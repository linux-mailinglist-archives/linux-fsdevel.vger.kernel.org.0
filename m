Return-Path: <linux-fsdevel+bounces-48754-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78F09AB397E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 May 2025 15:41:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0FAB7A673B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 May 2025 13:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B92A2951D8;
	Mon, 12 May 2025 13:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="lNK/UfBo";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="nJwxY6nI";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="lNK/UfBo";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="nJwxY6nI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80BFB248F7C
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 May 2025 13:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747057272; cv=none; b=GpUNHSRhkzZl/NtOPiSIOxE8IkESlhFbICeFOeE0tyz6jRwIpxQwITjsF/wq3B7DfupFCeL1oFHuk4E9OxOg2MFZgq6r8XEo+PWF1pHXKHR/t1QgvhOCpvFuh4qDDBq3dVGEBEyRXBFTOX66L9s9EO6NHezIqwKtGmGkOVfO1hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747057272; c=relaxed/simple;
	bh=8ktmtIYpT6wwtdT0zYdkBhVaJ3gPszcgYgVw1aS/E5o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VPilQAX3tb8kh+obn9DXpbthQTEIlRXELNlisMg1lY4F14yujW6Yj/6vg5nZKJKgc0Cx4YMwLiti2Ln8r/1+Bu5mCjSb65G4SqejnESuDjjDSb7ej53MP/sg7YaiXjqI4xQOMeOVfxa2YnDjMKe4dsVZiI6/bjzFfTuUUPNd5YA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=lNK/UfBo; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=nJwxY6nI; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=lNK/UfBo; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=nJwxY6nI; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 96FF521186;
	Mon, 12 May 2025 13:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1747057268; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hkc92dB4s/OAzbA2ymL5HCS5Yfyt+Sp+XYay4jTgCDc=;
	b=lNK/UfBo/xbhPN5pZ7VQCHQ9ClJ/Mqizxut2wWLXH6nVhELd5GnrllnQj/DWNsBmLW9Px3
	aUL5cIVq9rr6hkmEwzpzmPLG8gIRsYcr7lO9LM4q6DfpgYbFFZZzHoSbqRall4gvMalYFt
	lD+BeGQG6pOgn9deFHhKC6b+04t4AKI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1747057268;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hkc92dB4s/OAzbA2ymL5HCS5Yfyt+Sp+XYay4jTgCDc=;
	b=nJwxY6nIODhzUIMNYfhvKp6oS+hmpJHRZwMuIjAju9LMe1cj/R8mEDM/ihrdLJIzq1qOLo
	yp/TG0yo5GF/1+Cg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1747057268; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hkc92dB4s/OAzbA2ymL5HCS5Yfyt+Sp+XYay4jTgCDc=;
	b=lNK/UfBo/xbhPN5pZ7VQCHQ9ClJ/Mqizxut2wWLXH6nVhELd5GnrllnQj/DWNsBmLW9Px3
	aUL5cIVq9rr6hkmEwzpzmPLG8gIRsYcr7lO9LM4q6DfpgYbFFZZzHoSbqRall4gvMalYFt
	lD+BeGQG6pOgn9deFHhKC6b+04t4AKI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1747057268;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hkc92dB4s/OAzbA2ymL5HCS5Yfyt+Sp+XYay4jTgCDc=;
	b=nJwxY6nIODhzUIMNYfhvKp6oS+hmpJHRZwMuIjAju9LMe1cj/R8mEDM/ihrdLJIzq1qOLo
	yp/TG0yo5GF/1+Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7A575137D2;
	Mon, 12 May 2025 13:41:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 5amAHXT6IWgkLQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 12 May 2025 13:41:08 +0000
Message-ID: <5c5ccea9-3ce4-40c5-94b4-796d4bc1f533@suse.cz>
Date: Mon, 12 May 2025 15:41:08 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] mm: secretmem: convert to .mmap_prepare() hook
Content-Language: en-US
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@redhat.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>, Mike Rapoport
 <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>,
 Pedro Falcato <pfalcato@suse.de>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Matthew Wilcox <willy@infradead.org>
References: <cover.1746792520.git.lorenzo.stoakes@oracle.com>
 <0f758474fa6a30197bdf25ba62f898a69d84eef3.1746792520.git.lorenzo.stoakes@oracle.com>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <0f758474fa6a30197bdf25ba62f898a69d84eef3.1746792520.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.cz:mid]

On 5/9/25 14:13, Lorenzo Stoakes wrote:
> Secretmem has a simple .mmap() hook which is easily converted to the new
> .mmap_prepare() callback.
> 
> Importantly, it's a rare instance of an driver that manipulates a VMA which
> is mergeable (that is, not a VM_SPECIAL mapping) while also adjusting VMA
> flags which may adjust mergeability, meaning the retry merge logic might
> impact whether or not the VMA is merged.
> 
> By using .mmap_prepare() there's no longer any need to retry the merge
> later as we can simply set the correct flags from the start.
> 
> This change therefore allows us to remove the retry merge logic in a
> subsequent commit.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Reviewed-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>


