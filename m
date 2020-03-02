Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7FF9D1757C6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Mar 2020 10:57:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727605AbgCBJ5X (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Mar 2020 04:57:23 -0500
Received: from mx06.melco.co.jp ([192.218.140.146]:33327 "EHLO
        mx06.melco.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727060AbgCBJ5W (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Mar 2020 04:57:22 -0500
Received: from mr06.melco.co.jp (mr06 [133.141.98.164])
        by mx06.melco.co.jp (Postfix) with ESMTP id 55A923A3F52;
        Mon,  2 Mar 2020 18:57:19 +0900 (JST)
Received: from mr06.melco.co.jp (unknown [127.0.0.1])
        by mr06.imss (Postfix) with ESMTP id 48WFtR1lThzRk8J;
        Mon,  2 Mar 2020 18:57:19 +0900 (JST)
Received: from mf04_second.melco.co.jp (unknown [192.168.20.184])
        by mr06.melco.co.jp (Postfix) with ESMTP id 48WFtR1RmzzRjyb;
        Mon,  2 Mar 2020 18:57:19 +0900 (JST)
Received: from mf04.melco.co.jp (unknown [133.141.98.184])
        by mf04_second.melco.co.jp (Postfix) with ESMTP id 48WFtR1hPjzRkCp;
        Mon,  2 Mar 2020 18:57:19 +0900 (JST)
Received: from tux532.tad.melco.co.jp (unknown [133.141.243.226])
        by mf04.melco.co.jp (Postfix) with ESMTP id 48WFtR1DyWzRkBl;
        Mon,  2 Mar 2020 18:57:19 +0900 (JST)
Received:  from tux532.tad.melco.co.jp
        by tux532.tad.melco.co.jp (unknown) with ESMTP id 0229vJZN027658;
        Mon, 2 Mar 2020 18:57:19 +0900
Received: from tux390.tad.melco.co.jp (tux390.tad.melco.co.jp [127.0.0.1])
        by postfix.imss70 (Postfix) with ESMTP id E655C17E075;
        Mon,  2 Mar 2020 18:57:18 +0900 (JST)
Received: from tux554.tad.melco.co.jp (mailgw1.tad.melco.co.jp [10.168.7.223])
        by tux390.tad.melco.co.jp (Postfix) with ESMTP id D982D17E073;
        Mon,  2 Mar 2020 18:57:18 +0900 (JST)
Received: from tux554.tad.melco.co.jp
        by tux554.tad.melco.co.jp (unknown) with ESMTP id 0229vH0t007040;
        Mon, 2 Mar 2020 18:57:18 +0900
From:   Tetsuhiro Kohada <Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>
To:     Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp
Cc:     Mori.Takahiro@ab.MitsubishiElectric.co.jp,
        motai.hirotaka@aj.mitsubishielectric.co.jp,
        Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] staging: exfat: remove redundant if statements
Date:   Mon,  2 Mar 2020 18:57:16 +0900
Message-Id: <20200302095716.64155-2-Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200302095716.64155-1-Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>
References: <20200302095716.64155-1-Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If statement does not affect results when updating directory entry in
ffsMapCluster().

Signed-off-by: Tetsuhiro Kohada <Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>
---
 drivers/staging/exfat/exfat_super.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/exfat/exfat_super.c b/drivers/staging/exfat/exfat_super.c
index 708398265828..75813d0fe7a7 100644
--- a/drivers/staging/exfat/exfat_super.c
+++ b/drivers/staging/exfat/exfat_super.c
@@ -1361,11 +1361,8 @@ static int ffsMapCluster(struct inode *inode, s32 clu_offset, u32 *clu)
 
 		/* (3) update directory entry */
 		if (modified) {
-			if (exfat_get_entry_flag(ep) != fid->flags)
-				exfat_set_entry_flag(ep, fid->flags);
-
-			if (exfat_get_entry_clu0(ep) != fid->start_clu)
-				exfat_set_entry_clu0(ep, fid->start_clu);
+			exfat_set_entry_flag(ep, fid->flags);
+			exfat_set_entry_clu0(ep, fid->start_clu);
 		}
 
 		update_dir_checksum_with_entry_set(sb, es);
-- 
2.25.1

