Return-Path: <linux-fsdevel+bounces-26278-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 032EC956FC3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2024 18:07:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 831A11F223A4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2024 16:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBB4716D4E1;
	Mon, 19 Aug 2024 16:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="YggP3P7S";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CnrRxde4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout8-smtp.messagingengine.com (fout8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E7D3184528
	for <linux-fsdevel@vger.kernel.org>; Mon, 19 Aug 2024 16:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724083471; cv=none; b=hlddmqLfS+ri4CbjTza0ShnPzJ0tNAbKDsUsqzujS/MkSf8Es8VD1ywkJqULjo+e/qzOmQKuDmnAxBgXLNgdXczGVBc6C6CkxrdrTPFV6Xufh7suuBBmwUHAqajU8M0bTryBSteGbI5oNBWmZ8mb0t1q3eGSnEGbSCf7OZHmktM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724083471; c=relaxed/simple;
	bh=i9+fbskjjzpM7ml4fOKgH3pRE4Qf/4st/xHCnethSYA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=H1dmJPYt1HgzoNhBbLmzCaz1vt/3TDzX7Ee3rK1ZcsWQsgQ54WkgSMO4Aa14M7iQ4lfFTlajyLxFT7Ngf6sWMciQj7ngUP+BVLMU89vyY6Rz2LxPx38Jut+ekppIE5EZZbq1PUWyroqEMBnp5saTcjhbh6j7ojmxHT1M1PSmCxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=YggP3P7S; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CnrRxde4; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from phl-compute-05.internal (phl-compute-05.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 4E06313868EA;
	Mon, 19 Aug 2024 12:04:28 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 19 Aug 2024 12:04:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1724083468;
	 x=1724169868; bh=NUPSTRTMLE+zTnD84j2ILDwS7qwaC59x3c83WeSieCA=; b=
	YggP3P7S6bQiiNRwNBH8DwVrsWM5zGl6jIUYb4cQt05R9bCqs14J2CIswg+YmB20
	0VgZp+WOls3uqvXCaiQ4DVoGR/20Cyeb0zQkNwSCH9ZiOIHblDIUepUl7y2Osxrf
	Zp/Wvm0YaDd7nluQgjHw3uQPEzCea3Dxb4/dqLSoHwYRFU7PjN+oYEvH77din4m5
	vMyVU64mseJOHE3vY8aUlG/Hw81vbLAynZyqXPdobSeUJciI1UQXIyMQSGb7YGyL
	Frbfu/ucfjJMdAA4MTSwlNJstC5Uh0LmgChJMSrKmkZxHTBWKPx77X9S/b2fss+U
	jUMRRCnnVCHIP9jg5GKJFA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1724083468; x=
	1724169868; bh=NUPSTRTMLE+zTnD84j2ILDwS7qwaC59x3c83WeSieCA=; b=C
	nrRxde4hiPN+Gm4Fj/TbfbpGsMan2HzbW8bp+qheFz4dezgaQURHnvZ1gJ6TkVjw
	q+LlxU4uHxPYp/dlkVnHsCfnbuQmY6zWxgbm8lL2dJidt5ZelZD796QJcCu8Bh6C
	KW+Fj8pbT9ILP80ReDddCX2tYpt8X7hGkSaMuWnHK3UShdWhYu3uxY/nRLgLQq+w
	3dd3ugn6zcP2tIDRBmwN4mhy+xTRhnjHZEAAU/27tB+0OYCajWoOw57aQGMArDnf
	LgNpKn4Ne30zp7I6Zzm5DUSBWM8opoOdSbpwy+xsm0YyifTnVDvBr2SBGyJGg15E
	MBp5bEP5Q4Qc71JUPZ1Yw==
X-ME-Sender: <xms:C23DZsXGM-7nE9VpDMtoQhNFurUwO_tO_ZJi03XcLRjVoNyX3NgGOg>
    <xme:C23DZgm8MkzGn9vrGE03VdliV7urNez-ZeTjgSwiXufNAQdxbt23A0EwLdrwE7tny
    QpdTT7QosJ3RLaS>
X-ME-Received: <xmr:C23DZgZ-NiQUwHVtK4ovpzznVuxA8PrG3NT9x-EtVuGZeifOc2u9A_cnITq-BLGtx4JfE3eodpjFVHerg7qjxdUCUH-vKL1_3rja3V7vYiPJXZ7umg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddugedgleeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnegoufhushhpvggtthffohhmrghinhculdegledmnecujfgurhep
    kfffgggfuffvfhfhjggtgfesthekredttddvjeenucfhrhhomhepuegvrhhnugcuufgthh
    husggvrhhtuceosggvrhhnugdrshgthhhusggvrhhtsehfrghsthhmrghilhdrfhhmqeen
    ucggtffrrghtthgvrhhnpeelleevvddtveeiieffjeeiuedujeehvedtudfffefghfffle
    elheeludffffejjeenucffohhmrghinhepghhithhhuhgsrdgtohhmpdgtvghrnhdrtghh
    pdhsohhurhgtvghfohhrghgvrdhnvghtnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepsggvrhhnugdrshgthhhusggvrhhtsehfrghsthhmrghi
    lhdrfhhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtth
    hopehlrghurhgrrdhprhhomhgsvghrghgvrhestggvrhhnrdgthhdprhgtphhtthhopehf
    uhhsvgdquggvvhgvlheslhhishhtshdrshhouhhrtggvfhhorhhgvgdrnhgvthdprhgtph
    htthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:C23DZrV42AbeNlAN8LUIf4UP4ZGvaqrZslhz7SIFGGmwiIfbvGqElw>
    <xmx:C23DZmnHvd_X7qDb3coCgBRvypasGOMURPgDBigkh4xOwel7-mxflw>
    <xmx:C23DZgfaqChUgGhgK4IXzArgsEC0NXsh1f9OA8FAT5y-4u9z2UdTLg>
    <xmx:C23DZoGw2IbR3sQ2shPpngax1zVxzkTpu2SLCF-6OyGNP7xMgfo0xg>
    <xmx:DG3DZojZ2d5VlwAUTcEbSskKvVORRviTg90P2CHzhc6Qev5dd9cc8YFz>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 Aug 2024 12:04:26 -0400 (EDT)
Message-ID: <a17c8525-8d76-4d87-a7b9-879d1a107434@fastmail.fm>
Date: Mon, 19 Aug 2024 18:04:25 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [fuse-devel] Symlink caching: Updating the target can result in
 corrupted symlinks - kernel issue?
To: Laura Promberger <laura.promberger@cern.ch>,
 "fuse-devel@lists.sourceforge.net" <fuse-devel@lists.sourceforge.net>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <GV0P278MB07187F9B0E7B576AD0B362B485802@GV0P278MB0718.CHEP278.PROD.OUTLOOK.COM>
From: Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Language: en-US, fr, ru
In-Reply-To: <GV0P278MB07187F9B0E7B576AD0B362B485802@GV0P278MB0718.CHEP278.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Laura,

it is better to use linux-fsdevel if you suspect kernel issues. The
sourceforge list is badly spammed and I'm not sure there are many people
who read it. Personally I get it sorted into special folder.
We should probably ask for a new fuse list on  a kernel server...

On 8/15/24 16:11, Laura Promberger wrote:
> Hi Miklos, and fuse developers,
> 
> I want to say thanks again for implementing the fuse_expire_entry functionality [0]. With this being able to do symlink caching is a well-received feature. But like [1], we also notice that in certain cases corrupted symlinks are returned on `readlink` (new value with old length).
> 
> TL;DR
> Symlink corruption (new value, old length) can occur if the target of a symlink changes; symlink inode stays the same; expire is used for dentries and inval for inodes.
> It is most likely a kernel issue as userland returns the correct new symlink.
> - In healthy calls (kernel) `fuse_change_attributes()` and `fuse_change_attributes_common()` are called. 
> - But for corrupted symlinks `fuse_change_attributes()` exits before `fuse_change_attributes_common()` is called and as such the length stays the old one.
> 
> Why it is able to exit early is not clear to me.
> 
> 
> Nicer formatted version: https://github.com/cvmfs/cvmfs/issues/3626#issuecomment-2291308284
> 
> --------------------------------------------------------
> Before continuing to describe the problem, here a short overview of our file system:
> --------------------------------------------------------
> 
> CernVM-FS [2] is a snapshot-based read-only, distributed file system. The file system does not have genuine inodes but "cvmfs inodes" that are artificially issued by the fuse module to allow keep track of and serve correctly open files during different generations of snapshots (an open file from snapshot A should be still working on the snapshot A data, while a new request should work on the current snapshot D).
> 
> When a new snapshot becomes available the following steps are performed:
> 1. Stop Kernel caching (new dentries timeout = 0)
> 2. Asynchronously evict kernel caches (inval inodes, expire dentries - we have trackers for it to know what the kernel has in its caches)
> 3. Apply new snapshot
>    - this is a critical section and will stop any execution of critical sections within all posix functions (open, readlink, getatt, lookup, read, ...)
>    - mutex to stop and drain readlink requests (wait for drain, and have an extra stop within readlink before the critical section)
>    - evict inodes again
>    - apply new snapshot
>    - restart readlink requests
>    - end critical section
> 4. Turn back on kernel caching
> 
> During all those steps, requests from the user can and will come in. As such, we do not want to fail lookup/open/readlink requests if they are valid requests on the new snapshot (even if the inode is "old"). For open/read etc we have mechanics to figure out if to work on stale cvmfs inodes or replace them with new ones.
> 
> --------------------------------------------------------
> 
> While the event itself is randomly happening, we have a reproducer for our file system that can reliably reproduce it within a couple of minutes. It performs as quickly as possible a readlink on `my-symlink` while new snapshots are applied that change the target `my-symlink` points to. The targets have different length and point to valid files.

Do you have description how to run that reproducer? Would it be possible
to run it in a VM?

> 
> The mutex around the readlink decreases the likelyhood of returning a corrupted symlink but does not fully solve it. Adding sleeps did not change anything. 
> 
> Note:
> - Using no kernel symlink caching will not trigger the bug
> - We must expire dentries and cannot invalidate them due to invalidate destroying mount-on-top paths, which is heavily used by containers
> - We use the lowlevel libfuse API
> - The (kernel) inode of the symlink does not change, even though the target location changes and the snapshot changes
> 
> --------------------------------------------------------
> Debugging results
> --------------------------------------------------------
> 0) This problem only occurs if readlink-calls are performed in a very tight loop during application of a new snapshot. (e.g. when adding a `sleep(1)` inside the loop i do not seem to be able to trigger this issue)
> 1) On the userland everything seems to work correctly:
> - after the new snapshot, cvmfs_readlink()and the subsequent call to cvmfs_getattr() return the correct new value and new length of the symlink. --> But this is ignored. (This can also be seen in fuse_change_attributes() parameter fuse_attr having the correct values)
> 2) It seems to be a kernel space issue:
> - libfuse expire dentry triggers in the fuse kernel module: fuse_dentry_revalidate (see the description below [A] )
> - fuse_dentry_revalidate() calls fuse_change_attributes()
> - fuse_change_attributes() parmeters include `inode` which has the current value, and `fuse_attr` that contains the new values (with correct new length)
> - fuse_change_attributes() calls fuse_change_attributes_common() which updates most of the attribute values of `inode` to the values given in `attr`. Afterwards fuse_change_attributes() continues to update the length.
> 3) In corrupted symlink cases fuse_change_attributes() exits before fuse_change_attributes_common() is called
> 
> For the logs: 
> - Notes/Comments are put in << some comment >>
> - `SYMLINK CHANGED` output is from the user program `corrupt_symlink` what the readlink() returns
> - In all cases the readlink is refered to by inode 270
> - Compared to the raw log output, I did a bit of formatting to make it (hopefully) easier to read
> 
> --------------------------------------------------------
>  Good log
> --------------------------------------------------------
>    08/15/24 11:35:34.959253 fuse_reverse_inval_inode:    func cvmfs2             ino 270 offset 0 len 0
>    08/15/24 11:35:34.959258 fuse_invalidate_attr:        func cvmfs2             inode-inode 270 inode-size 22
> 
> << stop caching here>>
>    08/15/24 11:35:35.984689 fuse_dentry_settime:         func cvmfs2             d_time 0 ino 270 new_time 0
>    08/15/24 11:35:35.984784 fuse_reverse_inval_inode:    func cvmfs2             ino 270 offset 0 len 0
>    08/15/24 11:35:35.984791 fuse_invalidate_attr:        func cvmfs2             inode-inode 270 inode-size 22
>    08/15/24 11:35:35.984855 fuse_reverse_inval_inode:    func cvmfs2             ino 270 offset 0 len 0
>    08/15/24 11:35:35.984859 fuse_invalidate_attr:        func cvmfs2             inode-inode 270 inode-size 22
>    08/15/24 11:35:36.086263 fuse_dentry_revalidate:      func corrupt_symlink    d_time 0 ino 270 size 22 flags 16448
>    08/15/24 11:35:36.086284 fuse_dentry_revalidate:      func corrupt_symlink    d_time 0 ino 270 size 22 flags 16384
>    08/15/24 11:35:36.086566 fuse_invalid_attr:           func corrupt_symlink    ino 270 size 16 blksize 4096
> 
>    08/15/24 11:35:36.086579 fuse_change_attributes:  func corrupt_symlink \
>                                                       inode: ino 270, size 22, version.counter 0, state 0 \
>                                                       fuse_attr: ino 270, size 16, blksize 4096, \
>                                                       fuse_statx: ino 0, size 0, blksize 0, \
>                                                       fuse_inode: ino 0, orig_ino 0, attr_version 0 state 0 \
>                                                       attr_valid 98, attr_version 0
> 
>    08/15/24 11:35:36.086584 fuse_change_attributes_common: func corrupt_symlink 
>                                                             inode: ino 270, i_size 22, \
>                                                             fuse_attr: ino 270, size 16, blksize 4096, \
>                                                             fuse_statx: ino 0, size 0, blksize 0, \
>                                                             attr_valid 0, cache_mask 0
> 
> << restart caching here >>
>    08/15/24 11:35:36.086588 fuse_dentry_settime:      func corrupt_symlink  d_time 0 ino 270 new_time 68641802
>    08/15/24 11:35:36.086598 fuse_get_link:            func corrupt_symlink  dentry-inode 270 dentry-size 16 inode-inode 270 inode-size 16
>    08/15/24 11:35:36.086612 fuse_readlink_page:       func corrupt_symlink  ino 0 inode 270 size 16
> 
> Current time: 08/15/24 09:35:36.086833735 UTC
> SYMLINK CHANGED:  1402844     size 16     symlinktest/1a1b
> << correct value and size >>
> 
>    08/15/24 11:35:36.087078 fuse_dentry_revalidate:   func corrupt_symlink  d_time 0 ino 270 size 16 flags 16448
>    08/15/24 11:35:36.087085 fuse_get_link:            func corrupt_symlink  dentry-inode 270 dentry-size 16 inode-inode 270 inode-size 16
> 
> --------------------------------------------------------
> Bad log - old length, new symlink too long
> --------------------------------------------------------
>    08/15/24 11:35:11.883895 fuse_get_link:            func corrupt_symlink    dentry-inode 270 dentry-size 22 inode-inode 270 inode-size 22
>    08/15/24 11:35:11.884372 fuse_dentry_revalidate:   func corrupt_symlink    d_time 0 ino 270 size 22 flags 16384
> 
> << stop caching here>>
>    08/15/24 11:35:11.884238 fuse_dentry_settime:      func cvmfs2             d_time 0 ino 270 new_time 0
>    08/15/24 11:35:11.884334 fuse_reverse_inval_inode: func cvmfs2             ino 270 offset 0 len 0
>    08/15/24 11:35:11.884338 fuse_invalidate_attr:     func cvmfs2             inode-inode 270 inode-size 22
>    08/15/24 11:35:11.880132 fuse_dentry_revalidate:   func corrupt_symlink    d_time 0 ino 270 size 22 flags 16448
>    08/15/24 11:35:11.880142 fuse_get_link:            func corrupt_symlink    dentry-inode 270 dentry-size 22 inode-inode 270 inode-size 22
>    08/15/24 11:35:11.884041 fuse_dentry_revalidate:   func corrupt_symlink    d_time 0 ino 270 size 22 flags 16448
>    08/15/24 11:35:11.884052 fuse_get_link:            func corrupt_symlink    dentry-inode 270 dentry-size 22 inode-inode 270 inode-size 22
>    08/15/24 11:35:11.884169 fuse_dentry_revalidate:   func corrupt_symlink    d_time 0 ino 270 size 22 flags 16448
>    08/15/24 11:35:11.884174 fuse_get_link:            func corrupt_symlink    dentry-inode 270 dentry-size 22 inode-inode 270 inode-size 22
>    08/15/24 11:35:12.904539 fuse_reverse_inval_inode: func cvmfs2             ino 270 offset 0 len 0
>    08/15/24 11:35:12.904554 fuse_invalidate_attr:     func cvmfs2             inode-inode 270 inode-size 22
>    08/15/24 11:35:12.904592 fuse_reverse_inval_inode: func cvmfs2             ino 270 offset 0 len 0
>    08/15/24 11:35:12.904595 fuse_invalidate_attr:     func cvmfs2             inode-inode 270 inode-size 22
>    08/15/24 11:35:13.004875 fuse_invalid_attr:        func corrupt_symlink    ino 270 size 36 blksize 4096
> 
>    08/15/24 11:35:13.004891 fuse_change_attributes:  func corrupt_symlink \
>                                                       inode: ino 270, size 22, version.counter 0, state 0 \
>                                                       fuse_attr: ino 270, size 36, blksize 4096, \
>                                                       fuse_statx: ino 0, size 0, blksize 0, \
>                                                       fuse_inode: ino 0, orig_ino 0, attr_version 0, state 0 \
>                                                       attr_valid 74, attr_version 0
> 
> <<<< fuse_change_attributes_common is missing >>>>
> 
> << restart caching here >>
>    08/15/24 11:35:13.004897 fuse_dentry_settime:      func corrupt_symlink    d_time 0 ino 270 new_time 68636032
>    08/15/24 11:35:13.004907 fuse_get_link:            func corrupt_symlink    dentry-inode 270 dentry-size 22 inode-inode 270 inode-size 22
>    08/15/24 11:35:13.004920 fuse_readlink_page:       func corrupt_symlink    ino 0 inode 270 size 22
> 
> Current time: 08/15/24 11:35:13.005221851 UTC
> SYMLINK CHANGED:  936856      size 22     symlinktest/10bbbbbbbb
> << wrong value: symlink should point to symlinktest/10bbbbbbbbbb10cccccccccc with length 36 >>
> 
>    08/15/24 11:35:13.007225 fuse_dentry_revalidate:   func corrupt_symlink     d_time 0 ino 270 size 22 flags 16448
>    08/15/24 11:35:13.007244 fuse_get_link:            func corrupt_symlink     dentry-inode 270 dentry-size 22 inode-inode 270 inode-size 22
>    08/15/24 11:35:13.007363 fuse_dentry_revalidate:   func corrupt_symlink     d_time 0 ino 270 size 22 flags 16448
> 
> --------------------------------------------------------
> Bad log - old length, new symlink too short (user will not see that mismatch due to null terminator)
> --------------------------------------------------------
>    08/15/24 11:35:00.338840 fuse_get_link:            func corrupt_symlink    dentry-inode 270 dentry-size 22 inode-inode 270 inode-size 22
>    08/15/24 11:35:00.338888 fuse_dentry_revalidate:   func corrupt_symlink    d_time 0 ino 270 size 22 flags 16448
>    08/15/24 11:35:00.338891 fuse_get_link:            func corrupt_symlink    dentry-inode 270 dentry-size 22 inode-inode 270 inode-size 22
> 
> << stop caching here>>
>    08/15/24 11:35:00.339018 fuse_dentry_settime:      func cvmfs2             d_time 0 ino 270 new_time 0
>    08/15/24 11:35:00.339076 fuse_reverse_inval_inode: func cvmfs2             ino 270 offset 0 len 0
>    08/15/24 11:35:00.339078 fuse_invalidate_attr:     func cvmfs2             inode-inode 270 inode-size 22
>    08/15/24 11:35:00.339110 fuse_dentry_revalidate:   func corrupt_symlink    d_time 0 ino 270 size 22 flags 16384
>    08/15/24 11:35:01.364445 fuse_reverse_inval_inode: func cvmfs2             ino 270 offset 0 len 0
>    08/15/24 11:35:01.364457 fuse_invalidate_attr:     func cvmfs2             inode-inode 270 inode-size 22
>    08/15/24 11:35:01.364484 fuse_reverse_inval_inode: func cvmfs2             ino 270 offset 0 len 0
>    08/15/24 11:35:01.364488 fuse_invalidate_attr:     func cvmfs2             inode-inode 270 inode-size 22
>    08/15/24 11:35:01.464772 fuse_invalid_attr:        func corrupt_symlink    ino 270 size 14 blksize 4096
> 
>    08/15/24 11:35:01.464796 fuse_change_attributes:  func corrupt_symlink \
>                                                       inode: ino 270, size 22, version.counter 0, state 0, \
>                                                       fuse_attr: ino 270, size 14, blksize 4096, \
>                                                       fuse_statx: ino 0, size 0, blksize 0, \
>                                                       fuse_inode: ino 0, orig_ino 0, attr_version 0, state 0 \
>                                                       attr_valid 65, attr_version 0
> 
> <<<< fuse_change_attributes_common is missing >>>>
> 
> << restart caching here >>
>    08/15/24 11:35:01.464803 fuse_dentry_settime:      func corrupt_symlink    d_time 0 ino 270 new_time 68633147
>    08/15/24 11:35:01.464815 fuse_get_link:            func corrupt_symlink    dentry-inode 270 dentry-size 22 inode-inode 270 inode-size 22
>    08/15/24 11:35:01.464836 fuse_readlink_page:       func corrupt_symlink    ino 0 inode 270 size 22
> 
> Current time: 08/15/24 11:35:01.465255963 UTC
> SYMLINK CHANGED:  703167      size 14     symlinktest/fg
> << correct value but kernel works with too large size 22 instead of 14 >>
> 
>    08/15/24 11:35:01.466162 fuse_dentry_revalidate:   func corrupt_symlink    d_time 0 ino 270 size 22 flags 16448
>    08/15/24 11:35:01.466174 fuse_get_link:            func corrupt_symlink    dentry-inode 270 dentry-size 22 inode-inode 270 inode-size 22
>    08/15/24 11:35:01.466447 fuse_dentry_revalidate:   func corrupt_symlink    d_time 0 ino 270 size 22 flags 16448
> 
> --------------------------------------------------------
> My understanding from the logs
> --------------------------------------------------------
> Looking at the good and bad logs, the only difference is fuse_change_attributes_common() not being called from fuse_change_attributes(). This is only possible if the following branch is being taken:
> if ((attr_version != 0 && fi->attr_version > attr_version) ||
>           test_bit(FUSE_I_SIZE_UNSTABLE, &fi->state)) {
>             spin_unlock(&fi->lock);
>             return;
>       }
> However, looking at bpftrace (see code being used below [B]), I do not understand how this branch can be taken as in the logs it is stated: 
> `attr_version == 0` and `&fi->state == 0` with `struct fuse_inode *fi = get_fuse_inode(inode);`


