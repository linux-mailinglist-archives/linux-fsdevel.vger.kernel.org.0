Return-Path: <linux-fsdevel+bounces-39387-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C643A13727
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2025 10:57:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7AD527A0F6F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2025 09:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 264811DDC15;
	Thu, 16 Jan 2025 09:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="VpJtDQMW";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="2TR9MH3e";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="VpJtDQMW";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="2TR9MH3e"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FFAA1D9A50;
	Thu, 16 Jan 2025 09:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737021419; cv=none; b=Sow8H5FWsaceYYBEyjBksvcvgiKvOB7thEBSQrk6QufFC40YeBXbflOpn80xPERhvhmdGxH2fbt8juk20+Th+drTlkpjwVQrHNjBwk9AstN+ADts6ADFeM5NETiYujRCz6m2i847YE/JiXoOvFOXqkqJsh2YwVs6O3MyCqy28nE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737021419; c=relaxed/simple;
	bh=OKZruiIn7K4pAL01L990J0G76keVLQLwgAM6iBA3og0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AtB9Kp3JPRLbyP+Ah8nCHqRZ8cH4xq06rYtir5oH5UkWzJc5hRc6AlyX9fcTZLYP6262LXvYu7XLtLTTC2+Q32B61aKdZdakXpKJQ1bwyYgfnZYE7XNfKpRojM2kdZfGrVki0CKaG5j447vWrlFbFvU8WGWWWkid9k44lJxnnx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=VpJtDQMW; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=2TR9MH3e; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=VpJtDQMW; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=2TR9MH3e; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4A822211DD;
	Thu, 16 Jan 2025 09:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1737021414; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=69jTRBVx7v5lC+RPc/GkP3LJRO7OBf7CTidYRADh8Ow=;
	b=VpJtDQMWkEPGL+gxD+WMzDY+9caJxeLypFb3sOLBMD2nZA8p9rmo5+e5L6dDeqcU0SBzgl
	BcbzyuAZVv1WOeGtEwap8OLkeWDXWFrblF1/amhTDZopNE/ZOCUDrS4I5R4fWQIt2VN8+x
	rqa+waAfKh+8Vib3QNAZ9P/8RxZ/StA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1737021414;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=69jTRBVx7v5lC+RPc/GkP3LJRO7OBf7CTidYRADh8Ow=;
	b=2TR9MH3eSIK3LqcNDM3jn/EJ6IdU8ZOOaMAdDyxbR0lV2036+K6BjpM1yEjK+JMBRgrKDc
	Ir2AZrY6NlRs7rBQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=VpJtDQMW;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=2TR9MH3e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1737021414; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=69jTRBVx7v5lC+RPc/GkP3LJRO7OBf7CTidYRADh8Ow=;
	b=VpJtDQMWkEPGL+gxD+WMzDY+9caJxeLypFb3sOLBMD2nZA8p9rmo5+e5L6dDeqcU0SBzgl
	BcbzyuAZVv1WOeGtEwap8OLkeWDXWFrblF1/amhTDZopNE/ZOCUDrS4I5R4fWQIt2VN8+x
	rqa+waAfKh+8Vib3QNAZ9P/8RxZ/StA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1737021414;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=69jTRBVx7v5lC+RPc/GkP3LJRO7OBf7CTidYRADh8Ow=;
	b=2TR9MH3eSIK3LqcNDM3jn/EJ6IdU8ZOOaMAdDyxbR0lV2036+K6BjpM1yEjK+JMBRgrKDc
	Ir2AZrY6NlRs7rBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 40F1513332;
	Thu, 16 Jan 2025 09:56:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 9t3UD+bXiGe5bAAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 16 Jan 2025 09:56:54 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id F26BCA08E0; Thu, 16 Jan 2025 10:56:53 +0100 (CET)
Date: Thu, 16 Jan 2025 10:56:53 +0100
From: Jan Kara <jack@suse.cz>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Tavian Barnes <tavianator@tavianator.com>, 
	linux-fsdevel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] coredump: allow interrupting dumps of large anonymous
 regions
