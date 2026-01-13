Return-Path: <linux-fsdevel+bounces-73378-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 037D5D173E3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 09:18:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 48BE9307DBE0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 08:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0376537BE95;
	Tue, 13 Jan 2026 08:15:43 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1EC37BE84;
	Tue, 13 Jan 2026 08:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768292142; cv=none; b=WhmmrF13p4EqnrAhirpbVXupavTGq7pRXdSI0JxqXexFwIgX10tSzLRkFMwh0nGltrUHfkC/5dW4TtPsrhNnKzdKOXb0GLWsk/X2VQuu/iVjsjkbBiwJjphvWr0XT2mffhwVAkkT7JNivxMWMDkVtJDS8lYteF5tG28JKqyDJfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768292142; c=relaxed/simple;
	bh=fPmWMt142u8uvs1/G9PFe7JJPQLIHkde9s/GwdIF9rQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t7ocdHjJG5Z/cHFGa1qfqPD5rf4Neq1LqxP3Qm+Nx+zTsEmGJNeZ6xMKMzabyeg3NwM4CAGVjxSvRFt5USIqli0LLleMM88eOqMkpZosaNLOBjqcgGmXaZL3KwEfewegivIN6HApU25ZhcFDScddg+nHewmIQndEfVMZE/0lNco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 64AF067373; Tue, 13 Jan 2026 09:15:36 +0100 (CET)
Date: Tue, 13 Jan 2026 09:15:35 +0100
From: Christoph Hellwig <hch@lst.de>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Andrey Albershteyn <aalbersh@redhat.com>, fsverity@lists.linux.dev,
	linux-xfs@vger.kernel.org, ebiggers@kernel.org,
	linux-fsdevel@vger.kernel.org, aalbersh@kernel.org,
	david@fromorbit.com, hch@lst.de
Subject: Re: [PATCH v2 4/22] iomap: allow iomap_file_buffered_write() take
 iocb without file
Message-ID: <20260113081535.GC30809@lst.de>
References: <cover.1768229271.patch-series@thinky> <kibhid6bipmrndfn774tlbm6wcitya5qydhjws3n6tnjvbd4a3@bui63p535b3q> <20260112222215.GJ15551@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260112222215.GJ15551@frogsfrogsfrogs>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Jan 12, 2026 at 02:22:15PM -0800, Darrick J. Wong wrote:
> > +		iter.inode = iocb->ki_filp->f_mapping->host;
> > +	} else {
> > +		iter.inode = (struct inode *)private;
> 
> @private is for the filesystem implementation to access, not the generic
> iomap code.  If this is intended for fsverity, then shouldn't merkle
> tree construction be the only time that fsverity writes to the file?
> And shouldn't fsverity therefore have access to the struct file?

It's not passed down, but I think it could easily.

> 
> > +		iter.flags |= IOMAP_F_BEYOND_EOF;
> 
> IOMAP_F_ flags are mapping state flags for struct iomap::flags, not the
> iomap_iter.

But we could fix this part as well by having a specific helper for
fsverity that is called instead of iomap_file_buffered_write.
Neither the iocb, nor struct file are used inside of iomap_write_iter.
So just add a new helper that takes an inode, sets the past-EOF/verify
flag and open codes the iomap_iter/iomap_write_iter loop.


