Return-Path: <linux-fsdevel+bounces-14214-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 911C28796BE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Mar 2024 15:46:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E7AE1C2152B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Mar 2024 14:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8C0D7AE7D;
	Tue, 12 Mar 2024 14:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="LswGAEql";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="a6W/UZ0E";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="LswGAEql";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="a6W/UZ0E"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C49C7AE64
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 Mar 2024 14:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710254797; cv=none; b=pdypQfJgqSNtu1IAmsCoKzw7eR/yp0w6bgzOherScQeOJJxaDyggo6OjFIKQP4cOx8rIJaPPIHeENm6ClHPr/J16+86XkbOtA5a2lp+/ZZo1MIif0ZBCiZpB6KODKGzvsL/va03x7vipjtZWTTCv+C/aWy5JlzcNIZ46W0zWuX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710254797; c=relaxed/simple;
	bh=ABS/FEwcE58BLdCIEXhRvGcIbN15Vfw7dfSTP7qTF94=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kPP5EilcSGanWrBknwaNLuaEPVE4Ao9YNKDmBxPk7VgzpTkasBMEgYs3CzKH2cddMwz6eVwDLoUy5hl5nPnBqauNg4hPn3jJkMCpuHdAAM6Arevxhj/Poxg61nV4gtt5DqjstYVekelffpu/yDe8HsYgpz8B2OTtah0fqQVXGYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=LswGAEql; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=a6W/UZ0E; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=LswGAEql; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=a6W/UZ0E; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3339F5D62C;
	Tue, 12 Mar 2024 14:46:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710254793; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1IbOynCtiL2PaA5IeWxQtG1SaOtxW/QcAtTtLspaTMY=;
	b=LswGAEqlwL3PRqPZ6pHPHQBlSmRIjjbylp0N+EMYSffkhlSiGUvX7piYuFisGLGKP6fhTV
	zJE79KVpaqFG5xOIwhp6o2hKytKM1bLDW02f0bXfdxOafL8WwqMwDi5r3RGXNB0lN1Il2h
	JzmKva3sAyVmKJdA/DjWyGjIRZpJzUo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710254793;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1IbOynCtiL2PaA5IeWxQtG1SaOtxW/QcAtTtLspaTMY=;
	b=a6W/UZ0EXMpxJ2eok5iYAeTFn6bf0ZUXhkmV09ZZXFyoY9x4+2UJJ3KinehsiGA669Yjku
	NcdXQhrfX4o1h3BQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710254793; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1IbOynCtiL2PaA5IeWxQtG1SaOtxW/QcAtTtLspaTMY=;
	b=LswGAEqlwL3PRqPZ6pHPHQBlSmRIjjbylp0N+EMYSffkhlSiGUvX7piYuFisGLGKP6fhTV
	zJE79KVpaqFG5xOIwhp6o2hKytKM1bLDW02f0bXfdxOafL8WwqMwDi5r3RGXNB0lN1Il2h
	JzmKva3sAyVmKJdA/DjWyGjIRZpJzUo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710254793;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1IbOynCtiL2PaA5IeWxQtG1SaOtxW/QcAtTtLspaTMY=;
	b=a6W/UZ0EXMpxJ2eok5iYAeTFn6bf0ZUXhkmV09ZZXFyoY9x4+2UJJ3KinehsiGA669Yjku
	NcdXQhrfX4o1h3BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1A5D613795;
	Tue, 12 Mar 2024 14:46:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id hN8PBslq8GWDKAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 12 Mar 2024 14:46:33 +0000
Message-ID: <a7862cf1-1ed2-4c2c-8a27-f9d950ff4da5@suse.cz>
Date: Tue, 12 Mar 2024 15:46:32 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Reclamation interactions with RCU
Content-Language: en-US
To: NeilBrown <neilb@suse.de>, Kent Overstreet <kent.overstreet@linux.dev>
Cc: Dave Chinner <david@fromorbit.com>, Matthew Wilcox <willy@infradead.org>,
 Amir Goldstein <amir73il@gmail.com>, paulmck@kernel.org,
 lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>, Jan Kara <jack@suse.cz>
