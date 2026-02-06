Return-Path: <linux-fsdevel+bounces-76528-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eFkgCUpxhWn5BgQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76528-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 05:42:50 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C2FBFFA26F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 05:42:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 25D6F3019BAC
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Feb 2026 04:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41D4B2E62C0;
	Fri,  6 Feb 2026 04:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pYXJkcbp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C309F1F4181;
	Fri,  6 Feb 2026 04:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770352958; cv=none; b=hqyPiv053YhGdKZiO+Ldx/Ompu34et0pR0g7tCKtlEdpIsqLaHlUo1hTGdF+IgtM1Kltbs3IoHkhnVYxPUwo5l9O2lW3kz4EAbK8clJW88VBibVW+Pog2cafjIhdmMGoISXA4AJYRbRNM6mtZGDDxlxTD0N+PkVRunM+Xpoz9Pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770352958; c=relaxed/simple;
	bh=I2urq3HRSZd2U/WKLQGeb2xlxwHQeMuAVFdmWb2qq6k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=had3cQwcJtOWpdz2byXX7Gq5k7RrYTus6S+5ShnmgnPf12HRnhPJlSpWShdMcYLDHJIbMMiTsW+Kjmoc9+MGX5DcSo4B31GWIS7SIvO0rMCUhtON/kXPi9wb+UbxYcLpOxvecXdWUCFAhWve0NUKeN3tAanNNSqfznpHD9hwolU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pYXJkcbp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47E31C116C6;
	Fri,  6 Feb 2026 04:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770352958;
	bh=I2urq3HRSZd2U/WKLQGeb2xlxwHQeMuAVFdmWb2qq6k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pYXJkcbpf/IzfxQglbUnm6L8CbnibxemyyTRXseMEttDj6QjibMYrrm2OW9IKYyvV
	 ehK8ZL6oLvNTL8Oa2nHjp8Pl6VudgRyBkENdfU77hSYZfEJYdZ95j3BmWJ19zQRv3L
	 Z0FsxBcToI/1mfF68AnYbjg9eNgq1k0jSCVlMsc/TvhTIZ0V284iSHBUfflAQOpc5m
	 HzdsvRHx61tm8B4MbsBEhja7eKT12cVwBzxA+7+Z8deiryjGGuOMusYyRKKeVopUiE
	 viUJQfmScM8DPOFKg961Gf8CTVX5IfP35HG6NEVLCMCt9kopfnhDNaqaJUPjhxoxqQ
	 eep5pzCQ+sl/A==
Date: Thu, 5 Feb 2026 20:42:37 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Chris Mason <clm@meta.com>
Cc: miklos@szeredi.hu, joannelkoong@gmail.com, bernd@bsbernd.com,
	neal@gompa.dev, linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 07/10] fuse: enable iomap cache management
