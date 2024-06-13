Return-Path: <linux-fsdevel+bounces-21632-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDA92906A60
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2024 12:46:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9149B21045
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2024 10:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3064F14290F;
	Thu, 13 Jun 2024 10:46:37 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from wind.enjellic.com (wind.enjellic.com [76.10.64.91])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06DAB137C25;
	Thu, 13 Jun 2024 10:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=76.10.64.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718275596; cv=none; b=Zb8mOEiiqoXAw47nrbxpL2tlvE9WlQgDOuwDcJgpwwYDwHJzdRJLawVGgny8cz6TRsePa/YTYS8W+eNZS7TVmGpfOBDMzXP2seFENsJHwEn/XCjIwqPE7Q8QT/71pa31G9bZY50yvZH5uz631QF1DynXeVFtcdMq14MSPeMvFiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718275596; c=relaxed/simple;
	bh=NNoLj6NG7+/lmRKiScF9b/hfIGCzN5rkCrwpdxpZr1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Mime-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kG1Le8SS6adOcmmB1k7GI0L1yFL4wiYCwqlEDde+nC0HM0cj8W9qVczZFEFPQYTJXgmxwiPYpzXBbgDycXZLPjpFQEn/TKqV8ccwcSue+GEiAlhrPQlXDBB2aGbFXT51AtXltmCdgPsq+jlQlsiXpeOUvkn+nKInqNlBvcdVmIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enjellic.com; spf=pass smtp.mailfrom=wind.enjellic.com; arc=none smtp.client-ip=76.10.64.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enjellic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wind.enjellic.com
Received: from wind.enjellic.com (localhost [127.0.0.1])
	by wind.enjellic.com (8.15.2/8.15.2) with ESMTP id 45DAjF41023155;
	Thu, 13 Jun 2024 05:45:15 -0500
Received: (from greg@localhost)
	by wind.enjellic.com (8.15.2/8.15.2/Submit) id 45DAjC98023150;
	Thu, 13 Jun 2024 05:45:12 -0500
Date: Thu, 13 Jun 2024 05:45:12 -0500
From: "Dr. Greg" <greg@enjellic.com>
To: John Johansen <john.johansen@canonical.com>
Cc: Paul Moore <paul@paul-moore.com>, Jonathan Calmels <jcalmels@3xx0.net>,
        brauner@kernel.org, ebiederm@xmission.com,
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
        Jiri Olsa <jolsa@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <kees@kernel.org>, Joel Granados <j.granados@samsung.com>,
        David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Ondrej Mosnacek <omosnace@redhat.com>, Mykola Lysenko <mykolal@fb.com>,
        Shuah Khan <shuah@kernel.org>, containers@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-security-module@vger.kernel.org,
        bpf@vger.kernel.org, apparmor@lists.ubuntu.com,
        keyrings@vger.kernel.org, selinux@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 4/4] bpf,lsm: Allow editing capabilities in BPF-LSM hooks
Message-ID: <20240613104512.GA22971@wind.enjellic.com>
Reply-To: "Dr. Greg" <greg@enjellic.com>
References: <20240609104355.442002-5-jcalmels@3xx0.net> <CAHC9VhT5XWbhoY2Nw5jQz4GxpDriUdHw=1YsQ4xLVUtSnFxciA@mail.gmail.com> <z2bgjrzeq7crqx24chdbxnaanuhczbjnq6da3xw6al6omjj5xz@mqbzzzfva5sw> <887a3658-2d8d-4f9e-98f2-27124bb6f8e6@canonical.com> <CAHC9VhQFNPJTOct5rUv3HT6Z2S20mYdW75seiG8no5=fZd7JjA@mail.gmail.com> <uuvwcdsy7o4ulmrdzwffr6uywfacmlkjrontmjdj44luantpok@dtatxaa6tzyv> <CAHC9VhRnthf8+KgfuzFHXWEAc9RShDO0G_g0kc1OJ-UTih1ywg@mail.gmail.com> <rgzhcsblub7wedm734n56cw2qf6czjb4jgck6l5miur6odhovo@n5tgrco74zce> <CAHC9VhRGJTND25MFk4gR-FGxoLhMmgUrMpz_YoMFOwL6kr28zQ@mail.gmail.com> <ba8d88c8-a251-4c1f-8653-1082b0a101dd@canonical.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ba8d88c8-a251-4c1f-8653-1082b0a101dd@canonical.com>
User-Agent: Mutt/1.4i
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.2.3 (wind.enjellic.com [127.0.0.1]); Thu, 13 Jun 2024 05:45:15 -0500 (CDT)

