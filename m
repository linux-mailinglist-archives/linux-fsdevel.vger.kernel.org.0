Return-Path: <linux-fsdevel+bounces-17118-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C49608A80D4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 12:23:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 811B72874EC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 10:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC34213C9B2;
	Wed, 17 Apr 2024 10:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="d+OxPeNv";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="qYsTlNEr";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="d+OxPeNv";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="qYsTlNEr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E7613BC3E;
	Wed, 17 Apr 2024 10:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713349285; cv=none; b=BMf+KEP1xl+90ii2/vwslnHiAoRWbie+GXIxyyxOnWvRRpzoppfyNrP+O+WOGaUsIP8MoFhRYAlMh2KTgY89XalfM7aKhXCoNosDz+zj3N7othASEXZHZJJ1evP23hbwWJf8OLwj3zV01Syavfh2m3/qYG+JtHt9iZuEzTHk7tY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713349285; c=relaxed/simple;
	bh=MIuiJiecMNYop1J5gyfn17kW3mM6Q47w9aU6e2zL69Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aokYbtTEF6H+ng8W05nr/sdlM1qA1QUQfLh4Er/yf8wOZXwAEw7XXroTXaUgaIvClbhbuLjYmXwAgtLshoHlebWudRblf/e/w0n+wAPf1k4T95eO3PrNqw0lj5n5ypVJrYb98oby76+xKrn/FOBpFJKx0AQv79kAYgPVivZlK4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=d+OxPeNv; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=qYsTlNEr; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=d+OxPeNv; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=qYsTlNEr; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A62ED33AE8;
	Wed, 17 Apr 2024 10:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713349275; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fh/JsAx365b5+9LhCKoSfw3empGDkEaoXILqTfsoTCk=;
	b=d+OxPeNvL9YZMckUpJ0g7mpky2kuucuY0AHSf+tnU7LMVcSFi3BNZYTuRv5xAE8Y3S0DPZ
	/B9XizzXL43tJPuukB/oJdSIdC1GRmUA43BPEtIuMrddLMIIgY0SqDMnPU4EjqSJPZjjo7
	Xo4Ghgcls8EmtbRCoE0BsTMce50IQco=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713349275;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fh/JsAx365b5+9LhCKoSfw3empGDkEaoXILqTfsoTCk=;
	b=qYsTlNEr0szT8LVQsX4hafElClV5lnrbsMjMbFD7CsWOZ6ZmYNhkp1jGoNA1St2DEoueVm
	JOdgAIM37OF31WBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713349275; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fh/JsAx365b5+9LhCKoSfw3empGDkEaoXILqTfsoTCk=;
	b=d+OxPeNvL9YZMckUpJ0g7mpky2kuucuY0AHSf+tnU7LMVcSFi3BNZYTuRv5xAE8Y3S0DPZ
	/B9XizzXL43tJPuukB/oJdSIdC1GRmUA43BPEtIuMrddLMIIgY0SqDMnPU4EjqSJPZjjo7
	Xo4Ghgcls8EmtbRCoE0BsTMce50IQco=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713349275;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fh/JsAx365b5+9LhCKoSfw3empGDkEaoXILqTfsoTCk=;
	b=qYsTlNEr0szT8LVQsX4hafElClV5lnrbsMjMbFD7CsWOZ6ZmYNhkp1jGoNA1St2DEoueVm
	JOdgAIM37OF31WBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C569B1384C;
	Wed, 17 Apr 2024 10:21:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kadzKJqiH2bVawAAD6G6ig
	(envelope-from <osalvador@suse.de>); Wed, 17 Apr 2024 10:21:14 +0000
Date: Wed, 17 Apr 2024 12:21:12 +0200
From: Oscar Salvador <osalvador@suse.de>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Muchun Song <muchun.song@linux.dev>
Subject: Re: [PATCH v1 1/2] fs/proc/task_mmu: convert pagemap_hugetlb_range()
 to work on folios
Message-ID: <Zh-imMfMzCEgD1Ao@localhost.localdomain>
References: <20240417092313.753919-1-david@redhat.com>
 <20240417092313.753919-2-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240417092313.753919-2-david@redhat.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:email]
X-Spam-Score: -4.30
X-Spam-Flag: NO

On Wed, Apr 17, 2024 at 11:23:12AM +0200, David Hildenbrand wrote:
> Let's get rid of another page_mapcount() check and simply use
> folio_likely_mapped_shared(), which is precise for hugetlb folios.
> 
> While at it, also check for PMD table sharing, like we do in
> smaps_hugetlb_range().
> 
> No functional change intended, except that we would now detect hugetlb
> folios shared via PMD table sharing correctly.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Oscar Salvador <osalvador@suse.de>

 

-- 
Oscar Salvador
SUSE Labs

