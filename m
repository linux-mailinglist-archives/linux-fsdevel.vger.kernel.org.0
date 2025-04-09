Return-Path: <linux-fsdevel+bounces-46079-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99EAFA8249B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Apr 2025 14:25:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED5E01BC09CB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Apr 2025 12:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81702262801;
	Wed,  9 Apr 2025 12:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="EDprO00/";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="23eBSpA/";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="EDprO00/";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="23eBSpA/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6172925EF81
	for <linux-fsdevel@vger.kernel.org>; Wed,  9 Apr 2025 12:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744201410; cv=none; b=moGxeCSSWZqxAGEL9t3UiavW+iWXRM8erVqChl4UMHv7F+1Ed2mOiq1Ik0b2mV6CgXPCX/8Vgl915ItAPOVr+JFcRB1hJWwx1HHjhSXqh8zqk2NnXvjbkdYpln7b/Sbz7jOp8rVAThaFeOYNBaIKCVLQSIi3Hn4BrwmivWD+koI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744201410; c=relaxed/simple;
	bh=Fgr7R5b+ulQnIXmOIM1WAgaF0kERi+EgqOoyjhbfzzA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ffqnCuuq9B8AQFgsYZHMxrjfv+K0OG+cR7XkiNsAVRVnCW2CPIQPPH2/wS0yeOmLwjq8fZF7VUTUBn9PNvd4QCtHqffB5nOMymbkg/t9Ql5YwUeccypwS3z7WoJae5+a0TtBMtuCEcrnGJoykJKlDWCYid1M2aZuU21POY9kSMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=EDprO00/; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=23eBSpA/; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=EDprO00/; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=23eBSpA/; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3CEBF1F395;
	Wed,  9 Apr 2025 12:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744201407; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=35vhnK1QcBnFpxT7JcUr3Qul61NTqzLzG46OhW8fdm4=;
	b=EDprO00/3+viqpN3KchYLp16WLLxHQnZ2MOQlaYsdGrdcP6RAlf9sDIP6FPHlOYkva8Gwo
	vrFm6Hwbd7ZfSscaRmJh4PYBvaZbqy/Cm7fDdpcfSG9cTw9uRteoEZgQJGlTzMHqjO4cGl
	JmqVrkRrKSqoPXPbGI5ielEcdtXl0Y0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744201407;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=35vhnK1QcBnFpxT7JcUr3Qul61NTqzLzG46OhW8fdm4=;
	b=23eBSpA/dhmmWdsuf2zdm3SRRQOcZFr7g+Nk5PmLS61Wz/yaNBFec9OEfer0/EUMRQW3jY
	n3cmwyoVrDSjMtDQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="EDprO00/";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="23eBSpA/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744201407; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=35vhnK1QcBnFpxT7JcUr3Qul61NTqzLzG46OhW8fdm4=;
	b=EDprO00/3+viqpN3KchYLp16WLLxHQnZ2MOQlaYsdGrdcP6RAlf9sDIP6FPHlOYkva8Gwo
	vrFm6Hwbd7ZfSscaRmJh4PYBvaZbqy/Cm7fDdpcfSG9cTw9uRteoEZgQJGlTzMHqjO4cGl
	JmqVrkRrKSqoPXPbGI5ielEcdtXl0Y0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744201407;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=35vhnK1QcBnFpxT7JcUr3Qul61NTqzLzG46OhW8fdm4=;
	b=23eBSpA/dhmmWdsuf2zdm3SRRQOcZFr7g+Nk5PmLS61Wz/yaNBFec9OEfer0/EUMRQW3jY
	n3cmwyoVrDSjMtDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2A262137AC;
	Wed,  9 Apr 2025 12:23:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Snj8Cb9m9mdJKgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 09 Apr 2025 12:23:27 +0000
Message-ID: <c2b10e1b-2914-48be-8818-863d8c3e5e3f@suse.cz>
Date: Wed, 9 Apr 2025 14:23:35 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: kvmalloc: make kmalloc fast path real fast path
To: Michal Hocko <mhocko@suse.com>
Cc: Dave Chinner <david@fromorbit.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Shakeel Butt <shakeel.butt@linux.dev>, Yafang Shao <laoar.shao@gmail.com>,
 Harry Yoo <harry.yoo@oracle.com>, Kees Cook <kees@kernel.org>,
 joel.granados@kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
 linux-mm@kvack.org
References: <Z-y50vEs_9MbjQhi@harry>
 <CALOAHbBSvMuZnKF_vy3kGGNOCg5N2CgomLhxMxjn8RNwMTrw7A@mail.gmail.com>
 <Z-0gPqHVto7PgM1K@dread.disaster.area> <Z-0sjd8SEtldbxB1@tiehlicka>
 <zeuszr6ot5qdi46f5gvxa2c5efy4mc6eaea3au52nqnbhjek7o@l43ps2jtip7x>
 <Z-43Q__lSUta2IrM@tiehlicka> <Z-48K0OdNxZXcnkB@tiehlicka>
 <Z-7m0CjNWecCLDSq@tiehlicka> <Z_YjKs5YPk66vmy8@tiehlicka>
 <0f2091ba-0a43-4dd3-aa48-fe284530044a@suse.cz> <Z_ZmKcA2CvMiZnSG@tiehlicka>
Content-Language: en-US
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <Z_ZmKcA2CvMiZnSG@tiehlicka>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 3CEBF1F395
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[fromorbit.com,linux-foundation.org,linux.dev,gmail.com,oracle.com,kernel.org,vger.kernel.org,toxicpanda.com,kvack.org];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

On 4/9/25 2:20 PM, Michal Hocko wrote:
> On Wed 09-04-25 11:11:37, Vlastimil Babka wrote:
>> On 4/9/25 9:35 AM, Michal Hocko wrote:
>>> On Thu 03-04-25 21:51:46, Michal Hocko wrote:
>>>> Add Andrew
>>>
>>> Andrew, do you want me to repost the patch or can you take it from this
>>> email thread?
>>
>> I'll take it as it's now all in mm/slub.c
> 
> Thanks that will work as well.

It's now in slab/for-next with Shakeel's ack and the updated comment you
discussed:

https://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab.git/commit/?h=slab/for-6.16/fixes&id=bfedb6b93bc8d1dc02627beb43ceb466f42a4ed9

