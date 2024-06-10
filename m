Return-Path: <linux-fsdevel+bounces-21307-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53CFC9019CF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Jun 2024 06:39:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82E0DB213B5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Jun 2024 04:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97675B67F;
	Mon, 10 Jun 2024 04:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="saXPWnjG";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="DqCF0EH5";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="OHUb2VpQ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="GzK8PFnJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E5F56FB6;
	Mon, 10 Jun 2024 04:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717994328; cv=none; b=eCZv8ERO2PyclHA61GCyiAKnq3K5rj1lgYwAL/tB3R1ugjSy92j5I+LcufOYWsIRI0gvGzSVXnpPUsf6uOBTvWBvdSn5FJKVJSgOyjL1VtSTrNlexh/Oez0l9g1A1REw3UtRzbLfM7kh2wVJHbTIm3Clbdol+sU2e+F/wil5IAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717994328; c=relaxed/simple;
	bh=AJ+Wru5ybSpKxohsJxOE4zcTMQHNP41mGIe7OS2Kx08=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oIay8HsF9HRF+9p676onU8Np2aF7sOddKe2ocYx78AuMk6Y3fivA0kM0MOdghQs/RlpwUIPTIqlcVa00/CjHX/+hQOI2aD+rNRUdW6Hgbdbgsa7VrB63Z8QZemtWizfQkwd+NlBlhqzW2UN55vB5o/us7dqgGQuiEro9AwcV5P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=saXPWnjG; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=DqCF0EH5; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=OHUb2VpQ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=GzK8PFnJ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8AE111F78E;
	Mon, 10 Jun 2024 04:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1717994324; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=44b65Qtx0GUTMeu+t5DPRyJLh8bwKaMPwRjjHIXsQdA=;
	b=saXPWnjGLY4bdAYRAIIE0yvQCij4VXUKetGnoIweu6/V47hvPxSqp0CW4rQLAy85lJiFeg
	1QZR2WyLVKyqtr/yUhIgj8NzhX2B0JUSikLILnYiODF2j+VJodwinaBU52bGdHwaLIvrA5
	KolVIUGuBdMDfYE6BIsseB9BXaAEZU0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1717994324;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=44b65Qtx0GUTMeu+t5DPRyJLh8bwKaMPwRjjHIXsQdA=;
	b=DqCF0EH51a7wumTthdIJHmvilIjSX8R9ANElBhwfxIE58c7pSTL4E6g6Z+o/w7+jKGezAY
	sjdqM5sjnG8EJqDg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=OHUb2VpQ;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=GzK8PFnJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1717994323; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=44b65Qtx0GUTMeu+t5DPRyJLh8bwKaMPwRjjHIXsQdA=;
	b=OHUb2VpQqzV3DOig5EL5GAjJ1sj9rcVhIDSYTigtAtA8TcGfYE3ytCn5F8deNIhV03H6lJ
	132K39rowPVrXWIPUT21hVzcUAZKudT5Jg4YbfmwMIfszsrJou7oIIwI3skSCnLwTrR/s1
	ljDaKFDlvU1kQngYEkubOJHRvJlREqs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1717994323;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=44b65Qtx0GUTMeu+t5DPRyJLh8bwKaMPwRjjHIXsQdA=;
	b=GzK8PFnJYqXsQPfLZrTpZvRUNb/l3CAWomGSm8IGphAJnn4Y4KImH9ioZQxXIpcUwhTonG
	mfwwm/Vpj+LInNAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 20EAA13A7F;
	Mon, 10 Jun 2024 04:38:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id iLK2BFODZmYoGgAAD6G6ig
	(envelope-from <osalvador@suse.de>); Mon, 10 Jun 2024 04:38:43 +0000
Date: Mon, 10 Jun 2024 06:38:33 +0200
From: Oscar Salvador <osalvador@suse.de>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v1 2/6] fs/proc/task_mmu: don't indicate
 PM_MMAP_EXCLUSIVE without PM_PRESENT
Message-ID: <ZmaDSQZlAl7Jb-wi@localhost.localdomain>
References: <20240607122357.115423-1-david@redhat.com>
 <20240607122357.115423-3-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240607122357.115423-3-david@redhat.com>
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 8AE111F78E
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
	DKIM_TRACE(0.00)[suse.de:+]

On Fri, Jun 07, 2024 at 02:23:53PM +0200, David Hildenbrand wrote:
> Relying on the mapcount for non-present PTEs that reference pages
> doesn't make any sense: they are not accounted in the mapcount, so
> page_mapcount() == 1 won't return the result we actually want to know.
> 
> While we don't check the mapcount for migration entries already, we
> could end up checking it for swap, hwpoison, device exclusive, ...
> entries, which we really shouldn't.
> 
> There is one exception: device private entries, which we consider
> fake-present (e.g., incremented the mapcount). But we won't care about
> that for now for PM_MMAP_EXCLUSIVE, because indicating PM_SWAP for them
> although they are fake-present already sounds suspiciously wrong.
> 
> Let's never indicate PM_MMAP_EXCLUSIVE without PM_PRESENT.

Alternatively we could use is_pfn_swap_entry?
But the PM_PRESENT approach seems more correct.

> Signed-off-by: David Hildenbrand <david@redhat.com>

Signed-off-by: Oscar Salvador <osalvador@suse.de>

-- 
Oscar Salvador
SUSE Labs

