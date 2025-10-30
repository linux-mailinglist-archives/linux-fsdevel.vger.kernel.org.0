Return-Path: <linux-fsdevel+bounces-66496-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8960CC21322
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 17:32:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 056BB4272E1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 16:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9810A3678AD;
	Thu, 30 Oct 2025 16:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Wr67yKJ4";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="D+oqUsGa";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Wr67yKJ4";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="D+oqUsGa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31BD23655FC
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Oct 2025 16:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761841566; cv=none; b=isacnnKrxlA6r2eqKsbW/AucU7lDH5bHwLpyzAAK/b/TAwfYEj4BDdBj3EhkEkrOD0NxZMgOt68i+nQrKgB6gPu7I3RjLDsG6GeQJOi2gYX+HbCu3JLzHhiqiBUJ8R/e/WiR83OiCV2YCq4bxqiaIzSLGBGgI3ROhaFqH3tj/9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761841566; c=relaxed/simple;
	bh=tzp1RPz9J6cF5ewTGOUXuNYVp2WUlMURNL2v6N9EIjE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iXQgTjTLGkKjVLkR/+84wkVfqgVPi4rX0RwIOPOBhJR+3QzqngDxlFAwEUlTe0osbUcQS1flHIhchYnAkzF9xjxHvyeh9Upyi0UrBimBm1jANNdAY7APDGWMz3PppEv9PhSk8qkWbQC8NCkVCs2ieeYwaM18zW+l+jVlqPx2LiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Wr67yKJ4; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=D+oqUsGa; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Wr67yKJ4; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=D+oqUsGa; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6B776337A4;
	Thu, 30 Oct 2025 16:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1761841562; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Y45ny24R7zem9vCEHKWr8/ZHpLbSWhPSrqSC/spGVIw=;
	b=Wr67yKJ4CtPObOAKIVbuQJ9uY1Mk/MgeJUi4m6VsB6BWlU0F0w3slr/L7uxGX4UIVenmYG
	FVooJOrHZxMD/LXTl1NWfVDmDpsPcFAepG2c3+9mRbdmLpk/tAp/3f6fhAHmZQkmiFApmK
	dN1RFs/oz0bT5pWP2kremYVE/gbgeeQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1761841562;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Y45ny24R7zem9vCEHKWr8/ZHpLbSWhPSrqSC/spGVIw=;
	b=D+oqUsGaCNVth5UJ+jVZ9a4MlY9qTQC2zol7+YlVgHZwEw4ExmMJUEvovqmF7TEqS4ZDTF
	1G1QbvzD5qIGfHCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1761841562; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Y45ny24R7zem9vCEHKWr8/ZHpLbSWhPSrqSC/spGVIw=;
	b=Wr67yKJ4CtPObOAKIVbuQJ9uY1Mk/MgeJUi4m6VsB6BWlU0F0w3slr/L7uxGX4UIVenmYG
	FVooJOrHZxMD/LXTl1NWfVDmDpsPcFAepG2c3+9mRbdmLpk/tAp/3f6fhAHmZQkmiFApmK
	dN1RFs/oz0bT5pWP2kremYVE/gbgeeQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1761841562;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Y45ny24R7zem9vCEHKWr8/ZHpLbSWhPSrqSC/spGVIw=;
	b=D+oqUsGaCNVth5UJ+jVZ9a4MlY9qTQC2zol7+YlVgHZwEw4ExmMJUEvovqmF7TEqS4ZDTF
	1G1QbvzD5qIGfHCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0369B1396A;
	Thu, 30 Oct 2025 16:25:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id rF/mOJeRA2m3FgAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Thu, 30 Oct 2025 16:25:59 +0000
Date: Thu, 30 Oct 2025 16:25:54 +0000
From: Pedro Falcato <pfalcato@suse.de>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Jonathan Corbet <corbet@lwn.net>, David Hildenbrand <david@redhat.com>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Jann Horn <jannh@google.com>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Andrei Vagin <avagin@gmail.com>
Subject: Re: [PATCH 2/3] mm: implement sticky, copy on fork VMA flags
Message-ID: <jmyrkglrrdxtdkcnovmkcxbk64zgfpp6r3e33bquixkvoxl45r@zcnwp3v2ucbp>
References: <cover.1761756437.git.lorenzo.stoakes@oracle.com>
 <ec71238fd1f735ca6e4970ccdc0abfbb60967596.1761756437.git.lorenzo.stoakes@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ec71238fd1f735ca6e4970ccdc0abfbb60967596.1761756437.git.lorenzo.stoakes@oracle.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,lwn.net,redhat.com,oracle.com,suse.cz,kernel.org,google.com,suse.com,goodmis.org,efficios.com,vger.kernel.org,kvack.org,gmail.com];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -3.80

On Wed, Oct 29, 2025 at 04:50:32PM +0000, Lorenzo Stoakes wrote:
> It's useful to be able to force a VMA to be copied on fork outside of the
> parameters specified by vma_needs_copy(), which otherwise only copies page
> tables if:
> 
> * The destination VMA has VM_UFFD_WP set
> * The mapping is a PFN or mixed map
> * The mapping is anonymous and forked in (i.e. vma->anon_vma is non-NULL)
> 
> Setting this flag implies that the page tables mapping the VMA are such
> that simply re-faulting the VMA will not re-establish them in identical
> form.
> 
> We introduce VM_COPY_ON_FORK to clearly identify which flags require this
> behaviour, which currently is only VM_MAYBE_GUARD.

Do we want this to be sticky though? If you're looking for more granularity
with this flag, the best option might be to stop merges from happening there.
If not, I can imagine a VMA that merges with other VMAs far past the original
guarded range, and thus you get no granularity (possibly, not even useful).

If you're _not_ looking for granularity, then maybe using a per-mm flag for
guard ranges or some other solution would be superior?

The rest of the patch (superficially) looks good to me, though.

-- 
Pedro

