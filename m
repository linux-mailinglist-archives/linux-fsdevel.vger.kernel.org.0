Return-Path: <linux-fsdevel+bounces-21516-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98101904DDB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jun 2024 10:16:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B5C91F22ADB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jun 2024 08:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59C0616D4C8;
	Wed, 12 Jun 2024 08:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=3xx0.net header.i=@3xx0.net header.b="T/COupJO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Q1t7Oopg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from wflow5-smtp.messagingengine.com (wflow5-smtp.messagingengine.com [64.147.123.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A355416D305;
	Wed, 12 Jun 2024 08:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718180148; cv=none; b=deuYjV9nKHnGLkYfwfED7o3lUPR0/MFNmCpqhtaDOvm4EMBvbcEOnUGBfjSRpbCZcJSZ1RYIi1EqN0ngido1OsgXDYs9h45fPWfuR62w80ykrEgkKAMVaQAQzT1nvvR2b5KE/OVCXUgwM1FGMxnCbcjt4kXC31Vc58JfCGmhFZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718180148; c=relaxed/simple;
	bh=U6hukzBbxKrvojtraGdCUg5S848y4qN0OYQuMf0rzt8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nPBxECaVt8IPUzcE/h+brj/Pizn8iUe3t2kAg62fb/+qwW2rPShxzVf6zJ0EySVPwHHfZ0eyhGJsbcdCffXlAO3GPjnL+ds62jqBijMwMOoHFu5117epb8GpQR+LhzUFHoNfSVCcb0LsDWnz+smHkKyXonCz6SYTrQzGvHYfoZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=3xx0.net; spf=pass smtp.mailfrom=3xx0.net; dkim=pass (2048-bit key) header.d=3xx0.net header.i=@3xx0.net header.b=T/COupJO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Q1t7Oopg; arc=none smtp.client-ip=64.147.123.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=3xx0.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=3xx0.net
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailflow.west.internal (Postfix) with ESMTP id 56FE02CC01F5;
	Wed, 12 Jun 2024 04:15:43 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 12 Jun 2024 04:15:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=3xx0.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1718180142;
	 x=1718183742; bh=HeipJvuPUXcxMs0ABdL536egEdVvkPwYQPNqw34NrRM=; b=
	T/COupJOcGQBBzKb4rbSed3jgNiyDZbxjs5JEtO62DxXUNSbNnBaXJ6I3BPKd6Z+
	6ARsd0guK71kwjXw1RDdKg5FDdOuWZkhwcyazmIZQ+0GGUiPXA//nZRmjiyKDLNQ
	H3/FNjklRKt6S0bTwlxmBGERxBLF6m4484BT0r9L+hTKInVQ+3ZYLh5YNyhJQYXp
	ZZZMseNCt+e5LtkzAJE90jHuYM3sIq1I7W7lunhkpVB8TAmty1La50EuAaJ2vR/x
	PTEbGgbt62p4WoIo7bG36hXKZCWOBjYI6WmrR/4jUJFSGtN1AaNl7FrHu6maHb+C
	adktYiXIICDWSH7ngkbRJg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1718180142; x=
	1718183742; bh=HeipJvuPUXcxMs0ABdL536egEdVvkPwYQPNqw34NrRM=; b=Q
	1t7OopgDslFmy8Sn7kpNoKmWbzt3Z2MGoExLH6bfO3TYPzfnfQmHEmYzcMmDYeHV
	4dOdhWYUwwev8eBSiP2BjHKfakaj7tjqMPnm2sdSXNNRycOPLgtwenCOF46yNAyx
	pPGsiB5WI1cN0szwAA8d9Y57IMMJlW3Ei1JOljlO9f5ryb0xDOh5eGgEy9Jj/ToU
	J12o9vnGWKGOfi3Pf99MDmRwkD/fZLuT0kChTde7Io3QW+/d+bIpBFmWeAnhDtLL
	Sktq4hNvnEGvGrHexapT4Ja5f4O0hdjtDsDaNSAJp70b6y8l05Fy5XHVTfs3iZLk
	IGtT76BrLZv7Sbyt6kHjw==
