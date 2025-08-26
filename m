Return-Path: <linux-fsdevel+bounces-59170-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E348B356D5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 10:28:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 901EF16966B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 08:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F3062FABE6;
	Tue, 26 Aug 2025 08:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fhRRXYCp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6062F6586
	for <linux-fsdevel@vger.kernel.org>; Tue, 26 Aug 2025 08:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756196881; cv=none; b=F09jvoI6zvEZekEa7NVqMmUzMC570pg+N4zGtBp48p9BRlBzWsP+drJyjXmIONkQaJFK+AinxPCXkWJi/5U7dQpIlJMYKW4JOV1ijEXmzyKovEqVerddmvlcy2Po1rSUktU+cnfeRNyMw11pbtps6TPXIKea2BuTtSzmVBYiOnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756196881; c=relaxed/simple;
	bh=IZZD/7G0RhU9lquQTxQrM2CR3PbTNXrKAKYHTRWd/98=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WHtnYBIi2hcUIc5xctNfghzgMQ4RmdzliQ2HIlkmFZ3yC22pe0dAhUfZbCx2IyXmz46dGDPRfqLPM/dxAUJkqZ99LuNMQdW8WpW9S7Le/EtTLtMiXS64flkr2OVDlrSqwiEunlVVkywOxXRpSCl3t88I96gmN2su/1uksrPEE78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fhRRXYCp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00DD8C4CEF1;
	Tue, 26 Aug 2025 08:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756196881;
	bh=IZZD/7G0RhU9lquQTxQrM2CR3PbTNXrKAKYHTRWd/98=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fhRRXYCpFyikXfvfrOvXnqXM70xLDsPmUv8/yZCvsjZU7c6aE9ka1P61iyIlGpadC
	 tNibrNN6OsfZabehJwoGyLP107iyyf4YLzbbJ8GLR50VqKBqoBvK8Hoa7A1NbxG49S
	 kNY4NkIud7MfCpU2jQ6WgjCPJhY0kU1e+kNT2tLUoyhP3X6IODpjMLdA1XKw/Mii/h
	 nBwOBWtR+pYJvvD2pcf+DdLF3BJaCN1pRya0ho6p/rLWYeXGEpI53LJ/ME6L4Qz482
	 eWYKn3OUGMtfCQLukA7FQBf7NRLRWlAZOxDuFxV3OHaoNvDx90yBQsbD19ib0E0QUG
	 2njEbKIrXIbiQ==
Date: Tue, 26 Aug 2025 10:27:56 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, jack@suse.cz, 
	torvalds@linux-foundation.org
Subject: Re: [PATCH 25/52] do_new_mount_rc(): use __free() to deal with
 dropping mnt on failure
Message-ID: <20250826-kronleuchter-vortag-af3c087ae46a@brauner>
References: <20250825044046.GI39973@ZenIV>
 <20250825044355.1541941-1-viro@zeniv.linux.org.uk>
 <20250825044355.1541941-25-viro@zeniv.linux.org.uk>
 <20250825-zugute-verkohlen-945073b3851f@brauner>
 <20250825160939.GL39973@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250825160939.GL39973@ZenIV>

On Mon, Aug 25, 2025 at 05:09:39PM +0100, Al Viro wrote:
> On Mon, Aug 25, 2025 at 03:29:33PM +0200, Christian Brauner wrote:
> > > -	mnt = vfs_create_mount(fc);
> > > +	struct vfsmount *mnt __free(mntput) = vfs_create_mount(fc);
> > 
> > Ugh, can we please not start declaring variables in the middle of a
> > scope.
> 
> Seeing that it *is* the beginning of its scope, what do you suggest?

What? Did I miss earlier or later changes because:

static int do_new_mount_fc(struct fs_context *fc, struct path *mountpoint,
			   unsigned int mnt_flags)
{
	struct vfsmount *mnt;
	struct pinned_mountpoint mp = {};
	struct super_block *sb = fc->root->d_sb;
	int error;

	error = security_sb_kern_mount(sb);
	if (!error && mount_too_revealing(sb, &mnt_flags))
		error = -EPERM;

	if (unlikely(error)) {
		fc_drop_locked(fc);
		return error;
	}

	up_write(&sb->s_umount);

	mnt = vfs_create_mount(fc);
	if (IS_ERR(mnt))
		return PTR_ERR(mnt);

How does up_write() create a new scope?

	mnt_warn_timestamp_expiry(mountpoint, mnt);

	error = lock_mount(mountpoint, &mp);
	if (!error) {
		error = do_add_mount(real_mount(mnt), mp.mp,
				     mountpoint, mnt_flags);
		unlock_mount(&mp);
	}
	if (error < 0)
		mntput(mnt);
	return error;
}

> Declaring it above, initializing with NULL and reassigning here?
> That's actually just as wrong, if not more so - any assignment added

I disagree. I do very much prefer having cleanups at the top of the
function or e.g.,:

if (foo) {
	struct vfsmount *mnt __free(mntput) = vfs_create_mount(fc);
}

Because it is really easy to figure out visually. But just doing it
somewhere in the middle is just confusing.

static int do_new_mount_fc(struct fs_context *fc, struct path *mountpoint,
			   unsigned int mnt_flags)
{
	struct pinned_mountpoint mp = {};
	struct super_block *sb = fc->root->d_sb;
	int error;

	error = security_sb_kern_mount(sb);
	if (!error && mount_too_revealing(sb, &mnt_flags))
		error = -eperm;

	if (unlikely(error)) {
		fc_drop_locked(fc);
		return error;
	}

	up_write(&sb->s_umount);

	struct vfsmount *mnt __free(mntput) = vfs_create_mount(fc);
	if (is_err(mnt))
		return ptr_err(mnt);

