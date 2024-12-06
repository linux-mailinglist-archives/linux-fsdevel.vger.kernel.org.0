Return-Path: <linux-fsdevel+bounces-36645-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BFF79E7422
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2024 16:32:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E1A7281833
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2024 15:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CEE7207E17;
	Fri,  6 Dec 2024 15:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="AkxJrcKa";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="rYKTUp0D";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="AkxJrcKa";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="rYKTUp0D"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8204462171;
	Fri,  6 Dec 2024 15:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733499154; cv=none; b=dNTaSCg/Hgv1JviYFWplJwjHwqf9iADOGA8OZnE5EEdIb2kBo2CTSmGNbsULNvoHErI8MJkJav7r0c8PvnVjvq1iAbL6gvH0Poisd0d8bVrRjSi1Vsa09C+FaHFj15YFGzmyrhhPx/eZvvJj7EFwJMeuK8UujonV1FAYabzSfZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733499154; c=relaxed/simple;
	bh=tzczW2NaBtH/TqyTYWpEi1peWqluiHajhsHRLcDS+Lw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tet+DoSb6Q/qfNqK7jrfIwLtuPzY1cmXmJ9Dy/QBme7vLwzOkhWFJ0XZfCR35yixaP/MLAv9HSLV9CuL/fMrpyZEc07AV+TedJKsOIfTnuoE2ueFUS+L/Ay8Knxihr3LRg9GsTXGIN/EW3jUAx38UL0WM0jQK4nZ49Wra9fWTrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=AkxJrcKa; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=rYKTUp0D; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=AkxJrcKa; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=rYKTUp0D; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A78C01F37E;
	Fri,  6 Dec 2024 15:32:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733499150; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gFRnd9sjo2xH2tQED/Tut4UkToLXL+o1pumphDRBYEE=;
	b=AkxJrcKaRWSRTUyebc4BNqsWEqRLVml3zw17Ebdd7bsDwZXT/LDfQMtV3XJ6GPLwCmGyuX
	6qlJt3IJVwZ5Uqsig9tBqKnmntbu4WUgwKkbkTB4gE+i23VVvqK3ojKoL5PaSuVP9qoBSO
	tS95ep1fcVrNMavWO/YNgQxYGkDC5ww=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733499150;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gFRnd9sjo2xH2tQED/Tut4UkToLXL+o1pumphDRBYEE=;
	b=rYKTUp0D/fxGj4yRqY8/V4BmmllSxdrJ09Z1msMPhS9CYnC+y8MEYaxJzIVEYHF0Ylr9ni
	BS5YhsWB4wy6bUBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733499150; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gFRnd9sjo2xH2tQED/Tut4UkToLXL+o1pumphDRBYEE=;
	b=AkxJrcKaRWSRTUyebc4BNqsWEqRLVml3zw17Ebdd7bsDwZXT/LDfQMtV3XJ6GPLwCmGyuX
	6qlJt3IJVwZ5Uqsig9tBqKnmntbu4WUgwKkbkTB4gE+i23VVvqK3ojKoL5PaSuVP9qoBSO
	tS95ep1fcVrNMavWO/YNgQxYGkDC5ww=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733499150;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gFRnd9sjo2xH2tQED/Tut4UkToLXL+o1pumphDRBYEE=;
	b=rYKTUp0D/fxGj4yRqY8/V4BmmllSxdrJ09Z1msMPhS9CYnC+y8MEYaxJzIVEYHF0Ylr9ni
	BS5YhsWB4wy6bUBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9213713647;
	Fri,  6 Dec 2024 15:32:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id y/ugIw4ZU2cZfAAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 06 Dec 2024 15:32:30 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 4C868A08CD; Fri,  6 Dec 2024 16:32:30 +0100 (CET)
Date: Fri, 6 Dec 2024 16:32:30 +0100
From: Jan Kara <jack@suse.cz>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Jan Kara <jack@suse.cz>, paulmck@kernel.org, brauner@kernel.org,
	viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
	torvalds@linux-foundation.org, edumazet@google.com,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] fs: elide the smp_rmb fence in fd_install()
Message-ID: <20241206153230.6o37z5raxvohbqqm@quack3>
References: <CAGudoHG6zYMfFmhizJDPAw=CF8QY8dzbvg0cSEW4XVcvTYhELw@mail.gmail.com>
 <20241205120332.1578562-1-mjguzik@gmail.com>
 <20241205144645.bv2q6nqua66sql3j@quack3>
 <CAGudoHGtOX+XPM5Z5eWd-feCvNZQ+nv0u6iY9zqGVMhPunLXqA@mail.gmail.com>
 <20241205152937.v2uf65wcmnkutiqz@quack3>
 <CAGudoHGyFVCjSTjenyO8Y+uPHyhkOCwZrvBW=FyQRDundntFdw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGudoHGyFVCjSTjenyO8Y+uPHyhkOCwZrvBW=FyQRDundntFdw@mail.gmail.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-0.998];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Score: -3.80
X-Spam-Flag: NO

On Thu 05-12-24 16:36:40, Mateusz Guzik wrote:
> On Thu, Dec 5, 2024 at 4:29 PM Jan Kara <jack@suse.cz> wrote:
> > On Thu 05-12-24 16:01:07, Mateusz Guzik wrote:
> > > Suppose the CPU reordered loads of the flag and the fd table. There is
> > > no ordering in which it can see both the old table and the unset flag.
> >
> > But I disagree here. If the reads are reordered, then the fd table read can
> > happen during the "flag is true and the fd table is old" state and the flag
> > read can happen later in "flag is false and the fd table is new" state.
> > Just as I outlined above...

Ugh, I might be missing something obvious so please bear with me.

> In your example all the work happens *after* synchronize_rcu().

Correct.

> The thread resizing the table already published the result even before
> calling into it.

Really? You proposed expand_table() does:

       BUG_ON(files->resize_in_progress);
       files->resize_in_progress = true;
       spin_unlock(&files->file_lock);
       new_fdt = alloc_fdtable(nr + 1);
       if (atomic_read(&files->count) > 1)
               synchronize_rcu();

       spin_lock(&files->file_lock);
       if (IS_ERR(new_fdt)) {
               err = PTR_ERR(new_fdt);
               goto out;
       }
       cur_fdt = files_fdtable(files);
       BUG_ON(nr < cur_fdt->max_fds);
       copy_fdtable(new_fdt, cur_fdt);
       rcu_assign_pointer(files->fdt, new_fdt);
       if (cur_fdt != &files->fdtab)
               call_rcu(&cur_fdt->rcu, free_fdtable_rcu);
       smp_wmb();
out:
       files->resize_in_progress = false;
       return err;

So synchronize_rcu() is called very early AFAICT. At that point we have
allocated the new table but copy & store in files->fdt happens *after*
synchronize_rcu() has finished. So the copy & store can be racing with
fd_install() calling rcu_read_lock_sched() and prefetching files->fdt (but
not files->resize_in_progress!) into a local CPU cache.

> Furthermore by the time synchronize_rcu returns
> everyone is guaranteed to have issued a full fence. Meaning nobody can
> see the flag as unset.

Well, nobody can see the flag unset only until expand_fdtable() reaches:

       smp_wmb();
out:
       files->resize_in_progress = false;
 
And smp_wmb() doesn't give you much unless the reads of
files->resize_in_progress and files->fdt are ordered somehow on the other
side (i.e., in fd_install()).

But I'm looking forward to the Litmus test to resolve our discussion :)

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

