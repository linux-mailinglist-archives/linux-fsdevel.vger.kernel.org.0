Return-Path: <linux-fsdevel+bounces-74437-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 19585D3A7FA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 13:07:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 49445302DAF6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 12:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2CA435B12E;
	Mon, 19 Jan 2026 12:06:17 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F593590DB;
	Mon, 19 Jan 2026 12:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768824377; cv=none; b=Nvhjm9XDXt3Ca3fza2jvvnUdqNxag/A0cJGS/JxtnYv8LZma0g40s1L2aLNrJTIKkEWXB5iif7DgM4lFm0tCMZaugVQrE/u0ApsoD9CSJuBFrpODGXNEqmhZbYz7K2X9LXXCRMzb4i2lpULuSum7RN9WDekRLWVB7Apsy1C7fAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768824377; c=relaxed/simple;
	bh=Cr2GJL9XnBNnOtUICJ1ZUWD3ign/NX/f6uXN9QQy25I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fW7r+tdMcm7XQh8vf+M5FbB5XEmQOU4yT6jCGEGQtrN+8lmTErx7UnQ2+0N3+jvVT8E/5defuhC8OF48Oy1T4cMylhzvNc9AhPPq9adPbdNlvnyfvzc5C6yYFQ69cl+XoWWOZmfZT3OTIH7mWHPqvYay30coyxFZqWG/3li9k1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9BBA6227A88; Mon, 19 Jan 2026 13:06:11 +0100 (CET)
Date: Mon, 19 Jan 2026 13:06:11 +0100
From: Christoph Hellwig <hch@lst.de>
To: Christian Brauner <brauner@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Eric Biggers <ebiggers@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	David Sterba <dsterba@suse.com>, Theodore Ts'o <tytso@mit.edu>,
	Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
	Andrey Albershteyn <aalbersh@redhat.com>,
	linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	fsverity@lists.linux.dev
Subject: Re: [PATCH 3/6] fs,fsverity: handle fsverity in generic_file_open
Message-ID: <20260119120611.GA23787@lst.de>
References: <20260119062250.3998674-1-hch@lst.de> <20260119062250.3998674-4-hch@lst.de> <20260119-davon-krippenkind-78d683621491@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260119-davon-krippenkind-78d683621491@brauner>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Jan 19, 2026 at 11:02:37AM +0100, Christian Brauner wrote:
> > +	if (IS_ENABLED(CONFIG_FS_VERITY) && IS_VERITY(inode)) {
> > +		if (filp->f_mode & FMODE_WRITE)
> > +			return -EPERM;
> > +		return fsverity_file_open(inode, filp);
> > +	}
> 
> This is the only one where I'm not happy about the location.
> This hides the ordering requirement between fsverity and fscrypt. It's
> easier to miss now. This also really saves very little compared to the
> other changes. So I wonder whether it's really that big of a deal to
> have the call located in the open routines of the filesystems.

So my idea was to do a similar pass for fscrypt eventually, and enforce
the ordering in one place, instead of relying on file systems to get it
right.  I'd be fine with delaying this patch until then and give it
another try.  The good thing is that unlike say the stat hook fsverity
will simply not work without wiring this up, so it can't be easily
forgotten.

