Return-Path: <linux-fsdevel+bounces-21309-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D25F7901A15
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Jun 2024 06:51:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4D64282029
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Jun 2024 04:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3367BDDB8;
	Mon, 10 Jun 2024 04:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="MneOOx+1";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Dpbhr+aJ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="MneOOx+1";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Dpbhr+aJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7E01876;
	Mon, 10 Jun 2024 04:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717995082; cv=none; b=WyXODHIn0qGvezVwC9I5tCN/PFjeK01vR7aqD6btmeHH+j6QjbaSTmhoYwxvRdhDlvOo8YC3w2ySfcqEMrfk0Ob5dECXpnoQhhvGn9ILv5QM+1tPESJfotH1c0+Y/lrYgtKGd9idVtF47lSC91+gYK4znDSotnmWx/+7kocUymY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717995082; c=relaxed/simple;
	bh=7qKPtaal4QnVDHVSx+pi8mWVmic8iCOzD3fxUS1BCcY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XMlJ+GvveqH3td6iBXefEEud0ATgSSLo984V6rMykVrYYbKerk5iBDk9DvHEZ7+wAFiN14kxo6A0nEa5codf/w4Xi0TJHePUSidSy5dUX5tAmqABqsKwzSmcj63Y5guA0HYXyKQ3r9LB8ZM0V8HYvBhuLS8yq0Rr7W4XVJfv0xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=MneOOx+1; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Dpbhr+aJ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=MneOOx+1; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Dpbhr+aJ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 38A28219BD;
	Mon, 10 Jun 2024 04:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1717995079; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Vn3iqBiy78yK0GTRpos/+icWPZatVJQ3vhkUe1A4EWM=;
	b=MneOOx+1gNcO52wjHjbtfvSOIFd2eLO7f0JeCEkn1WWeCMuHu97X5WFutxD1M7GMvOHS/9
	xyURXfjcjF4O/mvjDZLul8gh64AOhEI28Tg3mXu1XRpC5xnFo8Zn1J4UYpILXq8qVk8Pek
	+5NVhqSi6QGN449xlVKByUM90ju7NcQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1717995079;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Vn3iqBiy78yK0GTRpos/+icWPZatVJQ3vhkUe1A4EWM=;
	b=Dpbhr+aJgsRfAZ0eTMD/fBth3eN8Oab5culOdlnVfX4aZrhAvBbfqxmyksY6dBKf7CJKCD
	MamWDYGzf1wknrDw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=MneOOx+1;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Dpbhr+aJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1717995079; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Vn3iqBiy78yK0GTRpos/+icWPZatVJQ3vhkUe1A4EWM=;
	b=MneOOx+1gNcO52wjHjbtfvSOIFd2eLO7f0JeCEkn1WWeCMuHu97X5WFutxD1M7GMvOHS/9
	xyURXfjcjF4O/mvjDZLul8gh64AOhEI28Tg3mXu1XRpC5xnFo8Zn1J4UYpILXq8qVk8Pek
	+5NVhqSi6QGN449xlVKByUM90ju7NcQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1717995079;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Vn3iqBiy78yK0GTRpos/+icWPZatVJQ3vhkUe1A4EWM=;
	b=Dpbhr+aJgsRfAZ0eTMD/fBth3eN8Oab5culOdlnVfX4aZrhAvBbfqxmyksY6dBKf7CJKCD
	MamWDYGzf1wknrDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BD45913A7F;
	Mon, 10 Jun 2024 04:51:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id miCHK0aGZmbIHAAAD6G6ig
	(envelope-from <osalvador@suse.de>); Mon, 10 Jun 2024 04:51:18 +0000
Date: Mon, 10 Jun 2024 06:51:09 +0200
From: Oscar Salvador <osalvador@suse.de>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH v1 3/6] fs/proc/task_mmu: properly detect
 PM_MMAP_EXCLUSIVE per page of PMD-mapped THPs
Message-ID: <ZmaGPfSsJ1tguUry@localhost.localdomain>
References: <20240607122357.115423-1-david@redhat.com>
 <20240607122357.115423-4-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240607122357.115423-4-david@redhat.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 38A28219BD
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -4.51

On Fri, Jun 07, 2024 at 02:23:54PM +0200, David Hildenbrand wrote:
> We added PM_MMAP_EXCLUSIVE in 2015 via commit 77bb499bb60f ("pagemap: add
> mmap-exclusive bit for marking pages mapped only here"), when THPs could
> not be partially mapped and page_mapcount() returned something
> that was true for all pages of the THP.
> 
> In 2016, we added support for partially mapping THPs via
> commit 53f9263baba6 ("mm: rework mapcount accounting to enable 4k mapping
> of THPs") but missed to determine PM_MMAP_EXCLUSIVE as well per page.
> 
> Checking page_mapcount() on the head page does not tell the whole story.
> 
> We should check each individual page. In a future without per-page
> mapcounts it will be different, but we'll change that to be consistent
> with PTE-mapped THPs once we deal with that.
> 
> Fixes: 53f9263baba6 ("mm: rework mapcount accounting to enable 4k mapping of THPs")
> Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Oscar Salvador <osalvador@suse.de>

-- 
Oscar Salvador
SUSE Labs

