Return-Path: <linux-fsdevel+bounces-58148-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 176F6B2A10E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Aug 2025 14:04:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 416747A558C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Aug 2025 12:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93CB530E0C9;
	Mon, 18 Aug 2025 12:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="beztyR7s";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="WKulBeCw";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="beztyR7s";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="WKulBeCw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755AA2E22AF
	for <linux-fsdevel@vger.kernel.org>; Mon, 18 Aug 2025 12:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755518666; cv=none; b=Sm5XrZGdZjXh71APdHMlKYZatqaBLLLfk0mt3bDZB3BEoOgL58I7Y7IwvaIaegT6AJmaaHB6S9y7ScP7bUyljccboGE01s7l0UvhW3fhldDHCZg5hqrTmnIOvOY1stvOY+aq+gc/1/lO/rwIAF7fHaMLWcD5Dm+GfE4nZBhgocU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755518666; c=relaxed/simple;
	bh=EPng86Tw5ZUyAVF+u5J0jbyfM4/r8CdRJMTxfsILI70=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WhBv1T+Ll02xd56p3KzqK92pSNWdaSFCuVcKvfah8/RZaMpOKk+jFGgeISpZZ4rhgaOXbdWEQHSSI6YsAFD0wW/nPYAP7jgPKsbkvVyCmXw4i0wayt5vy6Bq8oJMlVAnvqduiWSoliRIeP9gZFQPHrrw5jVpYZvtdq/Spury4UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=beztyR7s; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=WKulBeCw; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=beztyR7s; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=WKulBeCw; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BF98C1F387;
	Mon, 18 Aug 2025 12:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1755518662; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rM7e3IdiwaCTEtvovImthX0CfEk5ySRhUVWdsnkbP+g=;
	b=beztyR7sBDGZyBm/JkHUTLHBQR+sgiZoXt7OYr0PnM1UUEnK31rzHY1r2xAsm1D7caS6ql
	BCWupQGv3dDbKphH+UrBJhD72p3oaaZDYTDs0AEqJ15vrq3QBR7Nodscx7R1o2A2UQEEvR
	x7Via08+M2V9275HyHH3RvC7iRlL+io=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1755518662;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rM7e3IdiwaCTEtvovImthX0CfEk5ySRhUVWdsnkbP+g=;
	b=WKulBeCw6firgU+sJgKSzp/MVu6/f/9T6Blez64p2SqXHBsQNIQitUMNZHlMVf5L4lqP/+
	pPxyaQde5yv9owDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1755518662; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rM7e3IdiwaCTEtvovImthX0CfEk5ySRhUVWdsnkbP+g=;
	b=beztyR7sBDGZyBm/JkHUTLHBQR+sgiZoXt7OYr0PnM1UUEnK31rzHY1r2xAsm1D7caS6ql
	BCWupQGv3dDbKphH+UrBJhD72p3oaaZDYTDs0AEqJ15vrq3QBR7Nodscx7R1o2A2UQEEvR
	x7Via08+M2V9275HyHH3RvC7iRlL+io=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1755518662;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rM7e3IdiwaCTEtvovImthX0CfEk5ySRhUVWdsnkbP+g=;
	b=WKulBeCw6firgU+sJgKSzp/MVu6/f/9T6Blez64p2SqXHBsQNIQitUMNZHlMVf5L4lqP/+
	pPxyaQde5yv9owDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 048BB13A55;
	Mon, 18 Aug 2025 12:04:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4nltAMYWo2iqbAAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 18 Aug 2025 12:04:22 +0000
Message-ID: <47277451-4220-436a-a2ef-b0a58d556c4f@suse.de>
Date: Mon, 18 Aug 2025 14:04:21 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/5] mm: add largest_zero_folio() routine
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
 <20250808121141.624469-5-kernel@pankajraghav.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250808121141.624469-5-kernel@pankajraghav.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -2.80

On 8/8/25 14:11, Pankaj Raghav (Samsung) wrote:
> From: Pankaj Raghav <p.raghav@samsung.com>
> 
> The callers of mm_get_huge_zero_folio() have access to a mm struct and
> the lifetime of the huge_zero_folio is tied to the lifetime of the mm
> struct.
> 
> largest_zero_folio() will give access to huge_zero_folio when
> PERSISTENT_HUGE_ZERO_FOLIO config option is enabled for callers that do not
> want to tie the lifetime to a mm struct. This is very useful for
> filesystem and block layers where the request completions can be async
> and there is no guarantee on the mm struct lifetime.
> 
> This function will return a ZERO_PAGE folio if PERSISTENT_HUGE_ZERO_FOLIO
> is disabled or if we failed to allocate a huge_zero_folio during early
> init.
> 
> Co-developed-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> ---
>   include/linux/huge_mm.h | 22 ++++++++++++++++++++++
>   1 file changed, 22 insertions(+)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

