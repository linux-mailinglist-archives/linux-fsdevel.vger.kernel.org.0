Return-Path: <linux-fsdevel+bounces-28721-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29AAC96D7C6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 14:00:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D35F6285571
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 12:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FF3B179654;
	Thu,  5 Sep 2024 12:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="St9itUJG";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="M1VjWN8/";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="St9itUJG";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="M1VjWN8/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75E819AA72
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Sep 2024 12:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725537628; cv=none; b=WATM/uQ8Mvf8I/MKbSs60eunPfhoPvl5ZijtQM0U48vIUommv8TNgR493Xbdkz8YAk09MUdvJ+vjE9LaF9sZKpzj4dH4RfMug49ZvIMBBY0Z7CdBmUW+DIKpzPeNhukJt3nd7of3Buq0EwxYKwic79Nua98bg5aSuV6s7P7FU8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725537628; c=relaxed/simple;
	bh=ybFNyOyC4rC2zoQhsBoLheZgl9zZev3gUk7nZVGMKVI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WU0CvhMAsLkCHBaZDGE4LDB4VN6sl8oJUQY9N01cf2aExALuqbCHDB+A9m5W2ir0iQpAVgHtDif+biL6YUO5+jryU10edRN/t5XIY4jGgCtgbwogeoExnPQQmYC7mbKs/bVevcSJP/Zk4DGisvD+/mMm3f2W0scRjKqMaWFrijQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=St9itUJG; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=M1VjWN8/; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=St9itUJG; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=M1VjWN8/; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C25A321A80;
	Thu,  5 Sep 2024 12:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725537623; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Spn7CLo0CT0E6HWBORZo4RLPTll0vYYiUag7Fb/6L2s=;
	b=St9itUJGilB52a1VXfc4jVZi7e1h1RtgEnRbJEfZue2WMERqa7JgbonkulPbteHT0PzNLK
	mspZx/gEr1SSycu2oZaFwc7G//3AMqHIeAbElDS8ML6gAWB6QJjJmasrTGt8CvcCKo7m52
	D9I+aCcSYFWrHVqQcOdeS8PJa+cxAGM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725537623;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Spn7CLo0CT0E6HWBORZo4RLPTll0vYYiUag7Fb/6L2s=;
	b=M1VjWN8/faTtL+YPVIXLQD9T123Fim9zwAcECtcwpSD62Q7u1ywiPSObNAM4UWMI/0zZH2
	880m01+rdq2xIdCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725537623; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Spn7CLo0CT0E6HWBORZo4RLPTll0vYYiUag7Fb/6L2s=;
	b=St9itUJGilB52a1VXfc4jVZi7e1h1RtgEnRbJEfZue2WMERqa7JgbonkulPbteHT0PzNLK
	mspZx/gEr1SSycu2oZaFwc7G//3AMqHIeAbElDS8ML6gAWB6QJjJmasrTGt8CvcCKo7m52
	D9I+aCcSYFWrHVqQcOdeS8PJa+cxAGM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725537623;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Spn7CLo0CT0E6HWBORZo4RLPTll0vYYiUag7Fb/6L2s=;
	b=M1VjWN8/faTtL+YPVIXLQD9T123Fim9zwAcECtcwpSD62Q7u1ywiPSObNAM4UWMI/0zZH2
	880m01+rdq2xIdCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A9F0713419;
	Thu,  5 Sep 2024 12:00:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id lx4zKVed2WZBaQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Thu, 05 Sep 2024 12:00:23 +0000
Message-ID: <696de186-ecf1-49b5-bb27-b3290a705e82@suse.cz>
Date: Thu, 5 Sep 2024 14:02:33 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/17] slab: add struct kmem_cache_args
To: Christian Brauner <brauner@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Jann Horn <jannh@google.com>, Linus Torvalds
 <torvalds@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>
Cc: Kees Cook <kees@kernel.org>, Christoph Lameter <cl@linux.com>,
 Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>,
 Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org
