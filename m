Return-Path: <linux-fsdevel+bounces-21863-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF6BC90C447
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jun 2024 09:28:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A752283395
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jun 2024 07:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16B8113C3F3;
	Tue, 18 Jun 2024 06:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="hmiQTA09";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="4H4/l+xW";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="GYfee203";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="6QDwu9Ll"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED31813AA5E;
	Tue, 18 Jun 2024 06:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718693821; cv=none; b=lsW5mBezLyZO439YOr/TFTlED4PetoXOny4IhqdT99816FPXWsNest0co9NVYLMFRbQ8wFRKw/UCJLG4lLWDOve5V7kjUO+EYrCX3AptgPxSWA40xFQtePFpxzDM8TPNdcn/twnQoiFpbKNX627neYKuDZSnK61TkDQQo5rtvps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718693821; c=relaxed/simple;
	bh=mCT+lRo19SYdPPmeF1jKr36h1RCMo1ewSc4P5xMJyec=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XB5q9GMb7unOsHKhn/5BXYLL23yHbZCR5ul/PBUxwoLmieui3upC22JT3RXDipFYL7HINqNf1o6OgNAHQVTAKaIG4417WW/DMBg2/5WEdlE4KyE47czQntdl92Nwlzt7N4YBOwE/riQ52pGXq+1r9QKJoJmUUBCs70yyz32O7DE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=hmiQTA09; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=4H4/l+xW; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=GYfee203; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=6QDwu9Ll; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E6B22219F9;
	Tue, 18 Jun 2024 06:56:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718693817; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+Y4IEo+0BCAfVtmTwp25/ON1j1FWc+fWfSBByJ2vQjU=;
	b=hmiQTA09n3cjaBFLpn/ZRRx3oGVIx7UdjssLQcVB20EKrWkusAxqjGg9IbGxjH//4fkFZs
	GH140FavkAqsJi7teviWWE2LN8KJ5kQIWP0XsXGctvz5q/Q8/3pobSs21yQpw/HnJMfWBU
	5RxyeWKFvhZf6tF9BwNyIt35Gu6pbVo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718693817;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+Y4IEo+0BCAfVtmTwp25/ON1j1FWc+fWfSBByJ2vQjU=;
	b=4H4/l+xW9WhOEXRF6mJYGd9jB8Gf31NpLoa0FQl22moEXIniPo+3Vlxm635xaO22YHuiI0
	jXAbRGOrVlNoJmAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718693816; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+Y4IEo+0BCAfVtmTwp25/ON1j1FWc+fWfSBByJ2vQjU=;
	b=GYfee203pZGXTDaQzZHRoNPY84ww+D+XWRXmQZwQ5vgpTuE351IY61rZY+qDhYR6uDARDX
	u55z7Ehmxlw3GZwBUD3H9kxvXTNcun5jPlsYyWOqYkrKIK4uCIDeSLFPrOcxAZUQF67e30
	zTGH9IztNSQspvWTRS1zIGl/injeQFI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718693816;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+Y4IEo+0BCAfVtmTwp25/ON1j1FWc+fWfSBByJ2vQjU=;
	b=6QDwu9LlFFj2jgPxC30eYLJ051WOxJxCkpB/Os2nsgaxHGwvasASmmL1LRk1gzlEcjeMQd
	JrUGPKxxpn4ypvAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DCB291369F;
	Tue, 18 Jun 2024 06:56:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id cKsXM7cvcWY/ZwAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 18 Jun 2024 06:56:55 +0000
Message-ID: <ac136000-1ae0-4cab-9858-abb68ff53b66@suse.de>
Date: Tue, 18 Jun 2024 08:56:53 +0200
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
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>,
 Matthew Wilcox <willy@infradead.org>
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
 <20240617163931.wvxgqdxdbwsbqtrx@quentin>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20240617163931.wvxgqdxdbwsbqtrx@quentin>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Score: -4.29
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.29 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[sent.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[fromorbit.com,kernel.org,oracle.com,linux-foundation.org,kvack.org,vger.kernel.org,os.amperecomputing.com,sent.com,samsung.com,lst.de];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email]

On 6/17/24 18:39, Pankaj Raghav (Samsung) wrote:
> On Mon, Jun 17, 2024 at 05:10:15PM +0100, Matthew Wilcox wrote:
>> On Mon, Jun 17, 2024 at 04:04:20PM +0000, Pankaj Raghav (Samsung) wrote:
>>> On Mon, Jun 17, 2024 at 01:32:42PM +0100, Matthew Wilcox wrote:
>>> So the following can still be there from Hannes patch as we have a
>>> stable reference:
>>>
>>>   		ractl->_workingset |= folio_test_workingset(folio);
>>> -		ractl->_nr_pages++;
>>> +		ractl->_nr_pages += folio_nr_pages(folio);
>>> +		i += folio_nr_pages(folio);
>>>   	}
>>
>> We _can_, but we just allocated it, so we know what size it is already.
> Yes.
> 
>> I'm starting to feel that Hannes' patch should be combined with this
>> one.
> 
> Fine by me. @Hannes, is that ok with you?

Sure. I was about to re-send my patchset anyway, so feel free to wrap it in.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


