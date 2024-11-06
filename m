Return-Path: <linux-fsdevel+bounces-33744-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6E209BE753
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Nov 2024 13:13:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29422B235F3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Nov 2024 12:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A8221DF27F;
	Wed,  6 Nov 2024 12:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="LlFYUwRR";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="um2T/57x";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="LlFYUwRR";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="um2T/57x"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C39B51DE8A2;
	Wed,  6 Nov 2024 12:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730895179; cv=none; b=sDc6RlWpqXB4WOQ4fhvbpt9pcOgOhRalWuI7B9sPUQSmuy2wLlukZ+0Yh8Ibi7u5y9SSiuIrsQaUUSyYbf29eUrlg+vKmRAhPwmCwoYsAk1Q+5CzizvYGqAEW6QoRuNspXctgWHbyYIsglZTTBqtF2Xdxs2C9EbPoKtqZPJT04o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730895179; c=relaxed/simple;
	bh=bXddG/FveR3aoMYiGsTGUJ6RgqDcjco2B6ViSIbeW/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aaSRmQ3BBc4D7t03m1nDcnypi8tZt2TS301/lJcNZCTOg5A2YJLeSf8bgDfX+noi4fbjjYIKAjqYNm8AzbRgoStbmkUhsA/PbRwjn1Tng7yUtP2ha3YGuW0L7OVZFjS65K6DL6UDmxkiMwn28KSgTG6ABPuAmNvIJrkK9j5eYTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=LlFYUwRR; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=um2T/57x; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=LlFYUwRR; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=um2T/57x; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0182921D0E;
	Wed,  6 Nov 2024 12:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1730895176; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=njeZ+yQRun/jfDycNnUBiUijgBXsw9RdOZfZ3I2Tq/o=;
	b=LlFYUwRRPbctZ+3xls0nBnIw15XiqtZQTC7BpqZOHm0xQOfpu8EK5zJ4Xwn2DtV8AnX4hJ
	lQay8q0oYs4Rz99uYQue+vIKSwUpPzfdL0y30LSy6bqKFQ0bVSMjWdHyviCIGGb58HWHLw
	HDueTuJJW56Sn0z0gdM4F21fQuPGL0M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1730895176;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=njeZ+yQRun/jfDycNnUBiUijgBXsw9RdOZfZ3I2Tq/o=;
	b=um2T/57xWiDaF0NT/sM4ClpAxBBp/xy3SLHXDxmf+sckJk+VqJJTJTC7u2SX0fZueRThz8
	FmugQBNM+majrSAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1730895176; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=njeZ+yQRun/jfDycNnUBiUijgBXsw9RdOZfZ3I2Tq/o=;
	b=LlFYUwRRPbctZ+3xls0nBnIw15XiqtZQTC7BpqZOHm0xQOfpu8EK5zJ4Xwn2DtV8AnX4hJ
	lQay8q0oYs4Rz99uYQue+vIKSwUpPzfdL0y30LSy6bqKFQ0bVSMjWdHyviCIGGb58HWHLw
	HDueTuJJW56Sn0z0gdM4F21fQuPGL0M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1730895176;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=njeZ+yQRun/jfDycNnUBiUijgBXsw9RdOZfZ3I2Tq/o=;
	b=um2T/57xWiDaF0NT/sM4ClpAxBBp/xy3SLHXDxmf+sckJk+VqJJTJTC7u2SX0fZueRThz8
	FmugQBNM+majrSAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E619113980;
	Wed,  6 Nov 2024 12:12:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id EBTjN0ddK2cBCgAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 06 Nov 2024 12:12:55 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 8E3B4A0AF6; Wed,  6 Nov 2024 13:12:55 +0100 (CET)
Date: Wed, 6 Nov 2024 13:12:55 +0100
From: Jan Kara <jack@suse.cz>
To: Asahi Lina <lina@asahilina.net>
Cc: Dave Chinner <david@fromorbit.com>, Jan Kara <jack@suse.cz>,
	Dan Williams <dan.j.williams@intel.com>,
	Matthew Wilcox <willy@infradead.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Sergio Lopez Pascual <slp@redhat.com>,
	linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev,
	linux-kernel@vger.kernel.org, asahi@lists.linux.dev
