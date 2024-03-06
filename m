Return-Path: <linux-fsdevel+bounces-13773-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F496873C41
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 17:30:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E392B1F28794
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 16:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74131137921;
	Wed,  6 Mar 2024 16:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PDnwyOFF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF9F137904;
	Wed,  6 Mar 2024 16:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709742601; cv=none; b=BnbJ/H5gr2Vc0WpqlGqnG52pfWp04lzXRuYhluXMuNRBpodGDZpe7Frp57u+XuOsAFc1NNUMoxDpqghZh8gm2Bh8eC3ygDjguQxl9If5k9BIiDrSnsUnyktraATRk7QaDj2VfQCwMSC418cNIXN0llNtSkG3jBJAEPwfUTM+ay0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709742601; c=relaxed/simple;
	bh=eZV8riaJEUdxsSABB6D99YhMGQQ6hWkHmvjxZv84qBg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eO3A25D7iQkkfdJET2UFalta1ZLbegMbwPygS+pX64PC/Wx9QAzrF5nkwVtfp1OxXnShqFXc4WMzTru27OqObGov8pZPr1n9iMPqPralmQTl/n7ObhoBPoVmPeU68Tgg3l8XdK3xQCvBM7ZaOStzS76FWqSNUDccaLl32s8zfeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PDnwyOFF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48A58C433F1;
	Wed,  6 Mar 2024 16:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709742601;
	bh=eZV8riaJEUdxsSABB6D99YhMGQQ6hWkHmvjxZv84qBg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PDnwyOFFVdJYfgXJmffTwYOj/bUW6rB1YDbcEXGprSv56hQpl2SRO8NpP+05fhCs8
	 Pc1oRyQsL1H0EL2nAAALg/+Fo7b648aqnum641Yo6vofMtGj2goSGatwUEgAhmmDzW
	 NsANXCcCq/h7c3dbfX8ObJDFUzTipdUUhHtlG5BAQD0fCwkMPC7jk2TJsgoYouVlVe
	 UTtbzehZVe5RzliigtIr+yzy7Vzi2QpGdPoVpnBRT4BN0hRY9qa3grMuDFCd4GrSc7
	 CWubCSyyC4PM17G9kgXn/B4XTGdwTPAx8ZCQnUhAiwWVvVQYM8DPjWT1JCV0FxdlpV
	 c2+wF+dZJIknQ==
Date: Wed, 6 Mar 2024 08:30:00 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Andrey Albershteyn <aalbersh@redhat.com>, fsverity@lists.linux.dev,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	chandan.babu@oracle.com
Subject: Re: [PATCH v5 06/24] fsverity: pass tree_blocksize to
 end_enable_verity()
Message-ID: <20240306163000.GP1927156@frogsfrogsfrogs>
References: <20240304191046.157464-2-aalbersh@redhat.com>
 <20240304191046.157464-8-aalbersh@redhat.com>
 <20240305005242.GE17145@sol.localdomain>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240305005242.GE17145@sol.localdomain>

On Mon, Mar 04, 2024 at 04:52:42PM -0800, Eric Biggers wrote:
> On Mon, Mar 04, 2024 at 08:10:29PM +0100, Andrey Albershteyn wrote:
> > XFS will need to know tree_blocksize to remove the tree in case of an
> > error. The size is needed to calculate offsets of particular Merkle
> > tree blocks.
> > 
> > Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
> > ---
> >  fs/btrfs/verity.c        | 4 +++-
> >  fs/ext4/verity.c         | 3 ++-
> >  fs/f2fs/verity.c         | 3 ++-
> >  fs/verity/enable.c       | 6 ++++--
> >  include/linux/fsverity.h | 4 +++-
> >  5 files changed, 14 insertions(+), 6 deletions(-)
> 
> How will XFS handle dropping a file's incomplete tree if the system crashes
> while it's being built?

AFAICT it simply leaves the half-constructed tree in the xattrs data.

> I think this is why none of the other filesystems have needed the tree_blocksize
> in ->end_enable_verity() yet.  They need to be able to drop the tree from just
> the information the filesystem has on-disk anyway.  ext4 and f2fs just truncate
> past EOF, while btrfs has some code that finds all the verity metadata items and
> deletes them (see btrfs_drop_verity_items() in fs/btrfs/verity.c).
> 
> Technically you don't *have* to drop incomplete trees, since it shouldn't cause
> a behavior difference.  But it seems like something that should be cleaned up.

If it's required that a failed FS_IOC_ENABLE_VERITY clean up the
unfinished merkle tree, then you'd have to introduce some kind of log
intent item to roll back blocks from an unfinished tree.  That log
item has to be committed as the first item in a chain of transactions,
each of which adds a merkle tree block and relogs the rollback item.
When we finish the tree, we log a done item to whiteout the intent.

Log recovery, upon finding an intent without the done item, will replay
the intent, which (in this case) will remove all the blocks.  In theory
a failed merkle tree commit also should do this, but most likely that
will cause an fs shutdown anyway.

(That's a fair amount of work.)

Or you could leave the unfinished tree as-is; that will waste space, but
if userspace tries again, the xattr code will replace the old merkle
tree block contents with the new ones.  This assumes that we're not
using XATTR_CREATE during FS_IOC_ENABLE_VERITY.

--D

> 
> - Eric
> 

