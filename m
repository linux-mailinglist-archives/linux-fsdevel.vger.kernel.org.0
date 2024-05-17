Return-Path: <linux-fsdevel+bounces-19692-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D4BF8C8BE5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 May 2024 19:58:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD5A928791F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 May 2024 17:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D22613E05B;
	Fri, 17 May 2024 17:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=3xx0.net header.i=@3xx0.net header.b="uMfGVJkU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TDNEW63p"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from wflow2-smtp.messagingengine.com (wflow2-smtp.messagingengine.com [64.147.123.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3852B13DDCA;
	Fri, 17 May 2024 17:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715968648; cv=none; b=nIrom0Z2xz7JRQxQxCl5TtU2iuO1Edqt/bKFh/QoeQvFMCtIO3qKv9vmxnso8cVJjcGVrhU1m8bIaxyY+fDE85jWnuX1IroS2yZZQbbFGOMZ5sROoMRecAtNBr7lL2Bk26prs7TYD+0bl5O45Iw4FszoWLkWZ1cJ+kpcEnXC5Q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715968648; c=relaxed/simple;
	bh=I2w45PghcaqjI+y7WfkIeFOVTyWdnhXIf4c8rZ8OaJw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KnIDRhrQfP7T8N2nKCGyXi5RNUnz8pF8ACH3RTkFbJOnbzG1phL52NNPOnJf+O6B8W0HELQ/VhVgFAoG3Z779J1FvSFStRrul9eepvTX6R5VyC9SHHxFPpECA+wSFgvVDVnYKXAtiV4vib4eGQ6HgICwMZWY8YRFPaHWttBtfu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=3xx0.net; spf=pass smtp.mailfrom=3xx0.net; dkim=pass (2048-bit key) header.d=3xx0.net header.i=@3xx0.net header.b=uMfGVJkU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TDNEW63p; arc=none smtp.client-ip=64.147.123.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=3xx0.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=3xx0.net
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailflow.west.internal (Postfix) with ESMTP id 7886D2CC010B;
	Fri, 17 May 2024 13:57:25 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Fri, 17 May 2024 13:57:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=3xx0.net; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1715968645; x=1715972245; bh=DG6bdjmTz4
	bBiRVx5vRqnyJGZODkSyHM0WPBKPD11vg=; b=uMfGVJkUQVRfm1T4SuQfg81+Vd
	5+EwSSzA1veRwFXODlGOsYMfbC5e9PDXupLK9HyaH/xalBd1s2kzVUiWMT2yQzvw
	hwRQ1fjYhfph5jS6R/35a6KtY34plcZMeR9Ze6xsvaXAZmSVgYgDUo2CD8pKLFPo
	Xy/T7Yx76YZjEUvdKWTQ/L8b+RH71BSELaxN8E1DA4gdeovy8JQ/GaJdIRS7/+JU
	nOR9kD+ElEjP9xlmH0WurtQuTo73SZegb2IizZ8K96HXLon2ZWd8yjQxXX9/jyWV
	LYzWnUzZv2IlDZ6c/LFUuMihTF52VWHKB3S26Kahi3BE/rYv+w/AkiBW4sjQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	i76614979.fm3; t=1715968645; x=1715972245; bh=DG6bdjmTz4bBiRVx5v
	RqnyJGZODkSyHM0WPBKPD11vg=; b=TDNEW63pXqb2VU0CcKW4l1HzhcHIdknUB/
	pz14lQW13kC6oa25PaUJ3EtzVqxHTnNRnTjcdfH+8czm5HMuaNUoZJNfrrzALEjj
	BhXP3yluNNAc75YUSlp2g1JKsDbzm4O1ZNjegjBzQEutxAV2qwhBA+PiVAl2qSTD
	wcvi2l7YIS6ZSe/e860AJvkLBo69+YWUv9s79bv4P/X0XeFjuMU/7FXm6jZHziD5
	dV8pUspsjHJiSbf/yF1J/558iKeCjLZNiZRLmWuEOFh+rxdDTbikzjB/nf4RuUcS
	9zUWeQhZVMpSt+DZfp2vzbU8AQQhAgnJoJrumNrLMdK5EsRfgtng==
X-ME-Sender: <xms:hJpHZgt-DnLYAP4XfCB3f4QDQ4JOhbJ0kjv4C7wIKndVKYrK6cgIIQ>
    <xme:hJpHZteog5l-85Pkdhrlk26_ZDbUVd1ZBbQGP0nfgODF4pJa5auMVRXbP8aJJU3Up
    NcIi4mMySIixXSafOo>
X-ME-Received: <xmr:hJpHZrxlVLZZGOGFQfKZBifYj11s-ibw1SC9sayyin6qUTgQyif-0J2hn7vqmYdM9hEJR-MQ_giyQTDryczmkrI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdehgedgvdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtsfdttddtjeenucfhrhhomheplfhonhgr
    thhhrghnucevrghlmhgvlhhsuceojhgtrghlmhgvlhhsseefgiigtddrnhgvtheqnecugg
    ftrfgrthhtvghrnhepkeekteegfefgvdefgfefffeufeffjedvudeijeehjeehffekjeek
    leffueelgffgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepjhgtrghlmhgvlhhsseefgiigtddrnhgvth
X-ME-Proxy: <xmx:hJpHZjOliYt1B30kBgmlLYDz3U_k0ILR04enLwlswHtl81Hc9_tOOw>
    <xmx:hJpHZg_tTtVt17uZ85S7l8qt2ezP1HcqKp8HG_d_HTVqD7c6KaT-Cg>
    <xmx:hJpHZrUFUcj0c_VL6ZrIN41Q8tSZ2WWCOA-aRCVfDXmGeifvQPDOGA>
    <xmx:hJpHZpedGcEgWYQAWwY_aGP7jCPuyq_4VonVfo014ODZjsk29EXztw>
    <xmx:hZpHZrUx1OlgTMngfhQPqJ-LWsX64N4U3yZMVc9MloMg7FfoIwLl0U3_>
Feedback-ID: i76614979:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 May 2024 13:57:22 -0400 (EDT)
Date: Fri, 17 May 2024 11:02:23 -0700
From: Jonathan Calmels <jcalmels@3xx0.net>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: brauner@kernel.org, Luis Chamberlain <mcgrof@kernel.org>, 
	Kees Cook <keescook@chromium.org>, Joel Granados <j.granados@samsung.com>, 
	Serge Hallyn <serge@hallyn.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, David Howells <dhowells@redhat.com>, 
	Jarkko Sakkinen <jarkko@kernel.org>, containers@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org, keyrings@vger.kernel.org
Subject: Re: [PATCH 1/3] capabilities: user namespace capabilities
Message-ID: <mya7cjq5yzf4xc53un65zia2bwp45mbrt5ys67mgr4azn3phet@o54svegibxze>
References: <20240516092213.6799-1-jcalmels@3xx0.net>
 <20240516092213.6799-2-jcalmels@3xx0.net>
 <878r08brmp.fsf@email.froward.int.ebiederm.org>
 <xv52m5xu5tgwpckkcvyjvefbvockmb7g7fvhlky5yjs2i2jhsp@dcuovgkys4eh>
 <87jzjsa57k.fsf@email.froward.int.ebiederm.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87jzjsa57k.fsf@email.froward.int.ebiederm.org>

> > On Fri, May 17, 2024 at 06:32:46AM GMT, Eric W. Biederman wrote:
> As I read your introduction you were justifying the introduction
> of a new security mechanism with the observation that distributions
> were carrying distribution specific patches.
> 
> To the best of my knowledge distribution specific patches and
> distributions disabling user namespaces have been gone for quite a
> while.  So if that has changed recently I would like to know.

On the top of my head:

- RHEL based:
  namespace.unpriv_enable
  user_namespace.enable

- Arch/Debian based:
  kernel.unprivileged_userns_clone

- Ubuntu based:
  kernel.apparmor_restrict_unprivileged_userns

I'm not sure which exact version those apply to, but it's definitely
still out there.

The observation is that while you can disable namespaces today, in
practice it breaks userspace in various ways. Hence, being able to
control capabilities is a better way to approach it.

For example, today's big hammer to prevent CAP_NET_ADMIN in userns:

# sysctl -qw user.max_net_namespaces=0

$ unshare -U -r -n ip tuntap add mode tap tap0 && echo OK
unshare: unshare failed: No space left on device

With patch, this becomes manageable:

# capsh --drop=cap_net_admin --secbits=$((1 << 8)) --user=$USER -- \
        -c 'unshare -U -r -n ip tuntap add mode tap tap0 && echo OK'
ioctl(TUNSETIFF): Operation not permitted

