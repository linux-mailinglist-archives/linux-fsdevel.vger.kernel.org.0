Return-Path: <linux-fsdevel+bounces-24850-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BEE1A94580D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Aug 2024 08:30:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A7981F241A8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Aug 2024 06:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4559438F9C;
	Fri,  2 Aug 2024 06:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="NdvIv6q0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C86282FA
	for <linux-fsdevel@vger.kernel.org>; Fri,  2 Aug 2024 06:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722580192; cv=none; b=dbvPOGCxfKETWhFKD9f6q0FTrEZ9vk+z9Mgec7EBD9H1zx91zir25gIKwl35y7u+Opf8UbS/3PP+ejc1Xyzs2084xdqU9ZdjUOCALtABjRsPfzkIwmrrsq9J+TAz7dqlVAjQMGLwjYpjW+X2942/jf70ABL1riAjes1L83my62Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722580192; c=relaxed/simple;
	bh=Ncrd++OEIxe65yHwqnlLyZ4Z2l4NA2W8IDs1ESGT+lc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FSLeBBc9j4xBoyCrXERtEBf73+zYsg5cuFJwrxte1ctOTw9lnZV/2ycF9JdwLOOuGwQgRVN7Y6uSqTzt8xvgpbarvoZ15I5MRHQKLpCsw93mmtEpcUWocWY4m3b9EC/PVMjH+OKYkiHXbgr0p1YawJX8g4IvleFQgxVc/GXX98E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=NdvIv6q0; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1fc56fd4de1so22012495ad.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 01 Aug 2024 23:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1722580190; x=1723184990; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dxts+ByNxv6qEnlrsjNu2IlvXYdrlkHts46qfJU5adg=;
        b=NdvIv6q0yYnVb0AppKv6wjbt8EYKOVoAtmxsl9jc1cmi8ZqeDWAIfFlJRKLZJPjbc2
         XAXxD1riCizLdD5acdPPLpcnmDMu1XnU9nqysP6Be8LbrMFQ8Vu35swF+OLbMKOK4QQi
         oMlax2rqbV4newaxH9sbrumamV/8+pdKqERpWKRaIoNkAKMt3M3xIT1w4xXBy7ZB4f86
         XLY3QFpCaMJwdtrAyHCfyA7JC97RCOy28Wc/PTNEYGy5XZFa5jsnG2d5AgEZ9vqCp16e
         6UC6F5nL7+G2SV9GuxkP7hpVLl/9PBxFDB/T+vRA3B8yL4b/l1PJTN58cviDg6xVVUCe
         9ALA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722580190; x=1723184990;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dxts+ByNxv6qEnlrsjNu2IlvXYdrlkHts46qfJU5adg=;
        b=bgpAcxwqhIzhuWtq95am3cKMTm4Qcp9FH/addMxfZ3a0gisL9N3Jp2vO88xAc9J7wy
         WOA1sTA39sdTI1EMTPJ1sDhP4LA4qRvrHvomyHmfehKu9R8/ioYD7eG/Ujn4USXXuohF
         sdcrON4ohQ4XxOtqHmpH+aw8PTxty8v29u64gRjYcZWTI93SfXandUSIlBOKN1va5hiT
         MEeEl2d5bYAPaGF/FuDgivPVlYBEpKpPjTRRQdE2cKnM7Iiug0ZmUaKDacYwTcROwMEC
         oc9wgPtVQGp6zqpcqmHPda9T6uJYK4E6NfDI1ckw9T4JaO5WPA5e1gRuJ5BfImvfdWZG
         wdcA==
X-Forwarded-Encrypted: i=1; AJvYcCXZ5T04EXO19tjIjIPBBw6NuPqXYk7FVX4XGlrMdeSUx9nRH+inh7wHiY4lOYGINwk456VS2qAKqDP3cZb9ENNeT/jrTn9KCDf2tO8rgg==
X-Gm-Message-State: AOJu0Yxbme4tS5E/PKCN0O6rf/SngNDr0R3yj+xSWBqqd8UDTJCuYkJq
	Xw9aeO7TRcHRfyHsDzVuDE5MZicWB7J/58cXy6B3Wceh8w6NDM2nEXbH09bsoD8=
