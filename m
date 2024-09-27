Return-Path: <linux-fsdevel+bounces-30256-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E00C9887A1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Sep 2024 16:56:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8CF19B230DB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Sep 2024 14:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D43811C0DEC;
	Fri, 27 Sep 2024 14:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.pizza header.i=@tycho.pizza header.b="VgdlrTvb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iF7I47nA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5924F1BFE1A;
	Fri, 27 Sep 2024 14:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727448989; cv=none; b=OpoFKa3f6Awej2Z4+s4I4nKxnwyM2XySV7VSwG/nYaNs8kScGUAd3srKM9MaZ9rKn7TT1tIwB66NGMoRt4B5rXSht2q6cVOYZG/w9FFEG+btDRXhwX5coZoWi+l879vMiLqTF+inV4fT8s6qM606rj2qSTGEZ/rSjtY6dY148o4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727448989; c=relaxed/simple;
	bh=inzmU683np0qqTazklj06++fIeFWEJ0I19ZbsVKvWho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fyc/q2o8TXGp8sgwlq18rLr+W6UW5lw1cUt8GD6BGpwNxKUvgZ42o0t3LHBnEwlllQgp+1pqBBtoKs3HuXfd4O0P/AcFfJxtwKLPBKVsQdcVOr6mZ57VHmHhFNgfkEhX/yyP+pVQHCZL6C5yBJ2Nt7di3YDUWKYcAD05uAnpBJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.pizza; spf=pass smtp.mailfrom=tycho.pizza; dkim=pass (2048-bit key) header.d=tycho.pizza header.i=@tycho.pizza header.b=VgdlrTvb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iF7I47nA; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.pizza
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tycho.pizza
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 677CA1380143;
	Fri, 27 Sep 2024 10:56:26 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Fri, 27 Sep 2024 10:56:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tycho.pizza; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1727448986; x=1727535386; bh=lCpfQdkJ67
	FKoocTx2z3FyOrYGH6Jp6LctLaGMXrtSA=; b=VgdlrTvbh+92Z+N91GjBhyRVVg
	op+dQK9nZOurC8zzc00XjCTbVbMSYbzp9nv6OYtywYLLvJIW9JpZgBySIDSonM5b
	qEfBlt5aVqjyqJIwqQTt5Pvs1o5Y2ZenSr/1t3D4MNrnn9am+ZcFppMZ6bBt2LxR
	Zhms1yNnfVh65VwHejMrQZ7GFUyAtiYUe6+puZbXUWi5OevULLOysLCRt/s5sIZj
	Dr+uV/Sm5WVoBboEMtviNSbu1tGhr2gBHdN6VT7aqDKIZ7qSGifk8Z2cTxchlixc
	/oLCmUhCFBUZLw8Snc1wRybhycad6/c0eukQOcLWL9i+N6Ab6UNJlqU8SRig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727448986; x=1727535386; bh=lCpfQdkJ67FKoocTx2z3FyOrYGH6
	Jp6LctLaGMXrtSA=; b=iF7I47nAUm+VHeZ0v731v0kbcVwAKvvrhGiDX5WcTLuX
	cCn+wyryAjXmUIopcug+Lm4WJLrNbeQUwUU3j7vc1aQSEng25aAfuJLvlX3y7zlH
	TE5WZ52k1LvJgKrnYumwN/7Gh55e5rOcgCqFr/kZOtAFj9mr+7muoGowgiwxbDdX
	Bj76Y8oZRJBD5RpZM/bdJRek4WLcfekjk0e5mXqH+YZnn9nBMSeV+CjKUJUVrQTX
	iAwKVG8e0guJYWjbVKGKRPRcFjNw2XLf8KBwf6FS/voMmXWBj8cYpvCVB4JUBSkS
	5zkleevjYa7/p1XGmaP3d0zEMeDBuYOW0gLuRG9YCw==
X-ME-Sender: <xms:mcf2Zpgfeer_Vs-7XmhL9sF02oA4b6Zt7XXi1ucFWfxXBEcmRr31wQ>
    <xme:mcf2ZuAfC-Bm2CAtQ0xkReQginzxsO-U8yPZ3jqtOt1djJZ0QTr-YCcp_j-i7g9fV
    Q6jOzHKWnwpisWHyiE>
