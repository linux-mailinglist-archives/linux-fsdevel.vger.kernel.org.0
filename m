Return-Path: <linux-fsdevel+bounces-14188-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 43C178790E5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Mar 2024 10:25:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E8BAB21D43
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Mar 2024 09:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D88A78676;
	Tue, 12 Mar 2024 09:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="JjTUxez+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="4EUcVuLu";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="JjTUxez+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="4EUcVuLu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 908E477F25;
	Tue, 12 Mar 2024 09:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710235379; cv=none; b=CoQ6Ss7h5gxLJv4XvkbVG+x9SvoGRbwcyibiRPfGMxeEQtAMKTxutKM9IYFyi3vjf8DM3Vh2U+mz2GjZsQ24NFHRJxeBnF+5hqmMW93DNsBK78jV/iJQ3/gnkKfOoFWvBg/OK8XnmCb/QMFhjUyAVpPddaUcBikwrFT4gnXiOug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710235379; c=relaxed/simple;
	bh=I+EYM0WoETASWaRI0J3YiWa6rmHuNoDSp7q5mvmzE8k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ft51vaxzZeGapGuZUQiYk/ymdLxzFQn0oVqSlA5XJZrelyKtRHTngLuXZlDU3GYYbtoXevnIeMg1f/JD7woPXsrJ2oba6el1g3sSsefq8sAg6+prGs6mFutbT1EGpP3z7UGIavJlZIxqlETQScJnbjj+GWjF48c7DJI8/qFIqlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=JjTUxez+; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=4EUcVuLu; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=JjTUxez+; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=4EUcVuLu; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6A4A6374BE;
	Tue, 12 Mar 2024 09:22:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710235375; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QstBqPw+TFWXqr+lHM3TQAnfI7rBxMjKCBz0FdaAFh8=;
	b=JjTUxez+t5+tkgWCeHoYFhbWGQ/8+VyUw3UsPDj4CwE/vP4F1JcUAVotrRQGG7Yyu/yj3B
	am4oK9MbDA2uZBbKHajOpaLX4c7TyLOFvKXng9vsiDQe/mZGO8kdmNpLDfOda9ZY5Gh2xH
	ys4+nCE24DEeOg/Y4jnROi95X4GWVCo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710235375;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QstBqPw+TFWXqr+lHM3TQAnfI7rBxMjKCBz0FdaAFh8=;
	b=4EUcVuLu9y7GiROf+XRXjuTVFaEcC9Oez6BLIMLagRJ2BdV7eDlXozkus+xsGav7jhpWGa
	KAeVEKkPIQD5NgBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710235375; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QstBqPw+TFWXqr+lHM3TQAnfI7rBxMjKCBz0FdaAFh8=;
	b=JjTUxez+t5+tkgWCeHoYFhbWGQ/8+VyUw3UsPDj4CwE/vP4F1JcUAVotrRQGG7Yyu/yj3B
	am4oK9MbDA2uZBbKHajOpaLX4c7TyLOFvKXng9vsiDQe/mZGO8kdmNpLDfOda9ZY5Gh2xH
	ys4+nCE24DEeOg/Y4jnROi95X4GWVCo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710235375;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QstBqPw+TFWXqr+lHM3TQAnfI7rBxMjKCBz0FdaAFh8=;
	b=4EUcVuLu9y7GiROf+XRXjuTVFaEcC9Oez6BLIMLagRJ2BdV7eDlXozkus+xsGav7jhpWGa
	KAeVEKkPIQD5NgBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3A6781364F;
	Tue, 12 Mar 2024 09:22:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7vPiDe8e8GW6NAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 12 Mar 2024 09:22:55 +0000
Message-ID: <8aa61329-dc3c-46f2-9db5-6e0770fbedda@suse.cz>
Date: Tue, 12 Mar 2024 10:22:54 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 4/4] UNFINISHED mm, fs: use kmem_cache_charge() in
 path_openat()
To: Roman Gushchin <roman.gushchin@linux.dev>,
 Linus Torvalds <torvalds@linux-foundation.org>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, Jeff Layton <jlayton@kernel.org>,
 Chuck Lever <chuck.lever@oracle.com>, Kees Cook <kees@kernel.org>,
 Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
 David Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Hyeonggon Yoo <42.hyeyoo@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Michal Hocko <mhocko@kernel.org>, Shakeel Butt <shakeelb@google.com>,
 Muchun Song <muchun.song@linux.dev>, Alexander Viro
 <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>,
 Jan Kara <jack@suse.cz>, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20240301-slab-memcg-v1-0-359328a46596@suse.cz>
 <20240301-slab-memcg-v1-4-359328a46596@suse.cz>
 <CAHk-=whgFtbTxCAg2CWQtDj7n6CEyzvdV1wcCj2qpMfpw0=m1A@mail.gmail.com>
 <ZeIkKrS7HK6ENwbw@P9FQF9L96D.corp.robot.car>
Content-Language: en-US
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <ZeIkKrS7HK6ENwbw@P9FQF9L96D.corp.robot.car>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spamd-Bar: /
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=JjTUxez+;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=4EUcVuLu
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [0.00 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 TO_DN_SOME(0.00)[];
	 DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
	 R_RATELIMIT(0.00)[to_ip_from(RLduzbn1medsdpg3i8igc4rk67)];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-0.20)[-0.983];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-0.00)[17.18%];
	 MID_RHS_MATCH_FROM(0.00)[];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCPT_COUNT_TWELVE(0.00)[23];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FREEMAIL_CC(0.00)[kernel.org,oracle.com,linux.com,google.com,lge.com,linux-foundation.org,gmail.com,cmpxchg.org,linux.dev,zeniv.linux.org.uk,suse.cz,kvack.org,vger.kernel.org];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Score: 0.00
X-Rspamd-Queue-Id: 6A4A6374BE
X-Spam-Flag: NO

On 3/1/24 19:53, Roman Gushchin wrote:
> On Fri, Mar 01, 2024 at 09:51:18AM -0800, Linus Torvalds wrote:
>> What I *think* I'd want for this case is
>> 
>>  (a) allow the accounting to go over by a bit
>> 
>>  (b) make sure there's a cheap way to ask (before) about "did we go
>> over the limit"
>> 
>> IOW, the accounting never needed to be byte-accurate to begin with,
>> and making it fail (cheaply and early) on the next file allocation is
>> fine.
>> 
>> Just make it really cheap. Can we do that?
>> 
>> For example, maybe don't bother with the whole "bytes and pages"
>> stuff. Just a simple "are we more than one page over?" kind of
>> question. Without the 'stock_lock' mess for sub-page bytes etc
>> 
>> How would that look? Would it result in something that can be done
>> cheaply without locking and atomics and without excessive pointer
>> indirection through many levels of memcg data structures?
> 
> I think it's possible and I'm currently looking into batching charge,
> objcg refcnt management and vmstats using per-task caching. It should
> speed up things for the majority of allocations.
> For allocations from an irq context and targeted allocations
> (where the target memcg != memcg of the current task) we'd probably need to
> keep the old scheme. I hope to post some patches relatively soon.

Do you think this will work on top of this series, i.e. patches 1+2 could be
eventually put to slab/for-next after the merge window, or would it
interfere with your changes?

> I tried to optimize the current implementation but failed to get any
> significant gains. It seems that the overhead is very evenly spread across
> objcg pointer access, charge management, objcg refcnt management and vmstats.
> 
> Thanks!


