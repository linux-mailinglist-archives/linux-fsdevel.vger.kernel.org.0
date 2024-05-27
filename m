Return-Path: <linux-fsdevel+bounces-20234-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C20E18D011D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 May 2024 15:17:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3EE21C21AC4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 May 2024 13:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06AD615ECFA;
	Mon, 27 May 2024 13:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JiDXrb77"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5955415DBC1;
	Mon, 27 May 2024 13:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716815839; cv=none; b=eqm4Tag0d5xGIXdtOAAAhLUxVmXP1pinxQU0qoKBzZBS66ym4j2zYiQHn128dd0+3mEOTbpazUj6DHgNRh0jsVUfQvPfwxn1xrgt8GkLmHxF2YdoHstEV3BqwAJHrGi4cR9vDT7CSUdSfw0XJX2sp8B9ML260FycLJ4nT4E91y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716815839; c=relaxed/simple;
	bh=mbc7e5Aw51Pj7Y7uXh0+EUTmMjHOr9lpqOQGt0LJNj8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W4ZV2KNaEIUaB0qmguRRlYGgysHCQvP1rqZqFfLFzZ6F9ltS2L33ahAUX5hy/lCJH6GkeM38sw0scDyAOCXGIhNFvNI6JsJqqozKEjn85z64226EoVpM1QiXMhzI/yzfPAmr4m0Z53jLkga2yi2b0WH91NKhpeLLszMpRCxgdvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JiDXrb77; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6587C2BBFC;
	Mon, 27 May 2024 13:17:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716815838;
	bh=mbc7e5Aw51Pj7Y7uXh0+EUTmMjHOr9lpqOQGt0LJNj8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JiDXrb77d1bgd6e2DuJZv7zycxfNAaNgJiQqhZ/Tz8eWQhtdmsKbvLpZ9wMsrfpgC
	 H/snoGkHgh5YBLptJ2cBfzz3ObHLDFUUObg5FqU3xaVNYBo7VLsEeTwyfJdDO4UnoH
	 HExGdKZoJLJ/HP8qRau/9qZcJjyc1lOIQObo6zU3zajkvHGuXujNA3jtNvlXLZIjc4
	 dMdbeo+88BXg+/AO4gumXZCatcHMXtaOL/EFSOPSLpqEFcJmfM8wJaRpfxkAAplwB+
	 fdUMuqIoxiTYeSgDizJ0c+EjYHHP8IqNU+MepsHIRzxm150fcnfEylDlZq53fviMYM
	 EEhy/wWYRdNMQ==
Date: Mon, 27 May 2024 15:17:13 +0200
From: Christian Brauner <brauner@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Aleksa Sarai <cyphar@cyphar.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Chuck Lever <chuck.lever@oracle.com>, 
	Jeff Layton <jlayton@kernel.org>, Amir Goldstein <amir73il@gmail.com>, 
	Alexander Aring <alex.aring@gmail.com>, linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [PATCH RFC v2] fhandle: expose u64 mount id to
 name_to_handle_at(2)
Message-ID: <20240527-raufen-skorpion-fa81805b3273@brauner>
References: <20240523-exportfs-u64-mount-id-v2-1-f9f959f17eb1@cyphar.com>
 <ZlMADupKkN0ITgG5@infradead.org>
 <20240526.184753-detached.length.shallow.contents-jWkMukeD7VAC@cyphar.com>
 <ZlRy7EBaV04F2UaI@infradead.org>
 <20240527-hagel-thunfisch-75781b0cf75d@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240527-hagel-thunfisch-75781b0cf75d@brauner>

On Mon, May 27, 2024 at 02:29:02PM +0200, Christian Brauner wrote:
> On Mon, May 27, 2024 at 04:47:56AM -0700, Christoph Hellwig wrote:
> > On Sun, May 26, 2024 at 12:01:08PM -0700, Aleksa Sarai wrote:
> > > The existing interface already provides a mount ID which is not even
> > > safe without rebooting.
> > 
> > And that seems to be a big part of the problem where the Linux by handle
> > syscall API deviated from all know precedence for no good reason.  NFS
> > file handles which were the start of this do (and have to) encode a
> > persistent file system identifier.  As do the xfs handles (although they
> > do the decoding in the userspace library on Linux for historic reasons),
> > as do the FreeBSD equivalents to these syscalls.
> > 
> > > An alternative would be to return something unique to the filesystem
> > > superblock, but as far as I can tell there is no guarantee that every
> > > Linux filesystem's fsid is sufficiently unique to act as a globally
> > > unique identifier. At least with a 64-bit mount ID and statmount(2),
> > > userspace can decide what information is needed to get sufficiently
> > > unique information about the source filesystem.
> > 
> > Well, every file system that supports export ops already needs a
> > globally unique ID for NFS to work properly.  We might not have good
> > enough interfaces for that, but that shouldn't be too hard.
> 
> I see not inherent problem with exposing the 64 bit mount id through
> name_to_handle_at() as we already to expose the old one anyway.
> 
> But I agree that it is useful if we had the guarantee that file handles
> are unique in the way you describe. As it currently stands that doesn't
> seem to be the case and userspace doesn't seem to have a way of figuring
> out if the handle provided by name_to_handle_at() is indeed unique as
> you describe and can be reliably passed to open_by_handle_at().
> 
> Yes, we should fix it but that's really orthogonal to the mount id. It
> is separately useful and we already do expose it anyway.

Put another way, name_to_handle_at(2) currently states:

   Obtaining a persistent filesystem ID
       The mount IDs in /proc/self/mountinfo can be reused as
       filesystems are unmounted and mounted.  Therefore, the mount ID
       returned by name_to_handle_at()  (in  *mount_id)  should  not  be
       treated  as  a persistent identifier for the corresponding
       mounted filesystem.  However, an application can use the
       information in the mountinfo record that corresponds to the mount
       ID to derive a persistent identifier.

       For example, one can use the device name in the fifth field of
       the mountinfo record to search for the corresponding device UUID
       via the symbolic links in /dev/disks/by-uuid.   (A  more
       comfortable  way  of obtaining the UUID is to use the libblkid(3)
       library.)  That process can then be reversed, using the UUID to
       look up the device name, and then obtaining the corre‐ sponding
       mount point, in order to produce the mount_fd argument used by
       open_by_handle_at().

Returning the 64bit mount id makes this race-free because we now have
statmount():

u64 mnt_id = 0;
name_to_handle_at(AT_FDCWD, "/path/to/file", &handle, &mnt_id, 0);
statmount(mnt_id);

Which gets you the device number which one can use to figure out the
uuid without ever having to open a single file (We could even expose the
UUID of the filesystem through statmount() if we wanted to.).

