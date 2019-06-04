Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A39834962
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2019 15:50:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727577AbfFDNuN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Jun 2019 09:50:13 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:40276 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727574AbfFDNuN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Jun 2019 09:50:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
        Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
        In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=x43B53q2OtaiqpXtjoXdJMZMqXaw6WoUcm7PnM4a3EA=; b=uq4rCcUrnrp8W9Oy1wO9kdNHnm
        cr3stMVFrim/Dti43PpCW3Wn6xyUxEcvruuM7HrA7Xwn/+ulk8LqxEk0UVKsXagN3bInx+UrB+b2G
        ajbC1x2THmcOpo8kopINl+eIvyLf1cJlgHzzBkwzgP4yj9XhKrrBdM+rMS726juI+GT2UpA/AFA6X
        nlGT6Ms2W9IFPoMGrftHxTMIE25tsOq3BTy1igegTqTCJDpz2cJ/tiJjILuC6kyvNgCVSwe2l9+eS
        fa2GzOfY3nG95CoVwZUEm3GdIcU1DvY82kkFgXcHJf4eYQsdcERbltQFvBb29sZt3nARuVtpjmedY
        VXCrQJXg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([2002:4e20:1eda:1:222:68ff:fe15:37dd]:34320 helo=rmk-PC.armlinux.org.uk)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1hY9pJ-0001bz-SN; Tue, 04 Jun 2019 14:50:09 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.82_1-5b7a7c0-XX)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1hY9pJ-00085K-4v; Tue, 04 Jun 2019 14:50:09 +0100
In-Reply-To: <20190604111943.GA15281@rmk-PC.armlinux.org.uk>
References: <20190604111943.GA15281@rmk-PC.armlinux.org.uk>
From:   Russell King <rmk+kernel@armlinux.org.uk>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH 09/12] fs/adfs: super: safely update options on remount
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1hY9pJ-00085K-4v@rmk-PC.armlinux.org.uk>
Date:   Tue, 04 Jun 2019 14:50:09 +0100
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Only update the options on remount if we successfully parse all options,
rather than updating those we've managed to parse.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 fs/adfs/super.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/fs/adfs/super.c b/fs/adfs/super.c
index 1e6afc324f61..c17ece0a3b61 100644
--- a/fs/adfs/super.c
+++ b/fs/adfs/super.c
@@ -170,10 +170,10 @@ static const match_table_t tokens = {
 	{Opt_err, NULL}
 };
 
-static int parse_options(struct super_block *sb, char *options)
+static int parse_options(struct super_block *sb, struct adfs_sb_info *asb,
+			 char *options)
 {
 	char *p;
-	struct adfs_sb_info *asb = ADFS_SB(sb);
 	int option;
 
 	if (!options)
@@ -228,9 +228,18 @@ static int parse_options(struct super_block *sb, char *options)
 
 static int adfs_remount(struct super_block *sb, int *flags, char *data)
 {
+	struct adfs_sb_info temp_asb;
+	int ret;
+
 	sync_filesystem(sb);
 	*flags |= ADFS_SB_FLAGS;
-	return parse_options(sb, data);
+
+	temp_asb = *ADFS_SB(sb);
+	ret = parse_options(sb, &temp_asb, data);
+	if (ret == 0)
+		*ADFS_SB(sb) = temp_asb;
+
+	return ret;
 }
 
 static int adfs_statfs(struct dentry *dentry, struct kstatfs *buf)
@@ -393,7 +402,7 @@ static int adfs_fill_super(struct super_block *sb, void *data, int silent)
 	asb->s_other_mask = ADFS_DEFAULT_OTHER_MASK;
 	asb->s_ftsuffix = 0;
 
-	if (parse_options(sb, data))
+	if (parse_options(sb, asb, data))
 		goto error;
 
 	sb_set_blocksize(sb, BLOCK_SIZE);
-- 
2.7.4

