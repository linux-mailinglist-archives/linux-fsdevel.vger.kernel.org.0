Return-Path: <linux-fsdevel+bounces-16044-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AB5F897466
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 17:49:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C19EB2B024
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 15:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 239D814A602;
	Wed,  3 Apr 2024 15:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="B9LTX7Lv";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="XpD4vI0O"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A906D14A0A2;
	Wed,  3 Apr 2024 15:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712159308; cv=none; b=iy7qw1iKIxy64EcgaKMbkyqmB7lYE5umvexLfrOyNB6OHE5kx2jcRtP7mijilovNhzb2aIOQRo1ZMSzvsBGkQFl44dtISMQa2DKqJtG0GU5LOMqogM5OrWAp13ODQ7BmsqXmddp36rxOjCxjf6/oIMmOuf1lOAjiMUZ9fxnFlxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712159308; c=relaxed/simple;
	bh=xeOUKhPq3Fj2QGoZD8eBqnVOFFJiuO02MjXvbR7cwtg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qnuSjXpHdqZpeXT9hsK0nCa5kXRw1+6/+dwTzg0EagFIeGgYunuYNDomUxU3TN2RgFfQ/nhkGGWMh0200vYtbZOb1HKU5n5T+nU08AFAkPAnt8P7PDSqJkteu7zpVe3eGV4DOGHxVd5V73IEZ9AI8DlZvlmsWLT+bdmN7RU7duU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=B9LTX7Lv; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=XpD4vI0O; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DE05234F5A;
	Wed,  3 Apr 2024 15:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1712159304; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7oNoIY5ww0gv3VU/TWODJLW0stHUYUIo7HrJ52y0BwM=;
	b=B9LTX7LvmmsyVU4sIRQovKvU02mdKjzNeFejSfw+KnhrXcUtGr/V1WGmTUvAgVVvwQKd3j
	+FV20M4Sv/CqK1RW2oe/0geQaAuA+pnzADleF4Hj3FTvlPB8ELNOiSLe8+PaWQwzUe+DBO
	MDzXUtk0PNOMmo1l1/IvzsLO1NG1bxY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1712159304;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7oNoIY5ww0gv3VU/TWODJLW0stHUYUIo7HrJ52y0BwM=;
	b=XpD4vI0OejctTDeIixHkLVdljXWdVHrKM7K1YjIYArDfpRXhwYY+7nUrsk3Om4eQ2vMdLU
	kTaPgCYV1K7kSbBw==
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id AA70F1331E;
	Wed,  3 Apr 2024 15:48:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id aLZCKUh6DWbpegAAn2gu4w
	(envelope-from <vbabka@suse.cz>); Wed, 03 Apr 2024 15:48:24 +0000
Message-ID: <4af50be2-4109-45e5-8a36-2136252a635e@suse.cz>
Date: Wed, 3 Apr 2024 17:48:24 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] mm, slab: move memcg charging to post-alloc hook
Content-Language: en-US
To: Aishwarya TCV <aishwarya.tcv@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 Chengming Zhou <chengming.zhou@linux.dev>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Josh Poimboeuf <jpoimboe@kernel.org>, Jeff Layton <jlayton@kernel.org>,
 Chuck Lever <chuck.lever@oracle.com>, Kees Cook <kees@kernel.org>,
 Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
 David Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Hyeonggon Yoo <42.hyeyoo@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Michal Hocko <mhocko@kernel.org>, Muchun Song <muchun.song@linux.dev>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Shakeel Butt <shakeel.butt@linux.dev>, Mark Brown <broonie@kernel.org>
References: <20240325-slab-memcg-v2-0-900a458233a6@suse.cz>
 <20240325-slab-memcg-v2-1-900a458233a6@suse.cz>
 <30df7730-1b37-420d-b661-e5316679246f@arm.com>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <30df7730-1b37-420d-b661-e5316679246f@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.79
X-Spamd-Result: default: False [-2.79 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MID_RHS_MATCH_FROM(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-0.998];
	 BAYES_HAM(-3.00)[100.00%];
	 RCPT_COUNT_TWELVE(0.00)[26];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[kvack.org,vger.kernel.org,linux.dev,linux-foundation.org,kernel.org,oracle.com,linux.com,google.com,lge.com,gmail.com,cmpxchg.org,zeniv.linux.org.uk,suse.cz];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Level: 
X-Spam-Flag: NO

On 4/3/24 1:39 PM, Aishwarya TCV wrote:
> 
> 
> On 25/03/2024 08:20, Vlastimil Babka wrote:
>> The MEMCG_KMEM integration with slab currently relies on two hooks
>> during allocation. memcg_slab_pre_alloc_hook() determines the objcg and
>> charges it, and memcg_slab_post_alloc_hook() assigns the objcg pointer
>> to the allocated object(s).
>> 
>> As Linus pointed out, this is unnecessarily complex. Failing to charge
>> due to memcg limits should be rare, so we can optimistically allocate
>> the object(s) and do the charging together with assigning the objcg
>> pointer in a single post_alloc hook. In the rare case the charging
>> fails, we can free the object(s) back.
>> 
>> This simplifies the code (no need to pass around the objcg pointer) and
>> potentially allows to separate charging from allocation in cases where
>> it's common that the allocation would be immediately freed, and the
>> memcg handling overhead could be saved.
>> 
>> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
>> Link: https://lore.kernel.org/all/CAHk-=whYOOdM7jWy5jdrAm8LxcgCMFyk2bt8fYYvZzM4U-zAQA@mail.gmail.com/
>> Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>
>> Reviewed-by: Chengming Zhou <chengming.zhou@linux.dev>
>> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
>> ---
>>  mm/slub.c | 180 +++++++++++++++++++++++++++-----------------------------------
>>  1 file changed, 77 insertions(+), 103 deletions(-)
> 
> Hi Vlastimil,
> 
> When running the LTP test "memcg_limit_in_bytes" against next-master
> (next-20240402) kernel with Arm64 on JUNO, oops is observed in our CI. I
> can send the full logs if required. It is observed to work fine on
> softiron-overdrive-3000.
> 
> A bisect identified 11bb2d9d91627935c63ea3e6a031fd238c846e1 as the first
> bad commit. Bisected it on the tag "next-20240402" at repo
> "https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git".
> 
> This works fine on  Linux version v6.9-rc2

Oops, sorry, can you verify that this fixes it?
Thanks.

----8<----
From b0597c220624fef4f10e26079a3ff1c86f02a12b Mon Sep 17 00:00:00 2001
From: Vlastimil Babka <vbabka@suse.cz>
Date: Wed, 3 Apr 2024 17:45:15 +0200
Subject: [PATCH] fixup! mm, slab: move memcg charging to post-alloc hook

The call to memcg_alloc_abort_single() is wrong, it expects a pointer to
single object, not an array.

Reported-by: Aishwarya TCV <aishwarya.tcv@arm.com>
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/slub.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/slub.c b/mm/slub.c
index f5b151a58b7d..b32e79629ae7 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2100,7 +2100,7 @@ bool memcg_slab_post_alloc_hook(struct kmem_cache *s, struct list_lru *lru,
 		return true;
 
 	if (likely(size == 1)) {
-		memcg_alloc_abort_single(s, p);
+		memcg_alloc_abort_single(s, *p);
 		*p = NULL;
 	} else {
 		kmem_cache_free_bulk(s, size, p);
-- 
2.44.0



