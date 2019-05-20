Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13C652399A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2019 16:13:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731383AbfETONi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 May 2019 10:13:38 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:47740 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730274AbfETONh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 May 2019 10:13:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
        Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
        In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=SF8ACNbk0ra61AmI8ZDPlvPIjPOeTkHD0HYILXQ5eoM=; b=Rccqb0MWZfAcgA0ShpIo9yv8HJ
        b7Mm91DTgJg/e2fAAcvRj7ip41dRNY9uAqcpoDLey3nrw0EuKqI+YOjiNyVO2KY2tlAKXmbLNmfy3
        KBdvy/ZGguDfeN+hjLpZ6CBdGTraCrzmc7Iqki9uvKb7lTLRBAFHdGjTVbfHc/VHBGCidu/Q3Cog+
        HZ+5JhfsDbZTpUHZv2M1qc4Z2ESpgYE30mi3P4ijWZAw1dmuhvqcqo6elGouVNCmDXKNGJedC53fZ
        lbmcDkmYFg8epwQsbyY29URzKY51qDS1oc04B7myl3xPF1/rWarH72gNbTJnZPvmJ4lfQgdEMGkGs
        Ai4lw9bA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:33172 helo=rmk-PC.armlinux.org.uk)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1hSj2k-0003BE-Se; Mon, 20 May 2019 15:13:34 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.82_1-5b7a7c0-XX)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1hSj2k-0000M6-B8; Mon, 20 May 2019 15:13:34 +0100
In-Reply-To: <20190520141227.krqowhs3yg7hpige@shell.armlinux.org.uk>
References: <20190520141227.krqowhs3yg7hpige@shell.armlinux.org.uk>
From:   Russell King <rmk+kernel@armlinux.org.uk>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH 7/7] fs/adfs: fix filename fixup handling for "/" and "//"
 names
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1hSj2k-0000M6-B8@rmk-PC.armlinux.org.uk>
Date:   Mon, 20 May 2019 15:13:34 +0100
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Avoid translating "/" and "//" directory entry names to the special
"." and ".." names by instead converting the first character to "^".

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 fs/adfs/dir.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/fs/adfs/dir.c b/fs/adfs/dir.c
index 51ed80ff10a5..fe39310c1a0a 100644
--- a/fs/adfs/dir.c
+++ b/fs/adfs/dir.c
@@ -18,18 +18,25 @@ static DEFINE_RWLOCK(adfs_dir_lock);
 
 void adfs_object_fixup(struct adfs_dir *dir, struct object_info *obj)
 {
-	unsigned int i;
+	unsigned int dots, i;
 
 	/*
 	 * RISC OS allows the use of '/' in directory entry names, so we need
 	 * to fix these up.  '/' is typically used for FAT compatibility to
 	 * represent '.', so do the same conversion here.  In any case, '.'
 	 * will never be in a RISC OS name since it is used as the pathname
-	 * separator.
+	 * separator.  Handle the case where we may generate a '.' or '..'
+	 * name, replacing the first character with '^' (the RISC OS "parent
+	 * directory" character.)
 	 */
-	for (i = 0; i < obj->name_len; i++)
-		if (obj->name[i] == '/')
+	for (i = dots = 0; i < obj->name_len; i++)
+		if (obj->name[i] == '/') {
 			obj->name[i] = '.';
+			dots++;
+		}
+
+	if (obj->name_len <= 2 && dots == obj->name_len)
+		obj->name[0] = '^';
 
 	obj->filetype = -1;
 
-- 
2.7.4

