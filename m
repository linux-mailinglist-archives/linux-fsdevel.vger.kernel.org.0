Return-Path: <linux-fsdevel+bounces-21387-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D69D09034BC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2024 10:04:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E270F282873
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2024 08:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3EE8173346;
	Tue, 11 Jun 2024 08:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=3xx0.net header.i=@3xx0.net header.b="mZQbjnu5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CSZrK0Kd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from wflow1-smtp.messagingengine.com (wflow1-smtp.messagingengine.com [64.147.123.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8680F2AF11;
	Tue, 11 Jun 2024 08:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718093058; cv=none; b=LpRQaluXdGoY9wdkM0LDCP2nWoyRcndKsrHuryRKk/9BpO26aPUQcJsshSSGXdaZspDc97Dg/GhP3aftLokTGPDCgWfi3uoenQZWotQitOda0av5MHwuVXxgzXf02rk/LqgCNc1caiakLGW2QuH1BlD5PRSZUlUZL3GUFS9GwwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718093058; c=relaxed/simple;
	bh=i5PCbp0/q6PWz4TVWQpu/XHWdtU4gQtsM/eIXXS5bCo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ndaXJxABZVuXLCM7HDiVozNF3AcEvkenzxNJktu9GPWi5pNyxrhh/Z0cJ0cv6bJgTbW09F3os1xaPZ+kMeEQg3S54G/hR7e3meuB6edA/LcQu9eK+iEdINOcass02d2GF55W6Ezj8UdgVrWOfebkwfhxvQ3ESqrANUImEp2FsKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=3xx0.net; spf=pass smtp.mailfrom=3xx0.net; dkim=pass (2048-bit key) header.d=3xx0.net header.i=@3xx0.net header.b=mZQbjnu5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CSZrK0Kd; arc=none smtp.client-ip=64.147.123.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=3xx0.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=3xx0.net
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailflow.west.internal (Postfix) with ESMTP id 282092CC0167;
	Tue, 11 Jun 2024 04:04:12 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 11 Jun 2024 04:04:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=3xx0.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1718093051;
	 x=1718096651; bh=T/+yVl2zv0+WWZAFjJjZWDjIEaS6BfN4J4jIExynF6o=; b=
	mZQbjnu5j3Y6c5s3NSn+f0d3nDl8PoIpV2J7xwyMi9/WvD/RY1kTze8DRKg5Ob/9
	qdcDzg8z1JIHwDnn25DSApXsXTn6/bVuJosk8d9RnWp8rWzskRXM9PaWfzjSQcbO
	L/pICtn0oU8vqHYGhaUI1WhxzlfiEW2Clz2RiIucnveZEE0r7ic4GSTumjSm/+sx
	TwBH7RXzTN8uCCs8xL8Sbb4/3Mi1fvUv0uRTk5azsCKbpc82kY8WVMIrYDFbESmz
	tAKWOi8hA8Yb3/3nHam8loFLXet5LCOSdm5CHxishmCypoFw7WMqzrS6+GZqpoKW
	KSv/GyUZaUeeojOfo+9Vzg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1718093051; x=
	1718096651; bh=T/+yVl2zv0+WWZAFjJjZWDjIEaS6BfN4J4jIExynF6o=; b=C
	SZrK0KdQEkfShTQPNyvj4mlnKZ0Xbt96wH2Bk8SLgKtBosrmcGOS62Nxz2GgpRKh
	RM+s1SmAOHc8jwTQYcbXY4HfhyvA1X/BpdzYexyb3voF546hIMFrftL6byx/8Gq5
	CyxDkiIDN9oLRqT0Nf/LaUiqqX05eT1btd9UsyUmbwFpTvbGTA6DT3DuQvwfUBKc
	qA52qqMKRKtPR/9fjA9TbeDBTjsdN+FQxV3vQB7Zo6Dn7FU+V32DBRBd2xsUo4KD
	epx9fxt2GbDP3IDJj7N9Sx6AiW6gmuCXgkH2QW1AZX1ds1Dhu6HORajf9Tf9GL0+
	Sd5Mo8tvMorsvB3tmZk0Q==
X-ME-Sender: <xms:-wRoZpXrMrwrS2LBoRUf1CscHpzfEOrNAJKNPFtQhnL2ou4ekXBebw>
    <xme:-wRoZplIqIz-jLey3ypWwohXbLo_axCWylNtXJSop0FrUIU_rmjonZ32jdlWwBPFT
    iyChc6HdYd2moNtCsY>
