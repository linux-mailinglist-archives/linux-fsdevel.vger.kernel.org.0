Return-Path: <linux-fsdevel+bounces-69123-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CA57C7046D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 17:59:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7BBAA4FD493
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 16:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F0B13446BC;
	Wed, 19 Nov 2025 16:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="QoyUzQy0";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="qKhmmQci";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Vc917aBD";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="EhVk9XM6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9015136E569
	for <linux-fsdevel@vger.kernel.org>; Wed, 19 Nov 2025 16:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763570188; cv=none; b=DfpgR7UlAVude9k2aQror69SNq2pfAXpNz0Cl43wWj5l5zql4+VzlVVsbHW6E4uYaUstN/A+luxQEXR95EiKNjhX/hNALA8WXlAF8GSwgwY7Fm/6ExRfRcW/1LuYkNCku/tOKr5sCDdZlNXPdz7ffVYOCGcaRZBBTzGtjGNvsoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763570188; c=relaxed/simple;
	bh=MiYcdi2tQ+2r1RMplxVS9eAgA9bD8miiom4S+yzOduA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oGQOF9fN8ATcV3XTh032DHqS3gsCDwL/nDYxO3f0ejwiehB0wyZ/NFFEI+Ula8qcOw5yMNU9rz9ZblF/ndg7D87RkouWCncEaQh0bw2bxSuTIOXa4VaJONkEYguwgc3Cp8bfmQdM84spj/Ie7R6qnyHTX+bYpEBIqYfYTzEmgDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=QoyUzQy0; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=qKhmmQci; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Vc917aBD; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=EhVk9XM6; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CDBEC20595;
	Wed, 19 Nov 2025 16:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1763570178; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UaJrljRuHzsSahjPRFPX05pBvERQqP62JHa1SezYFP4=;
	b=QoyUzQy0kfEnmwEH9C+WMNmv2fIw6SyxdCjQ48Vph6uLgnt2FyRgxRi+IrojladgxuGPqF
	lgOx9Sp0Tpe3VQugorn8fo9va7mWPEshkF5wl7IVuODe649vFAspPCCre792HbRoNJzDIp
	Zsj6cN0scu/Ujuuk/8iqe7SUORJ33/g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1763570178;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UaJrljRuHzsSahjPRFPX05pBvERQqP62JHa1SezYFP4=;
	b=qKhmmQci2mtPc1l8hRYQoJB2MunsPpcPUwoTjghLy0f/8UeUoZhRpC1t2aDUlTvlNwmWKY
	fYhvv+/I+Q/GNeDg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Vc917aBD;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=EhVk9XM6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1763570173; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UaJrljRuHzsSahjPRFPX05pBvERQqP62JHa1SezYFP4=;
	b=Vc917aBDIOVnaGybQq9G9o6Sw5JDPY9DXNjg0SB3wCL9/7z05/g3dtOdqldVWKeio8A1fU
	wT1TjOnfdFdWRvoysS8piGh9prn0ffObfab8alRHuZuoxYbw9OSLk+320MTkYfLmaGZQRy
	BHalF4F3Bja+m/sVwTPFNLNMHeB6gLY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1763570173;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UaJrljRuHzsSahjPRFPX05pBvERQqP62JHa1SezYFP4=;
	b=EhVk9XM63H+CBv9exjU6w0Z1ugfyJBtkpRPI4mnv+0FmkorsOQ8RVVkrkiFOGJk/Vx4DlA
	9BIe0uuvHC5zHVBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2DD143EA62;
	Wed, 19 Nov 2025 16:36:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Kx8ECPzxHWl4cgAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Wed, 19 Nov 2025 16:36:12 +0000
Date: Wed, 19 Nov 2025 16:36:10 +0000
From: Pedro Falcato <pfalcato@suse.de>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Jonathan Corbet <corbet@lwn.net>, David Hildenbrand <david@redhat.com>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Jann Horn <jannh@google.com>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Nico Pache <npache@redhat.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
	Lance Yang <lance.yang@linux.dev>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Andrei Vagin <avagin@gmail.com>
Subject: Re: [PATCH v4 3/9] mm: update vma_modify_flags() to handle residual
 flags, document
Message-ID: <vr45iyduvak3wpzmos5l4jfpzticerlnxuhnpvbzb7fpsvanqx@rsuogv5s6brh>
References: <cover.1763460113.git.lorenzo.stoakes@oracle.com>
 <23b5b549b0eaefb2922625626e58c2a352f3e93c.1763460113.git.lorenzo.stoakes@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23b5b549b0eaefb2922625626e58c2a352f3e93c.1763460113.git.lorenzo.stoakes@oracle.com>
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: CDBEC20595
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWELVE(0.00)[27];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,lwn.net,redhat.com,oracle.com,suse.cz,kernel.org,google.com,suse.com,goodmis.org,efficios.com,nvidia.com,linux.alibaba.com,arm.com,linux.dev,vger.kernel.org,kvack.org,gmail.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	BLOCKLISTDE_FAIL(0.00)[2a07:de40:b281:106:10:150:64:167:query timed out,2a07:de40:b281:104:10:150:64:97:query timed out];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -4.01

On Tue, Nov 18, 2025 at 10:17:45AM +0000, Lorenzo Stoakes wrote:
> The vma_modify_*() family of functions each either perform splits, a merge
> or no changes at all in preparation for the requested modification to
> occur.
> 
> When doing so for a VMA flags change, we currently don't account for any
> flags which may remain (for instance, VM_SOFTDIRTY) despite the requested
> change in the case that a merge succeeded.
> 
> This is made more important by subsequent patches which will introduce the
> concept of sticky VMA flags which rely on this behaviour.
> 
> This patch fixes this by passing the VMA flags parameter as a pointer and
> updating it accordingly on merge and updating callers to accommodate for
> this.
> 
> Additionally, while we are here, we add kdocs for each of the
> vma_modify_*() functions, as the fact that the requested modification is
> not performed is confusing so it is useful to make this abundantly
> clear.
> 
> We also update the VMA userland tests to account for this change.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Reviewed-by: Pedro Falcato <pfalcato@suse.de>

Quite ugly change, but for the sake of brevity I think we can live it
Temporarily(tm).

-- 
Pedro

