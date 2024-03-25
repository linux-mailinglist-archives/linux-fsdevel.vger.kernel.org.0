Return-Path: <linux-fsdevel+bounces-15224-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0295188AA86
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Mar 2024 18:01:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26D641C38CCA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Mar 2024 17:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE1407175A;
	Mon, 25 Mar 2024 15:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="WJj/a9I1";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="M93iyWbg";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="WJj/a9I1";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="M93iyWbg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7123A1CD10;
	Mon, 25 Mar 2024 15:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711380655; cv=none; b=c5hcslJHlJKtTE7cmt0vUmM2gRI/O+4vAaZ6FkT7wDU7ArRKR6NgaiLwgbGRwcJIJUkegGRtVPwDqgxdfjcVqZ/WVPGsysw+UVMY2NtfW5yishZMr4aReVtyHXZDLr+NmxoyfHE7gOBc5p31Xn+LRzbttXuj5AfhykAiVeYghYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711380655; c=relaxed/simple;
	bh=mfYSa1yfZfPpDq486hekylx6oaxonD6vYQ8tMP9Zlhk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CgIg4MGiXKItLvIR2TgQuX1z+ZekapDxhn+AU45UWHiUR5XCiwi3oKu3aEPcNoQz8SMB8fMLkdXKq7F29bsx80QA3pEs69KkTDMYES4Rr8b/XJRwDRXMDv1rJ2DUxci0+/q7EeFfavefV1LQeUf3gPWYlERSHrGxcddDJBguwmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=WJj/a9I1; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=M93iyWbg; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=WJj/a9I1; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=M93iyWbg; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 76CB23528E;
	Mon, 25 Mar 2024 15:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1711380651; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tRU5JeE7QDiwpvASu5aYR/CLW5bb30H/jTz3LaISFDE=;
	b=WJj/a9I1uVgRcP9FC5Ea4vyQ0W2lMr0XA/3+uitkkGCHHFiBzSYOCGmpxDsMsgsTY1llTh
	jRvJaNW4JUiT8HyoiWZLpWfSLQ4EP3OItZTNSIaJp8ZAdwn+uCBJH/NJTCSMdQZ3/Mum8x
	S+pFySUbwBJOxcibZ5wk69ry50d340E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1711380651;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tRU5JeE7QDiwpvASu5aYR/CLW5bb30H/jTz3LaISFDE=;
	b=M93iyWbgE+MbqzM5gtgY+M4Q+v2vOzq3t2HbC+OB0OODL0nIRpSnwJKdRvAVNKuzRiWlMZ
	kMcmfDvZFf8pwvBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1711380651; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tRU5JeE7QDiwpvASu5aYR/CLW5bb30H/jTz3LaISFDE=;
	b=WJj/a9I1uVgRcP9FC5Ea4vyQ0W2lMr0XA/3+uitkkGCHHFiBzSYOCGmpxDsMsgsTY1llTh
	jRvJaNW4JUiT8HyoiWZLpWfSLQ4EP3OItZTNSIaJp8ZAdwn+uCBJH/NJTCSMdQZ3/Mum8x
	S+pFySUbwBJOxcibZ5wk69ry50d340E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1711380651;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tRU5JeE7QDiwpvASu5aYR/CLW5bb30H/jTz3LaISFDE=;
	b=M93iyWbgE+MbqzM5gtgY+M4Q+v2vOzq3t2HbC+OB0OODL0nIRpSnwJKdRvAVNKuzRiWlMZ
	kMcmfDvZFf8pwvBQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 682BA13A71;
	Mon, 25 Mar 2024 15:30:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id tpATGauYAWbNOgAAn2gu4w
	(envelope-from <jack@suse.cz>); Mon, 25 Mar 2024 15:30:51 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 08088A0812; Mon, 25 Mar 2024 16:30:47 +0100 (CET)
Date: Mon, 25 Mar 2024 16:30:46 +0100
From: Jan Kara <jack@suse.cz>
To: Liu Shixin <liushixin2@huawei.com>
Cc: Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH v2 2/2] mm/readahead: don't decrease mmap_miss when folio
 has workingset flags
Message-ID: <20240325153046.5m5xls7emjfa45da@quack3>
References: <20240322093555.226789-1-liushixin2@huawei.com>
 <20240322093555.226789-3-liushixin2@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240322093555.226789-3-liushixin2@huawei.com>
X-Spam-Score: -1.06
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spamd-Result: default: False [-1.06 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[9];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.05)[60.05%];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:98:from]
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="WJj/a9I1";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=M93iyWbg
X-Rspamd-Queue-Id: 76CB23528E

On Fri 22-03-24 17:35:55, Liu Shixin wrote:
> If there are too many folios that are recently evicted in a file, then
> they will probably continue to be evicted. In such situation, there is
> no positive effect to read-ahead this file since it is only a waste of IO.
> 
> The mmap_miss is increased in do_sync_mmap_readahead() and decreased in
> both do_async_mmap_readahead() and filemap_map_pages(). In order to skip
> read-ahead in above scenario, the mmap_miss have to increased exceed
> MMAP_LOTSAMISS. This can be done by stop decreased mmap_miss when folio
> has workingset flags. The async path is not to care because in above
> scenario, it's hard to run into the async path.
> 
> Signed-off-by: Liu Shixin <liushixin2@huawei.com>
...
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 8df4797c5287..753771310127 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -3439,7 +3439,8 @@ static vm_fault_t filemap_map_folio_range(struct vm_fault *vmf,
>  		if (PageHWPoison(page + count))
>  			goto skip;
>  
> -		(*mmap_miss)++;
> +		if (!folio_test_workingset(folio))
> +			(*mmap_miss)++;

Hum, so this means we consider this a 'hit' if the page is completely new
in the page cache or evicted long time ago. OK, makes sense. It would be
nice to add a comment in this direction to explain the condition. Frankly
the whole mmap_miss accounting is broken as I've outlined in my patch
series. But I guess this works as a fixup for your immediate problem and
we can make mmap_miss accounting sensible later. So for now feel free to
add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

