Return-Path: <linux-fsdevel+bounces-63177-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D4F5BB06AD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 01 Oct 2025 15:08:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36B84189D840
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Oct 2025 13:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EF3D2EC568;
	Wed,  1 Oct 2025 13:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="C73SZ3ou";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="T54pUyfT";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ugGB9i4n";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="lgKgLzzr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F18B02EC54D
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Oct 2025 13:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759324087; cv=none; b=tI55rB6/C0BMv4gnIdpV4aDknyPvSFOlsM7xthzVBUuXslB5HavsDspF/MZD/VFh1ojlGUL4PW5vMbcXUQNGo+wakq01ACGxfWtFGspUvfEIk1oifuQZcYtzcLXstQQ4LgHU7rb4WZW4pWuOhFyH3UDeTkVX6lyVbG+UpBYT9f4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759324087; c=relaxed/simple;
	bh=5DLcHOoX9VrKRa+fcanJh9nwu+xxw6WNlyYp9tKftF4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EHflHxjXYM2jdYcU9yJ4IKXQ82jXCKoQGVmDN8lauGEHyftaJs6th3u2JEgIg4BiQRvX1atQXo4ty2rDdd3RD80f05L6ogCGNmGoUV/viszW2M5C5RwBaC/N94L7dqwT//ElR9YWfy3NDVV9Vni7fpqjFWM9GxvNlBpn5J8PecU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=C73SZ3ou; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=T54pUyfT; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ugGB9i4n; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=lgKgLzzr; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8D6B71FB66;
	Wed,  1 Oct 2025 13:08:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1759324083; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iE6s1H1dfuzBde0bw3bQ07y/kyptyyDWPHTywqdSxQE=;
	b=C73SZ3outgK4mQS4I4+1ZHk2Eypnp+02eeC0yJt9T4RKXkgfrLtF2XMZ3QYHijLht07xzo
	kNQqntAPmMSyCOi2VJbpbiIP2egoPxUlBuCItMzuhE7BCkmEcR8QwmV23dPOBALzaTYlUh
	aEP3my+QSkYWTqX9bkuU6J/Kp93/3q0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1759324083;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iE6s1H1dfuzBde0bw3bQ07y/kyptyyDWPHTywqdSxQE=;
	b=T54pUyfT6XxVwf8wIwAnLT3unxuFqBGUd+/1fQW2+YweA25yIi3VA3Gq6KdieN1guh5DXX
	oEpQmbGUvTFxAtAw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=ugGB9i4n;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=lgKgLzzr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1759324082; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iE6s1H1dfuzBde0bw3bQ07y/kyptyyDWPHTywqdSxQE=;
	b=ugGB9i4nrvaCXQLUE1GiGbWKQWCw4veUIf8IFBraUNiE2CSa6B5tea9DAX6BC6kIIz0H2G
	k//EBsWAPpcv8qK5uLeGShR783T9ugStnHx3pL973RaskqxQe+e72hmOG5tt6XLNDavLVf
	1Hoamwt/YumTO8RuKvKBGmBCVnLUuQA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1759324082;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iE6s1H1dfuzBde0bw3bQ07y/kyptyyDWPHTywqdSxQE=;
	b=lgKgLzzrzq1h/XxcpFycm3PPEcQz2c5ysZrDE6tf4uI40vzPFsUCnN4GjPne4t3en5U5wv
	l3mqQRuUKjt6iRAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 81B4213A3F;
	Wed,  1 Oct 2025 13:08:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ZcKhH7In3WjXDAAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 01 Oct 2025 13:08:02 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 2C315A094B; Wed,  1 Oct 2025 15:07:58 +0200 (CEST)
Date: Wed, 1 Oct 2025 15:07:58 +0200
From: Jan Kara <jack@suse.cz>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Jan Kara <jack@suse.cz>, brauner@kernel.org, viro@zeniv.linux.org.uk, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: assert on ->i_count in iput_final()
Message-ID: <7ck3szsab4zb3uzgh6aub5kmvm2slold5la2oyi264klwjel36@crjlqzwdmrgh>
References: <20251001010010.9967-1-mjguzik@gmail.com>
 <zvd5obgxrkbqeifnuvvvhhjeh7t4cveziipwoii3hjaztxytpa@qlcxp4l2r5jg>
 <CAGudoHHZL0g9=eRqjUOS2sez8Mew7r1TRWaR+uX-7YuYomd3WA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGudoHHZL0g9=eRqjUOS2sez8Mew7r1TRWaR+uX-7YuYomd3WA@mail.gmail.com>
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 8D6B71FB66
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FREEMAIL_TO(0.00)[gmail.com];
	URIBL_BLOCKED(0.00)[suse.cz:dkim,suse.cz:email,suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCPT_COUNT_FIVE(0.00)[6];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim,suse.cz:email,suse.com:email]
X-Spam-Score: -4.01

On Wed 01-10-25 14:12:13, Mateusz Guzik wrote:
> On Wed, Oct 1, 2025 at 2:07 PM Jan Kara <jack@suse.cz> wrote:
> > > diff --git a/fs/inode.c b/fs/inode.c
> > > index ec9339024ac3..fa82cb810af4 100644
> > > --- a/fs/inode.c
> > > +++ b/fs/inode.c
> > > @@ -1879,6 +1879,7 @@ static void iput_final(struct inode *inode)
> > >       int drop;
> > >
> > >       WARN_ON(inode->i_state & I_NEW);
> > > +     VFS_BUG_ON_INODE(atomic_read(&inode->i_count) != 0, inode);
> >
> > This seems pointless given when iput_final() is called...
> >
> 
> This and the other check explicitly "wrap" the ->drop_inode call.

I understand but given iput() has just decremented i_count to 0 before
calling iput_final() this beginning of the "wrap" looks pretty pointless to
me.

> > >       if (op->drop_inode)
> > >               drop = op->drop_inode(inode);
> > > @@ -1893,6 +1894,12 @@ static void iput_final(struct inode *inode)
> > >               return;
> > >       }
> > >
> > > +     /*
> > > +      * Re-check ->i_count in case the ->drop_inode() hooks played games.
> > > +      * Note we only execute this if the verdict was to drop the inode.
> > > +      */
> > > +     VFS_BUG_ON_INODE(atomic_read(&inode->i_count) != 0, inode);
> > > +
> >
> > I'm not sure this can catch much but OK...
> >
> 
> It can catch drop routines which bumped the ref but did not release
> it, or which indicated to continue with drop while someone else
> snatched the reference.

Right. 

> Preferaby the APIs would prevent that in the first place, but there is
> quite a bit of shit-shoveling before that happens.

Agreed.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

