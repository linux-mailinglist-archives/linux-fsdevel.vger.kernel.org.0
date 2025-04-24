Return-Path: <linux-fsdevel+bounces-47208-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD8FBA9A664
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 10:40:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FD4E1B85DAD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 08:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C14FE214A66;
	Thu, 24 Apr 2025 08:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=3xo.fr header.i=@3xo.fr header.b="BSXE0LCn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.3xo.fr (mail.3xo.fr [212.129.21.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 523DE21480E;
	Thu, 24 Apr 2025 08:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.129.21.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745483967; cv=none; b=ZezV1NFZCPAJ52fZddnZVckiiCZsNwRjda+6LnDOcsy3M8Sxjt5VmZ5F5Fwa8F3mmkeInwcKyEAI4zEIv9EvEu+5ar7CV5I1EgjauM0DoLxdyTfZWpEgZNE1OKH25TcN6TqdQruN0lfy0AN11rIlkNjSS9ZhI61+/lPX809cssY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745483967; c=relaxed/simple;
	bh=Av/34v7UChi4JNbIEEUnlc5vVjqyHKU5NzPvwgiuGAw=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=em+f32gF2jswfEInithsa3Uirsi6C16B6CdLip3hre7FgZR3AsFKbnfSm37O6gXzkdJVqceUT0KPQIK2kNV0xswwY8o+YN7gUp7kHPOuaPcoN/7rWQ62Gp6Wp/5mMDjJReySXxAR60wDL+7lIelyAWVp/vYvz7GnO16asQ71ssk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=3xo.fr; spf=pass smtp.mailfrom=3xo.fr; dkim=pass (2048-bit key) header.d=3xo.fr header.i=@3xo.fr header.b=BSXE0LCn; arc=none smtp.client-ip=212.129.21.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=3xo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=3xo.fr
Received: from localhost (mail.3xo.fr [212.129.21.66])
	by mail.3xo.fr (Postfix) with ESMTP id 9B419CE;
	Thu, 24 Apr 2025 10:39:23 +0200 (CEST)
X-Virus-Scanned: Debian amavis at nxo2.3xo.fr
Received: from mail.3xo.fr ([212.129.21.66])
 by localhost (mail.3xo.fr [212.129.21.66]) (amavis, port 10024) with ESMTP
 id zLcdfzqgOw0z; Thu, 24 Apr 2025 10:39:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.3xo.fr 2E902CD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=3xo.fr; s=3xo;
	t=1745483961; bh=6BQjjR0DSeE+okd6TA+xue8mPzKXSf2VzW3YBPfOwOk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BSXE0LCnXnQyHnDg2fYkaw0qS4RuOkwU0um0UoTDeaK0TkxMRr3hI3c2WqWsGopJ0
	 DTMF6kN7gNuVRPPQzDWfQfKjPThvXBRd3htJv/3sIwHlDD5ixoMQIX8P8/79QiSLrH
	 NSFyOO4uRSrBL8Jgb2y6vvSjfo8UHkEXcrDro/w2qnTKJEKTmkrmtZB6aZChYYTf9z
	 Llca8Ow8dG+CE3C2o0/TVDFXBgSdz3eVhfGMbEmZATVGsVfwAGLXAKfsoEGys5PfVu
	 0lv3f1iFvysETZu8SnpRkS0ZsIY4xxviP32jlPZnvhf2modVnHARI78QPK/iRtK/Fb
	 Hh3EyMyThFq2A==
