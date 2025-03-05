Return-Path: <linux-fsdevel+bounces-43287-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6A9DA50A3F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Mar 2025 19:49:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F1607A9510
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Mar 2025 18:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DACCF253B71;
	Wed,  5 Mar 2025 18:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="it+H1gaB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 363EB25179E;
	Wed,  5 Mar 2025 18:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741200516; cv=none; b=Jajrz1zKE63CusioinmwfTTk69pZGcNSoMTuipl1e6zGDxw6Yu5LsX9IS+GLwuZgNNrH0vj44haCaT0OMrlZfa+nT4L8g8MwYGoyKFM1k0PsG35uZY0n7qMN0dYgdGZqs0e7nHkiSnEgXtfBMLIT/VbjJzsClgILvTBAtxgZmxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741200516; c=relaxed/simple;
	bh=wel2R8QVy27EKiGZf1o/TwGcyJNnKp1OngV/HowqlWs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qu0+nidWn1t9C8C4YsqJHqy6vfjB9vAJys9NAmLjkRlgV1BOrK4lZcWGbAljMwaFAue9KGrnErzI7TrQ+WvZ3kOh3rXbCjXDAKEQ3i9FlW0NJsze6Lq62Ws7XgdrAgF5tEVU3tm4GPInodegD6ZHtmIptTf2n8krsakuWF9Jvhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=it+H1gaB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CAD5C4CEE0;
	Wed,  5 Mar 2025 18:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741200514;
	bh=wel2R8QVy27EKiGZf1o/TwGcyJNnKp1OngV/HowqlWs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=it+H1gaBIr4l6YFVJwudnADMG34ihH8fwzBvXfsb3ft9ouvQKzpQsvfzX3XlwKoHd
	 esNWY48VZEhviEWIBxPCo3/lPuUzAbkCkZ+CaXOh6kVC5tF6tNUoRqp+/ToOomDmQd
	 7mdkLSK0+KPOlbkqe7SEieWeeEzOvdEJFJZH+PY1hvnKEcTzAg8WKpfGNf6ZsUeEim
	 cipHZbGBJLdfoLAMdGHQ5uxfjEpb9KUziQ9twD5gYPa3EJ/EqPJ+zMeEP2oFRdThF8
	 yxqAMKiJZ/Ue5lTmHuRmTMeHgWUUu9+fX3oXwd5tbTaI6rK5n2+00MmHxlWGYAtC84
	 qjfXfT4K/n0mg==
Date: Wed, 5 Mar 2025 10:48:34 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: Matthew Wilcox <willy@infradead.org>, brauner@kernel.org, hare@suse.de,
	david@fromorbit.com, kbusch@kernel.org, john.g.garry@oracle.com,
	hch@lst.de, ritesh.list@gmail.com, linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org, gost.dev@samsung.com,
	p.raghav@samsung.com, da.gomez@samsung.com, kernel@pankajraghav.com,
	Kent Overstreet <kent.overstreet@linux.dev>
Subject: Re: [PATCH] bdev: add back PAGE_SIZE block size validation for
 sb_set_blocksize()'
Message-ID: <20250305184834.GE2803771@frogsfrogsfrogs>
References: <20250305015301.1610092-1-mcgrof@kernel.org>
 <Z8fpZWHNs8eI5g38@casper.infradead.org>
 <20250305063330.GA2803730@frogsfrogsfrogs>
 <Z8hck6aKEopiezug@casper.infradead.org>
 <Z8iEMv354ThMRr0b@bombadil.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8iEMv354ThMRr0b@bombadil.infradead.org>

On Wed, Mar 05, 2025 at 09:04:50AM -0800, Luis Chamberlain wrote:
> On Wed, Mar 05, 2025 at 02:15:47PM +0000, Matthew Wilcox wrote:
> > On Tue, Mar 04, 2025 at 10:33:30PM -0800, Darrick J. Wong wrote:
> > > > So this is expedient because XFS happens to not call sb_set_blocksize()?
> > > > What is the path forward for filesystems which call sb_set_blocksize()
> > > > today and want to support LBS in future?
> > > 
> > > Well they /could/ set sb_blocksize/sb_blocksize_bits themselves, like
> > > XFS does.
> > 
> > I'm kind of hoping that isn't the answer.
> 
> set_blocksize() can be used. The only extra steps the filesystem needs
> to in addition is:
> 
> 	sb->s_blocksize = size;
> 	sb->s_blocksize_bits = blksize_bits(size);
> 
> Which is what both XFS and bcachefs do.
> 
> We could modify sb to add an LBS flag but that alone would not suffice
> either as the upper limit is still a filesystem specific limit. Additionally
> it also does not suffice for filesystems that support a different device
> for metadata writes, for instance XFS supports this and uses the sector
> size for set_blocksize().
> 
> So I think that if ext4 for example wants to use LBS then simply it
> would open code the above two lines and use set_blocksize(). Let me know
> if you have any other recommendations.

int sb_set_large_blocksize(struct super_block *sb, int size)
{
	if (set_blocksize(sb->s_bdev_file, size))
		return 0;
	sb->s_blocksize = size;
	sb->s_blocksize_bits = blksize_bits(size);
	return sb->s_blocksize;
}
EXPORT_SYMBOL_GPL(sb_set_large_blocksize);

int sb_set_blocksize(struct super_block *sb, int size)
{
	if (size > PAGE_SIZE)
		return 0;
	return sb_set_large_blocksize(sb, size);
}
EXPORT_SYMBOL(sb_set_blocksize);

Though you'll note that this doesn't help XFS, or any other filesystem
where the bdev block size isn't set to the fs block size.  But xfs can
just be weird on its own like always. ;)

--D

> 
>   Luis

