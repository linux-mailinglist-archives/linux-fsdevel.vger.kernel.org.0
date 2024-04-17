Return-Path: <linux-fsdevel+bounces-17127-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8911E8A832F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 14:31:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18B771F2295F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 12:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5096A7D071;
	Wed, 17 Apr 2024 12:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="1iD43Ece";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="PnkGW4IO";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="1iD43Ece";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="PnkGW4IO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4542B339A0;
	Wed, 17 Apr 2024 12:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713357107; cv=none; b=GzPgIkdwPA1IZ17UUzWQ9Qxku6nMPGxZC/2qh1oJVz9zNtyMtrw/LnuvvWhVrWAKkHBUt8uHYn32v2SsDcPYNAS8vBgF76bdQoxYWFIg+YpgDp914KNgBhbcgTL+8jnouTCuX3OuVaBv2uOkgSAS2dgExcaj5K5fPV8/lfTXMX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713357107; c=relaxed/simple;
	bh=rXUcUq9+KUqvE6a58BxJUPvJs1UlmFH6ez+k9PbJlXI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mAOqNZqf491RnzeIObOJg0TLyRWPIhXbdGQiUeuh6zLqxLjLvuC8ZxMcmpHb6xFa2tgDOGH/PfE29EczD4gjP9dCoDDgt5yw3oMhw8xCUNQR61zJJfg+ifT+VeHD/GyNqd2yVdz4xiGAQTU6juDuV24YX8gESDMpzSecRCzdzic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=1iD43Ece; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=PnkGW4IO; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=1iD43Ece; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=PnkGW4IO; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3F6DD33C42;
	Wed, 17 Apr 2024 12:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713357104; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5L4Cpqhji1dUxreeRJmUVcGAtVBWN1z//jlv1xmcGEE=;
	b=1iD43EceviFz+KY05gM4FjqkaP3J7tV1tRqKcpl/FycpA1bIkaqvRUxh83HFXUkkEYABzn
	2Zq/qzk2EH4AHjBtNpK0owv7BUHuogUVIhcbQDwjW1eiGvmRoRilM3pYrfRKANt/U7UEFg
	FiIPUq6AmWzsc4FAgOBCFn80ucxCjjY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713357104;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5L4Cpqhji1dUxreeRJmUVcGAtVBWN1z//jlv1xmcGEE=;
	b=PnkGW4IOEXnDPviFaQWfyO2xr8qX1ttY0BiMCF6uvBFlGEAPhVfeLqKFJWQglXNi7HSt2n
	QKsuL4AofQJ2h+AQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=1iD43Ece;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=PnkGW4IO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713357104; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5L4Cpqhji1dUxreeRJmUVcGAtVBWN1z//jlv1xmcGEE=;
	b=1iD43EceviFz+KY05gM4FjqkaP3J7tV1tRqKcpl/FycpA1bIkaqvRUxh83HFXUkkEYABzn
	2Zq/qzk2EH4AHjBtNpK0owv7BUHuogUVIhcbQDwjW1eiGvmRoRilM3pYrfRKANt/U7UEFg
	FiIPUq6AmWzsc4FAgOBCFn80ucxCjjY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713357104;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5L4Cpqhji1dUxreeRJmUVcGAtVBWN1z//jlv1xmcGEE=;
	b=PnkGW4IOEXnDPviFaQWfyO2xr8qX1ttY0BiMCF6uvBFlGEAPhVfeLqKFJWQglXNi7HSt2n
	QKsuL4AofQJ2h+AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D846A1384C;
	Wed, 17 Apr 2024 12:31:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id j187Mi/BH2bKHgAAD6G6ig
	(envelope-from <osalvador@suse.de>); Wed, 17 Apr 2024 12:31:43 +0000
Date: Wed, 17 Apr 2024 14:31:38 +0200
From: Oscar Salvador <osalvador@suse.de>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Muchun Song <muchun.song@linux.dev>
Subject: Re: [PATCH v1 2/2] fs/proc/task_mmu: convert smaps_hugetlb_range()
 to work on folios
Message-ID: <Zh_BKoUNK0uKJF8r@localhost.localdomain>
References: <20240417092313.753919-1-david@redhat.com>
 <20240417092313.753919-3-david@redhat.com>
 <Zh-7_0hDIZKWSDNB@localhost.localdomain>
 <209b1956-a46f-41aa-bec1-cd65484f36cd@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <209b1956-a46f-41aa-bec1-cd65484f36cd@redhat.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 3F6DD33C42
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -4.51

On Wed, Apr 17, 2024 at 02:18:10PM +0200, David Hildenbrand wrote:
> On 17.04.24 14:09, Oscar Salvador wrote:
> > On Wed, Apr 17, 2024 at 11:23:13AM +0200, David Hildenbrand wrote:
> > > Let's get rid of another page_mapcount() check and simply use
> > > folio_likely_mapped_shared(), which is precise for hugetlb folios.
> > > 
> > > While at it, use huge_ptep_get() + pte_page() instead of ptep_get() +
> > > vm_normal_page(), just like we do in pagemap_hugetlb_range().
> > 
> > That is fine because vm_normal_page() tries to be clever about  mappings which
> > hugetlb does not support, right?
> 
> Right, using vm_normal_page() is even completely bogus. Usually (but not
> always) we have PMDs/PUDs and not PTEs for mapping hugetlb pages -- where
> vm_normal_folio_pmd() would be the right thing to do.
> 
> That's also the reason why hugetlb.c has not a single user of
> vm_normal_page() and friends ... it doesn't apply to hugetlb, but likely
> also isn't currently harmful to use it.

I guess not because we skip the special handling, but I agree that
replacing it is the right thing to do.
Thanks for explaining!
 

-- 
Oscar Salvador
SUSE Labs

