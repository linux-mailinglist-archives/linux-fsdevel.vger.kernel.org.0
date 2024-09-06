Return-Path: <linux-fsdevel+bounces-28887-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77BE396FDA5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Sep 2024 23:57:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02DF71F23136
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Sep 2024 21:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C96315A85E;
	Fri,  6 Sep 2024 21:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="JK9maVdR";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="XmVkQg3t";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="JK9maVdR";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="XmVkQg3t"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5486A1B85DC;
	Fri,  6 Sep 2024 21:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725659823; cv=none; b=JVWdBUGVvAQcYD4iDUOI9+wnS1F03e22ctTpyz3lrrljLpWLm9BtYDSkeduhe+yqNdb8L+TeziND5fTnVL4lXMHGWRFX1bK/km4A8Hu5ysIn3tV12n8uQQCZig/i4H6o2vF2eG2NW3c9O0KfRZWjSAtZOPd3QikPgURFUDRakjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725659823; c=relaxed/simple;
	bh=mgkeTgbtYio7pQ4uM4qkdEnqKxib6Y6s7cFZpeBpGYw=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=HSFvviH6XcmnlBHRRo4Xddq/Y8eMcEvJ7koQuQ47m9eh3FxiGxM+ScL9ijtuCYfvFdMF8Q4kiPSy7sfYnByh1Dthff8+aovmA3KznBjd5lrfk81R3F/WsrUQ8e2NmS0p0kt2aJ01m0QXmo6JOCHWkdIah6d+1M9FWBpuzlTDpE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=JK9maVdR; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=XmVkQg3t; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=JK9maVdR; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=XmVkQg3t; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4FF7621ADE;
	Fri,  6 Sep 2024 21:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1725659819; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R3QkpOcVKnFon8HPSUY1dOpBuIEHrd7AbJzNvYmxs9c=;
	b=JK9maVdREmPcQdKPULdV5KKttU2mpT4XcRkwQKSulNrFg2J0m1LRuT21O3p8SVVCBXdXiV
	dU5DpZNhgqp/9RG07EizM6yP1WE4ncexzqZbhyQWBCtAp7k2tLoJJqPzgIH7fDJuXJMYnl
	Hsljigx1xIM7VN1vLuDZtpbGD4mZ3Lc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1725659819;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R3QkpOcVKnFon8HPSUY1dOpBuIEHrd7AbJzNvYmxs9c=;
	b=XmVkQg3tiSo1ROJPDjSj+W6XQjXU79EHI/zL8BtghCB5h7QeqgPPdXGEpN2ue5vjcyylIi
	NqgnBXd+tCwLqPCg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=JK9maVdR;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=XmVkQg3t
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1725659819; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R3QkpOcVKnFon8HPSUY1dOpBuIEHrd7AbJzNvYmxs9c=;
	b=JK9maVdREmPcQdKPULdV5KKttU2mpT4XcRkwQKSulNrFg2J0m1LRuT21O3p8SVVCBXdXiV
	dU5DpZNhgqp/9RG07EizM6yP1WE4ncexzqZbhyQWBCtAp7k2tLoJJqPzgIH7fDJuXJMYnl
	Hsljigx1xIM7VN1vLuDZtpbGD4mZ3Lc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1725659819;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R3QkpOcVKnFon8HPSUY1dOpBuIEHrd7AbJzNvYmxs9c=;
	b=XmVkQg3tiSo1ROJPDjSj+W6XQjXU79EHI/zL8BtghCB5h7QeqgPPdXGEpN2ue5vjcyylIi
	NqgnBXd+tCwLqPCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DDDD61395F;
	Fri,  6 Sep 2024 21:56:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WQ8aJKh622ZHKAAAD6G6ig
	(envelope-from <neilb@suse.de>); Fri, 06 Sep 2024 21:56:56 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Mike Snitzer" <snitzer@kernel.org>
Cc: "Chuck Lever" <chuck.lever@oracle.com>, "Jeff Layton" <jlayton@kernel.org>,
 "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>,
 "Anna Schumaker" <anna@kernel.org>,
 "Trond Myklebust" <trondmy@hammerspace.com>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v15 16/26] nfsd: add LOCALIO support
In-reply-to: <ZttE4DKrqqVa0ACn@kernel.org>
References: <>, <ZttE4DKrqqVa0ACn@kernel.org>
Date: Sat, 07 Sep 2024 07:56:47 +1000
Message-id: <172565980778.4433.7347554942573335142@noble.neil.brown.name>
X-Rspamd-Queue-Id: 4FF7621ADE
X-Spam-Score: -6.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Sat, 07 Sep 2024, Mike Snitzer wrote:

> > But I'd just like to point out that something like the below patch
> > wouldn't be needed if we kept my "heavy" approach (nfs reference on
> > nfsd modules via nfs_common using symbol_request):
> > https://marc.info/?l=linux-nfs&m=172499445027800&w=2
> > (that patch has stuff I since cleaned up, e.g. removed typedefs and
> > EXPORT_SYMBOL_GPLs..)
> > 
> > I knew we were going to pay for being too cute with how nfs took its
> > reference on nfsd.
> > 
> > So here we are, needing fiddly incremental fixes like this to close a
> > really-small-yet-will-be-deadly race:
> 
> <snip required delicate rcu re-locking requirements patch>
> 
> I prefer this incremental re-implementation of my symbol_request patch
> that eliminates all concerns about the validity of 'nfs_to' calls:

We could achieve the same effect without using symbol_request() (which
hardly anyone uses) if we did a __module_get (or try_module_get) at the
same place you are calling symbol_request(), and module_put() where you
do symbol_put().

This would mean that once NFS LOCALIO had detected a path to the local
server, it would hold the nfsd module until the nfs server were shutdown
and the nfs client noticed.  So you wouldn't be able to unmount the nfsd
module immediately after stopping all nfsd servers.

Maybe that doesn't matter.  I think it is important to be able to
completely shut down the NFS server at any time.  I think it is
important to be able to completely shutdown a network namespace at any
time.  I am less concerned about being able to rmmod the nfsd module
after all obvious users have been disabled.

So if others think that the improvements in code maintainability are
worth the loss of being able to rmmod nfsd without (potentially) having
to unmount all NFS filesystems, then I won't argue against it.  But I
really would want it to be get/put of the module, not of some symbol.

.... BTW you probably wanted to use symbol_get(), not symbol_request(). 
The latter tries to load the module if it isn't already loaded.  Using
symbol_get() does have the benefit that you don't need any locking dance
to prevent the module unloading while we get the ref.  So if we really
want to go for less tricky locking that might be a justification - but
you don't need much locking for try_module_get()...


Thanks,
NeilBrown