Received: from mail.3xo.fr (mail.3xo.fr [212.129.21.66])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by mail.3xo.fr (Postfix) with ESMTPSA id 2E902CD;
	Thu, 24 Apr 2025 10:39:21 +0200 (CEST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 24 Apr 2025 10:39:21 +0200
From: Nicolas Baranger <nicolas.baranger@3xo.fr>
To: Paulo Alcantara <pc@manguebit.com>
Cc: Christoph Hellwig <hch@infradead.org>, hch@lst.de, David Howells
 <dhowells@redhat.com>, netfs@lists.linux.dev, linux-cifs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, Steve French
 <smfrench@gmail.com>, Jeff Layton <jlayton@kernel.org>, Christian Brauner
 <brauner@kernel.org>
Subject: Re: [netfs/cifs - Linux 6.14] loop on file cat + file copy when files
 are on CIFS share
In-Reply-To: <af401afc7e32d9c0eeb6b36da70d2488@3xo.fr>
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
Message-ID: <a25811b8d4f245173f672bdfa8f81506@3xo.fr>
X-Sender: nicolas.baranger@3xo.fr
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit

[Resending mail in plain text version, sorry !]

Hi Paolo

Thanks again for help and sorry for this new mail but I think it could 
be relevant

In fact, I think there is somethings wrong:

After a remount, I sucessfully get the good buffers size values in 
/proc/mounts (those defined in /etc/fstab).

grep cifs /proc/mounts
//10.0.10.100/FBX24T /mnt/fbx/FBX-24T cifs 
rw,nosuid,nodev,noexec,relatime,vers=3.1.1,cache=none,upcall_target=app,username=*****,domain=*****,uid=0,noforceuid,gid=0,noforcegid,addr=10.0.10.100,file_mode=0666,dir_mode=0755,iocharset=utf8,soft,nounix,serverino,mapposix,mfsymlinks,reparse=nfs,rsize=4194304,wsize=4194304,bsize=16777216,retrans=1,echo_interval=60,actimeo=1,closetimeo=1 
0 0

uname -r
6.13.8.1-ast-nba0-amd64



But here is what I constat: a 'dd' with a block size smaller than 65536 
is working fine:
LANG=en_US.UTF-8

dd if=/dev/urandom of=/mnt/fbx/FBX-24T/dd.test3 bs=65536 status=progress 
conv=notrunc oflag=direct count=128
128+0 records in
128+0 records out
8388608 bytes (8.4 MB, 8.0 MiB) copied, 0.100398 s, 83.6 MB/s



But a 'dd' with a block size bigger than 65536 is not working:
LANG=en_US.UTF-8

dd if=/dev/urandom of=/mnt/fbx/FBX-24T/dd.test3 bs=65537 status=progress 
conv=notrunc oflag=direct count=128
dd: error writing '/mnt/fbx/FBX-24T/dd.test3'
dd: closing output file '/mnt/fbx/FBX-24T/dd.test3': Invalid argument

And kernel report:
Apr 24 10:01:37 14RV-SERVER.14rv.lan kernel: CIFS: VFS: \\10.0.10.100 
Error -32 sending data on socket to server



If I let systemd option x-systemd.automount mount the share it configure 
/proc/mount with rsize=65536,wsize=65536 and I'm able to send datas 
whatever is the size of each packet of datas in the transfer stream.
Example:

grep cifs /proc/mounts
//10.0.10.100/FBX24T /mnt/fbx/FBX-24T cifs 
rw,nosuid,nodev,noexec,relatime,vers=3.1.1,cache=none,upcall_target=app,username=*****,domain=*****,uid=0,noforceuid,gid=0,noforcegid,addr=10.0.10.100,file_mode=0666,dir_mode=0755,iocharset=utf8,soft,nounix,serverino,mapposix,mfsymlinks,reparse=nfs,rsize=65536,wsize=65536,bsize=16777216,retrans=1,echo_interval=60,actimeo=1,closetimeo=1 
0 0

dd if=/dev/urandom of=/mnt/fbx/FBX-24T/dd.test3 bs=64M status=progress 
conv=notrunc oflag=direct count=128
8589934592 bytes (8.6 GB, 8.0 GiB) copied, 42 s, 203 MB/s
128+0 records in
128+0 records out
8589934592 bytes (8.6 GB, 8.0 GiB) copied, 42.2399 s, 203 MB/s


To conclude, if I force an fstab value bigger than 65536 to be 
concidered and used (visible in /proc/mounts), transfer failed if I 
don't stream the transfer in packets of maximum 65536 bytes and if I let 
systemd configure rsize and wsize at 65536, I can stream the transfer in 
blocks of all size and specially of bigger size (*1024 in the example)


Let me know if you need further testing

Kind regards
Nicolas




Le 2025-04-24 09:40, Nicolas Baranger a écrit :

> Hi Paolo
> 
> Thanks again for help.
> 
> I'm sorry, I made a mistake in my answer yesterday:
> 
>> After a lot of testing, the mounts buffers values: rsize=65536, 
>> wsize=65536, bsize=16777216,...
> 
> The actual values in /etc/fstab are:
> rsize=4194304,wsize=4194304,bsize=16777216
> 
> But negociated values in /proc/mounts are:
> rsize=65536,wsize=65536,bsize=16777216
> 
> And don't know if it's related but I have:
> grep -i maxbuf /proc/fs/cifs/DebugData
> CIFSMaxBufSize: 16384
> 
> I've just force a manual 'mount -o remount' and now I have in 
> /proc/mounts the good values (SMB version is 3.1.1).
> Where does this behavior comes from ?
> 
> After some search, it appears that when the CIFS share is mounted by 
> systemd option x-systemd.automount (for example doing 'ls' in the mount 
> point directory), negociated values are:
> rsize=65536,wsize=65536,bsize=16777216
> If I umount / remount manually, the negociated values are those defined 
> in /etc/fstab !
> 
> Don't know if it's a normal behavior but it is a source of errors / 
> mistake and makes troubleshooting performance issues harder
> 
> Kind regards
> Nicolas
> 
> Le 2025-04-23 18:28, Nicolas Baranger a écrit :
> 
> Hi Paolo
> 
> Thanks for answer, all explanations and help
> 
> I'm happy you found those 2 bugs and starting to patch them.
> Reading your answer, I want to remember that I already found a bug in 
> cifs DIO starting from Linux 6.10 (when cifs statring to use netfs to 
> do its IO) and it was fixed by David and Christoph
> full story here: 
> https://lore.kernel.org/all/14271ed82a5be7fcc5ceea5f68a10bbd@manguebit.com/T/
> 
> I've noticed that you disabled caching with 'cache=none', is there any
> particular reason for that?
> Yes, it's related with the precedent use case describes in the other 
> bug:
> For backuping servers, I've got some KSMBD cifs share on which there 
> are some 4TB+ sparses files (back-files) which are LUKS + BTRFS 
> formatted.
> The cifs share is mounted on servers and each server mount its own 
> back-file as a block device and make its backup inside this crypted 
> disk file
> Due to performance issues, it is required that the disk files are using 
> 4KB block and are mounted in servers using losetup DIO option (+ 4K 
> block size options)
> When I use something else than 'cache=none', sometimes the BTRFS 
> filesystem on the back file get corrupted and I also need to mount the 
> BTRFS filesystem with 'space_cache=v2' to avoid filesystem corruption
> 
> Have you also set rsize, wsize and bsize mount options?  If so, why?
> After a lot of testing, the mounts buffers values: rsize=65536, 
> wsize=65536, bsize=16777216, are the one which provide the best 
> performances with no corruptions on the back-file filesystem and with 
> these options a ~2TB backup is possible in few hours during  timeframe 
> ~1 -> ~5 AM each night
> 
> For me it's important that kernel async DIO on netfs continue to work 
> as it's used by all my production backup system (transfer speed ratio 
> compared with and without DIO is between 10 to 25)
> 
> I will try the patch "[PATCH] netfs: Fix setting of transferred bytes 
> with short DIO reads", thanks
> 
> Let me know if you need further explanations,
> 
> Kind regards
> Nicolas Baranger
> 
> Le 2025-04-22 01:45, Paulo Alcantara a écrit :
> 
> Nicolas Baranger <nicolas.baranger@3xo.fr> writes:
> 
> If you need more traces or details on (both?) issues :
> 
> - 1) infinite loop issue during 'cat' or 'copy' since Linux 6.14.0
> 
> - 2) (don't know if it's related) the very high number of several bytes
> TCP packets transmitted in SMB transaction (more than a hundred) for a 
> 5
> bytes file transfert under Linux 6.13.8
> According to your mount options and network traces, cat(1) is 
> attempting
> to read 16M from 'toto' file, in which case netfslib will create 256
> subrequests to handle 64K (rsize=65536) reads from 'toto' file.
> 
> The first 64K read at offset 0 succeeds and server returns 5 bytes, the
> client then sets NETFS_SREQ_HIT_EOF to indicate that this subrequest 
> hit
> the EOF.  The next subrequests will still be processed by netfslib and
> sent to the server, but they all fail with STATUS_END_OF_FILE.
> 
> So, the problem is with short DIO reads in netfslib that are not being
> handled correctly.  It is returning a fixed number of bytes read to
> every read(2) call in your cat command, 16711680 bytes which is the
> offset of last subrequest.  This will make cat(1) retry forever as
> netfslib is failing to return the correct number of bytes read,
> including EOF.
> 
> While testing a potential fix, I also found other problems with DIO in
> cifs.ko, so I'm working with Dave to get the proper fixes for both
> netfslib and cifs.ko.
> 
> I've noticed that you disabled caching with 'cache=none', is there any
> particular reason for that?
> 
> Have you also set rsize, wsize and bsize mount options?  If so, why?
> 
> If you want to keep 'cache=none', then a possible workaround for you
> would be making rsize and wsize always greater than bsize.  The default
> values (rsize=4194304,wsize=4194304,bsize=1048576) would do it.

