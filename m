Return-Path: <linux-fsdevel+bounces-16814-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFFB68A324B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Apr 2024 17:23:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2B881C21501
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Apr 2024 15:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5B10149003;
	Fri, 12 Apr 2024 15:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="dHfLhXt+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="7oESxyKH";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="dHfLhXt+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="7oESxyKH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6120B14883A;
	Fri, 12 Apr 2024 15:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712935334; cv=none; b=UJ3dBWz4Q2h5SMhHurkq1GHW226fKui3NvZFDcdWwVfp+AreCfHgw5VLsuMJxlqhYczR6bxY0xr4JVkt3fzP1lD//pJluXFYkXEmY3Sq5iQW2rQ2j9UZ8VwRE5wK58SLiJ0zEt7hzeW6XnAq29DnIv1HcYL9sqEj+vPF9nT/rzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712935334; c=relaxed/simple;
	bh=BvHPHN8fOa7EW5Y5iMhwD3d+SLjl19jOc6gJ/tU9ku4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pE2zs4jRXS2eB3CS2HCp7s3TaBcs8SHFhLNynb5zFuDsChLU5eUARip+Ta2cnQI4Zw/KKUTi2ZWZCzTy9hT4BUygN2NNxJHdh7Z2c9FivhLHp5YTbEybapbkJp/bDQ6WW1V7SxTUTda+sfLuA5P10MbXnRQfEyivqtDACm5YPWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=dHfLhXt+; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=7oESxyKH; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=dHfLhXt+; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=7oESxyKH; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A8CE338405;
	Fri, 12 Apr 2024 15:22:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1712935328; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IC6E9bO8ytOyXP9Gha3+QfcN0HdacgeeixK9ev2ZVE4=;
	b=dHfLhXt+oafE8lHfYHjX6le7winvuajKwY05JhjjVbNfZCkhHc9ZKQ0RJvCbA+dWjvBNw3
	LPvedgvHiGpR464a2sQUo7rILDyyOq95ZAFaYuJesGafOpuRDIM51OTUW8/mzTq365buJa
	P9IIQknnm088ShJgoRrO142ub13XIF4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1712935328;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IC6E9bO8ytOyXP9Gha3+QfcN0HdacgeeixK9ev2ZVE4=;
	b=7oESxyKH6MgNpHewLYE5ihQlUjAOKGGynQJ/OGqt3k0zupKvXDFBOmtcf185gBClkKbm4U
	P86WYmrj8CAfDoCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1712935328; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IC6E9bO8ytOyXP9Gha3+QfcN0HdacgeeixK9ev2ZVE4=;
	b=dHfLhXt+oafE8lHfYHjX6le7winvuajKwY05JhjjVbNfZCkhHc9ZKQ0RJvCbA+dWjvBNw3
	LPvedgvHiGpR464a2sQUo7rILDyyOq95ZAFaYuJesGafOpuRDIM51OTUW8/mzTq365buJa
	P9IIQknnm088ShJgoRrO142ub13XIF4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1712935328;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IC6E9bO8ytOyXP9Gha3+QfcN0HdacgeeixK9ev2ZVE4=;
	b=7oESxyKH6MgNpHewLYE5ihQlUjAOKGGynQJ/OGqt3k0zupKvXDFBOmtcf185gBClkKbm4U
	P86WYmrj8CAfDoCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 977D01377F;
	Fri, 12 Apr 2024 15:22:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qVT4JKBRGWa1BAAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 12 Apr 2024 15:22:08 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 2B0A8A071E; Fri, 12 Apr 2024 17:22:08 +0200 (CEST)
Date: Fri, 12 Apr 2024 17:22:08 +0200
From: Jan Kara <jack@suse.cz>
To: Alistair Popple <apopple@nvidia.com>
Cc: linux-mm@kvack.org, david@fromorbit.com, dan.j.williams@intel.com,
	jhubbard@nvidia.com, rcampbell@nvidia.com, willy@infradead.org,
	jgg@nvidia.com, linux-fsdevel@vger.kernel.org, jack@suse.cz,
	djwong@kernel.org, hch@lst.de, david@redhat.com,
	ruansy.fnst@fujitsu.com, nvdimm@lists.linux.dev,
	linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
	jglisse@redhat.com
Subject: Re: [RFC 04/10] fs/dax: Don't track page mapping/index
Message-ID: <20240412152208.m25mjo3xjfyawcaj@quack3>
References: <cover.fe275e9819458a4bbb9451b888cafb88af8867d4.1712796818.git-series.apopple@nvidia.com>
 <322065d373bb6571b700dba4450f1759b304644a.1712796818.git-series.apopple@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <322065d373bb6571b700dba4450f1759b304644a.1712796818.git-series.apopple@nvidia.com>
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,nvidia.com:email]

On Thu 11-04-24 10:57:25, Alistair Popple wrote:
> The page->mapping and page->index fields are normally used by the
> pagecache and rmap for looking up virtual mappings of pages. FS DAX
> implements it's own kind of page cache and rmap look ups so these
> fields are unnecessary. They are currently only used to detect
> error/warning conditions which should never occur.
> 
> A future change will change the way shared mappings are detected by
> doing normal page reference counting instead, so remove the
> unnecessary checks.
> 
> Signed-off-by: Alistair Popple <apopple@nvidia.com>
...
> -/*
> - * When it is called in dax_insert_entry(), the shared flag will indicate that
> - * whether this entry is shared by multiple files.  If so, set the page->mapping
> - * PAGE_MAPPING_DAX_SHARED, and use page->share as refcount.
> - */
> -static void dax_associate_entry(void *entry, struct address_space *mapping,
> -		struct vm_area_struct *vma, unsigned long address, bool shared)
> -{
> -	unsigned long size = dax_entry_size(entry), pfn, index;
> -	int i = 0;
> -
> -	if (IS_ENABLED(CONFIG_FS_DAX_LIMITED))
> -		return;
> -
> -	index = linear_page_index(vma, address & ~(size - 1));
> -	for_each_mapped_pfn(entry, pfn) {
> -		struct page *page = pfn_to_page(pfn);
> -
> -		if (shared) {
> -			dax_page_share_get(page);
> -		} else {
> -			WARN_ON_ONCE(page->mapping);
> -			page->mapping = mapping;
> -			page->index = index + i++;
> -		}
> -	}
> -}

Hum, but what about existing uses of folio->mapping and folio->index in
fs/dax.c? AFAICT this patch breaks them. What am I missing? How can this
ever work?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

