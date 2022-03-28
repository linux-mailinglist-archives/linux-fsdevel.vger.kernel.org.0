Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F16014E8D94
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Mar 2022 07:48:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238188AbiC1Fu2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Mar 2022 01:50:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232370AbiC1FuW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Mar 2022 01:50:22 -0400
Received: from mail.parknet.co.jp (mail.parknet.co.jp [210.171.160.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6ED0451592;
        Sun, 27 Mar 2022 22:48:42 -0700 (PDT)
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
        by mail.parknet.co.jp (Postfix) with ESMTPSA id 9EAEB15F93A;
        Mon, 28 Mar 2022 14:48:40 +0900 (JST)
Received: from devron.myhome.or.jp (foobar@devron.myhome.or.jp [192.168.0.3])
        by ibmpc.myhome.or.jp (8.16.1/8.16.1/Debian-2) with ESMTPS id 22S5mdSq110033
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Mon, 28 Mar 2022 14:48:40 +0900
Received: from devron.myhome.or.jp (foobar@localhost [127.0.0.1])
        by devron.myhome.or.jp (8.16.1/8.16.1/Debian-2) with ESMTPS id 22S5mdTv426820
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Mon, 28 Mar 2022 14:48:39 +0900
Received: (from hirofumi@localhost)
        by devron.myhome.or.jp (8.16.1/8.16.1/Submit) id 22S5mcVN426819;
        Mon, 28 Mar 2022 14:48:38 +0900
From:   OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To:     qianfan <qianfanguijin@163.com>
Cc:     Guenter Roeck <linux@roeck-us.net>, linux-watchdog@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: linux resetting when the usb storage was removed while copying
References: <1cc135e3-741f-e7d6-5d0a-fef319832a4c@163.com>
        <87pmmee9kr.fsf@mail.parknet.co.jp>
        <06ebc7fb-e7eb-b994-78fd-df07155ef4b5@163.com>
        <15b83842-60d9-78b8-54e9-3a27211caded@roeck-us.net>
Date:   Mon, 28 Mar 2022 14:48:38 +0900
In-Reply-To: <15b83842-60d9-78b8-54e9-3a27211caded@roeck-us.net> (Guenter
        Roeck's message of "Tue, 22 Mar 2022 05:31:06 -0700")
Message-ID: <87pmm6hbk9.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/29.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


>> I had changed console to ttynull and the system doesn't reset again.  kernel driver generate lots of error messages when usb storage is disconnected:
>> 
>> $ dmesg | grep 'FAT read failed' | wc -l
>> 
>> 608
>> 
>> usb storage can work again when reconnected.
>> 
>> The gpio watchdog depends on hrtimer, maybe printk in ISR delayed hrtimer that cause watchdog reset.

This limits the rate of messages. Can you try if a this patch fixes behavior?

Thanks.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>


[PATCH] fat: Add ratelimit to fat*_ent_bread()

fat*_ent_bread() can be the cause of too many report on I/O error
path. So use fat_msg_ratelimit() instead.

Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
---
 fs/fat/fatent.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/fat/fatent.c b/fs/fat/fatent.c
index 978ac67..1db348f 100644
--- a/fs/fat/fatent.c	2022-03-28 14:34:04.582208819 +0900
+++ b/fs/fat/fatent.c	2022-03-28 14:39:26.884325073 +0900
@@ -94,7 +94,8 @@ static int fat12_ent_bread(struct super_
 err_brelse:
 	brelse(bhs[0]);
 err:
-	fat_msg(sb, KERN_ERR, "FAT read failed (blocknr %llu)", (llu)blocknr);
+	fat_msg_ratelimit(sb, KERN_ERR, "FAT read failed (blocknr %llu)",
+			  (llu)blocknr);
 	return -EIO;
 }
 
@@ -107,8 +108,8 @@ static int fat_ent_bread(struct super_bl
 	fatent->fat_inode = MSDOS_SB(sb)->fat_inode;
 	fatent->bhs[0] = sb_bread(sb, blocknr);
 	if (!fatent->bhs[0]) {
-		fat_msg(sb, KERN_ERR, "FAT read failed (blocknr %llu)",
-		       (llu)blocknr);
+		fat_msg_ratelimit(sb, KERN_ERR, "FAT read failed (blocknr %llu)",
+				  (llu)blocknr);
 		return -EIO;
 	}
 	fatent->nr_bhs = 1;
_

-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
