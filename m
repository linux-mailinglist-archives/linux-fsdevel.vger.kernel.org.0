Return-Path: <linux-fsdevel+bounces-7535-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F792826D60
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jan 2024 13:03:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B312A1F2287B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jan 2024 12:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F20DF2554A;
	Mon,  8 Jan 2024 12:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EKtr/gmb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541F621A06;
	Mon,  8 Jan 2024 12:02:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6272FC433C8;
	Mon,  8 Jan 2024 12:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704715362;
	bh=d/qetscOUyX1aNwfJUdo3Ou5VsBil4XgKNRo18oHsvI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EKtr/gmbBS+mVct55+nmFBL4MLHYqCo+eQzf4vI0qxYQyi0GgGqShw1vHjdyq0dvA
	 GQ18wyDwK+InRF/sx4e7L/AQfeGLuKrSechjRmN5iSRpW+S3TngTbDAYzo7EUNJ181
	 Ekyi3D7HdInveJi+mQVZpBJ+jfa7SBZFCUXTT+pedkcoQKRtShf7b69EcqaZdCZZac
	 8PkTBvXR5q5zS5Pc/3PYXnFWzf8h1EdELaKyDEW9QV2CqXLaK0nNjWREMPBhci2PQl
	 c/sSpU1tGrjRtHbYjJea6ZzakN9dXcpsFn8anRyDOJKfM5qUh1ZTLH0xTovogZXvyW
	 ACj9zZxCBSYuw==
Date: Mon, 8 Jan 2024 13:02:37 +0100
From: Christian Brauner <brauner@kernel.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Linus Torvalds <torvalds@linuxfoundation.org>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, netdev@vger.kernel.org, paul@paul-moore.com, 
	linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH bpf-next 03/29] bpf: introduce BPF token object
Message-ID: <20240108-gasheizung-umstand-a36d89ed36b7@brauner>
References: <20240103222034.2582628-1-andrii@kernel.org>
 <20240103222034.2582628-4-andrii@kernel.org>
 <CAHk-=wgmjr4nhxGheec1OwuYRk02d0+quUAViVk1v+w=Kvg15w@mail.gmail.com>
 <CAEf4Bzb6jnJL98SLPJB7Vjxo_O33W8HjJuAsyP3+6xigZtsTkA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4Bzb6jnJL98SLPJB7Vjxo_O33W8HjJuAsyP3+6xigZtsTkA@mail.gmail.com>

On Fri, Jan 05, 2024 at 02:18:40PM -0800, Andrii Nakryiko wrote:
> On Fri, Jan 5, 2024 at 1:45 PM Linus Torvalds
> <torvalds@linuxfoundation.org> wrote:
> >
> > Ok, I've gone through the whole series now, and I don't find anything
> > objectionable.
> 
> That's great, thanks for reviewing!
> 
> >
> > Which may only mean that I didn't notice something, of course, but at
> > least there's nothing I'd consider obvious.
> >
> > I keep coming back to this 03/29 patch, because it's kind of the heart
> > of it, and I have one more small nit, but it's also purely stylistic:
> >
> > On Wed, 3 Jan 2024 at 14:21, Andrii Nakryiko <andrii@kernel.org> wrote:
> > >
> > > +bool bpf_token_capable(const struct bpf_token *token, int cap)
> > > +{
> > > +       /* BPF token allows ns_capable() level of capabilities, but only if
> > > +        * token's userns is *exactly* the same as current user's userns
> > > +        */
> > > +       if (token && current_user_ns() == token->userns) {
> > > +               if (ns_capable(token->userns, cap))
> > > +                       return true;
> > > +               if (cap != CAP_SYS_ADMIN && ns_capable(token->userns, CAP_SYS_ADMIN))
> > > +                       return true;
> > > +       }
> > > +       /* otherwise fallback to capable() checks */
> > > +       return capable(cap) || (cap != CAP_SYS_ADMIN && capable(CAP_SYS_ADMIN));
> > > +}
> >
> > This *feels* like it should be written as
> >
> >     bool bpf_token_capable(const struct bpf_token *token, int cap)
> >     {
> >         struct user_namespace *ns = &init_ns;
> >
> >         /* BPF token allows ns_capable() level of capabilities, but only if
> >          * token's userns is *exactly* the same as current user's userns
> >          */
> >         if (token && current_user_ns() == token->userns)
> >                 ns = token->userns;
> >         return ns_capable(ns, cap) ||
> >                 (cap != CAP_SYS_ADMIN && capable(CAP_SYS_ADMIN));
> >     }
> >
> > And yes, I realize that the function will end up later growing a
> >
> >         security_bpf_token_capable(token, cap)
> >
> > test inside that 'if (token ..)' statement, and this would change the
> > order of that test so that the LSM hook would now be done before the
> > capability checks are done, but that all still seems just more of an
> > argument for the simplification.
> >
> > So the end result would be something like
> >
> >     bool bpf_token_capable(const struct bpf_token *token, int cap)
> >     {
> >         struct user_namespace *ns = &init_ns;
> >
> >         if (token && current_user_ns() == token->userns) {
> >                 if (security_bpf_token_capable(token, cap) < 0)
> >                         return false;
> >                 ns = token->userns;
> >         }
> >         return ns_capable(ns, cap) ||
> >                 (cap != CAP_SYS_ADMIN && capable(CAP_SYS_ADMIN));
> >     }
> 
> Yep, it makes sense to use ns_capable with init_ns. I'll change those
> two patches to end up with something like what you suggested here.
> 
> >
> > although I feel that with that LSM hook, maybe this all should return
> > the error code (zero or negative), not a bool for success?
> >
> > Also, should "current_user_ns() != token->userns" perhaps be an error
> > condition, rather than a "fall back to init_ns" condition?
> >
> > Again, none of this is a big deal. I do think you're dropping the LSM
> > error code on the floor, and are duplicating the "ns_capable()" vs
> > "capable()" logic as-is, but none of this is a deal breaker, just more
> > of my commentary on the patch and about the logic here.
> >
> > And yeah, I don't exactly love how you say "ok, if there's a token and
> > it doesn't match, I'll not use it" rather than "if the token namespace
> > doesn't match, it's an error", but maybe there's some usability issue
> > here?
> 
> Yes, usability was the primary concern. The overall idea with BPF

NAK on not restricting this to not erroring out on current_user_ns()
!= token->user_ns. I've said this multiple times before.

