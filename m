Return-Path: <linux-fsdevel+bounces-58149-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 28AA8B2A146
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Aug 2025 14:16:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6187918A622C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Aug 2025 12:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5704330EF6C;
	Mon, 18 Aug 2025 12:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="MdHLM0qg";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="IpR3VIGE";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="MdHLM0qg";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="IpR3VIGE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EFF6326D60
	for <linux-fsdevel@vger.kernel.org>; Mon, 18 Aug 2025 12:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755518758; cv=none; b=RkHHizrm14rsTY13nna3JXTNz4ekXfHtA9yyUvvIhfRSib3BagPn6JWqS8ajfgxmdK0m3OOWLcFUm36iae16IO4Pyen0Boh36rYHdERe6Q52+WHQu5EAkb8awrXkJrrB4WqwsNFCQbLMHOrGQdVgigQYrcHmvL92I4UnmnEoXh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755518758; c=relaxed/simple;
	bh=agMSR/n+TYHGFoLcSt3sVCPShmBk3mrjzk0qOxZI+WU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z2g6DNhPq2eo5MddC7iQgzdYkbC5kuTCS7aJE0FnG0lzEmrS6A2kNuEp4J0VifoWKblozT8E1u96EbpH8nt3lcD0MbLET3X/aZLlV39kesuwEaD25btHDMO0n1w6pDDac6Bga8xeeyJgUJ7x8OAr7cjQIHDKq9I/d8voUFErqyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=MdHLM0qg; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=IpR3VIGE; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=MdHLM0qg; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=IpR3VIGE; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 902D81F387;
	Mon, 18 Aug 2025 12:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1755518755; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qu9v+fr2mK8VQbSW13ClOvrZt5hxDSdnoK2mLEHPovM=;
	b=MdHLM0qgaeR4B3I0+GdsZeZl+SGwY9C79O4Y7QTjaxvkXfLsN6stdQyNVySwjDUOhfPNYK
	B7V4HyC4ovjVZgs1xBau58s7tIAwZCwpvtF+jNhdmyIaOochhH4IKj38rOuVzGYDzVn39t
	QRu2NZCktn76xjw49q3NRlHI1kzKtko=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1755518755;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qu9v+fr2mK8VQbSW13ClOvrZt5hxDSdnoK2mLEHPovM=;
	b=IpR3VIGEpVAirqsgobjv2gkTstXg3/hm2n1koZnwMhtR0of+PtO7xb0I+WwMRoBoAgyaKW
	Q7I+4KL4sFBiGFCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1755518755; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qu9v+fr2mK8VQbSW13ClOvrZt5hxDSdnoK2mLEHPovM=;
	b=MdHLM0qgaeR4B3I0+GdsZeZl+SGwY9C79O4Y7QTjaxvkXfLsN6stdQyNVySwjDUOhfPNYK
	B7V4HyC4ovjVZgs1xBau58s7tIAwZCwpvtF+jNhdmyIaOochhH4IKj38rOuVzGYDzVn39t
	QRu2NZCktn76xjw49q3NRlHI1kzKtko=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1755518755;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qu9v+fr2mK8VQbSW13ClOvrZt5hxDSdnoK2mLEHPovM=;
	b=IpR3VIGEpVAirqsgobjv2gkTstXg3/hm2n1koZnwMhtR0of+PtO7xb0I+WwMRoBoAgyaKW
	Q7I+4KL4sFBiGFCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2D34113A55;
	Mon, 18 Aug 2025 12:05:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id dQPbNiAXo2gnbQAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 18 Aug 2025 12:05:52 +0000
Message-ID: <fde3cd06-d660-4b38-940b-4d089ee2c4c4@suse.de>
Date: Mon, 18 Aug 2025 14:05:49 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] block: use largest_zero_folio in
 __blkdev_issue_zero_pages()
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>,
 Suren Baghdasaryan <surenb@google.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Vlastimil Babka
 <vbabka@suse.cz>, Zi Yan <ziy@nvidia.com>, Mike Rapoport <rppt@kernel.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, Michal Hocko <mhocko@suse.com>,
 David Hildenbrand <david@redhat.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Thomas Gleixner <tglx@linutronix.de>, Nico Pache <npache@redhat.com>,
 Dev Jain <dev.jain@arm.com>, "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Jens Axboe <axboe@kernel.dk>
Cc: linux-kernel@vger.kernel.org, willy@infradead.org, linux-mm@kvack.org,
 Ritesh Harjani <ritesh.list@gmail.com>, linux-block@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, "Darrick J . Wong" <djwong@kernel.org>,
 mcgrof@kernel.org, gost.dev@samsung.com, hch@lst.de,
 Pankaj Raghav <p.raghav@samsung.com>
References: <20250808121141.624469-1-kernel@pankajraghav.com>
 <20250808121141.624469-6-kernel@pankajraghav.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250808121141.624469-6-kernel@pankajraghav.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[28];
	TAGGED_RCPT(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RL5eeoi1u38ap3bcc41xiargsg)];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,infradead.org,kvack.org,gmail.com,kernel.org,samsung.com,lst.de];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -2.80

On 8/8/25 14:11, Pankaj Raghav (Samsung) wrote:
> From: Pankaj Raghav <p.raghav@samsung.com>
> 
> Use largest_zero_folio() in __blkdev_issue_zero_pages().
> On systems with CONFIG_PERSISTENT_HUGE_ZERO_FOLIO enabled, we will end up
> sending larger bvecs instead of multiple small ones.
> 
> Noticed a 4% increase in performance on a commercial NVMe SSD which does
> not support OP_WRITE_ZEROES. The device's MDTS was 128K. The performance
> gains might be bigger if the device supports bigger MDTS.
> 
> Acked-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> ---
>   block/blk-lib.c | 15 ++++++++-------
>   1 file changed, 8 insertions(+), 7 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

