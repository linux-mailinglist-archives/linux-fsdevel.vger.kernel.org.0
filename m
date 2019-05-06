Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7656B1530F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 May 2019 19:50:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726519AbfEFRuf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 May 2019 13:50:35 -0400
Received: from mail133-31.atl131.mandrillapp.com ([198.2.133.31]:9935 "EHLO
        mail133-31.atl131.mandrillapp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725883AbfEFRuf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 May 2019 13:50:35 -0400
X-Greylist: delayed 903 seconds by postgrey-1.27 at vger.kernel.org; Mon, 06 May 2019 13:50:34 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=mandrill; d=nexedi.com;
 h=From:Subject:To:Cc:Message-Id:In-Reply-To:References:Date:MIME-Version:Content-Type:Content-Transfer-Encoding; i=kirr@nexedi.com;
 bh=qZUWN1kEJ7Nm/rElYRgeKRzf22qzOgyt1hGga7WcdSQ=;
 b=YE5RRrf5C8lt+QZJFxQiAsshpiu5XPngReCSiOhUflV9zrDNSwPEFaO+cq43zWfDrXWBR2vNsqxX
   IQ7mCESVGjQ0ROZW4D+AmkUXM4t8GEIPUhIM0EI/A5Jmz0fHpR+Iv6sQgBj4rZ1cY6uMu9IT6wor
   kg4I2qxPwZGxRW4vVqU=
Received: from pmta02.mandrill.prod.atl01.rsglab.com (127.0.0.1) by mail133-31.atl131.mandrillapp.com id hq1puk1sar8t for <linux-fsdevel@vger.kernel.org>; Mon, 6 May 2019 17:20:46 +0000 (envelope-from <bounce-md_31050260.5cd06ced.v1-8f0b2b09c45a4202a2beadd2cc921498@mandrillapp.com>)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandrillapp.com; 
 i=@mandrillapp.com; q=dns/txt; s=mandrill; t=1557163245; h=From : 
 Subject : To : Cc : Message-Id : In-Reply-To : References : Date : 
 MIME-Version : Content-Type : Content-Transfer-Encoding : From : 
 Subject : Date : X-Mandrill-User : List-Unsubscribe; 
 bh=qZUWN1kEJ7Nm/rElYRgeKRzf22qzOgyt1hGga7WcdSQ=; 
 b=qrxPcuXD81STVbPIX5GOVqrEyWkpjL/84wKVoc293eliPhst2mJnHLdyQOAv38w0H2O8Nw
 gGyTXJu2sDtvEbKVHDC/d5TQdTToeE7Ipq4e+4PhDXc+uO3zkADT+JAGCUgmEeJ67IFy84pu
 1aiVtR1GbgcN+2ELKgTi7GyXX/+F0=
From:   Kirill Smelkov <kirr@nexedi.com>
Subject: [PATCH 1/3] dtlk: remove double call to nonseekable_open
Received: from [87.98.221.171] by mandrillapp.com id 8f0b2b09c45a4202a2beadd2cc921498; Mon, 06 May 2019 17:20:45 +0000
X-Mailer: git-send-email 2.20.1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>,
        Christoph Hellwig <hch@lst.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pavel Machek <pavel@denx.de>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Kirill Smelkov <kirr@nexedi.com>
Message-Id: <184012ad69b275a17d6fa40a8d4dcf15ef76c4d2.1557162679.git.kirr@nexedi.com>
In-Reply-To: <cover.1557162679.git.kirr@nexedi.com>
References: <cover.1557162679.git.kirr@nexedi.com>
X-Report-Abuse: Please forward a copy of this message, including all headers, to abuse@mandrill.com
X-Report-Abuse: You can also report abuse here: http://mandrillapp.com/contact/abuse?id=31050260.8f0b2b09c45a4202a2beadd2cc921498
X-Mandrill-User: md_31050260
Date:   Mon, 06 May 2019 17:20:45 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

dtlk_open currently has 2 calls to nonseekable_open which are both
executed on success path. It was not hurting to make the extra call as
nonseekable_open is only changing file->f_flags in idempotent way.
However the first nonseekable_open is indeed both unneeded and looks
suspicious.

The first nonseekable_open was added in 6244f13c51 ("Fix up a couple of
drivers - notable sg - for nonseekability."; 2004-Aug-7). The second
nonseekable_open call was introduced in dc5c724584 ("Remove ESPIPE logic
from drivers, letting the VFS layer handle it instead.; 2004-Aug-8). The
latter patch being mass change probably missed to remove
nonseekable_open that was introduced into dtlk_open the day before.

Fix it: remove the extra/unneeded nonseekable_open call and leave the
call to nonseekable_open only on the path where we are actually opening
the file.

Suggested-by: Pavel Machek <pavel@denx.de>
Signed-off-by: Kirill Smelkov <kirr@nexedi.com>
---
 drivers/char/dtlk.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/char/dtlk.c b/drivers/char/dtlk.c
index f882460b5a44..669c3311adc4 100644
--- a/drivers/char/dtlk.c
+++ b/drivers/char/dtlk.c
@@ -298,7 +298,6 @@ static int dtlk_open(struct inode *inode, struct file *file)
 {
 	TRACE_TEXT("(dtlk_open");
 
-	nonseekable_open(inode, file);
 	switch (iminor(inode)) {
 	case DTLK_MINOR:
 		if (dtlk_busy)
-- 
2.20.1
