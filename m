Return-Path: <linux-fsdevel+bounces-47258-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95FB5A9B0F0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 16:32:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9BD53B4CA2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 14:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E09F283C86;
	Thu, 24 Apr 2025 14:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manguebit.com header.i=@manguebit.com header.b="LAVTvL+j"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx.manguebit.com (mx.manguebit.com [167.235.159.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E05F2820B9;
	Thu, 24 Apr 2025 14:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.235.159.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745504735; cv=none; b=DrZdIcsLCYms9UnKnftUJiA4YT17g6Ei+8DxQY/3Lmv58cfC2HqDLivkjCH7BK1GEEdPkf5k10LYYs6443lJq6AT5NZRDBM7GgXZlGqSDdtrU+OFQmraSTaZEg8JW33adH/pu336iYuZDcnyXNZ5JNinNbuS5b0eIVnbZ54N6KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745504735; c=relaxed/simple;
	bh=ctJUQqsDIJ4N/zUvhphAU/Viu/T5q5vuPpSV4mT1pBU=;
	h=Message-ID:From:To:Cc:Subject:In-Reply-To:References:Date:
	 MIME-Version:Content-Type; b=tlPSqi/szTJmuwLyRFFDIxG6NHdRrouoeCcW3jWGCyJKyFebaySGJMT6GvvSZwM/HlGwIX/biO+MN0xMTlKZ7XHjMz9a5EUvdYULowzUusc+um1NyZHP7fPWuLB9BRYES7lF5Z7jZKD9uIJfUTxsJHRvZcBcNQzhHaxqm1xxsaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manguebit.com; spf=pass smtp.mailfrom=manguebit.com; dkim=pass (2048-bit key) header.d=manguebit.com header.i=@manguebit.com header.b=LAVTvL+j; arc=none smtp.client-ip=167.235.159.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manguebit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manguebit.com
Message-ID: <e0b7f4902af6c758b5cdb7c2b7892b43@manguebit.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manguebit.com;
	s=dkim; t=1745504731;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qihysb7F6c8dcZhnGNX5LEKZVBHLri51T3P5qA9Nth0=;
	b=LAVTvL+jyTLTPukfCmxmlAI8/KfahgZ8acBCNWtG4W4vhzl2tzxe960o92gZA+UHXfG/yM
	PkJNUvgy2LKhSb9Mn2TBhJUNMp7yWXAkI4NBsnNRwtp2Ru+QsiP01TkmRMcbpnxOtdyHJG
	n4b5xfKG+d1ZSrA9y8gcZUvXsQ1pTPrb2ntNQu4gEafcbYq8wb/wVYTuO6STUgsGpKkjgK
	A92DW93VNKQxlFlJxkjpULpOcGAkJwDpgmr9wohl+/3FpDNzMczteV2y421ThuyuGr7uLx
	0EpX3r2ojdnXvtdtjezNeTd73Qv3IgQ7G3Nw9wgUUH1zESStEXu4G2nCWYqRkw==
From: Paulo Alcantara <pc@manguebit.com>
To: Nicolas Baranger <nicolas.baranger@3xo.fr>
Cc: Christoph Hellwig <hch@infradead.org>, hch@lst.de, David Howells
 <dhowells@redhat.com>, netfs@lists.linux.dev, linux-cifs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, Steve French
 <smfrench@gmail.com>, Jeff Layton <jlayton@kernel.org>, Christian Brauner
 <brauner@kernel.org>
Subject: Re: [netfs/cifs - Linux 6.14] loop on file cat + file copy when
 files are on CIFS share
In-Reply-To: <a25811b8d4f245173f672bdfa8f81506@3xo.fr>
References: <10bec2430ed4df68bde10ed95295d093@3xo.fr>
 <35940e6c0ed86fd94468e175061faeac@3xo.fr> <Z-Z95ePf3KQZ2MnB@infradead.org>
 <48685a06c2608b182df3b7a767520c1d@3xo.fr>
 <F89FD4A3-FE54-4DB2-BA08-3BCC8843C60E@manguebit.com>
 <5087f9cb3dc1487423de34725352f57c@3xo.fr>
 <f12973bcf533a40ca7d7ed78846a0a10@manguebit.com>
 <e63e7c7ec32e3014eb758fd6f8679f93@3xo.fr>
 <53697288e2891aea51061c54a2e42595@manguebit.com>
 <bb5f1ed84df1686aebdba5d60ab0e162@3xo.fr>
 <af401afc7e32d9c0eeb6b36da70d2488@3xo.fr>
 <a25811b8d4f245173f672bdfa8f81506@3xo.fr>
Date: Thu, 24 Apr 2025 11:25:26 -0300
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Nicolas,

Thanks for the very detailed information and testing.

Nicolas Baranger <nicolas.baranger@3xo.fr> writes:

> In fact, I think there is somethings wrong:
>
> After a remount, I sucessfully get the good buffers size values in 
> /proc/mounts (those defined in /etc/fstab).
>
> grep cifs /proc/mounts
> //10.0.10.100/FBX24T /mnt/fbx/FBX-24T cifs 
> rw,nosuid,nodev,noexec,relatime,vers=3.1.1,cache=none,upcall_target=app,username=*****,domain=*****,uid=0,noforceuid,gid=0,noforcegid,addr=10.0.10.100,file_mode=0666,dir_mode=0755,iocharset=utf8,soft,nounix,serverino,mapposix,mfsymlinks,reparse=nfs,rsize=4194304,wsize=4194304,bsize=16777216,retrans=1,echo_interval=60,actimeo=1,closetimeo=1 
> 0 0

Interesting.  When you do 'mount -o remount ...' but don't pass rsize=
and wsize=, the client is suppposed to reuse the existing values of
rsize and wsize set in the current superblock.  The above values of
rsize, wsize and bsize are also the default ones in case you don't pass
them at all.

I'll look into that when time allows it.

> But here is what I constat: a 'dd' with a block size smaller than 65536 
> is working fine:
> LANG=en_US.UTF-8
>
> dd if=/dev/urandom of=/mnt/fbx/FBX-24T/dd.test3 bs=65536 status=progress 
> conv=notrunc oflag=direct count=128
> 128+0 records in
> 128+0 records out
> 8388608 bytes (8.4 MB, 8.0 MiB) copied, 0.100398 s, 83.6 MB/s
>
>
>
> But a 'dd' with a block size bigger than 65536 is not working:
> LANG=en_US.UTF-8
>
> dd if=/dev/urandom of=/mnt/fbx/FBX-24T/dd.test3 bs=65537 status=progress 
> conv=notrunc oflag=direct count=128
> dd: error writing '/mnt/fbx/FBX-24T/dd.test3'
> dd: closing output file '/mnt/fbx/FBX-24T/dd.test3': Invalid argument
>
> And kernel report:
> Apr 24 10:01:37 14RV-SERVER.14rv.lan kernel: CIFS: VFS: \\10.0.10.100 
> Error -32 sending data on socket to server

This seems related to unaligned DIO reads and writes.  With O_DIRECT,
the client will set FILE_NO_INTERMEDIATE_BUFFERING when opening the
file, telling the server to not do any buffering when reading from or
writing to the file.  Some servers will fail the read or write request
if the file offset or length isn't a multiple of block size, where the
block size is >= 512 && <= PAGE_SIZE, as specified in MS-FSA 2.1.5.[34].

Since you're passing bs= with a value that is not multiple of block
size, then the server is failing the request with
STATUS_INVALID_PARAMETER as specified in MS-FSA.

I've tested it against Windows Server 2022 and it seems to enforce the
alignment only for DIO reads.  While samba doesn't enforce it at all.

win2k22:

$ dd if=/mnt/1/foo of=/dev/null status=none iflag=direct count=128 bs=65536
$ dd if=/mnt/1/foo of=/dev/null status=none iflag=direct count=128 bs=65537
dd: error reading '/mnt/1/foo': Invalid argument
$ dd if=/mnt/1/foo of=/dev/null status=none iflag=direct count=128 bs=$((65536+512))

$ xfs_io -d -f -c "pread 0 4096" /mnt/1/foo
read 4096/4096 bytes at offset 0
4 KiB, 1 ops; 0.0009 sec (4.260 MiB/sec and 1090.5125 ops/sec)
$ xfs_io -d -f -c "pread 1 4096" /mnt/1/foo
pread: Invalid argument

samba:

$ dd if=/mnt/1/foo of=/dev/null status=none iflag=direct count=128 bs=65536
$ dd if=/mnt/1/foo of=/dev/null status=none iflag=direct count=128 bs=65537
$ dd if=/mnt/1/foo of=/dev/null status=none iflag=direct count=128 bs=$((65536+512))

$ xfs_io -d -f -c "pread 0 4096" /mnt/1/foo
read 4096/4096 bytes at offset 0
4 KiB, 1 ops; 0.0071 sec (557.880 KiB/sec and 139.4700 ops/sec)
$ xfs_io -d -f -c "pread 1 4096" /mnt/1/foo
read 4096/4096 bytes at offset 1
4 KiB, 1 ops; 0.0010 sec (3.864 MiB/sec and 989.1197 ops/sec)

Note that the netfslib fix is for short DIO reads, so this bug is
related to unaligned DIO reads and writes and need to be fixed in the
client.  I'll let you know when I have patches for that.

