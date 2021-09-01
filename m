Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBAE93FE679
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Sep 2021 02:34:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244619AbhIAXoR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Sep 2021 19:44:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244344AbhIAXoP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Sep 2021 19:44:15 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23F52C061760
        for <linux-fsdevel@vger.kernel.org>; Wed,  1 Sep 2021 16:43:18 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id t1so45203pgv.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 Sep 2021 16:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SKq9FaM29beTFKHBuFsUutnwIAeKxNVhRiqi1gUUfqk=;
        b=PzmK/+NUhZxG8Z+YuxmTpJb9O380IFK7e1wlHLXqZCa1XFyxfVnhpezGuyhZ1kjAoF
         xxjSBwVxaM4uxKEzPeHweqkiVLEtiyo0Zt0xhddivh38U2sDftCITySNaIEc1dqIurxM
         0TWMp/bKIm8hlLJykPTkJVGON+3mdvfQ8/p84=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SKq9FaM29beTFKHBuFsUutnwIAeKxNVhRiqi1gUUfqk=;
        b=V3Pi2BmOhQg5ZOvAv4Hozf1BPn4JGy9TSUTWP5hHI/auuLplhut+VM7+mbDPGAgL+o
         V/yTqjGxEG205V2wDlaclG/A/4yzSQFjP43falaGV8oWvdwjhOIIsBi4kk4h+wRgtDHa
         PPnUNIubWHZr/lTkLmOTQO6UYsS9qL8sxT7Wxhnfa3JUHPJyVowDplo2KxYkvibOguKn
         KGRd9ucwVu3uS3OGIFBaWgwtAG/fcGDmKits403T6YtXhD0QDnPTux9nRvDjLma0m/MC
         lQIS3M03a0Wg4uZoDDyxDrvlgDgrsKknNMU0URK1NwvCBU0VHAU7go66LY5IMK60B2cs
         I28g==
X-Gm-Message-State: AOAM530pzXN88WvNWDq3rKOda6a1WtUaMNdt9jKEopHJX97/62OoNAJJ
        20ObLKmvT1jsyJGnX+ooxl/euA==
X-Google-Smtp-Source: ABdhPJyKvnT+zbVm+OyNSiV0tbk4E8w3SgYbGSl4SqDh2XVYSBz4FJsZZOYUbxtYJOwjDXefvJQ2VQ==
X-Received: by 2002:a05:6a00:230e:b029:3c4:24ff:969d with SMTP id h14-20020a056a00230eb02903c424ff969dmr380233pfh.44.1630539797625;
        Wed, 01 Sep 2021 16:43:17 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id n24sm37653pgv.60.2021.09.01.16.43.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Sep 2021 16:43:16 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Russell King <linux@armlinux.org.uk>,
        Michal Hocko <mhocko@suse.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Anthony Yznaga <anthony.yznaga@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH] binfmt_elf: Reintroduce using MAP_FIXED_NOREPLACE
