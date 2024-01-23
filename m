Return-Path: <linux-fsdevel+bounces-8602-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EF30839384
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 16:47:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D4C31C255B9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 15:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20384627FA;
	Tue, 23 Jan 2024 15:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YYASV1HO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EFF26025A;
	Tue, 23 Jan 2024 15:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706024377; cv=none; b=L2EYutP8nivL04C5Joe+HdCdk/qCqi7R5GwwiDRUwIr9Wef7hAvUs35pPjuOqbhsRXAM7fvFgNbNDUD673Vipo3wuj+slV5phr2mcfdMej8RYxrcxTLccrSEyNXg+vKAN/0jxzlTcsOOQvfvP7Y8Z/18ijrYCWmVbEmj/RP1gFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706024377; c=relaxed/simple;
	bh=I+Fk/lQymdlUbpEC80NeWgpwGxk57+2otkrBbMctKZw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HVK5wIyzDH4PgqDGbH02cvJBAJiIyyRe6YJhZzF6EeolnyJitlh7LrQk00JvZSF2PsT5Cxf2nFLwXIACNlItozMsk65peOfm6u2JnxZdFnpCjDJjmuNpPIjRo29VStd6ZhjFEv7Bl43XwhSY6Eajr2yPrPlQJfrJK7O4jEAwPIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YYASV1HO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4624C433F1;
	Tue, 23 Jan 2024 15:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706024377;
	bh=I+Fk/lQymdlUbpEC80NeWgpwGxk57+2otkrBbMctKZw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YYASV1HO9BUhRE8EBNVhLjYVoHangNHpU0L5uj7Y42Cu5bWnRvNJeRWazLyuQrer5
	 APO9qGWK3YKE6tDETMwmr3jFp2H6Nhc8XC3jtsKleDA+mbdjKIxHRhakMaKDIQrT4v
	 zitFyW4NMzHFGan/wNpyQ2G2jz4fNCvFqKfADdmXROdId2+GqQPjHo0TRwaYqGxHRp
	 HngteP7XQSXapOYoT3hOaxMUlpMiSU1LO1Sd0qMICB0bFyQ9//zZdNf/5boJveNJ9X
	 qTpbgG1sOoBO4fepWow6PsYHNv58s1P0obMg9p+As6FcIOBwfvEQU4qT5VICAoVimK
	 fbA/y5AZw1aXA==
Date: Tue, 23 Jan 2024 16:39:31 +0100
From: Christian Brauner <brauner@kernel.org>
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Cc: Amir Goldstein <amir73il@gmail.com>, hu1.chen@intel.com, 
	miklos@szeredi.hu, malini.bhandaru@intel.com, tim.c.chen@intel.com, 
	mikko.ylinen@intel.com, lizhen.you@intel.com, linux-unionfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel <linux-fsdevel@vger.kernel.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, David Howells <dhowells@redhat.com>, 
	Seth Forshee <sforshee@kernel.org>
Subject: Re: [RFC] HACK: overlayfs: Optimize overlay/restore creds
Message-ID: <20240123-apparat-flohen-a18640d08ae2@brauner>
References: <CAOQ4uxg-WvdcuCrQg7zp03ocNZoT-G2bpi=Y6nVxMTodyFAUbg@mail.gmail.com>
 <20231214220222.348101-1-vinicius.gomes@intel.com>
 <CAOQ4uxhJmjeSSM5iQyDadbj5UNjPqvh1QPLpSOVEYFbNbsjDQQ@mail.gmail.com>
 <87v88zp76v.fsf@intel.com>
 <CAOQ4uxiCVv7zbfn2BPrR9kh=DvGxQtXUmRvy2pDJ=G7rxjBrgg@mail.gmail.com>
 <CAOQ4uxhxvFt3_Wb3BGcjj4pGp=OFTBHNPJ4r4eH8245t-+CW+g@mail.gmail.com>
 <20231218-intim-lehrstellen-dbe053d6c3a8@brauner>
 <875y0vp41g.fsf@intel.com>
 <CAOQ4uxibYMQw0iszKhE5uxBnyayHWjqp4ZnOOiugO3GxMRS1eA@mail.gmail.com>
 <87le9qntwo.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87le9qntwo.fsf@intel.com>