X-ME-Received: <xmr:mcf2ZpEqQP3hC8LpZFfNJy2mLD27eEay-yUKjtNceuJOx6rSWPjbhNqgme8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddtledgkedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomhepvfihtghhohcutehnuggvrhhsvghnuceothihtghhohesthihtghhohdrph
    hiiiiirgeqnecuggftrfgrthhtvghrnhepueettdetgfejfeffheffffekjeeuveeifedu
    leegjedutdefffetkeelhfelleetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepthihtghhohesthihtghhohdrphhiiiiirgdpnhgspghrtghp
    thhtohepudegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegvsghivgguvghrmh
    esgihmihhsshhiohhnrdgtohhmpdhrtghpthhtoheptgihphhhrghrsegthihphhgrrhdr
    tghomhdprhgtphhtthhopehvihhrohesiigvnhhivhdrlhhinhhugidrohhrghdruhhkpd
    hrtghpthhtohepsghrrghunhgvrheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhgr
    tghksehsuhhsvgdrtgiipdhrtghpthhtohepkhgvvghssehkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehjlhgrhihtohhnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegthhhu
    tghkrdhlvghvvghrsehorhgrtghlvgdrtghomhdprhgtphhtthhopegrlhgvgidrrghrih
    hnghesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:mcf2ZuTRH7utXKrfboP36L73fv4Q3eOgMiZedA2jo_vsjbZZt1lyIg>
    <xmx:mcf2Zmz6krV3mWWmftN-84Zlxl4gAcGtOdGZk6KaK3yTWYd8e84tEw>
    <xmx:mcf2Zk5ECGFDJsoJEMa6WVzdedT93Ar20I6sXcRHDFgxLbfF9A5CJw>
    <xmx:mcf2Zry6aMwifBgIpLxKHVoeRtwQDUMU-qENoIZfoXXWn516Yofuvw>
    <xmx:msf2ZrKkfeqOLatrsTXrfmhG6nCPcRnnTcD6bzyV7P7hdb9ZSTjxykqM>
Feedback-ID: i21f147d5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Sep 2024 10:56:23 -0400 (EDT)
Date: Fri, 27 Sep 2024 08:56:20 -0600
From: Tycho Andersen <tycho@tycho.pizza>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Aleksa Sarai <cyphar@cyphar.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Kees Cook <kees@kernel.org>, Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Alexander Aring <alex.aring@gmail.com>,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Tycho Andersen <tandersen@netflix.com>,
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
Subject: Re: [RFC] exec: add a flag for "reasonable" execveat() comm
Message-ID: <ZvbHlChEmj35+jHF@tycho.pizza>
References: <20240924141001.116584-1-tycho@tycho.pizza>
 <87msjx9ciw.fsf@email.froward.int.ebiederm.org>
 <20240925.152228-private.conflict.frozen.trios-TdUGhuI5Sb4v@cyphar.com>
 <ZvR+k3D1KGALOIWt@tycho.pizza>
 <878qvf17zl.fsf@email.froward.int.ebiederm.org>
 <Zva8GEUv1Xj8SsLf@tycho.pizza>
 <87h6a1xilx.fsf@email.froward.int.ebiederm.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h6a1xilx.fsf@email.froward.int.ebiederm.org>

On Fri, Sep 27, 2024 at 09:43:22AM -0500, Eric W. Biederman wrote:
> Tycho Andersen <tycho@tycho.pizza> writes:
> 
> > On Wed, Sep 25, 2024 at 09:09:18PM -0500, Eric W. Biederman wrote:
> >> Tycho Andersen <tycho@tycho.pizza> writes:
> >> 
> >> > Yep, I did this for the test above, and it worked fine:
> >> >
> >> >         if (bprm->fdpath) {
> >> >                 /*
> >> >                  * If fdpath was set, execveat() made up a path that will
> >> >                  * probably not be useful to admins running ps or similar.
> >> >                  * Let's fix it up to be something reasonable.
> >> >                  */
> >> >                 struct path root;
> >> >                 char *path, buf[1024];
> >> >
> >> >                 get_fs_root(current->fs, &root);
> >> >                 path = __d_path(&bprm->file->f_path, &root, buf, sizeof(buf));
> >> >
> >> >                 __set_task_comm(me, kbasename(path), true);
> >> >         } else {
> >> >                 __set_task_comm(me, kbasename(bprm->filename), true);
> >> >         }
> >> >
> >> > obviously we don't want a stack allocated buffer, but triggering on
> >> > ->fdpath != NULL seems like the right thing, so we won't need a flag
> >> > either.
> >> >
> >> > The question is: argv[0] or __d_path()?
> >> 
> >> You know.  I think we can just do:
> >> 
> >> 	BUILD_BUG_ON(DNAME_INLINE_LEN >= TASK_COMM_LEN);
> >> 	__set_task_comm(me, bprm->file->f_path.dentry->d_name.name, true);
> >> 
> >> Barring cache misses that should be faster and more reliable than what
> >> we currently have and produce the same output in all of the cases we
> >> like, and produce better output in all of the cases that are a problem
> >> today.
> >> 
> >> Does anyone see any problem with that?
> >
> > Nice, this works great. We need to drop the BUILD_BUG_ON() since it is
> > violated in today's tree, but I think this is safe to do anyway since
> > __set_task_comm() does strscpy_pad(tsk->comm, buf, sizeof(tsk->comm)).
> 
> Doh.  I simply put the conditional in the wrong order.  That should have
> been:
> 	BUILD_BUG_ON(TASK_COMM_LEN > DNAME_INLINE_LEN);
> 
> Sorry I was thinking of the invariant that needs to be preserved rather
> than the bug that happens.

Thanks, I will include that. Just for my own education: this is still
*safe* to do, because of _pad, it's just that it is a userspace
visible break if TASK_COMM_LEN > DNAME_INLINE_LEN is ever true?

Tycho

