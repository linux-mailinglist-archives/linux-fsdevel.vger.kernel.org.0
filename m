Return-Path: <linux-fsdevel+bounces-28505-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D77696B5F5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 11:06:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4532C284925
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 09:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16FF719E978;
	Wed,  4 Sep 2024 09:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="R2gPuHFl";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="jCs5uxyf";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="HvBHcvp2";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="v6rblfYD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C639B198A2F
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Sep 2024 09:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725440747; cv=none; b=gpuvV1SMb5IIKaOLatm171cjFDD2mNVWHNd4yIsrLYVRg9TmBwdMH4yDwqRCsXltfwI2SXYNTZgNl8lXK8+XfYH2/kupr+XSceTbgqS+t2lhG9pgulG0b0oPOgLiP94rtSVPeIclTaPsxMLAlTOYwHNPCb1B7yWpWqbF+RICGvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725440747; c=relaxed/simple;
	bh=Wv8qVZr43MDw3H+j3mEGA8g+lZQrAyuiC/2WDAHoWkY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gm3hjh9Y8u7GgE0DSQc/qSP6P/v8r7/NNEICerSg0AcTlhQRE5tVYYckjSH9YwTYsaFetnaQ18vrx8N/GOhqFUC6JntHIRv9MG+Sckzntj9FVLVpktK9ftLMQ+EhruYUFpWsb/a/7xaidycXSVq3N78znat1L0ihWL3sA7g1l2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=R2gPuHFl; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=jCs5uxyf; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=HvBHcvp2; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=v6rblfYD; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DB4D21F7AF;
	Wed,  4 Sep 2024 09:05:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725440744; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=TYZWCq59RBY717M+LjQXIQTkI3xeZCPBTWNYganGX0Y=;
	b=R2gPuHFlw9YvEVv6BUS5BAbYjJqsfIByQ7iPDHbEtCbP2grNE0WF3pXusb0D/qb3DKnfbx
	oAPWI9Bgv7Xl/G78nteoqwk3ccAwyyIR9DaNDRax1ch/XCdRrs0KKY4gsWvTdzZdT0t3zL
	2cl2Go+Sje/rLBI6/9MmFnVXgwH49o4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725440744;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=TYZWCq59RBY717M+LjQXIQTkI3xeZCPBTWNYganGX0Y=;
	b=jCs5uxyfFaNniK4VmEo2dlTPGDGdTyBYlmc71V4OczPS9Je3+BYKV4Q9k9ep0T7mtTDvE1
	ownpH1PcUCw7x6Dw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=HvBHcvp2;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=v6rblfYD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725440743; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=TYZWCq59RBY717M+LjQXIQTkI3xeZCPBTWNYganGX0Y=;
	b=HvBHcvp2Lm9h3bHF7IZHE/n8SpIpYV/l3IabNTJ0WjoQEjqqlpPOyXcGaaEHAx8ZQ/lceu
	Z/n/JtA+021exkXWAoBACLobWrPHNCSGQvnDMclmjduned2moIuk7S5Aqv7FR3d/w3l+mI
	rTDx3E1QKQozE383Jz2uK7tM5akjfVs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725440743;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=TYZWCq59RBY717M+LjQXIQTkI3xeZCPBTWNYganGX0Y=;
	b=v6rblfYDJcEXRys+kEQzTVnm7hrT5YgpNH4Fuao1eBxefQaIwBXwQgzMLKigrtPxKPcJQL
	/15GxGa7Z6bA5QDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C4D50139E2;
	Wed,  4 Sep 2024 09:05:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WMFkL+ci2GaZDgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 04 Sep 2024 09:05:43 +0000
