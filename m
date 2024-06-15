Return-Path: <linux-fsdevel+bounces-21762-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A30289098DD
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Jun 2024 17:20:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB4551C21070
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Jun 2024 15:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2F794D9F4;
	Sat, 15 Jun 2024 15:20:14 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D3C94F5FB;
	Sat, 15 Jun 2024 15:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.66.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718464814; cv=none; b=t/qDyQvBWykUa4Y55oUZok5TibYHV4ya+DPfbm/tfss2drYKrCmPmzv8XQKA6VYB2L1Floj0Ilw1AE3uwlj9LgJtokPfB/LpoesMnLsNUHdxacBi8bBFjcjd6PJo/EQo5I5A9oi1q20psg931hxXzeYEyQunRIn3cjH9P45KFW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718464814; c=relaxed/simple;
	bh=IFh8KhffQ3yr0f1VsXFjXTwbEQq/G+GmRuWLfL7ScZg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R+doN4MywucFqVQdmjAMERqw4cu9tTMxZHkRX8o3/YXzxyLv0e2ioersrlQqdzSnigwT/H9d74yOFtuqN5hBz5zlwSJIpANGeYAaynva9oWH46Qzh+u1a7JzOR/nBBa7pcberwNrQRHxiY6EH8DcyNcgJqpwAoc1PsJlnbY/6Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com; spf=pass smtp.mailfrom=mail.hallyn.com; arc=none smtp.client-ip=178.63.66.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.hallyn.com
Received: by mail.hallyn.com (Postfix, from userid 1001)
	id A5A8DC18; Sat, 15 Jun 2024 10:20:10 -0500 (CDT)
Date: Sat, 15 Jun 2024 10:20:10 -0500
From: "Serge E. Hallyn" <serge@hallyn.com>
To: Jonathan Calmels <jcalmels@3xx0.net>
Cc: John Johansen <john.johansen@canonical.com>,
	Paul Moore <paul@paul-moore.com>, brauner@kernel.org,
	ebiederm@xmission.com, Jonathan Corbet <corbet@lwn.net>,
	James Morris <jmorris@namei.org>,
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
	Ondrej Mosnacek <omosnace@redhat.com>,
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
	containers@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-security-module@vger.kernel.org, bpf@vger.kernel.org,
	apparmor@lists.ubuntu.com, keyrings@vger.kernel.org,
	selinux@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 4/4] bpf,lsm: Allow editing capabilities in BPF-LSM
 hooks
Message-ID: <20240615152010.GB44653@mail.hallyn.com>
References: <CAHC9VhT5XWbhoY2Nw5jQz4GxpDriUdHw=1YsQ4xLVUtSnFxciA@mail.gmail.com>
 <z2bgjrzeq7crqx24chdbxnaanuhczbjnq6da3xw6al6omjj5xz@mqbzzzfva5sw>
 <887a3658-2d8d-4f9e-98f2-27124bb6f8e6@canonical.com>
 <CAHC9VhQFNPJTOct5rUv3HT6Z2S20mYdW75seiG8no5=fZd7JjA@mail.gmail.com>
 <uuvwcdsy7o4ulmrdzwffr6uywfacmlkjrontmjdj44luantpok@dtatxaa6tzyv>
 <CAHC9VhRnthf8+KgfuzFHXWEAc9RShDO0G_g0kc1OJ-UTih1ywg@mail.gmail.com>
 <rgzhcsblub7wedm734n56cw2qf6czjb4jgck6l5miur6odhovo@n5tgrco74zce>
 <CAHC9VhRGJTND25MFk4gR-FGxoLhMmgUrMpz_YoMFOwL6kr28zQ@mail.gmail.com>
 <ba8d88c8-a251-4c1f-8653-1082b0a101dd@canonical.com>
 <zwh766li4dwx5be6uxnxl2lhtxb4jsiua4atilpqvoeuksgz2h@v3pna3o3ewkp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <zwh766li4dwx5be6uxnxl2lhtxb4jsiua4atilpqvoeuksgz2h@v3pna3o3ewkp>

