Return-Path: <linux-fsdevel+bounces-7118-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A33C7821D09
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jan 2024 14:48:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45C3728361C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jan 2024 13:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA83AFC16;
	Tue,  2 Jan 2024 13:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Gd9hn96C";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="lf4aYHUL";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Gd9hn96C";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="lf4aYHUL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22DA10940;
	Tue,  2 Jan 2024 13:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BBA4A21FD3;
	Tue,  2 Jan 2024 13:47:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704203271; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Fn91W3IuOvD77xTkollMSFA//O+slhWPewfM4nu/8YY=;
	b=Gd9hn96CbvxDZREN/9vBcxFp5oo63p8ln1MRJHJFNTW8bBR4ynjNMEH6Tltih8fDHCtoA+
	FMu7UYsuCF8rwhDzD5q475ALaJsFqYkmcwCXqWxyPFcYtrWYpanBj5JJSBGxm1t8MkPSyz
	+peYwb8+F7ck4OD/42Jba7iTzRTzUdo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704203271;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Fn91W3IuOvD77xTkollMSFA//O+slhWPewfM4nu/8YY=;
	b=lf4aYHULWqzaj7W0XVWI941+Kj4b88tYBjE2svC80AKn70RYPZdJpAnb7LJX7cedUIZh+I
	fUo3jfFhB0zI2pBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704203271; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Fn91W3IuOvD77xTkollMSFA//O+slhWPewfM4nu/8YY=;
	b=Gd9hn96CbvxDZREN/9vBcxFp5oo63p8ln1MRJHJFNTW8bBR4ynjNMEH6Tltih8fDHCtoA+
	FMu7UYsuCF8rwhDzD5q475ALaJsFqYkmcwCXqWxyPFcYtrWYpanBj5JJSBGxm1t8MkPSyz
	+peYwb8+F7ck4OD/42Jba7iTzRTzUdo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704203271;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Fn91W3IuOvD77xTkollMSFA//O+slhWPewfM4nu/8YY=;
	b=lf4aYHULWqzaj7W0XVWI941+Kj4b88tYBjE2svC80AKn70RYPZdJpAnb7LJX7cedUIZh+I
	fUo3jfFhB0zI2pBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B054313AC6;
	Tue,  2 Jan 2024 13:47:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qNP9KgcUlGWqVQAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 02 Jan 2024 13:47:51 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 3D0A6A07EF; Tue,  2 Jan 2024 14:47:51 +0100 (CET)
Date: Tue, 2 Jan 2024 14:47:51 +0100
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Su Hui <suhui@nfschina.com>, jack@suse.cz, repnop@google.com,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] fanotify: avoid possible NULL dereference
Message-ID: <20240102134751.2flliwe4lfvp3r5a@quack3>
References: <20230808091849.505809-1-suhui@nfschina.com>
 <CAOQ4uxhtZSr-kq3G1vmm4=GyBO3E5RdSbGSp108moRiRBx4vvg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxhtZSr-kq3G1vmm4=GyBO3E5RdSbGSp108moRiRBx4vvg@mail.gmail.com>
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -2.12
X-Spamd-Result: default: False [-2.12 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-0.997];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 FREEMAIL_TO(0.00)[gmail.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-1.32)[90.27%]
X-Spam-Flag: NO

On Thu 10-08-23 20:58:16, Amir Goldstein wrote:
> On Tue, Aug 8, 2023 at 12:19 PM Su Hui <suhui@nfschina.com> wrote:
> >
> > smatch error:
> > fs/notify/fanotify/fanotify_user.c:462 copy_fid_info_to_user():
> > we previously assumed 'fh' could be null (see line 421)
> >
> > Fixes: afc894c784c8 ("fanotify: Store fanotify handles differently")
> > Signed-off-by: Su Hui <suhui@nfschina.com>'
> 
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>

I'm sorry but this has somehow fallen through the cracks. 

> > diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
> > index f69c451018e3..5a5487ae2460 100644
> > --- a/fs/notify/fanotify/fanotify_user.c
> > +++ b/fs/notify/fanotify/fanotify_user.c
> > @@ -459,12 +459,13 @@ static int copy_fid_info_to_user(__kernel_fsid_t *fsid, struct fanotify_fh *fh,
> >         if (WARN_ON_ONCE(len < sizeof(handle)))
> >                 return -EFAULT;
> >
> > -       handle.handle_type = fh->type;
> >         handle.handle_bytes = fh_len;

Well, if passed 'fh' is NULL, we have problems later in the function
anyway. E.g. in fanotify_fh_buf() a few lines below. So I think this needs
a bit more work that just this small fixup...

								Honza

> >
> >         /* Mangle handle_type for bad file_handle */
> >         if (!fh_len)
> >                 handle.handle_type = FILEID_INVALID;
> > +       else
> > +               handle.handle_type = fh->type;
> >
> >         if (copy_to_user(buf, &handle, sizeof(handle)))
> >                 return -EFAULT;
> > --
> > 2.30.2
> >
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