Date:   Wed,  1 Sep 2021 16:43:14 -0700
Message-Id: <20210901234314.2624109-1-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4227; h=from:subject; bh=mwvE/gDRs6e5NxW4p+Kk0QNaEgjqTD4VySLc2KZdvDw=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhMBARowTodGVt/9YDPs4IjC58d4M0IDDsGnVkzR3B foKFAPqJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYTAQEQAKCRCJcvTf3G3AJluIEA Cd38ESBXKwortzq1h4eaJNKXI+JZlB8Ihl3WB4vg7A+ecCnsG2ZOz1BJAZhCsIHQ4wfKFylECGxLoO V2adQU117i+u6jhbZMMoL3hMRYQpPEe684WeiBrHhFRvt0epxz9T1SGWWYkyqEB9mnptqUbFI+VPQ1 wTMc++ZzZMufUt2AG17s+0gRSXiyznVoCZiZKtnvVOaAQy2XKjmrq7lEIxcp2UUxLlKzzWFZJuseby Fzln0RbCW3aKjqTTHwTv/8rt5ENbFwsOI3jf5J5rFqXhyYA2lzzlVvDYvcR/U8N2EOfExj9fKWgm/s I803h1/1F4j9/VNdZW+36lQMRsOKOuP88ogB+1+JxirbW0jaORfgWcZqhdkPNBDQ9IeheOrSb+rqWC d6cr12+FbjtuZ1RQqx1c0Ad0izk1d6tWVA2kWDNq0IGVqjeyl0H4oPz6uMwD4uifcM3QX6xEZCtJVJ PIL21XXJoCeg2wvt7hx6ni/hgKinu2/6/6UVCofRNtdwBEd2LRtp3cpz0Jx1qJFgFURztowHKjsj63 +OHMxAuVxTEznUewjivihW34ePYJeDtRQ6QbbPv0FgtwlJBoVfldEfKVHxnRHC8ZbRZL6y+XYeiXM2 31zO61UhfXd3LtZzgI7344SkvMkk3FG5+EYRMlJ+uLTk0mv0IF+Mk50hDPuw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Commit b212921b13bd ("elf: don't use MAP_FIXED_NOREPLACE for elf
executable mappings") reverted back to using MAP_FIXED to map ELF
LOAD segments because it was found that the segments in some binaries
overlap and can cause MAP_FIXED_NOREPLACE to fail. The original intent of
MAP_FIXED_NOREPLACE was to prevent the silent clobbering of an existing
mapping (e.g. stack) by the ELF image. To achieve this, expand on the
logic used when loading ET_DYN binaries which calculates a total size
for the image when the first segment is mapped, maps the entire image,
and then unmaps the remainder before remaining segments are mapped.
Apply this to ET_EXEC binaries as well as ET_DYN binaries as is done
now, and for both ET_EXEC and ET_DYN+INTERP use MAP_FIXED_NOREPLACE for
the initial total size mapping and MAP_FIXED for remaining mappings.
For ET_DYN w/out INTERP, continue to map at a system-selected address
in the mmap region.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Eric Biederman <ebiederm@xmission.com>
Co-developed-by: Anthony Yznaga <anthony.yznaga@oracle.com>
Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
Link: https://lore.kernel.org/lkml/1595869887-23307-2-git-send-email-anthony.yznaga@oracle.com
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/binfmt_elf.c | 31 ++++++++++++++++++++++---------
 1 file changed, 22 insertions(+), 9 deletions(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 439ed81e755a..ef00bf8bd6f4 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -1074,20 +1074,26 @@ static int load_elf_binary(struct linux_binprm *bprm)
 
 		vaddr = elf_ppnt->p_vaddr;
 		/*
-		 * If we are loading ET_EXEC or we have already performed
-		 * the ET_DYN load_addr calculations, proceed normally.
+		 * The first time through the loop, load_addr_set is false:
+		 * layout will be calculated. Once set, use MAP_FIXED since
+		 * we know we've already safely mapped the entire region with
+		 * MAP_FIXED_NOREPLACE in the once-per-binary logic following.
 		 */
-		if (elf_ex->e_type == ET_EXEC || load_addr_set) {
+		if (load_addr_set) {
 			elf_flags |= MAP_FIXED;
+		} else if (elf_ex->e_type == ET_EXEC) {
+			/*
+			 * This logic is run once for the first LOAD Program
+			 * Header for ET_EXEC binaries. No special handling
+			 * is needed.
+			 */
+			elf_flags |= MAP_FIXED_NOREPLACE;
 		} else if (elf_ex->e_type == ET_DYN) {
 			/*
 			 * This logic is run once for the first LOAD Program
 			 * Header for ET_DYN binaries to calculate the
 			 * randomization (load_bias) for all the LOAD
-			 * Program Headers, and to calculate the entire
-			 * size of the ELF mapping (total_size). (Note that
-			 * load_addr_set is set to true later once the
-			 * initial mapping is performed.)
+			 * Program Headers.
 			 *
 			 * There are effectively two types of ET_DYN
 			 * binaries: programs (i.e. PIE: ET_DYN with INTERP)
@@ -1108,7 +1114,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
 			 * Therefore, programs are loaded offset from
 			 * ELF_ET_DYN_BASE and loaders are loaded into the
 			 * independently randomized mmap region (0 load_bias
-			 * without MAP_FIXED).
+			 * without MAP_FIXED nor MAP_FIXED_NOREPLACE).
 			 */
 			if (interpreter) {
 				load_bias = ELF_ET_DYN_BASE;
@@ -1117,7 +1123,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
 				alignment = maximum_alignment(elf_phdata, elf_ex->e_phnum);
 				if (alignment)
 					load_bias &= ~(alignment - 1);
-				elf_flags |= MAP_FIXED;
+				elf_flags |= MAP_FIXED_NOREPLACE;
 			} else
 				load_bias = 0;
 
@@ -1129,7 +1135,14 @@ static int load_elf_binary(struct linux_binprm *bprm)
 			 * is then page aligned.
 			 */
 			load_bias = ELF_PAGESTART(load_bias - vaddr);
+		}
 
+		/*
+		 * Calculate the entire size of the ELF mapping (total_size).
+		 * (Note that load_addr_set is set to true later once the
+		 * initial mapping is performed.)
+		 */
+		if (!load_addr_set) {
 			total_size = total_mapping_size(elf_phdata,
 							elf_ex->e_phnum);
 			if (!total_size) {
-- 
2.30.2

