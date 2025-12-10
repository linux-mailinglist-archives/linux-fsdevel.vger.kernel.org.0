Return-Path: <linux-fsdevel+bounces-71029-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F58BCB1838
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Dec 2025 01:38:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EEB8130072A6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Dec 2025 00:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0C4C1DC985;
	Wed, 10 Dec 2025 00:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="NSDvUYM1";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="rHHBaVK2";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="NSDvUYM1";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="rHHBaVK2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C2591A9FB4
	for <linux-fsdevel@vger.kernel.org>; Wed, 10 Dec 2025 00:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765327112; cv=none; b=TtuA83E3v9Yro6on5QZt+TIQ1cgiUNExTIjo6oxGvTMUNwyEmeXVJCYgUGU+g6RAs1nkeJCfDoWslYH+/Yk0Vlgtklar+So6oPjEwUDZNygrBi3MYjF6Tt0WCKXzQxaFT8IhjL9migIYzzoo8lm7XlIOMjEE5z92QpWIAAgadTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765327112; c=relaxed/simple;
	bh=c65hds9zAFnoDayj832FEWgPGyLkvJkfBVHl8GLQypI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RzzCPLvMMRnK3bdtTQK7CKW+a63La6g2YDnMLC2wMPGLLhcugzCWlLbiYK+LK0j4bKLkDp9M24ov8uF3LR4aW2wT0Tm9nTC083WuXoPcgGWSudOMvg/NpsuVfllZd71BPoq1KMdQKDEhQGs+uCv/jUll8whLYJ04fla7HDGbsac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=NSDvUYM1; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=rHHBaVK2; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=NSDvUYM1; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=rHHBaVK2; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 974F7338B4;
	Wed, 10 Dec 2025 00:38:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1765327108; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sZNiUJuG3TeKZsNDlVrI19mlrKWSweIT9h/omtBTHB8=;
	b=NSDvUYM1HDtqM6oPFiwMjjuKWt4EqZKJymRYKTh7+EzbnTgM8NgnBjhnDhEjH2fAkho4i5
	Tt/7gFFhQ50Qp0DqvIcM0fGxIgnBLATl2OJmaTMwtq9K8BsLPKR6Y4f479SGw9c0fn8kBQ
	YFRJzly+foIx/GASnxveaEDorM0zhZk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1765327108;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sZNiUJuG3TeKZsNDlVrI19mlrKWSweIT9h/omtBTHB8=;
	b=rHHBaVK2YDKlGAiXwsxjk4Zl6UntY3f/wo8LTvZ6U52z2ltaHfrD/w/u4Xc6paFySFxx55
	e1GPfKAztuHd1UAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1765327108; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sZNiUJuG3TeKZsNDlVrI19mlrKWSweIT9h/omtBTHB8=;
	b=NSDvUYM1HDtqM6oPFiwMjjuKWt4EqZKJymRYKTh7+EzbnTgM8NgnBjhnDhEjH2fAkho4i5
	Tt/7gFFhQ50Qp0DqvIcM0fGxIgnBLATl2OJmaTMwtq9K8BsLPKR6Y4f479SGw9c0fn8kBQ
	YFRJzly+foIx/GASnxveaEDorM0zhZk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1765327108;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sZNiUJuG3TeKZsNDlVrI19mlrKWSweIT9h/omtBTHB8=;
	b=rHHBaVK2YDKlGAiXwsxjk4Zl6UntY3f/wo8LTvZ6U52z2ltaHfrD/w/u4Xc6paFySFxx55
	e1GPfKAztuHd1UAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C59DF3EA63;
	Wed, 10 Dec 2025 00:38:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +gEjEPjAOGl2dwAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 10 Dec 2025 00:38:16 +0000
Message-ID: <b23da846-ff6e-4b73-9691-beb14ceb0fa5@suse.de>
Date: Wed, 10 Dec 2025 01:38:09 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 1/3] filemap: set max order to be min order if THP is
 disabled
To: Pankaj Raghav <kernel@pankajraghav.com>,
 Pankaj Raghav <p.raghav@samsung.com>, Suren Baghdasaryan
 <surenb@google.com>, Mike Rapoport <rppt@kernel.org>,
 David Hildenbrand <david@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Michal Hocko <mhocko@suse.com>, Lance Yang <lance.yang@linux.dev>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Nico Pache <npache@redhat.com>, Zi Yan <ziy@nvidia.com>,
 Vlastimil Babka <vbabka@suse.cz>, "Liam R . Howlett"
 <Liam.Howlett@oracle.com>, Jens Axboe <axboe@kernel.dk>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 mcgrof@kernel.org, gost.dev@samsung.com, tytso@mit.edu
References: <20251206030858.1418814-1-p.raghav@samsung.com>
 <20251206030858.1418814-2-p.raghav@samsung.com>
 <d395cf62-2066-4965-87e6-823a7bbde775@suse.de>
 <3ced3736-81e8-4bc3-b5a3-50ac4af3536c@pankajraghav.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <3ced3736-81e8-4bc3-b5a3-50ac4af3536c@pankajraghav.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -4.27
X-Spam-Level: 
X-Spamd-Result: default: False [-4.27 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.17)[-0.856];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid]

On 12/9/25 17:33, Pankaj Raghav wrote:
> On 12/9/25 13:15, Hannes Reinecke wrote:
>> On 12/6/25 04:08, Pankaj Raghav wrote:
>>> Large folios in the page cache depend on the splitting infrastructure from
>>> THP. To remove the dependency between large folios and
>>> CONFIG_TRANSPARENT_HUGEPAGE, set the min order == max order if THP is
>>> disabled. This will make sure the splitting code will not be required
>>> when THP is disabled, therefore, removing the dependency between large
>>> folios and THP.
>>>
>> The description is actually misleading.
>> It's not that you remove the dependency from THP for large folios
>> _in general_ (the CONFIG_THP is retained in this patch).
>> Rather you remove the dependency for large folios _for the block layer_.
>> And that should be make explicit in the description, otherwise the
>> description and the patch doesn't match.
>>
> 
> Hmm, that is not what I am doing. This has nothing to do with the block layer directly.
> I mentioned this in the cover letter but I can reiterate it again.
> 
> Large folios depended on THP infrastructure when it was introduced. When we added added LBS support
> to the block layer, we introduced an indirect dependency on CONFIG_THP. When we disabled config_THP
> and had a block device logical block size > page size, we ran into a panic.
> 
> That was fixed here[1].
> 
Yes, and no. That patch limited the maximum blocksize without THP to 4k,
so effectively disabling LBS.

> If this patch is upstreamed, then we can disable THP but still have a LBS drive attached without any
> issues.
> 
But this is what I meant. We do _not_ disable the dependency on THP for
LBS, we just remove checks for the config option itself in the block 
layer code. The actual dependency on THP will remain as LBS will only
be supported if THP is enabled.

> Baolin added another CONFIG_THP block in ext4 [2]. With this support, we don't need to sprinkle THP
> where file backed large folios are used.
> 
> Happy to discuss this in LPC (if you are attending)!
> 
The very first presentation on the first day in the CXL track. Yes :-)
Let's discuss there; would love to figure out if we cannot remove the
actual dependency on THP, too.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

