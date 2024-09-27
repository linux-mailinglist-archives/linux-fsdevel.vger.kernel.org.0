Return-Path: <linux-fsdevel+bounces-30250-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC8FF9886AE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Sep 2024 16:07:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEE2E1C22FCB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Sep 2024 14:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6767132464;
	Fri, 27 Sep 2024 14:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.pizza header.i=@tycho.pizza header.b="YLIExtAS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Mt+Z0Npn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C787081727;
	Fri, 27 Sep 2024 14:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727446047; cv=none; b=HVbK8ALtc1c/ECdBeAhW8dEQezYvISowoSyL+gIZ3d0iPeXnPYMki22FCGORRMyjLLa5YOBTf5YwJtsL2N52ysNUFw6KFajSpVCoswYhhj3x77R+EjNwVqO7oIVsfbZx+mDXtlfd35uX7DbE61F5gZnMhB7PD+CeeaWryJqA1P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727446047; c=relaxed/simple;
	bh=+my4i+PV2U51waZhPAUIE9prTED9WJKWUkcEfP0xVPg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dGSSdgXfj8lt44ukq9YQHPEiFpeWXwuXmlz5bxncJcwnHOk7v9ORaRsn+WELsz5vRId7MLEugZq1F3KCvRFWS8+XXe8HkPXvLwS8YLgFM9kFy8dKMDineeiAmaDkTL62RlTqxqCSCI0cuyXoY4fcAbWW5Fztx4svW3ezghc9z8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.pizza; spf=pass smtp.mailfrom=tycho.pizza; dkim=pass (2048-bit key) header.d=tycho.pizza header.i=@tycho.pizza header.b=YLIExtAS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Mt+Z0Npn; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.pizza
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tycho.pizza
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id C41B81380162;
	Fri, 27 Sep 2024 10:07:23 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Fri, 27 Sep 2024 10:07:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tycho.pizza; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1727446043; x=1727532443; bh=reEuEofoIX
	50Jk9+XfJrwD0MRSP6hIoJJ1tb5DJ8T7Y=; b=YLIExtASxjMsLzAQVgJU9JmOsc
	/FBDk20AQOHIbQA7l7q9wC4SvNTwE1yR1a3+uMTjCsEuR9eRGZ7PD3HjlG57wM7f
	G2E3CNdhbx0h1HB6sq699XOXVA5eH4LbBpwGxQ4HZXDR3uKH44/6hCo3+L9DsZt9
	UBqkFKV0lHuNX7EgQQf7MeK8WxU0uOjKUiCjr1fwnm8iGHUk+EVa1jPQJ/aAKsLX
	BiIBXbiO0P2Fu+s4XuSdoRa2hffg2Z616fMs+EV44vJIFwsaAFLdUd2iy8ofFshD
	xvSH/qsG5VuqbM8wu5+dMYAE3GKh/mBY10xVMNo0ayxm5PKHFpS4KJ6JiQjQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727446043; x=1727532443; bh=reEuEofoIX50Jk9+XfJrwD0MRSP6
	hIoJJ1tb5DJ8T7Y=; b=Mt+Z0Npn8iF9AEDWPT/DMESvRfJ6Vow6mC1kB0zqM5zN
	9krzJvPSFtaWibAFAbrc/ifWXfGCsi4F4PAyCUkK7lLDbsPgLhyZA/sutqm4WL7B
	5MAYhe92No5bG6skcJq7vv9ctRs1+04EhLJZ7eQvbGMBJ0VFHQRnUgmWpKQRk8N4
	Pr5GK/5BM4HZ4Z0Kl7/E2fnVtrRVGNJG2JszaEZBqMeDCb9yTIU/l9t+s8CJm9wR
	Q8af6Q1UBBzZllHKNPst8J2RY48lgi5nIGnuJ1Srt7BHi+QqolFgZ2zoyZsCH6tW
	/T5V4ghJW9a1effr3R+hOmEJ4ywaycEu20MTFpcLIw==
