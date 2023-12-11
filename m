Return-Path: <linux-fsdevel+bounces-5587-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C725180DE1B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Dec 2023 23:24:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6D6E1C21553
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Dec 2023 22:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BF6255797;
	Mon, 11 Dec 2023 22:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="gHOxDtY0";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="I30+EAmN";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="gHOxDtY0";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="I30+EAmN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 265BF8F;
	Mon, 11 Dec 2023 14:24:00 -0800 (PST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 477672243D;
	Mon, 11 Dec 2023 22:23:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702333438; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PQ9QS0iOEdiHygKhY0Q4xaDhkAE7QfbRkg0Gf+N/PhE=;
	b=gHOxDtY0sMxr4xrroTkDnAtQqbTNflYkcDbk8SLU23cVa8e+xsy79mJZNyGpWr+K5LYV19
	QQ4MHd2PKJQE4oQWTYUtUu1PK2tvFiYo4j4A3+hBMpo/nxu2LGIAnwpdnfd1h7hFr6inBP
	xSx6KIAHUUphaDkd3fK6PIi3ID/99E8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702333438;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PQ9QS0iOEdiHygKhY0Q4xaDhkAE7QfbRkg0Gf+N/PhE=;
	b=I30+EAmN4n4SBnszs/6KX2t0cujDYmKEMoiXI6wdj8Njx7HXrmJOtV4Iq9bcbL8Ly07fut
	G1tBfbX79aNOmODg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702333438; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PQ9QS0iOEdiHygKhY0Q4xaDhkAE7QfbRkg0Gf+N/PhE=;
	b=gHOxDtY0sMxr4xrroTkDnAtQqbTNflYkcDbk8SLU23cVa8e+xsy79mJZNyGpWr+K5LYV19
	QQ4MHd2PKJQE4oQWTYUtUu1PK2tvFiYo4j4A3+hBMpo/nxu2LGIAnwpdnfd1h7hFr6inBP
	xSx6KIAHUUphaDkd3fK6PIi3ID/99E8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702333438;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PQ9QS0iOEdiHygKhY0Q4xaDhkAE7QfbRkg0Gf+N/PhE=;
	b=I30+EAmN4n4SBnszs/6KX2t0cujDYmKEMoiXI6wdj8Njx7HXrmJOtV4Iq9bcbL8Ly07fut
	G1tBfbX79aNOmODg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0317D132DA;
	Mon, 11 Dec 2023 22:23:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id zZjaKPqLd2VKOwAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 11 Dec 2023 22:23:54 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Al Viro" <viro@zeniv.linux.org.uk>
Cc: "Chuck Lever" <chuck.lever@oracle.com>,
 "Christian Brauner" <brauner@kernel.org>, "Jens Axboe" <axboe@kernel.dk>,
 "Oleg Nesterov" <oleg@redhat.com>, "Jeff Layton" <jlayton@kernel.org>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nfs@vger.kernel.org
Subject:
 Re: [PATCH 1/3] nfsd: use __fput_sync() to avoid delayed closing of files.
In-reply-to: <20231211191117.GD1674809@ZenIV>
References: <20231208033006.5546-1-neilb@suse.de>,
 <20231208033006.5546-2-neilb@suse.de>,
 <ZXMv4psmTWw4mlCd@tissot.1015granger.net>,
 <170224845504.12910.16483736613606611138@noble.neil.brown.name>,
 <20231211191117.GD1674809@ZenIV>
Date: Tue, 12 Dec 2023 09:23:51 +1100
Message-id: <170233343177.12910.2316815312951521227@noble.neil.brown.name>
X-Spam-Level: **********
X-Spam-Score: 10.12
X-Spamd-Result: default: False [-9.01 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 BAYES_HAM(-0.00)[23.87%];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 R_SPF_SOFTFAIL(0.00)[~all];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[9];
	 WHITELIST_DMARC(-7.00)[suse.de:D:+];
	 DMARC_POLICY_ALLOW(0.00)[suse.de,none];
	 DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_TLS_ALL(0.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim]
X-Spam-Flag: NO
X-Rspamd-Server: rspamd1
X-Spam-Level: 
X-Rspamd-Queue-Id: 477672243D
X-Spam-Score: -9.01
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=gHOxDtY0;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=I30+EAmN;
	spf=softfail (smtp-out1.suse.de: 2a07:de40:b281:104:10:150:64:97 is neither permitted nor denied by domain of neilb@suse.de) smtp.mailfrom=neilb@suse.de;
	dmarc=pass (policy=none) header.from=suse.de

On Tue, 12 Dec 2023, Al Viro wrote:
> On Mon, Dec 11, 2023 at 09:47:35AM +1100, NeilBrown wrote:
> 
> > Similarly would could wrap __fput_sync() is a more friendly name, but
> > that would be better if we actually renamed the function.
> > 
> >   void fput_now(struct file *f)
> >   {
> >       __fput_sync(f);
> >   }
> 
> It is unfriendly *precisely* because it should not be used without
> a very good reason.
> 
> It may be the last opened file keeping a lazy-umounted mount alive.
> It may be taking pretty much any locks, or eating a lot of stack
> space.

Previously you've suggested problems with ->release blocking.
Now you refer to lazy-umount, which is what the comment above
__fput_sync() mentions.

"pretty much an locks" seems like hyperbole.  I don't see it taking
nfsd_mutex or nlmsvc_mutex.  Maybe you mean any filesystem lock?

My understanding is that the advent of vmalloc allocated stacks means
that kernel stack space is not an important consideration.

It would really help if we could have clear documented explanation of
what problems can occur.  Maybe an example of contexts where it isn't
safe to call __fput_sync().

I can easily see that lazy-unmount is an interesting case which could
easily catch people unawares.  Punting the tail end of mntput_no_expire
(i.e.  if count reaches zero) to a workqueue/task_work makes sense and
would be much less impact than punting every __fput to a workqueue.

Would that make an fput_now() call safe to use in most contexts, or is
there something about ->release or dentry_kill() that can still cause
problems?

Thanks,
NeilBrown


> 
> It really isn't a general-purpose API; any "more friendly name"
> is going to be NAKed for that reason alone.
> 
> Al, very much tempted to send a patch renaming that sucker to
> __fput_dont_use_that_unless_you_really_know_what_you_are_doing().
> 