References: <c6321dd1-ec0e-4fed-87cc-50d297d2be30@paulmck-laptop>
 <CAOQ4uxhiOizDDDJZ+hth4KDvUAYSyM6FRr_uqErAvzQ-=2VydQ@mail.gmail.com>
 <Zd-LljY351NCrrCP@casper.infradead.org>
 <170925937840.24797.2167230750547152404@noble.neil.brown.name>
 <ZeFtrzN34cLhjjHK@dread.disaster.area>
 <pv2chxwnrufut6wecm47q2z7222tzdl3gi6s5wgvmk3b2gq3n5@d23qr5odwyxl>
 <170933687972.24797.18406852925615624495@noble.neil.brown.name>
 <xbjw7mn57qik3ica2k6o7ykt7twryod6rt3uvu73w6xahrrrql@iaplvz7t5tgv>
 <170950594802.24797.17587526251920021411@noble.neil.brown.name>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <170950594802.24797.17587526251920021411@noble.neil.brown.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-3.09 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BAYES_HAM(-3.00)[100.00%];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCPT_COUNT_SEVEN(0.00)[10];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[fromorbit.com,infradead.org,gmail.com,kernel.org,lists.linux-foundation.org,kvack.org,vger.kernel.org,suse.cz];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Score: -3.09
X-Spam-Flag: NO

On 3/3/24 23:45, NeilBrown wrote:
> On Sat, 02 Mar 2024, Kent Overstreet wrote:
>> 
>> *nod* 
>> 
>> > I suspect that most places where there is a non-error fallback already
>> > use NORETRY or RETRY_MAYFAIL or similar.
>> 
>> NORETRY and RETRY_MAYFAIL actually weren't on my radar, and I don't see
>> _tons_ of uses for either of them - more for NORETRY.
>> 
>> My go-to is NOWAIT in this scenario though; my common pattern is "try
>> nonblocking with locks held, then drop locks and retry GFP_KERNEL".
>>  
>> > But I agree that changing the meaning of GFP_KERNEL has a potential to
>> > cause problems.  I support promoting "GFP_NOFAIL" which should work at
>> > least up to PAGE_ALLOC_COSTLY_ORDER (8 pages).
>> 
>> I'd support this change.
>> 
>> > I'm unsure how it should be have in PF_MEMALLOC_NOFS and
>> > PF_MEMALLOC_NOIO context.  I suspect Dave would tell me it should work in
>> > these contexts, in which case I'm sure it should.
>> > 
>> > Maybe we could then deprecate GFP_KERNEL.
>> 
>> What do you have in mind?
> 
> I have in mind a more explicit statement of how much waiting is
> acceptable.
> 
> GFP_NOFAIL - wait indefinitely
> GFP_KILLABLE - wait indefinitely unless fatal signal is pending.
> GFP_RETRY - may retry but deadlock, though unlikely, is possible.  So
>             don't wait indefinitely.  May abort more quickly if fatal
>             signal is pending.
> GFP_NO_RETRY - only try things once.  This may sleep, but will give up
>             fairly quickly.  Either deadlock is a significant
>             possibility, or alternate strategy is fairly cheap.
> GFP_ATOMIC - don't sleep - same as current.
> 
> I don't see how "GFP_KERNEL" fits into that spectrum.  The definition of
> "this will try really hard, but might fail and we can't really tell you
> what circumstances it might fail in" isn't fun to work with.

The problem is if we set out to change everything from GFP_KERNEL to one of
the above, it will take many years. So I think it would be better to just
change the semantics of GFP_KERNEL too.

If we change it to remove the "too-small to fail" rule, we might suddenly
introduce crashes in unknown amount of places, so I don't think that's feasible.

But if we change it to effectively mean GFP_NOFAIL (for non-costly
allocations), there should be a manageable number of places to change to a
variant that allows failure. Also if these places are GFP_KERNEL by mistake
today, and should in fact allow failure, they would be already causing
problems today, as the circumstances where too-small-to-fail is violated are
quite rare (IIRC just being an oom victim, so somewhat close to
GFP_KILLABLE). So changing GFP_KERNEL to GFP_NOFAIL should be the lowest
risk (one could argue for GFP_KILLABLE but I'm afraid many places don't
really handle that as they assume the too-small-to-fail without exceptions
and are unaware of the oom victim loophole, and failing on any fatal signal
increases the chances of this happening).

> Thanks,
> NeilBrown
> 
> 
>> 
>> Deprecating GFP_NOFS and GFP_NOIO would be wonderful - those should
>> really just be PF_MEMALLOC_NOFS and PF_MEMALLOC_NOIO, now that we're
>> pushing for memalloc_flags_(save|restore) more.
>> 
>> Getting rid of those would be a really nice cleanup beacuse then gfp
>> flags would mostly just be:
>>  - the type of memory to allocate (highmem, zeroed, etc.)
>>  - how hard to try (don't block at all, block some, block forever)
>> 
> 
> 