Subject: Re: [PATCH] dax: Allow block size > PAGE_SIZE
Message-ID: <20241106121255.yfvlzcomf7yvrvm7@quack3>
References: <20241101-dax-page-size-v1-1-eedbd0c6b08f@asahilina.net>
 <20241104105711.mqk4of6frmsllarn@quack3>
 <7f0c0a15-8847-4266-974e-c3567df1c25a@asahilina.net>
 <ZylHyD7Z+ApaiS5g@dread.disaster.area>
 <21f921b3-6601-4fc4-873f-7ef8358113bb@asahilina.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21f921b3-6601-4fc4-873f-7ef8358113bb@asahilina.net>
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Flag: NO
X-Spam-Level: 

On Wed 06-11-24 19:55:23, Asahi Lina wrote:
> On 11/5/24 7:16 AM, Dave Chinner wrote:
> > On Tue, Nov 05, 2024 at 12:31:22AM +0900, Asahi Lina wrote:
> > Unfortunately, the DAX infrastructure is independent of the page
> > cache but is also tightly tied to PAGE_SIZE based inode->i_mapping
> > index granularity. In a way, this is even more fundamental than the
> > page cache issues we had to solve. That's because we don't have
> > folios with their own locks and size tracking. In DAX, we use the
> > inode->i_mapping xarray entry for a given file offset to -serialise
> > access to the backing pfn- via lock bits held in the xarray entry.
> > We also encode the size of the dax entry in bits held in the xarray
> > entry.
> > 
> > The filesystem needs to track dirty state with filesystem block
> > granularity. Operations on filesystem blocks (e.g. partial writes,
> > page faults) need to be co-ordinated across the entire filesystem
> > block. This means we have to be able to lock a single filesystem
> > block whilst we are doing instantiation, sub-block zeroing, etc.
> 
> Ah, so it's about locking? I had a feeling that might be the case...

Yes. About locking and general state tracking.

> > Large folio support in the page cache provided this "single tracking
> > object for a > PAGE_SIZE range" support needed to allow fsb >
> > page_size in filesystems. The large folio spans the entire
> > filesystem block, providing a single serialisation and state
> > tracking for all the page cache operations needing to be done on
> > that filesystem block.
> > 
> > The DAX infrastructure needs the same changes for fsb > page size
> > support. We have a limited number bits we can use for DAX entry
> > state:
> > 
> > /*
> >  * DAX pagecache entries use XArray value entries so they can't be mistaken
> >  * for pages.  We use one bit for locking, one bit for the entry size (PMD)
> >  * and two more to tell us if the entry is a zero page or an empty entry that
> >  * is just used for locking.  In total four special bits.
> >  *
> >  * If the PMD bit isn't set the entry has size PAGE_SIZE, and if the ZERO_PAGE
> >  * and EMPTY bits aren't set the entry is a normal DAX entry with a filesystem
> >  * block allocation.
> >  */
> > #define DAX_SHIFT       (4)
> > #define DAX_LOCKED      (1UL << 0)
> > #define DAX_PMD         (1UL << 1)
> > #define DAX_ZERO_PAGE   (1UL << 2)
> > #define DAX_EMPTY       (1UL << 3)
> > 
> > I *think* that we have at most PAGE_SHIFT worth of bits we can
> > use because we only store the pfn part of the pfn_t in the dax
> > entry. There are PAGE_SHIFT high bits in the pfn_t that hold
> > pfn state that we mask out.
> > 
> > Hence I think we can easily steal another 3 bits for storing an
> > order - orders 0-4 are needed (3 bits) for up to 64kB on 4kB
> > PAGE_SIZE - so I think this is a solvable problem. There's a lot
> > more to it than "just use several pages to map to a single
> > filesystem block", though.....
> 
> Honestly, this is all quite over my head... my use case is virtiofs,
> which I think is quite different to running a filesystem on bare-metal
> DAX. It's starting to sound like we should perhaps just gate off the
> check for virtiofs only?

Yes, my point was that the solution should better be virtiofs specific
because for anybody else blocksize > PAGE_SIZE is going to fail
spectacularly.

