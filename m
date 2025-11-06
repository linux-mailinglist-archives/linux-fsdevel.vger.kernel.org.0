Return-Path: <linux-fsdevel+bounces-67273-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 53730C39F75
	for <lists+linux-fsdevel@lfdr.de>; Thu, 06 Nov 2025 10:59:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E95EF4FB5F1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Nov 2025 09:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B25B30F53A;
	Thu,  6 Nov 2025 09:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="mOGFYZdB";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="oTk3RRCR";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="VpFzHZKz";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="9u0tum4U"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D423E30CD82
	for <linux-fsdevel@vger.kernel.org>; Thu,  6 Nov 2025 09:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762422753; cv=none; b=tj35p2sAgbVDoMOrL0AqhdQO0Vrx51jqofVS/+l7JBMd1w0XAyyzeC1/gXuQMxY4g/VKtT9MwbAjEEJLUqd7pjpc6QO0uHsVNlpNWtNwP5z1uIUBg18Q9z1RwccMcXc5XeeLjV/1bgNAgI3PPUom/KEGMOFtfTP0Mup0knFNhvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762422753; c=relaxed/simple;
	bh=3z9tKiixu75cZygPG7DEIhtsy5nshE6QhyCC2aOakFs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FIWj+76k0xPZ9athcj28RfoPKBSkDzdM+ZOSiIsihaRPluhEytLmUoQOzwvRUnsfI0vQjq0huNmXrzvFxwibIumAk8TNMw4oREiRkFa2Dx45qSe+kIOpQ2GcOHssPVjKAHz/yhAuSaAWmsg5PQUUEr29utO56F8KyUTXT/B4z8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=mOGFYZdB; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=oTk3RRCR; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=VpFzHZKz; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=9u0tum4U; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 252B7211C7;
	Thu,  6 Nov 2025 09:52:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762422750; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bPqnD4mmA6cHcO1NRezM92gePmu8aG6SvFf8KMO34c8=;
	b=mOGFYZdBqHKpcZVGcmrS7wuFUtBuGhFrNhr/8vyLkgopPDn2KVTCkSoiVK7qLW2fESwrCE
	cCNbuBm4GKiTnHgEY/nQxi52GofltzdqAc2vZQwEtwQulXZnYYC7cGRIt55KLDe7TXmMtH
	RjA0cuYOspsyVYnAGM2Xgvp7KjMNaUw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762422750;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bPqnD4mmA6cHcO1NRezM92gePmu8aG6SvFf8KMO34c8=;
	b=oTk3RRCRFs+N6ivHodgC9R0J7iahYFJnhHkQtXgkreRm4ortj4rC27iHoZEN4kqkASFF1l
	lXwlWCjmP66Q9fDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762422749; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bPqnD4mmA6cHcO1NRezM92gePmu8aG6SvFf8KMO34c8=;
	b=VpFzHZKzt6ElQkTPRuDl0M7K1GviJSGUqeIDhC69lTmzXoX79Ip04u2IOT1nzyXf+CD1cr
	AGqRp6PaDw3yMBgfwVo2kR2LHqmM063PSP/cJA5+1IYMSGGYYmRNwNJHHADZivu/2ColCr
	nEShgVvGdtvU4CJtWo1QViLr9vArWh8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762422749;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bPqnD4mmA6cHcO1NRezM92gePmu8aG6SvFf8KMO34c8=;
	b=9u0tum4UHAxT3iYAuUaJo0unhlyEtpqztxglC11YzH3XI2Hyr6Td6h5AlAVk4CUFHXWHjs
	Ulv7t4oj98NRk+BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1A25B139A9;
	Thu,  6 Nov 2025 09:52:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id exZXBt1vDGmJLQAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 06 Nov 2025 09:52:29 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id BED5CA0948; Thu,  6 Nov 2025 10:52:20 +0100 (CET)
