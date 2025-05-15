Return-Path: <linux-fsdevel+bounces-49156-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29A8EAB8A0E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 16:57:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D36EA0835A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 14:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52D9F207A0B;
	Thu, 15 May 2025 14:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="RttnuULT";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="e8ebKY0M";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="RttnuULT";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="e8ebKY0M"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D000192D6B
	for <linux-fsdevel@vger.kernel.org>; Thu, 15 May 2025 14:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747320885; cv=none; b=WKIQ9DK5Wle1SxRkMLJIKfK7gpKNZEpTY7wwAHfGfi8kabEu/wdCS5KIxLlnf9fIqXNa3RKIfCfj0l170fOwa3MEeeK+oMu8IR2cEl/aMeA60eDGTpMh2YMrVYhcJEpr3RLAgDkAPcs5vlNwLTDZSjULat1fJI/4RcQ1ri1qIUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747320885; c=relaxed/simple;
	bh=CIuQXyAlmDZ0tcTqwt4Ki5f1XUEKxbpY7qH+7NA4P/U=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=WLriXa4uccmhp/1mkdwULf0PbUG20fdWSSqn3p9CKtuJpzltDmk+OSYuP1wRhLTfyP3tqzWAZsdOm7BIjGJvYzPlp2kGSmD24Z2ufZDol0ACcWzt4/iE8CsOjhIPauGxfF/l26LKuM8RqTQPPvLz0rav0EfMRsNAl3hoxEVabjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=RttnuULT; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=e8ebKY0M; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=RttnuULT; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=e8ebKY0M; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1220B1F387;
	Thu, 15 May 2025 14:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1747320881; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=F+gKtpIB+zYoDH0TSjofufwHlAln19enRcuv1d0Dnsc=;
	b=RttnuULTz8GMvQQwET/QXYECs1HX1/hNOPo97LuLjXYzTRwP2EimgXrUlVDyG+LQLKqnLH
	iD4ZDJMptPCfkoRe+WX+M6JssEhOn1yvVhnNlvg9ERijk6AccL0cOHY8ZBRRfCVIsTJebH
	KadQFy5Dv/3ccBgtHJkrtg62M/GrE84=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1747320881;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=F+gKtpIB+zYoDH0TSjofufwHlAln19enRcuv1d0Dnsc=;
	b=e8ebKY0MG3Aa20izeockCzGtrJ6A/EgU/TSaVRuQAMFVYndbrQUMeU4AGJCvcuN4H0U3Be
	Eo3i+6XXFyZ89hAw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=RttnuULT;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=e8ebKY0M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1747320881; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=F+gKtpIB+zYoDH0TSjofufwHlAln19enRcuv1d0Dnsc=;
	b=RttnuULTz8GMvQQwET/QXYECs1HX1/hNOPo97LuLjXYzTRwP2EimgXrUlVDyG+LQLKqnLH
	iD4ZDJMptPCfkoRe+WX+M6JssEhOn1yvVhnNlvg9ERijk6AccL0cOHY8ZBRRfCVIsTJebH
	KadQFy5Dv/3ccBgtHJkrtg62M/GrE84=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1747320881;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=F+gKtpIB+zYoDH0TSjofufwHlAln19enRcuv1d0Dnsc=;
	b=e8ebKY0MG3Aa20izeockCzGtrJ6A/EgU/TSaVRuQAMFVYndbrQUMeU4AGJCvcuN4H0U3Be
	Eo3i+6XXFyZ89hAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0745C139D0;
	Thu, 15 May 2025 14:54:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id nS2+ATEAJmhGOwAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 15 May 2025 14:54:41 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 9CABCA08CF; Thu, 15 May 2025 16:54:36 +0200 (CEST)
Date: Thu, 15 May 2025 16:54:36 +0200
From: Jan Kara <jack@suse.cz>
To: linux-fsdevel@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>, 
	Al Viro <viro@zeniv.linux.org.uk>
Subject: Machine lockup with large d_invalidate()
Message-ID: <vmjjaofrxvwfkse7gybj5r4mj2mbg345ganq3ydbzllees7oi2@uomtwdvj6xcd>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 1220B1F387
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Spam-Level: 
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	MISSING_XM_UA(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim]
X-Rspamd-Action: no action

Hello,

we have a customer who is mounting over NFS a directory (let's call it
hugedir) with many files (there are several millions dentries on d_children
list). Now when they do 'mv hugedir hugedir.bak; mkdir hugedir' on the
server, which invalidates NFS cache of this directory, NFS clients get
stuck in d_invalidate() for hours (until the customer lost patience).

Now I don't want to discuss here sanity or efficiency of this application
architecture but I'm sharing the opinion that it shouldn't take hours to
invalidate couple million dentries. Analysis of the crashdump revealed that
d_invalidate() can have O(n^2) complexity with the number of dentries it is
invalidating which leads to impractical times to invalidate large numbers
of dentries. What happens is the following:

There are several processes accessing the hugedir directory - about 16 in
the case I was inspecting. When the directory changes on the server all
these 16 processes quickly enter d_invalidate() -> shrink_dcache_parent()
(actually the kernel is old so the function names are somewhat different
but the same seems to be applicable to current upstream kernel AFAICT). In
shrink_dcache_parent() we use d_walk() to collect dentries to invalidate.
The processes doing d_walk() are synchronized on hughedir->d_lock so they
operate sequentially. Now select_collect() handler returns D_WALK_QUIT as
soon as need_resched() is set and it has moved at least one dentry into the
dispose list. Hence the first task that does d_walk() moves around 90k
entries to dispose list before it decides to take a break. The second task
has a somewhat harder work - it needs to skip over those 90k entries moved
to dispose list (as they are still in hugedir->d_children list) and only
then starts moving dentries to dispose list. It has managed to move 50k
dentries before it decided to reschedule. Finally, from about fifth task
that called d_invalidate() the task always spends its whole timeslice
skipping over moved dentries in hugedir->d_chidren list, then moves one
dentry to dispose list and aborts scanning to reschedule.

So we are in a situation where a few tasks have tens of thousands entries
in their dispose lists and a larger number of tasks that have only one dentry
in their dispose lists. What happens next is that tasks eventually get
scheduled again and proceed to process dentries in dispose list (in fact in
the current kernel the first scheduling point seems to be in
__dentry_kill() when we are evicting the first dentry from the dispose
list). If this was a task that had only single dentry in its dispose list, it
rather quickly evicts it and cycles back to d_walk() - only to scan
hugedir->d_children, skip huge number of already moved dentries and finally
move another one dentry to dispose list. While this is happening, all other
tasks that want to evict dentries from their dispose lists are spinning on
hugedir->d_lock. So the overall progress is very slow because we always
evict only a few dentries and then someone gets to scanning
hugedir->d_children, blocks everybody for the whole timeslice only to move
one more dentry to its dispose list...

The question is how to best fix this very inefficient behavior. One
possible approach would be to somehow completely serialize
shrink_dcache_parent() operation for a directory. That way we'd avoid the
expensive rescanning of already moved dentries as well as the contention on
d_lock between tasks. On the other hand deep directory hierarchies can
possibly benefit from multiple tasks reaping them so it isn't a clear
universal win.

Another possible approach is to remember position in d_children list where
we stopped scanning when we decided to reschedule (I suppose we could use
DCACHE_DENTRY_CURSOR for that). This way there would still be some amount
of skipping of already moved dentries but at least the overall complexity
would get from O(n^2) to O(t*n) where 't' is the number of tasks trying to
invalidate the directory so I think the performance will be acceptable.

What do people think about these solutions? Anything I'm missing?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