> >>> If virtiofs can actually map 4k subpages out of 16k page on
> >>> host (and generally perform 4k granular tracking etc.), it would seem more
> >>> appropriate if virtiofs actually exposed the filesystem 4k block size instead
> >>> of 16k blocksize? Or am I missing something?
> >>
> >> virtiofs itself on the guest does 2MiB mappings into the SHM region, and
> >> then the guest is free to map blocks out of those mappings. So as long
> >> as the guest page size is less than 2MiB, it doesn't matter, since all
> >> files will be aligned in physical memory to that block size. It behaves
> >> as if the filesystem block size is 2MiB from the point of view of the
> >> guest regardless of the actual block size. For example, if the host page
> >> size is 16K, the guest will request a 2MiB mapping of a file, which the
> >> VMM will satisfy by mmapping 128 16K pages from its page cache (at
> >> arbitrary physical memory addresses) into guest "physical" memory as one
> >> contiguous block. Then the guest will see the whole 2MiB mapping as
> >> contiguous, even though it isn't in physical RAM, and it can use any
> >> page granularity it wants (that is supported by the architecture) to map
> >> it to a userland process.
> > 
> > Clearly I'm missing something important because, from this
> > description, I honestly don't know which mapping is actually using
> > DAX.
> > 
> > Can you draw out the virtofs stack from userspace in the guest down
> > to storage in the host so dumb people like myself know exactly where
> > what is being directly accessed and how?
> 
> I'm not familiar with all of the details, but essentially virtiofs is
> FUSE backed by a virtio device instead of userspace, plus the extra DAX
> mapping stuff. Since it's not a real filesystem backed by a block
> device, it has no significant concept of block size itself. i_blkbits
> comes from the st_blksize of the inode stat, which in our case is passed
> through from the underlying filesystem backing the virtiofs in the host
> (but it could be anything, nothing says virtiofs has to be backed by a
> real kernel FS in the host).
> 
> So as a baseline, virtiofs is just FUSE and block size doesn't matter
> since all the non-mmap filesystem APIs shouldn't care about block size
> (other than for optimization reasons and issues with torn racy writes).
> The guest should be able to pretend the block size is 4K for FS/VM
> purposes even if it's 16K in the host, and track everything in the page
> cache and DAX infrastructure in terms of 4K blocks. As far as I know
> there is no operation in plain FUSE that actually cares about the block
> size itself.
> 
> So then there's DAX/mmap. When DAX is enabled, FUSE can issue
> FUSE_SETUPMAPPING and FUSE_REMOVEMAPPING opcodes. These request that a
> range of a file be mapped into the device memory region used by
> virtiofs. When the VMM receives those, it will use mmap to map the
> backing file into the guest's virtio device memory window, and then the
> guest can use DAX to directly access those pages and allow userspace
> processes to mmap them directly. This means that mmaps are coherent
> between processes on the guest and the host (or in another guest), which
> is the main reason we're doing this.
> 
> If you look at fs/fuse/dax.c, you'll see that FUSE_DAX_SHIFT is 21. This
> means that the FUSE code only ever issues
> FUSE_SETUPMAPPING/FUSE_REMOVEMAPPING opcodes with offsets/lengths at
> 2MiB granularity within files. So, regardless of the underlying
> filesystem block size in the host (if there is one at all), the guest
> will always see aligned 2MiB blocks of files available in its virtio
> device region, similar to the hypothetical case of an actual
> block-backed DAX filesystem with a 2MiB allocation block size.

OK, I've read fs/fuse/dax.c and I agree that virtiofs works as if its
block size would be 2MB because it not only maps space with this
granularity but also allocates from underlying storage, tracks extent state
etc. with this granularity.
 
> We could cap st_blksize in the VMM to 4K, I guess? I don't know if that
> would make more sense than removing the kernel check. On one hand, that
> might result in less optimized I/O if userspace then does 4K writes. On
> the other hand, if we report st_blksize as 16K to userspace then I guess
> it could assume concurrent 16K writes cannot be torn, which is not the
> case if the guest is using 4K pages and page cache blocks (at least not
> until all the folio stuff is worked out for blocks > page size in both
> the page cache and DAX layers).

Yes, I think capping sb->s_blocksize at PAGE_SIZE for virtiofs will be the
cleanest solution for now.
 
> This WARN still feels like the wrong thing, though. Right now it is the
> only thing in DAX code complaining on a page size/block size mismatch
> (at least for virtiofs). If this is so important, I feel like there
> should be a higher level check elsewhere, like something happening at
> mount time or on file open. It should actually cause the operations to
> fail cleanly.

That's a fair point. Currently filesystems supporting DAX check for this in
their mount code because there isn't really a DAX code that would get
called during mount and would have enough information to perform the check.
I'm not sure adding a new call just for this check makes a lot of sense.
But if you have some good place in mind, please tell me.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

