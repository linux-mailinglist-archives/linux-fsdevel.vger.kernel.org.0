Return-Path: <linux-fsdevel+bounces-35395-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D5909D491C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2024 09:44:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D43C282DE4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2024 08:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C5E91CC884;
	Thu, 21 Nov 2024 08:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZZd9bmXE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C40C21CB323;
	Thu, 21 Nov 2024 08:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732178641; cv=none; b=N31ONkJ20D0ZxiA/l3JmJXZBXxUcSz+l6Vep17XbOPlVf2QHJfW6J1xsslnAZpH6gO+huQ/IsOa7GPLizEi5UkunKaf8kAwDi+ZvrifxPV4MhF3Jm31A7Uf0VwUwpl2NwKMVLDpm1av6E4yLJ142xGHhjUxrTzoPqJ4J8PDqUv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732178641; c=relaxed/simple;
	bh=93d+OqbVd9Ea0NG2jzTeioEuzX6Aq7NOIU6RQqe9nlY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l0Dx6DGzrYPDM4oCJHDskmJPQJX5zm/5Ua+XcyCBHNRp49GxrWH5zix8/p6QsjZ+/MoXxrvl21X7GymSj+XbETj/NzcLpNubWYzh707q7jdJyj6NK2E80OTzUTv6MwhjLNvZbYuAFf0KvInMHGlE50YFAVjYbZaFZdOSCBjUTPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZZd9bmXE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 193F1C4CECE;
	Thu, 21 Nov 2024 08:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732178641;
	bh=93d+OqbVd9Ea0NG2jzTeioEuzX6Aq7NOIU6RQqe9nlY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZZd9bmXEsHfChSC2aGGlnkiIzf9lWdGjwnqCPXDdGdAN+Z+csyftlF80cpphfn0zi
	 ozvQS+XQXfe/gtGwm3cOUHr/4L2vKNNqChErygaOJ1t/mrVSnBczW5+X1HQCSlRPBU
	 aX1XCMRqDLLuko25njgEYFoLzGb2wuLbhmN4zDNzXuKDUOo0kWcpm0EqBakv/v8/k7
	 CYiqRae1FtkzC705/sCiOGSip1nXQkq6mQMR0ETfHk1NzHJLkLPARKS1NGWh8WUcTs
	 84gt0t3tzzVmieSC7eLIhsQ1FU/msJ5G48ejiJzUhnQUzm/bg1OUG2+95xXkCpZxBd
	 2z+CjzORZ7IgA==
Date: Thu, 21 Nov 2024 09:43:52 +0100
From: Christian Brauner <brauner@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Song Liu <songliubraving@meta.com>, Jeff Layton <jlayton@kernel.org>, 
	Jan Kara <jack@suse.cz>, Song Liu <song@kernel.org>, 
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>, Kernel Team <kernel-team@meta.com>, 
	"andrii@kernel.org" <andrii@kernel.org>, "eddyz87@gmail.com" <eddyz87@gmail.com>, 
	"ast@kernel.org" <ast@kernel.org>, "daniel@iogearbox.net" <daniel@iogearbox.net>, 
	"martin.lau@linux.dev" <martin.lau@linux.dev>, "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>, 
	"kpsingh@kernel.org" <kpsingh@kernel.org>, "mattbobrowski@google.com" <mattbobrowski@google.com>, 
	"repnop@google.com" <repnop@google.com>, Josef Bacik <josef@toxicpanda.com>, 
	"mic@digikod.net" <mic@digikod.net>, "gnoack@google.com" <gnoack@google.com>
Subject: Re: [PATCH bpf-next 2/4] bpf: Make bpf inode storage available to
 tracing program