X-ME-Received: <xmr:-wRoZla3TKdjigG_1iaNu_jfnqUKH-kmyaTaQ8PEpjIy_KzdOf026xrOdaJZbZ3hsIKHSjAW1_0YIc-XzHE-Kz8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeduuddguddvfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtugfgjgestheksfdttddtjeenucfhrhhomheplfho
    nhgrthhhrghnucevrghlmhgvlhhsuceojhgtrghlmhgvlhhsseefgiigtddrnhgvtheqne
    cuggftrfgrthhtvghrnhepleekffehueelieehveekjeeggfdufefffeeuvdetkeeigefg
    veekvedtfeegffegnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdplhgruhhntghhph
    grugdrnhgvthenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhr
    ohhmpehjtggrlhhmvghlshesfeiggidtrdhnvght
X-ME-Proxy: <xmx:-wRoZsW_jAS-81zAUR-g6jdd9E8ilJENs9OUd1rRv-1c8UA21Ym8_A>
    <xmx:-wRoZjlpGEBpk6d50L2m4A98pvBaAsuSdPz6BQm4X_y5dld9sd84LA>
    <xmx:-wRoZpefYCike81RvCyTXCdE9YDoVGo62yxfwbbeJ0ekaL6W3FmwhA>
    <xmx:-wRoZtEuV4QOEfDqcw9_xN4BTBgS0yEpp8zMtZ8VcYlL1hMBle_ObQ>
    <xmx:-wRoZtmBixysWk2mkeQa9y_IPYYypQgmdhR9RwxVXuUx8F-uV7TEZXxX>
Feedback-ID: i76614979:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Jun 2024 04:04:07 -0400 (EDT)
Date: Tue, 11 Jun 2024 01:09:18 -0700
From: Jonathan Calmels <jcalmels@3xx0.net>
To: Paul Moore <paul@paul-moore.com>
Cc: brauner@kernel.org, ebiederm@xmission.com,
 	Jonathan Corbet <corbet@lwn.net>, James Morris <jmorris@namei.org>,
 	"Serge E. Hallyn" <serge@hallyn.com>, KP Singh <kpsingh@kernel.org>,
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
Subject: Re: [PATCH v2 4/4] bpf,lsm: Allow editing capabilities in BPF-LSM
 hooks
Message-ID: <z2bgjrzeq7crqx24chdbxnaanuhczbjnq6da3xw6al6omjj5xz@mqbzzzfva5sw>
References: <20240609104355.442002-1-jcalmels@3xx0.net>
 <20240609104355.442002-5-jcalmels@3xx0.net>
 <CAHC9VhT5XWbhoY2Nw5jQz4GxpDriUdHw=1YsQ4xLVUtSnFxciA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhT5XWbhoY2Nw5jQz4GxpDriUdHw=1YsQ4xLVUtSnFxciA@mail.gmail.com>

On Sun, Jun 09, 2024 at 08:18:48PM GMT, Paul Moore wrote:
> On Sun, Jun 9, 2024 at 6:40 AM Jonathan Calmels <jcalmels@3xx0.net> wrote:
> >
> > This patch allows modifying the various capabilities of the struct cred
> > in BPF-LSM hooks. More specifically, the userns_create hook called
> > prior to creating a new user namespace.
> >
> > With the introduction of userns capabilities, this effectively provides
> > a simple way for LSMs to control the capabilities granted to a user
> > namespace and all its descendants.
> >
> > Update the selftests accordingly by dropping CAP_SYS_ADMIN in
> > namespaces and checking the resulting task's bounding set.
> >
> > Signed-off-by: Jonathan Calmels <jcalmels@3xx0.net>
> > ---
> >  include/linux/lsm_hook_defs.h                 |  2 +-
> >  include/linux/security.h                      |  4 +-
> >  kernel/bpf/bpf_lsm.c                          | 55 +++++++++++++++++++
> >  security/apparmor/lsm.c                       |  2 +-
> >  security/security.c                           |  6 +-
> >  security/selinux/hooks.c                      |  2 +-
> >  .../selftests/bpf/prog_tests/deny_namespace.c | 12 ++--
> >  .../selftests/bpf/progs/test_deny_namespace.c |  7 ++-
> >  8 files changed, 76 insertions(+), 14 deletions(-)
> 
> I'm not sure we want to go down the path of a LSM modifying the POSIX
> capabilities of a task, other than the capabilities/commoncap LSM.  It
> sets a bad precedent and could further complicate issues around LSM
> ordering.

Well unless I'm misunderstanding, this does allow modifying the
capabilities/commoncap LSM through BTF. The reason for allowing
`userns_create` to be modified is that it is functionally very similar
to `cred_prepare` in that it operates with new creds (but specific to
user namespaces because of reasons detailed in [1]). 

There were some concerns in previous threads that the userns caps by
themselves wouldn't be granular enough, hence the LSM integration.
Ubuntu for example, currently has to resort to a hardcoded profile
transition to achieve this [2].

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=7cd4c5c2101cb092db00f61f69d24380cf7a0ee8
[2] https://git.launchpad.net/~ubuntu-kernel/ubuntu/+source/linux/+git/noble/commit/?id=43a6c29532f517179fea8c94949d657d71f4fc13

