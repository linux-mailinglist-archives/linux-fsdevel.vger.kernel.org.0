Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B5236B52D2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Mar 2023 22:27:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231803AbjCJV1y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Mar 2023 16:27:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231614AbjCJV1v (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Mar 2023 16:27:51 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4BFC88887;
        Fri, 10 Mar 2023 13:27:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=ctty4fDrrZNyrt5HheuQAuhXiak1NZsitsCG8hvMT5s=; b=WKAfe1wHQgcQC2tZVCtG8KUPDu
        AoQ6u6dXx7h2Z+Yw7+IqIIpQi7VVv1mzIiegb++2rWiKX4pDnf4IQC4RUl1Gf2HYuW1IXET/0eOP6
        drJXWGyWxwxEj2Dn6KZc+AeIM/HcsVN02qEDyuFD0DafXNT/cy9smVUeOg7+rUQDCGf/g9bisDyxw
        x48pMYb+MBmqG/sxjavWK07CVbHDYAYw/724gJ2pf7XQreW9GI2B56vtMuIhImURtBiKm5oMTqji6
        NISEEk12Nzgh2ZbtkoHplZ0DTDKoLP9OZ4PLNvhS8O/4r741CcPAkzkkOITdXDQVg+VxV5b7ViGn8
        Ugxz4KVA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pakHF-00FR65-0e;
        Fri, 10 Mar 2023 21:27:49 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 2/8] convert sgx_set_attribute() to fdget()/fdput()
Date:   Fri, 10 Mar 2023 21:27:42 +0000
Message-Id: <20230310212748.3679076-2-viro@zeniv.linux.org.uk>
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
 arch/x86/kernel/cpu/sgx/main.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
index e5a37b6e9aa5..166692f2d501 100644
--- a/arch/x86/kernel/cpu/sgx/main.c
+++ b/arch/x86/kernel/cpu/sgx/main.c
@@ -892,20 +892,19 @@ static struct miscdevice sgx_dev_provision = {
 int sgx_set_attribute(unsigned long *allowed_attributes,
 		      unsigned int attribute_fd)
 {
-	struct file *file;
+	struct fd f = fdget(attribute_fd);
 
-	file = fget(attribute_fd);
-	if (!file)
+	if (!f.file)
 		return -EINVAL;
 
-	if (file->f_op != &sgx_provision_fops) {
-		fput(file);
+	if (f.file->f_op != &sgx_provision_fops) {
+		fdput(f);
 		return -EINVAL;
 	}
 
 	*allowed_attributes |= SGX_ATTR_PROVISIONKEY;
 
-	fput(file);
+	fdput(f);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(sgx_set_attribute);
-- 
2.30.2

