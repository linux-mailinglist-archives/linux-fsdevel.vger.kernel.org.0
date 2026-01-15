Return-Path: <linux-fsdevel+bounces-73890-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 15E4BD22CC3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 08:23:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DBF1C3059463
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 07:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BED2A328605;
	Thu, 15 Jan 2026 07:23:22 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED1131328D;
	Thu, 15 Jan 2026 07:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768461802; cv=none; b=IF/R/8qEsLd2lptjlL8ejEsaEbsn0vyeOdTZuUwiO39aFuf7F4MItcn15AQYP02SFpU2tPCwQUwpq5VuJ1kg8dJQMtF2mVCiHtm+D5m2zJ8uK6FIYFWG7VcVMAENoJNokXQs9DGn1Pzap1pPkCIAW5JXgbOmX+RH8YAPxMdJJKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768461802; c=relaxed/simple;
	bh=O1BNHKLn5erkcEmGXQ2si3MlRqbzcIIYuajlpLP7xkM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tlq14n0dvqXhrCFMQZYwxLt4CXszRTG0tlMCrR+L0pc4DTtcBo6pjwyhH5DnGT871SlNaT2yGR183iCuiOkAy/sgllKqcjw+tmkskR0eKlSN1tlss8IhSOlS7Sy9eqNuuwgSD6d6GaEbhZuxM6mY/RhCOXWY4hHA3PDDDwafROI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 630AD227AA8; Thu, 15 Jan 2026 08:23:12 +0100 (CET)
Date: Thu, 15 Jan 2026 08:23:12 +0100
From: Christoph Hellwig <hch@lst.de>
To: Qu Wenruo <wqu@suse.com>
Cc: Christoph Hellwig <hch@lst.de>,
	=?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	Carlos Maiolino <cem@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>, Chris Mason <clm@fb.com>,
	David Sterba <dsterba@suse.com>, Miklos Szeredi <miklos@szeredi.hu>,
	Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org, linux-unionfs@vger.kernel.org,
	kernel-dev@igalia.com
Subject: Re: [PATCH 3/3] ovl: Use real disk UUID for origin file handles
Message-ID: <20260115072311.GA10352@lst.de>
References: <20260114-tonyk-get_disk_uuid-v1-0-e6a319e25d57@igalia.com> <20260114-tonyk-get_disk_uuid-v1-3-e6a319e25d57@igalia.com> <20260114062608.GB10805@lst.de> <5334ebc6-ceee-4262-b477-6b161c5ca704@igalia.com> <20260115062944.GA9590@lst.de> <633bb5f3-4582-416c-b8b9-fd1f3b3452ab@suse.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <633bb5f3-4582-416c-b8b9-fd1f3b3452ab@suse.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Jan 15, 2026 at 05:21:04PM +1030, Qu Wenruo wrote:
> So that means let btrfs to convert the temp fsid into metadata uuid, which 
> I think is fine.

At least in XFS terms, that metadata uuid is the persistent, never
changing uuid in the metadata headrs.

> But the problem is that will change the fsid of the new fs, which may or 
> may not be what's expected for the current temp fsid user (they really want 
> two btrfs with the same fsid).

Which is really dangerous and should not be used in normal operation.
For XFS with support it with a nouuid option, mostly for historic
reasons and to be able to change the uuid transactional using an
ioctl.

> My initial idea for this problem is to let btrfs not generate a tempfsid 
> automatically, but put some special flag (e.g. SINGLE_DEV compat ro flag) 
> on those fses that want duplicated fsid.
>
> Then for those SINGLE_DEV fses, disable any multi-device related features, 
> and use their dev_t to distinguish different fses just like EXT4/XFS, 
> without bothering the current tempfsid hack, and just return the same fsid.

dev_t is not related to the uuid in any way for XFS, and while I'm not
an expert there I'm pretty sure ext4 uses the same not dev related uuid
generation.

> I'm wondering will that behavior (returning the same fsid) be acceptable 
> for overlayfs?

I still wonder what the use case is here.  Looking at André's original
mail it states:

"However, btrfs mounts may have volatiles UUIDs. When mounting the exact same
disk image with btrfs, a random UUID is assigned for the following disks each
time they are mounted, stored at temp_fsid and used across the kernel as the
disk UUID. `btrfs filesystem show` presents that. Calling statfs() however
shows the original (and duplicated) UUID for all disks."

and this doesn't even talk about multiple mounts, but looking at
device_list_add it seems to only set the temp_fsid flag when set
same_fsid_diff_dev is set by find_fsid_by_device, which isn't documented
well, but does indeed seem to be done transparently when two file systems
with the same fsid are mounted.

So André, can you confirm this what you're worried about?  And btrfs
developers, I think the main problem is indeed that btrfs simply allows
mounting the same fsid twice.  Which is really fatal for anything using
the fsid/uuid, such NFS exports, mount by fs uuid or any sb->s_uuid user.

> If so, I think it's time to revert the behavior before it's too late.
> Currently the main usage of such duplicated fsids is for Steam deck to 
> maintain A/B partitions, I think they can accept a new compat_ro flag for 
> that.

What's an A/B partition?  And how are these safely used at the same time?


