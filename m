Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A12236867C5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Feb 2023 14:59:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232172AbjBAN67 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Feb 2023 08:58:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232158AbjBAN6s (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Feb 2023 08:58:48 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4752D1353A;
        Wed,  1 Feb 2023 05:58:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 33167B821A9;
        Wed,  1 Feb 2023 13:58:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 325E2C4339B;
        Wed,  1 Feb 2023 13:58:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675259901;
        bh=aLPnAbPHT8a02PSgEV9wcJJL8dIRbp5TcW8HLfo0WbA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rvH85aZNkyrEZQUXF6LXPZDUhDCIneD+wlLL8wRJAzoq7xdGsbZ4t9y4SSe7WIaYV
         ZsVEfIlDeihAbZRx2dqyt4yynUmxQ742B/1VsTqAN3o/+tb8MjpZujt1pnkTLeX9Is
         FpMyWfOOKcWUCpcAeCuz0mVsDgqyctFbWxB6UIGy7MexEJ1ExskMh4Sm6yQTli7XLu
         DBNcNlbqf9PNhhpjpP7jDzCBD8dT6rTWEbaPDJMy1b2Noh+HdZ23q0LBZ0wnUrzSg/
         y3F7rfav54xFq/3hGRpV/VFwWAnwAH2T2XgZDoyB/yvAcZuh5vrUqO2XiROuOwbTU9
         Uecjvuc+qafkA==
From:   Jiri Olsa <jolsa@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Hao Luo <haoluo@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     bpf@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH RFC 3/5] perf: Use file object build id in perf_event_mmap_event
Date:   Wed,  1 Feb 2023 14:57:35 +0100
Message-Id: <20230201135737.800527-4-jolsa@kernel.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230201135737.800527-1-jolsa@kernel.org>
References: <20230201135737.800527-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use build id from file object when available for perf's MMAP2
event build id data.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/events/core.c | 43 +++++++++++++++++++++++++++++++++++++++----
 1 file changed, 39 insertions(+), 4 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index d56328e5080e..44001fc7edb7 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -8508,6 +8508,9 @@ struct perf_mmap_event {
 	u32			prot, flags;
 	u8			build_id[BUILD_ID_SIZE_MAX];
 	u32			build_id_size;
+#ifdef CONFIG_FILE_BUILD_ID
+	struct build_id		*f_bid;
+#endif
 
 	struct {
 		struct perf_event_header	header;
@@ -8520,6 +8523,38 @@ struct perf_mmap_event {
 	} event_id;
 };
 
+#ifdef CONFIG_FILE_BUILD_ID
+static void build_id_read(struct perf_mmap_event *mmap_event)
+{
+	struct vm_area_struct *vma = mmap_event->vma;
+
+	mmap_event->f_bid = vma->vm_file ? vma->vm_file->f_bid : NULL;
+}
+
+static bool has_build_id(struct perf_mmap_event *mmap_event)
+{
+	return mmap_event->f_bid;
+}
+
+#define build_id_data mmap_event->f_bid->data
+#define build_id_size mmap_event->f_bid->sz
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
@@ -8564,7 +8599,7 @@ static void perf_event_mmap_output(struct perf_event *event,
 	mmap_event->event_id.pid = perf_event_pid(event, current);
 	mmap_event->event_id.tid = perf_event_tid(event, current);
 
-	use_build_id = event->attr.build_id && mmap_event->build_id_size;
+	use_build_id = event->attr.build_id && has_build_id(mmap_event);
 
 	if (event->attr.mmap2 && use_build_id)
 		mmap_event->event_id.header.misc |= PERF_RECORD_MISC_MMAP_BUILD_ID;
@@ -8573,10 +8608,10 @@ static void perf_event_mmap_output(struct perf_event *event,
 
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
@@ -8708,7 +8743,7 @@ static void perf_event_mmap_event(struct perf_mmap_event *mmap_event)
 	mmap_event->event_id.header.size = sizeof(mmap_event->event_id) + size;
 
 	if (atomic_read(&nr_build_id_events))
-		build_id_parse(vma, mmap_event->build_id, &mmap_event->build_id_size);
+		build_id_read(mmap_event);
 
 	perf_iterate_sb(perf_event_mmap_output,
 		       mmap_event,
-- 
2.39.1

