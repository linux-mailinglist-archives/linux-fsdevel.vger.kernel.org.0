Return-Path: <linux-fsdevel+bounces-40934-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0014FA2960B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2025 17:18:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 121A21684B5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2025 16:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD7AF1B6CE3;
	Wed,  5 Feb 2025 16:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="DMrpjL3L";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="kQMH8M2I";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="DMrpjL3L";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="kQMH8M2I"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D0411519BA;
	Wed,  5 Feb 2025 16:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738772305; cv=none; b=kzzVeSa/D1VFBh+2qdW6amuS13+IMoYUj2aHmtBCpc6vllmDArdlOjZBGo6Prp95CSSCby7zCmsY8PY967YfIU4hgjNSxUlP/UgIT+xWnvsQ22v3JedKh6zDo0vCUaAe6htae1srWUua0BDTBwocbT+irZRU/TLk3JMsRPJUKxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738772305; c=relaxed/simple;
	bh=P056bjDNXC4WDtTebP9aDBpebM865lPz+KZT7ckxHTc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c5ccFqPrdccfWu3XZJEzJRnYq2Dn0tju+wSS5Hv9EsJUh2SkrppT11Oil5M07qvUfYNOqy7CSmZ3DQJEwmfOuXi3OZbj7fBg0u1RXQjjL8zGGY1cGysPHLtTOlPOWck+JVGY1PRtOnrt0/34GDGnNjLOz1SDkUVyVjxtj2KOKkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=DMrpjL3L; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=kQMH8M2I; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=DMrpjL3L; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=kQMH8M2I; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 983AC2127C;
	Wed,  5 Feb 2025 16:18:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738772301; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qqXMYTGRPo//iC4U6ET+snD1ntsXXfRNOFComRHHCgM=;
	b=DMrpjL3L5UVfUDm93oaO+VKDWFmu/e+rkIpfk5qrtpgk9AdAMMU2a8GdsXXzklH3oDQ+bd
	1Cxgz/phvR/+65wq9qwyDITOIarvFMhzFCHFdgZ880ZSwvml/9IPY3pubHupqFUeF1JQPf
	QECo89Bc9mmEWJ0KtLzcxjcqkATVfT0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738772301;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qqXMYTGRPo//iC4U6ET+snD1ntsXXfRNOFComRHHCgM=;
	b=kQMH8M2IwNV5WtepSpNP4NeSL02tUF3TlNkvI9+uubUP6vBuVY9Yt9I6DDLvfMCOSmYKDn
	2EKHTenv7NvRXEBA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=DMrpjL3L;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=kQMH8M2I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738772301; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qqXMYTGRPo//iC4U6ET+snD1ntsXXfRNOFComRHHCgM=;
	b=DMrpjL3L5UVfUDm93oaO+VKDWFmu/e+rkIpfk5qrtpgk9AdAMMU2a8GdsXXzklH3oDQ+bd
	1Cxgz/phvR/+65wq9qwyDITOIarvFMhzFCHFdgZ880ZSwvml/9IPY3pubHupqFUeF1JQPf
	QECo89Bc9mmEWJ0KtLzcxjcqkATVfT0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738772301;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qqXMYTGRPo//iC4U6ET+snD1ntsXXfRNOFComRHHCgM=;
	b=kQMH8M2IwNV5WtepSpNP4NeSL02tUF3TlNkvI9+uubUP6vBuVY9Yt9I6DDLvfMCOSmYKDn
	2EKHTenv7NvRXEBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2365813694;
	Wed,  5 Feb 2025 16:18:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Fpb7Bk2Po2eNMwAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 05 Feb 2025 16:18:21 +0000
Message-ID: <1b211dd3-a45d-4a2e-aa2a-e0d3e302d4ca@suse.de>
Date: Wed, 5 Feb 2025 17:18:20 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/8] fs/buffer: simplify block_read_full_folio() with
 bh_offset()
To: Luis Chamberlain <mcgrof@kernel.org>, willy@infradead.org,
 dave@stgolabs.net, david@fromorbit.com, djwong@kernel.org, kbusch@kernel.org
Cc: john.g.garry@oracle.com, hch@lst.de, ritesh.list@gmail.com,
 linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
 linux-mm@kvack.org, linux-block@vger.kernel.org, gost.dev@samsung.com,
 p.raghav@samsung.com, da.gomez@samsung.com, kernel@pankajraghav.com
References: <20250204231209.429356-1-mcgrof@kernel.org>
 <20250204231209.429356-2-mcgrof@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250204231209.429356-2-mcgrof@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 983AC2127C
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TAGGED_RCPT(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[oracle.com,lst.de,gmail.com,vger.kernel.org,kvack.org,samsung.com,pankajraghav.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On 2/5/25 00:12, Luis Chamberlain wrote:
> When we read over all buffers in a folio we currently use the
> buffer index on the folio and blocksize to get the offset. Simplify
> this with bh_offset(). This simplifies the loop while making no
> functional changes.
> 
> Suggested-by: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
>   fs/buffer.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/buffer.c b/fs/buffer.c
> index cc8452f60251..b99560e8a142 100644
> --- a/fs/buffer.c
> +++ b/fs/buffer.c
> @@ -2381,7 +2381,6 @@ int block_read_full_folio(struct folio *folio, get_block_t *get_block)
>   	lblock = div_u64(limit + blocksize - 1, blocksize);
>   	bh = head;
>   	nr = 0;
> -	i = 0;
>   
>   	do {
>   		if (buffer_uptodate(bh))
> @@ -2398,7 +2397,7 @@ int block_read_full_folio(struct folio *folio, get_block_t *get_block)
>   					page_error = true;
>   			}
>   			if (!buffer_mapped(bh)) {
> -				folio_zero_range(folio, i * blocksize,
> +				folio_zero_range(folio, bh_offset(bh),
>   						blocksize);
>   				if (!err)
>   					set_buffer_uptodate(bh);
> @@ -2412,7 +2411,7 @@ int block_read_full_folio(struct folio *folio, get_block_t *get_block)
>   				continue;
>   		}
>   		arr[nr++] = bh;
> -	} while (i++, iblock++, (bh = bh->b_this_page) != head);
> +	} while (iblock++, (bh = bh->b_this_page) != head);
>   
>   	if (fully_mapped)
>   		folio_set_mappedtodisk(folio);

One wonders: shouldn't we use plugging here to make I/O more efficient?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

