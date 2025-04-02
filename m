Return-Path: <linux-fsdevel+bounces-45510-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3369DA78D79
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Apr 2025 13:49:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A35BC1893EDB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Apr 2025 11:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3E5B238172;
	Wed,  2 Apr 2025 11:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="VvWtACp4";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="AVPSE5DM";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="VvWtACp4";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="AVPSE5DM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E5A2231A57
	for <linux-fsdevel@vger.kernel.org>; Wed,  2 Apr 2025 11:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743594436; cv=none; b=mvjarxyTJ6MftrnVkAlD65kEBdUlmWIqHEZVrLxY6wFJjh2OHdSngqWg1hCNChXxUinSkni1ql8J69/QzS6ZINswPsqZtSdvEpNka8zCocM7myuc5KJUhXWlGCkAX+uJ3mfZIImS4Pdjwb7+Fdm0lrXupz7OW0HlsNmsZRl1DzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743594436; c=relaxed/simple;
	bh=aAWMzELJP1P/if9KF7/bduo6wGnBWLqqHpooy2iQ6Nw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tue1TShwf3uyAPpoQUmjEpptNDdWi+Rhi0vhEo/zZ5fPNzmOTM2LWoTAfBU9KS8/ADUtpJ4d8hSFEDZ7GKIoXsz9tfha1yIYUwnWkGs94Uq4qfsyhcz0yxw9LahtwUnhjIifXstM2n1mZcLtt+5Vnia8VpJegZTzEGnKacoLLcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=VvWtACp4; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=AVPSE5DM; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=VvWtACp4; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=AVPSE5DM; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3CFF921168;
	Wed,  2 Apr 2025 11:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1743594431; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hRC1Ph3v+dpLUuN6PqUZ7LoZjP3VCw/h5Hi3hKP3wJQ=;
	b=VvWtACp4e5Hwz/FYvvv2rYbfAnIKDXHF66ZNX9rKOwzJ1rv4x78pEzSxpkjjvS8U0Y4f0V
	ywFGX/skiQLH2QJKusP29Ueop4fFXYF/BJ7dO0BBGefEPYecRSNtPVYy4fkap2TUeYqy1U
	tnZBkE5H82tctqN+ayrjuKQiX7pOPu8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1743594431;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hRC1Ph3v+dpLUuN6PqUZ7LoZjP3VCw/h5Hi3hKP3wJQ=;
	b=AVPSE5DMJ6Y/I/QNwxPw8VyR29KkM+YlBuSlKFG6eS6hWTZBJB23tjIAnHdEdSg9tDVsKW
	Aq/u7TGKBolnxyAw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=VvWtACp4;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=AVPSE5DM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1743594431; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hRC1Ph3v+dpLUuN6PqUZ7LoZjP3VCw/h5Hi3hKP3wJQ=;
	b=VvWtACp4e5Hwz/FYvvv2rYbfAnIKDXHF66ZNX9rKOwzJ1rv4x78pEzSxpkjjvS8U0Y4f0V
	ywFGX/skiQLH2QJKusP29Ueop4fFXYF/BJ7dO0BBGefEPYecRSNtPVYy4fkap2TUeYqy1U
	tnZBkE5H82tctqN+ayrjuKQiX7pOPu8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1743594431;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hRC1Ph3v+dpLUuN6PqUZ7LoZjP3VCw/h5Hi3hKP3wJQ=;
	b=AVPSE5DMJ6Y/I/QNwxPw8VyR29KkM+YlBuSlKFG6eS6hWTZBJB23tjIAnHdEdSg9tDVsKW
	Aq/u7TGKBolnxyAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1365313A4B;
	Wed,  2 Apr 2025 11:47:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id oiNPBL8j7WcfcwAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 02 Apr 2025 11:47:11 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 93B48A07E6; Wed,  2 Apr 2025 13:47:06 +0200 (CEST)
Date: Wed, 2 Apr 2025 13:47:06 +0200
From: Jan Kara <jack@suse.cz>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, mcgrof@kernel.org, 
	hch@infradead.org, david@fromorbit.com, rafael@kernel.org, djwong@kernel.org, 
	pavel@kernel.org, peterz@infradead.org, mingo@redhat.com, will@kernel.org, 
	boqun.feng@gmail.com
Subject: Re: [RFC PATCH 1/4] locking/percpu-rwsem: add freezable alternative
 to down_read
