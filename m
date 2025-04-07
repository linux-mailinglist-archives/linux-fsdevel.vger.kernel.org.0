Return-Path: <linux-fsdevel+bounces-45914-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10587A7ED26
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Apr 2025 21:31:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBE9B3BD868
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Apr 2025 19:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53A1F255236;
	Mon,  7 Apr 2025 19:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GXlYIfTV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6AC72550D3;
	Mon,  7 Apr 2025 19:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744052897; cv=none; b=Kj1uJ9/Oe3ETjqh0tzVWOFIXvA16IsZbND2BLO9dXt+DQmL5QD5Dr4o442hyqNa8zZJVxAEeNf8jxlqSFos/+O6xmGtWwRaXc/QGRdfotqShv8e9+VIhaFQDYrVkFsqQufxuHc1UWRdE7cPwpp2T7Q/lWl1TFWFHDXhw4JFRQnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744052897; c=relaxed/simple;
	bh=lJf9zIuif4BIo222tcqoPJFmlvYQSPEu41tH6umSAus=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=clo/adyqg19H3NqxmYQtIGmTd73PmOyEFFrm/oSMA0MYCg2qbmEUNmrrsVK9DN1QwCQ+iV0lGa22f1j+WK+YG8QkquoaDuQ1ve6iVLjrmZjMrgbt8bGWLs4tU1Yz9006h08FfGrcN0W7MSgBv+UYTOqf8YRbPXXBf1NwQn1zBkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GXlYIfTV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 151FCC4CEED;
	Mon,  7 Apr 2025 19:08:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744052897;
	bh=lJf9zIuif4BIo222tcqoPJFmlvYQSPEu41tH6umSAus=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GXlYIfTVJKXqN2qD047swvCaFJSit8J6wOo6LunFbsCP9bp/spYa+In5fUGqLnjG9
	 6IRJmbTSnMUfCWP2So/dGWRxmdV+cjMaOH/uO3Mibf626rTk+6KVgfuU1IzNZzbwCK
	 cxA0ko9h1DeFn8RQ3uYcFeGeMUHO6rIW9GQoqGL1QP5dkmY/moKFKaGNmX+LcheeHD
	 0HIGoR7CaEGMvlayPRa0M4AeiYEhh4xDrdbbr8dFnNm+vpM4NWh/Kyq11l9+33dvaF
	 khEfonlWb4KrahuzZEbM+AsekpMCE7EMT0qiray5GNm0TNF+NFRT4ClFSdE+8/RPT7
	 bs61KNTWmInxg==
Date: Mon, 7 Apr 2025 12:08:14 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Cengiz Can <cengiz.can@canonical.com>,
	Attila Szasz <szasza.contact@gmail.com>,
	Greg KH <gregkh@linuxfoundation.org>,
	Salvatore Bonaccorso <carnil@debian.org>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	lvc-patches@linuxtesting.org, dutyrok@altlinux.org,
	syzbot+5f3a973ed3dfb85a6683@syzkaller.appspotmail.com,
	stable@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] hfs/hfsplus: fix slab-out-of-bounds in hfs_bnode_read_key
Message-ID: <20250407190814.GB6258@frogsfrogsfrogs>
References: <20241019191303.24048-1-kovalev@altlinux.org>
 <Z9xsx-w4YCBuYjx5@eldamar.lan>
 <d4mpuomgxqi7xppaewlpey6thec7h2fk4sm2iktqsx6bhwu5ph@ctkjksxmkgne>
 <2025032402-jam-immovable-2d57@gregkh>
 <7qi6est65ekz4kjktvmsbmywpo5n2kla2m3whbvq4dsckdcyst@e646jwjazvqh>
 <2025032404-important-average-9346@gregkh>
 <dzmprnddbx2qaukb7ukr5ngdx6ydwxynaq6ctxakem43yrczqb@y7dg7kzxsorc>
 <20250407-biegung-furor-e7313ca9d712@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250407-biegung-furor-e7313ca9d712@brauner>

