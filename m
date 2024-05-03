Return-Path: <linux-fsdevel+bounces-18650-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8117A8BAF0B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2024 16:32:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3705E28451D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2024 14:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FF0C17C64;
	Fri,  3 May 2024 14:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Z5HSLYLM";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="XJtk3Jgv";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Z5HSLYLM";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="XJtk3Jgv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EECB6FB8;
	Fri,  3 May 2024 14:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714746761; cv=none; b=F7Vrns5CPow5a/pyrFkLYb3s1hHSqKRsJu0SKFiwqb33jpQ/e2AcCt+SzpUIaOuaahUxoOODBQBTYCfX6WJTKphOj/c/sHZpSKsLCoYvhohCjozIBABW7DYKelTCAC+Rs4NxA1vqe1mR8PrYaYiPpbDqSMG8wwbWQrioVfolaUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714746761; c=relaxed/simple;
	bh=WGy5eDz8FfbuYhVL3Kmrt4nRsa3yhfmLVHYQkbwsrCk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gaI4mjqU417Sv8eDID+pAd2Jx3Xrk4dgm5xDxPoweiOTlsZkH+sf+ObsV5zJ5wcEwmrzrae1t81ZiRvhMfDDLn98vmD1EVxA7ZBlkopKqUyIeFvvM2j6RP77YfF0SFnOmb2PtkuTegSm4VH7LFVcCrFakj0bjCoQZT7y7WbMxwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Z5HSLYLM; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=XJtk3Jgv; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Z5HSLYLM; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=XJtk3Jgv; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2B87F33B31;
	Fri,  3 May 2024 14:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1714746757; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BHlVZ1sU7qEW1KllZBA7cvducPvlkRE8JqumePYarAA=;
	b=Z5HSLYLMaU1EOzzvffEscP1GFJBAC0FhsHKDu09yMdObMgiy0PtIYbG/7HvQk8oG1j0hDt
	vjEyYPkTx/56uXOcO8nbUhzh+0DbpnI9J0h9EVrOF7MXmnpYUiwmdNXiAwYRYBErY8SdiQ
	yBoXQzTmeTuSXJ+DGvLAqViFUCcQHYM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1714746757;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BHlVZ1sU7qEW1KllZBA7cvducPvlkRE8JqumePYarAA=;
	b=XJtk3JgvXliqyQz5Yn7QDlmZKLzFlJj2dbgVb3Gr6LZwCd5lVfq20Zqn+EGSGPYlXWwgfc
	QKVUqk8dnQQAIMAg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Z5HSLYLM;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=XJtk3Jgv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1714746757; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BHlVZ1sU7qEW1KllZBA7cvducPvlkRE8JqumePYarAA=;
	b=Z5HSLYLMaU1EOzzvffEscP1GFJBAC0FhsHKDu09yMdObMgiy0PtIYbG/7HvQk8oG1j0hDt
	vjEyYPkTx/56uXOcO8nbUhzh+0DbpnI9J0h9EVrOF7MXmnpYUiwmdNXiAwYRYBErY8SdiQ
	yBoXQzTmeTuSXJ+DGvLAqViFUCcQHYM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1714746757;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BHlVZ1sU7qEW1KllZBA7cvducPvlkRE8JqumePYarAA=;
	b=XJtk3JgvXliqyQz5Yn7QDlmZKLzFlJj2dbgVb3Gr6LZwCd5lVfq20Zqn+EGSGPYlXWwgfc
	QKVUqk8dnQQAIMAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8EE5213991;
	Fri,  3 May 2024 14:32:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2+PwIIT1NGaDGgAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 03 May 2024 14:32:36 +0000
Message-ID: <51642048-ddb1-4f21-96ad-c6970f9c71dc@suse.de>
Date: Fri, 3 May 2024 16:32:16 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 04/11] readahead: allocate folios with
 mapping_min_order in readahead
To: Luis Chamberlain <mcgrof@kernel.org>, akpm@linux-foundation.org,
 willy@infradead.org, djwong@kernel.org, brauner@kernel.org,
 david@fromorbit.com, chandan.babu@oracle.com
Cc: ritesh.list@gmail.com, john.g.garry@oracle.com, ziy@nvidia.com,
 linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
 linux-mm@kvack.org, linux-block@vger.kernel.org, gost.dev@samsung.com,
 p.raghav@samsung.com, kernel@pankajraghav.com
References: <20240503095353.3798063-1-mcgrof@kernel.org>
 <20240503095353.3798063-5-mcgrof@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20240503095353.3798063-5-mcgrof@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -5.00
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 2B87F33B31
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-5.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWELVE(0.00)[17];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,oracle.com,nvidia.com,vger.kernel.org,kvack.org,samsung.com,pankajraghav.com];
	RCVD_TLS_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TAGGED_RCPT(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:email]

On 5/3/24 11:53, Luis Chamberlain wrote:
> From: Pankaj Raghav <p.raghav@samsung.com>
> 
> page_cache_ra_unbounded() was allocating single pages (0 order folios)
> if there was no folio found in an index. Allocate mapping_min_order folios
> as we need to guarantee the minimum order if it is set.
> When read_pages() is triggered and if a page is already present, check
> for truncation and move the ractl->_index by mapping_min_nrpages if that
> folio was truncated. This is done to ensure we keep the alignment
> requirement while adding a folio to the page cache.
> 
> page_cache_ra_order() tries to allocate folio to the page cache with a
> higher order if the index aligns with that order. Modify it so that the
> order does not go below the mapping_min_order requirement of the page
> cache. This function will do the right thing even if the new_order passed
> is less than the mapping_min_order.
> When adding new folios to the page cache we must also ensure the index
> used is aligned to the mapping_min_order as the page cache requires the
> index to be aligned to the order of the folio.
> 
> readahead_expand() is called from readahead aops to extend the range of
> the readahead so this function can assume ractl->_index to be aligned with
> min_order.
> 
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> ---
>   mm/readahead.c | 85 +++++++++++++++++++++++++++++++++++++++++---------
>   1 file changed, 71 insertions(+), 14 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Ivo Totev, Andrew McDonald,
Werner Knoblich