X-Google-Smtp-Source: AGHT+IHGcNBJOT7nNItQ4srDPyP9HCLfF6C7ZcF7Y6StEbuBIUW47lVCmTsUUpUqwIRp67Ldz8QDSA==
X-Received: by 2002:a17:903:32cf:b0:1f9:a69d:4e05 with SMTP id d9443c01a7336-1ff524418e3mr61197825ad.19.1722580190266;
        Thu, 01 Aug 2024 23:29:50 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-47-239.pa.nsw.optusnet.com.au. [49.181.47.239])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff592b7d2csm9213975ad.300.2024.08.01.23.29.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 23:29:49 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1sZlnP-002MaP-16;
	Fri, 02 Aug 2024 16:29:47 +1000
Date: Fri, 2 Aug 2024 16:29:47 +1000
From: Dave Chinner <david@fromorbit.com>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, djwong@kernel.org, hch@infradead.org,
	brauner@kernel.org, jack@suse.cz, yi.zhang@huawei.com,
	chengzhihao1@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH 5/6] iomap: drop unnecessary state_lock when setting ifs
 uptodate bits
Message-ID: <Zqx824ty5yvwdvXO@dread.disaster.area>
References: <20240731091305.2896873-1-yi.zhang@huaweicloud.com>
 <20240731091305.2896873-6-yi.zhang@huaweicloud.com>
 <Zqwi48H74g2EX56c@dread.disaster.area>
 <b40a510d-37b3-da50-79db-d56ebd870bf0@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b40a510d-37b3-da50-79db-d56ebd870bf0@huaweicloud.com>

On Fri, Aug 02, 2024 at 10:57:41AM +0800, Zhang Yi wrote:
> On 2024/8/2 8:05, Dave Chinner wrote:
> > On Wed, Jul 31, 2024 at 05:13:04PM +0800, Zhang Yi wrote:
> >> From: Zhang Yi <yi.zhang@huawei.com>
> >>
> >> Commit '1cea335d1db1 ("iomap: fix sub-page uptodate handling")' fix a
> >> race issue when submitting multiple read bios for a page spans more than
> >> one file system block by adding a spinlock(which names state_lock now)
> >> to make the page uptodate synchronous. However, the race condition only
> >> happened between the read I/O submitting and completeing threads,
> > 
> > when we do writeback on a folio that has multiple blocks on it we
> > can submit multiple bios for that, too. Hence the write completions
> > can race with each other and write submission, too.
> > 
> > Yes, write bio submission and completion only need to update ifs
> > accounting using an atomic operation, but the same race condition
> > exists even though the folio is fully locked at the point of bio
> > submission.
> > 
> > 
> >> it's
> >> sufficient to use page lock to protect other paths, e.g. buffered write
> >                     ^^^^ folio
> >> path.
> >>
> >> After large folio is supported, the spinlock could affect more
> >> about the buffered write performance, so drop it could reduce some
> >> unnecessary locking overhead.
> > 
> > From the point of view of simple to understand and maintain code, I
> > think this is a bad idea. The data structure is currently protected
> > by the state lock in all situations, but this change now makes it
> > protected by the state lock in one case and the folio lock in a
> > different case.
> 
> Yeah, I agree that this is a side-effect of this change, after this patch,
> we have to be careful to distinguish between below two cases B1 and B2 as
> Willy mentioned.
> 
> B. If ifs_set_range_uptodate() is called from iomap_set_range_uptodate(),
>    either we know:
> B1. The caller of iomap_set_range_uptodate() holds the folio lock, and this
>     is the only place that can call ifs_set_range_uptodate() for this folio
> B2. The caller of iomap_set_range_uptodate() holds the state lock

