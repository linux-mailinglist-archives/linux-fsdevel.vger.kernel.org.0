Return-Path: <linux-fsdevel+bounces-42003-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 923A6A3A0BC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2025 16:03:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E8C51696EB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2025 15:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15D0726A0D7;
	Tue, 18 Feb 2025 15:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="TH/vyPra";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Nldm3Xuo";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="TH/vyPra";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Nldm3Xuo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7EA826A0F0
	for <linux-fsdevel@vger.kernel.org>; Tue, 18 Feb 2025 15:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739890968; cv=none; b=uab3fsnrq2DE4bJ6saOYvzbphunpHiVKVUvRz9K4OJEUsltTkmvI1Cf2IO42EDWiFkSLpnU90rpio8TbcsKD8GBlXtaUZPtKQDcMtpwJL5LVSYP+DA8qqyxQ3nYV4KmQf6kT2cdz5J0lKkshoMugC5y/6VE45KxOHKSLttthcL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739890968; c=relaxed/simple;
	bh=cqL2LF+ND/ZdbWHONpwi2puXTW1mKlzIebK30VWdNYs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZYiOgEOdihlx7f22G0pta3WegyV7o4Wr2VtMS/Wyp9PP6xPcjRskJXnBvtpRzjSJVa0U1iUcK/EyY1Fp+htaWAVmwBj3Qa/Dsh4UZTnvzfA9Adh7wiUYhbwZSfqel8OMc3dw/J5DtsOd2YWGkQTtF4tAl2a7CPIHxp3JSLTpUQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=fail smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=TH/vyPra; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Nldm3Xuo; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=TH/vyPra; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Nldm3Xuo; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1F17C2116B;
	Tue, 18 Feb 2025 15:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1739890965; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q7AVrF9ImZMiQtbhCkV0xB4O3QN1TooCyYbbebiN5RI=;
	b=TH/vyPrak8PCZ0vEaafDeUCYqouDLsldQujzwmjRx3pncH4F+TfCo0qIdTUz/i63MgyJkd
	yYJkSPZ+3qTwpRyn8foRLIryqazTTXhlct/kV8DVYnQTbXAjjLmYLRQANzrMPFXlPn8ipE
	x1FsKbfCHoxdiWRuXkLnaUXiStaj1PE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1739890965;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q7AVrF9ImZMiQtbhCkV0xB4O3QN1TooCyYbbebiN5RI=;
	b=Nldm3XuoIBkSbhWanlQuhz9oeF7EWCcg8C3TA/s98xFav/thw1DTYEhF1FPrjvWZc4CcWW
	3XirSQkS1Cp3XiAQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="TH/vyPra";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Nldm3Xuo
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1739890965; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q7AVrF9ImZMiQtbhCkV0xB4O3QN1TooCyYbbebiN5RI=;
	b=TH/vyPrak8PCZ0vEaafDeUCYqouDLsldQujzwmjRx3pncH4F+TfCo0qIdTUz/i63MgyJkd
	yYJkSPZ+3qTwpRyn8foRLIryqazTTXhlct/kV8DVYnQTbXAjjLmYLRQANzrMPFXlPn8ipE
	x1FsKbfCHoxdiWRuXkLnaUXiStaj1PE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1739890965;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q7AVrF9ImZMiQtbhCkV0xB4O3QN1TooCyYbbebiN5RI=;
	b=Nldm3XuoIBkSbhWanlQuhz9oeF7EWCcg8C3TA/s98xFav/thw1DTYEhF1FPrjvWZc4CcWW
	3XirSQkS1Cp3XiAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C5B0613A1D;
	Tue, 18 Feb 2025 15:02:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wpbBKxOhtGc6bgAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 18 Feb 2025 15:02:43 +0000
Message-ID: <a4ba2d82-1f42-4d70-bf66-56ef9c037cca@suse.de>
Date: Tue, 18 Feb 2025 16:02:43 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/8] fs/mpage: use blocks_per_folio instead of
 blocks_per_page
To: Matthew Wilcox <willy@infradead.org>, Luis Chamberlain <mcgrof@kernel.org>
Cc: dave@stgolabs.net, david@fromorbit.com, djwong@kernel.org,
 kbusch@kernel.org, john.g.garry@oracle.com, hch@lst.de,
 ritesh.list@gmail.com, linux-fsdevel@vger.kernel.org,
 linux-xfs@vger.kernel.org, linux-mm@kvack.org, linux-block@vger.kernel.org,
 gost.dev@samsung.com, p.raghav@samsung.com, da.gomez@samsung.com,
 kernel@pankajraghav.com
References: <20250204231209.429356-1-mcgrof@kernel.org>
 <20250204231209.429356-5-mcgrof@kernel.org>
 <Z7Ow_ib2GDobCXdP@casper.infradead.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <Z7Ow_ib2GDobCXdP@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 1F17C2116B
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
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
	FREEMAIL_CC(0.00)[stgolabs.net,fromorbit.com,kernel.org,oracle.com,lst.de,gmail.com,vger.kernel.org,kvack.org,samsung.com,pankajraghav.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

On 2/17/25 22:58, Matthew Wilcox wrote:
> On Tue, Feb 04, 2025 at 03:12:05PM -0800, Luis Chamberlain wrote:
>> @@ -182,7 +182,7 @@ static struct bio *do_mpage_readpage(struct mpage_readpage_args *args)
>>   		goto confused;
>>   
>>   	block_in_file = folio_pos(folio) >> blkbits;
>> -	last_block = block_in_file + args->nr_pages * blocks_per_page;
>> +	last_block = block_in_file + args->nr_pages * blocks_per_folio;
> 
> In mpage_readahead(), we set args->nr_pages to the nunber of pages (not
> folios) being requested.  In mpage_read_folio() we currently set it to
> 1.  So this is going to read too far ahead for readahead if using large
> folios.
> 
> I think we need to make nr_pages continue to mean nr_pages.  Or we pass
> in nr_bytes or nr_blocks.
> 
I had been pondering this, too, while developing the patch.
The idea I had here was to change counting by pages over to counting by 
folios, as then the logic is essentially unchanged.

Not a big fan of 'nr_pages', as then the question really is how much
data we should read at the end of the day. So I'd rather go with 
'nr_blocks' to avoid any confusion.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

