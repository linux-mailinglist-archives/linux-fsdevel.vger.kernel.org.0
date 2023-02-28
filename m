Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 506B86A55D5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Feb 2023 10:32:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbjB1Jcp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Feb 2023 04:32:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231331AbjB1Jcl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Feb 2023 04:32:41 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 625D5211F6;
        Tue, 28 Feb 2023 01:32:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F386860FFC;
        Tue, 28 Feb 2023 09:32:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 532EFC4339C;
        Tue, 28 Feb 2023 09:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677576759;
        bh=KVeSwjr1MM70r3HIU41SsfKM/mZY7sGzW/FlWf73V/s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HBaS3gT21KO0nsyCT8FwE/BIVPSrUUAxD9WbcMeJSMhx+MPsx2OXhehXjktvVQ9SF
         kgJTVUP2drmveFEQk744dTA34D7L/FR0tCswjY48qD3gZLezBwpxEZdaAKZUfEV9E8
         puKhKdldF5sCccw/H2cmBkC1DcvkyZ0EPz3U9fIMjXlUn7pqlNJ4oKgcBkNiYoOlta
         cVp0OrKcyhSKGCigtDHHEBTfcJIn3NdplKyAHXX+250Ogh4BZ5UuwAz7T0/68WfyFW
         ib8w3H4K5cOCX3dNnQvhTkO039M+djRYVP/majEBXvugWcRXiA6lq1snRVqbeG+RoZ
         mhHeZuGdkPo5w==
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
        Namhyung Kim <namhyung@gmail.com>
Subject: [PATCH RFC v2 bpf-next 2/9] bpf: Use file's inode object build id in stackmap
Date:   Tue, 28 Feb 2023 10:31:59 +0100
Message-Id: <20230228093206.821563-3-jolsa@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230228093206.821563-1-jolsa@kernel.org>
References: <20230228093206.821563-1-jolsa@kernel.org>
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

Use build id from file's inode object in stackmap if it's available.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/bpf/stackmap.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
index aecea7451b61..9b9578e0cada 100644
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -124,6 +124,28 @@ static struct bpf_map *stack_map_alloc(union bpf_attr *attr)
 	return ERR_PTR(err);
 }
 
+#ifdef CONFIG_INODE_BUILD_ID
+static int vma_get_build_id(struct vm_area_struct *vma, unsigned char *build_id)
+{
+	struct build_id *bid;
+
+	if (!vma->vm_file)
+		return -EINVAL;
+	bid = file_inode(vma->vm_file)->i_build_id;
+	if (IS_ERR_OR_NULL(bid))
+		return bid ? PTR_ERR(bid) : -ENOENT;
+	if (bid->sz > BUILD_ID_SIZE_MAX)
+		return -EINVAL;
+	memcpy(build_id, bid->data, bid->sz);
+	return 0;
+}
+#else
+static int vma_get_build_id(struct vm_area_struct *vma, unsigned char *build_id)
+{
+	return build_id_parse(vma, build_id, NULL);
+}
+#endif
+
 static void stack_map_get_build_id_offset(struct bpf_stack_build_id *id_offs,
 					  u64 *ips, u32 trace_nr, bool user)
 {
@@ -156,7 +178,7 @@ static void stack_map_get_build_id_offset(struct bpf_stack_build_id *id_offs,
 			goto build_id_valid;
 		}
 		vma = find_vma(current->mm, ips[i]);
-		if (!vma || build_id_parse(vma, id_offs[i].build_id, NULL)) {
+		if (!vma || vma_get_build_id(vma, id_offs[i].build_id)) {
 			/* per entry fall back to ips */
 			id_offs[i].status = BPF_STACK_BUILD_ID_IP;
 			id_offs[i].ip = ips[i];
-- 
2.39.2