Yes, I read that before I commented that I think it's a bad idea.
And then provided a method where we don't need to care about this at
all.
> 
> > 
> > Making this change also misses the elephant in the room: the
> > buffered write path still needs the ifs->state_lock to update the
> > dirty bitmap. Hence we're effectively changing the serialisation
> > mechanism for only one of the two ifs state bitmaps that the
> > buffered write path has to update.
> > 
> > Indeed, we can't get rid of the ifs->state_lock from the dirty range
> > updates because iomap_dirty_folio() can be called without the folio
> > being locked through folio_mark_dirty() calling the ->dirty_folio()
> > aop.
> > 
> 
> Sorry, I don't understand, why folio_mark_dirty() could be called without
> folio lock (isn't this supposed to be a bug)?  IIUC, all the file backed
> folios must be locked before marking dirty. Are there any exceptions or am
> I missing something?

Yes: reading the code I pointed you at.

/**
 * folio_mark_dirty - Mark a folio as being modified.
 * @folio: The folio.
 *
 * The folio may not be truncated while this function is running.
 * Holding the folio lock is sufficient to prevent truncation, but some
 * callers cannot acquire a sleeping lock.  These callers instead hold
 * the page table lock for a page table which contains at least one page
 * in this folio.  Truncation will block on the page table lock as it
 * unmaps pages before removing the folio from its mapping.
 *
 * Return: True if the folio was newly dirtied, false if it was already dirty.
 */

So, yes, ->dirty_folio() can indeed be called without the folio
being locked and it is not a bug.

Hence we have to serialise ->dirty_folio against both
__iomap_write_begin() dirtying the folio and iomap_writepage_map()
clearing the dirty range.

And that means we alway need to take the ifs->state_lock in
__iomap_write_begin() when we have an ifs attached to the folio.
Hence it is a) not correct and b) makes no sense to try to do
uptodate bitmap updates without it held...

> > IOWs, getting rid of the state lock out of the uptodate range
> > changes does not actually get rid of it from the buffered IO patch.
> > we still have to take it to update the dirty range, and so there's
> > an obvious way to optimise the state lock usage without changing any
> > of the bitmap access serialisation behaviour. i.e.  We combine the
> > uptodate and dirty range updates in __iomap_write_end() into a
> > single lock context such as:
> > 
> > iomap_set_range_dirty_uptodate()
> > {
> > 	struct iomap_folio_state *ifs = folio->private;
> > 	struct inode *inode:
> >         unsigned int blks_per_folio;
> >         unsigned int first_blk;
> >         unsigned int last_blk;
> >         unsigned int nr_blks;
> > 	unsigned long flags;
> > 
> > 	if (!ifs)
> > 		return;
> > 
> > 	inode = folio->mapping->host;
> > 	blks_per_folio = i_blocks_per_folio(inode, folio);
> > 	first_blk = (off >> inode->i_blkbits);
> > 	last_blk = (off + len - 1) >> inode->i_blkbits;
> > 	nr_blks = last_blk - first_blk + 1;
> > 
> > 	spin_lock_irqsave(&ifs->state_lock, flags);
> > 	bitmap_set(ifs->state, first_blk, nr_blks);
> > 	bitmap_set(ifs->state, first_blk + blks_per_folio, nr_blks);
> > 	spin_unlock_irqrestore(&ifs->state_lock, flags);
> > }
> > 
> > This means we calculate the bitmap offsets only once, we take the
> > state lock only once, and we don't do anything if there is no
> > sub-folio state.
> > 
> > If we then fix the __iomap_write_begin() code as Willy pointed out
> > to elide the erroneous uptodate range update, then we end up only
> > taking the state lock once per buffered write instead of 3 times per
> > write.
> > 
> > This patch only reduces it to twice per buffered write, so doing the
> > above should provide even better performance without needing to
> > change the underlying serialisation mechanism at all.
> > 
> 
> Thanks for the suggestion. I've thought about this solution too, but I
> didn't think we need the state_lock when setting ifs dirty bit since the
> folio lock should work, so I changed my mind and planed to drop all ifs
> state_lock in the write path (please see the patch 6). Please let me
> know if I'm wrong.

Whether it works or not is irrelevant: it is badly designed code
that you have proposed. We can acheive the same result without
changing the locking rules for the bitmap data via a small amount of
refactoring, and that is a much better solution than creating
complex and subtle locking rules for the object.

"But it works" doesn't mean the code is robust, maintainable code.

So, good optimisation, but NACK in this form. Please rework it to
only take the ifs->state_lock once for both bitmap updates in the
__iomap_write_end() path.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

