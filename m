Return-Path: <linux-fsdevel+bounces-28061-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2F8B96654E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2024 17:25:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6514B285446
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2024 15:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 368E21B530A;
	Fri, 30 Aug 2024 15:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="PjJ/GGJz";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="R/iTWHJh";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="b3LaU4/L";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="kVhVRxbY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8635DEACD;
	Fri, 30 Aug 2024 15:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725031543; cv=none; b=cFjsDT2tRJADkBWaFIcGGHO4KFMmLzPOFVsagpnOk6nZK3SUOQTXYEsZZ3KY39LC786Ltn3Az2vcq2xIOqMG5K9C8/jIcDFw9Yta1GjgiRZOtLuu0ZXEohcBFZ6WnemVuM7dNOzyUhthnsLJ7QcFrrhbv5l4zpTM2cmSFyZaiWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725031543; c=relaxed/simple;
	bh=iNp6n/jsH71QB5oDAhRZb0TAOpaKlbAuJNW//GZ1g44=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tKVAhg5BhvoAfPBUzuqK62hgY4rFWxIixqtt0TurYeqo0rkazw/Jl06d7puzoI3Pp8vdxA84s9zaGmFfOGTKcMzktGtQaTUHwHWXtqVIhPUocNAP2+aLWwOITaCGEWENbebH0o3jcNkx+elitUIqizxJkOnhZkgnNakXsd4tZrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=PjJ/GGJz; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=R/iTWHJh; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=b3LaU4/L; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=kVhVRxbY; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3E5831F7D7;
	Fri, 30 Aug 2024 15:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725031539; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XWnzRDtYyiKw4+/tQoF82vYW5iToq0BDKNejq3/tEfI=;
	b=PjJ/GGJz/HPNIwxTYmQLnQVqQhnIPSG5hlOD15O3/cEExasyt6JbkegPLNQ0fbj5WSw+CA
	eq1IuQ13AFR/ZTev6jiyB9ka2u9/5wE+C05Vj6+Km5UkBQ8PZrFMqGRbvTyKJpBG8UGEQ7
	GvCgHC6Ned/EgsVo/g47UCNnQGTRCE0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725031539;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XWnzRDtYyiKw4+/tQoF82vYW5iToq0BDKNejq3/tEfI=;
	b=R/iTWHJhvXOWOm35QXFdoQpgreMc3S3+OkDUaQofGb/WV0ZFjE9srlc4cmqFZwOHvbEb4+
	9ed+5RAwYGom3pBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725031538; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XWnzRDtYyiKw4+/tQoF82vYW5iToq0BDKNejq3/tEfI=;
	b=b3LaU4/LNz2Ztgx6PoNo9qffokU3etG2y3fudDe+hX+OCc67YBzyQllbrGViRips59msZa
	DHJVxMosYBjjnlQlnapOJS4DPBryhJeq1X4lLqkVVDGjJHyrAirM81Sn6Z8J88uwvB5+Jm
	jTaV/UiHtK4IpyWY0016sQObLswCrlQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725031538;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XWnzRDtYyiKw4+/tQoF82vYW5iToq0BDKNejq3/tEfI=;
	b=kVhVRxbY+uTv1eXdfW7326R2MlZWqBxgd9tjLG1jLWYqGVysANrvajdy953rh0Lil5O97a
	JAMAWHQD5V5JSnBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 24D0A13A3D;
	Fri, 30 Aug 2024 15:25:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Dx0vCHLk0WZ+ewAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 30 Aug 2024 15:25:38 +0000
Message-ID: <f62e400e-49ab-4d0a-b2e2-c3bbb66c2ab1@suse.cz>
Date: Fri, 30 Aug 2024 17:25:37 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bcachefs: Switch to memalloc_flags_do() for vmalloc
 allocations
Content-Language: en-US
To: Yafang Shao <laoar.shao@gmail.com>, Dave Chinner <david@fromorbit.com>
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
 Michal Hocko <mhocko@suse.com>, Matthew Wilcox <willy@infradead.org>,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Dave Chinner <dchinner@redhat.com>
References: <20240828140638.3204253-1-kent.overstreet@linux.dev>
 <Zs9xC3OJPbkMy25C@casper.infradead.org>
 <gutyvxwembnzaoo43dzvmnpnbmj6pzmypx5kcyor3oeomgzkva@6colowp7crgk>
 <Zs959Pa5H5WeY5_i@tiehlicka>
 <xxs3s22qmlzby3ligct7x5a3fbzzjfdqqt7unmpih64dk3kdyx@vml4m27gpujw>
 <ZtBWxWunhXTh0bhS@tiehlicka>
 <wjfubyrzk4ovtuae5uht7uhhigkrym2anmo5w5vp7xgq3zss76@s2uy3qindie4>
 <ZtCFP5w6yv/aykui@dread.disaster.area>
 <CALOAHbCssCSb7zF6VoKugFjAQcMACmOTtSCzd7n8oGfXdsxNsg@mail.gmail.com>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <CALOAHbCssCSb7zF6VoKugFjAQcMACmOTtSCzd7n8oGfXdsxNsg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	URIBL_BLOCKED(0.00)[suse.cz:mid,fromorbit.com:email,imap1.dmz-prg2.suse.org:helo];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	ARC_NA(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,fromorbit.com];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,fromorbit.com:email,suse.cz:mid]
X-Spam-Flag: NO
X-Spam-Level: 

On 8/30/24 11:14, Yafang Shao wrote:
> On Thu, Aug 29, 2024 at 10:29 PM Dave Chinner <david@fromorbit.com> wrote:
> 
> Hello Dave,
> 
> I've noticed that XFS has increasingly replaced kmem_alloc() with
> __GFP_NOFAIL. For example, in kernel 4.19.y, there are 0 instances of
> __GFP_NOFAIL under fs/xfs, but in kernel 6.1.y, there are 41
> occurrences. In kmem_alloc(), there's an explicit
> memalloc_retry_wait() to throttle the allocator under heavy memory
> pressure, which aligns with your filesystem design. However, using
> __GFP_NOFAIL removes this throttling mechanism, potentially causing
> issues when the system is under heavy memory load. I'm concerned that
> this shift might not be a beneficial trend.
> 
> We have been using XFS for our big data servers for years, and it has
> consistently performed well with older kernels like 4.19.y. However,
> after upgrading all our servers from 4.19.y to 6.1.y over the past two
> years, we have frequently encountered livelock issues caused by memory
> exhaustion. To mitigate this, we've had to limit the RSS of
> applications, which isn't an ideal solution and represents a worrying
> trend.

By "livelock issues caused by memory exhaustion" you mean the long-standing
infamous issue that the system might become thrashing for the remaining
small amount of page cache, and anonymous memory being swapped out/in,
instead of issuing OOM, because there's always just enough progress of the
reclaim to keep going, but the system isn't basically doing anything else?

I think that's related to near-exhausted memory by userspace, so I'm not
sure why XFS would be to blame here.

That said, if memalloc_retry_wait() is indeed a useful mechanism, maybe we
could perform it inside the page allocator itself for __GFP_NOFAIL?




