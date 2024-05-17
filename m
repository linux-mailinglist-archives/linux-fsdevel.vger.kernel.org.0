Return-Path: <linux-fsdevel+bounces-19667-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA4748C865D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 May 2024 14:36:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32D611F23DD7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 May 2024 12:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B67E747F60;
	Fri, 17 May 2024 12:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ydH76rsx";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="bk9pEpDF";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="TXXm5qRm";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="xtO6hOK0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F58C7F9;
	Fri, 17 May 2024 12:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715949396; cv=none; b=jB8N3CpsECiwlAUTY5zQ3+2ii5YPNJJFDtWKTvxcof3iyyS85PeDv8f9lPVB2C08FH1dMpHapaNU329zw3JhY8I7k55OgL2q1BLe7GMPU6a3nmcMSXduSNtAjp4oqAhbzUpvDV3YH/rkXnoTgTkYBMMzPTNMD0XiwH/442BDdxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715949396; c=relaxed/simple;
	bh=RDsNP+vun4IuHN3F+yPTvliBSlzYXtxXg8UG0BlX8NQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YGNpGLJRpkizrI5+DebsZskgQQzqTPMS0gO95hsRZg7EfKt3+N3qWNzpRYBFn9/8J+kbnQhnRiIHXWGsslDH8qFUFXc0rQOvZMJePRNerZkX2UUMJuQQsuT8vAnxjGa5vMuz0tV2CzJjMHfST1CRE+YmDT7SETsyUQEqLX2QJ1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ydH76rsx; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=bk9pEpDF; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=TXXm5qRm; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=xtO6hOK0; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 435CA37472;
	Fri, 17 May 2024 12:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1715949392; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ue3vJL1SAMo1R7zI163Hy0EYrAeewo1Z63UFC2G4Xyg=;
	b=ydH76rsxdcfKe18Ri9nE9LKLEiPj9U7dcgoTI/rlRld70TFEumeFp3ro0x5UJlHSF5Iiq2
	kuh1gPt9jeR/69fxDCMrIHcI4io0fNX+E7P8j+o9BBdGv2liJg2+r4oobKZ6tghsFKsumP
	8Ypw782OJceIGc6q+S4TRNBnv+U7dwI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1715949392;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ue3vJL1SAMo1R7zI163Hy0EYrAeewo1Z63UFC2G4Xyg=;
	b=bk9pEpDFlPWzp/xArkxHF/skFla39sDMuyh4FFjzo77NgsJuR1yH9+lDcOUBQm8dPzz7Zw
	TuETGXRrHnhV/YDQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=TXXm5qRm;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=xtO6hOK0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1715949391; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ue3vJL1SAMo1R7zI163Hy0EYrAeewo1Z63UFC2G4Xyg=;
	b=TXXm5qRm60AH+633Mfa6cA0TeNY/PXkrguk54+N2dM79pS+QDOl27cY/jnJznGAjwz0LIZ
	J8yDEflDUX/aKkolv2mgiXeUZHff24t1mADj7F0/B6UPWNLo+44u8WondS3zCgC9r1Qfaz
	GH7XuOHvKd2ann9txx/uNKZxnQ1O0gE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1715949391;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ue3vJL1SAMo1R7zI163Hy0EYrAeewo1Z63UFC2G4Xyg=;
	b=xtO6hOK0ZgJ7afvvYaFtlJtlYoVKPvJJkrAQZLxP+EnJHFz6AOZGARAfaZjdNhvCOXDPez
	ufbLyS0pV3GSAfCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7193413942;
	Fri, 17 May 2024 12:36:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id xvbqGU5PR2Z5TAAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 17 May 2024 12:36:30 +0000
Message-ID: <ef22fc06-0227-419c-8f25-38aff7f5e3eb@suse.de>
Date: Fri, 17 May 2024 14:36:29 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] iomap: use huge zero folio in iomap_dio_zero
Content-Language: en-US
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>,
 Matthew Wilcox <willy@infradead.org>
Cc: david@fromorbit.com, djwong@kernel.org, hch@lst.de,
 Keith Busch <kbusch@kernel.org>, mcgrof@kernel.org,
 akpm@linux-foundation.org, brauner@kernel.org, chandan.babu@oracle.com,
 gost.dev@samsung.com, john.g.garry@oracle.com, linux-block@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-xfs@vger.kernel.org, p.raghav@samsung.com, ritesh.list@gmail.com,
 ziy@nvidia.com
References: <20240503095353.3798063-8-mcgrof@kernel.org>
 <20240507145811.52987-1-kernel@pankajraghav.com>
 <ZkQG7bdFStBLFv3g@casper.infradead.org> <ZkQfId5IdKFRigy2@kbusch-mbp>
 <ZkQ0Pj26H81HxQ_4@casper.infradead.org>
 <20240515155943.2uaa23nvddmgtkul@quentin>
 <ZkT46AsZ3WghOArL@casper.infradead.org>
 <20240516150206.d64eezbj3waieef5@quentin>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20240516150206.d64eezbj3waieef5@quentin>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-5.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[fromorbit.com,kernel.org,lst.de,linux-foundation.org,oracle.com,samsung.com,vger.kernel.org,kvack.org,gmail.com,nvidia.com];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 435CA37472
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -5.00

