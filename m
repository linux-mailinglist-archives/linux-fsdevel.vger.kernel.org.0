Return-Path: <linux-fsdevel+bounces-22911-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C4ED91EDFE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jul 2024 06:58:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E41DE281B4B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jul 2024 04:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4777543AC1;
	Tue,  2 Jul 2024 04:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cip4jZJJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ADD081F;
	Tue,  2 Jul 2024 04:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719896292; cv=none; b=fHaioBv5amDzXEfeLEM5oMuONHxo/I46Z5xSJvpa6umqHkr6j6GyxHggm2AfdlfL4LALA3L7fW0tNywfGbK6mVniwuQCIveZJxj6gHR0pEqjU5RgyZPsDiPO7dyQSwRb73FpRewBnvwtP3ShaAYA/0yf40MJBravAElOXCU+o2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719896292; c=relaxed/simple;
	bh=uO6STUc14T56dIESpMhyWi2neZ9u9dDvyMOL6sjEZds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EWgNfKKlTThVk6SGRNiIlL/u3SGt0bxGRmTO1IZM2CiUS5dDq+wDEWYncBqANhZh1UMuVBia3MlrCgYO4qH2GWY07Sea10jZ3aGYecfazgUqfVLMM7XX3Dh30myYkqRbJXj2yxCcDBW4Q8zklczJUuPLVhUMLUDqb9qEiIW96TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cip4jZJJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5BD0C116B1;
	Tue,  2 Jul 2024 04:58:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719896292;
	bh=uO6STUc14T56dIESpMhyWi2neZ9u9dDvyMOL6sjEZds=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cip4jZJJ9p02SzpcGhe7EPhkxUeJGL6pnLoJRRlXPO2cQm+vqB0Iqvq21bMrpwgRD
	 Ucbkn45OK7CTkhkfmwTqg+ZT48oEOrUcKLE6012ffh7J2l1SY7SFQxa6lv/4EnrQlg
	 9RF5SqwkXfdSnjxHyfkZH3uI1FkHC1rWBJ3HtLYshtGhFRIPix627DlxTpnzqhTLXL
	 iaB+FZR9zev/E2+4O6CoT0Wu87W4LwKXyQdqZQlwwox2pHxf9BN/G+ZI3S70BYJSnk
	 uo48R0Z4IJpNWX2cIN1lhV0ogAc8r038vVX4OPbzyYC521Gbeq2D19p33+oJ5dwqow
	 rxZTMTAjv0u2Q==
Date: Tue, 2 Jul 2024 06:58:06 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Ian Kent <ikent@redhat.com>, Matthew Wilcox <willy@infradead.org>, 
	Lucas Karpinski <lkarpins@redhat.com>, viro@zeniv.linux.org.uk, raven@themaw.net, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Alexander Larsson <alexl@redhat.com>, Eric Chanudet <echanude@redhat.com>
Subject: Re: [RFC v3 1/1] fs/namespace: remove RCU sync for MNT_DETACH umount
Message-ID: <20240702-sauna-tattoo-31b01a5f98f6@brauner>
References: <20240626201129.272750-2-lkarpins@redhat.com>
 <20240626201129.272750-3-lkarpins@redhat.com>
 <Znx-WGU5Wx6RaJyD@casper.infradead.org>
 <50512ec3-da6d-4140-9659-58e0514a4970@redhat.com>
 <20240627115418.lcnpctgailhlaffc@quack3>
 <cfda4682-34b4-462c-acf6-976b0d79ba06@redhat.com>
 <20240628111345.3bbcgie4gar6icyj@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240628111345.3bbcgie4gar6icyj@quack3>

On Fri, Jun 28, 2024 at 01:13:45PM GMT, Jan Kara wrote:
> On Fri 28-06-24 10:58:54, Ian Kent wrote:
> > 
> > On 27/6/24 19:54, Jan Kara wrote:
> > > On Thu 27-06-24 09:11:14, Ian Kent wrote:
> > > > On 27/6/24 04:47, Matthew Wilcox wrote:
> > > > > On Wed, Jun 26, 2024 at 04:07:49PM -0400, Lucas Karpinski wrote:
> > > > > > +++ b/fs/namespace.c
> > > > > > @@ -78,6 +78,7 @@ static struct kmem_cache *mnt_cache __ro_after_init;
> > > > > >    static DECLARE_RWSEM(namespace_sem);
> > > > > >    static HLIST_HEAD(unmounted);	/* protected by namespace_sem */
> > > > > >    static LIST_HEAD(ex_mountpoints); /* protected by namespace_sem */
> > > > > > +static bool lazy_unlock = false; /* protected by namespace_sem */
> > > > > That's a pretty ugly way of doing it.  How about this?
> > > > Ha!
> > > > 
> > > > That was my original thought but I also didn't much like changing all the
> > > > callers.
> > > > 
> > > > I don't really like the proliferation of these small helper functions either
> > > > but if everyone
> > > > 
> > > > is happy to do this I think it's a great idea.
> > > So I know you've suggested removing synchronize_rcu_expedited() call in
> > > your comment to v2. But I wonder why is it safe? I *thought*
> > > synchronize_rcu_expedited() is there to synchronize the dropping of the
> > > last mnt reference (and maybe something else) - see the comment at the
> > > beginning of mntput_no_expire() - and this change would break that?
> > 
> > Interesting, because of the definition of lazy umount I didn't look closely
> > enough at that.
> > 
> > But I wonder, how exactly would that race occur, is holding the rcu read
> > lock sufficient since the rcu'd mount free won't be done until it's
> > released (at least I think that's how rcu works).
> 
> I'm concerned about a race like:
> 
> [path lookup]				[umount -l]
> ...
> path_put()
>   mntput(mnt)
>     mntput_no_expire(m)
>       rcu_read_lock();
>       if (likely(READ_ONCE(mnt->mnt_ns))) {
> 					do_umount()
> 					  umount_tree()
> 					    ...
> 					    mnt->mnt_ns = NULL;
> 					    ...
> 					  namespace_unlock()
> 					    mntput(&m->mnt)
> 					      mntput_no_expire(mnt)
> 				              smp_mb();
> 					      mnt_add_count(mnt, -1);
> 					      count = mnt_get_count(mnt);
> 					      if (count != 0) {
> 						...
> 						return;
>         mnt_add_count(mnt, -1);
>         rcu_read_unlock();
>         return;
> -> KABOOM, mnt->mnt_count dropped to 0 but nobody cleaned up the mount!
>       }

Yeah, I think that's a valid concern. mntput_no_expire() requires that
the last reference is dropped after an rcu grace period and that can
only be done by synchronize_rcu_*() (It could be reworked but that would
be quite ugly.). See also mnt_make_shortterm() caller's for kernel
initiated unmounts.

