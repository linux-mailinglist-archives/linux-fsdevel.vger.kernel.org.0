Return-Path: <linux-fsdevel+bounces-73900-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 40A2BD23376
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 09:43:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C236930D702A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 08:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B77833A9D6;
	Thu, 15 Jan 2026 08:31:46 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CDEF339B32;
	Thu, 15 Jan 2026 08:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768465903; cv=none; b=dr8nvTAuVP8/6vEu/CyXoR39qLyZ9nSlbxg68xi5ajwkQpT3wCrIeyUJ5pJ/j+VwbA/f/IJbjjziW2ifgrUs4XQKiwkTbibdnhFDh9/F45lchVZZ5HaIQpZe4g3SgbffjtZ/NgN9DhqU2fSGoXd4L7EoQg2dCm+eZ8JsYQ35eyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768465903; c=relaxed/simple;
	bh=QoowsZLh9gCbs7BpUDUIW6YL7UCTyh3zOWkgQP5Oeuk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CYEH6sXxgmy+cNi52h3CMjd+nJ2PGPqli9epv0k1YLr8XdJA56j9qI+qiflK1NaiUeDZaDR1oAMdLfK46xZt7gyK5roQldmh3cJmZS2zlblMd0BDwUivM8kvhH8mTvwQDzAYp7W+sZKcI5moSh5KKmiQCjYCJHU9tN2UkYHln+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8FAEE227AA8; Thu, 15 Jan 2026 09:31:31 +0100 (CET)
Date: Thu, 15 Jan 2026 09:31:31 +0100
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
Message-ID: <20260115083131.GA12267@lst.de>
References: <20260114-tonyk-get_disk_uuid-v1-0-e6a319e25d57@igalia.com> <20260114-tonyk-get_disk_uuid-v1-3-e6a319e25d57@igalia.com> <20260114062608.GB10805@lst.de> <5334ebc6-ceee-4262-b477-6b161c5ca704@igalia.com> <20260115062944.GA9590@lst.de> <633bb5f3-4582-416c-b8b9-fd1f3b3452ab@suse.com> <20260115072311.GA10352@lst.de> <461fc582-71ba-4238-9696-3d8bdd8a0207@suse.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <461fc582-71ba-4238-9696-3d8bdd8a0207@suse.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Jan 15, 2026 at 06:39:05PM +1030, Qu Wenruo wrote:
>>> Then for those SINGLE_DEV fses, disable any multi-device related features,
>>> and use their dev_t to distinguish different fses just like EXT4/XFS,
>>> without bothering the current tempfsid hack, and just return the same fsid.
>>
>> dev_t is not related to the uuid in any way for XFS, and while I'm not
>> an expert there I'm pretty sure ext4 uses the same not dev related uuid
>> generation.
>
> My bad, by dev_t I mean bdev holder, which is a pointer to the super block 
> of the mounted fs. (And btrfs just recently join this common usage)

How is that related?  That prevents multiple callers from exclusively
using a block device.  Cloned file systems will sit on different devices.

> Yeah, although it's possible to mount different devices with same fsid 
> separately, I don't think it's really that a good idea either.
>
> Thus I really prefer to have special flags for those "uncommon" use cases, 
> other than the current automatically enabled tempfsid feature.

For XFS we require the nouuid option to allows additional mounts of
file systems with the same uuid.  I think that is the equivalent to
what btrfs calls the fsid.


