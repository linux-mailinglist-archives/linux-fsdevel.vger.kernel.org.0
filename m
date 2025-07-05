Return-Path: <linux-fsdevel+bounces-54023-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E8CC2AFA256
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Jul 2025 01:26:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59CFF4A04B3
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Jul 2025 23:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66C6A2C031B;
	Sat,  5 Jul 2025 23:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="l6QfWN88"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F7D18DB1C
	for <linux-fsdevel@vger.kernel.org>; Sat,  5 Jul 2025 23:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751757987; cv=none; b=Ryl+ve063dJbJMdS8XVXdNQHYQ3jF36Kon+TEEElTmA4R7qZ1ufXaccOhLfofRIUaJx2dTHT8czrjC5mwkOu7WoEbcBulmUniWPoK0r8svmv2i5Vu7jZZ+bPclY408QipR3JcwqDxPU+fVOT+OfLIMQfZ2hc3MAcjm9jbGHIrok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751757987; c=relaxed/simple;
	bh=TT8zbs+eCX2XbTHT/hcGbsXraGVt/tSsOZTS0MfPCWk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fXezgta+hORcm4E12tlId2CmntUHfbK5I/oIdI5AmP8wPhJbOQyimSA1SK0HZntNOsDK/Sg76lC8GP7ygfFgV30DG1t1zJg6i+TISIjXCa4AwPSw58mbGkXXWWNm+b5nRYzzmqCfcHm2MBXFMw2m8Dhv5Bub70DFbOs9VcSGWyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=l6QfWN88; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=fyxMmE36ZuZQvBgcB1Oh21WcvH4Wp1UwJ5DH9CT4EOo=; b=l6QfWN88Sf5xo5C9nrEhH+UyjC
	YoL1EPXIvuOuFOJr8XONQKUwpJ8lnLR5HgY/VSRQtgEXgtg3fg7py8EgcgKdZ16q2MhZE5ejqOlm3
	r2G7bQgM7zuQgMebHrjWeq82bamKMto3/oduwSNQdwPdJOgQP94QTG4JF9vhnKBihNxwXgESlHAXF
	fJy/VP5L2OuOAu1B8n9Q+DNr/qJ6XEO/VRI8epVU/ZMXOvd6nZvvpQA5MxvzZ2JnmbS/3U1jx3B8F
	ikT4X4PBHR0pdarb4FM7Sg/Td7c+Y8X6luf+kFzhp7osaYLySmpj0ayoS1zTUNwndaXBY7QR6rC5r
	fbXG/CmA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uYCGz-00000006ICk-2vCm;
	Sat, 05 Jul 2025 23:26:21 +0000
Date: Sun, 6 Jul 2025 00:26:21 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.com>,
	Christoph Hellwig <hch@infradead.org>
Subject: Re: [RFC] MNT_WRITE_HOLD mess
Message-ID: <20250705232621.GA1880847@ZenIV>
References: <20250704194414.GR1880847@ZenIV>
 <CAHk-=wgurLEukSdbUPk28rW=hsVGMxE4zDOCZ3xxY3ee3oGyoQ@mail.gmail.com>
 <20250704202337.GT1880847@ZenIV>
 <20250705000114.GU1880847@ZenIV>
 <20250705185359.GZ1880847@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250705185359.GZ1880847@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sat, Jul 05, 2025 at 07:53:59PM +0100, Al Viro wrote:
> On Sat, Jul 05, 2025 at 01:01:14AM +0100, Al Viro wrote:
> 
> > FWIW, several observations around that thing:
> > 	* mnt_get_write_access(), vfs_create_mount() and clone_mnt()
> > definitely do not need to touch the seqcount component of mount_lock.
> > read_seqlock_excl() is enough there.
> > 	* AFAICS, the same goes for sb_prepare_remount_readonly(),
> > do_remount() and do_reconfigure_mnt() - no point bumping the seqcount
> > side of mount_lock there; only spinlock is needed.
> > 	* failure exit in mount_setattr_prepare() needs only clearing the
> > bit; smp_wmb() is pointless there (especially done for each mount involved).
> 
> The following appears to work; writing docs now...

	More fun questions in the area: is there any reason we have mnt_want_write()
doing
int mnt_want_write(struct vfsmount *m)
{
        int ret;

        sb_start_write(m->mnt_sb);
        ret = mnt_get_write_access(m);
        if (ret)
                sb_end_write(m->mnt_sb);
        return ret;
}
rather than
int mnt_want_write(struct vfsmount *m)
{
        int ret = mnt_get_write_access(m);
	if (!ret)
		sb_start_write(m->mnt_sb);
        return ret;
}

	Note that mnt_want_write_file() on e.g. a regular file opened
for write will have sb_start_write() done with mnt_get_write_access()
already in place since open(2).  So the nesting shouldn't be an issue
here...  The same order (mount then superblock) is used for overlayfs
copyup, for that matter.

	So if it's a matter of waiting for thaw with mount write
count already incremented, simple echo foo > pathname would already
demonstrate the same, no matter of which order mnt_want_write() uses.
What am I missing there?

	IIRC, that was Jan's stuff... <checks git log> yep - eb04c28288bb
"fs: Add freezing handling to mnt_want_write() / mnt_drop_write()" is
where it came from...

