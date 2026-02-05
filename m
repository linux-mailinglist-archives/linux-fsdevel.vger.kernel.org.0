Return-Path: <linux-fsdevel+bounces-76406-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GFjXJpOEhGl/3AMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76406-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Feb 2026 12:52:51 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 51F8FF2122
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Feb 2026 12:52:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 13B3D301D951
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Feb 2026 11:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5889E3B8BDD;
	Thu,  5 Feb 2026 11:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="yf/YTyTq";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="q5Z1NplZ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="yf/YTyTq";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="q5Z1NplZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7667F3B8BCD
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Feb 2026 11:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770292363; cv=none; b=Dp0zOFV0zec6RZcjO1k24OrIWPxS6XhjEOMPnCX8K7c8oFTo+FyC6F1TJ9uCHVTfWTSUPlfL+NVHQwUAwi1E6AZ7SJFCuN55UhV3Pn/XcLSST4/GZSeH/wtYvFFl3LO6waMJeBXmXCFT/MD8BDq6h5WIAbGwg84APnDMVdzS+AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770292363; c=relaxed/simple;
	bh=av3bjkaGdw7tgihtVk60i7LRTwyrC/nsi4p5AqDTfPA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tEcNDYrhMwl+DF+FA7sVXBL0wDK77Zcmb9O2IeYK/N4021vZmx4+S+1+i4GpnGdwIK+frDWKn0hpBatX4OmK+xC9iMRpLBkJEfKfNxdGNvJAwsDBfuam1elAgR4DkqYBkKxHDtbbPC9ECenefY1ByWWCS7nZ1/9KjjiXnAVChwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=yf/YTyTq; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=q5Z1NplZ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=yf/YTyTq; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=q5Z1NplZ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8D24E5BD94;
	Thu,  5 Feb 2026 11:52:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1770292361; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=w6i0Y+COppC7XkuUVmKQRi6WI/byuV2S9cdcfhLCB9I=;
	b=yf/YTyTq8BKlF5Yp+lwfFt3AYI4+FED/rliHSVlUYszpHUcyIITvQqhE3xvLSVEIs5kevR
	70myIE/skRg/ZWd9uQDBfeGOOSQXpaCCy8kUdVetFWN1nRX4VyhkBHVisv6jVPn+hGhQrS
	Fc311HyyKDpi9VxTsmWKbCtWe9lWnlM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1770292361;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=w6i0Y+COppC7XkuUVmKQRi6WI/byuV2S9cdcfhLCB9I=;
	b=q5Z1NplZ8YAxWXVjC1jg1js+QwkAx5qITWpJMXjBD1eXo1YDNU1TU7Qs0B7HRuzT/QAnLE
	p8776fmdz5Rzd0DA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="yf/YTyTq";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=q5Z1NplZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1770292361; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=w6i0Y+COppC7XkuUVmKQRi6WI/byuV2S9cdcfhLCB9I=;
	b=yf/YTyTq8BKlF5Yp+lwfFt3AYI4+FED/rliHSVlUYszpHUcyIITvQqhE3xvLSVEIs5kevR
	70myIE/skRg/ZWd9uQDBfeGOOSQXpaCCy8kUdVetFWN1nRX4VyhkBHVisv6jVPn+hGhQrS
	Fc311HyyKDpi9VxTsmWKbCtWe9lWnlM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1770292361;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=w6i0Y+COppC7XkuUVmKQRi6WI/byuV2S9cdcfhLCB9I=;
	b=q5Z1NplZ8YAxWXVjC1jg1js+QwkAx5qITWpJMXjBD1eXo1YDNU1TU7Qs0B7HRuzT/QAnLE
	p8776fmdz5Rzd0DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 722333EA63;
	Thu,  5 Feb 2026 11:52:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id IobZG4mEhGlGegAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 05 Feb 2026 11:52:41 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 23A65A09D8; Thu,  5 Feb 2026 12:52:37 +0100 (CET)
Date: Thu, 5 Feb 2026 12:52:37 +0100
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Alice Ryhl <aliceryhl@google.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Carlos Llamas <cmllamas@google.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Dave Chinner <david@fromorbit.com>, 
	Qi Zheng <zhengqi.arch@bytedance.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, David Hildenbrand <david@kernel.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, kernel-team@android.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, linux-mm@kvack.org, 
	rust-for-linux@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 1/5] export file_close_fd and task_work_add