X-ME-Sender: <xms:LllpZr8xON2t8JBtvP8z2r9RPYAmVXKWxpra7VsoLzksHIWrVAqsTw>
    <xme:LllpZnvkqHMbLn7nTwJpStwes9BHkU7PymLNoNE0gBFFBIWcXFG3r7Wg35DH8sg6E
    Ww3SmzOnbYfBIBkWs8>
X-ME-Received: <xmr:LllpZpAi9D44gg8B35OwmmG863qQRbZ6qMZRrXVT34TXUCAV6qQheTcH-4QZDZnznyXra_ThPng13sWtDhfFg7Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedugedgtdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggugfgjsehtkefstddttdejnecuhfhrohhmpeflohhn
    rghthhgrnhcuvegrlhhmvghlshcuoehjtggrlhhmvghlshesfeiggidtrdhnvghtqeenuc
    ggtffrrghtthgvrhhnpeetgedutdfggeetleefhfeuhedtheduteekieduvdeigeegvdev
    vddtieekiedvheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehjtggrlhhmvghlshesfeiggidtrdhnvght
X-ME-Proxy: <xmx:LllpZneDoyZ-RX3X4rVUuUmiN2s53H0HQpEPmjarSlJmdbeNsrC-cg>
    <xmx:LllpZgOos_vdtrYhH4zy-fXOAUsMnhJPoF2-A5YI2fB8xlNbQzKhqQ>
    <xmx:LllpZpnXG5LqLB-ZltLJVdyjPBFYDlsy8SHeGNxT_BRuOggOAb-DYg>
    <xmx:LllpZqvTNxszjuD5ehQbJyHiu7_SOSqdldAZXDNby64nJkUiYieeqQ>
    <xmx:LllpZquORTNviG0fl8x754yxTGr1qD6L8k5YykdTsQFtiAHXFTPbkZnD>
Feedback-ID: i76614979:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Jun 2024 04:15:38 -0400 (EDT)
Date: Wed, 12 Jun 2024 01:20:49 -0700
From: Jonathan Calmels <jcalmels@3xx0.net>
To: Paul Moore <paul@paul-moore.com>
Cc: John Johansen <john.johansen@canonical.com>, brauner@kernel.org,
 	ebiederm@xmission.com, Jonathan Corbet <corbet@lwn.net>,
 	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>,
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
 David Howells <dhowells@redhat.com>,
 	Jarkko Sakkinen <jarkko@kernel.org>,
 Stephen Smalley <stephen.smalley.work@gmail.com>,
 	Ondrej Mosnacek <omosnace@redhat.com>, Mykola Lysenko <mykolal@fb.com>,
 Shuah Khan <shuah@kernel.org>, 	containers@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 	linux-doc@vger.kernel.org, linux-security-module@vger.kernel.org,
 bpf@vger.kernel.org, 	apparmor@lists.ubuntu.com,
 keyrings@vger.kernel.org, selinux@vger.kernel.org,
 	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 4/4] bpf,lsm: Allow editing capabilities in BPF-LSM
 hooks