Message-ID: <f2e6faa1-5b23-4955-9a95-e654625ff292@suse.cz>
Date: Wed, 4 Sep 2024 11:05:43 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/15] slab: add struct kmem_cache_args
Content-Language: en-US
To: Christian Brauner <brauner@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Jann Horn <jannh@google.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org
References: <20240903-work-kmem_cache_args-v2-0-76f97e9a4560@kernel.org>
 <8d8da7d3-5a8f-4c79-84d2-90535324cdcd@suse.cz>
 <20240904-stauraum-kennst-5769fa810706@brauner>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <20240904-stauraum-kennst-5769fa810706@brauner>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: DB4D21F7AF
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_TLS_ALL(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:email,suse.cz:dkim,suse.cz:mid];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51
X-Spam-Flag: NO

On 9/4/24 10:42, Christian Brauner wrote:
> On Wed, Sep 04, 2024 at 10:25:32AM GMT, Vlastimil Babka wrote:
>> On 9/3/24 16:20, Christian Brauner wrote:
>> > Hey,
>> > 
>> > As discussed last week the various kmem_cache_*() functions should be
>> > replaced by a unified function that is based around a struct, with only
>> > the basic parameters passed separately.
>> > 
>> > Vlastimil already said that he would like to keep core parameters out
>> > of the struct: name, object size, and flags. I personally don't care
>> > much and would not object to moving everything into the struct but
>> > that's a matter of taste and I yield that decision power to the
>> > maintainer.
>> > 
>> > In the first version I pointed out that the choice of name is somewhat
>> > forced as kmem_cache_create() is taken and the only way to reuse it
>> > would be to replace all users in one go. Or to do a global
>> > sed/kmem_cache_create()/kmem_cache_create2()/g. And then introduce
>> > kmem_cache_setup(). That doesn't strike me as a viable option.
>> > 
>> > If we really cared about the *_create() suffix then an alternative might
>> > be to do a sed/kmem_cache_setup()/kmem_cache_create()/g after every user
>> > in the kernel is ported. I honestly don't think that's worth it but I
>> > wanted to at least mention it to highlight the fact that this might lead
>> > to a naming compromise.
>> > 
>> > However, I came up with an alternative using _Generic() to create a
>> > compatibility layer that will call the correct variant of
>> > kmem_cache_create() depending on whether struct kmem_cache_args is
>> > passed or not. That compatibility layer can stay in place until we
>> > updated all calls to be based on struct kmem_cache_args.
>> > 
>> > From a cursory grep (and not excluding Documentation mentions) we will
>> > have to replace 44 kmem_cache_create_usercopy() calls and about 463
>> > kmem_cache_create() calls which makes for a bit above 500 calls to port
>> > to kmem_cache_setup(). That'll probably be good work for people getting
>> > into kernel development.
>> > 
>> > Signed-off-by: Christian Brauner <brauner@kernel.org>
>> 
>> Besides the nits I replied to individual patches, LGTM and thanks for doing
>> the work. You could add to all:
>> 
>> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
>> 
>> Too bad it's quite late for 6.12, right? It would have to be vfs tree anyway
>> for that due to the kmem_cache_create_rcu() prerequisities. Otherwise I can
> 
> Imho, we can do it and Linus can always just tell us to go away and wait
> for v6.13. But if you prefer to wait that's fine for me too.

Right, we can try. Maybe there's rc8 anyway due to conferences overlapping
with merge window otherwise, so there's more soak time in -next possible.

> And I don't even need to take it all through the vfs tree. I mean, I'm
> happy to do it but the vfs.file branch in it's current form is stable.
> So you could just 
> 
> git pull -S --no-ff git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs vfs.file
> 
> and note in the merge message that you're bringing in the branch as
> prerequisites for the rework and then pull this series in.

OK I'll do that with a v3! Thanks.

> My pull requests will go out latest on Friday before the final release.
> If Linus merges it you can just send yours after.
> 
>> handle it in the slab tree after the merge window, for 6.13.
>> 
>> Also for any more postings please Cc the SLAB ALLOCATOR section, only a
>> small subset of that is completely MIA :)
> 
> Sure.


