Return-Path: <linux-fsdevel+bounces-38368-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53558A00BBD
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Jan 2025 16:56:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AF223A44D3
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Jan 2025 15:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08C511FBC96;
	Fri,  3 Jan 2025 15:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="Dyf+W8Rg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F971AB530
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 Jan 2025 15:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735919793; cv=none; b=uCHgo98XwI+8Y+BKkSDlXf7LEqXaJDY7df7IGCRDEbcfjSsBrJLIah/0z54MpArpnDWTWvwfX//km7b+Af+fH3T0CjBiUH/ntkc7UDZ0P6FRysFRge5Ty+7tUaTTuYoxXIhhGOgOadUw5RbSdfC6Tt5bnFmYNAnWI8rZpUlHnYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735919793; c=relaxed/simple;
	bh=r0+x8oxV4BM9H7bMcWQfG09+gWSKRSbs49MsCxervZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BqH7lmWd03ZqhmIVTgI+Gc+s0cHoYoE7ormQ0nPaX+pIKNzdG0Lc6E6/SZrRqXRjIDbd3Rzod4UvSWml0cSqMpK0StuBpNcsvOIHwkv9DTixUuSPD4cuO/bjtiJ5UXjGmj2GCdFx7Cs7RZ1lmNK5K6vqAf0FkRXBfM8f6pQSyFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=Dyf+W8Rg; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-117-149.bstnma.fios.verizon.net [173.48.117.149])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 503Fs6kn025324
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 3 Jan 2025 10:54:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1735919649; bh=gmFo+jASjnj0KYMIoZp5J7FWX3jrWJsWaGvpfid9J2w=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=Dyf+W8Rg2VrT2f58IzoUmTroQEQWBN6ifglHCog1KYcV6ulJf7IpIWU5e06ARk1T4
	 NZGjF9rFs1JEOSoc8aB9ICKCRusoFbBXFZO3wLFDPoTjrnjMYdhKXTlzDIMs8Wv2Ak
	 eAARWuduoMKFZmk6eX+cjVn1VPD2D7TSZc/6bh0vATR4B5QFKhXY5uBpePaNUS5xEJ
	 bTfkywLXE2lndw8lS3vQBAaPoYh8ANLdVs5sxGSELJ+uuT2eaDrDa3p6bT/Zs30kLb
	 6DZygeOVoM39zpCkeK0SSLOtXAeEc0CN4WttEMje2xaiJTq178TIfa7toYiOw1NDKr
	 VS2mxpdKQj4MA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 7A3E715C0113; Fri, 03 Jan 2025 10:54:06 -0500 (EST)
Date: Fri, 3 Jan 2025 10:54:06 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Jan Kara <jack@suse.cz>
Cc: Baokun Li <libaokun1@huawei.com>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        Christian Brauner <brauner@kernel.org>, sunyongjian1@huawei.com,
        Yang Erkun <yangerkun@huawei.com>, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org
Subject: Re: [BUG REPORT] ext4: =?utf-8?B?4oCcZXJy?=
 =?utf-8?Q?ors=3Dremount-ro=E2=80=9D_has_become_=E2=80=9Cerrors=3Dshutdown?=
 =?utf-8?B?4oCdPw==?=
Message-ID: <20250103155406.GC1284777@mit.edu>
References: <22d652f6-cb3c-43f5-b2fe-0a4bb6516a04@huawei.com>
 <z52ea53du2k66du24ju4yetqm72e6pvtcbwkrjf4oomw2feffq@355vymdndrxn>
 <17108cad-efa8-46b4-a320-70d7b696f75b@huawei.com>
 <umpsdxhd2dz6kgdttpm27tigrb3ytvpf3y3v73ugavgh4b5cuj@dnacioqwq4qq>
 <20250103153517.GB1284777@mit.edu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250103153517.GB1284777@mit.edu>

On Fri, Jan 03, 2025 at 10:35:17AM -0500, Theodore Ts'o wrote:
> I don't see how setting the shutdown flag causes reads to fail.  That
> was true in an early version of the ext4 patch which implemented
> shutdown support, but one of the XFS developers (I don't remember if
> it was Dave or Cristoph) objected because XFS did not cause the
> read_pages function to fail.  Are you seeing this with an upstream
> kernel, or with a patched kernel?  The upstream kernel does *not* have
> the check in ext4_readpages() or ext4_read_folio() (post folio
> conversion).

OK, that's weird.  Testing on 6.13-rc4, I don't see the problem simulating an ext4 error:

root@kvm-xfstests:~# mke2fs -t ext4 -Fq /dev/vdc
/dev/vdc contains a ext4 file system
	last mounted on /vdc on Fri Jan  3 10:38:21 2025
root@kvm-xfstests:~# mount -t ext4 -o errors=continue /dev/vdc /vdc
[   24.780982] EXT4-fs (vdc): mounted filesystem f8595206-fe57-486c-80dd-48b03d41ebdb r/w with ordered data mode. Quota mode: none.
root@kvm-xfstests:~# cp /etc/motd /vdc/motd
root@kvm-xfstests:~# echo testing > /sys/fs/ext4/vdc/trigger_fs_error 
[   42.943141] EXT4-fs error (device vdc): trigger_test_error:129: comm bash: testing
root@kvm-xfstests:~# cat /vdc/motd 

The programs included with the Debian GNU/Linux system are free software;
the exact distribution terms for each program are described in the
individual files in /usr/share/doc/*/copyright.

Debian GNU/Linux comes with ABSOLUTELY NO WARRANTY, to the extent
permitted by applicable law.
root@kvm-xfstests:~# 


HOWEVER, testing with shutdown ioctl, both ext4 and xfs are failing with EIO:

root@kvm-xfstests:~# mount /dev/vdc /vdc
[    7.969168] XFS (vdc): Mounting V5 Filesystem 7834ea96-eab0-46c5-9b18-c8f054fa9cf4
[    7.978539] XFS (vdc): Ending clean mount
root@kvm-xfstests:~# cp /etc/motd /vdc
root@kvm-xfstests:~# /root/xfstests/src/godown -v /vdc
Opening "/vdc"
Calling XFS_IOC_GOINGDOWN
[   29.354609] XFS (vdc): User initiated shutdown received.
[   29.356123] XFS (vdc): Log I/O Error (0x6) detected at xfs_fs_goingdown+0x55/0xb0 (fs/xfs/xfs_fsops.c:452).  Shutting down filesystem.
[   29.357092] XFS (vdc): Please unmount the filesystem and rectify the problem(s)
root@kvm-xfstests:~# cat /vdc/motd
cat: /vdc/motd: Input/output error
root@kvm-xfstests:~#

So I take back what I said earlier, but I am a bit confused why it
worked after simulating an file system error using "echo testing >
/sys/fs/ext4/vdc/trigger_fs_error".

						- Ted

