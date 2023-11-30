Return-Path: <linux-fsdevel+bounces-4427-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6D597FF666
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 17:41:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66275B209F0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 16:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAA705576F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 16:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="udaPQdQ1";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="lSkn4n/v"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2a07:de40:b251:101:10:150:64:1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55EB01700
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Nov 2023 07:50:10 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BCBE921B2C;
	Thu, 30 Nov 2023 15:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1701359408; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RXQOyRSZ4+z9d25KPXgpAY79SSgPZt65cavWE2ExKYk=;
	b=udaPQdQ1jq7iUvckss7rzPhdX5syper74Kg0LH49qDPVcioWcNC1FOjGHWBByyGetK6WV9
	x8rCcQhWmDCj+eMtxemybVpAfsEqleDlsPK79z0zCU9qwkbodJ4cmukKDc6XYujs8/ClHf
	+H7ptTRHr22Zrq0icRWQs+qHrKA9ulw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1701359408;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RXQOyRSZ4+z9d25KPXgpAY79SSgPZt65cavWE2ExKYk=;
	b=lSkn4n/v1VXdqbFTX9RzkZ6NGbpktPofy0sso6ao52moUcnJHxlNHVp3uD/CBlNsAClV9z
	pVkZxtouL7Nc6CDw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id A995E13A5C;
	Thu, 30 Nov 2023 15:50:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id pSliKTCvaGXUCAAAn2gu4w
	(envelope-from <jack@suse.cz>); Thu, 30 Nov 2023 15:50:08 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id F1D7EA07E0; Thu, 30 Nov 2023 16:50:07 +0100 (CET)
Date: Thu, 30 Nov 2023 16:50:07 +0100
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/2] fanotify: store fsid in mark instead of in connector
Message-ID: <20231130155007.q3rwbwugeepowh55@quack3>
References: <20231118183018.2069899-1-amir73il@gmail.com>
 <20231118183018.2069899-2-amir73il@gmail.com>
 <20231130142539.g4hhcsk4hk2oimdv@quack3>
 <CAOQ4uxhOc0JBQ6JcHfHxOfi57OzHWdK=i-onP8++pX2PuAdw3Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxhOc0JBQ6JcHfHxOfi57OzHWdK=i-onP8++pX2PuAdw3Q@mail.gmail.com>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -2.66
X-Spamd-Result: default: False [-2.66 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email];
	 FREEMAIL_TO(0.00)[gmail.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-2.06)[95.42%]

On Thu 30-11-23 17:29:02, Amir Goldstein wrote:
> On Thu, Nov 30, 2023 at 4:25 PM Jan Kara <jack@suse.cz> wrote:
> > > @@ -530,6 +528,7 @@ struct fsnotify_mark {
> > >  #define FSNOTIFY_MARK_FLAG_IGNORED_SURV_MODIFY       0x0100
> > >  #define FSNOTIFY_MARK_FLAG_NO_IREF           0x0200
> > >  #define FSNOTIFY_MARK_FLAG_HAS_IGNORE_FLAGS  0x0400
> > > +#define FSNOTIFY_MARK_FLAG_HAS_FSID          0x0800
> > >       unsigned int flags;             /* flags [mark->lock] */
> > >  };
> >
> > So this flag is in fact private to fanotify notification framework. Either
> > we could just drop this flag and use
> >
> >   FANOTIFY_MARK(mark)->fsid[0] != 0 || FANOTIFY_MARK(mark)->fsid[1] != 0
> 
> Cannot.
> Zero fsid is now a valid fsid in an inode mark (e.g. fuse).
> The next patch also adds the flag FSNOTIFY_MARK_FLAG_WEAK_FSID

Yeah, I've realized that once I've digested the second patch.

> > instead or we could at least add a comment that this flags is in fact
> > private to fanotify?
> 
> There is already a comment, because all the flags above are fanotify flags:
> 
>         /* fanotify mark flags */
> #define FSNOTIFY_MARK_FLAG_IGNORED_SURV_MODIFY  0x0100
> #define FSNOTIFY_MARK_FLAG_NO_IREF              0x0200
> #define FSNOTIFY_MARK_FLAG_HAS_IGNORE_FLAGS     0x0400

Right, I should have checked more that the diff context ;) Sorry for the
noise.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

