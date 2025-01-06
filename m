Return-Path: <linux-fsdevel+bounces-38486-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B19CA0338C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2025 00:50:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E056A3A14D1
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jan 2025 23:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0B671E260D;
	Mon,  6 Jan 2025 23:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pz1HgIx/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0064B1E1025;
	Mon,  6 Jan 2025 23:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736207398; cv=none; b=iL51MlB7xLq0j/SC/OaJ17Np+hDzn5/XAAriM0pjYSK6yVm7EJBMOBJUJ07AzAGR7prtsimKOivVaizJlPaCLHJaD/+bjbSeYntiPvHZqEPYumQW1cEOwjPvqv7Dz06NhjHOJMuWroASA/kvZr/49xcsYxy+42w1ezyPTpoHKh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736207398; c=relaxed/simple;
	bh=fYRywOPmfgHYpX4Q1BeTvWS+5nz1VVw2i6Ft9vmcLg0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JHPfJxW3L85OiIaK7jIEEoUA6UappQV0HoMGIXf8FXTXiVcUkLqxQ+oKEoGqsZa14wda5EgO5NqxYPfEu1ccUuTI+NL5vytg1eMZid1SCVwaAh0tk86jmJ7Io5UUZGzwaA1VbFUtBsg223ZlFi3FGl+K2x7+CLnJ8VR4d38/130=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pz1HgIx/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85698C4CED2;
	Mon,  6 Jan 2025 23:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736207397;
	bh=fYRywOPmfgHYpX4Q1BeTvWS+5nz1VVw2i6Ft9vmcLg0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Pz1HgIx/jedXCAPUL82RtNiwksHXWp3q6+OvjBpNT0gB++f9aETT2Oa7EMKcfUbPk
	 Lu1yj9KwnF1EH8tZWU4AUgftr8+qhEa4jTAdHDLE/JMoDHQIX6D7ORabpGY+0dk2x2
	 jVAobq9swE3ackv6/inGqju+jX48wx8O7xeLatQz1+kGRtY4ymDPekmcd05KVJnD1J
	 XWruXU2QWiNv6nfNTw6SUci+8FPMFJywFNO+GWvkaypmv0TGWnogoQuIXoKv5ECy2/
	 JVsNsBWkA4qK6Ac/vFZEddGFhpdSch606wvVj0CQYhpUlTn3FuwrunFtji9dJao/5o
	 fTgzdhmrOErlg==
Date: Mon, 6 Jan 2025 15:49:56 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Baokun Li <libaokun1@huawei.com>
Cc: Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
	"linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
	Christian Brauner <brauner@kernel.org>, sunyongjian1@huawei.com,
	Yang Erkun <yangerkun@huawei.com>, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: Re: [BUG REPORT] ext4: =?utf-8?B?4oCcZXJy?=
 =?utf-8?Q?ors=3Dremount-ro=E2=80=9D_has_become_=E2=80=9Cerrors=3Dshutdown?=
 =?utf-8?B?4oCdPw==?=
Message-ID: <20250106234956.GM6174@frogsfrogsfrogs>
References: <22d652f6-cb3c-43f5-b2fe-0a4bb6516a04@huawei.com>
 <z52ea53du2k66du24ju4yetqm72e6pvtcbwkrjf4oomw2feffq@355vymdndrxn>
 <17108cad-efa8-46b4-a320-70d7b696f75b@huawei.com>
 <umpsdxhd2dz6kgdttpm27tigrb3ytvpf3y3v73ugavgh4b5cuj@dnacioqwq4qq>
 <20250103153517.GB1284777@mit.edu>
 <20250103155406.GC1284777@mit.edu>
 <5eb2ad64-c6ea-45f8-9ba1-7de5c68d59aa@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5eb2ad64-c6ea-45f8-9ba1-7de5c68d59aa@huawei.com>

On Sat, Jan 04, 2025 at 10:41:28AM +0800, Baokun Li wrote:
> Hi Ted,
> 
> On 2025/1/3 23:54, Theodore Ts'o wrote:
> > On Fri, Jan 03, 2025 at 10:35:17AM -0500, Theodore Ts'o wrote:
> > > I don't see how setting the shutdown flag causes reads to fail.  That
> > > was true in an early version of the ext4 patch which implemented
> > > shutdown support, but one of the XFS developers (I don't remember if
> > > it was Dave or Cristoph) objected because XFS did not cause the
> > > read_pages function to fail.  Are you seeing this with an upstream
> > > kernel, or with a patched kernel?  The upstream kernel does *not* have
> > > the check in ext4_readpages() or ext4_read_folio() (post folio
> > > conversion).
> > OK, that's weird.  Testing on 6.13-rc4, I don't see the problem simulating an ext4 error:
> > 
> > root@kvm-xfstests:~# mke2fs -t ext4 -Fq /dev/vdc
> > /dev/vdc contains a ext4 file system
> > 	last mounted on /vdc on Fri Jan  3 10:38:21 2025
> > root@kvm-xfstests:~# mount -t ext4 -o errors=continue /dev/vdc /vdc
> We are discussing "errors=remount-ro," as the title states, not the
> continue mode. The key code leading to the behavior change is as follows,
> therefore the continue mode is not affected.

