Return-Path: <linux-fsdevel+bounces-17124-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 296848A82D7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 14:09:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A66521F21D0C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 12:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9C0113D24E;
	Wed, 17 Apr 2024 12:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="vlS4lE2K";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="TlHCqslP";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="vlS4lE2K";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="TlHCqslP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A99AD48;
	Wed, 17 Apr 2024 12:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713355785; cv=none; b=nJIk8uo1DHpw05zl/4lhZc1wKdNQha86GvX1WsBa3Pc+EHV/V44U/bVtsYU+7zFzqIjW4SwlLV4+conq/0L6/kXPYi89UIlMKmhEGrHNf6/l2zxRoixooxgPdQud8U4xGI6Nnt4P/sB/XE4btn7s70IUsyF+IwDW8IF9Z4eiWYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713355785; c=relaxed/simple;
	bh=NURdGll+5FSpwk1SEAsneUdAjwr5/KUKesseqUS7NUs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M4qgh7EzbAyvVVl3yHqoww9g+hUKOAL/l/vbNQsqPJJ+KXGIgw5DOnakdDcp+74Zvrf4T6x7X23oeHxYFf1jqceXYMiCBSZ6tAJbjLuV+w+CTP1i0D7NnlmBGmdhfTQF+SZd5G4WoqGM82VjrU2+zBppDiPxb34PsGlk5jlrUE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=vlS4lE2K; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=TlHCqslP; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=vlS4lE2K; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=TlHCqslP; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 921BD33BEF;
	Wed, 17 Apr 2024 12:09:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713355781; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pptNZkp6pulHR22seSGYcg9eKyjdPLVEknH5lx1MXtM=;
	b=vlS4lE2K50ZRnqElpinbQQmEi7VsBGX9ADnqHneRMb3ynjpIqc74nHqzeaz4AIJVoa+3Qp
	WKcdzen2+/Q2voEUyvdL4btbCTyBWGp8U5IbY60BglkL/6Y/9DbY3hN6WNLFxNggbpf5jf
	MPQPQMlvPiKSsVsDLYrOYV2beuCBxYk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713355781;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pptNZkp6pulHR22seSGYcg9eKyjdPLVEknH5lx1MXtM=;
	b=TlHCqslPtkNWjfuS+9gquddFq25t0Z2mrXdxzo0a7THgMEKtodZ15JUl2VoW/ScjzJi+VQ
	ZnrVqPqgEchxMFDw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=vlS4lE2K;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=TlHCqslP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713355781; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pptNZkp6pulHR22seSGYcg9eKyjdPLVEknH5lx1MXtM=;
	b=vlS4lE2K50ZRnqElpinbQQmEi7VsBGX9ADnqHneRMb3ynjpIqc74nHqzeaz4AIJVoa+3Qp
	WKcdzen2+/Q2voEUyvdL4btbCTyBWGp8U5IbY60BglkL/6Y/9DbY3hN6WNLFxNggbpf5jf
	MPQPQMlvPiKSsVsDLYrOYV2beuCBxYk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713355781;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pptNZkp6pulHR22seSGYcg9eKyjdPLVEknH5lx1MXtM=;
	b=TlHCqslPtkNWjfuS+9gquddFq25t0Z2mrXdxzo0a7THgMEKtodZ15JUl2VoW/ScjzJi+VQ
	ZnrVqPqgEchxMFDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3295613957;
	Wed, 17 Apr 2024 12:09:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id talVCQW8H2aRFgAAD6G6ig
	(envelope-from <osalvador@suse.de>); Wed, 17 Apr 2024 12:09:41 +0000
Date: Wed, 17 Apr 2024 14:09:35 +0200
From: Oscar Salvador <osalvador@suse.de>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Muchun Song <muchun.song@linux.dev>
Subject: Re: [PATCH v1 2/2] fs/proc/task_mmu: convert smaps_hugetlb_range()
 to work on folios
Message-ID: <Zh-7_0hDIZKWSDNB@localhost.localdomain>
References: <20240417092313.753919-1-david@redhat.com>
 <20240417092313.753919-3-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240417092313.753919-3-david@redhat.com>
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 921BD33BEF
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
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
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:email];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]

On Wed, Apr 17, 2024 at 11:23:13AM +0200, David Hildenbrand wrote:
> Let's get rid of another page_mapcount() check and simply use
> folio_likely_mapped_shared(), which is precise for hugetlb folios.
> 
> While at it, use huge_ptep_get() + pte_page() instead of ptep_get() +
> vm_normal_page(), just like we do in pagemap_hugetlb_range().

That is fine because vm_normal_page() tries to be clever about  mappings which
hugetlb does not support, right?

> 
> No functional change intended.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Oscar Salvador <osalvador@suse.de>


-- 
Oscar Salvador
SUSE Labs

