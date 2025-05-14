Return-Path: <linux-fsdevel+bounces-48950-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 143A8AB670B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 May 2025 11:13:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E0E7866148
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 May 2025 09:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A52D9221DA0;
	Wed, 14 May 2025 09:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="bEl1Gf5v";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="nwvSBOrm";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Cq72lhzG";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="tCmuaFQg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99AAD17996
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 May 2025 09:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747214013; cv=none; b=LqO82c6dgiSHR7DNv04zvveJxWBbJmtrDh+Efslq2NNQmxP2SOY6U/PAZ5c1ncvNxggYwhNE0jfG0Y02jXNNO7HbR2sedH3krBNYdTKjBUnsXnD+JCs2KtA5QH8jH7PVIYl71hVeTrWjBrBKLHy0MrkdXLzzmtHV5WSMJQubpQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747214013; c=relaxed/simple;
	bh=cFeVRe+A70sYpv8Ge9aAo11X2NPgN11proufQ2VgVNQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sPB/wX2C/iwIrTZPBzhVk9pPSKdO2LOttuAQ/Nm2mlFV6OD3mhAznaf5TK8uPCqFOjCu6fWt02+5ipkDSPi7q2zZTFeVxEr2B7SNhLA//ulqwTCcJa86wj85/TL3MQqn2Cer9u5HMwx74UIqY8bmv7kUnInJ3Zsh2mZdCfOb/M0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=bEl1Gf5v; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=nwvSBOrm; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Cq72lhzG; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=tCmuaFQg; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 619AF1F455;
	Wed, 14 May 2025 09:13:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1747214009; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IJzDrZLzl0GAfPyXpLtIqKtYKjkB62YGWcSeN006vHk=;
	b=bEl1Gf5vMzoW9w/RxKz7jsH1lSM2aHfdI5U/pXt3hgqp1KefKLXMTlsA13FPuvDCQWbaxa
	BL47D6iLzqOGwpP8T2ElMsRyscv2wU7zvur0Uwtp3XElvuU8gxCPJEXUGnGp29Dz8FWMh+
	Ep+nHRDcoByE9x5uBGUfGVO/Ehsu81w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1747214009;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IJzDrZLzl0GAfPyXpLtIqKtYKjkB62YGWcSeN006vHk=;
	b=nwvSBOrmxl/LGpG5yITjUvoH8OxYyE+rUnKD3ugEpQfzsFRhA5f2ccdSDLdoAR2OtW3no2
	dGvU5PgK4fqdRgAQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Cq72lhzG;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=tCmuaFQg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1747214008; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IJzDrZLzl0GAfPyXpLtIqKtYKjkB62YGWcSeN006vHk=;
	b=Cq72lhzGbBW2QBWBijcCbYFFzRnKmRnDPomsIRwrLGtBjNfqFjavbOPNuQsv/HhNBKL+49
	oRvgFR4RZlBTyeojT8a9rBpar/Ues7wYdSjZM6cPTSIfUYbyOD4eEsKB0cj+QuHBe69KX1
	9iAeTXraf0CKhxyucl/PRkubTfH/moA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1747214008;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IJzDrZLzl0GAfPyXpLtIqKtYKjkB62YGWcSeN006vHk=;
	b=tCmuaFQg24TDWQ/gg5VCK6pSMVIlUoOElC66m8lfe8VgK7I3/fJZI5WJi9A/Wey4o5d5jQ
	u0NmFuTgk9u7vlAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3AD50137E8;
	Wed, 14 May 2025 09:13:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mlXdDLheJGgAJAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 14 May 2025 09:13:28 +0000
Message-ID: <8e13926d-b685-4802-a207-ade2001cb657@suse.cz>
Date: Wed, 14 May 2025 11:13:27 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: remove WARN_ON_ONCE() in file_has_valid_mmap_hooks()
Content-Language: en-US
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 David Hildenbrand <david@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>, Mike Rapoport
 <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>,
 Pedro Falcato <pfalcato@suse.de>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Matthew Wilcox <willy@infradead.org>
References: <20250514084024.29148-1-lorenzo.stoakes@oracle.com>
 <357de3b3-6f70-49c4-87d4-f6e38e7bec11@redhat.com>
 <f7dddb21-25cb-4de4-8c6e-d588dbc8a7c5@lucifer.local>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <f7dddb21-25cb-4de4-8c6e-d588dbc8a7c5@lucifer.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 619AF1F455
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:mid,suse.cz:dkim];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action

On 5/14/25 10:56, Lorenzo Stoakes wrote:
>> Fixes: c84bf6dd2b83 ("mm: introduce new .mmap_prepare() file callback")

Ah yeah I missed there wasn't one.

> Is it worth having a fixes tag for something not upstream? This is why I
> excluded that. I feel like it's maybe more misleading when the commit hashes are
> ephemeral in a certain branch?

Yeah it can be useful, in case the fixed commit gets backported somewhere,
tools can warn that there's a follow up fix. As mm-stable hashes should not
be ephemeral, then this should remain valid (and if there's a rebase for
some reason then the fix could be squashed).

>>
>> Acked-by: David Hildenbrand <david@redhat.com>
> 
> Thanks!
> 
>>
>> --
>> Cheers,
>>
>> David / dhildenb
>>


