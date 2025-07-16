Return-Path: <linux-fsdevel+bounces-55115-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28F43B07008
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 10:15:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F6754A1F7D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 08:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A2CB28DF3F;
	Wed, 16 Jul 2025 08:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="yNm/reCG";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="RWidS2MG";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="yNm/reCG";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="RWidS2MG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE18290BB4
	for <linux-fsdevel@vger.kernel.org>; Wed, 16 Jul 2025 08:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752653723; cv=none; b=jXf0bINvE5WxW0Q9Mkyj6tt/oJ4pgA/MHFH2JvpYfpmb7PEcXxH1SobM05uLvGsHkbzMRf4lILSbRGctmLN+xUjn44pYx+wxKric/S4CfuV+pcWXZRDVzYMlDqCjiEtSvwSn9s7wQTRj7eGeb67ezvyQdPAYyVFdCkL1O2YLq+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752653723; c=relaxed/simple;
	bh=xIQfjOSeDmcHMctGGAmr6Zed/Pgzh+yH1/AwDBGkcc4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dvnZtK8EE5IjSl1EaMsnMieERXH0mq7u1fg9rk9v+3DqPINP1pU0IZEEGV+GnsR/FWlrwUbNLWb+QzeBYIA1BADeQB+ARNiNIjCsNfSZqXJZY1d9z4/YGREfsjkXm/Fbsb13HKXGbQwrLKRPTXWZdrv4DXjJ2SLhdsAaZMoGxhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=yNm/reCG; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=RWidS2MG; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=yNm/reCG; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=RWidS2MG; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B91CD21235;
	Wed, 16 Jul 2025 08:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1752653708; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jkSgIZSLDUxZGJTDY6g7f04pt3NDA9wqvE9dGLy8T3U=;
	b=yNm/reCGnpS06F2l9+0Ry+8Ejjq4CGRXtL+0STIy8ioMEUP1Djxt0KkgGMQPU5k0wm9u4d
	iOk/WQMGXfbDv4a24ny4YRvOQUXjHI7KRTRxVx1kn5vSqxq0049/OdAmX4pTJ3xt5MsmNB
	VULt+jCl2uroaJfVB3wWDgXYRKxzxLQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1752653708;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jkSgIZSLDUxZGJTDY6g7f04pt3NDA9wqvE9dGLy8T3U=;
	b=RWidS2MGx9plftoxMQMTNCZGN7vfWKVczAox/HX8yN9FEL66POamEEvVsYYl82h2WpaUyv
	HL2bIvusC0OnzCAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1752653708; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jkSgIZSLDUxZGJTDY6g7f04pt3NDA9wqvE9dGLy8T3U=;
	b=yNm/reCGnpS06F2l9+0Ry+8Ejjq4CGRXtL+0STIy8ioMEUP1Djxt0KkgGMQPU5k0wm9u4d
	iOk/WQMGXfbDv4a24ny4YRvOQUXjHI7KRTRxVx1kn5vSqxq0049/OdAmX4pTJ3xt5MsmNB
	VULt+jCl2uroaJfVB3wWDgXYRKxzxLQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1752653708;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jkSgIZSLDUxZGJTDY6g7f04pt3NDA9wqvE9dGLy8T3U=;
	b=RWidS2MGx9plftoxMQMTNCZGN7vfWKVczAox/HX8yN9FEL66POamEEvVsYYl82h2WpaUyv
	HL2bIvusC0OnzCAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 284E6138D2;
	Wed, 16 Jul 2025 08:15:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id czrGBItfd2jfDwAAD6G6ig
	(envelope-from <osalvador@suse.de>); Wed, 16 Jul 2025 08:15:07 +0000
Date: Wed, 16 Jul 2025 10:15:05 +0200
From: Oscar Salvador <osalvador@suse.de>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	xen-devel@lists.xenproject.org, linux-fsdevel@vger.kernel.org,
	nvdimm@lists.linux.dev, Andrew Morton <akpm@linux-foundation.org>,
	Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
	Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
	Hugh Dickins <hughd@google.com>, Lance Yang <lance.yang@linux.dev>
Subject: Re: [PATCH v1 7/9] mm/memory: factor out common code from
 vm_normal_page_*()
Message-ID: <aHdfiaKXU0zfHcPe@localhost.localdomain>
References: <20250715132350.2448901-1-david@redhat.com>
 <20250715132350.2448901-8-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250715132350.2448901-8-david@redhat.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[31];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLhwqoz3wsm4df3nfubx4grhps)];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,localhost.localdomain:mid]
X-Spam-Flag: NO
X-Spam-Score: -4.30

On Tue, Jul 15, 2025 at 03:23:48PM +0200, David Hildenbrand wrote:
> Let's reduce the code duplication and factor out the non-pte/pmd related
> magic into vm_normal_page_pfn().
> 
> To keep it simpler, check the pfn against both zero folios. We could
> optimize this, but as it's only for the !CONFIG_ARCH_HAS_PTE_SPECIAL
> case, it's not a compelling micro-optimization.
> 
> With CONFIG_ARCH_HAS_PTE_SPECIAL we don't have to check anything else,
> really.
> 
> It's a good question if we can even hit the !CONFIG_ARCH_HAS_PTE_SPECIAL
> scenario in the PMD case in practice: but doesn't really matter, as
> it's now all unified in vm_normal_page_pfn().
> 
> Add kerneldoc for all involved functions.
> 
> No functional change intended.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Oscar Salvador <osalvador@suse.de>

 

-- 
Oscar Salvador
SUSE Labs

