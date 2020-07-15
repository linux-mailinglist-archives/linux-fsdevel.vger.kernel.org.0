Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 332C8220683
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jul 2020 09:54:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729490AbgGOHy2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jul 2020 03:54:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729430AbgGOHy2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jul 2020 03:54:28 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9C47C061755
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Jul 2020 00:54:27 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id q4so1558491lji.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Jul 2020 00:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndmsystems-com.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language;
        bh=AaMeE2VFR8ZuEw5LsQxEItloLz0gWhQi19KYRomVT+s=;
        b=p0kVU3eciEfVOpPecAgjJe9HwQYo4jlHTFXZAA5p+nn7VuY/9uN/12xeA0dtCTOfR3
         If101DlUz+C//0ge2nuUh2hTVj3lp7nk2Iap31qDgVAV2E+mn1fkeNKIy3P4Gld9/WOq
         6zQLXMV9Q7ew0Wvz2aLZ10tL/GFlMeXgGRX/Qf5GS0CItFfc80653xOSMv3LUdLDagJK
         SE2JXory5dh2bUUD2fVBLmaT4lBQshLK9FDgiIsthOZ33sYnDRwjHwCgC02WqMBdbZfZ
         +wpi48lU2OebKq28t2gthQv4/PgoUNAAPw91tnVj3xdJhpnb0umY7U4sFvHohJUgY2y2
         s4sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language;
        bh=AaMeE2VFR8ZuEw5LsQxEItloLz0gWhQi19KYRomVT+s=;
        b=RhPiVsTh/bJIFO4ZUT4mIwJgiZ/QmWIT3HM/kSzHq+t0L16ic41BB6prmoVdWdr5cO
         G1fDolR9mZKZuHznnofbLpCszgteIr1lDRgU9Fp7RG/aE8B5M+PzwHTdawJ3REfZStDI
         VR0Awlifcfy1WGAme0GHNd0vS6iYhvIXCXeeEbiGpPtC5qPFNh70yJ8cEHOij3hwL+T/
         Lk5CC9JNkt21V9ErbShfu0i1v2q46BcTHLcLukJPWWG6x8p9e9LytdYmWHBVZNsNI3Na
         QYBrj92Udnpay0RMOz/7Yms95TQETCG6HJW5qQGwQ8ZI27/xdWIfMDtxPHQbHh80zssX
         4NIg==
X-Gm-Message-State: AOAM532MGCMsdbWDJ4maXX1FPtFv7ui2gvC6DUnyvY3eZf5EQUpPoruG
        Vo3++H/+ghddBLguESQwRV2kyRahPhi06g==
X-Google-Smtp-Source: ABdhPJx8AxldNrX5cG9Ka74ruIuI96lcfgtSIbGkhi1U9UVJU2eU12DapaM5eUh5pGnoNRpcLxUMVQ==
X-Received: by 2002:a2e:8707:: with SMTP id m7mr3999154lji.350.1594799665908;
        Wed, 15 Jul 2020 00:54:25 -0700 (PDT)
Received: from [172.16.120.9] ([176.118.209.45])
        by smtp.googlemail.com with ESMTPSA id y26sm302725ljk.26.2020.07.15.00.54.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jul 2020 00:54:25 -0700 (PDT)
To:     Namjae Jeon <namjae.jeon@samsung.com>,
        Sungjong Seo <sj1557.seo@samsung.com>
Cc:     linux-fsdevel@vger.kernel.org
From:   Ilya Ponetaev <i.ponetaev@ndmsystems.com>
Subject: [PATCH v2] exfat: fix name_hash computation on big endian systems
Message-ID: <77ff2710-ebf7-6958-87a7-a5aa9a709e3b@ndmsystems.com>
Date:   Wed, 15 Jul 2020 10:54:23 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------8737218D46B35B24E58289DC"
Content-Language: en-US
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is a multi-part message in MIME format.
--------------8737218D46B35B24E58289DC
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello!

I tested current kernel 5.8 on MIPS BE CPU, and found that name_hash 
field of directory entry is computed incorrectly due to lack of 
endianess conversion.

It leads to errors in directories listing and opening files:

