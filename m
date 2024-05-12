Return-Path: <linux-fsdevel+bounces-19376-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FBC78C4240
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 May 2024 15:42:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F13F1F21854
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 May 2024 13:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F475154425;
	Mon, 13 May 2024 13:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="E4+R9yqK";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="dC4r5Yoc";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="E4+R9yqK";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="dC4r5Yoc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A32E1534F5;
	Mon, 13 May 2024 13:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715607698; cv=none; b=pur7BYp7wAHE6BxNEUAaiC7sNZzEksK4hF7+8gOwsAmr9pCxwnBNRpXQVeeEtPRgbM5PYN4jqj96/oSwGRpx+RiOXOwLQh0KwhrtObZxkTrJ/oO35Wd7wBP5Q6pCVj/KUDMN0Y41O+8vLZzUYyqjvSenJb8GbID4iJfooiSvRrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715607698; c=relaxed/simple;
	bh=GL5iuPNcZkxZRAZ19nDqqMLeYai0AWhAQuFGnf+HmkQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nkidK6kxBn3ZMR8ukEU8yFnphYv5YGFTFL9vnlZx1aHUw082rNmDEXzNB9MU9HRKPf4a3EVdtm3QIJDyPg0oNylVNMyio+GzTPXrcy2xeWln1tqx3mP9DDi9JAy7kueBxduztAUvpvXQK9ZKV2nDBTIuDqx5smTZ/Yngv3CWCcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=E4+R9yqK; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=dC4r5Yoc; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=E4+R9yqK; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=dC4r5Yoc; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6B0ED5C0CD;
	Mon, 13 May 2024 13:41:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1715607688; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l3oUc43y28QKIjKFgVsSHE+JFuKC/E7/R57nCXyy2ZE=;
	b=E4+R9yqKhQpc77GwXyQyf+F6HdTkvaWhf7kU6PGDE9aoA+Aq7uQ7ek1RiCHr8jkgG4O0CS
	jyePzBs829W+flCrgqtBarSZ6CLlVgsPLsLJ/xzm4McyxvVny3aPsStrxV8xk+wZOmW7Jt
	oKZ4RpTcoqdE/a0eJLEISxVt+/PXVhc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1715607688;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l3oUc43y28QKIjKFgVsSHE+JFuKC/E7/R57nCXyy2ZE=;
	b=dC4r5Yoc7Z0batMZUbPNO7r8ejxVUK/nQT+yQZVbcebIXhu4TdXESNUFo4W+9R1rwJ64fQ
	+CvPikjaq9UfeUCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1715607688; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l3oUc43y28QKIjKFgVsSHE+JFuKC/E7/R57nCXyy2ZE=;
	b=E4+R9yqKhQpc77GwXyQyf+F6HdTkvaWhf7kU6PGDE9aoA+Aq7uQ7ek1RiCHr8jkgG4O0CS
	jyePzBs829W+flCrgqtBarSZ6CLlVgsPLsLJ/xzm4McyxvVny3aPsStrxV8xk+wZOmW7Jt
	oKZ4RpTcoqdE/a0eJLEISxVt+/PXVhc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1715607688;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l3oUc43y28QKIjKFgVsSHE+JFuKC/E7/R57nCXyy2ZE=;
	b=dC4r5Yoc7Z0batMZUbPNO7r8ejxVUK/nQT+yQZVbcebIXhu4TdXESNUFo4W+9R1rwJ64fQ
	+CvPikjaq9UfeUCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DBD621372E;
	Mon, 13 May 2024 13:41:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id x2+iNYcYQmb8DgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 13 May 2024 13:41:27 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 5389BA08FA; Sun, 12 May 2024 14:44:57 +0200 (CEST)
Date: Sun, 12 May 2024 14:44:57 +0200
From: Jan Kara <jack@suse.cz>
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc: linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, Dave Chinner <david@fromorbit.com>,
	Matthew Wilcox <willy@infradead.org>,
	Christoph Hellwig <hch@infradead.org>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>, Jan Kara <jack@suse.cz>
Subject: Re: [RFC] Documentation: Add initial iomap document
Message-ID: <20240512124457.w3273qye4bgtvs5r@quack3>
References: <17e84cbae600898269e9ad35046ce6dc929036ae.1714744795.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <17e84cbae600898269e9ad35046ce6dc929036ae.1714744795.git.ritesh.list@gmail.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-1.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	DATE_IN_PAST(1.00)[24];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Spam-Score: -1.30
X-Spam-Flag: NO

