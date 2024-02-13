Return-Path: <linux-fsdevel+bounces-11380-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A896B853454
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 16:11:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DB611F211D0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 15:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 641495FF06;
	Tue, 13 Feb 2024 15:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="aYxE9kiT";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="pYzu1Bfj";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="aYxE9kiT";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="pYzu1Bfj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 359C35FEEC;
	Tue, 13 Feb 2024 15:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707836784; cv=none; b=SAfsTxWRhqRu2ksxCU3vRM72nUrkEIsBDY4XROFE8FtmmnjK3IATfFQJlBgCurwBHiYLcuBIE01l0pf7QfhfmWX9fxmif+AP5nyrF2WeBOebv457D5YC/FU30lIwqNZKeAy/Fv1lY9hauMpnoD5unixX5pWmJErtVrubyfsHZ4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707836784; c=relaxed/simple;
	bh=HfTxaV85bQ5N+4rl97kNfU4pEDd/6TmuuAa8Xv99rbU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i1wPP04WyJtTOZGDP1IbLdT905uFaCnSuVAUNpXk7lzgJmfO2WLDeAXoK+pwaNMRl4Fih5vYVvHt+jz8lo60/A8GhPXrM4VKCWEtyOIUZPkaTma/l5m2LT9DCLjKRSm+oMA/LAW3EX0Sv4hGzj+0+vP17sJZmHqdosCVA447EsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=aYxE9kiT; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=pYzu1Bfj; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=aYxE9kiT; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=pYzu1Bfj; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 34DA521E54;
	Tue, 13 Feb 2024 15:06:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707836781; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/ZnYq6o4Mhw4uq6WMCCvbGU2WzT/Rvdq9e8cUAYa9Uw=;
	b=aYxE9kiT88dxR4vB+BaIfviwAnd+J+wYdL/f6EEr/PsjH+UqEc41JWaBF70qbhptVKOo/D
	aik1zMTYO/aUvrFQthhlrI0u6JH9MQ6YiumJONaJI8gRZDgyUIz3xrcmmxJ1LauHDTSktB
	PD0/QKN2eUhzSXAB1GYOwVEMlKvdQlg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707836781;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/ZnYq6o4Mhw4uq6WMCCvbGU2WzT/Rvdq9e8cUAYa9Uw=;
	b=pYzu1BfjgGhSDqWc8CQVpN24wtzBYd+0d+QfOZ/Yishgpcf3FumI1y1kPPI9upMquS2d7s
	ITpsdZCyQjK2bZAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707836781; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/ZnYq6o4Mhw4uq6WMCCvbGU2WzT/Rvdq9e8cUAYa9Uw=;
	b=aYxE9kiT88dxR4vB+BaIfviwAnd+J+wYdL/f6EEr/PsjH+UqEc41JWaBF70qbhptVKOo/D
	aik1zMTYO/aUvrFQthhlrI0u6JH9MQ6YiumJONaJI8gRZDgyUIz3xrcmmxJ1LauHDTSktB
	PD0/QKN2eUhzSXAB1GYOwVEMlKvdQlg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707836781;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/ZnYq6o4Mhw4uq6WMCCvbGU2WzT/Rvdq9e8cUAYa9Uw=;
	b=pYzu1BfjgGhSDqWc8CQVpN24wtzBYd+0d+QfOZ/Yishgpcf3FumI1y1kPPI9upMquS2d7s
	ITpsdZCyQjK2bZAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DBCDD13404;
	Tue, 13 Feb 2024 15:06:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id AJb9NGyFy2UHNwAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 13 Feb 2024 15:06:20 +0000
Message-ID: <0e44e137-eea0-4249-aab9-86acfca58ac7@suse.de>
Date: Tue, 13 Feb 2024 16:06:20 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 10/14] iomap: fix iomap_dio_zero() for fs bs > system
 page size
Content-Language: en-US
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>,
 linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc: mcgrof@kernel.org, gost.dev@samsung.com, akpm@linux-foundation.org,
 kbusch@kernel.org, djwong@kernel.org, chandan.babu@oracle.com,
 p.raghav@samsung.com, linux-kernel@vger.kernel.org, willy@infradead.org,
 linux-mm@kvack.org, david@fromorbit.com
References: <20240213093713.1753368-1-kernel@pankajraghav.com>
 <20240213093713.1753368-11-kernel@pankajraghav.com>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20240213093713.1753368-11-kernel@pankajraghav.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=aYxE9kiT;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=pYzu1Bfj
X-Spamd-Result: default: False [-0.34 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BAYES_HAM(-0.04)[57.78%];
	 MIME_GOOD(-0.10)[text/plain];
	 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_TWELVE(0.00)[14];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[samsung.com:email,suse.de:dkim,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: -0.34
X-Rspamd-Queue-Id: 34DA521E54
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Bar: /

On 2/13/24 10:37, Pankaj Raghav (Samsung) wrote:
> From: Pankaj Raghav <p.raghav@samsung.com>
> 
> iomap_dio_zero() will pad a fs block with zeroes if the direct IO size
> < fs block size. iomap_dio_zero() has an implicit assumption that fs block
> size < page_size. This is true for most filesystems at the moment.
> 
> If the block size > page size, this will send the contents of the page
> next to zero page(as len > PAGE_SIZE) to the underlying block device,
> causing FS corruption.
> 
> iomap is a generic infrastructure and it should not make any assumptions
> about the fs block size and the page size of the system.
> 
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> ---
>   fs/iomap/direct-io.c | 13 +++++++++++--
>   1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> index bcd3f8cf5ea4..04f6c5548136 100644
> --- a/fs/iomap/direct-io.c
> +++ b/fs/iomap/direct-io.c
> @@ -239,14 +239,23 @@ static void iomap_dio_zero(const struct iomap_iter *iter, struct iomap_dio *dio,
>   	struct page *page = ZERO_PAGE(0);
>   	struct bio *bio;
>   
> -	bio = iomap_dio_alloc_bio(iter, dio, 1, REQ_OP_WRITE | REQ_SYNC | REQ_IDLE);
> +	WARN_ON_ONCE(len > (BIO_MAX_VECS * PAGE_SIZE));
> +
> +	bio = iomap_dio_alloc_bio(iter, dio, BIO_MAX_VECS,
> +				  REQ_OP_WRITE | REQ_SYNC | REQ_IDLE);
>   	fscrypt_set_bio_crypt_ctx(bio, inode, pos >> inode->i_blkbits,
>   				  GFP_KERNEL);
> +
>   	bio->bi_iter.bi_sector = iomap_sector(&iter->iomap, pos);
>   	bio->bi_private = dio;
>   	bio->bi_end_io = iomap_dio_bio_end_io;
>   
> -	__bio_add_page(bio, page, len, 0);
> +	while (len) {
> +		unsigned int io_len = min_t(unsigned int, len, PAGE_SIZE);
> +
> +		__bio_add_page(bio, page, io_len, 0);
> +		len -= io_len;
> +	}
>   	iomap_dio_submit_bio(iter, dio, bio, pos);
>   }
>   
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes


