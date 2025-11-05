Return-Path: <linux-fsdevel+bounces-67115-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BC9EC358E4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 05 Nov 2025 13:05:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 95A534E235A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Nov 2025 12:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F3633128AC;
	Wed,  5 Nov 2025 12:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="e9ucpd1Z";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="2YFLjJ/b";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="e9ucpd1Z";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="2YFLjJ/b"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ACF23009EE
	for <linux-fsdevel@vger.kernel.org>; Wed,  5 Nov 2025 12:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762344295; cv=none; b=SlVaMnU9Cna/yO+1FyoXrB6nNB8QkT52WTvJNs2EfUTjhR8dSjmVb4e9J6jOE0mr5SmJumE92b28aZlPgCznDZUea+WyHFbEl//G9PAPvsF38V1dc7/Omb+pmCQx/XXoTWDWzJdTN171BDX35Wrb7P7wc1FlAr+c5vutsXYFIKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762344295; c=relaxed/simple;
	bh=w9JcTzxd6YAsTJ9pWbHeAiOROCWEMtgOElM6VuRWRwU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=umAUw7fmN2mhX9ckgyMznSPnZUVsnpYUjtTsmI1sAF+YWACI4/p7ahZBYzq9O7MTmY4Iper2/Xhq0k1oRbTagZchZNMFCeuJ6RqPPXnB03ErWho15LkXgKzzb5U+CAjEFEqPrk/+9nxZaO84ZWn6UYSAb2VnooiO00sQeCbDQNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=e9ucpd1Z; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=2YFLjJ/b; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=e9ucpd1Z; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=2YFLjJ/b; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 28E741F44F;
	Wed,  5 Nov 2025 12:04:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762344292; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1h/gJ32w5R4YcpxPIF+ppPWL+XXWJoG88t2CwEGf52Y=;
	b=e9ucpd1ZISfPslVb14qhEwIDBJ43UrRXC1JEtzGXziNMCP/cfTeP08C/bp2A6bAzXdboBZ
	PRGfPWitm5JfATMo0JgYXhk7bR0Y9JwgBd7XRunmvLT0Vz295yDzkt0rDfLndtIG09oy4W
	RpO74z0cPqG6F4PEln46FDTPXkLgxyg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762344292;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1h/gJ32w5R4YcpxPIF+ppPWL+XXWJoG88t2CwEGf52Y=;
	b=2YFLjJ/boLjqDQNNvoJ5PrPceF+xX87IFELiSZiFFjkNDTxT4h3sqT8/21sOB5dzBft3nG
	o4uPMwiOMoKQ+1Dg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=e9ucpd1Z;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="2YFLjJ/b"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762344292; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1h/gJ32w5R4YcpxPIF+ppPWL+XXWJoG88t2CwEGf52Y=;
	b=e9ucpd1ZISfPslVb14qhEwIDBJ43UrRXC1JEtzGXziNMCP/cfTeP08C/bp2A6bAzXdboBZ
	PRGfPWitm5JfATMo0JgYXhk7bR0Y9JwgBd7XRunmvLT0Vz295yDzkt0rDfLndtIG09oy4W
	RpO74z0cPqG6F4PEln46FDTPXkLgxyg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762344292;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1h/gJ32w5R4YcpxPIF+ppPWL+XXWJoG88t2CwEGf52Y=;
	b=2YFLjJ/boLjqDQNNvoJ5PrPceF+xX87IFELiSZiFFjkNDTxT4h3sqT8/21sOB5dzBft3nG
	o4uPMwiOMoKQ+1Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1DF8913699;
	Wed,  5 Nov 2025 12:04:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QyhLB2Q9C2lAOgAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 05 Nov 2025 12:04:52 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id CCEAEA28C2; Wed,  5 Nov 2025 13:04:51 +0100 (CET)
Date: Wed, 5 Nov 2025 13:04:51 +0100
From: Jan Kara <jack@suse.cz>
To: sunyongjian1@huawei.com
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	tytso@mit.edu, jack@suse.cz, yangerkun@huawei.com, yi.zhang@huawei.com, 
	libaokun1@huawei.com, chengzhihao1@huawei.com
Subject: Re: [PATCH 2/2] ext4: improve integrity checking in __mb_check_buddy
 by enhancing order-0 validation
Message-ID: <6mjxlmvxs4p7k3rgs2cx3ny5u3o5tuikzpxxuqepq5yv6xcxk3@nvmzrpu2ooel>
References: <20251105074250.3517687-1-sunyongjian@huaweicloud.com>
 <20251105074250.3517687-3-sunyongjian@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251105074250.3517687-3-sunyongjian@huaweicloud.com>
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 28E741F44F
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.com:email];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Score: -4.01

