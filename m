Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37D2223998
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2019 16:13:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387401AbfETON1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 May 2019 10:13:27 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:47726 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387402AbfETON1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 May 2019 10:13:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
        Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
        In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=gJXPBII9CuEVPVD0ou4DkPEePVn7qxAClxyxaIHwuuk=; b=Ewi/jeBhxGb2FJb7AxLjotUXaF
        FxXhhvYF8Jdgnd9Nb0ajAg3UvzK6SIzJDAm+F76HhwJslF1zr+fwpJpOJcDfcsTsZA+HFchKjGE28
        W3cc/uVN1K1o29szJn4N3jx0+bWk5Xj7uQUwTGULXqN0mSsbuLp9EMjGipTkrwCbrE2P0cqD+XDY+
        c8QJVS1XqtO0umwko5sIcXAiag1iOaMbd7tH34qNTzzPQdvxBTwwbq3+jb3PJ+cLGvBCu6j2cGBe8
        7Lx6yJtgh5I3utoPo05uc+KCSW7HNvKBYQkYFxCzlSEUHVtcFwZoiy52/C5Su2jo1xgcNJpHnCcLK
        92XjGdrA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:33166 helo=rmk-PC.armlinux.org.uk)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1hSj2a-0003B0-MO; Mon, 20 May 2019 15:13:24 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.82_1-5b7a7c0-XX)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1hSj2a-0000Ll-30; Mon, 20 May 2019 15:13:24 +0100
In-Reply-To: <20190520141227.krqowhs3yg7hpige@shell.armlinux.org.uk>
References: <20190520141227.krqowhs3yg7hpige@shell.armlinux.org.uk>
From:   Russell King <rmk+kernel@armlinux.org.uk>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH 5/7] fs/adfs: remove truncated filename hashing
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1hSj2a-0000Ll-30@rmk-PC.armlinux.org.uk>
Date:   Mon, 20 May 2019 15:13:24 +0100
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

fs/adfs support for truncated filenames is broken, and there is a desire
not to support this into the future.  Let's remove the fs/adfs support
for this.

Viro says:

"FWIW, the word from Linus had been basically "kill it off" on
truncation."

That being:

"Make it so. Make the rule be that d_hash() can only change the hash
itself, rather than the subtle special case for len that we had
because of legacy reasons.."

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 fs/adfs/dir.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/fs/adfs/dir.c b/fs/adfs/dir.c
index 877d5cffe9e9..5d88108339df 100644
--- a/fs/adfs/dir.c
+++ b/fs/adfs/dir.c
@@ -214,22 +214,17 @@ const struct file_operations adfs_dir_operations = {
 static int
 adfs_hash(const struct dentry *parent, struct qstr *qstr)
 {
-	const unsigned int name_len = ADFS_SB(parent->d_sb)->s_namelen;
 	const unsigned char *name;
 	unsigned long hash;
-	int i;
+	u32 len;
 
-	if (qstr->len < name_len)
-		return 0;
+	if (qstr->len > ADFS_SB(parent->d_sb)->s_namelen)
+		return -ENAMETOOLONG;
 
-	/*
-	 * Truncate the name in place, avoids
-	 * having to define a compare function.
-	 */
-	qstr->len = i = name_len;
+	len = qstr->len;
 	name = qstr->name;
 	hash = init_name_hash(parent);
-	while (i--)
+	while (len--)
 		hash = partial_name_hash(adfs_tolower(*name++), hash);
 	qstr->hash = end_name_hash(hash);
 
-- 
2.7.4

