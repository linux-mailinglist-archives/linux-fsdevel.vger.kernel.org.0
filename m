Return-Path: <linux-fsdevel+bounces-52861-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C182AE79D9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 10:20:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2363C7AC33B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 08:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56871210198;
	Wed, 25 Jun 2025 08:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="B1eJDhXf";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="G24Sbemn";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="u2v7kILd";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="BtQjL8pV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A7FE3594E
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Jun 2025 08:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750839634; cv=none; b=Ivz5zLJZdLga/47ayREmXFQn+Wkurmx0a5IQaTUus4PEoioZaxUJ2J/+9HWWbUgnfHo5hFtt8n5v6/P9ggp/gqhAIcK4Syu8KKB5cSGSo1fgpEtiuoi1enZsZ4uENDcsJw+xE1ldg/R1p9aMxe5ZpUuP349dLF1jFzM5ybSVo9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750839634; c=relaxed/simple;
	bh=Sk+GvlttIV62uPbu+Ct4Ra2hstc2ULQD62m+bFnXLYw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MKbLAgDPe5hpQg3igy/egCnQEKolAUQDSKk5oKechMLwDFou8CHU5TcrHajzR7bZk7E4/AUcui738enp+GHwjjcOqR+UHB6bA0am1QeEsXxS/HudeMzGG45/1PY9HFp9kPd+1GHJAPKQrdUdWMHQk31ZghBFCR0qlZwT0i3A850=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=B1eJDhXf; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=G24Sbemn; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=u2v7kILd; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=BtQjL8pV; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6515E1F441;
	Wed, 25 Jun 2025 08:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1750839630; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tRrlpCYKBr6U/YGWrZ2O+kAYBYYw0QBOzG9di7RcVx8=;
	b=B1eJDhXf4Et9u7oAioiPPifqPCnrw0tVcWKMD4rVC/jP1mF21seEA/4WwpeXA6oDCEbr0n
	KgF0Z09P10ly3GJeeZmReqZCtu645tLwo9jX6PaKn6k12N5tqvBQ7pHHP48KC8G8mQvsP9
	X7EDJVujpmqPW6dINZ0xcxnneMoCykA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1750839630;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tRrlpCYKBr6U/YGWrZ2O+kAYBYYw0QBOzG9di7RcVx8=;
	b=G24Sbemnp1z8K4Jk8kNEhicR7P6y02ABfUkfb8DP3A7UZ49kxqBfH3ilQ8TwUHTva3I27+
	9fZ/aj+XJMNmz+Dw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1750839629; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tRrlpCYKBr6U/YGWrZ2O+kAYBYYw0QBOzG9di7RcVx8=;
	b=u2v7kILdE9PAVYJDccNehqnO9nvodkgljp1BFSe4zUX2S84Cr15YxspIW8NJdMgeTBcWOT
	KpUODa+67TomBfcSopCxatBU+PeZQRFlYLNlwyeZ29vq58liUBjrCYv/6i+5uCkHgeZ1zd
	dMfrxH26YgY3huJk7E1SRHOQeG0VZTc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1750839629;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tRrlpCYKBr6U/YGWrZ2O+kAYBYYw0QBOzG9di7RcVx8=;
	b=BtQjL8pVkqgEv3yBpJ2m3DSUPgqvoPVs7n8mv7OYBEiflMg4n6l86ENjf4haEtIKzCxvR0
	7Y12Aj199qMO/gCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F0FE013301;
	Wed, 25 Jun 2025 08:20:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4HErOEuxW2hDGwAAD6G6ig
	(envelope-from <osalvador@suse.de>); Wed, 25 Jun 2025 08:20:27 +0000
Date: Wed, 25 Jun 2025 10:20:22 +0200
From: Oscar Salvador <osalvador@suse.de>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, nvdimm@lists.linux.dev,
	Andrew Morton <akpm@linux-foundation.org>,
	Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Alistair Popple <apopple@nvidia.com>,
	Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>
Subject: Re: [PATCH RFC 06/14] mm/huge_memory: support huge zero folio in
 vmf_insert_folio_pmd()
Message-ID: <aFuxRv1zYZDjJdYh@localhost.localdomain>
References: <20250617154345.2494405-1-david@redhat.com>
 <20250617154345.2494405-7-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250617154345.2494405-7-david@redhat.com>
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[29];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLhwqoz3wsm4df3nfubx4grhps)];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[localhost.localdomain:mid,imap1.dmz-prg2.suse.org:helo,suse:email]
X-Spam-Level: 

On Tue, Jun 17, 2025 at 05:43:37PM +0200, David Hildenbrand wrote:
> Just like we do for vmf_insert_page_mkwrite() -> ... ->
> insert_page_into_pte_locked(), support the huge zero folio.

It might just be me because I don't have the full context cached, but
I might have appreciated more info here :-).

> 
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Oscar Salvador <osalvador@suse,de>


-- 
Oscar Salvador
SUSE Labs

