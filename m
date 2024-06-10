Return-Path: <linux-fsdevel+bounces-21317-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 964B1901D37
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Jun 2024 10:43:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97B951C2168A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Jun 2024 08:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8BDF73514;
	Mon, 10 Jun 2024 08:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=3xx0.net header.i=@3xx0.net header.b="mnhLTPrt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oYdR8igH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow1-smtp.messagingengine.com (flow1-smtp.messagingengine.com [103.168.172.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E68B6F2F0;
	Mon, 10 Jun 2024 08:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718008929; cv=none; b=o5pQs48g5zsm8nTh2s5B0+7sciSSQJmKMGNDpN5lR72vdbFlho7YIAZi6+LRMA3czgCGnY9dGBD4QjeI8y+rI8VHSY/OkPs2iFjQnXsrxQuPCX+m60SuzjNqXad1RD0YDNnLGCS4c1A4oY8hOlBsoja8zRnVIH89a0NZef9S5yA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718008929; c=relaxed/simple;
	bh=ITgA5tjnrazsj2z8uUTCi7sXYM16+9a2OVtLAQMXods=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Relsxzy4uQyga+2a98GurNHHEQIEExo26YbVWohBMv+H7mKKVdz/Hpmv/8odHhLY4IZNe7E16gGqOobQWcB+vJBqlXanCysjfuaXuXcpF3z94peuEkDooGfRXdYSOdvJ38e8Yu+WOMR72csTV9H1Mbq3uX+Iz22IdUpp3m/hr1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=3xx0.net; spf=pass smtp.mailfrom=3xx0.net; dkim=pass (2048-bit key) header.d=3xx0.net header.i=@3xx0.net header.b=mnhLTPrt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oYdR8igH; arc=none smtp.client-ip=103.168.172.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=3xx0.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=3xx0.net
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailflow.nyi.internal (Postfix) with ESMTP id 5B03E200404;
	Mon, 10 Jun 2024 04:42:06 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 10 Jun 2024 04:42:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=3xx0.net; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1718008926; x=1718012526; bh=qmk9dz8QY8
	vVMsdJ1Kd+/af5+W3nNXWO20q8csDii3A=; b=mnhLTPrtZQ/DDGiawOwuJeaWat
	64250584gAjf2J/Dh8JvewKGYb34oCQE7URqIZHKpzJUeYA1kKsjDnhkfUZX+E68
	+8LVxRN9t/wJJjEEuCIuLof7r8VwRIZrZVHEAxubGvtTPuErvpSMPolZc6h/FBs6
	TnUtSUmlc0OkbJmubq9zDokuTpz7ngnJl4EEexVQqOAqSn6pQo4Yp6x54OpvrcCE
	XoIpGEw5oanL1CCEcLnD1Mbujxjb6oms1X2GanNYQEYDUDbSg8aqnlDuyXX+O/MN
	PNOtsnmF7Ft5GaBeljHc9lHlaU2Wz+ihucK9sDes64ynJ1BHh+vrhTVwTgQQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1718008926; x=1718012526; bh=qmk9dz8QY8vVMsdJ1Kd+/af5+W3n
	NXWO20q8csDii3A=; b=oYdR8igHwhuxgPsbo+C1eL/H3iR7gJqPSOM/AbjIQpfK
	67ktft+vuRVUKOaSvQRrky9qaOMVWGj9avRo7pDMQvDIUFwkzbpuOiDn6K/TcgJt
	K0frIvAmuJWqDSWzdLA0kJ+/Mque4OK/hfemuDOAqZAWyceRSHkX5eUTbIyt8DYe
	OhZixUDRh5ix2wgO28sZgvD7JW1Xe/+XTSGgkl9r6Q/yVMV6LyMXNCZhBqlzO2Wo
	mWBL3VIwKNRUn2DZuAKHbw6ioQD7VWsp8Bn9Ad8sFqGX9pKA8tZ6n3tYRn9gmqbD
	Z3JJFybCaAzTgVcMBgq/Sa50HuXv9Mh3IMoYALTfUA==
X-ME-Sender: <xms:XrxmZvzZP7xbrkP_X1Z_DJfplTPafejtRtkJI4A43LClUzmSIHIS5w>
    <xme:XrxmZnRUTkndK9sE_BuuYIUb3li2sZXgcdw5psio_zlMRycF1h7dtvtqc0gXr60x-
    dYdIq0OVEdPTi7AuKY>
