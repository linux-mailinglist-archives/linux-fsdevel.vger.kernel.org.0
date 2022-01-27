Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F9A249E2B3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jan 2022 13:42:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241304AbiA0MmV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Jan 2022 07:42:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241403AbiA0MmS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Jan 2022 07:42:18 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CB4AC061748;
        Thu, 27 Jan 2022 04:42:18 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id d15-20020a17090a110f00b001b4e7d27474so2826678pja.2;
        Thu, 27 Jan 2022 04:42:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=65lHAvgIrvaTDpQ8E/8HtbPHAXdF5rPPGyXj5G9Napk=;
        b=m5J49hSw3xUMpmLDf2fGSGxn0Q5aRF+lgicWZiT0ciapljFaf3uFyfr3KGlNMEzvMU
         6HoVCtvRqf/ZO9VNeQM33Giktu8Ps6mZ+LRhzrs1yraKtt+HdckINvUVNFf/LCcGF8V6
         YsvjpvUO/M/yek54njRaDuCT3kIPmEvS1uHqe5RNdkA3sW8au6yjnodbmd1gP1gAe6wS
         yMvdsjfdnHfg8tXckyudtjcLNKUjHJXWHo5mKRAJLD6HSCJ87Si3yGRmMIdve5e+wDOc
         oNd185layb+NCUlQhllLguOuaoLe51JQRXFcujR4pBxsf8Fbh09BESiSppD24VrsyPu8
         FIKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=65lHAvgIrvaTDpQ8E/8HtbPHAXdF5rPPGyXj5G9Napk=;
        b=E+eweg//mN8euUx4n7EXrPCbum2WgLIDp8LtywiT6TumlMXF4/9QWoUPg+bvwQodcr
         OzT8AgcFaW1LvBkeprDaUNgA5gi9ZFnqoXcpt7zXRqaviX5QBbJD5N6Igl2cnfl1pD9F
         epLUfWe7l1+tN1OcKRuvQ2mD2FhPMl9nz1vfUlvaz/Ak8pOALkqsgba66b1tDBP/XTTq
         HU+fFj80ejhvBVF6QDeMkksyNraEMlA4XopVG1sldGwhy1ZR+fFjTPxnF3wRTyGP0yBp
         9wOher9lMcBtXjcCowMa5nzL4qSh/swyOVeShdRbgG4cmypRZAQ3o1kXaFoM8WHN4Pcv
         ZqsA==
X-Gm-Message-State: AOAM531w3TcP53rqce+J3A0EBNvIYo84QfYEXKaTuYKvadd7P7jF6aJ1
        lSlSaewlD7zUqCAF9S0M2Y4=
X-Google-Smtp-Source: ABdhPJwTsY+xzKtPDG+leiEAflZIAbiOUmbhEMGb937hqpADqlAhicEQTyVFFRJGC6s3+v4DBGpGYA==
X-Received: by 2002:a17:902:9306:: with SMTP id bc6mr3266618plb.93.1643287337888;
        Thu, 27 Jan 2022 04:42:17 -0800 (PST)
Received: from localhost.localdomain ([2400:2410:93a3:bc00:d205:ec9:b1c6:b9ee])
        by smtp.gmail.com with ESMTPSA id m38sm19071298pgl.64.2022.01.27.04.42.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 04:42:17 -0800 (PST)
From:   Akira Kawata <akirakawata1@gmail.com>
To:     akpm@linux-foundation.org, adobriyan@gmail.com,
        viro@zeniv.linux.org.uk, keescook@chromium.org,
        linux-fsdevel@vger.kernel.org, lukas.bulwahn@gmail.com
Cc:     akirakawata1@gmail.com, Eric Biederman <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 2/2] fs/binfmt_elf: Refactor load_elf_binary function
Date:   Thu, 27 Jan 2022 21:40:17 +0900
Message-Id: <20220127124014.338760-3-akirakawata1@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220127124014.338760-1-akirakawata1@gmail.com>
References: <20220127124014.338760-1-akirakawata1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I delete load_addr because it is not used anymore. And I rename
load_addr_set to first_pt_load because it is used only to capture the
first iteration of the loop.

Signed-off-by: Akira Kawata <akirakawata1@gmail.com>
Acked-by: Kees Cook <keescook@chromium.org>
---
 fs/binfmt_elf.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index d120ab03795f..3218ebfde409 100644
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

