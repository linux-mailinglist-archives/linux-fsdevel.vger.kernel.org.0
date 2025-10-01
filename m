Return-Path: <linux-fsdevel+bounces-63192-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D1C93BB0FFD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 01 Oct 2025 17:14:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57BF9164BB0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Oct 2025 15:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0909C262815;
	Wed,  1 Oct 2025 15:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="fqMa9ANg";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="lTnycNce";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="fqMa9ANg";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="lTnycNce"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BADA23E356
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Oct 2025 15:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759331498; cv=none; b=pzGLg1OliXUzZ0Bg148/Qtj8cp0+yno+RDFvzyeiUi6EkU4fHSalO29hEGtZpiLeYWPoAzpbk7hVnSlnB1wR9FecKNDQfQXXwH2XZfN15m9k1bQy9w2k2sXuQCyYpBxufM8E3RE1YUmYbd4MHRydzfmDNRdfy1vR0E74mi6Ju+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759331498; c=relaxed/simple;
	bh=N9XbOvaQpBB2JsUJfMZYIHfglFUb3sxkfdkeZu7/gcU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hax+t6t7GoHkiAZGLDDpz9K3oBSce/wUccYa6VFemXGVGfCzXtKYFCXILMOucgNun6CqHqWT6aWY3HFyojlq0rgz5dbxu4ykljissADNmam1fr8rHLZ7ksM4XJmttqZJADX9Ej26k4C17wWNnKk//PU1u4Xr3t5jLcAW2zajnVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=fqMa9ANg; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=lTnycNce; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=fqMa9ANg; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=lTnycNce; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8FD371FB3B;
	Wed,  1 Oct 2025 15:11:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1759331494; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZrZzpyV5kFd/czh9AtHu5PTQZcC98XNeK6LlTDC9PSY=;
	b=fqMa9ANgCrJNAhr0848HfFzGkekGC8mBzlcKCXdbhiUTOiOsVMygdp+5wZCoDUqGR3SbST
	m2tZCcMjggFz6rmvDxWNov+Ymw3u6mB9LPbm7khz5RD/cE77r994kPBS3reH0XNDUnrqZi
	av9YykXaDt8C+9oETv4dAU0v5yi2FX4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1759331494;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZrZzpyV5kFd/czh9AtHu5PTQZcC98XNeK6LlTDC9PSY=;
	b=lTnycNceVAza6D72+p7T+Tl1w404buAhdCtKqizrfkLXO8tWYdcPwRw//BR1nPPEUyAglQ
	gcubN8PY/N4eQiBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1759331494; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZrZzpyV5kFd/czh9AtHu5PTQZcC98XNeK6LlTDC9PSY=;
	b=fqMa9ANgCrJNAhr0848HfFzGkekGC8mBzlcKCXdbhiUTOiOsVMygdp+5wZCoDUqGR3SbST
	m2tZCcMjggFz6rmvDxWNov+Ymw3u6mB9LPbm7khz5RD/cE77r994kPBS3reH0XNDUnrqZi
	av9YykXaDt8C+9oETv4dAU0v5yi2FX4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1759331494;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZrZzpyV5kFd/czh9AtHu5PTQZcC98XNeK6LlTDC9PSY=;
	b=lTnycNceVAza6D72+p7T+Tl1w404buAhdCtKqizrfkLXO8tWYdcPwRw//BR1nPPEUyAglQ
	gcubN8PY/N4eQiBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6FA8F13A3F;
	Wed,  1 Oct 2025 15:11:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id aXg8G6ZE3WhBNAAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 01 Oct 2025 15:11:34 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 845ACA094F; Wed,  1 Oct 2025 17:11:33 +0200 (CEST)
Date: Wed, 1 Oct 2025 17:11:33 +0200
From: Jan Kara <jack@suse.cz>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Jan Kara <jack@suse.cz>, brauner@kernel.org, viro@zeniv.linux.org.uk, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: assert on ->i_count in iput_final()
Message-ID: <yobncpbrbe6ctjdtkpiff6u2uiq5fmoov6lhcyj5nvhawengny@5j5r2alelmug>
References: <20251001010010.9967-1-mjguzik@gmail.com>
 <zvd5obgxrkbqeifnuvvvhhjeh7t4cveziipwoii3hjaztxytpa@qlcxp4l2r5jg>
 <CAGudoHHZL0g9=eRqjUOS2sez8Mew7r1TRWaR+uX-7YuYomd3WA@mail.gmail.com>
 <7ck3szsab4zb3uzgh6aub5kmvm2slold5la2oyi264klwjel36@crjlqzwdmrgh>
 <CAGudoHFAar2rHaCDWP4uD2QD_BO42-Fi6b9uxwFvHTmkXTCQfA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGudoHFAar2rHaCDWP4uD2QD_BO42-Fi6b9uxwFvHTmkXTCQfA@mail.gmail.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -3.80

On Wed 01-10-25 16:28:15, Mateusz Guzik wrote:
> On Wed, Oct 1, 2025 at 3:08 PM Jan Kara <jack@suse.cz> wrote:
> >
> > On Wed 01-10-25 14:12:13, Mateusz Guzik wrote:
> > > On Wed, Oct 1, 2025 at 2:07 PM Jan Kara <jack@suse.cz> wrote:
> > > > > diff --git a/fs/inode.c b/fs/inode.c
> > > > > index ec9339024ac3..fa82cb810af4 100644
> > > > > --- a/fs/inode.c
> > > > > +++ b/fs/inode.c
> > > > > @@ -1879,6 +1879,7 @@ static void iput_final(struct inode *inode)
> > > > >       int drop;
> > > > >
> > > > >       WARN_ON(inode->i_state & I_NEW);
> > > > > +     VFS_BUG_ON_INODE(atomic_read(&inode->i_count) != 0, inode);
> > > >
> > > > This seems pointless given when iput_final() is called...
> > > >
> > >
> > > This and the other check explicitly "wrap" the ->drop_inode call.
> >
> > I understand but given iput() has just decremented i_count to 0 before
> > calling iput_final() this beginning of the "wrap" looks pretty pointless to
> > me.
> >
> 
> To my understanding you are not NAKing the patch, are merely not
> particularly fond of it. ;)

Yes, it isn't annoying me enough to nak it but I couldn't resist
complaining :)

> Given that these asserts don't show up in production kernels, the
> layer should be moving towards always spelling out all assumptions at
> the entry point. Worst case does not hurt in production anyway, best
> case it will catch something.

Well, I think that when we get too many asserts, the code is harder to
read.

> For iput_final specifically, at the moment there is only one consumer
> so this indeed may look overzealous.
> 
> But for the sake of argument suppose someone noticed that
> dentry_unlink_inode() performs:
>         spin_unlock(&inode->i_lock);
>         if (!inode->i_nlink)
>                 fsnotify_inoderemove(inode);
>         if (dentry->d_op && dentry->d_op->d_iput)
>                 dentry->d_op->d_iput(dentry, inode);
>         else
>                 iput(inode);
> 
> ... and that with some minor rototoiling the inode lock can survive
> both fsnotify and custom d_iput in the common case. Should that
> happen, iput_locked() could be added to shave off a lock trip in the
> common case of whacking the inode. But then there is 2 consumers of
> iput_final. etc.

Right. And when we grow second iput_final() caller, I'd withdraw my
complaint about pointless assert ;).

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