Message-ID: <63wvjel64hsft4clgeayaorx3v7txvqh264mw7ionlbmmve7pj@eblpknd677zf>
References: <049f0da40ed76d94c419f83dd42deb413d6afb44.1737000287.git.tavianator@tavianator.com>
 <t2cucclkkxj65fk7nknzogbeobyq7tgx4klep77ptnnlfrv34e@vjkzxymgnr4r>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <t2cucclkkxj65fk7nknzogbeobyq7tgx4klep77ptnnlfrv34e@vjkzxymgnr4r>
X-Rspamd-Queue-Id: 4A822211DD
X-Spam-Score: -4.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_SEVEN(0.00)[7];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:dkim]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Thu 16-01-25 08:46:48, Mateusz Guzik wrote:
> On Wed, Jan 15, 2025 at 11:05:38PM -0500, Tavian Barnes wrote:
> > dump_user_range() supports sparse core dumps by skipping anonymous pages
> > which have not been modified.  If get_dump_page() returns NULL, the page
> > is skipped rather than written to the core dump with dump_emit_page().
> > 
> > Sadly, dump_emit_page() contains the only check for dump_interrupted(),
> > so when dumping a very large sparse region, the core dump becomes
> > effectively uninterruptible.  This can be observed with the following
> > test program:
> > 
> >     #include <stdlib.h>
> >     #include <stdio.h>
> >     #include <sys/mman.h>
> > 
> >     int main(void) {
> >         char *mem = mmap(NULL, 1ULL << 40, PROT_READ | PROT_WRITE,
> >                 MAP_ANONYMOUS | MAP_NORESERVE | MAP_PRIVATE, -1, 0);
> >         printf("%p %m\n", mem);
> >         if (mem != MAP_FAILED) {
> >                 mem[0] = 1;
> >         }
> >         abort();
> >     }
> > 
> > The program allocates 1 TiB of anonymous memory, touches one page of it,
> > and aborts.  During the core dump, SIGKILL has no effect.  It takes
> > about 30 seconds to finish the dump, burning 100% CPU.
> > 
> 
> While the patch makes sense to me, this should not be taking anywhere
> near this much time and plausibly after unscrewing it will stop being a
> factor.
> 
> So I had a look with a profiler:
> -   99.89%     0.00%  a.out
>      entry_SYSCALL_64_after_hwframe                      
>      do_syscall_64                                       
>      syscall_exit_to_user_mode                           
>      arch_do_signal_or_restart                           
>    - get_signal                                          
>       - 99.89% do_coredump                               
>          - 99.88% elf_core_dump                          
>             - dump_user_range                            
>                - 98.12% get_dump_page                    
>                   - 64.19% __get_user_pages              
>                      - 40.92% gup_vma_lookup             
>                         - find_vma                       
>                            - mt_find                     
>                                 4.21% __rcu_read_lock    
>                                 1.33% __rcu_read_unlock  
>                      - 3.14% check_vma_flags             
>                           0.68% vma_is_secretmem         
>                        0.61% __cond_resched              
>                        0.60% vma_pgtable_walk_end        
>                        0.59% vma_pgtable_walk_begin      
>                        0.58% no_page_table               
>                   - 15.13% down_read_killable            
>                        0.69% __cond_resched              
>                     13.84% up_read                       
>                  0.58% __cond_resched                    
> 
> 
> Almost 29% of time is spent relocking the mmap semaphore in
> __get_user_pages. This most likely can operate locklessly in the fast
> path. Even if somehow not, chances are the lock can be held across
> multiple calls.
> 
> mt_find spends most of it's time issuing a rep stos of 48 bytes (would
> be faster to rep mov 6 times instead). This is the compiler being nasty,
> I'll maybe look into it.
> 
> However, I strongly suspect the current iteration method is just slow
> due to repeat mt_find calls and The Right Approach(tm) would make this
> entire thing finish within miliseconds by iterating the maple tree
> instead, but then the mm folk would have to be consulted on how to
> approach this and it may be time consuming to implement.
> 
> Sorting out relocking should be an easily achievable & measurable win
> (no interest on my end).

As much as I agree the code is dumb, doing what you suggest with mmap_sem
isn't going to be easy. You cannot call dump_emit_page() with mmap_sem held
as that will cause lock inversion between mmap_sem and whatever filesystem
locks we have to take. So the fix would have to involve processing larger
batches of address space at once (which should also somewhat amortize the
__get_user_pages() setup costs). Not that hard to do but I wanted to spell
it out in case someone wants to pick up this todo item :)

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