On Fri 03-05-24 19:40:19, Ritesh Harjani (IBM) wrote:
> This adds an initial first draft of iomap documentation. Hopefully this
> will come useful to those who are looking for converting their
> filesystems to iomap. Currently this is in text format since this is the
> first draft. I would prefer to work on it's conversion to .rst once we
> receive the feedback/review comments on the overall content of the document.
> But feel free to let me know if we prefer it otherwise.
> 
> A lot of this has been collected from various email conversations, code
> comments, commit messages and/or my own understanding of iomap. Please
> note a large part of this has been taken from Dave's reply to last iomap
> doc patchset. Thanks to Dave, Darrick, Matthew, Christoph and other iomap
> developers who have taken time to explain the iomap design in various emails,
> commits, comments etc.
> 
> Please note that this is not the complete iomap design doc. but a brief
> overview of iomap.
> 
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> ---
>  Documentation/filesystems/index.rst |   1 +
>  Documentation/filesystems/iomap.txt | 289 ++++++++++++++++++++++++++++
>  MAINTAINERS                         |   1 +
>  3 files changed, 291 insertions(+)
>  create mode 100644 Documentation/filesystems/iomap.txt
> 
> diff --git a/Documentation/filesystems/index.rst b/Documentation/filesystems/index.rst
> index 1f9b4c905a6a..c17b5a2ec29b 100644
> --- a/Documentation/filesystems/index.rst
> +++ b/Documentation/filesystems/index.rst
> @@ -34,6 +34,7 @@ algorithms work.
>     seq_file
>     sharedsubtree
>     idmappings
> +   iomap
> 
>     automount-support
> 
> diff --git a/Documentation/filesystems/iomap.txt b/Documentation/filesystems/iomap.txt
> new file mode 100644
> index 000000000000..4f766b129975
> --- /dev/null
> +++ b/Documentation/filesystems/iomap.txt
> @@ -0,0 +1,289 @@
> +Introduction
> +============
> +iomap is a filesystem centric mapping layer that maps file's logical offset
> +ranges to physical extents. It provides several iterator APIs which filesystems
> +can use for doing various file_operations, address_space_operations,
> +vm_operations, inode_operations etc. It supports APIs for doing direct-io,
> +buffered-io, lseek, dax-io, page-mkwrite, swap_activate and extent reporting
> +via fiemap.
> +
> +iomap is termed above as filesystem centric because it first calls
> +->iomap_begin() phase supplied by the filesystem to get a mapped extent and
                   ^^^^ 'phase' sounds strange to me here. 'callback' or
'method'?

> +then loops over each folio within that mapped extent.
> +This is useful for filesystems because now they can allocate/reserve a much
> +larger extent at begin phase v/s the older approach of doing block allocation
> +of one block at a time by calling filesystem's provided ->get_blocks() routine.
> +
> +i.e. at a high level how iomap does write iter is [1]::
> +	user IO
> +	  loop for file IO range
> +	    loop for each mapped extent
> +	      if (buffered) {
> +		loop for each page/folio {
> +		  instantiate page cache
> +		  copy data to/from page cache
> +		  update page cache state
> +		}
> +	      } else { /* direct IO */
> +		loop for each bio {
> +		  pack user pages into bio
> +		  submit bio
> +		}
> +	      }
> +	    }
> +	  }

I agree with Christoph that this would be better split to buffer and direct
IO parts. In particular because the combined handler like shown above does
not exist in iomap...

> +Motivation for filesystems to convert to iomap
> +===============================================
> +1. iomap is a modern filesystem mapping layer VFS abstraction.
> +2. It also supports large folios for buffered-writes. Large folios can help
> +improve filesystem buffered-write performance and can also improve overall
> +system performance.
> +3. Less maintenance overhead for individual filesystem maintainers.
> +iomap is able to abstract away common folio-cache related operations from the
> +filesystem to within the iomap layer itself. e.g. allocating, instantiating,
> +locking and unlocking of the folios for buffered-write operations are now taken
> +care within iomap. No ->write_begin(), ->write_end() or direct_IO
      ^^^ of						  ^^ ->direct_IO

