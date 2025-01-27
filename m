Return-Path: <linux-fsdevel+bounces-40139-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EC263A1D1CA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Jan 2025 08:52:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C2547A2CEB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Jan 2025 07:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC3CA1FC7F3;
	Mon, 27 Jan 2025 07:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="yosWjN2y";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="pWQ1oK4R";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="yosWjN2y";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="pWQ1oK4R"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE7025A65E;
	Mon, 27 Jan 2025 07:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737964333; cv=none; b=H1OxkqGIYfsKYbRjOFb0jCjsxleWMqlUKyfV3G8lNQ2+rBuDobSG175Lc6AT0SsSFKc0bA5uwDhEu/EoDFF4SXe9gxBp78n2bCs7rICwFrqsgVY01GxmwVZkBjCPsb+T7D6pvhFnPLV4Koz2ApNVLpNNEV9e8V1su+KywH5vm2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737964333; c=relaxed/simple;
	bh=eX8UEoc4fFngshTtGs9aGW8k3YdKYCh1ppa0H21yKDk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NJmX4pgK4xL/n/HPFod3eG8+bo1FCG3BpmnJgNSqLu45Ggg4NQ4R637VrC7wY5uktmEb4hKBSgmUGaogMlTl0TqHs3z9ev5SvzAijXqUXW6aA0qbRUr/foWfrNgeEtUrZ5LKP8VLv4Fx7L0/V48dtDu02+NRc0lxznQ8MV3dvEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=yosWjN2y; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=pWQ1oK4R; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=yosWjN2y; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=pWQ1oK4R; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7BBFB21114;
	Mon, 27 Jan 2025 07:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1737964328; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HOVLpoaZTDnha9bY1uEyVw6fbwPqCer/OmqkPcifpwU=;
	b=yosWjN2yiUpKSokwv6E86cYpWLnbfQn9y/k/zaf0+ve0aGaQpOcXJ68hH7LlhzlwlmZTU6
	lgUIj0LB9JjskMX6ZN0ULJcH5mTI0wQFIt8hdsD9nPbo7r9YjXysS5UOomF5ieHFhvjNdn
	mQlCgoMkWpNskcdf7e7ghXj5IQXLk0A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1737964328;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HOVLpoaZTDnha9bY1uEyVw6fbwPqCer/OmqkPcifpwU=;
	b=pWQ1oK4RzhvLPISTPnIcdtlRoLklOfNkpMuFhnWcZ/yTlxOenlhj6hkCcb8yHQbbHs9QeR
	RCiG+wvfe980twCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1737964328; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HOVLpoaZTDnha9bY1uEyVw6fbwPqCer/OmqkPcifpwU=;
	b=yosWjN2yiUpKSokwv6E86cYpWLnbfQn9y/k/zaf0+ve0aGaQpOcXJ68hH7LlhzlwlmZTU6
	lgUIj0LB9JjskMX6ZN0ULJcH5mTI0wQFIt8hdsD9nPbo7r9YjXysS5UOomF5ieHFhvjNdn
	mQlCgoMkWpNskcdf7e7ghXj5IQXLk0A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1737964328;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HOVLpoaZTDnha9bY1uEyVw6fbwPqCer/OmqkPcifpwU=;
	b=pWQ1oK4RzhvLPISTPnIcdtlRoLklOfNkpMuFhnWcZ/yTlxOenlhj6hkCcb8yHQbbHs9QeR
	RCiG+wvfe980twCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 33E69137C0;
	Mon, 27 Jan 2025 07:52:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id KX7KCig7l2faMQAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 27 Jan 2025 07:52:08 +0000
Message-ID: <8a7b1eb9-6b9b-4883-9813-401cabf669da@suse.de>
Date: Mon, 27 Jan 2025 08:52:07 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: Skip the folio lock if the folio is already dirty
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Jens Axboe <axboe@kernel.dk>
Cc: linux-mm@kvack.org, linux-block@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, Andres Freund <andres@anarazel.de>
References: <20250124224832.322771-1-willy@infradead.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250124224832.322771-1-willy@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_FIVE(0.00)[6]
X-Spam-Flag: NO
X-Spam-Level: 

On 1/24/25 23:48, Matthew Wilcox (Oracle) wrote:
> Postgres sees significant contention on the hashed folio waitqueue lock
> when performing direct I/O to 1GB hugetlb pages.  This is because we
> mark the destination pages as dirty, and the locks end up 512x more
> contended with 1GB pages than with 2MB pages.
> 
> We can skip the locking if the folio is already marked as dirty.
> The writeback path clears the dirty flag before commencing writeback,
> if we see the dirty flag set, the data written to the folio will be
> written back.
> 
> In one test, throughput increased from 18GB/s to 20GB/s and moved the
> bottleneck elsewhere.
> 
> Reported-by: Andres Freund <andres@anarazel.de>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>   block/bio.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/block/bio.c b/block/bio.c
> index f0c416e5931d..e8d18a0fecb5 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -1404,6 +1404,8 @@ void bio_set_pages_dirty(struct bio *bio)
>   	struct folio_iter fi;
>   
>   	bio_for_each_folio_all(fi, bio) {
> +		if (folio_test_dirty(folio))
> +			continue;
>   		folio_lock(fi.folio);
>   		folio_mark_dirty(fi.folio);
>   		folio_unlock(fi.folio);

The same reasoning can probably applied to __bio_release_pages().

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

