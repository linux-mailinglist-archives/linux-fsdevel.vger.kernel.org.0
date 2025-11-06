Return-Path: <linux-fsdevel+bounces-67333-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24E9BC3BF6E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 06 Nov 2025 16:11:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C5AC560E9F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Nov 2025 15:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBF3034676F;
	Thu,  6 Nov 2025 15:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="wGQ+gtaT";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="DDexFs6t";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="01wpdMeT";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="oe31NF4m"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767CE32B98C
	for <linux-fsdevel@vger.kernel.org>; Thu,  6 Nov 2025 15:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762441411; cv=none; b=m/zIWUxbGIV1SJJBvpYZLXadPS1iVxM/h9qj9gX6C0UBg4NuBoM2BiuqR8dK/d34kNxwU4XKeWuyCGfJ847Y/IvMnCrNBdjpuqc4N3MYGXGj+WMPxrS8B3ZdH/JRbJ0ms7CxVGSxn8DL9djh3ry+8RGD1uTUHJphrc/DoZdPR7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762441411; c=relaxed/simple;
	bh=gzuh4VEHpFf40kRVaRGCio7glNRsExEQD401s+o6QZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mKJeGH26Ka7GAxwgpCly2O1IuyoTxpB5SuxlUqh9H+B4mRot0mL3DGxb2T3R2ODwe+FY4jrDyulccYUh8EOq+8aAnlVu60Jbq1ta3sY+2qn29B+ayZfvm0D/OTsx3te91637R0cLcjYq7OK1Iv268Yo1Dr9i+3ym5Od99yZTIHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=wGQ+gtaT; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=DDexFs6t; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=01wpdMeT; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=oe31NF4m; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id F3BAD2116D;
	Thu,  6 Nov 2025 15:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1762441407; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HOuwkH32wNh1jajTPykXv5BJYRoed9vUlh1FUYNSAaA=;
	b=wGQ+gtaT9MVIJPxQzAJk9nHKON1QhKutJFbvCIET4Yb4/bJtMaFPPy9w5qrEdWeo6ix+p6
	fYazGMnFXb9JuT7ytDt73mBc9+LHk6ypWWhdfltInKdExHoD0amJrZVUyHXZ3Y7AhISHm+
	VGLRDpEnEcXvYCUe0cx82pgtS+0P6IY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1762441407;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HOuwkH32wNh1jajTPykXv5BJYRoed9vUlh1FUYNSAaA=;
	b=DDexFs6tGKjcQ2YvkaPfgLWY1m4/M1FVIlK39uUpI+aBoiAROQYqo19U6sm5VdLFRKQLFo
	pVNwvJVw485STHDg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=01wpdMeT;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=oe31NF4m
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1762441406; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HOuwkH32wNh1jajTPykXv5BJYRoed9vUlh1FUYNSAaA=;
	b=01wpdMeT4QaOzQTmQOmtg8AandmWnWsQXos0e+S2FB9sjS0GXp+HMMMx81IDz9F/VzQnWB
	pEBB2oJ1GpSVbdv8zvO+zYm5xeR/EZHMJY1ocEQGKxP3Ul8N1Sz+7CbSzWv8JA4hpL+CVH
	AMSeqRac+lDfh4rOxUqXx3GhFnruiWw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1762441406;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HOuwkH32wNh1jajTPykXv5BJYRoed9vUlh1FUYNSAaA=;
	b=oe31NF4mP4vowzTL73VNM7GCu03qi2RD4jLPC2Zh3f9PMX3e538CzoelHIZ11XymFz/VrB
	y69Gxa4avZC+t6AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AFF7C139A9;
	Thu,  6 Nov 2025 15:03:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 3jNTJ7y4DGlKZwAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Thu, 06 Nov 2025 15:03:24 +0000
Date: Thu, 6 Nov 2025 15:03:22 +0000
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
Subject: Re: [PATCH v2 3/5] mm: implement sticky, copy on fork VMA flags
Message-ID: <ksk52ws4jyfihg4s6jeliqthzk44vapkjhycitsb63ujzpt7j4@pkbjovy4ad7a>
References: <cover.1762422915.git.lorenzo.stoakes@oracle.com>
 <9c9e9fb6b767556594b2cef023db01d45d8f8463.1762422915.git.lorenzo.stoakes@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9c9e9fb6b767556594b2cef023db01d45d8f8463.1762422915.git.lorenzo.stoakes@oracle.com>
X-Rspamd-Queue-Id: F3BAD2116D
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[linux-foundation.org,lwn.net,redhat.com,oracle.com,suse.cz,kernel.org,google.com,suse.com,goodmis.org,efficios.com,vger.kernel.org,kvack.org,gmail.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,suse.de:email,suse.de:dkim]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Spam-Level: 

On Thu, Nov 06, 2025 at 10:46:14AM +0000, Lorenzo Stoakes wrote:
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
> 
> Any VMA flags which require this behaviour are inherently 'sticky', that
> is, should we merge two VMAs together, this implies that the newly merged
> VMA maps a range that requires page table copying on fork.
> 
> In order to implement this we must both introduce the concept of a 'sticky'
> VMA flag and adjust the VMA merge logic accordingly, and also have VMA
> merge still successfully succeed should one VMA have the flag set and
> another not.

Perhaps we should separate this patch into two? It looks like we're doing two
things at once for no great reason. But it's a bit of a sticky situation...

> 
> Note that we update the VMA expand logic to handle new VMA merging, as this
> function is the one ultimately called by all instances of merging of new
> VMAs.
> 
> This patch implements this, establishing VM_STICKY to contain all such
> flags and VM_IGNORE_MERGE for those flags which should be ignored when
> comparing adjacent VMA's flags for the purposes of merging.
> 
> As part of this change we place VM_SOFTDIRTY in VM_IGNORE_MERGE as it
> already had this behaviour, alongside VM_STICKY as sticky flags by
> implication must not disallow merge.
> 
> As a result of this change, VMAs with guard ranges will now not have their
> merge behaviour impacted by doing so and can be freely merged with other
> VMAs without VM_MAYBE_GUARD set.
> 
> We also update the VMA userland tests to account for the changes.
> 
> Note that VM_MAYBE_GUARD being set atomically remains correct as
> vma_needs_copy() is invoked with the mmap and VMA write locks held,
> excluding any race with madvise_guard_install().
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Overall the patch LGTM.

Feel free to add:
Reviewed-by: Pedro Falcato <pfalcato@suse.de>

and maybe print it out on a sticker.

-- 
Pedro

