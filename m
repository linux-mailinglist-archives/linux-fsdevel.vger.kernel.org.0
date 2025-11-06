Return-Path: <linux-fsdevel+bounces-67270-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C4E74C39CE3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 06 Nov 2025 10:25:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4918935067C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Nov 2025 09:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EAB830BB87;
	Thu,  6 Nov 2025 09:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="UE0J+gbg";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="RFadnBqJ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="UE0J+gbg";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="RFadnBqJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6249C30BF58
	for <linux-fsdevel@vger.kernel.org>; Thu,  6 Nov 2025 09:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762421090; cv=none; b=fNSfxumt3jnBW7pqVyRHeQXJ0SGjR7HCjZsZZF5046ufZKp+eblFaOSY0TfsDEf0CgeyOl99ZQrsBFvC1cupt5OB7XoNPZ/DQI50ObzNUMi3j4khmlpqFB3fm9d8bXc5Ko6RamuT1nhef2J+JeMOXqPopvP1hHbGzHXyHv0hl40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762421090; c=relaxed/simple;
	bh=7bJ5qJttfQJKBc0MB3rn6hspKUOagptxg/C8vQlss78=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UpY7+oFS5YyR2U8Ax9lMAi+wtmd86r2wkJfO2v0heZt5xs1iEddKJzM7ZlZQfPB4GXzhrE3roi7VFpd4Svnad2dSie5feXcQWbm0qpjwp05CSLJQCUoXVVVoXNKc3JUEigFN/VjBA0BurC3EPiQNDBDAu6A7AeU26TN6c22pBZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=UE0J+gbg; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=RFadnBqJ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=UE0J+gbg; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=RFadnBqJ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2FEDA1F457;
	Thu,  6 Nov 2025 09:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762421081; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=v/YrHEvc8gVeJ9aboOAbmD9J9A1DDwTG3TFGxeCLdak=;
	b=UE0J+gbgOPcmB85ZJdiHFm9YvaF2TJyy/WGNOAmfto77nDfDIxVOwEApB07dqK4Gx2sUIp
	cR/uryaOhjMePAfvQDYHNYpBYXsoiCgP1w47Td+769g8NL3dLXNhd1PHyJjvzrlTljy0qq
	euhuMVHzZo9FNVUfGp5O2YJzvkf3jpw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762421081;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=v/YrHEvc8gVeJ9aboOAbmD9J9A1DDwTG3TFGxeCLdak=;
	b=RFadnBqJHFgvyMyjJsWo9QF3A1UD+bx++PZTMS2863DlKsquniVoCWXRSFrh3BKfrWy5wU
	vb4BZsiubx8+IMBg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=UE0J+gbg;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=RFadnBqJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762421081; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=v/YrHEvc8gVeJ9aboOAbmD9J9A1DDwTG3TFGxeCLdak=;
	b=UE0J+gbgOPcmB85ZJdiHFm9YvaF2TJyy/WGNOAmfto77nDfDIxVOwEApB07dqK4Gx2sUIp
	cR/uryaOhjMePAfvQDYHNYpBYXsoiCgP1w47Td+769g8NL3dLXNhd1PHyJjvzrlTljy0qq
	euhuMVHzZo9FNVUfGp5O2YJzvkf3jpw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762421081;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=v/YrHEvc8gVeJ9aboOAbmD9J9A1DDwTG3TFGxeCLdak=;
	b=RFadnBqJHFgvyMyjJsWo9QF3A1UD+bx++PZTMS2863DlKsquniVoCWXRSFrh3BKfrWy5wU
	vb4BZsiubx8+IMBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1A426139A9;
	Thu,  6 Nov 2025 09:24:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wSBhBllpDGnNEAAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 06 Nov 2025 09:24:41 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id BC7D7A0927; Thu,  6 Nov 2025 10:24:40 +0100 (CET)
Date: Thu, 6 Nov 2025 10:24:40 +0100
From: Jan Kara <jack@suse.cz>
To: Daniel Vacek <neelx@suse.com>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-btrfs@vger.kernel.org, 
	linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH RFC 5/8] ext4: use super write guard in write_mmp_block()
Message-ID: <5puaizn2a4dpoinvkct2nz5zdvvv5vdrlrmwcz7j6vl7qrxicb@b4qi4yfk4a5u>
References: <20251104-work-guards-v1-0-5108ac78a171@kernel.org>
 <20251104-work-guards-v1-5-5108ac78a171@kernel.org>
 <CAPjX3FeEZd7gX1OeCxRXrdBMafHOONB2WQO_JOZuxKoVEygzuQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPjX3FeEZd7gX1OeCxRXrdBMafHOONB2WQO_JOZuxKoVEygzuQ@mail.gmail.com>
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 2FEDA1F457
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
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_THREE(0.00)[3];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Score: -4.01

On Wed 05-11-25 19:33:35, Daniel Vacek wrote:
> On Tue, 4 Nov 2025 at 13:16, Christian Brauner <brauner@kernel.org> wrote:
> >
> > Signed-off-by: Christian Brauner <brauner@kernel.org>
> > ---
> >  fs/ext4/mmp.c | 8 ++------
> >  1 file changed, 2 insertions(+), 6 deletions(-)
> >
> > diff --git a/fs/ext4/mmp.c b/fs/ext4/mmp.c
> > index ab1ff51302fb..6f57c181ff77 100644
> > --- a/fs/ext4/mmp.c
> > +++ b/fs/ext4/mmp.c
> > @@ -57,16 +57,12 @@ static int write_mmp_block_thawed(struct super_block *sb,
> >
> >  static int write_mmp_block(struct super_block *sb, struct buffer_head *bh)
> >  {
> > -       int err;
> > -
> >         /*
> >          * We protect against freezing so that we don't create dirty buffers
> >          * on frozen filesystem.
> >          */
> > -       sb_start_write(sb);
> > -       err = write_mmp_block_thawed(sb, bh);
> > -       sb_end_write(sb);
> > -       return err;
> > +       scoped_guard(super_write, sb)
> > +               return write_mmp_block_thawed(sb, bh);
> 
> Why the scoped_guard here? Should the simple guard(super_write)(sb) be
> just as fine here?

Not sure about Ted but I prefer scoped_guard() to plain guard() because the
scoping makes it more visually obvious where the unlocking happens. Of
course there has to be a balance as the indentation level can go through
the roof but that's not the case here...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