On Wed, Jun 12, 2024 at 08:54:28PM -0700, John Johansen wrote:

Good morning, I hope the day is going well for everyone.

> On 6/12/24 10:29, Paul Moore wrote:
> >On Wed, Jun 12, 2024 at 4:15???AM Jonathan Calmels <jcalmels@3xx0.net> 
> >wrote:
> >>On Tue, Jun 11, 2024 at 06:38:31PM GMT, Paul Moore wrote:
> >>>On Tue, Jun 11, 2024 at 6:15???PM Jonathan Calmels <jcalmels@3xx0.net> 
> >>>wrote:
> >
> >...
> >
> >>>>Arguably, if we do want fine-grained userns policies, we need LSMs to
> >>>>influence the userns capset at some point.
> >>>
> >>>One could always use, or develop, a LSM that offers additional
> >>>controls around exercising capabilities.  There are currently four
> >>>in-tree LSMs, including the capabilities LSM, which supply a
> >>>security_capable() hook that is used by the capability-based access
> >>>controls in the kernel; all of these hook implementations work
> >>>together within the LSM framework and provide an additional level of
> >>>control/granularity beyond the existing capabilities.
> >>
> >>Right, but the idea was to have a simple and easy way to reuse/trigger
> >>as much of the commoncap one as possible from BPF. If we're saying we
> >>need to reimplement and/or use a whole new framework, then there is
> >>little value.
> >
> >I can appreciate how allowing direct manipulation of capability bits
> >from a BPF LSM looks attractive, but my hope is that our discussion
> >here revealed that as you look deeper into making it work there are a
> >number of pitfalls which prevent this from being a safe option for
> >generalized systems.
> >
> >>TBH, I don't feel strongly about this, which is why it is absent from
> >>v1. However, as John pointed out, we should at least be able to modify
> >>the blob if we want flexible userns caps policies down the road.
> >
> >As discussed in this thread, there are existing ways to provide fine
> >grained control over exercising capabilities that can be safely used
> >within the LSM framework.  I don't want to speak to what John is
> >envisioning, but he should be aware of these mechanisms, and if I
> >recall he did voice a level of concern about the same worries I
> >mentioned.
> >
> 
> sorry, I should have been more clear. I envision LSMs being able to
> update their own state in the userns hook.
> 
> Basically the portion of the patch that removes const from the
> userns hook.
> 
> An LSM updating the capset is worrysome for all the reasons you
> pointed out, and I think a few more. I haven't had a chance to really
> look at v2 yet, so I didn't want to speak directly on the bpf part of
> the patch without first giving a good once over.
> 
> >I'm happy to discuss ways in which we can adjust the LSM hooks/layer
> >to support different approaches to capability controls, but one LSM
> >directly manipulating the state of another is going to be a no vote
> >from me.
> >
> I might not be as hard no as Paul here, I am always willing to listen
> to arguments, but it would have to be a really good argument to
> modify the capset, when there are multiple LSMs in play on a system.

Putting my pragmatic operations hat on, it isn't just the impact on
multiple LSM's.

The security vendors, CrowdStrike's Falcon comes immediately to mind,
are installing BPF hooks as part of their agent systems.

Given that the issue of signing BPF programs is still an open
question, allowing the ability of a BPF program to modify the security
capabilities of a process opens the door to supply chain attacks that
would seem unbounded in scope.

On the other side of the fence, installing a BPF program is a
privileged operation.  If a decision is made to allow that kind of
privilege on a system the argument can be made that you get to keep
both pieces.

Of course that needs to be paired against the fact that system's
administrators are not given any choice as to the wisdom of that type
of permission being afforded to security applications.

Best wishes for a productive remainder of the week.

As always,
Dr. Greg

The Quixote Project - Flailing at the Travails of Cybersecurity
              https://github.com/Quixote-Project

