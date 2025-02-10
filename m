Return-Path: <linux-fsdevel+bounces-41375-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6223EA2E663
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 09:27:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F060D167B2F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 08:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E3161BEF6D;
	Mon, 10 Feb 2025 08:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="TzyQ0rT0";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="PNwgz+o5";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="CZ/6gXlp";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="KUIj5cQS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF1D31B85D6;
	Mon, 10 Feb 2025 08:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739176056; cv=none; b=d3FmQLe0zRnYGUip2iKjMC0j4jvZLFuIkPNHG+4mttbl4DcoH7qrI+9kdGyzRlYETJh+UBzpcDeaZc2ckpCfucyoz72D27hFvG2z0pgMfuAy7kGtoYG2NnKGekD2cR3zl3Vc266zZ03ODKHgYnrhqi98EYN04K3BltLsyyu7NZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739176056; c=relaxed/simple;
	bh=FTdL7sctDOxRcrBb0oZ2biT5vSzSQRjnYgP28GSiWkI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pZQ6/NrUDYVKWXoM/D4uy4UQk4UEUe6ery5MT4rF/kjKqsGOnmtXs3zT5pir9jRr8inCemTMk8733UcHd/PD53KAbAiLR7jEp7EHKtoYFu5vhGOZGo3O71GoDkc6DdfcUT96WAvbVjeE9+fgv41sq0XSvZZGiBVGnBLAfQiqHQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=TzyQ0rT0; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=PNwgz+o5; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=CZ/6gXlp; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=KUIj5cQS; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D715221109;
	Mon, 10 Feb 2025 08:27:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1739176053; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=YcF4untn6noy1BENHYGy14SUwNDSxJ/1RtuCfKAWOys=;
	b=TzyQ0rT0C7H76CYNALXR817sGRgtoNy2a5UfFajR0OHCpPQbntfWmhkK7znRtDhu4RMY7S
	Rf16CHHoPsjjdZONzWivoK2cHUtb4nMFbB1vfpM7d9hed9wNW1dXYewA4hb/LgTmIQ7kla
	jSItw3gsVRZ3tCpycVbw3u9HQXdADIY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1739176053;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=YcF4untn6noy1BENHYGy14SUwNDSxJ/1RtuCfKAWOys=;
	b=PNwgz+o5DXD9Rrlilyh0YvC5KsD47+yPBweDKJ0tXEa4PDO6TQ3s76TYkxaNZbbwrS8sMx
	o4ch4yn+lKe6eaAQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="CZ/6gXlp";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=KUIj5cQS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1739176052; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=YcF4untn6noy1BENHYGy14SUwNDSxJ/1RtuCfKAWOys=;
	b=CZ/6gXlprzUtNko0sDUyNN4xwzCzy0ffKeQJzQhL/Jx+GgR/HDXc21DMnThgdkSh9vZTQz
	84A61qcyFZEfwBshgDnFgwUWzIqgS4oghayU4n90KK+PbvizgQLY7IPtxKhbJRjvfslX0i
	il0/8xYr0MTy8TxwUqRx6E1BP5gwtxw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1739176052;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=YcF4untn6noy1BENHYGy14SUwNDSxJ/1RtuCfKAWOys=;
	b=KUIj5cQSoxB56L3SoXovFtnfKg9P/K6Ac0c76Jw5zPnj6ECbL1557jb6SqEPkwJzYNCnQt
	TvpuBGQddUfc+nAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B582913707;
	Mon, 10 Feb 2025 08:27:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id p7/9K3S4qWfmIQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 10 Feb 2025 08:27:32 +0000
Message-ID: <81298bd1-e630-4940-ae5b-7882576b6bf4@suse.cz>
Date: Mon, 10 Feb 2025 09:27:32 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION][BISECTED] Crash with Bad page state for FUSE/Flatpak
 related applications since v6.13
To: Joanne Koong <joannelkoong@gmail.com>,
 Matthew Wilcox <willy@infradead.org>
Cc: Josef Bacik <josef@toxicpanda.com>, Miklos Szeredi <miklos@szeredi.hu>,
 Christian Heusel <christian@heusel.eu>, Miklos Szeredi
 <mszeredi@redhat.com>, regressions@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm <linux-mm@kvack.org>, =?UTF-8?Q?Mantas_Mikul=C4=97nas?=
 <grawity@gmail.com>
