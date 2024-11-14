Return-Path: <linux-fsdevel+bounces-34790-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 363309C8C11
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2024 14:48:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE83D285817
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2024 13:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 905D1286A1;
	Thu, 14 Nov 2024 13:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="gbU7YX0a";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="qwKLoy/i";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="gbU7YX0a";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="qwKLoy/i"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A0A1CABA;
	Thu, 14 Nov 2024 13:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731592084; cv=none; b=HzGVz7Xwvx630gKfhlzcxmcwBnLQbeUPJMjji464FqIvZaMPP+c+LYqZ4Z38hgLAzVPkHty5a506eG06E2kUac58FwGIzWbTLDOWl7wydlYE6ZPu0uc3ltqoQ0PVYGqTxjA+GUM1ataO0c7KokoSEHHo3BY5XHemsSNKoEdSHdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731592084; c=relaxed/simple;
	bh=Sz/HCjWcHw2fNUUcTFPW8cNaSdfsidSlAYnDLaTLs1A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FK1LxcUqb226FnOlKGKVuHOftyMMSdyjNPFUmIQbYTbi7RXIa5xBffkh1bQJWebwxdt949InGLbJzBSTa0+i99GYCbo8KV199y1D2V81hjfFA6Krt6z1Unm/UR2M691fU1B/OrT1s8bkriqTPZQkAFpS5X2OKfbr6oEsR4qs7Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=gbU7YX0a; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=qwKLoy/i; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=gbU7YX0a; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=qwKLoy/i; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6C1C41F395;
	Thu, 14 Nov 2024 13:48:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731592080; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DUjIzgo1/q6wmPt3j3IRmdHoMb98/6oVGe67aiYYv/I=;
	b=gbU7YX0aK2DMwfWKyI22wCpxlAylAYGuTj34yv87OtWi0JQa5xVU4nagYes3DJtflsYwhm
	t0rxqEkk4fqZS7erDiOpXHQvt+5NcYJbJuKmSjG3xwVfD9PCyxjPz/MIRQE6jD9CU4Z/le
	051p6wEuWrSI5kZo8LAbUa6kUOOFyF8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731592080;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DUjIzgo1/q6wmPt3j3IRmdHoMb98/6oVGe67aiYYv/I=;
	b=qwKLoy/iki4X6i7WkAROAZFROb4gIdq0hloTOI6CBRu4QQYOz5Lc6DJz8lYL/4/35wFhHX
	yuTdmpUbPyrQrXBw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=gbU7YX0a;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="qwKLoy/i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731592080; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DUjIzgo1/q6wmPt3j3IRmdHoMb98/6oVGe67aiYYv/I=;
	b=gbU7YX0aK2DMwfWKyI22wCpxlAylAYGuTj34yv87OtWi0JQa5xVU4nagYes3DJtflsYwhm
	t0rxqEkk4fqZS7erDiOpXHQvt+5NcYJbJuKmSjG3xwVfD9PCyxjPz/MIRQE6jD9CU4Z/le
	051p6wEuWrSI5kZo8LAbUa6kUOOFyF8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731592080;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DUjIzgo1/q6wmPt3j3IRmdHoMb98/6oVGe67aiYYv/I=;
	b=qwKLoy/iki4X6i7WkAROAZFROb4gIdq0hloTOI6CBRu4QQYOz5Lc6DJz8lYL/4/35wFhHX
	yuTdmpUbPyrQrXBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 358B013794;
	Thu, 14 Nov 2024 13:48:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id R/KdDJD/NWe7ZQAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 14 Nov 2024 13:48:00 +0000
Message-ID: <7ccc2ab3-4f04-4c4f-abc5-cb3d7a393031@suse.de>
Date: Thu, 14 Nov 2024 14:47:59 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 2/8] fs/mpage: avoid negative shift for large blocksize
To: Matthew Wilcox <willy@infradead.org>, Luis Chamberlain <mcgrof@kernel.org>
Cc: hch@lst.de, david@fromorbit.com, djwong@kernel.org,
 john.g.garry@oracle.com, ritesh.list@gmail.com, kbusch@kernel.org,
 linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
 linux-mm@kvack.org, linux-block@vger.kernel.org, gost.dev@samsung.com,
 p.raghav@samsung.com, da.gomez@samsung.com, kernel@pankajraghav.com,
 Hannes Reinecke <hare@kernel.org>
References: <20241113094727.1497722-1-mcgrof@kernel.org>
 <20241113094727.1497722-3-mcgrof@kernel.org>
 <ZzSygjfVvyrV1jy6@casper.infradead.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <ZzSygjfVvyrV1jy6@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6C1C41F395
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
	FREEMAIL_CC(0.00)[lst.de,fromorbit.com,kernel.org,oracle.com,gmail.com,vger.kernel.org,kvack.org,samsung.com,pankajraghav.com];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:email,suse.de:dkim,suse.de:mid]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

On 11/13/24 15:06, Matthew Wilcox wrote:
> On Wed, Nov 13, 2024 at 01:47:21AM -0800, Luis Chamberlain wrote:
>> +++ b/fs/mpage.c
>> @@ -181,7 +181,7 @@ static struct bio *do_mpage_readpage(struct mpage_readpage_args *args)
>>   	if (folio_buffers(folio))
>>   		goto confused;
>>   
>> -	block_in_file = (sector_t)folio->index << (PAGE_SHIFT - blkbits);
>> +	block_in_file = (sector_t)(((loff_t)folio->index << PAGE_SHIFT) >> blkbits);
> 
> 	block_in_file = folio_pos(folio) >> blkbits;
> ?
> 
>> @@ -527,7 +527,7 @@ static int __mpage_writepage(struct folio *folio, struct writeback_control *wbc,
>>   	 * The page has no buffers: map it to disk
>>   	 */
>>   	BUG_ON(!folio_test_uptodate(folio));
>> -	block_in_file = (sector_t)folio->index << (PAGE_SHIFT - blkbits);
>> +	block_in_file = (sector_t)(((loff_t)folio->index << PAGE_SHIFT) >> blkbits);
> 
> Likewise.

Yeah. /me not being able to find proper macros ...

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

