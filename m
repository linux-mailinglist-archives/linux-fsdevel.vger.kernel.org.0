Return-Path: <linux-fsdevel+bounces-58124-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69804B299D9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Aug 2025 08:39:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 412D820598F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Aug 2025 06:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07C0B1DF982;
	Mon, 18 Aug 2025 06:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="udasneBH";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="I5SpOzL4";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="udasneBH";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="I5SpOzL4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC892275AF4
	for <linux-fsdevel@vger.kernel.org>; Mon, 18 Aug 2025 06:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755499164; cv=none; b=aT8YP2oIERwqH+hbLZJpnphtW/EbmihhF/PFakgrvTdQYV/Ti2xVU+Kw0upbpQyORy6YqJcHbkDT0AAZ57xevbfmzLq+aD+U1DMwUWXsZ1/zibVzZ+moUQF+LmoL0Miaoh1c25JI5ERhtXjB5lTD1bMgxnL5uY6YPTCPqhJ1HHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755499164; c=relaxed/simple;
	bh=LxEfPQaVDWexnKvTWGeNwRcx32X/IRvQesOmeFQvrdA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hbrn435jqgx9hz7ZR+H/n4afT0L+ADVZZPCefsODV2mTiZewyWuDp7GlPN+0Wpr0roMwYxQ++m/fa4Vuvy7t/y/9dT7MZcTDg+3C0bJzjrds862GH/EV5NCrBhdUAL0TjkLXnR3XGKibVZzd0mC0xzpnl97UXjtCbuasUs75IY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=udasneBH; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=I5SpOzL4; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=udasneBH; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=I5SpOzL4; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2D1511F387;
	Mon, 18 Aug 2025 06:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1755499161; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2GdNbUyDP+DT1aNEcPmDrED6jZJOeFHolY9S590GiyI=;
	b=udasneBHThsYZgO61XJ29x+6AH8Nf3gzF0OZ+dhXWC+vrDlhV411xqfXHbnBhjZ0VVdtEs
	8bEy6g7xoJOAsEhft4dKEMzncAINM5XIOQaogy6oHEPgNJIVOpSjZRO1TRwnCLRp1NZ9OL
	xU5lmcHRGHnVLEMTFtOv6bt2+H+8dKk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1755499161;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2GdNbUyDP+DT1aNEcPmDrED6jZJOeFHolY9S590GiyI=;
	b=I5SpOzL4fmgjUAbWRShMIpwnchYuXH92LNZHpLSs6+KAbwvbWTmkfNfbmhI2m+bPgU7cAw
	NRzp6oBE4xCOyfCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1755499161; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2GdNbUyDP+DT1aNEcPmDrED6jZJOeFHolY9S590GiyI=;
	b=udasneBHThsYZgO61XJ29x+6AH8Nf3gzF0OZ+dhXWC+vrDlhV411xqfXHbnBhjZ0VVdtEs
	8bEy6g7xoJOAsEhft4dKEMzncAINM5XIOQaogy6oHEPgNJIVOpSjZRO1TRwnCLRp1NZ9OL
	xU5lmcHRGHnVLEMTFtOv6bt2+H+8dKk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1755499161;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2GdNbUyDP+DT1aNEcPmDrED6jZJOeFHolY9S590GiyI=;
	b=I5SpOzL4fmgjUAbWRShMIpwnchYuXH92LNZHpLSs6+KAbwvbWTmkfNfbmhI2m+bPgU7cAw
	NRzp6oBE4xCOyfCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 30E5E13686;
	Mon, 18 Aug 2025 06:39:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id PbYRCJbKomhIBAAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 18 Aug 2025 06:39:18 +0000
Message-ID: <d7586866-5a41-45c8-88c5-ab6416d27123@suse.de>
Date: Mon, 18 Aug 2025 08:39:17 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] mm: rename MMF_HUGE_ZERO_PAGE to
 MMF_HUGE_ZERO_FOLIO
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
 <20250808121141.624469-3-kernel@pankajraghav.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250808121141.624469-3-kernel@pankajraghav.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWELVE(0.00)[28];
	TO_DN_SOME(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	R_RATELIMIT(0.00)[to_ip_from(RL5eeoi1u38ap3bcc41xiargsg)];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,infradead.org,kvack.org,gmail.com,kernel.org,samsung.com,lst.de];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	URIBL_BLOCKED(0.00)[suse.de:email,suse.de:mid];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[samsung.com:email,imap1.dmz-prg2.suse.org:helo,nvidia.com:email,suse.de:email,suse.de:mid,oracle.com:email]
X-Spam-Flag: NO
X-Spam-Score: -2.80

On 8/8/25 14:11, Pankaj Raghav (Samsung) wrote:
> From: Pankaj Raghav <p.raghav@samsung.com>
> 
> As all the helper functions has been renamed from *_page to *_folio,
> rename the MM flag from MMF_HUGE_ZERO_PAGE to MMF_HUGE_ZERO_FOLIO.
> 
> No functional changes.
> 
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Reviewed-by: Zi Yan <ziy@nvidia.com>
> Suggested-by: David Hildenbrand <david@redhat.com>
> Acked-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> ---
>   include/linux/mm_types.h | 2 +-
>   mm/huge_memory.c         | 6 +++---
>   2 files changed, 4 insertions(+), 4 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

