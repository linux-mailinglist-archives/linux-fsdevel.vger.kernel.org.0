Return-Path: <linux-fsdevel+bounces-34755-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91D7A9C8777
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2024 11:26:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FF461F22347
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2024 10:26:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D69A11FC7CD;
	Thu, 14 Nov 2024 10:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="2advFqcm";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="olXFPcll";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="sd0/pdNn";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="NgcSbVM6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 163021FBF54;
	Thu, 14 Nov 2024 10:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731579438; cv=none; b=RfPhaJpNl2+dQqKoZ5QdHksVmZkK6a35QQDMSjNNGoqq5T3tTWC+8Ir+phLEF3irdA38ha2ouuD7HsRiTnUzTVmPkt0LdKa9gX51+vgPWaF9zzJqCrRzMlBylkpQSO//ZttZu5RPFvSRErMEobo9c30U8tLpSh/8cLNNC6/TmfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731579438; c=relaxed/simple;
	bh=xvEXki5rY6rq1ezmDvimjqNRLcvjI3eC9py2uwrrtog=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mZw5BiWjMgjJpys/s/Panozsqo7h+0aZyOuhsofEu2CmU9+TKwydBspdzxDncUwx5Jr2peG2MSuEuchituXshOa33i2xb98w04GOmjobHAgGYoFo9w4ZHlhhHhKyy7akjS8UDEZIJvnhINTXpa9t2iaPTTNqD/A/IrqU/sfK82U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=2advFqcm; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=olXFPcll; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=sd0/pdNn; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=NgcSbVM6; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id EE7AA1F38F;
	Thu, 14 Nov 2024 10:17:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1731579433; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=KXwfhGjSxSpSj0pGG+aPpwV4jc+WfSo/ZyjjkVNLhD8=;
	b=2advFqcmp88eM1ELJLeclGt8f6PwY0PcXPierG0StArK21WrPf/Xqri1R8yybsexfo99T1
	/yEghD+9vbM4GLhf6mz/6lJd7y1k7lj5tVQij33i2jgsLIkBwLVSbkJJwmxcfH8ZOTE5ZZ
	SqvqiuN5fJcdEC1FOLoMSrI3NTddYvo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1731579433;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=KXwfhGjSxSpSj0pGG+aPpwV4jc+WfSo/ZyjjkVNLhD8=;
	b=olXFPcllzV/cIchqiZBLEb2GtYqc7S4zvgjVofSEe9bifNiTJ2OT5VVaGGa6MROiPpfHvN
	OfMyEJMkMF9fp7BA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="sd0/pdNn";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=NgcSbVM6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1731579432; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=KXwfhGjSxSpSj0pGG+aPpwV4jc+WfSo/ZyjjkVNLhD8=;
	b=sd0/pdNnjo9HPwxHfe/4kRB8NVLlanetxrhkhnAYznAw925jIpqW6yhQfqXRRZS98glv25
	3SaL3ysbMtWoaPGKtosSm5aLuQ0+HZth2x9pNGzB/WQoAUCL78KOQ6c9PJ6dXahUnY7MXP
	Z5JJCkPmo5yXhvu5vfrswsvYphdWG4s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1731579432;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=KXwfhGjSxSpSj0pGG+aPpwV4jc+WfSo/ZyjjkVNLhD8=;
	b=NgcSbVM66hX4midzeCNRRUmR0+nJw6nxkjWTnpyzPgcZx87yEZkg5DwRfXlRvqG/Zl39SP
	VhF5Vqphga3bSHBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B313313721;
	Thu, 14 Nov 2024 10:17:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id I/VlKyjONWcXHgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Thu, 14 Nov 2024 10:17:12 +0000
Message-ID: <d9089ef0-3abd-4148-949c-cab66890b98b@suse.cz>
Date: Thu, 14 Nov 2024 11:17:12 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 06/57] mm: Remove PAGE_SIZE compile-time constant
 assumption
Content-Language: en-US
To: Ryan Roberts <ryan.roberts@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Ard Biesheuvel <ardb@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 Christoph Lameter <cl@linux.com>, David Hildenbrand <david@redhat.com>,
 David Rientjes <rientjes@google.com>, Greg Marsden
 <greg.marsden@oracle.com>, Ivan Ivanov <ivan.ivanov@suse.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 Kalesh Singh <kaleshsingh@google.com>, Marc Zyngier <maz@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Matthias Brugger <mbrugger@suse.com>,
 Michal Hocko <mhocko@kernel.org>, Miquel Raynal <miquel.raynal@bootlin.com>,
 Miroslav Benes <mbenes@suse.cz>, Pekka Enberg <penberg@kernel.org>,
 Richard Weinberger <richard@nod.at>, Shakeel Butt <shakeel.butt@linux.dev>,
 Vignesh Raghavendra <vigneshr@ti.com>, Will Deacon <will@kernel.org>