On Wed 05-11-25 15:42:50, Yongjian Sun wrote:
> From: Yongjian Sun <sunyongjian1@huawei.com>
> 
> When the MB_CHECK_ASSERT macro is enabled, we found that the
> current validation logic in __mb_check_buddy has a gap in
> detecting certain invalid buddy states, particularly related
> to order-0 (bitmap) bits.
> 
> The original logic consists of three steps:
> 1. Validates higher-order buddies: if a higher-order bit is
> set, at most one of the two corresponding lower-order bits
> may be free; if a higher-order bit is clear, both lower-order
> bits must be allocated (and their bitmap bits must be 0).
> 2. For any set bit in order-0, ensures all corresponding
> higher-order bits are not free.
> 3. Verifies that all preallocated blocks (pa) in the group
> have pa_pstart within bounds and their bitmap bits marked as
> allocated.
> 
> However, this approach fails to properly validate cases where
> order-0 bits are incorrectly cleared (0), allowing some invalid
> configurations to pass:
> 
>                corrupt            integral
> 
> order 3           1                  1
> order 2       1       1          1       1
> order 1     1   1   1   1      1   1   1   1
> order 0    0 0 1 1 1 1 1 1    1 1 1 1 1 1 1 1
> 
> Here we get two adjacent free blocks at order-0 with inconsistent
> higher-order state, and the right one shows the correct scenario.
> 
> The root cause is insufficient validation of order-0 zero bits.
> To fix this and improve completeness without significant performance
> cost, we refine the logic:
> 
> 1. Maintain the top-down higher-order validation, but we no longer
> check the cases where the higher-order bit is 0, as this case will
> be covered in step 2.
> 2. Enhance order-0 checking by examining pairs of bits:
>    - If either bit in a pair is set (1), all corresponding
>      higher-order bits must not be free.
>    - If both bits are clear (0), then exactly one of the
>      corresponding higher-order bits must be free
> 3. Keep the preallocation (pa) validation unchanged.
> 
> This change closes the validation gap, ensuring illegal buddy states
> involving order-0 are correctly detected, while removing redundant
> checks and maintaining efficiency.
> 
> Fixes: c9de560ded61f ("ext4: Add multi block allocator for ext4")
> Signed-off-by: Yongjian Sun <sunyongjian1@huawei.com>
> Reviewed-by: Baokun Li <libaokun1@huawei.com>

The idea looks good but I have one question regarding the implementation...

> @@ -747,15 +756,29 @@ static void __mb_check_buddy(struct ext4_buddy *e4b, char *file,
>  				fragments++;
>  				fstart = i;
>  			}
> -			continue;
> +		} else {
> +			fstart = -1;
>  		}
> -		fstart = -1;
> -		/* check used bits only */
> -		for (j = 0; j < e4b->bd_blkbits + 1; j++) {
> -			buddy2 = mb_find_buddy(e4b, j, &max2);
> -			k = i >> j;
> -			MB_CHECK_ASSERT(k < max2);
> -			MB_CHECK_ASSERT(mb_test_bit(k, buddy2));
> +		if (!(i & 1)) {
> +			int in_use, zero_bit_count;
> +
> +			in_use = mb_test_bit(i, buddy) || mb_test_bit(i + 1, buddy);
> +			zero_bit_count = 0;
> +			for (j = 1; j < e4b->bd_blkbits + 2; j++) {
> +				buddy2 = mb_find_buddy(e4b, j, &max2);
> +				k = i >> j;
> +				MB_CHECK_ASSERT(k < max2);
> +				if (in_use) {
> +					/* can not contain any 0 at all orders */
> +					MB_CHECK_ASSERT(mb_test_bit(k, buddy2));
> +				} else {
> +					/* there is and can only be one 0 at all orders */
> +					if (!mb_test_bit(k, buddy2)) {
> +						zero_bit_count++;
> +						MB_CHECK_ASSERT(zero_bit_count == 1);
> +					}
> +				}

Your variant doesn't seem to properly assert that at least 1 bit in the
buddy is 0 above 0 bit in the bitmap because the MB_CHECK_ASSERT() doesn't
get executed in that case at all AFAICT.  I think it would be more
understandable to have the loop like:

			for (j = 1; j < e4b->bd_blkbits + 2; j++) {
				buddy2 = mb_find_buddy(e4b, j, &max2);
				k = i >> j;
				MB_CHECK_ASSERT(k < max2);
				if (!mb_test_bit(k, buddy2))
					zero_bit_count++;
			}
			MB_CHECK_ASSERT(zero_bit_count == !in_use);

									Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