References: <20240905-work-kmem_cache_args-v4-0-ed45d5380679@kernel.org>
From: Vlastimil Babka <vbabka@suse.cz>
Content-Language: en-US
In-Reply-To: <20240905-work-kmem_cache_args-v4-0-ed45d5380679@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,linux.com,google.com,lge.com,linux-foundation.org,linux.dev,gmail.com,kvack.org,vger.kernel.org];
	RCVD_COUNT_TWO(0.00)[2];
	TAGGED_RCPT(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

On 9/5/24 9:56 AM, Christian Brauner wrote:
> Hey,
> 
> This is v4 which allows NULL to be passed in the struct kmem_cache_args
> argument of kmem_cache_create() and substitutes default parameters in
> this case.

Thanks, I've followed your earlier suggestion and put this series to a
branch that merges the vfs.file first:

https://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab.git/log/?h=slab/for-6.12/kmem_cache_args

and I'm including it to slab/for-next

Meanwhile I think we should look at the kerneldocs for the new
kmem_cache_create() (hopefully kerneldoc can be persuaded to document it
without throwing errors) and the kmem_cache_args, because patches 16 and
14 just removed what we had before, including the details about
freeptr_offset in patch 14.

> As discussed last week the various kmem_cache_*() functions should be
> replaced by a unified function that is based around a struct, with only
> the basic parameters passed separately.
> 
> Vlastimil already said that he would like to keep core parameters out
> of the struct: name, object size, and flags. I personally don't care
> much and would not object to moving everything into the struct but
> that's a matter of taste and I yield that decision power to the
> maintainer.
> 
> In the first version I pointed out that the choice of name is somewhat
> forced as kmem_cache_create() is taken and the only way to reuse it
> would be to replace all users in one go. Or to do a global
> sed/kmem_cache_create()/kmem_cache_create2()/g. And then introduce
> kmem_cache_setup(). That doesn't strike me as a viable option.
> 
> If we really cared about the *_create() suffix then an alternative might
> be to do a sed/kmem_cache_setup()/kmem_cache_create()/g after every user
> in the kernel is ported. I honestly don't think that's worth it but I
> wanted to at least mention it to highlight the fact that this might lead
> to a naming compromise.
> 
> However, I came up with an alternative using _Generic() to create a
> compatibility layer that will call the correct variant of
> kmem_cache_create() depending on whether struct kmem_cache_args is
> passed or not. That compatibility layer can stay in place until we
> updated all calls to be based on struct kmem_cache_args.
> 
> From a cursory grep (and not excluding Documentation mentions) we will
> have to replace 44 kmem_cache_create_usercopy() calls and about 463
> kmem_cache_create() calls which makes for a bit above 500 calls to port
> to kmem_cache_setup(). That'll probably be good work for people getting
> into kernel development.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
> Changes in v4:
> - Allow NULL to be passed in the struct kmem_cache_args argument of
>   kmem_cache_create() and use default parameters in this case.
> - Link to v3: https://lore.kernel.org/r/20240904-work-kmem_cache_args-v3-0-05db2179a8c2@kernel.org
> 
> Changes in v3:
> - Reworded some commit messages.
> - Picked up various RvBs.
> - Added two patches to make two functions static inline.
> - Link to v2: https://lore.kernel.org/r/20240903-work-kmem_cache_args-v2-0-76f97e9a4560@kernel.org
> 
> Changes in v2:
> - Remove kmem_cache_setup() and add a compatibility layer built around
>   _Generic() so that we can keep the kmem_cache_create() name and type
>   switch on the third argument to either call __kmem_cache_create() or
>   __kmem_cache_create_args().
> - Link to v1: https://lore.kernel.org/r/20240902-work-kmem_cache_args-v1-0-27d05bc05128@kernel.org
> 
> ---
> Christian Brauner (17):
>       slab: s/__kmem_cache_create/do_kmem_cache_create/g
>       slab: add struct kmem_cache_args
>       slab: port kmem_cache_create() to struct kmem_cache_args
>       slab: port kmem_cache_create_rcu() to struct kmem_cache_args
>       slab: port kmem_cache_create_usercopy() to struct kmem_cache_args
>       slab: pass struct kmem_cache_args to create_cache()
>       slab: pull kmem_cache_open() into do_kmem_cache_create()
>       slab: pass struct kmem_cache_args to do_kmem_cache_create()
>       slab: remove rcu_freeptr_offset from struct kmem_cache
>       slab: port KMEM_CACHE() to struct kmem_cache_args
>       slab: port KMEM_CACHE_USERCOPY() to struct kmem_cache_args
>       slab: create kmem_cache_create() compatibility layer
>       file: port to struct kmem_cache_args
>       slab: remove kmem_cache_create_rcu()
>       slab: make kmem_cache_create_usercopy() static inline
>       slab: make __kmem_cache_create() static inline
>       io_uring: port to struct kmem_cache_args
> 
>  fs/file_table.c      |  11 ++-
>  include/linux/slab.h | 130 +++++++++++++++++++++++++++------
>  io_uring/io_uring.c  |  14 ++--
>  mm/slab.h            |   6 +-
>  mm/slab_common.c     | 197 +++++++++++----------------------------------------
>  mm/slub.c            | 162 +++++++++++++++++++++---------------------
>  6 files changed, 250 insertions(+), 270 deletions(-)
> ---
> base-commit: 6e016babce7c845ed015da25c7a097fa3482d95a
> change-id: 20240902-work-kmem_cache_args-e9760972c7d4
> 