Message-ID: <luj2ggjo47mvjzhzavoy72ro6kaoj46cicudjrc6646vs3s7q5@wzc7aabgdlkl>
References: <20260205-binder-tristate-v1-0-dfc947c35d35@google.com>
 <20260205-binder-tristate-v1-1-dfc947c35d35@google.com>
 <20260205-mitschnitt-pfirsich-148a5026fc36@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260205-mitschnitt-pfirsich-148a5026fc36@brauner>
X-Spam-Flag: NO
X-Spam-Score: -2.51
X-Spam-Level: 
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76406-lists,linux-fsdevel=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	DMARC_NA(0.00)[suse.cz];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[36];
	FREEMAIL_CC(0.00)[google.com,linuxfoundation.org,zeniv.linux.org.uk,suse.cz,paul-moore.com,namei.org,hallyn.com,linux-foundation.org,fromorbit.com,bytedance.com,linux.dev,kernel.org,oracle.com,suse.com,gmail.com,garyguo.net,protonmail.com,umich.edu,android.com,vger.kernel.org,kvack.org,lst.de];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jack@suse.cz,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 51F8FF2122
X-Rspamd-Action: no action

On Thu 05-02-26 12:38:22, Christian Brauner wrote:
> On Thu, Feb 05, 2026 at 10:51:26AM +0000, Alice Ryhl wrote:
> > This exports the functionality needed by Binder to close file
> > descriptors.
> > 
> > When you send a fd over Binder, what happens is this:
> > 
> > 1. The sending process turns the fd into a struct file and stores it in
> >    the transaction object.
> > 2. When the receiving process gets the message, the fd is installed as a
> >    fd into the current process.
> > 3. When the receiving process is done handling the message, it tells
> >    Binder to clean up the transaction. As part of this, fds embedded in
> >    the transaction are closed.
> > 
> > Note that it was not always implemented like this. Previously the
> > sending process would install the fd directly into the receiving proc in
> > step 1, but as discussed previously [1] this is not ideal and has since
> > been changed so that fd install happens during receive.
> > 
> > The functions being exported here are for closing the fd in step 3. They
> > are required because closing a fd from an ioctl is in general not safe.
> > This is to meet the requirements for using fdget(), which is used by the
> > ioctl framework code before calling into the driver's implementation of
> > the ioctl. Binder works around this with this sequence of operations:
> > 
> > 1. file_close_fd()
> > 2. get_file()
> > 3. filp_close()
> > 4. task_work_add(current, TWA_RESUME)
> > 5. <binder returns from ioctl>
> > 6. fput()
> > 
> > This ensures that when fput() is called in the task work, the fdget()
> > that the ioctl framework code uses has already been fdput(), so if the
> > fd being closed happens to be the same fd, then the fd is not closed
> > in violation of the fdget() rules.
> > 
> > Link: https://lore.kernel.org/all/20180730203633.GC12962@bombadil.infradead.org/ [1]
> > Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> > ---
> >  fs/file.c          | 1 +
> >  kernel/task_work.c | 1 +
> >  2 files changed, 2 insertions(+)
> > 
> > diff --git a/fs/file.c b/fs/file.c
> > index 0a4f3bdb2dec6284a0c7b9687213137f2eecb250..0046d0034bf16270cdea7e30a86866ebea3a5a81 100644
> > --- a/fs/file.c
> > +++ b/fs/file.c
> > @@ -881,6 +881,7 @@ struct file *file_close_fd(unsigned int fd)
> >  
> >  	return file;
> >  }
> > +EXPORT_SYMBOL(file_close_fd);
> >  
> >  void do_close_on_exec(struct files_struct *files)
> >  {
> > diff --git a/kernel/task_work.c b/kernel/task_work.c
> > index 0f7519f8e7c93f9a4536c26a341255799c320432..08eb29abaea6b98cc443d1087ddb1d0f1a38c9ae 100644
> > --- a/kernel/task_work.c
> > +++ b/kernel/task_work.c
> > @@ -102,6 +102,7 @@ int task_work_add(struct task_struct *task, struct callback_head *work,
> >  
> >  	return 0;
> >  }
> > +EXPORT_SYMBOL(task_work_add);
> 
> Uhm, no. We're not going to export task_work_add() to let random drivers
> queue up work for a task when it returns to userspace. That just screams
> bugs and deadlocks at full capacity. Sorry, no.

Agreed. And just to demonstrate the point binder's use would become the
first of such bugs because it is prone to the module being removed while
the task work is in flight and thus do_close_fd() code can be freed by the
time it gets executed.

Generally, making some code modular usually requires more effort than just
flipping the Kconfig to tristate. You usually need to make sure all objects
and queued work is flushed before the module can be removed. Not sure how
much of this is taken care of by Rust though...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

