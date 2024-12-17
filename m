Return-Path: <linux-fsdevel+bounces-37620-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E47AD9F4825
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2024 10:56:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DA0516EBB0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2024 09:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 307DB1DF26F;
	Tue, 17 Dec 2024 09:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="DA5AJLAQ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Dfe8VzKD";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="DA5AJLAQ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Dfe8VzKD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 232341D63F6;
	Tue, 17 Dec 2024 09:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734429369; cv=none; b=EquRJ8RzbZ5wW+V5RReD6/lODLJFOTsDqzQNKRg7tizd3wFvcdTU/7BgRtLGnZUt1M7o4IdPVDvTlgHWYsWo4kAzk6mhpgR/Y27PX8hk0qTSf8/VsY1vBryB+yzdVwfT09sFUwb3340lKP/iXTWGBdodQlNpeQ3iHQtdsmR+YtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734429369; c=relaxed/simple;
	bh=ArpWLaVmWptGuMasbx7WO9kITe46Age+NvTb+ucCdfI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O7KRFYFDF7fyGOBMhMuGe9f/zapwNlw8jrkWmgCbW26Dg/gstrK9iPMB2A4rYCKsQ1vTZmdNhr/HV5up0v6f4u4JFP7gsFKSzqjTwtspQyGCTCEeYHbX1L1jKFrKe6gxAc1OVgtdVEmm+qHCBNcXZxds9Xe2IGmr7DQublTypO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=DA5AJLAQ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Dfe8VzKD; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=DA5AJLAQ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Dfe8VzKD; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 274F721120;
	Tue, 17 Dec 2024 09:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1734429365; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W4kK35KkfBrN9Mg5yne7Rzp2l/7b6J0Oqjb8NVAWiKQ=;
	b=DA5AJLAQHK6EIwTQWqfEDjazP3JbOb7uHAziaV1ncaHFnmD0JPFJzeFEuZzsrvnSZ8DUUh
	BcmWMOR4ppfeLvp3fpsh2P9nO0ltVqfFNutUyEco/J5ExIimu6kxLrNLqW3zQgs/OFnysw
	kQrTSvdOZAKyhdf1y0CcFNfYUMKSjGI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1734429365;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W4kK35KkfBrN9Mg5yne7Rzp2l/7b6J0Oqjb8NVAWiKQ=;
	b=Dfe8VzKDbX65eZ3f6xT9c8B02fbIOmY6FHOku6LqTeGjlTQe3a1eeZ2H6g6Nd/ZxULbP6D
	YixD4nk7NlkGI9Ag==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=DA5AJLAQ;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Dfe8VzKD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1734429365; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W4kK35KkfBrN9Mg5yne7Rzp2l/7b6J0Oqjb8NVAWiKQ=;
	b=DA5AJLAQHK6EIwTQWqfEDjazP3JbOb7uHAziaV1ncaHFnmD0JPFJzeFEuZzsrvnSZ8DUUh
	BcmWMOR4ppfeLvp3fpsh2P9nO0ltVqfFNutUyEco/J5ExIimu6kxLrNLqW3zQgs/OFnysw
	kQrTSvdOZAKyhdf1y0CcFNfYUMKSjGI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1734429365;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W4kK35KkfBrN9Mg5yne7Rzp2l/7b6J0Oqjb8NVAWiKQ=;
	b=Dfe8VzKDbX65eZ3f6xT9c8B02fbIOmY6FHOku6LqTeGjlTQe3a1eeZ2H6g6Nd/ZxULbP6D
	YixD4nk7NlkGI9Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8D61F13A3C;
	Tue, 17 Dec 2024 09:56:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ehhdILRKYWdyOAAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 17 Dec 2024 09:56:04 +0000
Message-ID: <ec685d97-80f6-4e14-8b74-47c777f6ad12@suse.de>
Date: Tue, 17 Dec 2024 10:56:04 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 01/11] fs/buffer: move async batch read code into a
 helper
To: Luis Chamberlain <mcgrof@kernel.org>, willy@infradead.org, hch@lst.de,
 dave@stgolabs.net, david@fromorbit.com, djwong@kernel.org
Cc: john.g.garry@oracle.com, ritesh.list@gmail.com, kbusch@kernel.org,
 linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
 linux-mm@kvack.org, linux-block@vger.kernel.org, gost.dev@samsung.com,
 p.raghav@samsung.com, da.gomez@samsung.com, kernel@pankajraghav.com
