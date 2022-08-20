Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41F4159B050
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Aug 2022 22:19:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233727AbiHTUQI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 20 Aug 2022 16:16:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbiHTUQH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 20 Aug 2022 16:16:07 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75DD030570
        for <linux-fsdevel@vger.kernel.org>; Sat, 20 Aug 2022 13:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=P50G2fbuAyKc/xqCikkqSBXoqQc16Qc7bJ7pCizTavk=; b=DUjRN2yq/Pt4f9M+EI4eeeJsBK
        eOJrTr62bJ6emHN8ij3oC3g8l6rBOKyGIv/37r6Pq50XtrXmYDByEMNYsVksT+2FkYr6NEVkPRf7P
        uIM1koTUilpXKsMrd0yv9BqaKzpOz+37k32o5cGpsjkW+IPWjJwAc1cdiqCbwT0qQgKf1W5hoJYl/
        +cX1XTmqHxdghGqZ7kMLwo54HIjehHuLGGHkFwZfqi1pphAIApBKoRvYp2H/a4XrIfmWnM+7RUbXX
        6reHVfuM1LzOe6jLGk0vDG/UgvKdrztekaBTYivESklep+dT92SX0tBWfpDOfxVJ2gq4GxwJsZ8I9
        rT/LH4Uw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1oPUsz-006T8O-TB;
        Sat, 20 Aug 2022 20:16:02 +0000
Date:   Sat, 20 Aug 2022 21:16:01 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     Jarkko Sakkinen <jarkko@kernel.org>
Subject: [PATCH 3/8] sgx: use ->f_mapping...
Message-ID: <YwFBAdENeoM+CSTT@ZenIV>
References: <YwFANLruaQpqmPKv@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YwFANLruaQpqmPKv@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/x86/kernel/cpu/sgx/encl.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/sgx/encl.c b/arch/x86/kernel/cpu/sgx/encl.c
index 24c1bb8eb196..6de17468ca16 100644
--- a/arch/x86/kernel/cpu/sgx/encl.c
+++ b/arch/x86/kernel/cpu/sgx/encl.c
@@ -906,8 +906,7 @@ const cpumask_t *sgx_encl_cpumask(struct sgx_encl *encl)
 static struct page *sgx_encl_get_backing_page(struct sgx_encl *encl,
 					      pgoff_t index)
 {
-	struct inode *inode = encl->backing->f_path.dentry->d_inode;
-	struct address_space *mapping = inode->i_mapping;
+	struct address_space *mapping = encl->backing->f_mapping;
 	gfp_t gfpmask = mapping_gfp_mask(mapping);
 
 	return shmem_read_mapping_page_gfp(mapping, index, gfpmask);
-- 
2.30.2