X-ME-Received: <xmr:XrxmZpWFigCDMyF99Q0x1VukZuZF0pDyfj4v2qucOFZZZDNBIvxynahcR2xUygWLyodScN7TnSc7OL_2djL-qWE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedutddgtdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtsfdttddtjeenucfhrhhomheplfhonhgr
    thhhrghnucevrghlmhgvlhhsuceojhgtrghlmhgvlhhsseefgiigtddrnhgvtheqnecugg
    ftrfgrthhtvghrnhepkeekteegfefgvdefgfefffeufeffjedvudeijeehjeehffekjeek
    leffueelgffgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepjhgtrghlmhgvlhhsseefgiigtddrnhgvth
X-ME-Proxy: <xmx:XrxmZpgqPk_6F3e5JQ18-ltyf9uNdIpk3jU47q9k4RC_A1m-HkSIAA>
    <xmx:XrxmZhB3IOiTK8sDG3QzU35vcUkoWUzUhlt1H4t01NxV3RSUPw8VgA>
    <xmx:XrxmZiKucST3S9pfjfKdDEsNV54urVKt3wVhxz_XrYt_KNl9GdSMGg>
    <xmx:XrxmZgBCzxwwvZvceM4u8WKtEVlmeP_3n1PIWsMJ5HQgJ1N61m6WRg>
    <xmx:XrxmZtzmO1peIdr1owfiir_hApCQU2o9fIR5wZQfJTTv79xrcvqQ4J7P>
Feedback-ID: i76614979:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Jun 2024 04:42:02 -0400 (EDT)
Date: Mon, 10 Jun 2024 01:47:13 -0700
From: Jonathan Calmels <jcalmels@3xx0.net>
To: "Serge E. Hallyn" <serge@hallyn.com>
Cc: Andrew Morgan <morgan@kernel.org>, brauner@kernel.org,
 	ebiederm@xmission.com, Jonathan Corbet <corbet@lwn.net>,
 	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
 KP Singh <kpsingh@kernel.org>,
 	Matt Bobrowski <mattbobrowski@google.com>,
 Alexei Starovoitov <ast@kernel.org>,
 	Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>,
 	Martin KaFai Lau <martin.lau@linux.dev>,
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 	Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>,
 	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, 	Luis Chamberlain <mcgrof@kernel.org>,
 Kees Cook <kees@kernel.org>, 	Joel Granados <j.granados@samsung.com>,
 John Johansen <john.johansen@canonical.com>,
 	David Howells <dhowells@redhat.com>,
 Jarkko Sakkinen <jarkko@kernel.org>,
 	Stephen Smalley <stephen.smalley.work@gmail.com>,
 Ondrej Mosnacek <omosnace@redhat.com>, 	Mykola Lysenko <mykolal@fb.com>,
 Shuah Khan <shuah@kernel.org>, containers@lists.linux.dev,
 	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-doc@vger.kernel.org, 	linux-security-module@vger.kernel.org,
 bpf@vger.kernel.org, apparmor@lists.ubuntu.com,
 	keyrings@vger.kernel.org, selinux@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 1/4] capabilities: Add user namespace capabilities
Message-ID: <6pwskrbtmxjy2ti3xabfslmupjhat7dhrnbftinzhxgxnsveum@5jq5l6ws7hls>
References: <20240609104355.442002-1-jcalmels@3xx0.net>
 <20240609104355.442002-2-jcalmels@3xx0.net>
 <20240610015024.GA2182786@mail.hallyn.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240610015024.GA2182786@mail.hallyn.com>

On Sun, Jun 09, 2024 at 08:50:24PM GMT, Serge E. Hallyn wrote:
> On Sun, Jun 09, 2024 at 03:43:34AM -0700, Jonathan Calmels wrote:
> > Attackers often rely on user namespaces to get elevated (yet confined)
> > privileges in order to target specific subsystems (e.g. [1]). Distributions
> 
> I'd modify this to say "in order to target *bugs* in specific subsystems" :)

Ack

> > This effectively mimics the inheritable set rules and means that, by
> > default, only root in the user namespace can regain userns capabilities
> > previously dropped:
> 
> Something about this last sentence feels wrong, but I'm not sure what
> the best alternative would be.  As is, though, it makes it sound as though
> root in the userns can always regain previously dropped capabilities, but
> that's not true if dropped in ancestor ns, or if root also dropped the
> bits from its bounding set (right?).

Right, the wording is a little bit confusing here I admit.
What I meant to say is that if a cap is dropped in a *given* namespace,
then it can only be regained by root there. But yes, caps can never be
regained from ancestors ns. I'll try to rephrase it.

BTW, this is rather strict, but I think that's what we want right,
something simple? Alternative would be to have a new cap masked off by
default, but if granted to a userns, allows you to regain ancestors
caps.