On 5/16/24 17:02, Pankaj Raghav (Samsung) wrote:
> On Wed, May 15, 2024 at 07:03:20PM +0100, Matthew Wilcox wrote:
>> On Wed, May 15, 2024 at 03:59:43PM +0000, Pankaj Raghav (Samsung) wrote:
>>>   static int __init iomap_init(void)
>>>   {
>>> +       void            *addr = kzalloc(16 * PAGE_SIZE, GFP_KERNEL);
>>
>> Don't use XFS coding style outside XFS.
>>
>> kzalloc() does not guarantee page alignment much less alignment to
>> a folio.  It happens to work today, but that is an implementation
>> artefact.
>>
>>> +
>>> +       if (!addr)
>>> +               return -ENOMEM;
>>> +
>>> +       zero_fsb_folio = virt_to_folio(addr);
>>
>> We also don't guarantee that calling kzalloc() gives you a virtual
>> address that can be converted to a folio.  You need to allocate a folio
>> to be sure that you get a folio.
>>
>> Of course, you don't actually need a folio.  You don't need any of the
>> folio metadata and can just use raw pages.
>>
>>> +       /*
>>> +        * The zero folio used is 64k.
>>> +        */
>>> +       WARN_ON_ONCE(len > (16 * PAGE_SIZE));
>>
>> PAGE_SIZE is not necessarily 4KiB.
>>
>>> +       bio = iomap_dio_alloc_bio(iter, dio, BIO_MAX_VECS,
>>> +                                 REQ_OP_WRITE | REQ_SYNC | REQ_IDLE);
>>
>> The point was that we now only need one biovec, not MAX.
>>
> 
> Thanks for the comments. I think it all makes sense:
> 
> diff --git a/fs/internal.h b/fs/internal.h
> index 7ca738904e34..e152b77a77e4 100644
> --- a/fs/internal.h
> +++ b/fs/internal.h
> @@ -35,6 +35,14 @@ static inline void bdev_cache_init(void)
>   int __block_write_begin_int(struct folio *folio, loff_t pos, unsigned len,
>                  get_block_t *get_block, const struct iomap *iomap);
>   
> +/*
> + * iomap/buffered-io.c
> + */
> +
> +#define ZERO_FSB_SIZE (65536)
> +#define ZERO_FSB_ORDER (get_order(ZERO_FSB_SIZE))
> +extern struct page *zero_fs_block;
> +
>   /*
>    * char_dev.c
>    */
But why?
We already have a perfectly fine hugepage zero page in huge_memory.c. 
Shouldn't we rather export that one and use it?
(Actually I have some patches for doing so...)
We might allocate folios
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 4e8e41c8b3c0..36d2f7edd310 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -42,6 +42,7 @@ struct iomap_folio_state {
>   };
>   
>   static struct bio_set iomap_ioend_bioset;
> +struct page *zero_fs_block;
>   
>   static inline bool ifs_is_fully_uptodate(struct folio *folio,
>                  struct iomap_folio_state *ifs)
> @@ -1985,8 +1986,13 @@ iomap_writepages(struct address_space *mapping, struct writeback_control *wbc,
>   }
>   EXPORT_SYMBOL_GPL(iomap_writepages);
>   
> +
>   static int __init iomap_init(void)
>   {
> +       zero_fs_block = alloc_pages(GFP_KERNEL | __GFP_ZERO, ZERO_FSB_ORDER);
> +       if (!zero_fs_block)
> +               return -ENOMEM;
> +
>          return bioset_init(&iomap_ioend_bioset, 4 * (PAGE_SIZE / SECTOR_SIZE),
>                             offsetof(struct iomap_ioend, io_bio),
>                             BIOSET_NEED_BVECS);
> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> index f3b43d223a46..50c2bca8a347 100644
> --- a/fs/iomap/direct-io.c
> +++ b/fs/iomap/direct-io.c
> @@ -236,17 +236,22 @@ static void iomap_dio_zero(const struct iomap_iter *iter, struct iomap_dio *dio,
>                  loff_t pos, unsigned len)
>   {
>          struct inode *inode = file_inode(dio->iocb->ki_filp);
> -       struct page *page = ZERO_PAGE(0);
>          struct bio *bio;
>   
> +       /*
> +        * Max block size supported is 64k
> +        */
> +       WARN_ON_ONCE(len > ZERO_FSB_SIZE);
> +
>          bio = iomap_dio_alloc_bio(iter, dio, 1, REQ_OP_WRITE | REQ_SYNC | REQ_IDLE);
>          fscrypt_set_bio_crypt_ctx(bio, inode, pos >> inode->i_blkbits,
>                                    GFP_KERNEL);
> +
>          bio->bi_iter.bi_sector = iomap_sector(&iter->iomap, pos);
>          bio->bi_private = dio;
>          bio->bi_end_io = iomap_dio_bio_end_io;
>   
> -       __bio_add_page(bio, page, len, 0);
> +       __bio_add_page(bio, zero_fs_block, len, 0);
>          iomap_dio_submit_bio(iter, dio, bio, pos);
>   }
> 

-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


