Return-Path: <linux-fsdevel+bounces-46861-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0BE2A959DD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 01:45:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26335170086
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Apr 2025 23:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 002BB22F392;
	Mon, 21 Apr 2025 23:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manguebit.com header.i=@manguebit.com header.b="VZKCxIE1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx.manguebit.com (mx.manguebit.com [167.235.159.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE35126BF1;
	Mon, 21 Apr 2025 23:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.235.159.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745279118; cv=none; b=ciEVIKNDgw5I2fIEF9FdJbXRPIowNLocXYmunw2ho4STq49Z0MFparfB1APbWHsvr8BnpYaZ5bIkmcgXJ0IRtqNQr4QoRvG0BBEZl5ys8njYv51LVYq6ySoSlFm9bbjPn88PxkXTNp9TbmFH+li9kyKNrc0r/LYddmkK/Kw4QG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745279118; c=relaxed/simple;
	bh=dj+7ywLfjANsmePgmSvClDrZkt4qpwdzzeGNtOFPhn8=;
	h=Message-ID:From:To:Cc:Subject:In-Reply-To:References:Date:
	 MIME-Version:Content-Type; b=XNkT7B2WmDlP9CAF6OjXCZ7azJslZh+RAHi0nbg1MizfkgWYyhWyFfYc3SkLZq5Pq+2vBq7VJNo857P2Yym6WRCijEgl9h00XFFu5njzbIYdMdIAfC8AdNW3YFt9XbU0zF6jYlahub4IsV1rKzpPysb4AMTrzB2luip930uk37Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manguebit.com; spf=pass smtp.mailfrom=manguebit.com; dkim=pass (2048-bit key) header.d=manguebit.com header.i=@manguebit.com header.b=VZKCxIE1; arc=none smtp.client-ip=167.235.159.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manguebit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manguebit.com
Message-ID: <53697288e2891aea51061c54a2e42595@manguebit.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manguebit.com;
	s=dkim; t=1745279107;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9o5XLEyuOIwgGpG/sATH1xHXsQN9/52ZRpOOGo34RIw=;
	b=VZKCxIE1ZNfdou1GVm8PI3ljYZk/A/QjSLSE3zHVyhL8+KBYNrGIumKFDzRzB8h0F+Os8U
	FOEVGPDmKZrfYLSZjAqM+X/FSBWOuh50Zx4LMlE/AkfQksO7iqk9K0MZKyxIDtejCDckRa
	RU+ZSx0cY6vuemq8cdUYQgTRhgd8UF6NCik0+28Ra3rfMS+MI3Pnr7eRfmPwgCRbS42DzT
	ZqO+UOIoB81zUvdfvKUj6vMB5eAc1hnfv3akeUTFqxYW4DW5bEw7hnRwRrJ7ieQqbIqDIN
	d7p37pZNhrODOt31nxZDuHUFyACOWmLBR2FLdRSTHC6bNo111HeHSsEkdsDvlQ==
From: Paulo Alcantara <pc@manguebit.com>
To: Nicolas Baranger <nicolas.baranger@3xo.fr>
Cc: Christoph Hellwig <hch@infradead.org>, hch@lst.de, David Howells
 <dhowells@redhat.com>, netfs@lists.linux.dev, linux-cifs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, Steve French
 <smfrench@gmail.com>, Jeff Layton <jlayton@kernel.org>, Christian Brauner
 <brauner@kernel.org>
Subject: Re: [netfs/cifs - Linux 6.14] loop on file cat + file copy when
 files are on CIFS share
In-Reply-To: <e63e7c7ec32e3014eb758fd6f8679f93@3xo.fr>
References: <10bec2430ed4df68bde10ed95295d093@3xo.fr>
 <35940e6c0ed86fd94468e175061faeac@3xo.fr> <Z-Z95ePf3KQZ2MnB@infradead.org>
 <48685a06c2608b182df3b7a767520c1d@3xo.fr>
 <F89FD4A3-FE54-4DB2-BA08-3BCC8843C60E@manguebit.com>
 <5087f9cb3dc1487423de34725352f57c@3xo.fr>
 <f12973bcf533a40ca7d7ed78846a0a10@manguebit.com>
 <e63e7c7ec32e3014eb758fd6f8679f93@3xo.fr>
Date: Mon, 21 Apr 2025 20:45:04 -0300
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Nicolas Baranger <nicolas.baranger@3xo.fr> writes:

> If you need more traces or details on (both?) issues :
>
> - 1) infinite loop issue during 'cat' or 'copy' since Linux 6.14.0
>
> - 2) (don't know if it's related) the very high number of several bytes 
> TCP packets transmitted in SMB transaction (more than a hundred) for a 5 
> bytes file transfert under Linux 6.13.8

According to your mount options and network traces, cat(1) is attempting
to read 16M from 'toto' file, in which case netfslib will create 256
subrequests to handle 64K (rsize=65536) reads from 'toto' file.

The first 64K read at offset 0 succeeds and server returns 5 bytes, the
client then sets NETFS_SREQ_HIT_EOF to indicate that this subrequest hit
the EOF.  The next subrequests will still be processed by netfslib and
sent to the server, but they all fail with STATUS_END_OF_FILE.

So, the problem is with short DIO reads in netfslib that are not being
handled correctly.  It is returning a fixed number of bytes read to
every read(2) call in your cat command, 16711680 bytes which is the
offset of last subrequest.  This will make cat(1) retry forever as
netfslib is failing to return the correct number of bytes read,
including EOF.

While testing a potential fix, I also found other problems with DIO in
cifs.ko, so I'm working with Dave to get the proper fixes for both
netfslib and cifs.ko.

I've noticed that you disabled caching with 'cache=none', is there any
particular reason for that?

Have you also set rsize, wsize and bsize mount options?  If so, why?

If you want to keep 'cache=none', then a possible workaround for you
would be making rsize and wsize always greater than bsize.  The default
values (rsize=4194304,wsize=4194304,bsize=1048576) would do it.

