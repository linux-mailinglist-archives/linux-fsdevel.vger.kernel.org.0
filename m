Return-Path: <linux-fsdevel+bounces-5444-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9163D80BDB7
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Dec 2023 23:47:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9412280C68
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Dec 2023 22:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A1B01D559;
	Sun, 10 Dec 2023 22:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="rp/Uy7pz";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="uNwEpaz7";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="rp/Uy7pz";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="uNwEpaz7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7663BDF;
	Sun, 10 Dec 2023 14:47:43 -0800 (PST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8343C22179;
	Sun, 10 Dec 2023 22:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702248461; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qTWu+7fJmRUa9JaK7MNQfzwJEOHSHQSeMdkuB1S6r2U=;
	b=rp/Uy7pzLEu6FPC9FtXfRoZIKYMiAvNa6LwCkQGtue0gFdfRyw4yyntkJts8jaH0mZHFWP
	ikqcAkVPgb262CN54QR+lFyhZ5kOz7V5VNhUWF+n/Hid1OIcRYNYhoe/cEUX4LfOMF5L7B
	TlkqkxXeYm1NvuZmfAyocncfNoOlilE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702248461;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qTWu+7fJmRUa9JaK7MNQfzwJEOHSHQSeMdkuB1S6r2U=;
	b=uNwEpaz78gnq2bm1ORy6HOymdF05srNJ0t5gXQPNsRN/HsnFOP2y94Fu5hrCHFF3+HZRi3
	42GZvSW+dnB+3EAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702248461; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qTWu+7fJmRUa9JaK7MNQfzwJEOHSHQSeMdkuB1S6r2U=;
	b=rp/Uy7pzLEu6FPC9FtXfRoZIKYMiAvNa6LwCkQGtue0gFdfRyw4yyntkJts8jaH0mZHFWP
	ikqcAkVPgb262CN54QR+lFyhZ5kOz7V5VNhUWF+n/Hid1OIcRYNYhoe/cEUX4LfOMF5L7B
	TlkqkxXeYm1NvuZmfAyocncfNoOlilE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702248461;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qTWu+7fJmRUa9JaK7MNQfzwJEOHSHQSeMdkuB1S6r2U=;
	b=uNwEpaz78gnq2bm1ORy6HOymdF05srNJ0t5gXQPNsRN/HsnFOP2y94Fu5hrCHFF3+HZRi3
	42GZvSW+dnB+3EAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4700C133DE;
	Sun, 10 Dec 2023 22:47:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id lGG/OQlAdmVtFgAAD6G6ig
	(envelope-from <neilb@suse.de>); Sun, 10 Dec 2023 22:47:37 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Chuck Lever" <chuck.lever@oracle.com>
Cc: "Al Viro" <viro@zeniv.linux.org.uk>,
 "Christian Brauner" <brauner@kernel.org>, "Jens Axboe" <axboe@kernel.dk>,
 "Oleg Nesterov" <oleg@redhat.com>, "Jeff Layton" <jlayton@kernel.org>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nfs@vger.kernel.org
Subject:
 Re: [PATCH 1/3] nfsd: use __fput_sync() to avoid delayed closing of files.
In-reply-to: <ZXMv4psmTWw4mlCd@tissot.1015granger.net>
References: <20231208033006.5546-1-neilb@suse.de>,
 <20231208033006.5546-2-neilb@suse.de>,
 <ZXMv4psmTWw4mlCd@tissot.1015granger.net>
Date: Mon, 11 Dec 2023 09:47:35 +1100
Message-id: <170224845504.12910.16483736613606611138@noble.neil.brown.name>
X-Spam-Level: 
X-Spam-Score: -4.21
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -4.21
X-Spamd-Result: default: False [-4.21 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-0.92)[-0.921];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.19)[-0.940];
	 RCPT_COUNT_SEVEN(0.00)[9];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Flag: NO

On Sat, 09 Dec 2023, Chuck Lever wrote:
> On Fri, Dec 08, 2023 at 02:27:26PM +1100, NeilBrown wrote:
> > Calling fput() directly or though filp_close() from a kernel thread like
> > nfsd causes the final __fput() (if necessary) to be called from a
> > workqueue.  This means that nfsd is not forced to wait for any work to
> > complete.  If the ->release of ->destroy_inode function is slow for any
> > reason, this can result in nfsd closing files more quickly than the
> > workqueue can complete the close and the queue of pending closes can
> > grow without bounces (30 million has been seen at one customer site,
> > though this was in part due to a slowness in xfs which has since been
> > fixed).
> > 
> > nfsd does not need this.
> 
> That is technically true, but IIUC, there is only one case where a
> synchronous close matters for the backlog problem, and that's when
> nfsd_file_free() is called from nfsd_file_put(). AFAICT all other
> call sites (except rename) are error paths, so there aren't negative
> consequences for the lack of synchronous wait there...

What you say is technically true but it isn't the way I see it.

Firstly I should clarify that __fput_sync() is *not* a flushing close as
you describe it below.
All it does, apart for some trivial book-keeping, is to call ->release
and possibly ->destroy_inode immediately rather than shunting them off
to another thread.
Apparently ->release sometimes does something that can deadlock with
some kernel threads or if some awkward locks are held, so the whole
final __fput is delay by default.  But this does not apply to nfsd.
Standard fput() is really the wrong interface for nfsd to use.  
It should use __fput_sync() (which shouldn't have such a scary name).

The comment above flush_delayed_fput() seems to suggest that unmounting
is a core issue.  Maybe the fact that __fput() can call
dissolve_on_fput() is a reason why it is sometimes safer to leave the
work to later.  But I don't see that applying to nfsd.

Of course a ->release function *could* do synchronous writes just like
the XFS ->destroy_inode function used to do synchronous reads.
I don't think we should ever try to hide that by putting it in
a workqueue.  It's probably a bug and it is best if bugs are visible.

Note that the XFS ->release function does call filemap_flush() in some
cases, but that is an async flush, so __fput_sync doesn't wait for the
flush to complete.

The way I see this patch is that fput() is the wrong interface for nfsd
to use, __fput_sync is the right interface.  So we should change.  1
patch.
The details about exhausting memory explain a particular symptom that
motivated the examination which revealed that nfsd was using the wrong
interface.

If we have nfsd sometimes using fput() and sometimes __fput_sync, then
we need to have clear rules for when to use which.  It is much easier to
have a simple rule: always use __fput_sync().

I'm certainly happy to revise function documentation and provide
wrapper functions if needed.

I might be good to have

  void filp_close_sync(struct file *f)
  {
       get_file(f);
       filp_close(f);
       __fput_sync(f);
  }

but as that would only be called once, it was hard to motivate.
Having it in linux/fs.h would be nice.

Similarly would could wrap __fput_sync() is a more friendly name, but
that would be better if we actually renamed the function.

  void fput_now(struct file *f)
  {
      __fput_sync(f);
  }

??

Thanks,
NeilBrown

