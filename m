Return-Path: <linux-fsdevel+bounces-54068-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC7C8AFAE61
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 10:16:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A8F43A1EF3
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 08:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B968128A1FB;
	Mon,  7 Jul 2025 08:16:22 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B661DDC2A
	for <linux-fsdevel@vger.kernel.org>; Mon,  7 Jul 2025 08:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751876182; cv=none; b=C9OXK3iIWp/BYH3+Sxl2PTBXceKblR4+F8gzsMtA3QIvr2HBFmT7NwTh3mrYQiBUjlGuQ1aNVv546A9VS/Viu6CNrZon+IHLnIa8h243Tlnx7tHCfuP08vX0vpg4zdlRrfxf+7qe7BBKTK2lLoOklri8HCIOXMsyyhH6zrfczRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751876182; c=relaxed/simple;
	bh=XUSiHXeAqft3KWjBwWsENIyb3v/gq+2wG2azJgaM9vU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j9ehg4NY9IEE5U6CJgbuJS1B7rPMVPdmg1wOhJUK+SuN96zPk0KzhU8K/tB4FjUcq9zUDuBzXXU3TXlYjCfqomfa/t0VGY/hPdY+KskDbSLO5Vp8MEpzwgo0qCDtBez/C++ZQjlhFSxMJeqDoBG7ek5LAZKL3AST+FxsoqbRgbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2E26D2116B;
	Mon,  7 Jul 2025 08:16:19 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1C96613757;
	Mon,  7 Jul 2025 08:16:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id DG/2BlOCa2jaLwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 07 Jul 2025 08:16:19 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id B292EA0992; Mon,  7 Jul 2025 10:16:18 +0200 (CEST)
Date: Mon, 7 Jul 2025 10:16:18 +0200
From: Jan Kara <jack@suse.cz>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: Jan Kara <jack@suse.cz>, Naresh Kamboju <naresh.kamboju@linaro.org>, 
	Theodore Ts'o <tytso@mit.edu>, linux-ext4 <linux-ext4@vger.kernel.org>, 
	linux-fsdevel@vger.kernel.org, open list <linux-kernel@vger.kernel.org>, 
	lkft-triage@lists.linaro.org, Linux Regressions <regressions@lists.linux.dev>, 
	LTP List <ltp@lists.linux.it>, Anders Roxell <anders.roxell@linaro.org>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Arnd Bergmann <arnd@arndb.de>
Subject: Re: next-20250626: WARNING fs jbd2 transaction.c start_this_handle
 with ARM64_64K_PAGES
Message-ID: <mfx57o5lsxdkjpd3kq2y7ozkfu4rgr6zugdsnyqlhktwuh4dmw@7ldfhzgozaoo>
References: <CA+G9fYsyYQ3ZL4xaSg1-Tt5Evto7Zd+hgNWZEa9cQLbahA1+xg@mail.gmail.com>
 <2dbc199b-ef22-4c22-9dbd-5e5876e9f9b4@huaweicloud.com>
 <CA+G9fYv5zpLxeVLqYbDLLUOxmAzuXDbaZobvpCBBBuZJKLMpPQ@mail.gmail.com>
 <1c7ae5cb-61ad-404c-950a-ba1b5895e6c3@huaweicloud.com>
 <c2dvcablaximwjnwg67spegwkntxjgezu6prvyyto4vjnx6rvh@w3xgx4jjq4bb>
 <021aad1d-61ba-484f-88d1-9a482707ff94@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <021aad1d-61ba-484f-88d1-9a482707ff94@huaweicloud.com>
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Level: 
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 2E26D2116B
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.00

On Mon 07-07-25 12:54:56, Zhang Yi wrote:
> On 2025/7/4 19:17, Jan Kara wrote:
> > I wouldn't really disable it for 64K page size. I'd rather limit max folio
> > order to 1024 blocks. That actually makes sense as a general limitation of
> > our current implementation (linked lists of bhs in each folio don't really
> > scale). We can use mapping_set_folio_order_range() for that instead of
> > mapping_set_large_folios().
> > 
> 
> Indeed, after noticing that Btrfs also calls mapping_set_folio_order_range()
> to set the maximum size of a folio, I thought this solution should work. So
> I changed my mind and was going to try this solution. However, I guess limit
> max folio order to 1024 blocks is somewhat too small. I'd like to limit the
> order to 2048 blocks, because this this allows a file system with a 1KB
> block size to achieve a maximum folio size to PMD size in x86 with a 4KB
> page size, this is useful for increase the TLB efficiency and reduce page
> fault handling overhead.

OK. In my opinion whoever runs with 1k blocksize doesn't really care about
performance too much and thus is unlikely to care about getting 2M pages
:). But whatever, the limit of 2048 blocks is fine by me.

> I defined a new macro, something like this:
> 
> /*
>  * Limit the maximum folio order to 2048 blocks to prevent overestimation
>  * of reserve handle credits during the folio writeback in environments
>  * where the PAGE_SIZE exceeds 4KB.
>  */
> #define EXT4_MAX_PAGECACHE_ORDER(i)             \
>                 min(MAX_PAGECACHE_ORDER, (11 + (i)->i_blkbits - PAGE_SIZE))
								  ^^^ PAGE_SHIFT

Otherwise looks good to me.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

