Return-Path: <linux-fsdevel+bounces-76048-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GJTeODexgGn6AQMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76048-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Feb 2026 15:14:15 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C2C2CD382
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Feb 2026 15:14:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0D25E30254CE
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Feb 2026 14:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5E4436B04D;
	Mon,  2 Feb 2026 14:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Vuf9nYmW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1694B14F70;
	Mon,  2 Feb 2026 14:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770041651; cv=none; b=aUmXltmFAc6YhC4WdmbLg8Qv4MIqS/ECI96nL0du58B1T0Nzw1IZoGNfKeLXg9WT1nYBMGSprTXBkLoMLD1fx846L3Wq3Fltcjj/RnbLKEAFeHTsCNwiNk/QgkyVXc7ZYGEagKRLYep3tHdSzOtM+5fS72Nhgnb20KPp8EwCE2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770041651; c=relaxed/simple;
	bh=JqKUl60vf2mk2q6WHXRfrQSgpfjh0GgY9vftFLodTqw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W6rFg5ptkSJcFLRUt5qP4ty6rYWgK/ck5rVSva+JNVp/t3yUqK8xafvxSTkGGADJylwb7fPCg8Nn5EsUoaaO3zlRGwz4taXn9q9ByYUXH3PgbLJEevR1GSux08uDNpEjFiHIOHK2ZwUhXbFK2njsa2Qtu27EGxw0IdxYBh3SSw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Vuf9nYmW; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=wAc1k4+zJsRHlPOaEXkpUDHcRc6VbrRi9Rvm6Gsx3+s=; b=Vuf9nYmW73DOvW4W1bCFO/Hxhf
	uedDfAw5PpTFnap8ZcF5G1fMOqOe2VE3qvN/KvhNd6cK/1iX33t9qDefGu5dtybDwg6SHc/mTsaQ3
	4pfJ7q7Q7UW/Fqy7tYwfS+di3ywvNLV6d4u27oBErXywciqNsEyG6fUzAxxvO/DPTJKAQQhnfbGdQ
	4XAG22Ps8Iq9rSuz7NqYPvMUDTfjmzZ2ZNqT89ksZxR5D2Mda66892y7vk+/5MOUllpHQhIGQ/Zbb
	I3M46ENR0WVdvoH/48JMvhlIsSh2JE8qpY1GgUH9yrSJOD8h21d48T4MMyRVu5NO597BRMa2BcCMK
	Xt9iQZtQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vmugo-0000000Gb0L-1joD;
	Mon, 02 Feb 2026 14:14:06 +0000
Date: Mon, 2 Feb 2026 14:14:06 +0000
From: Matthew Wilcox <willy@infradead.org>
To: =?utf-8?B?5p2O6b6Z5YW0?= <coregee2000@gmail.com>
Cc: syzkaller@googlegroups.com, akpm@linux-foundation.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [Kernel Bug] KASAN: slab-use-after-free Read in
 filemap_free_folio
Message-ID: <aYCxLsCVUT_kky4o@casper.infradead.org>
References: <CAHPqNmyHRaGj0fn+2FvvaJYi4WYOVmai6XX3bRCwbAZoj_GwWg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHPqNmyHRaGj0fn+2FvvaJYi4WYOVmai6XX3bRCwbAZoj_GwWg@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=casper.20170209];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-76048-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[infradead.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willy@infradead.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:dkim,casper.infradead.org:mid]
X-Rspamd-Queue-Id: 5C2C2CD382
X-Rspamd-Action: no action

On Mon, Feb 02, 2026 at 02:20:50PM +0800, 李龙兴 wrote:
> Dear Linux kernel developers and maintainers,
> 
> We would like to report a new kernel bug found by our tool. KASAN:

Don't be syzbot.  Get your changes into syzkaller upstream and let
syzbot do its thing.

> Allocated by task 49607:
>  kasan_save_stack+0x33/0x60 mm/kasan/common.c:56
>  kasan_save_track+0x14/0x30 mm/kasan/common.c:77
>  unpoison_slab_object mm/kasan/common.c:342 [inline]
>  __kasan_slab_alloc+0x89/0x90 mm/kasan/common.c:368
>  kasan_slab_alloc include/linux/kasan.h:252 [inline]
>  slab_post_alloc_hook mm/slub.c:4978 [inline]
>  slab_alloc_node mm/slub.c:5288 [inline]
>  kmem_cache_alloc_lru_noprof+0x254/0x6e0 mm/slub.c:5307
>  ext4_alloc_inode+0x28/0x610 fs/ext4/super.c:1393

I'd suggest this is an ext4 problem, not a pagecache problem.

syzbot has good heuristics for this kind of thing now.  You don't.

