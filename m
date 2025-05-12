Return-Path: <linux-fsdevel+bounces-48755-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15332AB398C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 May 2025 15:44:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9708316795F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 May 2025 13:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 349E2295510;
	Mon, 12 May 2025 13:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="KEVMP0YM";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="CIw/tjR6";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="KEVMP0YM";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="CIw/tjR6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC1F281531
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 May 2025 13:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747057468; cv=none; b=N6VLG72iZoMnsVWj9ouYwbcb7MvuACDBz+y/4MnnJ9n5cOqPOGp0qT+nM93EvzSe4DTiRDm0xwDYMexrsaldHgkK3XAKMDZh4Rf+csnC/K3rzqIhVUJ/IT0sh5D3zNUPDDOCDrkwwiBClno9asC+i+ud+PW1OfKEMaWvREeb/9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747057468; c=relaxed/simple;
	bh=ifM2wI1QBcFSOxfePWJpwBcSfNhLDZMvhbjl3uN/kg0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MPUoyPwAh0pg2ILmoQ3i5IPIgI43rbzXPW6Bz+3GxuncRIa3nwxjCbPSm7D40u0GMET1nWWhQ8/b22koXZ70AMdZibqbpnpskqVmuBLzSHCjeSbF6Y+WQHx9kuACcW828lFoMH4d7NsHtMJpfByBEsf3dFtDcj4dDJY8ahiSGO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=KEVMP0YM; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=CIw/tjR6; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=KEVMP0YM; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=CIw/tjR6; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4EE4F1F388;
	Mon, 12 May 2025 13:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1747057465; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ER+N9VpRUCzTYrWu0T2ibs7iXfF6pjRuTAOA5gVtaos=;
	b=KEVMP0YMAB0/Koaa/yIXOoWu2jE8rGQZsiZhUiIfyWcEopOWGblI0oKpHyCSYCQVZdQWno
	lyENY5uzG4zLANDDfWye4090Z0Fjivx0rlBN4Z0C4JawdbhWdjtmfz0hzetQSsp1dGwYLI
	YN5CRNSKoNgVMNLpw0bQ1ONy1x03Upo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1747057465;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ER+N9VpRUCzTYrWu0T2ibs7iXfF6pjRuTAOA5gVtaos=;
	b=CIw/tjR6B1/nBxmjn+fePWFUr4nZvz69tvn6mJ6MahHldP/deIKIwkbOxuW+LpFzpoRpWu
	T003HzbPJXFIzaDw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=KEVMP0YM;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="CIw/tjR6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1747057465; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ER+N9VpRUCzTYrWu0T2ibs7iXfF6pjRuTAOA5gVtaos=;
	b=KEVMP0YMAB0/Koaa/yIXOoWu2jE8rGQZsiZhUiIfyWcEopOWGblI0oKpHyCSYCQVZdQWno
	lyENY5uzG4zLANDDfWye4090Z0Fjivx0rlBN4Z0C4JawdbhWdjtmfz0hzetQSsp1dGwYLI
	YN5CRNSKoNgVMNLpw0bQ1ONy1x03Upo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1747057465;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ER+N9VpRUCzTYrWu0T2ibs7iXfF6pjRuTAOA5gVtaos=;
	b=CIw/tjR6B1/nBxmjn+fePWFUr4nZvz69tvn6mJ6MahHldP/deIKIwkbOxuW+LpFzpoRpWu
	T003HzbPJXFIzaDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 32303137D2;
	Mon, 12 May 2025 13:44:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id DJ3rCzn7IWhbLgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 12 May 2025 13:44:25 +0000
Message-ID: <61badb6b-62aa-4457-900d-c280a8a41f97@suse.cz>
Date: Mon, 12 May 2025 15:44:25 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] mm/vma: remove mmap() retry merge
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
 <d5d8fc74f02b89d6bec5ae8bc0e36d7853b65cda.1746792520.git.lorenzo.stoakes@oracle.com>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <d5d8fc74f02b89d6bec5ae8bc0e36d7853b65cda.1746792520.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 4EE4F1F388
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim,suse.cz:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action

On 5/9/25 14:13, Lorenzo Stoakes wrote:
> We have now introduced a mechanism that obviates the need for a reattempted
> merge via the mmap_prepare() file hook, so eliminate this functionality
> altogether.
> 
> The retry merge logic has been the cause of a great deal of complexity in
> the past and required a great deal of careful manoeuvring of code to ensure
> its continued and correct functionality.
> 
> It has also recently been involved in an issue surrounding maple tree
> state, which again points to its problematic nature.
> 
> We make it much easier to reason about mmap() logic by eliminating this and
> simply writing a VMA once. This also opens the doors to future optimisation
> and improvement in the mmap() logic.
> 
> For any device or file system which encounters unwanted VMA fragmentation
> as a result of this change (that is, having not implemented .mmap_prepare
> hooks), the issue is easily resolvable by doing so.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>


