Return-Path: <linux-fsdevel+bounces-14179-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4FF5878D87
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Mar 2024 04:35:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96E2C1F2247E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Mar 2024 03:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32665B665;
	Tue, 12 Mar 2024 03:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BCuLpwmg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A40CAD53;
	Tue, 12 Mar 2024 03:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710214516; cv=none; b=H2R9k2OTqaYe/h3V77ozBoe7VK/oiGIS943MXvQiGNfjypDX1D/mwYSjbh+UWzLgynMuBt/XtnP4tv8biodAuhHDg/16tbMAyHYrIKn6lvM2Guf2N/yQcw7cyuIg/9pI5bZ9zocJ3KUPnBk6XX6HSWP4WpR+oGmKV1aKSjG0jSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710214516; c=relaxed/simple;
	bh=AUQ7xAWBTS5Ia7CJFyHPV3xL7WfXiWahy9TRf8nEfkQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gVGSnO9lkKk8Bg19SClPFvTMkmMpEG2mvThwfJA0/7DWz2a4HJ1xmrg1pHX2S+5ENdcZackYPVUC2MmKn7cULenNWtRuEo+Zh9wYqAV1rwTRBifuMu8Kwv6VHl7Yp84/RRvKglM2J7EBAftcuaQQYamuaWHYJerF1zdoBQGT82Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BCuLpwmg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D088C433C7;
	Tue, 12 Mar 2024 03:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710214516;
	bh=AUQ7xAWBTS5Ia7CJFyHPV3xL7WfXiWahy9TRf8nEfkQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BCuLpwmgvPExgGzXP91YpQQyZHNSwLE6gYj8a59LYvTDeg7NR7VjLrYJY+HfNVvm0
	 /xaAi2Rt4p1UP+ij3ErLabhUyXs+22Uxm7fOuswqU4ZM/Dv/hxDm41XneOn0Ni/vKb
	 qIP5JqQP1AQ4FuU6LE8sW1fMpkY/4Ztj12buxLdNeQlYD2Y3/CrDFqKxqCorKiZ5GK
	 zTs98KPkFLoQzbIMBc4rX63WjWRkfwGhjILdEdslp2JTifMaja/icz7VXjrCOXJuia
	 cz38SP1NQuot3QHtF0VKBC7TdzFZMg5XeT7af/DhaPOmkfleHa6PaHd6zBd+eMpbzo
	 k1neHLj6jkruw==
Date: Mon, 11 Mar 2024 20:35:13 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Andreas Dilger <adilger@dilger.ca>
Cc: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>, corbet@lwn.net,
	Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-doc@vger.kernel.org,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	linux-btrfs <linux-btrfs@vger.kernel.org>,
	Chris Mason <clm@meta.com>, David Sterba <dsterba@suse.com>,
	Josef Bacik <josef@toxicpanda.com>, jbacik@toxicpanda.com,
	kernel-team@meta.com
Subject: Re: [PATCH 1/3] add physical_length field to fiemap extents
Message-ID: <20240312033513.GG1182@sol.localdomain>
References: <cover.1709918025.git.sweettea-kernel@dorminy.me>
 <0b423d44538f3827a255f1f842b57b4a768b7629.1709918025.git.sweettea-kernel@dorminy.me>
 <D8407E1D-F188-4115-A963-9EFBB515C45D@dilger.ca>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D8407E1D-F188-4115-A963-9EFBB515C45D@dilger.ca>

On Mon, Mar 11, 2024 at 06:22:02PM -0600, Andreas Dilger wrote:
> On Mar 8, 2024, at 11:03 AM, Sweet Tea Dorminy <sweettea-kernel@dorminy.me> wrote:
> > 
> > Some filesystems support compressed extents which have a larger logical
> > size than physical, and for those filesystems, it can be useful for
> > userspace to know how much space those extents actually use. For
> > instance, the compsize [1] tool for btrfs currently uses btrfs-internal,
> > root-only ioctl to find the actual disk space used by a file; it would
> > be better and more useful for this information to require fewer
> > privileges and to be usable on more filesystems. Therefore, use one of
> > the padding u64s in the fiemap extent structure to return the actual
> > physical length; and, for now, return this as equal to the logical
> > length.
> 
> Thank you for working on this patch.  Note that there was a patch from
> David Sterba and a lengthy discussion about exactly this functionality
> several years ago.  If you haven't already read the details, it would be
> useful to do so. I think the thread had mostly come to good conclusions,
> but the patch never made it into the kernel.
> 
> https://patchwork.ozlabs.org/project/linux-ext4/patch/4f8d5dc5b51a43efaf16c39398c23a6276e40a30.1386778303.git.dsterba@suse.cz/
> 
> One of those conclusions was that the kernel should always fill in the
> fe_physical_length field in the returned extent, and set a flag:
> 
> #define FIEMAP_EXTENT_PHYS_LENGTH      0x00000010
> 
> to indicate to userspace that the physical length field is valid.
> 
> There should also be a separate flag for extents that are compressed:
> 
> #define FIEMAP_EXTENT_DATA_COMPRESSED  0x00000040
> 
> Rename fe_length to fe_logical_length and #define fe_length fe_logical_length
> so that it is more clear which field is which in the data structure, but
> does not break compatibility.
> 
> I think this patch gets most of this right, except the presence of the
> flags to indicate the PHYS_LENGTH and DATA_COMPRESSED state in the extent.
> 
> Cheers, Andreas

Thanks for resurrecting this.  Andreas's suggestions sound good to me.  And yes,
please try to search for any past discussions on this topic.

It may be a good idea to Cc the f2fs mailing list
(linux-f2fs-devel@lists.sourceforge.net), since this will be useful for f2fs
too, since f2fs supports compression.

One use case is that this will make testing the combination of
compression+encryption (e.g. as xfstest f2fs/002 tries to do) easier.

- Eric