Message-ID: <20260206044237.GM7686@frogsfrogsfrogs>
References: <176169812012.1426649.16037866918992398523.stgit@frogsfrogsfrogs>
 <176169812229.1426649.17695442505194165425.stgit@frogsfrogsfrogs>
 <20260205184044.1551228-1-clm@meta.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260205184044.1551228-1-clm@meta.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[szeredi.hu,gmail.com,bsbernd.com,gompa.dev,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-76528-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C2FBFFA26F
X-Rspamd-Action: no action

On Thu, Feb 05, 2026 at 10:33:26AM -0800, Chris Mason wrote:
> "Darrick J. Wong" <djwong@kernel.org> wrote:
> > From: Darrick J. Wong <djwong@kernel.org>
> > 
> > Provide a means for the fuse server to upload iomappings to the kernel
> > and invalidate them.  This is how we enable iomap caching for better
> > performance.  This is also required for correct synchronization between
> > pagecache writes and writeback.
> > 
> 
> Hi everyone,
> 
> I'm trying out my AI review prompts on a few more trees, and I ran it
> on the fuse-iomap-cache branch:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/log/?h=fuse-iomap-cache
> 
> This was the latest email lore could find, apologies if I grabbed the wrong one.
> 
> Hopefully the review below is useful, please let me know if there are places it
> has gone wildly wrong.  I kept the header to make it obvious exactly which
> commit I'd run through:
> 
> commit 84c726dd312b652c0fd2d4f43d65eefd16bfa901
> Author: Darrick J. Wong <djwong@kernel.org>
> 
> fuse: enable iomap cache management
> 
> This commit provides a means for the fuse server to upload iomappings to
> the kernel and invalidate them, enabling iomap caching for better
> performance and ensuring correct synchronization between pagecache writes
> and writeback.
> 
> > diff --git a/fs/fuse/fuse_iomap.c b/fs/fuse/fuse_iomap.c
> > index b56718dd256a6..dcadd66f6ec95 100644
> > --- a/fs/fuse/fuse_iomap.c
> > +++ b/fs/fuse/fuse_iomap.c
> 
> [ ... ]
> 
> > +int fuse_iomap_inval(struct fuse_conn *fc,
> > +		     const struct fuse_iomap_inval_out *outarg)
> > +{
> > +	struct inode *inode;
> > +	struct fuse_inode *fi;
> > +	int ret = 0, ret2 = 0;
> > +
> > +	if (!fc->iomap)
> > +		return -EINVAL;
> > +
> > +	down_read(&fc->killsb);
> > +	inode = fuse_ilookup(fc, outarg->nodeid, NULL);
> > +	if (!inode) {
> > +		ret = -ESTALE;
> > +		goto out_sb;
> > +	}
> > +
> > +	fi = get_fuse_inode(inode);
> > +	if (BAD_DATA(fi->orig_ino != outarg->attr_ino)) {
> > +		ret = -EINVAL;
> > +		goto out_inode;
> > +	}
> > +
> > +	if (fuse_is_bad(inode)) {
> > +		ret = -EIO;
> > +		goto out_inode;
> > +	}
> > +
> > +	if (!fuse_iomap_inval_validate(inode, outarg->write_offset,
> > +				       outarg->write_length)) {
> > +		ret = -EFSCORRUPTED;
> > +		goto out_inode;
> > +	}
> > +
> > +	if (!fuse_iomap_inval_validate(inode, outarg->read_offset,
> > +				       outarg->read_length)) {
> > +		ret = -EFSCORRUPTED;
> > +		goto out_inode;
> > +	}
> > +
> > +	fuse_iomap_cache_lock(inode);
> > +	if (outarg->read_length)
> > +		ret2 = fuse_iomap_cache_remove(inode, READ_MAPPING,
> > +					       outarg->read_offset,
> > +					       outarg->read_length);
> > +	if (outarg->write_length)
> > +		ret = fuse_iomap_cache_remove(inode, WRITE_MAPPING,
> > +					      outarg->write_offset,
> > +					      outarg->write_length);
> > +	fuse_iomap_cache_unlock(inode);
> >                    ^^^^
> 
> Can fuse_iomap_cache_lock() dereference a NULL pointer here? Looking at

Yes.  For those of you reading the parent message you might be confused
because the 29 Oct posting embedded the iomap cache directly in struct
fuse_inode so there was no possibility of a NULL pointer dereference.

Based on feedback from Joanne I changed fuse_inode to point to a
fuse_iomap_cache object, which the AI has now caught.  Excellent!

> fuse_iomap_upsert() above, there's a check for fuse_inode_caches_iomaps()
> before accessing the cache and allocating if necessary. In fuse_iomap_inval(),
> there's no such check before calling fuse_iomap_cache_lock().
> 
> fuse_iomap_cache_lock() accesses fi->cache and calls down_write(&ic->ic_lock),
> which will crash if fi->cache is NULL. This could happen when a fuse server
> sends FUSE_NOTIFY_IOMAP_INVAL for an inode that never had mappings upserted
> to it.
> 
> Should fuse_iomap_inval() check fuse_inode_caches_iomaps(inode) before
> calling fuse_iomap_cache_lock()? If the cache doesn't exist, there's
> nothing to invalidate, so returning early (perhaps with 0 or -EINVAL)
> would be appropriate.

I'll have it return 0 because no cache means cache invalidation is a
nop.  Thanks for your review help, Chris!

--D

