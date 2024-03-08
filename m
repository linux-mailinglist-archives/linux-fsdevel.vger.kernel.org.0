Return-Path: <linux-fsdevel+bounces-13978-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A2EC875D37
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Mar 2024 05:40:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5681D282654
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Mar 2024 04:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95D6C2E642;
	Fri,  8 Mar 2024 04:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hm9KiPhf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDCC32C1BF;
	Fri,  8 Mar 2024 04:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709872820; cv=none; b=GawvuREtUywonFxQrOL7Fu5qgdNCrBlR8E8Yr37AbOYBTWhlOkjnjQZvMSlRaRi6V/ul6gcNfjPNxn63IfzB6ahQ7ui+5x/yzI3LrmnQKeJQchWlayqaiaOQRSSpHJDpyu3xueM3jw9Hc1M5jY8OI0vyKBEdhI2qo5jKyt6LuDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709872820; c=relaxed/simple;
	bh=77caZOBVxWdVjB7T0uqv6sdnKxKbhk1L6k5nDRBj+Yg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ff+FGWidpQstPaK2f406a7o/y6FSr4uxRTdSZS4C8XFDVO81CIDqqhdsaRkM77FtvasW6KgLA5j/YfUnUTaDauUhcRG8Yg3GUKayxbYQyQ8XLQDOhJUjLrQ8fWivUlMdflEZ/26CVaE4IL7dn8M99sphXphFTPnxyw1Xk4LNCu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hm9KiPhf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3900BC433F1;
	Fri,  8 Mar 2024 04:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709872819;
	bh=77caZOBVxWdVjB7T0uqv6sdnKxKbhk1L6k5nDRBj+Yg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hm9KiPhfozyTAPShF3PtmQ5k2VQ6FJoH7+2EQqAgF2gU6N6zrTSff7zNNALAbIJWy
	 rJwavwf5xw2+TtsQjrlbhNmQFVxeQtzFSWdcCQKkbdl06VAMoSU3zZlJ4SwMRFLXAC
	 GeysXa4MoJN92PDt0SLRaVf3LicS68NvyzvUQxpoumyPIwxJON5w0GwPQxnyv2PmLV
	 h27n+tNp7YWMrBdjxSsY10A5RUkFvPGtg3oGTuWZWTfJGpLbsD5rU6fV8D9SR4qNB3
	 FMWP5mtjmfcfxfLQqg6EIeqgDKejecR6UvRI013HLVVqdIit4Cngvne4jdroItINSU
	 DTHsy+QW4miTg==
Date: Thu, 7 Mar 2024 20:40:17 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Andrey Albershteyn <aalbersh@redhat.com>, fsverity@lists.linux.dev,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	chandan.babu@oracle.com
Subject: Re: [PATCH v5 06/24] fsverity: pass tree_blocksize to
 end_enable_verity()
Message-ID: <20240308044017.GC8111@sol.localdomain>
References: <20240304191046.157464-2-aalbersh@redhat.com>
 <20240304191046.157464-8-aalbersh@redhat.com>
 <20240305005242.GE17145@sol.localdomain>
 <20240306163000.GP1927156@frogsfrogsfrogs>
 <20240307220224.GA1799@sol.localdomain>
 <20240308034650.GK1927156@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240308034650.GK1927156@frogsfrogsfrogs>

On Thu, Mar 07, 2024 at 07:46:50PM -0800, Darrick J. Wong wrote:
> > BTW, is xfs_repair planned to do anything about any such extra blocks?
> 
> Sorry to answer your question with a question, but how much checking is
> $filesystem expected to do for merkle trees?
> 
> In theory xfs_repair could learn how to interpret the verity descriptor,
> walk the merkle tree blocks, and even read the file data to confirm
> intactness.  If the descriptor specifies the highest block address then
> we could certainly trim off excess blocks.  But I don't know how much of
> libfsverity actually lets you do that; I haven't looked into that
> deeply. :/
> 
> For xfs_scrub I guess the job is theoretically simpler, since we only
> need to stream reads of the verity files through the page cache and let
> verity tell us if the file data are consistent.
> 
> For both tools, if something finds errors in the merkle tree structure
> itself, do we turn off verity?  Or do we do something nasty like
> truncate the file?

As far as I know (I haven't been following btrfs-progs, but I'm familiar with
e2fsprogs and f2fs-tools), there isn't yet any precedent for fsck actually
validating the data of verity inodes against their Merkle trees.

e2fsck does delete the verity metadata of inodes that don't have the verity flag
enabled.  That handles cleaning up after a crash during FS_IOC_ENABLE_VERITY.

I suppose that ideally, if an inode's verity metadata is invalid, then fsck
should delete that inode's verity metadata and remove the verity flag from the
inode.  Checking for a missing or obviously corrupt fsverity_descriptor would be
fairly straightforward, but it probably wouldn't catch much compared to actually
validating the data against the Merkle tree.  And actually validating the data
against the Merkle tree would be complex and expensive.  Note, none of this
would work on files that are encrypted.

Re: libfsverity, I think it would be possible to validate a Merkle tree using
libfsverity_compute_digest() and the callbacks that it supports.  But that's not
quite what it was designed for.

> Is there an ioctl or something that allows userspace to validate an
> entire file's contents?  Sort of like what BLKVERIFY would have done for
> block devices, except that we might believe its answers?

Just reading the whole file and seeing whether you get an error would do it.

Though if you want to make sure it's really re-reading the on-disk data, it's
necessary to drop the file's pagecache first.

> Also -- inconsistencies between the file data and the merkle tree aren't
> something that xfs can self-heal, right?

Similar to file data itself, only way to self-heal would be via mechanisms that
provide redundancy.  There's been some interest in adding support forward error
correction (FEC) to fsverity similar to what dm-verity has, but this would be
complex, and it's not something that anyone has gotten around to yet.

- Eric