Message-ID: <rgzhcsblub7wedm734n56cw2qf6czjb4jgck6l5miur6odhovo@n5tgrco74zce>
References: <20240609104355.442002-1-jcalmels@3xx0.net>
 <20240609104355.442002-5-jcalmels@3xx0.net>
 <CAHC9VhT5XWbhoY2Nw5jQz4GxpDriUdHw=1YsQ4xLVUtSnFxciA@mail.gmail.com>
 <z2bgjrzeq7crqx24chdbxnaanuhczbjnq6da3xw6al6omjj5xz@mqbzzzfva5sw>
 <887a3658-2d8d-4f9e-98f2-27124bb6f8e6@canonical.com>
 <CAHC9VhQFNPJTOct5rUv3HT6Z2S20mYdW75seiG8no5=fZd7JjA@mail.gmail.com>
 <uuvwcdsy7o4ulmrdzwffr6uywfacmlkjrontmjdj44luantpok@dtatxaa6tzyv>
 <CAHC9VhRnthf8+KgfuzFHXWEAc9RShDO0G_g0kc1OJ-UTih1ywg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhRnthf8+KgfuzFHXWEAc9RShDO0G_g0kc1OJ-UTih1ywg@mail.gmail.com>

On Tue, Jun 11, 2024 at 06:38:31PM GMT, Paul Moore wrote:
> On Tue, Jun 11, 2024 at 6:15 PM Jonathan Calmels <jcalmels@3xx0.net> wrote:
> > On Tue, Jun 11, 2024 at 03:01:01PM GMT, Paul Moore wrote:
> > > On Tue, Jun 11, 2024 at 6:32 AM John Johansen
> > > <john.johansen@canonical.com> wrote:
> > > >
> > > > On 6/11/24 01:09, Jonathan Calmels wrote:
> > > > > On Sun, Jun 09, 2024 at 08:18:48PM GMT, Paul Moore wrote:
> > > > >> On Sun, Jun 9, 2024 at 6:40 AM Jonathan Calmels <jcalmels@3xx0.net> wrote:
> > > > >>>
> > > > >>> This patch allows modifying the various capabilities of the struct cred
> > > > >>> in BPF-LSM hooks. More specifically, the userns_create hook called
> > > > >>> prior to creating a new user namespace.
> > > > >>>
> > > > >>> With the introduction of userns capabilities, this effectively provides
> > > > >>> a simple way for LSMs to control the capabilities granted to a user
> > > > >>> namespace and all its descendants.
> > > > >>>
> > > > >>> Update the selftests accordingly by dropping CAP_SYS_ADMIN in
> > > > >>> namespaces and checking the resulting task's bounding set.
> > > > >>>
> > > > >>> Signed-off-by: Jonathan Calmels <jcalmels@3xx0.net>
> > > > >>> ---
> > > > >>>   include/linux/lsm_hook_defs.h                 |  2 +-
> > > > >>>   include/linux/security.h                      |  4 +-
> > > > >>>   kernel/bpf/bpf_lsm.c                          | 55 +++++++++++++++++++
> > > > >>>   security/apparmor/lsm.c                       |  2 +-
> > > > >>>   security/security.c                           |  6 +-
> > > > >>>   security/selinux/hooks.c                      |  2 +-
> > > > >>>   .../selftests/bpf/prog_tests/deny_namespace.c | 12 ++--
> > > > >>>   .../selftests/bpf/progs/test_deny_namespace.c |  7 ++-
> > > > >>>   8 files changed, 76 insertions(+), 14 deletions(-)
> > > > >>
> > > > >> I'm not sure we want to go down the path of a LSM modifying the POSIX
> > > > >> capabilities of a task, other than the capabilities/commoncap LSM.  It
> > > > >> sets a bad precedent and could further complicate issues around LSM
> > > > >> ordering.
> > > > >
> > > > > Well unless I'm misunderstanding, this does allow modifying the
> > > > > capabilities/commoncap LSM through BTF. The reason for allowing
> > > > > `userns_create` to be modified is that it is functionally very similar
> > > > > to `cred_prepare` in that it operates with new creds (but specific to
> > > > > user namespaces because of reasons detailed in [1]).
> > > >
> > > > yes
> > > >
> > > > > There were some concerns in previous threads that the userns caps by
> > > > > themselves wouldn't be granular enough, hence the LSM integration.
> > > >
> > > > > Ubuntu for example, currently has to resort to a hardcoded profile
> > > > > transition to achieve this [2].
> > > > >
> > > >
> > > > The hard coded profile transition, is because the more generic solution
> > > > as part of policy just wasn't ready. The hard coding will go away before
> > > > it is upstreamed.
> > > >
> > > > But yes, updating the cred really is necessary for the flexibility needed
> > > > whether it is modifying the POSIX capabilities of the task or the LSM
> > > > modifying its own security blob.
> > > >
> > > > I do share some of Paul's concerns about the LSM modifying the POSIX
> > > > capabilities of the task, but also thing the LSM here needs to be
> > > > able to modify its own blob.
> > >
> > > To be clear, this isn't about a generic LSM needing to update its own
> > > blob (LSM state), it is about the BPF LSM updating the capability
> > > sets.  While we obviously must support a LSM updating its own state,
> > > I'm currently of the opinion that allowing one LSM to update the state
> > > of another LSM is only going to lead to problems.  We wouldn't want to
> > > allow Smack to update AppArmor state, and from my current perspective
> > > allowing the BPF LSM to update the capability state is no different.
> > >
> > > It's also important to keep in mind that if we allow one LSM to do
> > > something, we need to allow all LSMs to do something.  If we allow
> > > multiple LSMs to manipulate the capability sets, how do we reconcile
> > > differences in the desired capability state?  Does that resolution
> > > change depending on what LSMs are enabled at build time?  Enabled at
> > > boot?  Similarly, what about custom LSM ordering?
> > >
> > > What about those LSMs that use a task's capabilities as an input to an
> > > access control decision?  If those LSMs allow an access based on a
> > > given capability set only to have a LSM later in the ordering modify
> > > that capability set to something which would have resulted in an
> > > access denial, do we risk a security regression?
> >
> > I understand the concerns, what I fail to understand however, is how is
> > it any different from say the `cred_prepare` hook today?
> 
> The existing cred_prepare hooks only operate on their own small
> portion of the cred::security blob.  What you are proposing would be
> the BPF LSM operating on the capability sets that it does not "own"
> (they belong to the capability LSM).
> 
> If you see that as a minor difference, please understand that if you
> skip past that you have all the issues I mentioned in my previous
> message to deal with.
> 
> > > Our current approach to handling multiple LSMs is that each LSM is
> > > limited to modifying its own state, and I'm pretty confident that we
> > > stick to this model if we have any hope of preserving the sanity of
> > > the LSM layer as a whole.  If you want to modify the capability set
> > > you need to do so within the confines of the capability LSM and/or
> > > modify the other related kernel subsystems (which I'm guessing will
> > > likely necessitate a change in the LSMs, but that avenue is very
> > > unclear if such an option even exists).
> >
> > What do you mean by "within the confines of the capability LSM" here?
> 
> Basically security/commoncap.c.  One could make a lot of arguments
> about if it is, or isn't, a LSM, but commoncap.c registers LSM hooks
> which is pretty much the definition of a LSM from an implementation
> point of view.

Yes, hence the proposal to give it more fine-grained controls than
what's currently available. But to your point, unlike the others,
its own state (i.e. capsets) is shared, so this gets questionable.

> > Arguably, if we do want fine-grained userns policies, we need LSMs to
> > influence the userns capset at some point.
> 
> One could always use, or develop, a LSM that offers additional
> controls around exercising capabilities.  There are currently four
> in-tree LSMs, including the capabilities LSM, which supply a
> security_capable() hook that is used by the capability-based access
> controls in the kernel; all of these hook implementations work
> together within the LSM framework and provide an additional level of
> control/granularity beyond the existing capabilities.

Right, but the idea was to have a simple and easy way to reuse/trigger
as much of the commoncap one as possible from BPF. If we're saying we
need to reimplement and/or use a whole new framework, then there is
little value.

TBH, I don't feel strongly about this, which is why it is absent from
v1. However, as John pointed out, we should at least be able to modify
the blob if we want flexible userns caps policies down the road.

