Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 794006BD69A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Mar 2023 18:02:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230164AbjCPRCd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Mar 2023 13:02:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbjCPRCb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Mar 2023 13:02:31 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE568E6DA8;
        Thu, 16 Mar 2023 10:02:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7F41CB8227C;
        Thu, 16 Mar 2023 17:02:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A54DC433EF;
        Thu, 16 Mar 2023 17:02:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678986142;
        bh=wPkey4BWxoSwuVm0/JDcphsHh4pWF/uWOFmXxlWLkHg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SNv/7OPwD0I0s7lhX5kbFYwqOHQ6BEeVp42wO+mX9PwyPyOWc9aJP8tpSf8pTSmc7
         aJUi7ueFyPgrnzibcjii0GIA0zBfQ+oVxp0KrZ6owWC8EKweBWjgHUvuX4bvUsGb7K
         jRQt6UIxSQ6hmnmM4MFepJHDyU9d2by956YrhOlpGLKvW0kO976LhWUg9lFcytBy2I
         cOPXJzHAAG6XfhpiPaipKG4qKVWkQ9gVWf3V6V9dmCwMAjG+X0ldhsn8+xIPvtS/NU
         bs9dvCYweuoj4hon4v1BsbRdkf1cx44ZWcTyojzhvrOzQoSNM8qF+wi+IS6ht9pVT0
         jD7VHR0ypnIDw==
From:   Jiri Olsa <jolsa@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Hao Luo <haoluo@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Matthew Wilcox <willy@infradead.org>
Cc:     bpf@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Namhyung Kim <namhyung@gmail.com>,
        Dave Chinner <david@fromorbit.com>
Subject: [PATCHv3 bpf-next 2/9] perf: Use file object build id in perf_event_mmap_event
Date:   Thu, 16 Mar 2023 18:01:42 +0100
Message-Id: <20230316170149.4106586-3-jolsa@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230316170149.4106586-1-jolsa@kernel.org>
References: <20230316170149.4106586-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use build id from file object when available for perf's MMAP2 event
build id data.

The file's f_build_id is available (for CONFIG_FILE_BUILD_ID option)
when the file is mmap-ed and before the perf's callback is executed,
so we can use it, instead of reading it again.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/events/core.c | 43 +++++++++++++++++++++++++++++++++++++++----
 1 file changed, 39 insertions(+), 4 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index f79fd8b87f75..3a5398dda6f6 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -8527,6 +8527,9 @@ struct perf_mmap_event {
 	u32			prot, flags;
 	u8			build_id[BUILD_ID_SIZE_MAX];
 	u32			build_id_size;
+#ifdef CONFIG_FILE_BUILD_ID
+	struct build_id		*f_build_id;
+#endif
 
 	struct {
 		struct perf_event_header	header;
@@ -8539,6 +8542,38 @@ struct perf_mmap_event {
 	} event_id;
 };
 
+#ifdef CONFIG_FILE_BUILD_ID
+static void build_id_read(struct perf_mmap_event *mmap_event)
+{
+	struct vm_area_struct *vma = mmap_event->vma;
+
+	mmap_event->f_build_id = vma->vm_file ? vma->vm_file->f_build_id : NULL;
+}
+
+static bool has_build_id(struct perf_mmap_event *mmap_event)
+{
+	return !IS_ERR_OR_NULL(mmap_event->f_build_id);
+}
+
+#define build_id_data mmap_event->f_build_id->data
+#define build_id_size mmap_event->f_build_id->sz
+#else
+static void build_id_read(struct perf_mmap_event *mmap_event)
+{
+	struct vm_area_struct *vma = mmap_event->vma;
+
+	build_id_parse(vma, mmap_event->build_id, &mmap_event->build_id_size);
+}
+
+static bool has_build_id(struct perf_mmap_event *mmap_event)
+{
+	return mmap_event->build_id_size;
+}
+
+#define build_id_data mmap_event->build_id
+#define build_id_size mmap_event->build_id_size
+#endif
+
 static int perf_event_mmap_match(struct perf_event *event,
 				 void *data)
 {
@@ -8583,7 +8618,7 @@ static void perf_event_mmap_output(struct perf_event *event,
 	mmap_event->event_id.pid = perf_event_pid(event, current);
 	mmap_event->event_id.tid = perf_event_tid(event, current);
 
-	use_build_id = event->attr.build_id && mmap_event->build_id_size;
+	use_build_id = event->attr.build_id && has_build_id(mmap_event);
 
 	if (event->attr.mmap2 && use_build_id)
 		mmap_event->event_id.header.misc |= PERF_RECORD_MISC_MMAP_BUILD_ID;
@@ -8592,10 +8627,10 @@ static void perf_event_mmap_output(struct perf_event *event,
 
 	if (event->attr.mmap2) {
 		if (use_build_id) {
-			u8 size[4] = { (u8) mmap_event->build_id_size, 0, 0, 0 };
+			u8 size[4] = { (u8) build_id_size, 0, 0, 0 };
 
 			__output_copy(&handle, size, 4);
-			__output_copy(&handle, mmap_event->build_id, BUILD_ID_SIZE_MAX);
+			__output_copy(&handle, build_id_data, BUILD_ID_SIZE_MAX);
 		} else {
 			perf_output_put(&handle, mmap_event->maj);
 			perf_output_put(&handle, mmap_event->min);
@@ -8727,7 +8762,7 @@ static void perf_event_mmap_event(struct perf_mmap_event *mmap_event)
 	mmap_event->event_id.header.size = sizeof(mmap_event->event_id) + size;
 
 	if (atomic_read(&nr_build_id_events))
-		build_id_parse(vma, mmap_event->build_id, &mmap_event->build_id_size);
+		build_id_read(mmap_event);
 
 	perf_iterate_sb(perf_event_mmap_output,
 		       mmap_event,
-- 
2.39.2

