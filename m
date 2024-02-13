Return-Path: <linux-fsdevel+bounces-11378-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BEEB853422
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 16:04:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA7642841AE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 15:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02D775FDA1;
	Tue, 13 Feb 2024 15:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="szUl72B+";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="pB4wlgdE";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="o9IGtX0d";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="qKc059pN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2CA65F875;
	Tue, 13 Feb 2024 15:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707836546; cv=none; b=o1Jiv+6mFSEbkgBx+fq/yIe1kV16mszOFfXAh8gNGtQ6cyISAvD07HR61SxbxjPdtM0EAzitWzJvIAGFqXCHNFHcow+wogKzNk2qizisjklFJ6uk5qUX0d5hNd2fAQiO10xH1ltDncvaLGiEU87/Yk9QyKLLFbgxXQz5o0qmLws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707836546; c=relaxed/simple;
	bh=eD3n1DvnnA0M9NFRVpspeNsUx9c6TLcRCtfrJaIZcys=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mDWDV0/UaO0RVBsnMUpbILK7nATtPfgxZyLVIBvxPzLS+E43rxc5ufrO/rbfrTjYmee0FoJ6Z3HnFDAliDsq9kpWJRp90e2Y0V6h3cX2/jlrJ5jpQwBNAk4z6jWC0Z0QwtTIV1WzQr63f1yBq72cW34V4+2rapSzaD9Kkh59hTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=szUl72B+; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=pB4wlgdE; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=o9IGtX0d; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=qKc059pN; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3AE8421AFD;
	Tue, 13 Feb 2024 15:02:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707836543; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YT1Rr5EWPvxoN+JMJcAcT2S5g9ul6hPcJDVKcRLYfJ4=;
	b=szUl72B+6uo1DF7EH2JHX7ZuNfwKO9N5ZK9CYmHPgFApxJ76c41tdr3VYjfdZ4VWopRy+R
	v86gHcXZswxZVlB1uOrg27bIHL+YowY2sMbupA74jRu8bk/YjXBG23xkV7OrqODSyVh/tF
	qZ5Fxd1dbythUDszV6YVZIqpoUjnDXM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707836543;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YT1Rr5EWPvxoN+JMJcAcT2S5g9ul6hPcJDVKcRLYfJ4=;
	b=pB4wlgdErdYLk2ZZK7SOEhpOT94jvQ885Sycon3Vg6KyfDqnRZXpRVjXiTfMf0YYljMJLE
	xlsnfIeE4/f8P5Cw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707836541; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YT1Rr5EWPvxoN+JMJcAcT2S5g9ul6hPcJDVKcRLYfJ4=;
	b=o9IGtX0dCKnhUL5WW4GxZwsXndxBXQfy+f8gbuAOn/8d5rIzuRxOvMPwNw1l1qbLB+e96H
	3UGfopXY2EZ/1pWQ+3u6GeiKtnHFTccpgxH4n7zshA1rI0JODqG+CJOO7Tu/3uU03WdBKi
	NZu5qVRTt8Xxw88iKGMmgcdxkGcXjB4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707836541;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YT1Rr5EWPvxoN+JMJcAcT2S5g9ul6hPcJDVKcRLYfJ4=;
	b=qKc059pNKsq65TuPbj3YpSNhE/bQf5j5AlEM/PpbkVwv5hHTMNAk0GpfXrdgXufpErhIyS
	V+1d6okHsIFTjNDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F37BB13404;
	Tue, 13 Feb 2024 15:02:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GOhHOnyEy2VlMwAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 13 Feb 2024 15:02:20 +0000
Message-ID: <45e982ba-c983-4c57-96cb-6bd0d342a46f@suse.de>
Date: Tue, 13 Feb 2024 16:02:20 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 08/14] mm: do not split a folio if it has minimum folio
 order requirement
Content-Language: en-US
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>,
 linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc: mcgrof@kernel.org, gost.dev@samsung.com, akpm@linux-foundation.org,
 kbusch@kernel.org, djwong@kernel.org, chandan.babu@oracle.com,
 p.raghav@samsung.com, linux-kernel@vger.kernel.org, willy@infradead.org,
 linux-mm@kvack.org, david@fromorbit.com
References: <20240213093713.1753368-1-kernel@pankajraghav.com>
 <20240213093713.1753368-9-kernel@pankajraghav.com>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20240213093713.1753368-9-kernel@pankajraghav.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-0.22 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BAYES_HAM(-0.13)[67.80%];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCPT_COUNT_TWELVE(0.00)[14];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[samsung.com:email,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -0.22

On 2/13/24 10:37, Pankaj Raghav (Samsung) wrote:
> From: Pankaj Raghav <p.raghav@samsung.com>
> 
> As we don't have a way to split a folio to a any given lower folio
> order yet, avoid splitting the folio in split_huge_page_to_list() if it
> has a minimum folio order requirement.
> 
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
>   mm/huge_memory.c | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 94c958f7ebb5..d897efc51025 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -3026,6 +3026,19 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
>   			goto out;
>   		}
>   
> +		/*
> +		 * Do not split if mapping has minimum folio order
> +		 * requirement.
> +		 *
> +		 * XXX: Once we have support for splitting to any lower
> +		 * folio order, then it could be split based on the
> +		 * min_folio_order.
> +		 */
> +		if (mapping_min_folio_order(mapping)) {
> +			ret = -EAGAIN;
> +			goto out;
> +		}
> +
>   		gfp = current_gfp_context(mapping_gfp_mask(mapping) &
>   							GFP_RECLAIM_MASK);
>   
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes


