Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51A6E256B06
	for <lists+linux-fsdevel@lfdr.de>; Sun, 30 Aug 2020 03:08:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728545AbgH3BIk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 29 Aug 2020 21:08:40 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:33438 "EHLO
        mail.parknet.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728246AbgH3BIj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 29 Aug 2020 21:08:39 -0400
X-Greylist: delayed 536 seconds by postgrey-1.27 at vger.kernel.org; Sat, 29 Aug 2020 21:08:39 EDT
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
        by mail.parknet.co.jp (Postfix) with ESMTPSA id 1FDB81B44DF;
        Sun, 30 Aug 2020 09:59:43 +0900 (JST)
Received: from devron.myhome.or.jp (foobar@devron.myhome.or.jp [192.168.0.3])
        by ibmpc.myhome.or.jp (8.15.2/8.15.2/Debian-20) with ESMTPS id 07U0xf8Y321806
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Sun, 30 Aug 2020 09:59:42 +0900
Received: from devron.myhome.or.jp (foobar@localhost [127.0.0.1])
        by devron.myhome.or.jp (8.15.2/8.15.2/Debian-20) with ESMTPS id 07U0xf0f3060830
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Sun, 30 Aug 2020 09:59:41 +0900
Received: (from hirofumi@localhost)
        by devron.myhome.or.jp (8.15.2/8.15.2/Submit) id 07U0xfPW3060829;
        Sun, 30 Aug 2020 09:59:41 +0900
From:   OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH] fat: Avoid oops when bdi->io_pages==0
Date:   Sun, 30 Aug 2020 09:59:41 +0900
Message-ID: <87ft85osn6.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On one system, there was bdi->io_pages==0. This seems to be the bug of
a driver somewhere, and should fix it though. Anyway, it is better to
avoid the divide-by-zero Oops.

So this check it.

Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: <stable@vger.kernel.org>
---
 fs/fat/fatent.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/fat/fatent.c b/fs/fat/fatent.c
index f7e3304..98a1c4f 100644
--- a/fs/fat/fatent.c	2020-08-30 06:52:47.251564566 +0900
+++ b/fs/fat/fatent.c	2020-08-30 06:54:05.838319213 +0900
@@ -660,7 +660,7 @@ static void fat_ra_init(struct super_blo
 	if (fatent->entry >= ent_limit)
 		return;
 
-	if (ra_pages > sb->s_bdi->io_pages)
+	if (sb->s_bdi->io_pages && ra_pages > sb->s_bdi->io_pages)
 		ra_pages = rounddown(ra_pages, sb->s_bdi->io_pages);
 	reada_blocks = ra_pages << (PAGE_SHIFT - sb->s_blocksize_bits + 1);
 
_

-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
