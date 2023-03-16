Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 041896BD69E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Mar 2023 18:02:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbjCPRCu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Mar 2023 13:02:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbjCPRCt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Mar 2023 13:02:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20889E7EF4;
        Thu, 16 Mar 2023 10:02:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 92B11B8227B;
        Thu, 16 Mar 2023 17:02:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04ED5C433D2;
        Thu, 16 Mar 2023 17:02:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678986155;
        bh=GA8tXS4Mul2elWYsjsHoBsAbirrUGLhRxbF2Iayc8rg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZhtVj376qlPRWZ1voHqasur/pICqPh2D1iv3o8cqWfD6Tqwvn3vzB/NHNzr5q2zvc
         Du2DgVvnZu67X8HekIq3/BB471wLGP+xMh44yTpxdsA6MJ4i52t9Npw6fiUxKq79AZ
         BVAKBWemUcdBpEcTGD1w7L96mTMWWbvInC9HuwInR990nvhl2XzxnJL/fE2VLgeg3z
         M1me3mgk3ZFsAMmRYmy1tCPnFvQsZ8E0lS7EnHJoajef6uFHZoErIYZA4oTQ5C+GUn
         /zyUjx1ODsI4xjPqeOEyO5tNqStX53VCPmBS3mjJtL3+81scbzKF/Kf3q+8KkHUC9A
         CKaZl7dtXKDTg==
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
Subject: [PATCHv3 bpf-next 3/9] bpf: Use file object build id in stackmap
Date:   Thu, 16 Mar 2023 18:01:43 +0100
Message-Id: <20230316170149.4106586-4-jolsa@kernel.org>
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

Use build id from file object in stackmap if it's available.

The file's f_build_id is available (for CONFIG_FILE_BUILD_ID option)
when the file is mmap-ed, so it will be available (if present) when
used by stackmap.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/bpf/stackmap.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
index 0f1d8dced933..14d27bd83081 100644
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -124,6 +124,28 @@ static struct bpf_map *stack_map_alloc(union bpf_attr *attr)
 	return ERR_PTR(err);
 }
 
+#ifdef CONFIG_FILE_BUILD_ID
+static int vma_get_build_id(struct vm_area_struct *vma, unsigned char *build_id)
+{
+	struct build_id *bid;
+
+	if (!vma->vm_file)
+		return -EINVAL;
+	bid = vma->vm_file->f_build_id;
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

