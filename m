Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5420E116BFA
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2019 12:10:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727698AbfLILKg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Dec 2019 06:10:36 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:60152 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727566AbfLILKf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Dec 2019 06:10:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
        Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
        In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ic3XJAvHKvQd+oWh0YGq77iC6jOfSkxKgC8wEN/2xYE=; b=fRx/307n2+qmHVYV1R3d2f/DJi
        yBypF7B2dTgxr4w6lwzXJ1HeQPdjcYBSQN9IucMryOf932/NK1PJzUU8XSl4pRSOJc3SEnXS2sJPS
        Ea8aruPJ6IE2I+VCx2xfNHmynjaO4SEGjTPrWCFRVaAa0l5j9U0v9EPiX+CBpk6Zir72yCwLG3qP+
        K/HbNhcGqFO5E7I0vhoU+W/DTZt6OCFGysbC/FcA/7e5NBmfjDpL0RErf7RxbaE8vZ7Z7SKy1y6Ho
        jhezLkAUrk0sb71Nkgf8tDEFMQqq91XMGY+ksjmes+kz+wD/b0AgS234zLSZdFO4qay1lfJXDJvQu
        LRXHEQ1w==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([2002:4e20:1eda:1:222:68ff:fe15:37dd]:49850 helo=rmk-PC.armlinux.org.uk)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1ieGvw-0002WT-Ot; Mon, 09 Dec 2019 11:10:32 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1ieGvw-0004cn-6M; Mon, 09 Dec 2019 11:10:32 +0000
In-Reply-To: <20191209110731.GD25745@shell.armlinux.org.uk>
References: <20191209110731.GD25745@shell.armlinux.org.uk>
From:   Russell King <rmk+kernel@armlinux.org.uk>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH 27/41] fs/adfs: newdir: improve directory validation
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1ieGvw-0004cn-6M@rmk-PC.armlinux.org.uk>
Date:   Mon, 09 Dec 2019 11:10:32 +0000
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Check that the lastmask and reserved fields are all zero, as per the
documentation.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 fs/adfs/dir_f.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/adfs/dir_f.c b/fs/adfs/dir_f.c
index 196706d581bf..ebe8616ee533 100644
--- a/fs/adfs/dir_f.c
+++ b/fs/adfs/dir_f.c
@@ -127,6 +127,7 @@ static int adfs_f_validate(struct adfs_dir *dir)
 	struct adfs_newdirtail *tail = dir->newtail;
 
 	if (head->startmasseq != tail->endmasseq ||
+	    tail->dirlastmask || tail->reserved[0] || tail->reserved[1] ||
 	    (memcmp(&head->startname, "Nick", 4) &&
 	     memcmp(&head->startname, "Hugo", 4)) ||
 	    memcmp(&head->startname, &tail->endname, 4) ||
-- 
2.20.1