> +address_space_operations are required to be implemented by filesystem using
> +iomap.
> +
> +
> +blocksize < pagesize path/large folios
> +======================================
> +Large folio support or systems with large pagesize e.g 64K on Power/ARM64 and
						      ^^^ e.g.

> +4k blocksize, needs filesystems to support bs < ps paths. iomap embeds
> +struct iomap_folio_state (ifs) within folio->private. ifs maintains uptodate
> +and dirty bits for each subblock within the folio. Using ifs iomap can track
> +update and dirty status of each block within the folio. This helps in supporting
> +bs < ps path for such systems with large pagesize or with large folios [2].
> +
> +
> +struct iomap
> +=============
> +This structure defines a file mapping information of logical file offset range
> +to a physical mapped extent on which an IO operation could be performed.
> +An iomap reflects a single contiguous range of filesystem address space that
> +either exists in memory or on a block device.
> +1. The type field within iomap determines what type the range maps to e.g.
> +IOMAP_HOLE, IOMAP_DELALLOC, IOMAP_UNWRITTEN etc.
> +
> +2. The flags field represent the state flags (e.g. IOMAP_F_*), most of which are
> +set the by the filesystem during mapping time that indicates how iomap
> +infrastructure should modify it's behaviour to do the right thing.
> +
> +3. private void pointer within iomap allows the filesystems to pass filesystem's
> +private data from ->iomap_begin() to ->iomap_end() [3].
> +(see include/linux/iomap.h for more details)
> +
> +
> +iomap operations
> +================
> +iomap provides different iterator APIs for direct-io, buffered-io, lseek,
> +dax-io, page-mkwrite, swap_activate and extent reporting via fiemap. It requires
> +various struct operations to be prepared by filesystem and to be supplied to
> +iomap iterator APIs either at the beginning of iomap api call or attaching it
> +during the mapping callback time e.g iomap_folio_ops is attached to
				    ^^^ e.g.

> +iomap->folio_ops during ->iomap_begin() call.
> +
> +Following provides various ops to be supplied by filesystems to iomap layer for
> +doing different I/O types as discussed above.
   ^^^ performing

> +iomap_ops: IO interface specific operations
> +==========
> +The methods are designed to be used as pairs. The begin method creates the iomap
						     ^^^ I'd use the full
name here as it's the first occurence in the section. Hence 'iomap_begin'.

> +and attaches all the necessary state and information which subsequent iomap
> +methods & their callbacks might need. Once the iomap infrastructure has finished
> +working on the iomap it will call the end method to allow the filesystem to tear
					 ^^ iomap_end

> +down any unused space and/or structures it created for the specific iomap
> +context.
> +
> +Almost all iomap iterator APIs require filesystems to define iomap_ops so that
> +filesystems can be called into for providing logical to physical extent mapping,
> +wherever required. This is required by the iomap iter apis used for the
> +operations which are listed in the beginning of "iomap operations" section.
> +  - iomap_begin: This either returns an existing mapping or reserve/allocates a
								^^^ reserves

> +    new mapping when called by iomap. pos and length are passed as function
> +    arguments. Filesystem returns the new mapping information within struct
> +    iomap which also gets passed as a function argument. Filesystems should
> +    provide the type of this extent in iomap->type for e.g. IOMAP_HOLE,
> +    IOMAP_UNWRITTEN and it should set the iomap->flags e.g. IOMAP_F_*
> +    (see details in include/linux/iomap.h)
> +
> +    Note that iomap_begin() call has srcmap passed as another argument. This is
> +    mainly used only during the begin phase for COW mappings to identify where
> +    the reads are to be performed from. Filesystems needs to fill that mapping
							^^ need

> +    information if iomap should read data for partially written blocks from a
> +    different location than the write target [4].
> +
> +  - iomap_end: Commit and/or unreserve space which was previously allocated
> +    using iomap_begin. During buffered-io, when a short writes occurs,
> +    filesystem may need to remove the reserved space that was allocated
> +    during ->iomap_begin. For filesystems that use delalloc allocation, we need
							^^^ delayed

> +    to punch out delalloc extents from the range that are not dirty in the page
> +    cache. See comments in iomap_file_buffered_write_punch_delalloc() for more
> +    info [5][6].
> +
> +iomap_dio_ops: Direct I/O operations structure for iomap.
> +=============
> +This gets passed with iomap_dio_rw(), so that iomap can call certain operations
> +before submission or on completion of DIRECT_IO.
					 ^^^ I'd use just 'direct IO' or
