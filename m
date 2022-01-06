Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6D7A486DBF
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jan 2022 00:26:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245535AbiAFX0G (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Jan 2022 18:26:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245568AbiAFX0B (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jan 2022 18:26:01 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DB94C0611FD;
        Thu,  6 Jan 2022 15:26:01 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id v11so3756045pfu.2;
        Thu, 06 Jan 2022 15:26:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YMrJVY+JiLwYXB7dJ9LWCcuUUtmuetN3onx/+nxsDCc=;
        b=IVs1AD/IgQVkc2A10fm+jmdrb1k5hgdiGzycUnpLTAmbrb1jVOZCbgA1MRbFBBoxwr
         GzoZNTJh9pTzOgI7pWQoR8blc1rhUOpDicv4vwIjHF8Eu7W8NPyns8Riznc7TdPUUZ9c
         tVcg56T0F98D8f1GWslFLou+CoBYnNdnX0gohzDrz5JUQ1FVX37r81C7He7MmrYltDzH
         S6X4anoow+6AU+TZbt5gvdOJDrBvfMaTrOhDzQCnVBfq/ua8KTkItkRTPrQfodCHTKHu
         9+TPITjyWy2MQ9QicOgDn8LXM9CNr5I3IAs6KKB3ZwfIPufE3UOpeCqo6uislhqfbdXW
         wIWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YMrJVY+JiLwYXB7dJ9LWCcuUUtmuetN3onx/+nxsDCc=;
        b=xBvYdqs5yE91hmEkYz1GN5Udv6lkq/mgW1JE8iKwIi6Akq+y2jkx2hr3yKla8XXOQs
         IK9XbL5NZHZzD5XQobcPbgWrJoEvaZKJZVLFP7r9iiyQuoRKMtmD8FkXWRBtBT53OJHV
         jRTVI4iatkhRWg+2/Qz2h1rbI3OueC3SHgJbU2fbUFwtM/hUBuefz9viQD6ERIM4413T
         nyj80Rb4hWe0dmNMVEmyHS/isxcYiPlD/rETawP7rLFpwemsPauX2wQru1F2FRgQkW0M
         sI7vwQVPviChhmBdVi8ivhCNLwY7VAHxWZG0MtmjjCX0cmvzP3zj1aZdt04Q6IxvHxFI
         vFIw==
X-Gm-Message-State: AOAM531Pe6E4b6+GCilvvhVaOEJAbxumo3IBaq9kg0xIMNbNl/ns+N+o
        G1eVxeQE731A0GBSHZcNCPE=
X-Google-Smtp-Source: ABdhPJxGHfbTtKRwAwJlZcc+6oM4ko44yV0uEpvhyzUduZfp5eHXf3nWJb9qTur2jEiu2IGmXAtesQ==
X-Received: by 2002:a63:6ece:: with SMTP id j197mr46697247pgc.322.1641511561093;
        Thu, 06 Jan 2022 15:26:01 -0800 (PST)
Received: from goshun.usen.ad.jp (113x33x71x97.ap113.ftth.ucom.ne.jp. [113.33.71.97])
        by smtp.gmail.com with ESMTPSA id r13sm2937078pga.29.2022.01.06.15.25.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 15:26:00 -0800 (PST)
From:   Akira Kawata <akirakawata1@gmail.com>
To:     akpm@linux-foundation.org, adobriyan@gmail.com,
        viro@zeniv.linux.org.uk, keescook@chromium.org,
        linux-fsdevel@vger.kernel.org, lukas.bulwahn@gmail.com
Cc:     akirakawata1@gmail.com, Eric Biederman <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 RESEND 2/2] fs/binfmt_elf: Refactor load_elf_binary function
Date:   Fri,  7 Jan 2022 08:25:13 +0900
Message-Id: <20220106232513.143014-3-akirakawata1@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220106232513.143014-1-akirakawata1@gmail.com>
References: <20220106232513.143014-1-akirakawata1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I delete load_addr because it is not used anymore. And I rename
load_addr_set to first_pt_load because it is used only to capture the
first iteration of the loop.

Signed-off-by: Akira Kawata <akirakawata1@gmail.com>
---
 fs/binfmt_elf.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 828e88841cb4..48206fd1a20e 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -822,8 +822,8 @@ static int parse_elf_properties(struct file *f, const struct elf_phdr *phdr,
 static int load_elf_binary(struct linux_binprm *bprm)
 {
 	struct file *interpreter = NULL; /* to shut gcc up */
-	unsigned long load_addr, load_bias = 0, phdr_addr = 0;
-	int load_addr_set = 0;
+	unsigned long load_bias = 0, phdr_addr = 0;
+	int first_pt_load = 1;
 	unsigned long error;
 	struct elf_phdr *elf_ppnt, *elf_phdata, *interp_elf_phdata = NULL;
 	struct elf_phdr *elf_property_phdata = NULL;
@@ -1073,12 +1073,12 @@ static int load_elf_binary(struct linux_binprm *bprm)
 
 		vaddr = elf_ppnt->p_vaddr;
 		/*
-		 * The first time through the loop, load_addr_set is false:
+		 * The first time through the loop, first_pt_load is true:
 		 * layout will be calculated. Once set, use MAP_FIXED since
 		 * we know we've already safely mapped the entire region with
 		 * MAP_FIXED_NOREPLACE in the once-per-binary logic following.
 		 */
-		if (load_addr_set) {
+		if (!first_pt_load) {
 			elf_flags |= MAP_FIXED;
 		} else if (elf_ex->e_type == ET_EXEC) {
 			/*
@@ -1138,10 +1138,10 @@ static int load_elf_binary(struct linux_binprm *bprm)
 
 		/*
 		 * Calculate the entire size of the ELF mapping (total_size).
-		 * (Note that load_addr_set is set to true later once the
+		 * (Note that first_pt_load is set to false later once the
 		 * initial mapping is performed.)
 		 */
-		if (!load_addr_set) {
+		if (first_pt_load) {
 			total_size = total_mapping_size(elf_phdata,
 							elf_ex->e_phnum);
 			if (!total_size) {
@@ -1158,13 +1158,11 @@ static int load_elf_binary(struct linux_binprm *bprm)
 			goto out_free_dentry;
 		}
 
-		if (!load_addr_set) {
-			load_addr_set = 1;
-			load_addr = (elf_ppnt->p_vaddr - elf_ppnt->p_offset);
+		if (first_pt_load) {
+			first_pt_load = 0;
 			if (elf_ex->e_type == ET_DYN) {
 				load_bias += error -
 				             ELF_PAGESTART(load_bias + vaddr);
-				load_addr += load_bias;
 				reloc_func_desc = load_bias;
 			}
 		}
-- 
2.25.1

