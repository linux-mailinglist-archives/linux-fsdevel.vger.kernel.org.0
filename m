Return-Path: <linux-fsdevel+bounces-14775-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0260087F286
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Mar 2024 22:49:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7BE47B21B71
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Mar 2024 21:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3005359B59;
	Mon, 18 Mar 2024 21:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b="A1QODJ+s"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 999B05916F
	for <linux-fsdevel@vger.kernel.org>; Mon, 18 Mar 2024 21:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710798556; cv=none; b=pSYvYb7mx6UWTqUvA8ghkTRhR5Ue28W4Goo9GWAAalYexJWhfT/W6txcpUndjpyLo2IKuXtEpTZ8xk7+PaKgef/ZX6HNHnNLnC1v5XjAt7iQUor/ESRfR2hShRNa5xCMBZJjS+AQU42dDD9yFR4nd+kniqEZQ4AlcDSqaHJzJys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710798556; c=relaxed/simple;
	bh=6P3rFkrW9HnhkfagqhtOgoRhL4elj2LsX7y/ud/bmu0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=hhM4onofJ3YvdrxN3lcR2CdYl/tlfl4LV9lsFwb2AEHf7Bp4i1ySs04mkvw2qduPoXLZ4u78S3Qttprfdsd1a2fn+3SZyQUQk4ZJYEkFGKDJFQcGcAODjisk+fEB8VORVa3ueWc6P458ckMk/bdfVzYYyLMjQQsXa0aja+or0Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net; spf=pass smtp.mailfrom=posteo.net; dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b=A1QODJ+s; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id E9C6F240104
	for <linux-fsdevel@vger.kernel.org>; Mon, 18 Mar 2024 22:49:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
	t=1710798546; bh=6P3rFkrW9HnhkfagqhtOgoRhL4elj2LsX7y/ud/bmu0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:Content-Type:
	 Content-Transfer-Encoding:From;
	b=A1QODJ+sQD/n147oK1SJ5BVHfmWOXLEoIsQeobr3+VtG3vpib0kanM+ZLG9Pj/Scu
	 wnR6b/GqpSq1sxwCcuK14I0zAPZjHavXz49fwKOYQORkSI5WF39l9QEVed8lp76a5e
	 LudiJhxvs3nW2JjlwUG+DLuCRGBQtislQ5zDL8ydvU5Sr7c31NW/PVVjlkBf37e0Zy
	 H7IxAYCvgs/5zBKik3nCp7rRKqxgcARwgCBCum3iqNMQ6GbncnAHjWcXjM/frTGdAn
	 H5xpIZx49GJ+HcK03PUOo3I2mHkqQhbAUX+kpmrPuaUFzbgmg5BYKS9dgEgWlWC2CY
	 2SFs7jyXbjqIw==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4Tz7ly5gmvz6trs;
	Mon, 18 Mar 2024 22:49:02 +0100 (CET)
Message-ID: <ec51cc1d-beaa-4aa1-a54d-e503223dd365@posteo.net>
Date: Mon, 18 Mar 2024 21:49:00 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [syzbot] [v9fs?] KMSAN: uninit-value in v9fs_evict_inode
To: syzbot <syzbot+eb83fe1cce5833cd66a0@syzkaller.appspotmail.com>
References: <0000000000002750950613c53e72@google.com>
Content-Language: en-US
Cc: asmadeus@codewreck.org, ericvh@kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux_oss@crudebyte.com, lucho@ionkov.net,
 syzkaller-bugs@googlegroups.com, v9fs@lists.linux.dev
From: Charalampos Mitrodimas <charmitro@posteo.net>
In-Reply-To: <0000000000002750950613c53e72@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

please test uv in v9fs_evict_inode

#syz test 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
index 360a5304ec03..5d046f63e5fa 100644
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -353,7 +353,8 @@ void v9fs_evict_inode(struct inode *inode)
      filemap_fdatawrite(&inode->i_data);

  #ifdef CONFIG_9P_FSCACHE
-    fscache_relinquish_cookie(v9fs_inode_cookie(v9inode), false);
+    if (v9fs_inode_cookie(v9inode))
+        fscache_relinquish_cookie(v9fs_inode_cookie(v9inode), false);
  #endif
  }