X-ME-Sender: <xms:Grz2ZlqGIvXlpRo9uUAW4OPreujmx493hsSqmz_8xn947VvyVTfdpg>
    <xme:Grz2ZnosVpMV3AsEwWt5zEphIMSFJWmwkltr_4iLYNYrSgltG4Pnjt0CLEU67CJWG
    EcnXxeEoTN8NTCKIZ4>
X-ME-Received: <xmr:Grz2ZiPkfuvFKo82vsv4_AyjlndDEj4Y5KtcqadjzH5S0P-ZSN_Qiq1gwPZMJuozrpZg9EiTMmMLNgifpyAe5d8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddtledgjedvucetufdoteggodetrfdotf
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
X-ME-Proxy: <xmx:Grz2Zg4BJjWdY2Yh5cV6xInhNtB0zxrdpiicIQLMG5HDCyvav2WUjg>
    <xmx:Grz2Zk7LTB8wJrYWbGqAwdd7MrgceZCF6g1D1lBnY2VltB5Rgtg9FQ>
    <xmx:Grz2ZohAKeO1p7tkMNLKMEgTuWmtDHxLZt86Yiu0gglgqVEghqfO7Q>
    <xmx:Grz2Zm47iKhCqT0JlVDoNgtu6xHXu4AxRaNwZAXuCdN-Bb7KNJUDsg>
    <xmx:G7z2ZjSmQVDFIxhXt7zMHHjK-VylwIdSXZ9EJCeOfJIAkwlXvWgDiqCn>
Feedback-ID: i21f147d5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Sep 2024 10:07:21 -0400 (EDT)
Date: Fri, 27 Sep 2024 08:07:20 -0600
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
Message-ID: <Zva8GEUv1Xj8SsLf@tycho.pizza>
References: <20240924141001.116584-1-tycho@tycho.pizza>
 <87msjx9ciw.fsf@email.froward.int.ebiederm.org>
 <20240925.152228-private.conflict.frozen.trios-TdUGhuI5Sb4v@cyphar.com>
 <ZvR+k3D1KGALOIWt@tycho.pizza>
 <878qvf17zl.fsf@email.froward.int.ebiederm.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878qvf17zl.fsf@email.froward.int.ebiederm.org>

On Wed, Sep 25, 2024 at 09:09:18PM -0500, Eric W. Biederman wrote:
> Tycho Andersen <tycho@tycho.pizza> writes:
> 
> > Yep, I did this for the test above, and it worked fine:
> >
> >         if (bprm->fdpath) {
> >                 /*
> >                  * If fdpath was set, execveat() made up a path that will
> >                  * probably not be useful to admins running ps or similar.
> >                  * Let's fix it up to be something reasonable.
> >                  */
> >                 struct path root;
> >                 char *path, buf[1024];
> >
> >                 get_fs_root(current->fs, &root);
> >                 path = __d_path(&bprm->file->f_path, &root, buf, sizeof(buf));
> >
> >                 __set_task_comm(me, kbasename(path), true);
> >         } else {
> >                 __set_task_comm(me, kbasename(bprm->filename), true);
> >         }
> >
> > obviously we don't want a stack allocated buffer, but triggering on
> > ->fdpath != NULL seems like the right thing, so we won't need a flag
> > either.
> >
> > The question is: argv[0] or __d_path()?
> 
> You know.  I think we can just do:
> 
> 	BUILD_BUG_ON(DNAME_INLINE_LEN >= TASK_COMM_LEN);
> 	__set_task_comm(me, bprm->file->f_path.dentry->d_name.name, true);
> 
> Barring cache misses that should be faster and more reliable than what
> we currently have and produce the same output in all of the cases we
> like, and produce better output in all of the cases that are a problem
> today.
> 
> Does anyone see any problem with that?

Nice, this works great. We need to drop the BUILD_BUG_ON() since it is
violated in today's tree, but I think this is safe to do anyway since
__set_task_comm() does strscpy_pad(tsk->comm, buf, sizeof(tsk->comm)).

I will respin with this and dropping the flag.

Tycho

