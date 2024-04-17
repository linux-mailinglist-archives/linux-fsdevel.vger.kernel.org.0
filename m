Return-Path: <linux-fsdevel+bounces-17138-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 427608A83D4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 15:08:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7105B1C21106
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 13:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DAFD13DDA0;
	Wed, 17 Apr 2024 13:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="KH9DerAQ";
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="dysMG+oi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC6F139F;
	Wed, 17 Apr 2024 13:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.157.23.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713359271; cv=none; b=koYPONM9QLrSlnoWrWRet5ckquYlE6M2adXEAHQx5mskY8qOyIU5H66B2F57MRuGgQnuvKmabWa1dEvz3dkNST+3wZNah1oqpHFKjpFtR//Fcsr9KgSHA/puT5JkmGDZplzHmwzgTxPyEY1ck2jjjdQBG6z/LDmDZbQlddFYfhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713359271; c=relaxed/simple;
	bh=lmasahfYKfVOBZlqGI9lYCBg9fkni9arTHpxK4mtGXw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=tIBnZuhAASw4+uwKHYJVdrktd5Qibrg0k1bmZLG7p+1iSTnb2P6nszuHph1LYRL+GTHlnPKKCOpr2Ldh2T2Q3ULSPZLhrwuE1UIsmoGLpUtGf1HB/zXnvWzOYF3gEyuJFq1XRpXJOue1LqSsBPU/duxEs9kMz2ZbFw0Rzy+0MTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com; spf=pass smtp.mailfrom=paragon-software.com; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=KH9DerAQ; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=dysMG+oi; arc=none smtp.client-ip=35.157.23.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paragon-software.com
Received: from relayfre-01.paragon-software.com (unknown [172.30.72.12])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 11E1D2126;
	Wed, 17 Apr 2024 13:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1713358818;
	bh=IMyO98h2ap+R+a4RgdmKeCsdfzkIWjUB3lBQadUdqOQ=;
	h=Date:Subject:From:To:References:In-Reply-To;
	b=KH9DerAQZXwiD/zM3X17AjS+GPdu7Y8kHwmMAh+GcEHp4ZY0SEEASN6tO7nzyq/Pm
	 Euii0gQAmT5qhLo1c2Au0ZDHC9XeX2HRqcZZGdcunaaabLLX2VDJwnPnBPTn4+rgud
	 gUA7cYpt3szPv5RM9aryTpBeIBUeRoZRMik1GXNE=
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayfre-01.paragon-software.com (Postfix) with ESMTPS id 03BC935D;
	Wed, 17 Apr 2024 13:07:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1713359267;
	bh=IMyO98h2ap+R+a4RgdmKeCsdfzkIWjUB3lBQadUdqOQ=;
	h=Date:Subject:From:To:References:In-Reply-To;
	b=dysMG+oiiCetBRdhchoD5f2jOZhun7Gi7zy8ArGOJj2n+ANbkjGNM1RtT4qfqx2dE
	 lw0XLZ2zALJKturXwTgTVunvLxkCSlItw4fktGKVC+Jji+E1LHBtJAZon5L+k7I0tl
	 fyl736oKMIz7femYL5+WKArSkhvChHl3jxUuVuN4=
Received: from [192.168.211.39] (192.168.211.39) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Wed, 17 Apr 2024 16:07:46 +0300
Message-ID: <eb05b34a-e21c-4948-bef8-0d06fb9d7c5e@paragon-software.com>
Date: Wed, 17 Apr 2024 16:07:46 +0300
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 07/11] fs/ntfs3: Check 'folio' pointer for NULL
From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To: <ntfs3@lists.linux.dev>, LKML <linux-kernel@vger.kernel.org>,
	Linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <6c99c1bd-448d-4301-8404-50df34e8df8e@paragon-software.com>
Content-Language: en-US
In-Reply-To: <6c99c1bd-448d-4301-8404-50df34e8df8e@paragon-software.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: vdlg-exch-02.paragon-software.com (172.30.1.105) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)

It can be NULL if bmap is called.

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
  fs/ntfs3/inode.c | 17 +++++++++++------
  1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index 85a10d4a74c4..94177c1dd818 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -570,13 +570,18 @@ static noinline int ntfs_get_block_vbo(struct 
inode *inode, u64 vbo,
      clear_buffer_uptodate(bh);

      if (is_resident(ni)) {
-        ni_lock(ni);
-        err = attr_data_read_resident(ni, &folio->page);
-        ni_unlock(ni);
-
-        if (!err)
-            set_buffer_uptodate(bh);
+        bh->b_blocknr = RESIDENT_LCN;
          bh->b_size = block_size;
+        if (!folio) {
+            err = 0;
+        } else {
+            ni_lock(ni);
+            err = attr_data_read_resident(ni, &folio->page);
+            ni_unlock(ni);
+
+            if (!err)
+                set_buffer_uptodate(bh);
+        }
          return err;
      }

-- 
2.34.1


