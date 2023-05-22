Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 702F270CF0F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 May 2023 02:24:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbjEWAYp convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 May 2023 20:24:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235181AbjEVXaH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 May 2023 19:30:07 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E49BE52
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 May 2023 16:29:31 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34MMkxIj019125
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 May 2023 16:29:30 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3qpur5ydyj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 May 2023 16:29:30 -0700
Received: from twshared1631.42.prn1.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:21d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 22 May 2023 16:29:29 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 1E396312BC06F; Mon, 22 May 2023 16:29:21 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC:     <cyphar@cyphar.com>, <brauner@kernel.org>,
        <lennart@poettering.net>, <linux-fsdevel@vger.kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH v3 bpf-next 1/4] bpf: validate BPF object in BPF_OBJ_PIN before calling LSM
Date:   Mon, 22 May 2023 16:29:14 -0700
Message-ID: <20230522232917.2454595-2-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230522232917.2454595-1-andrii@kernel.org>
References: <20230522232917.2454595-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 9jQV-LL24upW9x6iZv5lbMLTWhKCulzy
X-Proofpoint-ORIG-GUID: 9jQV-LL24upW9x6iZv5lbMLTWhKCulzy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-22_17,2023-05-22_03,2023-05-22_02
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Do a sanity check whether provided file-to-be-pinned is actually a BPF
object (prog, map, btf) before calling security_path_mknod LSM hook. If
it's not, LSM hook doesn't have to be triggered, as the operation has no
chance of succeeding anyways.

Suggested-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/inode.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/kernel/bpf/inode.c b/kernel/bpf/inode.c
index 9948b542a470..329f27d5cacf 100644
--- a/kernel/bpf/inode.c
+++ b/kernel/bpf/inode.c
@@ -448,18 +448,17 @@ static int bpf_obj_do_pin(const char __user *pathname, void *raw,
 	if (IS_ERR(dentry))
 		return PTR_ERR(dentry);
 
-	mode = S_IFREG | ((S_IRUSR | S_IWUSR) & ~current_umask());
-
-	ret = security_path_mknod(&path, dentry, mode, 0);
-	if (ret)
-		goto out;
-
 	dir = d_inode(path.dentry);
 	if (dir->i_op != &bpf_dir_iops) {
 		ret = -EPERM;
 		goto out;
 	}
 
+	mode = S_IFREG | ((S_IRUSR | S_IWUSR) & ~current_umask());
+	ret = security_path_mknod(&path, dentry, mode, 0);
+	if (ret)
+		goto out;
+
 	switch (type) {
 	case BPF_TYPE_PROG:
 		ret = vfs_mkobj(dentry, mode, bpf_mkprog, raw);
-- 
2.34.1

