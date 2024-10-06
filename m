Return-Path: <linux-fsdevel+bounces-31104-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CD83991C6C
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Oct 2024 05:39:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11EAF283293
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Oct 2024 03:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 978EC1684A1;
	Sun,  6 Oct 2024 03:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="jT9l+tfW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B7AB1662F4
	for <linux-fsdevel@vger.kernel.org>; Sun,  6 Oct 2024 03:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728185934; cv=none; b=hX7peurjzxFNxpjUuHAE01iFxHMjMl6diGcTq9fkze0Je5aj+S1KOz3pR8TR3ZQepzqGzsorhrCrgyi1j7hW+BCu4PPYNSRfu7VemlyhdbblyEAOD4XVFL3Eo8TkD2QKDT2EjTImeaLEHL3Be7fFqdwtI72ebZ64MCsB29Acfzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728185934; c=relaxed/simple;
	bh=RCXBCq+nZWtkjXKtHC6Z2v1HSF/B5HMBPjyiighVBOI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bt4+aEoZ1vxBc+7C07v2uGJdeQ+w7zAKPugcyo8/pxhASI5yelCJ8Cf6f6b3nvv5aFi36wGDasPJOdch3nE/yf07eDyNmnW2f12fki2qNEESjixDgG4b7TD3G8RgrXL6lM93e8OFW8K4t9xa1RqH90p9lINK/9QiZStHykmkEeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=jT9l+tfW; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-111-178.bstnma.fios.verizon.net [173.48.111.178])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 4963c5lT019613
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 5 Oct 2024 23:38:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1728185893; bh=oCEEqj+UtNwLXvigx5EXmnpRe6dWCvtIGCt8HrRAOZQ=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=jT9l+tfW8Xt8ZDRXCHbo1A9oBWKxJFfvFcmX3f+kRWSXhjHeZTlIcMAnGylsCAIUU
	 BzoDQQFShM913bZrUBEuWEqoYyyV1lsFcVHh/k/5QalXHxFH6W5i13ZK6erEIvNiZb
	 4XLDg4vUQ/dtMpZHcFDzzeIvbOyDcgxhm9EA4LCm0LTF1DCuj+LXjC0EExOame65+w
	 /LrqlfRWC3nfl6OzIlOpSNnC8AGEVPXApwaOF8pBJDSSJ+LF7raCmQtsR/FtOA67XL
	 YCegeAvaRD6Gu7JZEMsQ5gnvgTEqSgKdPvzEo7d6zXFagUUaAfODN9aTUYzNupwCRC
	 +yRCtH6d/pguA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 6068A15C6668; Sat, 05 Oct 2024 23:38:05 -0400 (EDT)
Date: Sat, 5 Oct 2024 23:38:05 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Gabriel Krisman Bertazi <gabriel@krisman.be>
Cc: Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
        Jan Stancek <jstancek@redhat.com>,
        Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, ltp@lists.linux.it
Subject: Re: [LTP] [PATCH] ext4: don't set SB_RDONLY after filesystem errors
Message-ID: <20241006033805.GB158527@mit.edu>
References: <20240805201241.27286-1-jack@suse.cz>
 <Zvp6L+oFnfASaoHl@t14s>
 <20240930113434.hhkro4bofhvapwm7@quack3>
 <CAOQ4uxjXE7Tyz39wLUcuSTijy37vgUjYxvGL21E32cxStAgQpQ@mail.gmail.com>
 <877canu0gr.fsf@mailhost.krisman.be>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877canu0gr.fsf@mailhost.krisman.be>

On Fri, Oct 04, 2024 at 03:33:56PM -0400, Gabriel Krisman Bertazi wrote:
> > Regardless of what is right or wrong to do in ext4, I don't think that the test
> > really cares about remount read-only.
> > I don't see anything in the test that requires it. Gabriel?
> > If I remove MS_RDONLY from the test it works just fine.
> 
> If I recall correctly, no, there is no need for the MS_RDONLY.  We only
> care about getting the event to test FS_ERROR.

Looking at ltp/testcases/kernel/syscalls/fanotify/fanotify22.c this
appears to be true.

I'll note though that this comment in fanotify22.c is a bit
misleading:

	/* Unmount and mount the filesystem to get it out of the error state */
	SAFE_UMOUNT(MOUNT_PATH);
	SAFE_MOUNT(tst_device->dev, MOUNT_PATH, tst_device->fs_type, 0, NULL);

Once ext4_error() gets called, the file system will be marked as
containing errors.  This can be seen when you mount the file system,
and when you run fsck -p:

root@kvm-xfstests:~# mount /dev/vdc /vdc
[ 1893.569015] EXT4-fs (vdc): mounted filesystem 9bf1a2df-fc1c-4b46-a8e8-c9e3e9bc7a26 r/w with ordered data mode. Quota mode: none.
root@kvm-xfstests:~# echo "testing 123" > /sys/fs/ext4/vdc/trigger_fs_error 
[ 1907.268249] EXT4-fs error (device vdc): trigger_test_error:129: comm bash: testing 123
root@kvm-xfstests:~# umount /vdc
[ 1919.722934] EXT4-fs (vdc): unmounting filesystem 9bf1a2df-fc1c-4b46-a8e8-c9e3e9bc7a26.
root@kvm-xfstests:~# mount /dev/vdc /vdc
[ 1923.270852] EXT4-fs (vdc): warning: mounting fs with errors, running e2fsck is recommended
[ 1923.297998] EXT4-fs (vdc): mounted filesystem 9bf1a2df-fc1c-4b46-a8e8-c9e3e9bc7a26 r/w with ordered data mode. Quota mode: none.
root@kvm-xfstests:~# umount /vdc
[ 1925.889086] EXT4-fs (vdc): unmounting filesystem 9bf1a2df-fc1c-4b46-a8e8-c9e3e9bc7a26.
root@kvm-xfstests:~# fsck -p /dev/vdc
fsck from util-linux 2.38.1
/dev/vdc contains a file system with errors, check forced.
/dev/vdc: 12/327680 files (0.0% non-contiguous), 42398/1310720 blocks

Unmounting and remounting the file system is not going to clear file
system's error state.  You have to clear the EXT2_ERROR_FS state, and
if you want to prevent fsck.ext4 -p from running, you'll need to set
the EXT2_VALID_FS bit, via 'debugfs -w -R "ssv state 1" /dev/vdc' or
you could just run 'fsck.ext4 -p /dev/vdc'.

Also note that way I generally recommend that people simulate
triggering a file system error is via a command like this:

   echo "test error description" > /sys/fs/ext4/vdc/trigger_fs_error

To be honest, I had completely forgotten that the abort mount option
exists at all, and if I didn't know that ltp was using it, I'd be
inclined to deprecate and remove it....

						- Ted