~# ls /mnt/sda1/
ls: /mnt/sda1/System Volume Information: No such file or directory
ls: /mnt/sda1/node.exe: No such file or directory
ls: /mnt/sda1/node_etw_provider.man: No such file or directory
ls: /mnt/sda1/nodevars.bat: No such file or directory
ls: /mnt/sda1/npm: No such file or directory
ls: /mnt/sda1/npm.cmd: No such file or directory
ls: /mnt/sda1/npx: No such file or directory
ls: /mnt/sda1/npx.cmd: No such file or directory


v2:
  - fixed sparse errors

sparse warnings: (new ones prefixed by >>)

 >> fs/exfat/nls.c:522:27: sparse: sparse: incorrect type in assignment 
(different base types) @@     expected unsigned short @@     got 
restricted __le16 [usertype] @@
 >> fs/exfat/nls.c:522:27: sparse:     expected unsigned short
 >> fs/exfat/nls.c:522:27: sparse:     got restricted __le16 [usertype]
    fs/exfat/nls.c:614:32: sparse: sparse: incorrect type in assignment 
(different base types) @@     expected unsigned short @@     got 
restricted __le16 [usertype] @@
    fs/exfat/nls.c:614:32: sparse:     expected unsigned short
    fs/exfat/nls.c:614:32: sparse:     got restricted __le16 [usertype]



Sincerely yours,
Ilya Ponetayev

--------------8737218D46B35B24E58289DC
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-exfat-fix-name_hash-wrong-on-big_endian-system.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-exfat-fix-name_hash-wrong-on-big_endian-system.patch"

From f6d2c94c57189c162ccb531d10909d6d7f77c058 Mon Sep 17 00:00:00 2001
From: Ilya Ponetayev <i.ponetaev@ndmsystems.com>
Date: Tue, 7 Jul 2020 23:02:30 +0300
Subject: [PATCH] exfat: fix name_hash computation on big endian systems

On-disk format for name_hash field is LE, so it must be explicitly transformed
on BE system for proper result.

Signed-off-by: Chen Minqiang <ptpt52@gmail.com>
Signed-off-by: Ilya Ponetayev <i.ponetaev@ndmsystems.com>
---
 nls.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/nls.c b/nls.c
index d48060a..1a70138 100644
--- a/nls.c
+++ b/nls.c
@@ -494,7 +494,7 @@ static int exfat_utf8_to_utf16(struct super_block *sb,
 		struct exfat_uni_name *p_uniname, int *p_lossy)
 {
 	int i, unilen, lossy = NLS_NAME_NO_LOSSY;
-	unsigned short upname[MAX_NAME_LENGTH + 1];
+	__le16 upname[MAX_NAME_LENGTH + 1];
 	unsigned short *uniname = p_uniname->name;
 
 	WARN_ON(!len);
@@ -518,7 +518,7 @@ static int exfat_utf8_to_utf16(struct super_block *sb,
 		    exfat_wstrchr(bad_uni_chars, *uniname))
 			lossy |= NLS_NAME_LOSSY;
 
-		upname[i] = exfat_toupper(sb, *uniname);
+		upname[i] = cpu_to_le16(exfat_toupper(sb, *uniname));
 		uniname++;
 	}
 
@@ -596,7 +596,7 @@ static int exfat_nls_to_ucs2(struct super_block *sb,
 		struct exfat_uni_name *p_uniname, int *p_lossy)
 {
 	int i = 0, unilen = 0, lossy = NLS_NAME_NO_LOSSY;
-	unsigned short upname[MAX_NAME_LENGTH + 1];
+	__le16 upname[MAX_NAME_LENGTH + 1];
 	unsigned short *uniname = p_uniname->name;
 	struct nls_table *nls = EXFAT_SB(sb)->nls_io;
 
@@ -610,7 +610,7 @@ static int exfat_nls_to_ucs2(struct super_block *sb,
 		    exfat_wstrchr(bad_uni_chars, *uniname))
 			lossy |= NLS_NAME_LOSSY;
 
-		upname[unilen] = exfat_toupper(sb, *uniname);
+		upname[unilen] = cpu_to_le16(exfat_toupper(sb, *uniname));
 		uniname++;
 		unilen++;
 	}

--------------8737218D46B35B24E58289DC--
