Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34B9D3EA18F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Aug 2021 11:08:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235426AbhHLJIl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Aug 2021 05:08:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:34220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235131AbhHLJIf (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Aug 2021 05:08:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4CBB060FC4;
        Thu, 12 Aug 2021 09:08:08 +0000 (UTC)
Date:   Thu, 12 Aug 2021 11:08:05 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Cc:     Alejandro Colomar <alx.manpages@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: Questions re the new mount_setattr(2) manual page
Message-ID: <20210812090805.qkwjxnjitgaihlep@wittgenstein>
References: <b58e2537-03f4-6f6c-4e1b-8ddd989624cc@gmail.com>
 <20210810143255.2tjdskubryir2prp@wittgenstein>
 <95c7683e-957a-5a78-6b81-2cb8e756315c@gmail.com>
 <20210811100711.i3wwoc3bhrf7bvle@wittgenstein>
 <ea2e81b7-10e1-88f3-bfcb-e36afc5567d6@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ea2e81b7-10e1-88f3-bfcb-e36afc5567d6@gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 12, 2021 at 07:36:24AM +0200, Michael Kerrisk (man-pages) wrote:
> Hello Christian,
> 
> Thanks for the answers.
> 
> A couple of small queries still below.
> 
> On 8/11/21 12:07 PM, Christian Brauner wrote:
> > On Tue, Aug 10, 2021 at 11:06:52PM +0200, Michael Kerrisk (man-pages) wrote:
> 
> [...]
> 
> >>>>>       EINVAL The mount that is to be ID mapped is not a
> >>>>>              detached/anonymous mount; that is, the mount is
> >>>>
> >>>> ???
> >>>> What is a the distinction between "detached" and "anonymous"?
> >>>> Or do you mean them to be synonymous? If so, then let's use
> >>>> just one term, and I think "detached" is preferable.
> >>>
> >>> Yes, they are synonymous here. I list both because detached can
> >>> potentially be confusing. A detached mount is a mount that has not been
> >>> visible in the filesystem. But if you attached it an then unmount it
> >>> right after and keep the fd for the mountpoint open it's a detached
> >>> mount purely on a natural language level, I'd argue. But it's not a
> >>> detached mount from the kernel's view anymore because it has been
> >>> exposed in the filesystem and is thus not detached anymore.
> >>> But I do prefer "detached" to "anonymous" and that confusion is very
> >>> unlikely to occur.
> >>
> >> Thanks. I made it "detached". Elsewhere, the page already explains
> >> that a detached mount is one that:
> >>
> >>           must have been created by calling open_tree(2) with the
> >>           OPEN_TREE_CLONE flag and it must not already have been
> >>           visible in the filesystem.
> >>
> >> Which seems a fine explanation. 
> >>
> >> ????
> >> But, just a thought... "visible in the filesystem" seems not quite accurate. 
> >> What you really mean I guess is that it must not already have been
> >> /visible in the filesystem hierarchy/previously mounted/something else/,
> >> right?
> 
> I suppose that I should have clarified that my main problem was
> that you were using the word "filesystem" in a way that I find
> unconventional/ambiguous. I mean, I normally take the term
> "filesystem" to be "a storage system for folding files".
> Here, you are using "filesystem" to mean something else, what 
> I might call like "the single directory hierarchy" or "the
> filesystem hierarchy" or "the list of mount points".
> 
> > A detached mount is created via the OPEN_TREE_CLONE flag. It is a
> > separate new mount so "previously mounted" is not applicable.
> > A detached mount is _related_ to what the MS_BIND flag gives you with
> > mount(2). However, they differ conceptually and technically. A MS_BIND
> > mount(2) is always visible in the fileystem when mount(2) returns, i.e.
> > it is discoverable by regular path-lookup starting within the
> > filesystem.
> > 
> > However, a detached mount can be seen as a split of MS_BIND into two
> > distinct steps:
> > 1. fd_tree = open_tree(OPEN_TREE_CLONE): create a new mount
> > 2. move_mount(fd_tree, <somewhere>):     attach the mount to the filesystem
> > 
> > 1. and 2. together give you the equivalent of MS_BIND.
> > In between 1. and 2. however the mount is detached. For the kernel
> > "detached" means that an anonymous mount namespace is attached to it
> > which doen't appear in proc and has a 0 sequence number (Technically,
> > there's a bit of semantical argument to be made that "attached" and
> > "detached" are ambiguous as they could also be taken to mean "does or
> > does not have a parent mount". This ambiguity e.g. appears in
> > do_move_mount(). That's why the kernel itself calls it an "anonymous
> > mount". However, an OPEN_TREE_CLONE-detached mount of course doesn't
> > have a parent mount so it works.).
> > 
> > For userspace it's better to think of detached and attached in terms of
> > visibility in the filesystem or in a mount namespace. That's more
> > straightfoward, more relevant, and hits the target in 90% of the cases.
> > 
> > However, the better and clearer picture is to say that a
> > OPEN_TREE_CLONE-detached mount is a mount that has never been
> > move_mount()ed. Which in turn can be defined as the detached mount has
> > never been made visible in a mount namespace. Once that has happened the
> > mount is irreversibly an attached mount.
> > 
> > I keep thinking that maybe we should just say "anonymous mount"
> > everywhere. So changing the wording to:
> 
> I'm not against the word "detached". To user space, I think it is a
> little more meaningful than "anonymous". For the moment, I'll stay with
> "detached", but if you insist on "anonymous", I'll probably change it.

No, sounds good.

> 
> > [...]
> > EINVAL The mount that is to be ID mapped is not an anonymous mount;
> > that is, the mount has already been visible in a mount namespace.
> 
> I like that text *a lot* better! Thanks very much for suggesting
> wordings. It makes my life much easier. 
> 
> I've made the text:
> 
>        EINVAL The mount that is to be ID mapped is not a detached
>               mount; that is, the mount has not previously been
>               visible in a mount namespace.

Sounds good.

> 
> > [...]
> > The mount must be an anonymous mount; that is, it must have been
> > created by calling open_tree(2) with the OPEN_TREE_CLONE flag and it
> > must not already have been visible in a mount namespace, i.e. it must
> > not have been attached to the filesystem hierarchy with syscalls such
> > as move_mount() syscall.
> 
> And that too! I've made the text:
> 
>        •  The mount must be a detached mount; that is, it must have
>           been created by calling open_tree(2) with the
>           OPEN_TREE_CLONE flag and it must not already have been
>           visible in a mount namespace.  (To put things another way:
>           the mount must not have been attached to the filesystem
>           hierarchy with a system call such as move_mount(2).)

Sounds good.

> 
> > [...]
> > 
> > (I'm using the formulation "with syscalls such as move_mount()" to
> > future proof this. :)).
> 
> Fair enough.
> 
> >>>>>   EXAMPLES
> >>>>
> >>>> ???
> >>>> Do you have a (preferably simple) example piece of code
> >>>> somewhere for setting up an ID mapped mount?
> >>
> >> ????
> >> I guess the best example is this:
> >> https://github.com/brauner/mount-idmapped/
> >> right?
> > 
> > Ah yes, sorry. I forgot to answer that yesterday. I sent you links via
> > another medium but I repeat it here.
> > There are two places. The link you have here is a private repo. But I've
> > also merged a program alongside the fstests testsuite I merged:
> > https://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git/tree/src/idmapped-mounts/mount-idmapped.c
> > which should be nicer and has seen reviews by Amir and Christoph.
> 
> Thanks.
> 
> [...]
> 
> >>>>>           int fd_tree = open_tree(-EBADF, source,
> >>>>>                        OPEN_TREE_CLONE | OPEN_TREE_CLOEXEC |
> >>>>>                        AT_EMPTY_PATH | (recursive ? AT_RECURSIVE : 0));
> >>>>
> >>>> ???
> >>>> What is the significance of -EBADF here? As far as I can tell, it
> >>>> is not meaningful to open_tree()?
> >>>
> >>> I always pass -EBADF for similar reasons to [2]. Feel free to just use -1.
> >>
> >> ????
> >> But here, both -EBADF and -1 seem to be wrong. This argument 
> >> is a dirfd, and so should either be a file descriptor or the
> >> value AT_FDCWD, right?
> > 
> > [1]: In this code "source" is expected to be absolute. If it's not
> >      absolute we should fail. This can be achieved by passing -1/-EBADF,
> >      afaict.
> 
> D'oh! Okay. I hadn't considered that use case for an invalid dirfd.
> (And now I've done some adjustments to openat(2),which contains a
> rationale for the *at() functions.)
> 
> So, now I understand your purpose, but still the code is obscure,
> since
> 
> * You use a magic value (-EBADF) rather than (say) -1.
> * There's no explanation (comment about) of the fact that you want
>   to prevent relative pathnames.
> 
> So, I've changed the code to use -1, not -EBADF, and I've added some
> comments to explain that the intent is to prevent relative pathnames.
> Okay?

Sounds good.

> 
> But, there is still the meta question: what's the problem with using
> a relative pathname?

Nothing per se. Ok, you asked so it's your fault:
When writing programs I like to never use relative paths with AT_FDCWD
because. Because making assumptions about the current working directory
of the calling process is just too easy to get wrong; especially when
pivot_root() or chroot() are in play.
My absolut preference (joke intended) is to open a well-known starting
point with an absolute path to get a dirfd and then scope all future
operations beneath that dirfd. This already works with old-style
openat() and _very_ cautious programming but openat2() and its
resolve-flag space have made this **chef's kiss**.
If I can't operate based on a well-known dirfd I use absolute paths with
a -EBADF dirfd passed to *at() functions.

Christian
