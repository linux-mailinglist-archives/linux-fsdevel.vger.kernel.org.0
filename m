Return-Path: <linux-fsdevel+bounces-47560-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3788DAA0446
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Apr 2025 09:23:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B365174883
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Apr 2025 07:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF3DF27602E;
	Tue, 29 Apr 2025 07:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="jmbLj3w7";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="tOGPSogo";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="MYNq8J5p";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="RRe9sNC+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE81A2741C6
	for <linux-fsdevel@vger.kernel.org>; Tue, 29 Apr 2025 07:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745911384; cv=none; b=G1rn6h5nkhd8v8xYpzX+rT1tWR4twxt0Dr/UO1ucoTIJtrhCp+a0zT94lsm5+B/i3BhaCQz9Gz3nB2MJdVtbaGVA5AuxPCDjDznYqcTV9W5AA255sF2AM7/Rrhly8KwwJachT4eiHsFT9pON0eGLouVR6jTRKXl2aK/a9/hBE/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745911384; c=relaxed/simple;
	bh=Jqj8S5QKm0XG4wVHlb3ezR62Wv497w3Qiy3aoDfolxc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fGqz6gesDxVZJQQExC7gJKGCjoPo7UgodRIrqt+qjx9g01Bi0s/bOVx1a+JhTiXKEXvQxMPR/3hS/vByCHMpYy4a0jwxAKIyVuZlsGzM+LfNodGUCQBL4Hva8XLAI3QY0qrNauxqMB66BnGvm/W+o+lLCa9KFbE/6lwUOYwbjEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=jmbLj3w7; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=tOGPSogo; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=MYNq8J5p; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=RRe9sNC+; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 08BDB1F7F2;
	Tue, 29 Apr 2025 07:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1745911381; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XgFxspPi9B7NSTbrGf5zsAlHqXY3C8AjKtEtoZAU7aY=;
	b=jmbLj3w7K1ixDNjegIZASUmZ9XlbuU3dtspp8sqf/EWtkAoVilomDcdYrObWqq8TFTbRSf
	d32JIagzYDU6ixRf3HpKbtIZ2aPG/Y6kB4hmO3uv8B4qiK4weYhqJ+BFEF62UONjo9bMyw
	NkvyE+iOm3tkwVC+MAGFdbugVWffcDU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1745911381;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XgFxspPi9B7NSTbrGf5zsAlHqXY3C8AjKtEtoZAU7aY=;
	b=tOGPSogoMM6RcvX9pmSdFY6Ty9OsLo5mG7mp7E47aXJMT04Jk7+OJRdG3k05Ltfwupedxt
	sdfE2yweVVC01JDg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=MYNq8J5p;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=RRe9sNC+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1745911380; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XgFxspPi9B7NSTbrGf5zsAlHqXY3C8AjKtEtoZAU7aY=;
	b=MYNq8J5p9iRBYYjIiOAqkPOVxti1ihU1LdaEK4AmDakfg5Td8G3ImDTc0+ZrHtAAnsOi4e
	87GTSLxZzMAhsEC4hPvBZTxCXVDE/zW7VpfXcDr8PZ2KyMnLOsh3byQIueZF4Q2QxUIx9D
	zI8bR91lMw1tQEmJmOekl2NSu+o3Plc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1745911380;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XgFxspPi9B7NSTbrGf5zsAlHqXY3C8AjKtEtoZAU7aY=;
	b=RRe9sNC+Ltn4cVYSm2DukRGeHLaNH+8QFgZtUSe2qhljQaQL9NFBJypuYLCWK8MSo9NNH2
	VU7UoQZMzrgUmABg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E3A0E1340C;
	Tue, 29 Apr 2025 07:22:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Pj46N1N+EGi7bwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 29 Apr 2025 07:22:59 +0000
Message-ID: <c1acc2a7-5950-4c56-8429-6dc1c918e367@suse.cz>
Date: Tue, 29 Apr 2025 09:22:59 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] mm: perform VMA allocation, freeing, duplication
 in mm
Content-Language: en-US
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>, Jann Horn
 <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
 David Hildenbrand <david@redhat.com>, Kees Cook <kees@kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Suren Baghdasaryan <surenb@google.com>, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1745853549.git.lorenzo.stoakes@oracle.com>
 <f97b3a85a6da0196b28070df331b99e22b263be8.1745853549.git.lorenzo.stoakes@oracle.com>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <f97b3a85a6da0196b28070df331b99e22b263be8.1745853549.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 08BDB1F7F2
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,oracle.com:email,suse.cz:email,suse.cz:dkim,suse.cz:mid];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51
X-Spam-Flag: NO

On 4/28/25 17:28, Lorenzo Stoakes wrote:
> Right now these are performed in kernel/fork.c which is odd and a violation
> of separation of concerns, as well as preventing us from integrating this
> and related logic into userland VMA testing going forward, and perhaps more
> importantly - enabling us to, in a subsequent commit, make VMA
> allocation/freeing a purely internal mm operation.

I wonder if the last part is from an earlier version and now obsolete
because there's not subsequent commit in this series and the placement of
alloc/freeing in vma_init.c seems making those purely internal mm operations
already? Or do you mean some further plans?

> There is a fly in the ointment - nommu - mmap.c is not compiled if
> CONFIG_MMU not set, and neither is vma.c.
> 
> To square the circle, let's add a new file - vma_init.c. This will be
> compiled for both CONFIG_MMU and nommu builds, and will also form part of
> the VMA userland testing.
> 
> This allows us to de-duplicate code, while maintaining separation of
> concerns and the ability for us to userland test this logic.
> 
> Update the VMA userland tests accordingly, additionally adding a
> detach_free_vma() helper function to correctly detach VMAs before freeing
> them in test code, as this change was triggering the assert for this.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>


