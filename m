Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED15A597BD1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Aug 2022 05:00:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242767AbiHRC6V (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Aug 2022 22:58:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242690AbiHRC6T (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Aug 2022 22:58:19 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6205CE16;
        Wed, 17 Aug 2022 19:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=UmMaki5Hhl1wi+eFZfWuavkqEBkBswlN79+IhR2ejDM=; b=poOwA4KxRlQba1sGycIsPSb/re
        KEhm5z0NxN2d28v0n/+BY4PiqbMDuovmooeHmzuQnXpWpCevw4KUs+KbHdViXfcubwh+6lZf0Chhe
        RcFTowVbmqPKjBemjVhzJJRoOcWpZ27Dr5nLPcvDW8JD51yH5xjMweIX9MfWjKBX8+0gyxl9/L04x
        1QQDg4XGbSCsAWjhTwDSKapDwLhPCyGsJYJN5kTHRswbD1PEogoRgYcj86tBdF57woETFAKOt18eD
        HB2LrJ3FJ/jTatZe13rzJrAHARSRERmeUqs2gwgbLeCnKRYw/ujRW37+itsCHBth4RmI1QbFo7CeB
        kybeQxhw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1oOVjd-005aZ6-8Z;
        Thu, 18 Aug 2022 02:58:17 +0000
Date:   Thu, 18 Aug 2022 03:58:17 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] ksmbd: don't open-code file_path()
Message-ID: <Yv2qyayq+Jo/+Uvs@ZenIV>
References: <Yv2qoNQg48rtymGE@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yv2qoNQg48rtymGE@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/ksmbd/smb2pdu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index 9751cc92c111..0e1924a6476d 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -5416,7 +5416,7 @@ static int smb2_rename(struct ksmbd_work *work,
 	if (!pathname)
 		return -ENOMEM;
 
-	abs_oldname = d_path(&fp->filp->f_path, pathname, PATH_MAX);
+	abs_oldname = file_path(fp->filp, pathname, PATH_MAX);
 	if (IS_ERR(abs_oldname)) {
 		rc = -EINVAL;
 		goto out;
@@ -5551,7 +5551,7 @@ static int smb2_create_link(struct ksmbd_work *work,
 	}
 
 	ksmbd_debug(SMB, "link name is %s\n", link_name);
-	target_name = d_path(&filp->f_path, pathname, PATH_MAX);
+	target_name = file_path(filp, pathname, PATH_MAX);
 	if (IS_ERR(target_name)) {
 		rc = -EINVAL;
 		goto out;
-- 
2.30.2

