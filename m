Return-Path: <linux-fsdevel+bounces-47204-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E281EA9A482
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 09:45:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5850546184D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 07:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EB7A1F790F;
	Thu, 24 Apr 2025 07:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=3xo.fr header.i=@3xo.fr header.b="o88nyfQg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.3xo.fr (mail.3xo.fr [212.129.21.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919491F1927;
	Thu, 24 Apr 2025 07:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.129.21.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745480426; cv=none; b=JA5yENP9+RZrMYgEOrCBJXODRkolFQkelRoVo/IMqh/TdbWsE7+H4/j+TLZu4qID2beblU0ih0TiEBdsJZVHD6aZN1Dkl6l7LkKcAA+DYhG2MrR56FZBBC5JVye6kZe77Nq/A16zE0iAQ12m3tYPudeXUa2QWi6EBIz86/4oWM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745480426; c=relaxed/simple;
	bh=wJzBuNv3LpnWTInF73DPDdf568PiX49EKsvdzlN+VNM=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=hTQwLLKCBthzbjAq4tcso/6l3WzfYrz2tyaiDMnarx8ZxlOOEqgBBp87G8BfTw6kMVkhIc4Xl28Qzo9UYM0YgsUY6m+1qAJIhu9fQg5+c1E0iQDP3rZKKD3SK1KLQ8tVAu2UY0T/T2Pr7+Tlpj32n5ux0un/qtNpzeE9WjPGF6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=3xo.fr; spf=pass smtp.mailfrom=3xo.fr; dkim=pass (2048-bit key) header.d=3xo.fr header.i=@3xo.fr header.b=o88nyfQg; arc=none smtp.client-ip=212.129.21.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=3xo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=3xo.fr
Received: from localhost (mail.3xo.fr [212.129.21.66])
	by mail.3xo.fr (Postfix) with ESMTP id 4616ECB;
	Thu, 24 Apr 2025 09:40:21 +0200 (CEST)
X-Virus-Scanned: Debian amavis at nxo2.3xo.fr
Received: from mail.3xo.fr ([212.129.21.66])
 by localhost (mail.3xo.fr [212.129.21.66]) (amavis, port 10024) with ESMTP
 id H1RaQ-c1-sZu; Thu, 24 Apr 2025 09:40:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.3xo.fr B33EA8D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=3xo.fr; s=3xo;
	t=1745480418; bh=tkMxtFneChkyh6FH2tvBrsB//VGTblVVYgMkNJr9ZRg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=o88nyfQgvhZspqftbeutotYHg7ag/f98EgtlBX4u5ywFKamoDhhB2xAe8/pOJC40Y
	 ghJpjAiFBUQkHUtiILfM/4WQc16ky+ePbgr/s0VSRbkGbKGyRa6YrdCgU3t33brc+Y
	 4v0B95j6b44kNRBTBtvddbUK9vFLLwgTwJ6QjhU3HnrzAe7vj2dOoyd9G0LTD8qNC3
	 dh+e8aGQ95LP0eGCZ4FMdOEBx58CvTwfDObEsRmEWnIgTCsodkw2cWGrD61P5/q1NJ
	 kGVS8Vg9YRtIzyWeXT2ymX2dtPmZqRa+9KdJTfat6CCgETkKPNVMc9B2wrS8v6olY+
	 0+VdMLzZblIeg==
Received: from mail.3xo.fr (mail.3xo.fr [212.129.21.66])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by mail.3xo.fr (Postfix) with ESMTPSA id B33EA8D;
	Thu, 24 Apr 2025 09:40:18 +0200 (CEST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 24 Apr 2025 09:40:18 +0200
From: Nicolas Baranger <nicolas.baranger@3xo.fr>
To: Paulo Alcantara <pc@manguebit.com>
Cc: Christoph Hellwig <hch@infradead.org>, hch@lst.de, David Howells
 <dhowells@redhat.com>, netfs@lists.linux.dev, linux-cifs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, Steve French
 <smfrench@gmail.com>, Jeff Layton <jlayton@kernel.org>, Christian Brauner
 <brauner@kernel.org>
Subject: Re: [netfs/cifs - Linux 6.14] loop on file cat + file copy when files
 are on CIFS share
In-Reply-To: <bb5f1ed84df1686aebdba5d60ab0e162@3xo.fr>
References: <10bec2430ed4df68bde10ed95295d093@3xo.fr>
 <35940e6c0ed86fd94468e175061faeac@3xo.fr> <Z-Z95ePf3KQZ2MnB@infradead.org>
 <48685a06c2608b182df3b7a767520c1d@3xo.fr>
 <F89FD4A3-FE54-4DB2-BA08-3BCC8843C60E@manguebit.com>
 <5087f9cb3dc1487423de34725352f57c@3xo.fr>
 <f12973bcf533a40ca7d7ed78846a0a10@manguebit.com>
 <e63e7c7ec32e3014eb758fd6f8679f93@3xo.fr>
 <53697288e2891aea51061c54a2e42595@manguebit.com>
 <bb5f1ed84df1686aebdba5d60ab0e162@3xo.fr>
Message-ID: <af401afc7e32d9c0eeb6b36da70d2488@3xo.fr>
X-Sender: nicolas.baranger@3xo.fr
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit

Hi Paolo

Thanks again for help.

I'm sorry, I made a mistake in my answer yesterday:

> After a lot of testing, the mounts buffers values: rsize=65536, 
> wsize=65536, bsize=16777216,...

The actual values in /etc/fstab are:
rsize=4194304,wsize=4194304,bsize=16777216

But negociated values in /proc/mounts are:
rsize=65536,wsize=65536,bsize=16777216

And don't know if it's related but I have:
grep -i maxbuf /proc/fs/cifs/DebugData
CIFSMaxBufSize: 16384

I've just force a manual 'mount -o remount' and now I have in 
/proc/mounts the good values (SMB version is 3.1.1).
Where does this behavior comes from ?

After some search, it appears that when the CIFS share is mounted by 
systemd option x-systemd.automount (for example doing 'ls' in the mount 
point directory), negociated values are:
rsize=65536,wsize=65536,bsize=16777216
If I umount / remount manually, the negociated values are those defined 
in /etc/fstab !

Don't know if it's a normal behavior but it is a source of errors / 
mistake and makes troubleshooting performance issues harder

Kind regards
Nicolas



Le 2025-04-23 18:28, Nicolas Baranger a écrit :

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
>> I've noticed that you disabled caching with 'cache=none', is there any
>> particular reason for that?
> 
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
>> Have you also set rsize, wsize and bsize mount options?  If so, why?
> 
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