Cc: cgroups@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-mtd@lists.infradead.org
References: <20241014105514.3206191-1-ryan.roberts@arm.com>
 <20241014105912.3207374-1-ryan.roberts@arm.com>
 <20241014105912.3207374-6-ryan.roberts@arm.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <20241014105912.3207374-6-ryan.roberts@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: EE7AA1F38F
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[30];
	ARC_NA(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLe77yb3u88x3tt1x5utjqsmp8)];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51
X-Spam-Flag: NO

On 10/14/24 12:58, Ryan Roberts wrote:
> To prepare for supporting boot-time page size selection, refactor code
> to remove assumptions about PAGE_SIZE being compile-time constant. Code
> intended to be equivalent when compile-time page size is active.
> 
> Refactor "struct vmap_block" to use a flexible array for used_mmap since
> VMAP_BBMAP_BITS is not a compile time constant for the boot-time page
> size case.
> 
> Update various BUILD_BUG_ON() instances to check against appropriate
> page size limit.
> 
> Re-define "union swap_header" so that it's no longer exactly page-sized.
> Instead define a flexible "magic" array with a define which tells the
> offset to where the magic signature begins.
> 
> Consider page size limit in some CPP condditionals.
> 
> Wrap global variables that are initialized with PAGE_SIZE derived values
> using DEFINE_GLOBAL_PAGE_SIZE_VAR() so their initialization can be
> deferred for boot-time page size builds.
> 
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> ---
> 
> ***NOTE***
> Any confused maintainers may want to read the cover note here for context:
> https://lore.kernel.org/all/20241014105514.3206191-1-ryan.roberts@arm.com/
> 
>  drivers/mtd/mtdswap.c         |  4 ++--
>  include/linux/mm.h            |  2 +-
>  include/linux/mm_types_task.h |  2 +-
>  include/linux/mmzone.h        |  3 ++-
>  include/linux/slab.h          |  7 ++++---
>  include/linux/swap.h          | 17 ++++++++++++-----
>  include/linux/swapops.h       |  6 +++++-
>  mm/memcontrol.c               |  2 +-
>  mm/memory.c                   |  4 ++--
>  mm/mmap.c                     |  2 +-
>  mm/page-writeback.c           |  2 +-
>  mm/slub.c                     |  2 +-
>  mm/sparse.c                   |  2 +-
>  mm/swapfile.c                 |  2 +-
>  mm/vmalloc.c                  |  7 ++++---
>  15 files changed, 39 insertions(+), 25 deletions(-)
> 

> --- a/include/linux/swap.h
> +++ b/include/linux/swap.h
> @@ -132,10 +132,17 @@ static inline int current_is_kswapd(void)
>   * bootbits...
>   */
>  union swap_header {
> -	struct {
> -		char reserved[PAGE_SIZE - 10];
> -		char magic[10];			/* SWAP-SPACE or SWAPSPACE2 */
> -	} magic;
> +	/*
> +	 * Exists conceptually, but since PAGE_SIZE may not be known at compile
> +	 * time, we must access through pointer arithmetic at run time.
> +	 *
> +	 * struct {
> +	 * 	char reserved[PAGE_SIZE - 10];
> +	 * 	char magic[10];			   SWAP-SPACE or SWAPSPACE2
> +	 * } magic;
> +	 */
> +#define SWAP_HEADER_MAGIC	(PAGE_SIZE - 10)
> +	char magic[1];

I wonder if it makes sense to even keep this magic field anymore.

>  	struct {
>  		char		bootbits[1024];	/* Space for disklabel etc. */
>  		__u32		version;
> @@ -201,7 +208,7 @@ struct swap_extent {
>   * Max bad pages in the new format..
>   */
>  #define MAX_SWAP_BADPAGES \
> -	((offsetof(union swap_header, magic.magic) - \
> +	((SWAP_HEADER_MAGIC - \
>  	  offsetof(union swap_header, info.badpages)) / sizeof(int))
>  
>  enum {

<snip>

> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -2931,7 +2931,7 @@ static unsigned long read_swap_header(struct swap_info_struct *p,
>  	unsigned long swapfilepages;
>  	unsigned long last_page;
>  
> -	if (memcmp("SWAPSPACE2", swap_header->magic.magic, 10)) {
> +	if (memcmp("SWAPSPACE2", &swap_header->magic[SWAP_HEADER_MAGIC], 10)) {

I'd expect static checkers to scream here because we overflow the magic[1]
both due to copying 10 bytes into 1 byte array and also with the insane
offset. Hence my suggestion to drop the field and use purely pointer arithmetic.

>  		pr_err("Unable to find swap-space signature\n");
>  		return 0;
>  	}
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index a0df1e2e155a8..b4fbba204603c 100644

Hm I'm actually looking at yourwip branch which also has:

--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -969,7 +969,7 @@ static inline int get_order_from_str(const char *size_str)
        return -EINVAL;
 }

-static char str_dup[PAGE_SIZE] __initdata;
+static char str_dup[PAGE_SIZE_MAX] __initdata;
 static int __init setup_thp_anon(char *str)
 {
        char *token, *range, *policy, *subtoken;

Why PAGE_SIZE_MAX? Isn't this the same case as "mm/memcontrol: Fix seq_buf
size to save memory when PAGE_SIZE is large"