On Mon, Apr 07, 2025 at 12:59:18PM +0200, Christian Brauner wrote:
> On Sun, Apr 06, 2025 at 07:07:57PM +0300, Cengiz Can wrote:
> > On 24-03-25 11:53:51, Greg KH wrote:
> > > On Mon, Mar 24, 2025 at 09:43:18PM +0300, Cengiz Can wrote:
> > > > In the meantime, can we get this fix applied?
> > > 
> > > Please work with the filesystem maintainers to do so.
> > 
> > Hello Christian, hello Alexander
> > 
> > Can you help us with this?
> > 
> > Thanks in advance!
> 
> Filesystem bugs due to corrupt images are not considered a CVE for any
> filesystem that is only mountable by CAP_SYS_ADMIN in the initial user
> namespace. That includes delegated mounting.
> 
> Now, quoting from [1]:
> 
> "So, for the record, the Linux kernel in general only allows mounts for
> those with CAP_SYS_ADMIN, however, it is true that desktop and even
> server environments allow regular non-privileged users to mount and
> automount filesystems.
> 
> In particular, both the latest Ubuntu Desktop and Server versions come
> with default polkit rules that allow users with an active local session
> to create loop devices and mount a range of block filesystems commonly
> found on USB flash drives with udisks2. Inspecting
> /usr/share/polkit-1/actions/org.freedesktop.UDisks2.policy shows:"
> 
> So what this saying is:
> 
> A distribution is shipping tooling that allows unprivileged users to mount
> arbitrary filesystems including hpfsplus. Or to rephrase this: A
> distribution is allowing unprivileged users to mount orphaned
> filesystems. Congratulations on the brave decision to play Russian
> Roulette with a fully-loaded gun.

It's also the default policy on Debian 12 and RHEL9 that if you're
logged into the GUI, any program can run:

$ truncate -s 3g /tmp/a
$ mkfs.hfs /tmp/a
$ <write evil stuff on /tmp/a>
$ udisksctl loop-setup -f /tmp/a
$ udisksctl mount -b /dev/loopX

and the user never sees a prompt.  GNOME and KDE both display a
notification when the mount finishes, but by then it could be too late.
Someone should file a CVE against them too.

You can tighten this up by doing this:

# cat > /usr/share/polkit-1/rules.d/always-ask-mount.rules << ENDL
// don't allow mounting, reformatting, or loopdev creation without asking
polkit.addRule(function(action, subject) {
        if ((action.id == "org.freedesktop.udisks2.loop-setup" ||
             action.id == "org.freedesktop.udisks2.filesystem-mount" ||
             action.id == "org.freedesktop.udisks2.modify-device") &&
            subject.local == true) {
                return polkit.Result.AUTH_ADMIN_KEEP;
        }
});
ENDL

so at least you have to authenticate with an admin account.  We do love
our footguns, don't we?  At least it doesn't let you do that if you're
ssh'd in...

--D

> The VFS doesn't allow mounting arbitrary filesystems by unprivileged
> users. Every FS_REQUIRES_DEV filesystem requires global CAP_SYS_ADMIN
> privileged at which point you can also do sudo rm -rf --no-preserve-root /
> or a million other destructive things.
> 
> The blogpost is aware that the VFS maintainers don't accept CVEs like
> this. Yet a CVE was still filed against the upstream kernel. IOW,
> someone abused the fact that a distro chose to allow mounting arbitrary
> filesystems including orphaned ones by unprivileged user as an argument
> to gain a kernel CVE.
> 
> Revoke that CVE against the upstream kernel. This is a CVE against a
> distro. There's zero reason for us to hurry with any fix.
> 
> [1]: https://ssd-disclosure.com/ssd-advisory-linux-kernel-hfsplus-slab-out-of-bounds-write/
> 