fuse_reverse_inval_inode() has

	fi = get_fuse_inode(inode);
	spin_lock(&fi->lock);
	fi->attr_version = atomic64_inc_return(&fc->attr_version);
	spin_unlock(&fi->lock);


But that is not in fuse_reverse_inval_entry(). Could you test a patch?

> 
> I also have looked where `set_bit(FUSE_I_SIZE_UNSTABLE,` is called and attached to the kprobes of it. But none of them got triggered.
> - fuse_do_setattr
> - fuse_perform_write
> - fuse_file_fallocate
> - __fuse_copy_file_range
> 
> The complete logs and bpftrace script can be found here: https://cernbox.cern.ch/s/EBVedOKe6ng4O0H 
> A nicer formated version can be found here: https://github.com/cvmfs/cvmfs/issues/3626#issuecomment-2291308284 
> 
> If you need any more information or have any idea how to fix it, please let me know.
> 
> Thanks
> Laura
> 
> 
> [0] https://sourceforge.net/p/fuse/mailman/fuse-devel/thread/0158a70b-3d78-ce18-f38f-b8563d9efcdd@cern.ch/
> [1] https://sourceforge.net/p/fuse/mailman/fuse-devel/thread/fbb2f999-6b37-5875-deca-989a75ce3b5b@spawn.link/
> [2] https://github.com/cvmfs/cvmfs
> 
> [A]
> /*
>  * Check whether the dentry is still valid
>  *
>  * If the entry validity timeout has expired and the dentry is
>  * positive, try to redo the lookup.  If the lookup results in a
>  * different inode, then let the VFS invalidate the dentry and redo
>  * the lookup once more.  If the lookup results in the same inode,
>  * then refresh the attributes, timeouts and mark the dentry valid.
>  */
> static int fuse_dentry_revalidate(struct dentry *entry, unsigned int flags)
> 
> [B] (bpftrace version v0.14.0, 6.5.0-26-generic #26~22.04.1-Ubuntu )
> kprobe:fuse_change_attributes
> / ((struct inode *) arg0)->i_ino == 270 / {
>   $x = nsecs;
>   printf("%s fuse_change_attributes:\tfunc %s inode_ino %ld inode_size %ld, inode_version.counter %ld, inode_state %lu fuse_attr ino %ld, fuse_attr size, fuse_attr %ld blksize %ld, fuse_statx ino %ld, fuse_statx size %ld fuse_statx blksize %ld, fuse_inode ino %ld,  fuse_inode orig_ino %lu, fuse_inode attr_version %lu fuse_inode state %ld -- attr_valid %lu, attr_version %lu\n",
>           strftime("%D %T.%f", $x), comm,
>           ((struct inode *) arg0)->i_ino,
>           ((struct inode *) arg0)->i_size,
>           ((struct inode *) arg0)->i_version.counter,
>           ((struct inode *) arg0)->i_state,
>           ((struct fuse_attr*)arg1)->ino,
>           ((struct fuse_attr*)arg1)->size,
>           ((struct fuse_attr*)arg1)->blksize,
>           ((struct fuse_statx*)arg2)->ino,
>           ((struct fuse_statx*)arg2)->size,
>           ((struct fuse_statx*)arg2)->blksize,
>           ((struct fuse_inode *)((struct inode *) arg0)->i_private)->nodeid,
>           ((struct fuse_inode *)((struct inode *) arg0)->i_private)->orig_ino,
>           ((struct fuse_inode *)((struct inode *) arg0)->i_private)->attr_version,
>           ((struct fuse_inode *)((struct inode *) arg0)->i_private)->state,
>           arg3, arg4
>         );
> }

Nice analysis!


Thanks,
Bernd