Hmm.  On the one hand, XFS has generally returned EIO (or ESHUTDOWN in a
couple of specialty cases) when the fs has been shut down.

OTOH XFS also doesn't have errors=remount-ro; it just dies, which I
think has been its behavior for a long time.

To me, it doesn't sound unreasonable for ext* to allow reads after a
shutdown when errors=remount-ro since it's always had that behavior.

Bonus Q: do you want an errors=fail variant to shut things down fast?

--D

> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -657,7 +657,7 @@ static void ext4_handle_error(struct super_block *sb,
> bool force_ro, int error,
>                 WARN_ON_ONCE(1);
> 
>         if (!continue_fs && !sb_rdonly(sb)) {
> -               ext4_set_mount_flag(sb, EXT4_MF_FS_ABORTED);
> +               set_bit(EXT4_FLAGS_SHUTDOWN, &EXT4_SB(sb)->s_ext4_flags);
>                 if (journal)
>                         jbd2_journal_abort(journal, -EIO);
>         }
> 
> See the end for problem reproduction.
> 
> > [   24.780982] EXT4-fs (vdc): mounted filesystem f8595206-fe57-486c-80dd-48b03d41ebdb r/w with ordered data mode. Quota mode: none.
> > root@kvm-xfstests:~# cp /etc/motd /vdc/motd
> > root@kvm-xfstests:~# echo testing > /sys/fs/ext4/vdc/trigger_fs_error
> > [   42.943141] EXT4-fs error (device vdc): trigger_test_error:129: comm bash: testing
> > root@kvm-xfstests:~# cat /vdc/motd
> > 
> > The programs included with the Debian GNU/Linux system are free software;
> > the exact distribution terms for each program are described in the
> > individual files in /usr/share/doc/*/copyright.
> > 
> > Debian GNU/Linux comes with ABSOLUTELY NO WARRANTY, to the extent
> > permitted by applicable law.
> > root@kvm-xfstests:~#
> > 
> > 
> > HOWEVER, testing with shutdown ioctl, both ext4 and xfs are failing with EIO:
> Yes, this is as expected.
> > root@kvm-xfstests:~# mount /dev/vdc /vdc
> > [    7.969168] XFS (vdc): Mounting V5 Filesystem 7834ea96-eab0-46c5-9b18-c8f054fa9cf4
> > [    7.978539] XFS (vdc): Ending clean mount
> > root@kvm-xfstests:~# cp /etc/motd /vdc
> > root@kvm-xfstests:~# /root/xfstests/src/godown -v /vdc
> > Opening "/vdc"
> > Calling XFS_IOC_GOINGDOWN
> > [   29.354609] XFS (vdc): User initiated shutdown received.
> > [   29.356123] XFS (vdc): Log I/O Error (0x6) detected at xfs_fs_goingdown+0x55/0xb0 (fs/xfs/xfs_fsops.c:452).  Shutting down filesystem.
> > [   29.357092] XFS (vdc): Please unmount the filesystem and rectify the problem(s)
> > root@kvm-xfstests:~# cat /vdc/motd
> > cat: /vdc/motd: Input/output error
> > root@kvm-xfstests:~#
> > 
> > So I take back what I said earlier, but I am a bit confused why it
> > worked after simulating an file system error using "echo testing >
> > /sys/fs/ext4/vdc/trigger_fs_error".
> > 
> It's because "errors=remount-ro" wasn't used when mounting...
> 
> Here's a replication:
> 
> root@kvm-xfstests:~# mount -o errors=remount-ro /dev/vdc /mnt/test
> [  115.731007] EXT4-fs (vdc): mounted filesystem
> 0838f08f-c04e-440c-a9a5-417677efb03e r/w with ordered data mode. Quota mode:
> none.
> root@kvm-xfstests:~# echo test > /mnt/test/file
> root@kvm-xfstests:~# cat /mnt/test/file
> test
> root@kvm-xfstests:~# echo 1 > /sys/fs/ext4/vdc/trigger_fs_error
> [  131.537649] EXT4-fs error (device vdc): trigger_test_error:129: comm
> bash: 1
> [  131.538226] Aborting journal on device vdc-8.
> [  131.538844] EXT4-fs (vdc): Remounting filesystem read-only
> root@kvm-xfstests:~# cat /mnt/test/file
> cat: /mnt/test/file: Input/output error
> root@kvm-xfstests:~# uname -a
> Linux kvm-xfstests 6.13.0-rc4-xfstests-g6cfe3548f8f5-dirty #284 SMP
> PREEMPT_DYNAMIC Fri Dec 27 10:39:02 CST 2024 x86_64 GNU/Linux
> 
> 
> Regards,
> Baokun
> 
> 