On Thu, Jun 13, 2024 at 01:50:29AM -0700, Jonathan Calmels wrote:
> On Wed, Jun 12, 2024 at 08:54:28PM GMT, John Johansen wrote:
> > On 6/12/24 10:29, Paul Moore wrote:
> > > On Wed, Jun 12, 2024 at 4:15 AM Jonathan Calmels <jcalmels@3xx0.net> wrote:
> > > > On Tue, Jun 11, 2024 at 06:38:31PM GMT, Paul Moore wrote:
> > > > > On Tue, Jun 11, 2024 at 6:15 PM Jonathan Calmels <jcalmels@3xx0.net> wrote:
> > > 
> > > ...
> > > 
> > > > > > Arguably, if we do want fine-grained userns policies, we need LSMs to
> > > > > > influence the userns capset at some point.
> > > > > 
> > > > > One could always use, or develop, a LSM that offers additional
> > > > > controls around exercising capabilities.  There are currently four
> > > > > in-tree LSMs, including the capabilities LSM, which supply a
> > > > > security_capable() hook that is used by the capability-based access
> > > > > controls in the kernel; all of these hook implementations work
> > > > > together within the LSM framework and provide an additional level of
> > > > > control/granularity beyond the existing capabilities.
> > > > 
> > > > Right, but the idea was to have a simple and easy way to reuse/trigger
> > > > as much of the commoncap one as possible from BPF. If we're saying we
> > > > need to reimplement and/or use a whole new framework, then there is
> > > > little value.
> > > 
> > > I can appreciate how allowing direct manipulation of capability bits
> > > from a BPF LSM looks attractive, but my hope is that our discussion
> > > here revealed that as you look deeper into making it work there are a
> > > number of pitfalls which prevent this from being a safe option for
> > > generalized systems.
> > > 
> > > > TBH, I don't feel strongly about this, which is why it is absent from
> > > > v1. However, as John pointed out, we should at least be able to modify
> > > > the blob if we want flexible userns caps policies down the road.
> > > 
> > > As discussed in this thread, there are existing ways to provide fine
> > > grained control over exercising capabilities that can be safely used
> > > within the LSM framework.  I don't want to speak to what John is
> > > envisioning, but he should be aware of these mechanisms, and if I
> > > recall he did voice a level of concern about the same worries I
> > > mentioned.
> > > 
> > 
> > sorry, I should have been more clear. I envision LSMs being able to
> > update their own state in the userns hook.
> > 
> > Basically the portion of the patch that removes const from the
> > userns hook.
> 
> Yes, pretty sure we'll need this regardless.
> 
> > An LSM updating the capset is worrysome for all the reasons you
> > pointed out, and I think a few more. I haven't had a chance to really
> > look at v2 yet, so I didn't want to speak directly on the bpf part of
> > the patch without first giving a good once over.
> > 
> > > I'm happy to discuss ways in which we can adjust the LSM hooks/layer
> > > to support different approaches to capability controls, but one LSM
> > > directly manipulating the state of another is going to be a no vote
> > > from me.
> > > 
> > I might not be as hard no as Paul here, I am always willing to listen
> > to arguments, but it would have to be a really good argument to
> > modify the capset, when there are multiple LSMs in play on a system.
> 
> The way I see it, it's more about enhancing the capability LSM with BPF
> hooks and have it modify its own state dynamically, not so much
> crosstalk between two distinct LSM frameworks (say one where the BPF
> LSM implements a lot of things like capable()).
> 
> In this context and with enough safeguards (say we only allow dropping
> caps) this could be a net positive. Sure, ordering could come into play
> in very specific scenarios, but at this point I would expect the
> admin/LSM author to be conscious about it.
> 
> If we think there is no way we can come up with something that's safe
> enough, and that the risks outweigh the benefits, fine by me, we can
> drop this patch from the series.

I think pursuing patches 1-3 now, and punting on 4 until later, would
be great.