'DIO'

> +  - end_io: Required after bio completion for e.g. for conversion of unwritten
               ^^^ Well, the callback isn't really required AFAICT. So I'd
write: 'Method called after bio completion. Can be used for example for
conversion of unwritten extents."

> +    extents.
> +
> +  - submit_io: This hook is required for e.g. by filesystems like btrfs who
> +    would like to do things like data replication for fs-handled RAID.

Again somewhat hard to understand for me. How about: "Optional method to be
called by iomap instead of simply calling submit_bio(). Useful for example
for filesystems wanting to do data replication on submission of IO."

> +
> +  - bio_set: This allows the filesystem to provide custom bio_set for allocating
> +    direct I/O bios. This will allow the filesystem who uses ->submit_io hook to
							^^ which

> +    stash away additional information for filesystem use. Filesystems will
									 ^^^
"In case the filesystem will provide their custom ->bi_end_io function, it
needs to call iomap_dio_bio_end_io() from the custom handler to handle dio
completion [11]".

Also I'd move this note to the submit_io part above as it mostly relates to
that AFAIU.

> +    provide their custom ->bi_end_io function completion which should then call
> +    into iomap_dio_bio_end_io() for dio completion [11].
> +
> +iomap_writeback_ops: Writeback operations structure for iomap
> +====================
> +Writeback address space operations e.g. iomap_writepages(), requires the
> +filesystem to pass this ops field.
> +   - map_blocks: map the blocks at the writeback time. This is called once per
> +     folio. Filesystems can return an existing mapping from a previous call if
> +     that mapping is still valid. This can race with paths which can invalidate
> +     previous mappings such as fallocate/truncate. Hence filesystems must have
> +     a mechanism by which it can validate if the previous mapping provided is
			     ^^ they

> +     still valid. Filesystems might need a per inode seq counter which can be
> +     used to verify if the underlying mapping of logical to physical blocks
> +     has changed since the last ->map_blocks call or not.
> +     They can then use wpc->iomap->validity_cookie to cache their seq count in
> +     ->map_blocks call [6].
> +
> +  - prepare_ioend: Allows filesystems to process the extents before submission
> +    for e.g. convert COW extents to regular. This also allows filesystem to
> +    hook in a custom completion handler for processing bio completion e.g.
> +    conversion of unwritten extents.
> +    Note that ioends might need to be processed as an atomic completion unit
> +    (using transactions) when all the chained bios in the ioend have completed
> +    (e.g. for conversion of unwritten extents). iomap provides some helper
> +    methods for ioend merging and completion [12]. Look at comments in
> +    xfs_end_io() routine for more info.
> +
> +  - discard_folio: In case if the filesystem has any delalloc blocks on it,
> +    then those needs to be punched out in this call. Otherwise, it may leave a
> +    stale delalloc mapping covered by a clean page that needs to be dirtied
> +    again before the delalloc mapping can be converted. This stale delalloc
> +    mapping can trip the direct I/O reads when done on the same region [7].

Here I miss explanation when iomap calls this callback. Apparently when
mapping of folio for writeback fails for some reason.

> +iomap_folio_ops: Folio related operations structure for iomap.
> +================
> +When filesystem sets folio_ops in an iomap mapping it returns, ->get_folio()
> +and ->put_folio() will be called for each folio written to during write iter
> +time of buffered writes.
> +  - get_folio: iomap will call ->get_folio() for every folio of the returned
> +    iomap mapping. Currently gfs2 uses this to start the transaction before
> +    taking the folio lock [8].
> +
> +  - put_folio: iomap will call ->put_folio() once the data has been written to
									^^^
copied into the folio for each folio of the returned iomap mapping.

> +    for each folio of the returned iomap mapping. GFS2 uses this to add data
> +    bufs to the transaction before unlocking the folio and then ending the
> +    transaction [9].
> +
> +  - iomap_valid: Filesystem internal extent map can change while iomap is
		    ^^^ In case filesystem internal extent map ...