References: <20241214031050.1337920-1-mcgrof@kernel.org>
 <20241214031050.1337920-2-mcgrof@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20241214031050.1337920-2-mcgrof@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 274F721120
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[oracle.com,gmail.com,kernel.org,vger.kernel.org,kvack.org,samsung.com,pankajraghav.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:email,suse.de:dkim,suse.de:mid]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

On 12/14/24 04:10, Luis Chamberlain wrote:
> Move the code from block_read_full_folio() which does a batch of async
> reads into a helper.
> 
> No functional changes.
> 
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
>   fs/buffer.c | 73 +++++++++++++++++++++++++++++++----------------------
>   1 file changed, 43 insertions(+), 30 deletions(-)
> 
> diff --git a/fs/buffer.c b/fs/buffer.c
> index cc8452f60251..580451337efa 100644
> --- a/fs/buffer.c
> +++ b/fs/buffer.c
> @@ -2350,6 +2350,48 @@ bool block_is_partially_uptodate(struct folio *folio, size_t from, size_t count)
>   }
>   EXPORT_SYMBOL(block_is_partially_uptodate);
>   
> +static void bh_read_batch_async(struct folio *folio,
> +				int nr, struct buffer_head *arr[],
> +				bool fully_mapped, bool no_reads,
> +				bool any_get_block_error)
> +{
> +	int i;
> +	struct buffer_head *bh;
> +
> +	if (fully_mapped)
> +		folio_set_mappedtodisk(folio);
> +
> +	if (no_reads) {
> +		/*
> +		 * All buffers are uptodate or get_block() returned an
> +		 * error when trying to map them *all* buffers we can
> +		 * finish the read.
> +		 */
> +		folio_end_read(folio, !any_get_block_error);
> +		return;
> +	}
> +
> +	/* Stage one: lock the buffers */

Now you messed up documentation:
Originally this was 'stage two', so now we have two 'stage one'
comments.
Please use the original documentation convention and add a note
to the helper that it's contingent on the 'stage 1' in the
calling function.

> +	for (i = 0; i < nr; i++) {
> +		bh = arr[i];
> +		lock_buffer(bh);
> +		mark_buffer_async_read(bh);
> +	}
> +
> +	/*
> +	 * Stage 2: start the IO.  Check for uptodateness
> +	 * inside the buffer lock in case another process reading
> +	 * the underlying blockdev brought it uptodate (the sct fix).
> +	 */
Same here; should be 'stage 3' to be consistent.

> +	for (i = 0; i < nr; i++) {
> +		bh = arr[i];
> +		if (buffer_uptodate(bh))
> +			end_buffer_async_read(bh, 1);
> +		else
> +			submit_bh(REQ_OP_READ, bh);
> +	}
> +}
> +
>   /*
>    * Generic "read_folio" function for block devices that have the normal
>    * get_block functionality. This is most of the block device filesystems.
> @@ -2414,37 +2456,8 @@ int block_read_full_folio(struct folio *folio, get_block_t *get_block)
>   		arr[nr++] = bh;
>   	} while (i++, iblock++, (bh = bh->b_this_page) != head);
>   
> -	if (fully_mapped)
> -		folio_set_mappedtodisk(folio);
> -
> -	if (!nr) {
> -		/*
> -		 * All buffers are uptodate or get_block() returned an
> -		 * error when trying to map them - we can finish the read.
> -		 */
> -		folio_end_read(folio, !page_error);
> -		return 0;
> -	}
> -
> -	/* Stage two: lock the buffers */
> -	for (i = 0; i < nr; i++) {
> -		bh = arr[i];
> -		lock_buffer(bh);
> -		mark_buffer_async_read(bh);
> -	}
> +	bh_read_batch_async(folio, nr, arr, fully_mapped, nr == 0, page_error);
>   
> -	/*
> -	 * Stage 3: start the IO.  Check for uptodateness
> -	 * inside the buffer lock in case another process reading
> -	 * the underlying blockdev brought it uptodate (the sct fix).
> -	 */
> -	for (i = 0; i < nr; i++) {
> -		bh = arr[i];
> -		if (buffer_uptodate(bh))
> -			end_buffer_async_read(bh, 1);
> -		else
> -			submit_bh(REQ_OP_READ, bh);
> -	}
>   	return 0;
>   }
>   EXPORT_SYMBOL(block_read_full_folio);

Otherwise looks good.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