Date: Thu, 6 Nov 2025 10:52:20 +0100
From: Jan Kara <jack@suse.cz>
To: sunyongjian1@huawei.com
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	tytso@mit.edu, jack@suse.cz, yangerkun@huawei.com, yi.zhang@huawei.com, 
	libaokun1@huawei.com, chengzhihao1@huawei.com
Subject: Re: [PATCH v2 2/2] ext4: improve integrity checking in
 __mb_check_buddy by enhancing order-0 validation
Message-ID: <hbb6z62m4km5nm22tyn7xa4bcdbtqqnzwtygbqjosa4gayl2db@gcdpvei7rsjo>
References: <20251106060614.631382-1-sunyongjian@huaweicloud.com>
 <20251106060614.631382-3-sunyongjian@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251106060614.631382-3-sunyongjian@huaweicloud.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -3.80

On Thu 06-11-25 14:06:14, Yongjian Sun wrote:
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
> Suggested-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Yongjian Sun <sunyongjian1@huawei.com>
> Reviewed-by: Baokun Li <libaokun1@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/mballoc.c | 49 +++++++++++++++++++++++++++++++----------------
>  1 file changed, 32 insertions(+), 17 deletions(-)
> 
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 194a9f995c36..65335248825c 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -682,6 +682,24 @@ do {									\
>  	}								\
>  } while (0)
>  
> +/*
> + * Perform buddy integrity check with the following steps:
> + *
> + * 1. Top-down validation (from highest order down to order 1, excluding order-0 bitmap):
> + *    For each pair of adjacent orders, if a higher-order bit is set (indicating a free block),
> + *    at most one of the two corresponding lower-order bits may be clear (free).
> + *
> + * 2. Order-0 (bitmap) validation, performed on bit pairs:
> + *    - If either bit in a pair is set (1, allocated), then all corresponding higher-order bits
> + *      must not be free (0).
> + *    - If both bits in a pair are clear (0, free), then exactly one of the corresponding
> + *      higher-order bits must be free (0).
> + *
> + * 3. Preallocation (pa) list validation:
> + *    For each preallocated block (pa) in the group:
> + *    - Verify that pa_pstart falls within the bounds of this block group.
> + *    - Ensure the corresponding bit(s) in the order-0 bitmap are marked as allocated (1).
> + */
>  static void __mb_check_buddy(struct ext4_buddy *e4b, char *file,
>  				const char *function, int line)
>  {
> @@ -723,15 +741,6 @@ static void __mb_check_buddy(struct ext4_buddy *e4b, char *file,
>  				continue;
>  			}
>  
> -			/* both bits in buddy2 must be 1 */
> -			MB_CHECK_ASSERT(mb_test_bit(i << 1, buddy2));
> -			MB_CHECK_ASSERT(mb_test_bit((i << 1) + 1, buddy2));
> -
> -			for (j = 0; j < (1 << order); j++) {
> -				k = (i * (1 << order)) + j;
> -				MB_CHECK_ASSERT(
> -					!mb_test_bit(k, e4b->bd_bitmap));
> -			}
>  			count++;
>  		}
>  		MB_CHECK_ASSERT(e4b->bd_info->bb_counters[order] == count);
> @@ -747,15 +756,21 @@ static void __mb_check_buddy(struct ext4_buddy *e4b, char *file,
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
> +			int in_use, zero_bit_count = 0;
> +
> +			in_use = mb_test_bit(i, buddy) || mb_test_bit(i + 1, buddy);
> +			for (j = 1; j < e4b->bd_blkbits + 2; j++) {
> +				buddy2 = mb_find_buddy(e4b, j, &max2);
> +				k = i >> j;
> +				MB_CHECK_ASSERT(k < max2);
> +				if (!mb_test_bit(k, buddy2))
> +					zero_bit_count++;
> +			}
> +			MB_CHECK_ASSERT(zero_bit_count == !in_use);
>  		}
>  	}
>  	MB_CHECK_ASSERT(!EXT4_MB_GRP_NEED_INIT(e4b->bd_info));
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