Message-ID: <20241121-erleuchten-getobt-aba2e8f03611@brauner>
References: <20241113-sensation-morgen-852f49484fd8@brauner>
 <86C65B85-8167-4D04-BFF5-40FD4F3407A4@fb.com>
 <20241115111914.qhrwe4mek6quthko@quack3>
 <E79EFA17-A911-40E8-8A51-CB5438FD2020@fb.com>
 <8ae11e3e0d9339e6c60556fcd2734a37da3b4a11.camel@kernel.org>
 <CAOQ4uxgUYHEZTx7udTXm8fDTfhyFM-9LOubnnAc430xQSLvSVA@mail.gmail.com>
 <CAOQ4uxhyDAHjyxUeLfWeff76+Qpe5KKrygj2KALqRPVKRHjSOA@mail.gmail.com>
 <DF0C7613-56CC-4A85-B775-0E49688A6363@fb.com>
 <20241120-wimpel-virologen-1a58b127eec6@brauner>
 <CAOQ4uxhSM0PL8g3w6E2fZUUGds-13Swj-cfBvPz9b9+8XhHD3w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxhSM0PL8g3w6E2fZUUGds-13Swj-cfBvPz9b9+8XhHD3w@mail.gmail.com>

On Wed, Nov 20, 2024 at 12:19:51PM +0100, Amir Goldstein wrote:
> On Wed, Nov 20, 2024 at 10:28 AM Christian Brauner <brauner@kernel.org> wrote:
> >
> > On Tue, Nov 19, 2024 at 09:53:20PM +0000, Song Liu wrote:
> > > Hi Jeff and Amir,
> > >
> > > Thanks for your inputs!
> > >
> > > > On Nov 19, 2024, at 7:30 AM, Amir Goldstein <amir73il@gmail.com> wrote:
> > > >
> > > > On Tue, Nov 19, 2024 at 4:25 PM Amir Goldstein <amir73il@gmail.com> wrote:
> > > >>
> > > >> On Tue, Nov 19, 2024 at 3:21 PM Jeff Layton <jlayton@kernel.org> wrote:
> > > >>>
> > >
> > > [...]
> > >
> > > >>> Longer term, I think it may be beneficial to come up with a way to attach
> > > >>>>> private info to the inode in a way that doesn't cost us one pointer per
> > > >>>>> funcionality that may possibly attach info to the inode. We already have
> > > >>>>> i_crypt_info, i_verity_info, i_flctx, i_security, etc. It's always a tough
> > > >>>>> call where the space overhead for everybody is worth the runtime &
> > > >>>>> complexity overhead for users using the functionality...
> > > >>>>
> > > >>>> It does seem to be the right long term solution, and I am willing to
> > > >>>> work on it. However, I would really appreciate some positive feedback
> > > >>>> on the idea, so that I have better confidence my weeks of work has a
> > > >>>> better chance to worth it.
> > > >>>>
> > > >>>> Thanks,
> > > >>>> Song
> > > >>>>
> > > >>>> [1] https://github.com/systemd/systemd/blob/main/src/core/bpf/restrict_fs/restrict-fs.bpf.c
> > > >>>
> > > >>> fsnotify is somewhat similar to file locking in that few inodes on the
> > > >>> machine actually utilize these fields.
> > > >>>
> > > >>> For file locking, we allocate and populate the inode->i_flctx field on
> > > >>> an as-needed basis. The kernel then hangs on to that struct until the
> > > >>> inode is freed.
> > >
> > > If we have some universal on-demand per-inode memory allocator,
> > > I guess we can move i_flctx to it?
> > >
> > > >>> We could do something similar here. We have this now:
> > > >>>
> > > >>> #ifdef CONFIG_FSNOTIFY
> > > >>>        __u32                   i_fsnotify_mask; /* all events this inode cares about */
> > > >>>        /* 32-bit hole reserved for expanding i_fsnotify_mask */
> > > >>>        struct fsnotify_mark_connector __rcu    *i_fsnotify_marks;
> > > >>> #endif
> > >
> > > And maybe some fsnotify fields too?
> > >
> > > With a couple users, I think it justifies to have some universal
> > > on-demond allocator.
> > >
> > > >>> What if you were to turn these fields into a pointer to a new struct:
> > > >>>
> > > >>>        struct fsnotify_inode_context {
> > > >>>                struct fsnotify_mark_connector __rcu    *i_fsnotify_marks;
> > > >>>                struct bpf_local_storage __rcu          *i_bpf_storage;
> > > >>>                __u32                                   i_fsnotify_mask; /* all events this inode cares about */
> > > >>>        };
> > > >>>
> > > >>
> > > >> The extra indirection is going to hurt for i_fsnotify_mask
> > > >> it is being accessed frequently in fsnotify hooks, so I wouldn't move it
> > > >> into a container, but it could be moved to the hole after i_state.
> > >
> > > >>> Then whenever you have to populate any of these fields, you just
> > > >>> allocate one of these structs and set the inode up to point to it.
> > > >>> They're tiny too, so don't bother freeing it until the inode is
> > > >>> deallocated.
> > > >>>
> > > >>> It'd mean rejiggering a fair bit of fsnotify code, but it would give
> > > >>> the fsnotify code an easier way to expand per-inode info in the future.
> > > >>> It would also slightly shrink struct inode too.
> > >
> > > I am hoping to make i_bpf_storage available to tracing programs.
> > > Therefore, I would rather not limit it to fsnotify context. We can
> > > still use the universal on-demand allocator.
> >
> > Can't we just do something like:
> >
> > diff --git a/include/linux/fs.h b/include/linux/fs.h
> > index 7e29433c5ecc..cc05a5485365 100644
> > --- a/include/linux/fs.h
> > +++ b/include/linux/fs.h
> > @@ -627,6 +627,12 @@ is_uncached_acl(struct posix_acl *acl)
> >  #define IOP_DEFAULT_READLINK   0x0010
> >  #define IOP_MGTIME     0x0020
> >
> > +struct inode_addons {
> > +        struct fsnotify_mark_connector __rcu    *i_fsnotify_marks;
> > +        struct bpf_local_storage __rcu          *i_bpf_storage;
> > +        __u32                                   i_fsnotify_mask; /* all events this inode cares about */
> > +};
> > +
> >  /*
> >   * Keep mostly read-only and often accessed (especially for
> >   * the RCU path lookup and 'stat' data) fields at the beginning
> > @@ -731,12 +737,7 @@ struct inode {
> >                 unsigned                i_dir_seq;
> >         };
> >
> > -
> > -#ifdef CONFIG_FSNOTIFY
> > -       __u32                   i_fsnotify_mask; /* all events this inode cares about */
> > -       /* 32-bit hole reserved for expanding i_fsnotify_mask */
> > -       struct fsnotify_mark_connector __rcu    *i_fsnotify_marks;
> > -#endif
> > +       struct inode_addons *i_addons;
> >
> >  #ifdef CONFIG_FS_ENCRYPTION
> >         struct fscrypt_inode_info       *i_crypt_info;
> >
> > Then when either fsnotify or bpf needs that storage they can do a
> > cmpxchg() based allocation for struct inode_addons just like I did with
> > f_owner:
> >
> > int file_f_owner_allocate(struct file *file)
> > {
> >         struct fown_struct *f_owner;
> >
> >         f_owner = file_f_owner(file);
> >         if (f_owner)
> >                 return 0;
> >
> >         f_owner = kzalloc(sizeof(struct fown_struct), GFP_KERNEL);
> >         if (!f_owner)
> >                 return -ENOMEM;
> >
> >         rwlock_init(&f_owner->lock);
> >         f_owner->file = file;
> >         /* If someone else raced us, drop our allocation. */
> >         if (unlikely(cmpxchg(&file->f_owner, NULL, f_owner)))
> >                 kfree(f_owner);
> >         return 0;
> > }
> >
> > The internal allocations for specific fields are up to the subsystem
> > ofc. Does that make sense?
> >
> 
> Maybe, but as I wrote, i_fsnotify_mask should not be moved out
> of inode struct, because it is accessed in fast paths of fsnotify vfs
> hooks, where we do not want to have to deref another context,
> but i_fsnotify_mask can be moved to the hole after i_state.
> 
> And why stop at i_fsnotify/i_bfp?
> If you go to "addons" why not also move i_security/i_crypt/i_verify?
> Need to have some common rationale behind those decisions.

The rationale is that we need a mechanism to stop bloating our
structures with ever more stuff somehow. What happens to older members
of struct inode is a cleanup matter and then it needs to be seen what
can be moved into a substruct and not mind the additional pointer chase.

It's just a generalization of your proposal in a way because I don't
understand why you would move the bpf stuff into fsnotify specific
parts.

