Return-Path: <linux-fsdevel+bounces-41164-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90AB3A2BC04
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 08:07:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 138893A49E3
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 07:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F2651917D8;
	Fri,  7 Feb 2025 07:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="0wD4kP13";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="i+TUYHyh";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="0wD4kP13";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="i+TUYHyh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038AF2561D;
	Fri,  7 Feb 2025 07:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738912018; cv=none; b=d2XfzcApph5hVhPbn+g6vnZXItKjbY+NRdrkcsX26Hs/r3gTJODJXPb1SH80dFzuiZBnqXqqRkzAOHz9QmnNBu1IXW5x/P5m0mdeTfY413lgOY3eMamFLYYrVCO3zUuaZiNWqclRQvlL0zOuR0p1Jw/Sz7h+VeThjsUTyLQ4hrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738912018; c=relaxed/simple;
	bh=e4HQRjj23BUztMjo+E+fHDKHlzBwIf3YOJyzxnPh8v4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c+BIoxbW/OCmPsHY3H5Mas+DSE8Bgkf44T7sgAuUL9nAR8IcGczuR/Erayp0wyWqyAWtHSbttqxeQ8sbY9ZEafNhlbhXpebM8kWrUvSI21lAO5eFueBlz1lJ7teHFOtPe0DKOW6mRcx/ymis52EEpb/4pICtgZ1CnQR6lyfIi04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=0wD4kP13; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=i+TUYHyh; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=0wD4kP13; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=i+TUYHyh; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 093BC21161;
	Fri,  7 Feb 2025 07:06:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738912015; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OeAq5WgyNpyXwAYWhu2LEmnw14pRolj6vTmiCshrrJc=;
	b=0wD4kP13iqwgArOJELuH1Ygp0UJE6Wd6D7uvETz+xk8HvGU+DjZwvQxZQT5IOswgU8UcNB
	Rey1Ip5OyUaYDEUNEmLIlHjwj0frXoRqGbTXuYoOvTOvhZAuV9WRhXd1AUdFc2Rofn92d5
	FCe7+YQgJI5ZWnoMnWz6whGAd+ZzHFo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738912015;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OeAq5WgyNpyXwAYWhu2LEmnw14pRolj6vTmiCshrrJc=;
	b=i+TUYHyhDlYBLPTohEUtbfKzC1eQGJPcA3lRwwsfgCvs/Aw3k4kArXPZchvKzCOK2MoEAB
	wHjrqeXgwwZy04AQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=0wD4kP13;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=i+TUYHyh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738912015; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OeAq5WgyNpyXwAYWhu2LEmnw14pRolj6vTmiCshrrJc=;
	b=0wD4kP13iqwgArOJELuH1Ygp0UJE6Wd6D7uvETz+xk8HvGU+DjZwvQxZQT5IOswgU8UcNB
	Rey1Ip5OyUaYDEUNEmLIlHjwj0frXoRqGbTXuYoOvTOvhZAuV9WRhXd1AUdFc2Rofn92d5
	FCe7+YQgJI5ZWnoMnWz6whGAd+ZzHFo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738912015;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OeAq5WgyNpyXwAYWhu2LEmnw14pRolj6vTmiCshrrJc=;
	b=i+TUYHyhDlYBLPTohEUtbfKzC1eQGJPcA3lRwwsfgCvs/Aw3k4kArXPZchvKzCOK2MoEAB
	wHjrqeXgwwZy04AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6F7AE13694;
	Fri,  7 Feb 2025 07:06:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SAMhGQ6xpWf+MgAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 07 Feb 2025 07:06:54 +0000
Message-ID: <ebd83e59-6df1-425b-bf61-193211c2c058@suse.de>
Date: Fri, 7 Feb 2025 08:06:54 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/8] fs/buffer: simplify block_read_full_folio() with
 bh_offset()
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: Matthew Wilcox <willy@infradead.org>, dave@stgolabs.net,
 david@fromorbit.com, djwong@kernel.org, kbusch@kernel.org,
 john.g.garry@oracle.com, hch@lst.de, ritesh.list@gmail.com,
 linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
 linux-mm@kvack.org, linux-block@vger.kernel.org, gost.dev@samsung.com,
 p.raghav@samsung.com, da.gomez@samsung.com, kernel@pankajraghav.com
References: <20250204231209.429356-1-mcgrof@kernel.org>
 <20250204231209.429356-2-mcgrof@kernel.org>
 <1b211dd3-a45d-4a2e-aa2a-e0d3e302d4ca@suse.de>
 <Z6PgGccx6Uz-Jum6@casper.infradead.org>
 <13223185-5c5e-4c52-b7ab-00155b5ebd86@suse.de>
 <Z6Txvdewl2m8NRRo@bombadil.infradead.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <Z6Txvdewl2m8NRRo@bombadil.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 093BC21161
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[infradead.org,stgolabs.net,fromorbit.com,kernel.org,oracle.com,lst.de,gmail.com,vger.kernel.org,kvack.org,samsung.com,pankajraghav.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On 2/6/25 18:30, Luis Chamberlain wrote:
> On Thu, Feb 06, 2025 at 08:17:32AM +0100, Hannes Reinecke wrote:
>> On 2/5/25 23:03, Matthew Wilcox wrote:
>>> On Wed, Feb 05, 2025 at 05:18:20PM +0100, Hannes Reinecke wrote:
>>>> One wonders: shouldn't we use plugging here to make I/O more efficient?
>>>
>>> Should we plug at a higher level?
>>>
>>> Opposite question: What if getblk() needs to do a read (ie ext2 indirect
>>> block)?
>>
>> Ah, that. Yes, plugging on higher level would be a good idea.
>> (And can we check for nested plugs? _Should_ we check for nested plugs?)
> 
> I think given the discussion less is more for now, and if we really want
> this we can add it later. Thoughts?
> 
Yeah, go for it.

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

