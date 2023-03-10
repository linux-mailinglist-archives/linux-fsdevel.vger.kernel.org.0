Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 417926B52D5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Mar 2023 22:28:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231842AbjCJV16 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Mar 2023 16:27:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231737AbjCJV1w (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Mar 2023 16:27:52 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E47428F72D;
        Fri, 10 Mar 2023 13:27:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=MjWtbXIr3ZIOZlsm6oE+PQ2DYSkc5668Tc5HBu81c+E=; b=ZS6gePohdN9NDNj+GqtoEZXeu2
        icKOCAnRc6Jidl47vAtcOut12gfhOgQzcad3d/W25+Daotc5SiZ6zn+Jfh/sPzisq4eZbnFfvxbgU
        YhEvQI8v0+50EidpP6eKjjiwPZbfYfFDDDgZzMs9BYzv3gEnG2f6fb1oyZwwdAFExdy7I/EzgyC1z
        9pXtbQ+sekY5EaAgjRA82ytNNTIV4fCHDWYcUVcadP0+NaowKoQwBMRJexzhzXAUXkmi3KAeMA39d
        hjLOUS4vjV1gUEeU6XZXs7VFaf+4UM78PAUQ99gKJhD9FtXvCck0cvFLpiPO7Bi5NnCCjjAMa3pt0
        kKnsn57A==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pakHF-00FR68-1V;
        Fri, 10 Mar 2023 21:27:49 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 3/8] SVM-SEV: convert the rest of fget() uses to fdget() in there
Date:   Fri, 10 Mar 2023 21:27:43 +0000
Message-Id: <20230310212748.3679076-3-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230310212748.3679076-1-viro@zeniv.linux.org.uk>
References: <20230310212536.GX3390869@ZenIV>
 <20230310212748.3679076-1-viro@zeniv.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/x86/kvm/svm/sev.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index c25aeb550cd9..52398d49bc2f 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -1767,18 +1767,20 @@ int sev_vm_move_enc_context_from(struct kvm *kvm, unsigned int source_fd)
 {
 	struct kvm_sev_info *dst_sev = &to_kvm_svm(kvm)->sev_info;
 	struct kvm_sev_info *src_sev, *cg_cleanup_sev;
-	struct file *source_kvm_file;
+	struct fd f = fdget(source_fd);
 	struct kvm *source_kvm;
 	bool charged = false;
 	int ret;
 
-	source_kvm_file = fget(source_fd);
-	if (!file_is_kvm(source_kvm_file)) {
+	if (!f.file)
+		return -EBADF;
+
+	if (!file_is_kvm(f.file)) {
 		ret = -EBADF;
 		goto out_fput;
 	}
 
-	source_kvm = source_kvm_file->private_data;
+	source_kvm = f.file->private_data;
 	ret = sev_lock_two_vms(kvm, source_kvm);
 	if (ret)
 		goto out_fput;
@@ -1828,8 +1830,7 @@ int sev_vm_move_enc_context_from(struct kvm *kvm, unsigned int source_fd)
 out_unlock:
 	sev_unlock_two_vms(kvm, source_kvm);
 out_fput:
-	if (source_kvm_file)
-		fput(source_kvm_file);
+	fdput(f);
 	return ret;
 }
 
@@ -2046,18 +2047,20 @@ int sev_mem_enc_unregister_region(struct kvm *kvm,
 
 int sev_vm_copy_enc_context_from(struct kvm *kvm, unsigned int source_fd)
 {
-	struct file *source_kvm_file;
+	struct fd f = fdget(source_fd);
 	struct kvm *source_kvm;
 	struct kvm_sev_info *source_sev, *mirror_sev;
 	int ret;
 
-	source_kvm_file = fget(source_fd);
-	if (!file_is_kvm(source_kvm_file)) {
+	if (!f.file)
+		return -EBADF;
+
+	if (!file_is_kvm(f.file)) {
 		ret = -EBADF;
 		goto e_source_fput;
 	}
 
-	source_kvm = source_kvm_file->private_data;
+	source_kvm = f.file->private_data;
 	ret = sev_lock_two_vms(kvm, source_kvm);
 	if (ret)
 		goto e_source_fput;
@@ -2103,8 +2106,7 @@ int sev_vm_copy_enc_context_from(struct kvm *kvm, unsigned int source_fd)
 e_unlock:
 	sev_unlock_two_vms(kvm, source_kvm);
 e_source_fput:
-	if (source_kvm_file)
-		fput(source_kvm_file);
+	fdput(f);
 	return ret;
 }
 
-- 
2.30.2