Message-ID: <ophjhrnyzl7jp55qj35kgiz3zflopsiuiwg4dhxmkyua2w46nz@5p2e2djo3vw4>
References: <20250327140613.25178-1-James.Bottomley@HansenPartnership.com>
 <20250327140613.25178-2-James.Bottomley@HansenPartnership.com>
 <77774eb380e343976de3de681204e2c7f3ab1926.camel@HansenPartnership.com>
 <20250401-anwalt-dazugeben-18d8c3efd1fd@brauner>
 <f6bdfa23b9f54055f8a539ce396f1134b0921417.camel@HansenPartnership.com>
 <3bfnds6nsvxy5jfbcoy62uva6kebhacjuavqxvelbfs6ut6rqf@m4pzsudbqg6l>
 <1d913e99368039b77945d1be89e6626b4238f665.camel@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1d913e99368039b77945d1be89e6626b4238f665.camel@HansenPartnership.com>
X-Rspamd-Queue-Id: 3CFF921168
X-Spam-Score: -2.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,kernel.org,vger.kernel.org,infradead.org,fromorbit.com,redhat.com,gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Tue 01-04-25 08:52:02, James Bottomley wrote:
> On Tue, 2025-04-01 at 13:20 +0200, Jan Kara wrote:
> > On Mon 31-03-25 21:13:20, James Bottomley wrote:
> > > On Tue, 2025-04-01 at 01:32 +0200, Christian Brauner wrote:
> [...]
> > > > diff --git a/include/linux/fs.h b/include/linux/fs.h
> > > > index b379a46b5576..528e73f192ac 100644
> > > > --- a/include/linux/fs.h
> > > > +++ b/include/linux/fs.h
> > > > @@ -1782,7 +1782,8 @@ static inline void __sb_end_write(struct
> > > > super_block *sb, int level)
> > > >  static inline void __sb_start_write(struct super_block *sb, int
> > > > level)
> > > >  {
> > > >         percpu_down_read_freezable(sb->s_writers.rw_sem + level -
> > > > 1,
> > > > -                                  level == SB_FREEZE_WRITE);
> > > > +                                  (level == SB_FREEZE_WRITE ||
> > > > +                                   level ==
> > > > SB_FREEZE_PAGEFAULT));
> > > >  }
> > > 
> > > Yes, I was about to tell Jan that the condition here simply needs
> > > to be true.  All our rwsem levels need to be freezable to avoid a
> > > hibernation failure.
> > 
> > So there is one snag with this. SB_FREEZE_PAGEFAULT level is acquired
> > under mmap_sem, SB_FREEZE_INTERNAL level is possibly acquired under
> > some other filesystem locks.
> 
> Just for SB_FREEZE_INTERNAL, I think there's no case of
> sb_start_intwrite() that can ever hold in D wait because by the time we
> acquire the semaphore for write, the internal freeze_fs should have
> been called and the filesystem should have quiesced itself.  On the
> other hand, if that theory itself is true, there's no real need for
> sb_start_intwrite() at all because it can never conflict.

This is not true. Sure, userspace should all be blocked, dirty pages
written back, but you still have filesystem background tasks like lazy
initialization of inode tables, inode garbage collection, regular lazy
updates of statistics in the superblock. These generally happen from
kthreads / work queues and they can still be scheduled and executed
although freeze_super() has started blocking SB_FREEZE_WRITE and
SB_FREEZE_PAGEFAULT levels... And generally this freeze level is there
exactly because it needs to be acquired from locking context which doesn't
allow usage of SB_FREEZE_WRITE or SB_FREEZE_PAGEFAULT levels.

> >  So if you freeze the filesystem, a task can block on frozen
> > filesystem with e.g. mmap_sem held and if some other task then blocks
> > on grabbing that mmap_sem, hibernation fails because we'll be unable
> > to hibernate the task waiting for mmap_sem. So if you'd like to
> > completely avoid these hibernation failures, you'd have to make a
> > slew of filesystem related locks use freezable sleeping. I don't
> > think that's feasible.
> 
> I wouldn't see that because I'm on x86_64 and that takes the vma_lock
> in page faults not the mmap_lock.  The granularity of all these locks
> is process level, so it's hard to see what they'd be racing with ...

I agree that because of vma_lock it would be much harder to see this. But
as far as I remember mmap_sem is still a fallback option when we race with
VMA modification even for x86 so this problem is possible to hit, just much
more unlikely.

> even if I conjecture two threads trying to write to something, they'd
> have to have some internal co-ordination which would likely prevent the
> second one from writing if the first got stuck on the page fault. 
> 
> > I was hoping that failures due to SB_FREEZE_PAGEFAULT level not being
> > freezable would be rare enough but you've proven they are quite
> > frequent. We can try making SB_FREEZE_PAGEFAULT level (or even
> > SB_FREEZE_INTERNAL) freezable and see whether that works good
> > enough...
> 
> I'll try to construct a more severe test than systemd-journald ... it
> looks to be single threaded in its operation.

OK, thanks!

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

