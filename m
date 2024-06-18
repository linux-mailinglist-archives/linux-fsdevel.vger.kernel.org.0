Return-Path: <linux-fsdevel+bounces-21862-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51CD190C40F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jun 2024 08:52:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C38E1C23467
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jun 2024 06:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6618312CDB5;
	Tue, 18 Jun 2024 06:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="kT69tpqr";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="YlLpKnW/";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="kT69tpqr";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="YlLpKnW/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D90484FDA;
	Tue, 18 Jun 2024 06:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718693545; cv=none; b=dTVVdXQsFIJsbyJcvw6VDNJZa8j3EzL75VLkyYeuovbBT+Sv01e+H/dBGcsLE+Y82CxLMrmamU/lCjxR1MRf1uKe4mrR7n7bQJrDFKaB9BWXlUfWRZRjqSUVEhWGHusSPqv/gY4z3iQbdMGcH/Llwe5j0W4Fkjt+6U6YQgTAMa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718693545; c=relaxed/simple;
	bh=TBweA9ZhxwxO7EDdlp4lNOyVlNXpBz4h8rajTBRkJWc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p1JcHvlFjcFaNh+jWMPlNgTAusX5Pk5KrWSbfyKf1YLwij9/CFNP/MZqF6xwZMtNNns8owVVCT48uNH5zw8d8nQMFfiFjI3eMpHtP0wn9lxyWRNvl+FmNU+DpHQQdTohOM7Mke4Sy+a6fTLTx/TuqRFVLKScegJZ2Q0cBtQEUCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=kT69tpqr; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=YlLpKnW/; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=kT69tpqr; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=YlLpKnW/; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5D00922804;
	Tue, 18 Jun 2024 06:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718693542; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h1AskpgoSW43DiWneIGTKCBlhZ8DT6Ti9Evavgts+OM=;
	b=kT69tpqr1vGVDr4ZT2p63TsjqabTJg8QqBnYZut3t6ZucsHEt2eVmIy+e10TEug++pViF6
	Z7i2PClr+PZ+HoGy9xxALV2v6QmDWJ21ZE07oope5jlZoxCaXb8HCHz5KpvqGOEoS480PP
	3mGHfEANSIRq6LDZevEcPPV7X+L2vk0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718693542;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h1AskpgoSW43DiWneIGTKCBlhZ8DT6Ti9Evavgts+OM=;
	b=YlLpKnW/NOt8TxM29M6Rl1FEPHaTq0O86+tdi7XwnCCSwqDJ8k7Lw2xH07hdX/zVf1FCY/
	yVzWVOnF2kUWnvDw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=kT69tpqr;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="YlLpKnW/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718693542; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h1AskpgoSW43DiWneIGTKCBlhZ8DT6Ti9Evavgts+OM=;
	b=kT69tpqr1vGVDr4ZT2p63TsjqabTJg8QqBnYZut3t6ZucsHEt2eVmIy+e10TEug++pViF6
	Z7i2PClr+PZ+HoGy9xxALV2v6QmDWJ21ZE07oope5jlZoxCaXb8HCHz5KpvqGOEoS480PP
	3mGHfEANSIRq6LDZevEcPPV7X+L2vk0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718693542;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h1AskpgoSW43DiWneIGTKCBlhZ8DT6Ti9Evavgts+OM=;
	b=YlLpKnW/NOt8TxM29M6Rl1FEPHaTq0O86+tdi7XwnCCSwqDJ8k7Lw2xH07hdX/zVf1FCY/
	yVzWVOnF2kUWnvDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7743C1369F;
	Tue, 18 Jun 2024 06:52:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /HViG6UucWbnZQAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 18 Jun 2024 06:52:21 +0000
Message-ID: <3fad9f08-12cd-44c5-b79c-ba49f6587c45@suse.de>
Date: Tue, 18 Jun 2024 08:52:19 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 04/11] readahead: allocate folios with
 mapping_min_order in readahead
Content-Language: en-US
To: Matthew Wilcox <willy@infradead.org>,
 "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: david@fromorbit.com, djwong@kernel.org, chandan.babu@oracle.com,
 brauner@kernel.org, akpm@linux-foundation.org, mcgrof@kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 yang@os.amperecomputing.com, Zi Yan <zi.yan@sent.com>,
 linux-xfs@vger.kernel.org, p.raghav@samsung.com,
 linux-fsdevel@vger.kernel.org, hch@lst.de, gost.dev@samsung.com,
 cl@os.amperecomputing.com, john.g.garry@oracle.com
References: <20240607145902.1137853-1-kernel@pankajraghav.com>
 <20240607145902.1137853-5-kernel@pankajraghav.com>
 <ZmnuCQriFLdHKHkK@casper.infradead.org>
 <20240614092602.jc5qeoxy24xj6kl7@quentin>
 <ZnAs6lyMuHyk2wxI@casper.infradead.org>
 <20240617160420.ifwlqsm5yth4g7eo@quentin>
 <ZnBf5wXMOBWNl52x@casper.infradead.org>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <ZnBf5wXMOBWNl52x@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.50 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[sent.com];
	FREEMAIL_CC(0.00)[fromorbit.com,kernel.org,oracle.com,linux-foundation.org,kvack.org,vger.kernel.org,os.amperecomputing.com,sent.com,samsung.com,lst.de];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 5D00922804
X-Spam-Flag: NO
X-Spam-Score: -4.50
X-Spam-Level: 

On 6/17/24 18:10, Matthew Wilcox wrote:
> On Mon, Jun 17, 2024 at 04:04:20PM +0000, Pankaj Raghav (Samsung) wrote:
>> On Mon, Jun 17, 2024 at 01:32:42PM +0100, Matthew Wilcox wrote:
>> So the following can still be there from Hannes patch as we have a
>> stable reference:
>>
>>   		ractl->_workingset |= folio_test_workingset(folio);
>> -		ractl->_nr_pages++;
>> +		ractl->_nr_pages += folio_nr_pages(folio);
>> +		i += folio_nr_pages(folio);
>>   	}
> 
> We _can_, but we just allocated it, so we know what size it is already.
> I'm starting to feel that Hannes' patch should be combined with this
> one.

And we could even make it conditional; on recent devices allocating 64k
(or even 2M) worth of zero pages is not a big deal. And if you have 
machines where this is an issue maybe using large folios isn't the best
of ideas to start with.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