References: <2f681f48-00f5-4e09-8431-2b3dbfaa881e@heusel.eu>
 <CAJfpegtaTET+R7Tc1MozTQWmYfgsRp6Bzc=HKonO=Uq1h6Nzgw@mail.gmail.com>
 <9cd88643-daa8-4379-be0a-bd31de277658@suse.cz>
 <20250207172917.GA2072771@perftesting>
 <8f7333f2-1ba9-4df4-bc54-44fd768b3d5b@suse.cz>
 <CAJnrk1aNVMCfTjL0vo-Qki68-5t1W+6-bJHg+x67kHEo_-q0Eg@mail.gmail.com>
 <Z6ct4bEdeZwmksxS@casper.infradead.org>
 <CAJnrk1aY0ZFcS4JvmJL=icigencsCD8g4qmZiTuoPWj2S2Y_LQ@mail.gmail.com>
Content-Language: en-US
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <CAJnrk1aY0ZFcS4JvmJL=icigencsCD8g4qmZiTuoPWj2S2Y_LQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D715221109
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_TO(0.00)[gmail.com,infradead.org];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_CC(0.00)[toxicpanda.com,szeredi.hu,heusel.eu,redhat.com,lists.linux.dev,vger.kernel.org,kvack.org,gmail.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51
X-Spam-Flag: NO

On 2/8/25 16:46, Joanne Koong wrote:
> On Sat, Feb 8, 2025 at 2:11 AM Matthew Wilcox <willy@infradead.org> wrote:
>>
>> On Fri, Feb 07, 2025 at 04:22:56PM -0800, Joanne Koong wrote:
>> > > Thanks, Josef. I guess we can at least try to confirm we're on the right track.
>> > > Can anyone affected see if this (only compile tested) patch fixes the issue?
>> > > Created on top of 6.13.1.
>> >
>> > This fixes the crash for me on 6.14.0-rc1. I ran the repro using
>> > Mantas's instructions for Obfuscate. I was able to trigger the crash
>> > on a clean build and then with this patch, I'm not seeing the crash
>> > anymore.
>>
>> Since this patch fixes the bug, we're looking for one call to folio_put()
>> too many.  Is it possibly in fuse_try_move_page()?  In particular, this
>> one:
>>
>>         /* Drop ref for ap->pages[] array */
>>         folio_put(oldfolio);
>>
>> I don't know fuse very well.  Maybe this isn't it.
> 
> Yeah, this looks it to me. We don't grab a folio reference for the
> ap->pages[] array for readahead and it tracks with Mantas's
> fuse_dev_splice_write() dmesg. this patch fixed the crash for me when
> I tested it yesterday:
> 
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index 7d92a5479998..172cab8e2caf 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -955,8 +955,10 @@ static void fuse_readpages_end(struct fuse_mount
> *fm, struct fuse_args *args,
>                 fuse_invalidate_atime(inode);
>         }
> 
> -       for (i = 0; i < ap->num_folios; i++)
> +       for (i = 0; i < ap->num_folios; i++) {
>                 folio_end_read(ap->folios[i], !err);
> +               folio_put(ap->folios[i]);
> +       }
>         if (ia->ff)
>                 fuse_file_put(ia->ff, false);
> 
> @@ -1049,6 +1051,7 @@ static void fuse_readahead(struct readahead_control *rac)
> 
>                 while (ap->num_folios < cur_pages) {
>                         folio = readahead_folio(rac);
> +                       folio_get(folio);

This is almost the same as my patch, but balances the folio_put() in
readahead_folio() with another folio_get(), while mine uses
__readahead_folio() that does not do folio_put() in the first place.

But I think neither patch proves the extraneous folio_put() comes from
fuse_try_move_page().

>                         ap->folios[ap->num_folios] = folio;
>                         ap->descs[ap->num_folios].length = folio_size(folio);
>                         ap->num_folios++;
> 
> 
> I reran it just now with a printk by that ref drop in
> fuse_try_move_page() and I'm indeed seeing that path get hit.

It might get hit, but is it hit in the readahead paths? One way to test
would be to instead of yours above or mine change, to stop doing the
foio_put() in fuse_try_move_page(). But maybe it's called also from other
contexts that do expect it, and will leak memory otherwise.

> Not sure why fstests didn't pick this up though since splice is
> enabled by default in passthrough_hp, i'll look into this next week.
> 