> +    iterating each folio of a cached iomap, so this hook allows iomap to detect
> +    that the iomap needs to be refreshed during a long running write operation.
> +    Filesystems can store an internal state (e.g. a sequence no.) in
> +    iomap->validity_cookie when the iomap is first mapped, to be able to detect
> +    changes between the mapping time and whenever iomap calls ->iomap_valid().
> +    This gets called with the locked folio. See iomap_write_begin() for more
> +    comments around ->iomap_valid() [10].
> +
> +
> +Locking
> +========
> +iomap assumes two layers of locking. It requires locking above the iomap layer
> +for IO serialisation (i_rwsem, invalidation lock) which is generally taken
> +before calling into iomap iter functions. There is also locking below iomap for
> +mapping/allocation serialisation on an inode (e.g. XFS_ILOCK or i_data_sem in
> +ext4 etc) that is usually taken inside the mapping methods which filesystems
> +supplied to the iomap infrastructure. This layer of locking needs to be
> +independent of the IO path serialisation locking as it nests inside in the IO
> +path but is also used without the filesystem IO path locking protecting it
> +(e.g. in the iomap writeback path).
> +
> +General Locking order in iomap is:
> +inode->i_rwsem (shared or exclusive)
> +  inode->i_mapping->invalidate_lock (exclusive)
> +    folio_lock()
> +	internal filesystem allocation lock (e.g. XFS_ILOCK or i_data_sem)
> +
> +
> +Zeroing/Truncate Operations
> +===========================
> +Filesystems can use iomap provided helper functions e.g. iomap_zero_range(),
> +iomap_truncate_page() & iomap_file_unshare() for various truncate/fallocate or
> +any other similar operations that requires zeroing/truncate.
				     ^^^ require

> +See above functions for more details on how these can be used by individual
> +filesystems.
> +
> +
> +Guideline for filesystem conversion to iomap
> +=============================================
> +The right approach is to first implement ->iomap_begin and (if necessary)
> +->iomap_end to allow iomap to obtain a read-only mapping of a file range.  In
> +most cases, this is a relatively trivial conversion of the existing get_block()
> +callback for read-only mappings.
> +
> +i.e. rewrite the filesystem's get_block(create = false) implementation to use
  ^^^ I.e.

> +the new ->iomap_begin() implementation. i.e. get_block wraps around the outside
					   ^^^ I don't understand this
sentence...

> +and converts the information from bufferhead-based map to what iomap expects.
> +This will convert all the existing read-only mapping users to use the new iomap
> +mapping function internally. This way the iomap mapping function can be further
> +tested without needing to implement any other iomap APIs.
> +
> +FIEMAP operation is a really good first target because it is trivial to
> +implement support for it and then to determine that the extent map iteration is
> +correct from userspace. i.e. if FIEMAP is returning the correct information,
			   ^^ I.e.,

> +it's a good sign that other read-only mapping operations will also do the right
> +thing.
> +
> +Once everything is working like this, then convert all the other read-only
> +mapping operations to use iomap. Done one at a time, regressions should be self
> +evident. The only likely complexity at this point will be the buffered read IO
> +path because of bufferheads. The buffered read IO paths doesn't need to be
> +converted yet, though the direct IO read path should be converted in this phase.
> +
> +The next thing to do is implement get_blocks(create = true) functionality in the
> +->iomap_begin/end() methods. Then convert the direct IO write path to iomap, and
> +start running fsx w/ DIO enabled in earnest on filesystem. This will flush out
> +lots of data integrity corner case bug that the new write mapping implementation
				      ^^^ bugs
> +introduces.
> +
> +(TODO - get more info on this from Dave): At this point, converting the entire
> +get_blocks() path to call the iomap functions and convert the iomaps to
> +bufferhead maps is possible. This will get the entire filesystem using the new
					  ^^^ make		    ^^ use

> +mapping functions, and they should largely be debugged and working correctly
> +after this step.
> +
> +This now largely leaves the buffered read and write paths to be converted. The
> +mapping functions should all work correctly, so all that needs to be done is
> +rewriting all the code that interfaces with bufferheads to interface with iomap
> +and folios. It is rather easier first to get regular file I/O (without any
> +fancy feature like fscrypt, fsverity, data=journaling) converted to use iomap
> +and then work on directory handling conversion to iomap.

Well, I belive this comment about directories is pretty much specific for
ext2. Iomap never attempted to provide any infrastructure for metadata
handling - each filesystem is on its own here. ext2 is kind of special as
it was experimenting with handling directories more like data. In
retrospect I don't think it was particularly successful experiment but you
never know until you try :).

> +
> +The rest is left as an exercise for the reader, as it will be different for
> +every filesystem.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

