Return-Path: <linux-fsdevel+bounces-41180-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69C4DA2C108
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 11:56:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C6CE188BEF4
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 10:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5C7A1DED48;
	Fri,  7 Feb 2025 10:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="RUKNtCf+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="/2tW65eZ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="RUKNtCf+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="/2tW65eZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 759521DE4FC;
	Fri,  7 Feb 2025 10:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738925762; cv=none; b=bJrNCf1JTJH4NMd2q3lPMrb4CdUEXiexOI0unPYXcw0F94zkrgma36oqCjoMgJrH35N3+HPJ+itF+gcw0CXbcmzwFMO8GVzPjv7uP01JKbkHWtxy883eG8UcsZRi9Q/AY4Fd7IKuyDiMK118t+ovZEj6C6PQ3Ebbsd3TaZVSqbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738925762; c=relaxed/simple;
	bh=pYt+xftXndusuacIlXxk2mWb9HDWRHFU3WAlQvHyqeg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WkTNpoLXB34+DvvODvDdeURGrX6CsIsIGU0rqT7qWvxmUD01RXUG6+clHGzpL81NbDoo5k1y6KTU7v2L2Sz1hzwJBfmwBlDfHxx8FO/jxOIVD/yEcb3mdw6qMXHBzDgi0k6KHda59V3sg0JYiUuZNeb/eq4Lo2lqbdpPDzHlxEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=RUKNtCf+; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=/2tW65eZ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=RUKNtCf+; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=/2tW65eZ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9986F21160;
	Fri,  7 Feb 2025 10:55:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1738925758; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=fff5YP4Ec4Ar0HOYCFpKljGsZstst5SYCqA0UJvrHTA=;
	b=RUKNtCf+36/DPgwryIMM4y87jpIXZdbMug0M812QEPrYHQzZ2iVX9Ctg5AMk31+/2e05UB
	yTA3D5sEKLSON04m2+sjQfLqC/raNznG00et61eAKvO8UI1Se9CIXcNk9uJnM+GnFLvNxd
	jDxeiSGm7XBH42kF82/Ua3PE7mpvrrM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1738925758;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=fff5YP4Ec4Ar0HOYCFpKljGsZstst5SYCqA0UJvrHTA=;
	b=/2tW65eZsKGlKjntmZcpZJ7Pa8qyvzoJPjtQvuHkya6I2GWfWcBtbMVTHyqJgL49YxaSVf
	lfoHns/mWBs3uFAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1738925758; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=fff5YP4Ec4Ar0HOYCFpKljGsZstst5SYCqA0UJvrHTA=;
	b=RUKNtCf+36/DPgwryIMM4y87jpIXZdbMug0M812QEPrYHQzZ2iVX9Ctg5AMk31+/2e05UB
	yTA3D5sEKLSON04m2+sjQfLqC/raNznG00et61eAKvO8UI1Se9CIXcNk9uJnM+GnFLvNxd
	jDxeiSGm7XBH42kF82/Ua3PE7mpvrrM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1738925758;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=fff5YP4Ec4Ar0HOYCFpKljGsZstst5SYCqA0UJvrHTA=;
	b=/2tW65eZsKGlKjntmZcpZJ7Pa8qyvzoJPjtQvuHkya6I2GWfWcBtbMVTHyqJgL49YxaSVf
	lfoHns/mWBs3uFAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 71FB313694;
	Fri,  7 Feb 2025 10:55:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id iCK7GL7mpWdReQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 07 Feb 2025 10:55:58 +0000
Message-ID: <f8b08ef9-5bba-490c-9d99-9ab955e68732@suse.cz>
Date: Fri, 7 Feb 2025 11:55:58 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION][BISECTED] Crash with Bad page state for FUSE/Flatpak
 related applications since v6.13
Content-Language: en-US
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Matthew Wilcox <willy@infradead.org>,
 Christian Heusel <christian@heusel.eu>, Josef Bacik <josef@toxicpanda.com>,
 Miklos Szeredi <mszeredi@redhat.com>, regressions@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 Joanne Koong <joannelkoong@gmail.com>, linux-mm <linux-mm@kvack.org>
References: <2f681f48-00f5-4e09-8431-2b3dbfaa881e@heusel.eu>
 <CAJfpegtaTET+R7Tc1MozTQWmYfgsRp6Bzc=HKonO=Uq1h6Nzgw@mail.gmail.com>
 <Z6XWVU6ZTCIl3jnc@casper.infradead.org>
 <03eb13ad-03a2-4982-9545-0a5506e043d0@suse.cz>
 <CAJfpegtvy0N8dNK-jY1W-LX=TyGQxQTxHkgNJjFbWADUmzb6xA@mail.gmail.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <CAJfpegtvy0N8dNK-jY1W-LX=TyGQxQTxHkgNJjFbWADUmzb6xA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[infradead.org,heusel.eu,toxicpanda.com,redhat.com,lists.linux.dev,vger.kernel.org,gmail.com,kvack.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:mid]
X-Spam-Score: -4.30
X-Spam-Flag: NO

On 2/7/25 11:43, Miklos Szeredi wrote:
> On Fri, 7 Feb 2025 at 11:25, Vlastimil Babka <vbabka@suse.cz> wrote:
> 
>> Could be a use-after free of the page, which sets PG_lru again. The list
>> corruptions in __rmqueue_pcplist also suggest some page manipulation after
>> free. The -1 refcount suggests somebody was using the page while it was
>> freed due to refcount dropping to 0 and then did a put_page()?
> 
> Can you suggest any debug options that could help pinpoint the offender?

CONFIG_DEBUG_VM enables a check in put_page_testzero() that would catch the
underflow (modulo a tiny race window where it wouldn't). Worth trying.

> Thanks,
> Miklos


