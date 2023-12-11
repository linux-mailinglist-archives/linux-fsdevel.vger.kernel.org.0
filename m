Return-Path: <linux-fsdevel+bounces-5466-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8808D80C872
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Dec 2023 12:49:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37E2C281E98
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Dec 2023 11:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DEA238DDD;
	Mon, 11 Dec 2023 11:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="M4EVnJfN";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="I3qojihV";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="M4EVnJfN";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="I3qojihV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF239C7
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 Dec 2023 03:49:08 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id AC7391FB88;
	Mon, 11 Dec 2023 11:49:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1702295346; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=j5eNaVq99MzKxdifUjhmF8lkSdhuuXdMbCViavgVxnA=;
	b=M4EVnJfNQsE9NAyvdZwyrZ0xxEPPeir69xnYwgXRL0QeHfk3UYLQIugVN/9wBtgrMTA2cI
	1c6XKeltER3jEApcfAlzpXo03yvAcOFn3yM9+ni+uRBlCcMtUUqq3nb978JFAY3sbJQJLN
	UtWHCz4bMsgfAU9CY3ppJ+AJINumeCQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1702295346;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=j5eNaVq99MzKxdifUjhmF8lkSdhuuXdMbCViavgVxnA=;
	b=I3qojihViZxM4ldaSW4tkmGef8wY6tIkb3+q/IftDhqT9yhnDYkcJ9l369Kc/9F8tvgqef
	nN3VHi8Fef/3JuDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1702295346; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=j5eNaVq99MzKxdifUjhmF8lkSdhuuXdMbCViavgVxnA=;
	b=M4EVnJfNQsE9NAyvdZwyrZ0xxEPPeir69xnYwgXRL0QeHfk3UYLQIugVN/9wBtgrMTA2cI
	1c6XKeltER3jEApcfAlzpXo03yvAcOFn3yM9+ni+uRBlCcMtUUqq3nb978JFAY3sbJQJLN
	UtWHCz4bMsgfAU9CY3ppJ+AJINumeCQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1702295346;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=j5eNaVq99MzKxdifUjhmF8lkSdhuuXdMbCViavgVxnA=;
	b=I3qojihViZxM4ldaSW4tkmGef8wY6tIkb3+q/IftDhqT9yhnDYkcJ9l369Kc/9F8tvgqef
	nN3VHi8Fef/3JuDg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 84BA2138FF;
	Mon, 11 Dec 2023 11:49:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 1CNgIDL3dmX1OQAAn2gu4w
	(envelope-from <jack@suse.cz>); Mon, 11 Dec 2023 11:49:06 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id BAEE0A07E3; Mon, 11 Dec 2023 12:49:05 +0100 (CET)
Date: Mon, 11 Dec 2023 12:49:05 +0100
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>, Christoph Hellwig <hch@lst.de>,
	David Howells <dhowells@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 4/4] fsnotify: pass access range in file permission hooks
Message-ID: <20231211114905.jbmm7oxlmh3nt4j7@quack3>
References: <20231207123825.4011620-1-amir73il@gmail.com>
 <20231207123825.4011620-5-amir73il@gmail.com>
 <20231208185302.wkzvwthf5vuuuk3s@quack3>
 <CAOQ4uxi+6VMAdyREODOpMLiZ26Q_1R981H-eOwOA8gJsrsSqrA@mail.gmail.com>
 <CAOQ4uxiLtwp1QLQN1VBa10kLf4z+dx=UiDtB_WSqNXcoLYbvfw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxiLtwp1QLQN1VBa10kLf4z+dx=UiDtB_WSqNXcoLYbvfw@mail.gmail.com>
X-Spam-Score: 8.69
X-Spamd-Bar: ++++
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=M4EVnJfN;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=I3qojihV;
	dmarc=none;
	spf=softfail (smtp-out2.suse.de: 2a07:de40:b281:104:10:150:64:98 is neither permitted nor denied by domain of jack@suse.cz) smtp.mailfrom=jack@suse.cz
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [4.97 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 DMARC_NA(1.20)[suse.cz];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 R_SPF_SOFTFAIL(4.60)[~all];
	 NEURAL_SPAM_SHORT(2.98)[0.993];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[11];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FREEMAIL_TO(0.00)[gmail.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Score: 4.97
X-Rspamd-Queue-Id: AC7391FB88
X-Spam-Flag: NO

On Sun 10-12-23 15:24:00, Amir Goldstein wrote:
> > > > diff --git a/include/linux/fsnotify.h b/include/linux/fsnotify.h
> > > > index 0a9d6a8a747a..45e6ecbca057 100644
> > > > --- a/include/linux/fsnotify.h
> > > > +++ b/include/linux/fsnotify.h
> > > > @@ -103,7 +103,8 @@ static inline int fsnotify_file(struct file *file, __u32 mask)
> > > >  /*
> > > >   * fsnotify_file_perm - permission hook before file access
> > > >   */
> > > > -static inline int fsnotify_file_perm(struct file *file, int perm_mask)
> > > > +static inline int fsnotify_file_perm(struct file *file, int perm_mask,
> > > > +                                  const loff_t *ppos, size_t count)
> > > >  {
> > > >       __u32 fsnotify_mask = FS_ACCESS_PERM;
> > >
> > > Also why do you actually pass in loff_t * instead of plain loff_t? You
> > > don't plan to change it, do you?
> >
> > No I don't.
> 
> Please note that the pointer is to const loff_t.
> 
> >
> > I used NULL to communicate "no range info" to fanotify.
> > It is currently only used from iterate_dir(), but filesystems may need to
> > use that to report other cases of pre-content access with no clear range info.
> 
> Correction. iterate_dir() is not the only case.
> The callers that use file_ppos(), namely ksys_{read,write}, do_{readv,writev}()
> will pass a NULL ppos for an FMODE_STREAM file.
> The only sane behavior I could come up with for those cases
> is to not report range_info with the FAN_PRE_ACCESS event.

OK, understood. But isn't anything with len == 0 in fact "no valid range
provided" case? So we could use that to identify a case where we simply
don't report any range with the event without a need to pass the pointer?

> > I could leave fsnotify_file_perm(file, mask) for reporting events without
> > range info and add fsnotify_file_area(file, mask, pos, count) for reporting
> > access permission with range info.
> >
> 
> I renamed the hook in v2 to fsnotify_file_area_perm() and added a wrapper:
> 
> static inline int fsnotify_file_perm(struct file *file, int perm_mask)
> {
>         return fsnotify_file_area_perm(file, perm_mask, NULL, 0);
> }

Otherwise this works for me as well.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

