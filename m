Return-Path: <linux-fsdevel+bounces-11375-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DA288533F4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 16:01:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 363D7286730
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 15:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24D6E5FDAF;
	Tue, 13 Feb 2024 14:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="measIJ+s";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="W1aU9kpx";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="measIJ+s";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="W1aU9kpx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E188B5FB87;
	Tue, 13 Feb 2024 14:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707836349; cv=none; b=h7h4227lRts0lrMBal1Dt3YnDmK/AjNQH6W67VBJcAK/y8rfrV+HZ7QwzcLE1356yq/Uj8BriV1uruaDID7R0+F/kQIDCZVeQWpxcUoeMxSB9AS4aMKhoGyeEWSfyCUnBCaPkwYEPdYbCT3dQz2W7ArssMkH5tDcZTY1HDeTOrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707836349; c=relaxed/simple;
	bh=lwDiefLr+6YNJuKpC2MVkJ3EdHMrWM5cYSTU8gjxlyw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ehLLSIl2fx1LOG33Fcy9ODCNFJpdWdxXnW8h2BqhC5TxiSJ5v+0cz1ElsxhCIsmbHASIP48+rRbX4XhEb5mPAozwUmbWUpaeGt/GDNWbGticT+b/YX5QSjvatOU3JqmGTdklov5hF/m2E3v8gESBdzhUho9yVPYU+YL4rxX5zKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=measIJ+s; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=W1aU9kpx; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=measIJ+s; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=W1aU9kpx; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 21A852119E;
	Tue, 13 Feb 2024 14:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707836346; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eufzaWWPAUssvZikIcFqIIx+tlwz0ocVifv5kBaKKzM=;
	b=measIJ+sCTswty41h1307+dp1qvphy13BhDlnS9GJ4V0JBccKmFo9jh2V/uePSbm0JtPmo
	gA2wUKJhVeMJVT0b3P+Y0WacXNnh1iIYHOSJr0Otb3GQksQR5+4o9RV+96S3wSU6IBL1jl
	7ZUaWsVmwstpBub29rMGDAGMOxuJYiU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707836346;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eufzaWWPAUssvZikIcFqIIx+tlwz0ocVifv5kBaKKzM=;
	b=W1aU9kpxJcVQiMECPTywtnKWjo5cDhb/BnzpQKAfDE1VnDqa+NIxzPO+RuVW3Az8DQIZFO
	X6aJYfpqGcppkdCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707836346; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eufzaWWPAUssvZikIcFqIIx+tlwz0ocVifv5kBaKKzM=;
	b=measIJ+sCTswty41h1307+dp1qvphy13BhDlnS9GJ4V0JBccKmFo9jh2V/uePSbm0JtPmo
	gA2wUKJhVeMJVT0b3P+Y0WacXNnh1iIYHOSJr0Otb3GQksQR5+4o9RV+96S3wSU6IBL1jl
	7ZUaWsVmwstpBub29rMGDAGMOxuJYiU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707836346;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eufzaWWPAUssvZikIcFqIIx+tlwz0ocVifv5kBaKKzM=;
	b=W1aU9kpxJcVQiMECPTywtnKWjo5cDhb/BnzpQKAfDE1VnDqa+NIxzPO+RuVW3Az8DQIZFO
	X6aJYfpqGcppkdCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E2CA913404;
	Tue, 13 Feb 2024 14:59:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kJNVNrmDy2VlMwAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 13 Feb 2024 14:59:05 +0000
Message-ID: <a11a5c34-e8c4-48fb-82b6-6956f253224a@suse.de>
Date: Tue, 13 Feb 2024 15:59:05 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 04/14] readahead: set file_ra_state->ra_pages to be at
 least mapping_min_order
Content-Language: en-US
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>,
 linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc: mcgrof@kernel.org, gost.dev@samsung.com, akpm@linux-foundation.org,
 kbusch@kernel.org, djwong@kernel.org, chandan.babu@oracle.com,
 p.raghav@samsung.com, linux-kernel@vger.kernel.org, willy@infradead.org,
 linux-mm@kvack.org, david@fromorbit.com
References: <20240213093713.1753368-1-kernel@pankajraghav.com>
 <20240213093713.1753368-5-kernel@pankajraghav.com>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20240213093713.1753368-5-kernel@pankajraghav.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -2.20
X-Spamd-Result: default: False [-2.20 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BAYES_HAM(-0.91)[86.16%];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_TWELVE(0.00)[14];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Flag: NO

On 2/13/24 10:37, Pankaj Raghav (Samsung) wrote:
> From: Luis Chamberlain <mcgrof@kernel.org>
> 
> Set the file_ra_state->ra_pages in file_ra_state_init() to be at least
> mapping_min_order of pages if the bdi->ra_pages is less than that.
> 
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
>   mm/readahead.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/mm/readahead.c b/mm/readahead.c
> index 2648ec4f0494..4fa7d0e65706 100644
> --- a/mm/readahead.c
> +++ b/mm/readahead.c
> @@ -138,7 +138,12 @@
>   void
>   file_ra_state_init(struct file_ra_state *ra, struct address_space *mapping)
>   {
> +	unsigned int min_nrpages = mapping_min_folio_nrpages(mapping);
> +	unsigned int max_pages = inode_to_bdi(mapping->host)->io_pages;
> +
>   	ra->ra_pages = inode_to_bdi(mapping->host)->ra_pages;
> +	if (ra->ra_pages < min_nrpages && min_nrpages < max_pages)
> +		ra->ra_pages = min_nrpages;
>   	ra->prev_pos = -1;
>   }
>   EXPORT_SYMBOL_GPL(file_ra_state_init);

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes


