Return-Path: <linux-fsdevel+bounces-35291-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7084E9D370C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2024 10:28:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE013B2211D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2024 09:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA96619ABD8;
	Wed, 20 Nov 2024 09:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BFBCIo9N"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47EE0200CB;
	Wed, 20 Nov 2024 09:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732094913; cv=none; b=Q61OZtXrfHIVU3YfSrqR8qRBNNVN3qNu/T/VMHXDwV38hlrqNk1AI5GacKDcB5jlLSv3k0MdoSl8ShyWO+nM636jmv4p0z1wm+f0PzImQOMqAPfD6wzmMOPVxrv2zrv9ZLqOEfDv8CNKFEYIB+X1GqkCRUBi5q+bPnjDA2V8hKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732094913; c=relaxed/simple;
	bh=VrcMGITK8dOAe5io5QsstOrr2rW+8zosAYtEPi0gZug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r2Kfpic46aYncMeGiH4ZsfwSxsmrnACivEKBY3P+MpyA2TOzbF5JWPXKJIM0ZtfL9jU0ZMsHaJ+IyW6GPL9vRpFZXW9KrvkQeuDwVbcYx7nbxW18UzVH2lBUqphq/KTmeqUewscd6V5bO8SDGKolzna7X3QcZbLs6SJ0EqqyD68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BFBCIo9N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D989FC4CECD;
	Wed, 20 Nov 2024 09:28:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732094912;
	bh=VrcMGITK8dOAe5io5QsstOrr2rW+8zosAYtEPi0gZug=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BFBCIo9NM7T3C8kL+eYe/R11UdP27waGeu/Tgc2t5UfEomqenlmAs7S32a/VgkfjW
	 EICNtgnOCB3TdBR0P88GanbPfaDjmZE73S4I7FxrGBxCom7jtrnNOL9egb2sKKQRPr
	 gnQCKtmbTrG5O9Ogl3oW10d710bmric/Jiu8UEODtLb4wQ5myLFKUoad35wsNYIScV
	 /l6rtf3p7oCt2FTpUujSTsn1LimMX39EUP6bHJnU9iea865rVkzd2PUFWmDtTpiteX
	 Ui5/GhoW/gcVjGIUiXfTQpmdnOK72pSVpdARXg1kCdbI1xASZEheg217InxFyWxrZY
	 AFDvPRQirbGsg==
Date: Wed, 20 Nov 2024 10:28:25 +0100
From: Christian Brauner <brauner@kernel.org>
To: Song Liu <songliubraving@meta.com>, 
	Amir Goldstein <amir73il@gmail.com>, Jeff Layton <jlayton@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Song Liu <song@kernel.org>, 
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
Message-ID: <20241120-wimpel-virologen-1a58b127eec6@brauner>
References: <20241112082600.298035-1-song@kernel.org>
 <20241112082600.298035-3-song@kernel.org>
 <20241113-sensation-morgen-852f49484fd8@brauner>
 <86C65B85-8167-4D04-BFF5-40FD4F3407A4@fb.com>
 <20241115111914.qhrwe4mek6quthko@quack3>
 <E79EFA17-A911-40E8-8A51-CB5438FD2020@fb.com>
 <8ae11e3e0d9339e6c60556fcd2734a37da3b4a11.camel@kernel.org>
 <CAOQ4uxgUYHEZTx7udTXm8fDTfhyFM-9LOubnnAc430xQSLvSVA@mail.gmail.com>
 <CAOQ4uxhyDAHjyxUeLfWeff76+Qpe5KKrygj2KALqRPVKRHjSOA@mail.gmail.com>
 <DF0C7613-56CC-4A85-B775-0E49688A6363@fb.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DF0C7613-56CC-4A85-B775-0E49688A6363@fb.com>

On Tue, Nov 19, 2024 at 09:53:20PM +0000, Song Liu wrote:
> Hi Jeff and Amir, 
> 
> Thanks for your inputs!
> 
> > On Nov 19, 2024, at 7:30 AM, Amir Goldstein <amir73il@gmail.com> wrote:
> > 
> > On Tue, Nov 19, 2024 at 4:25 PM Amir Goldstein <amir73il@gmail.com> wrote:
> >> 
> >> On Tue, Nov 19, 2024 at 3:21 PM Jeff Layton <jlayton@kernel.org> wrote:
> >>> 
> 
> [...]
> 
> >>> Longer term, I think it may be beneficial to come up with a way to attach
> >>>>> private info to the inode in a way that doesn't cost us one pointer per
> >>>>> funcionality that may possibly attach info to the inode. We already have
> >>>>> i_crypt_info, i_verity_info, i_flctx, i_security, etc. It's always a tough
> >>>>> call where the space overhead for everybody is worth the runtime &
> >>>>> complexity overhead for users using the functionality...
> >>>> 
> >>>> It does seem to be the right long term solution, and I am willing to
> >>>> work on it. However, I would really appreciate some positive feedback
> >>>> on the idea, so that I have better confidence my weeks of work has a
> >>>> better chance to worth it.
> >>>> 
> >>>> Thanks,
> >>>> Song
> >>>> 
> >>>> [1] https://github.com/systemd/systemd/blob/main/src/core/bpf/restrict_fs/restrict-fs.bpf.c
> >>> 
> >>> fsnotify is somewhat similar to file locking in that few inodes on the
> >>> machine actually utilize these fields.
> >>> 
> >>> For file locking, we allocate and populate the inode->i_flctx field on
> >>> an as-needed basis. The kernel then hangs on to that struct until the
> >>> inode is freed.
> 
> If we have some universal on-demand per-inode memory allocator, 
> I guess we can move i_flctx to it?
> 
> >>> We could do something similar here. We have this now:
> >>> 
> >>> #ifdef CONFIG_FSNOTIFY
> >>>        __u32                   i_fsnotify_mask; /* all events this inode cares about */
> >>>        /* 32-bit hole reserved for expanding i_fsnotify_mask */
> >>>        struct fsnotify_mark_connector __rcu    *i_fsnotify_marks;
> >>> #endif
> 
> And maybe some fsnotify fields too?
> 
> With a couple users, I think it justifies to have some universal
> on-demond allocator. 
> 
> >>> What if you were to turn these fields into a pointer to a new struct:
> >>> 
> >>>        struct fsnotify_inode_context {
> >>>                struct fsnotify_mark_connector __rcu    *i_fsnotify_marks;
> >>>                struct bpf_local_storage __rcu          *i_bpf_storage;
> >>>                __u32                                   i_fsnotify_mask; /* all events this inode cares about */
> >>>        };
> >>> 
> >> 
> >> The extra indirection is going to hurt for i_fsnotify_mask
> >> it is being accessed frequently in fsnotify hooks, so I wouldn't move it
> >> into a container, but it could be moved to the hole after i_state.
> 
> >>> Then whenever you have to populate any of these fields, you just
> >>> allocate one of these structs and set the inode up to point to it.
> >>> They're tiny too, so don't bother freeing it until the inode is
> >>> deallocated.
> >>> 
> >>> It'd mean rejiggering a fair bit of fsnotify code, but it would give
> >>> the fsnotify code an easier way to expand per-inode info in the future.
> >>> It would also slightly shrink struct inode too.
> 
> I am hoping to make i_bpf_storage available to tracing programs. 
> Therefore, I would rather not limit it to fsnotify context. We can
> still use the universal on-demand allocator.

Can't we just do something like:

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 7e29433c5ecc..cc05a5485365 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -627,6 +627,12 @@ is_uncached_acl(struct posix_acl *acl)
 #define IOP_DEFAULT_READLINK   0x0010
 #define IOP_MGTIME     0x0020

+struct inode_addons {
+        struct fsnotify_mark_connector __rcu    *i_fsnotify_marks;
+        struct bpf_local_storage __rcu          *i_bpf_storage;
+        __u32                                   i_fsnotify_mask; /* all events this inode cares about */
+};
+
 /*
  * Keep mostly read-only and often accessed (especially for
  * the RCU path lookup and 'stat' data) fields at the beginning
@@ -731,12 +737,7 @@ struct inode {
                unsigned                i_dir_seq;
        };

-
-#ifdef CONFIG_FSNOTIFY
-       __u32                   i_fsnotify_mask; /* all events this inode cares about */
-       /* 32-bit hole reserved for expanding i_fsnotify_mask */
-       struct fsnotify_mark_connector __rcu    *i_fsnotify_marks;
-#endif
+       struct inode_addons *i_addons;

 #ifdef CONFIG_FS_ENCRYPTION
        struct fscrypt_inode_info       *i_crypt_info;

Then when either fsnotify or bpf needs that storage they can do a
cmpxchg() based allocation for struct inode_addons just like I did with
f_owner:

int file_f_owner_allocate(struct file *file)
{
	struct fown_struct *f_owner;

	f_owner = file_f_owner(file);
	if (f_owner)
		return 0;

	f_owner = kzalloc(sizeof(struct fown_struct), GFP_KERNEL);
	if (!f_owner)
		return -ENOMEM;

	rwlock_init(&f_owner->lock);
	f_owner->file = file;
	/* If someone else raced us, drop our allocation. */
	if (unlikely(cmpxchg(&file->f_owner, NULL, f_owner)))
		kfree(f_owner);
	return 0;
}

The internal allocations for specific fields are up to the subsystem
ofc. Does that make sense?

> >>>        struct fsnotify_inode_context {
> >>>                struct fsnotify_mark_connector __rcu    *i_fsnotify_marks;
> >>>                struct bpf_local_storage __rcu          *i_bpf_storage;
> >>>                __u32                                   i_fsnotify_mask; /* all events this inode cares about */
> >>>        };

> 
> >> 
> >> This was already done for s_fsnotify_marks, so you can follow the recipe
> >> of 07a3b8d0bf72 ("fsnotify: lazy attach fsnotify_sb_info state to sb")
> >> and create an fsnotify_inode_info container.
> >> 
> > 
> > On second thought, fsnotify_sb_info container is allocated and attached
> > in the context of userspace adding a mark.
> > 
> > If you will need allocate and attach fsnotify_inode_info in the content of
> > fast path fanotify hook in order to add the inode to the map, I don't
> > think that is going to fly??
> 
> Do you mean we may not be able to allocate memory in the fast path 
> hook? AFAICT, the fast path is still in the process context, so I 
> think this is not a problem?
> 
> Thanks,
> Song 
> 

