Return-Path: <linux-fsdevel+bounces-45991-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF4F9A80EDA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Apr 2025 16:51:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CCEF37AFAB7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Apr 2025 14:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBDED1EBA03;
	Tue,  8 Apr 2025 14:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yb1uNjcl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA141B6CE5;
	Tue,  8 Apr 2025 14:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744123854; cv=none; b=A2UA8JcsjYe1iWrNxsx3tJ8Kjp4XImxol6FoTI5B18xkA1z4WWLKyqvSZxvzYSU4AAYFzHaZxTXZVssaubGXrglQV4BLq8msISvrQtB0VMZsrwoQLuWpB8RajYV5W2eN+w6bsZ20ojXIGs7MPkCGnpVwarr8u5tHhWlvow9rgb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744123854; c=relaxed/simple;
	bh=F1gXfDTkprcTVTuQ1eClCfByLT07tIDnQSkinFWdSag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qClfc+v1KNeaqqCYok9GWaEwRqEA70eTZtPCcZ4SMg25dtaKkgN9t2XQXZXLWQUWquASUqlD8OFod8JTAW9XNWfk2gUOj/lguc3y0R9v7zQa+pB0A8XqHhrQFwDw8Uww2Nz5sKz3GmWr0iGH1TpNU3gdjsgJZ9zirJmS4RtIRDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yb1uNjcl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEFAAC4CEE5;
	Tue,  8 Apr 2025 14:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744123853;
	bh=F1gXfDTkprcTVTuQ1eClCfByLT07tIDnQSkinFWdSag=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Yb1uNjclOMw/7/4tbGQjBfBRgfbioiToBykUskc2CHJlW490ftj23eQdN6rxxIIuY
	 fUkfXMB52HKOnOJByUOhyo18QqdkGptlSXi10WUetNcuX4ACT/dJbzkaycvG02ka0p
	 OjgyxDCa1bfEtkSzZTP6XBqs6UclD15OBCp4u95nh9+TL7KAAXoPFeWw2useLNgn+T
	 O034SUJD2Af1O9UZIbM+CT8Rl1bJlFvgLr3RAqahoH3DuWOw8D9l8ARNPC+n0DKoxc
	 y8lxEYvTvKdRYJqa49Y3XDu3HVn3Wz7lSMiuB2WaAJr/YXKyRioEwfHjrFNVJ28KE1
	 aL8TBcQHVnyiA==
Date: Tue, 8 Apr 2025 07:50:53 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Richard Weinberger <richard.weinberger@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Cengiz Can <cengiz.can@canonical.com>,
	Attila Szasz <szasza.contact@gmail.com>,
	Greg KH <gregkh@linuxfoundation.org>,
	Salvatore Bonaccorso <carnil@debian.org>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	lvc-patches@linuxtesting.org, dutyrok@altlinux.org,
	syzbot+5f3a973ed3dfb85a6683@syzkaller.appspotmail.com,
	stable@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] hfs/hfsplus: fix slab-out-of-bounds in hfs_bnode_read_key
Message-ID: <20250408145053.GJ6266@frogsfrogsfrogs>
References: <20241019191303.24048-1-kovalev@altlinux.org>
 <Z9xsx-w4YCBuYjx5@eldamar.lan>
 <d4mpuomgxqi7xppaewlpey6thec7h2fk4sm2iktqsx6bhwu5ph@ctkjksxmkgne>
 <2025032402-jam-immovable-2d57@gregkh>
 <7qi6est65ekz4kjktvmsbmywpo5n2kla2m3whbvq4dsckdcyst@e646jwjazvqh>
 <2025032404-important-average-9346@gregkh>
 <dzmprnddbx2qaukb7ukr5ngdx6ydwxynaq6ctxakem43yrczqb@y7dg7kzxsorc>
 <20250407-biegung-furor-e7313ca9d712@brauner>
 <20250407190814.GB6258@frogsfrogsfrogs>
 <CAFLxGvxH=4rHWu-44LSuWaGA_OB0FU0Eq4fedVTj3tf2D3NgYQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFLxGvxH=4rHWu-44LSuWaGA_OB0FU0Eq4fedVTj3tf2D3NgYQ@mail.gmail.com>

On Tue, Apr 08, 2025 at 12:11:36PM +0200, Richard Weinberger wrote:
> On Mon, Apr 7, 2025 at 9:08 PM Darrick J. Wong <djwong@kernel.org> wrote:
> > It's also the default policy on Debian 12 and RHEL9 that if you're
> > logged into the GUI, any program can run:
> >
> > $ truncate -s 3g /tmp/a
> > $ mkfs.hfs /tmp/a
> > $ <write evil stuff on /tmp/a>
> > $ udisksctl loop-setup -f /tmp/a
> > $ udisksctl mount -b /dev/loopX
> >
> > and the user never sees a prompt.  GNOME and KDE both display a
> > notification when the mount finishes, but by then it could be too late.
> > Someone should file a CVE against them too.
> 
> At least on SUSE orphaned and other problematic filesystem kernel modules
> are blacklisted. I wonder why other distros didn't follow this approach.

Maximal flexibility, I'm assuming.  It's at least somewhat comforting
that RHEL doesn't enable HFS in Kconfig so it's a nonissue for them, but
some day it's going to be ext4/XFS/btrfs that creates a compromise
widget.

> > You can tighten this up by doing this:
> >
> > # cat > /usr/share/polkit-1/rules.d/always-ask-mount.rules << ENDL
> > // don't allow mounting, reformatting, or loopdev creation without asking
> > polkit.addRule(function(action, subject) {
> >         if ((action.id == "org.freedesktop.udisks2.loop-setup" ||
> >              action.id == "org.freedesktop.udisks2.filesystem-mount" ||
> >              action.id == "org.freedesktop.udisks2.modify-device") &&
> >             subject.local == true) {
> >                 return polkit.Result.AUTH_ADMIN_KEEP;
> >         }
> > });
> > ENDL
> 
> Thanks for sharing this!
> 
> > so at least you have to authenticate with an admin account.  We do love
> > our footguns, don't we?  At least it doesn't let you do that if you're
> > ssh'd in...
> 
> IMHO guestmount and other userspace filesystem implementations should
> be the default
> for such mounts.

Agree.  I don't know if they (udisks upstream) have any good way to
detect that a userspace filesystem driver is available for a given
filesystem.  Individual fuse drivers don't seem to have a naming
convention (fusefat, fuse2fs) though at least on Debian some of them
seem to end up as /sbin/mount.fuse.$FSTYPE.

guestmount seems to boot the running kernel in qemu and use that?  So I
guess it's hard for guestmount itself even to tell you what formats it
supports?  I'm probably just ignorant on that issue.

--D

> //richard
> 