On Tue, Dec 19, 2023 at 06:33:59AM -0800, Vinicius Costa Gomes wrote:
> Amir Goldstein <amir73il@gmail.com> writes:
> 
> > On Mon, Dec 18, 2023 at 11:57 PM Vinicius Costa Gomes
> > <vinicius.gomes@intel.com> wrote:
> >>
> >> Christian Brauner <brauner@kernel.org> writes:
> >>
> >> >> > Yes, the important thing is that an object cannot change
> >> >> > its non_refcount property during its lifetime -
> >> >>
> >> >> ... which means that put_creds_ref() should assert that
> >> >> there is only a single refcount - the one handed out by
> >> >> prepare_creds_ref() before removing non_refcount or
> >> >> directly freeing the cred object.
> >> >>
> >> >> I must say that the semantics of making a non-refcounted copy
> >> >> to an object whose lifetime is managed by the caller sounds a lot
> >> >> less confusing to me.
> >> >
> >> > So can't we do an override_creds() variant that is effectively just:
> >
> > Yes, I think that we can....
> >
> >> >
> >> > /* caller guarantees lifetime of @new */
> >> > const struct cred *foo_override_cred(const struct cred *new)
> >> > {
> >> >       const struct cred *old = current->cred;
> >> >       rcu_assign_pointer(current->cred, new);
> >> >       return old;
> >> > }
> >> >
> >> > /* caller guarantees lifetime of @old */
> >> > void foo_revert_creds(const struct cred *old)
> >> > {
> >> >       const struct cred *override = current->cred;
> >> >       rcu_assign_pointer(current->cred, old);
> >> > }
> >> >
> >
> > Even better(?), we can do this in the actual guard helpers to
> > discourage use without a guard:
> >
> > struct override_cred {
> >         struct cred *cred;
> > };
> >
> > DEFINE_GUARD(override_cred, struct override_cred *,
> >             override_cred_save(_T),
> >             override_cred_restore(_T));
> >
> > ...
> >
> > void override_cred_save(struct override_cred *new)
> > {
> >         new->cred = rcu_replace_pointer(current->cred, new->cred, true);
> > }
> >
> > void override_cred_restore(struct override_cred *old)
> > {
> >         rcu_assign_pointer(current->cred, old->cred);
> > }
> >
> >> > Maybe I really fail to understand this problem or the proposed solution:
> >> > the single reference that overlayfs keeps in ovl->creator_cred is tied
> >> > to the lifetime of the overlayfs superblock, no? And anyone who needs a
> >> > long term cred reference e.g, file->f_cred will take it's own reference
> >> > anyway. So it should be safe to just keep that reference alive until
> >> > overlayfs is unmounted, no? I'm sure it's something quite obvious why
> >> > that doesn't work but I'm just not seeing it currently.
> >>
> >> My read of the code says that what you are proposing should work. (what
> >> I am seeing is that in the "optimized" cases, the only practical effect
> >> of override/revert is the rcu_assign_pointer() dance)
> >>
> >> I guess that the question becomes: Do we want this property (that the
> >> 'cred' associated with a subperblock/similar is long lived and the
> >> "inner" refcount can be omitted) to be encoded in the constructor? Or do
> >> we want it to be "encoded" in a call by call basis?
> >>
> >
> > Neither.
> >
> > Christian's proposal does not involve marking the cred object as
> > long lived, which looks a much better idea to me.
> >
> 
> In my mind, I am reading his suggestion as the flag "long lived
> cred/lives long enough" is "in our brains" vs. what I proposed that the
> flag was "in the object". The effect of the "flag" is the same: when to
> use a lighter version (no refcount) of override/revert.
> 
> What I was thinking was more more under the covers, implicit. And I can
> see the advantages of having them more explicit.
> 
> > The performance issues you observed are (probably) due to get/put
> > of cred refcount in the helpers {override,revert}_creds().
> >
> 
> Yes, they are. Sorry that it was lost in the context. The original
> report is here:
> 
> https://lore.kernel.org/all/20231018074553.41333-1-hu1.chen@intel.com/
> 
> > Christian suggested lightweight variants of {override,revert}_creds()
> > that do not change refcount. Combining those with a guard and
> > I don't see what can go wrong (TM).
> >
> > If you try this out and post a patch, please be sure to include the
> > motivation for the patch along with performance numbers in the
> > commit message, even if only posting an RFC patch.
> >
> 
> Of course.
> 
> And to be sure, I will go with Christian's suggestion, it looks neat,
> and having a lighter version of references is a more common idiom.

Did this ever go anywhere?

