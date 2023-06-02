Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51997720221
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Jun 2023 14:35:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235254AbjFBMfA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Jun 2023 08:35:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235200AbjFBMe7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Jun 2023 08:34:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7105D1AE;
        Fri,  2 Jun 2023 05:34:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0BAF860E97;
        Fri,  2 Jun 2023 12:34:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84448C433D2;
        Fri,  2 Jun 2023 12:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685709295;
        bh=TpTi9BQSdSI8XASCAJYAYnldBBJTG5a0+zUcrCHLmDo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ryWMrlC55RZ0gbGe6k+u8jXH4cA1h14CLH5aPnKArXj+YbS2TKfba8ctKuZbuMYW9
         J2z9ElfQ9AMFAwaKg1qMI8Ar+ks9ujk8v5lJbeDQhltdnmn17nzY+I6JpQBDEZLUhF
         fSAglIdOhdyTzsTQ9qXb7QSeYXdkVQTLm4SLCbSHi2CcOxAcF6yxT/2Zl3cw/RgTFL
         Qr6hqrv00VeI0L583Yat3DPFvDGZhomOlsPCRWm/MIVyI/xgqOzHMegDdzUYepVAw6
         cldniFP30G7F/dnBqueAtFuWbgIr1dbBdHRd+2Uqc1y8+u69ysdP0YQzBwZ9xXVfJ0
         6I0vDcWuDXrSQ==
Date:   Fri, 2 Jun 2023 14:34:48 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     'Jan Kara' <jack@suse.cz>, Al Viro <viro@ZenIV.linux.org.uk>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        "Darrick J. Wong" <djwong@kernel.org>, Ted Tso <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v2 4/6] fs: Establish locking order for unrelated
 directories
Message-ID: <20230602-drehung-frappierend-fd5aabba4a52@brauner>
References: <20230601104525.27897-1-jack@suse.cz>
 <20230601105830.13168-4-jack@suse.cz>
 <20230601-gebracht-gesehen-c779a56b3bf3@brauner>
 <20230601152449.h4ur5zrfqjqygujd@quack3>
 <c5f209a6263b4f039c5eafcafddf90ca@AcuMS.aculab.com>
 <20230601161353.4o6but7hb7i7qfki@quack3>
 <eb70760399ae4222904c62c64dc529b6@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <eb70760399ae4222904c62c64dc529b6@AcuMS.aculab.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 01, 2023 at 04:33:58PM +0000, David Laight wrote:
> From: Jan Kara <jack@suse.cz>
> > Sent: 01 June 2023 17:14
> > 
> > On Thu 01-06-23 15:37:32, David Laight wrote:
> > > ...
> > > > > > + * Lock any non-NULL argument. The caller must make sure that if he is passing
> > > > > > + * in two directories, one is not ancestor of the other
> > >
> > > Not directly relevant to this change but is the 'not an ancestor'
> > > check actually robust?
> > >
> > > I found a condition in which the kernel 'pwd' code (which follows
> > > the inode chain) failed to stop at the base of a chroot.
> > >
> > > I suspect that the ancestor check would fail the same way.
> > 
> > Honestly, I'm not sure how this could be the case but I'm not a dcache
> > expert. d_ancestor() works on dentries and the whole dcache code pretty
> > much relies on the fact that there always is at most one dentry for any
> > directory. Also in case we call d_ancestor() from this code, we have the
> > whole filesystem locked from any other directory moves so the ancestor
> > relationship of two dirs cannot change (which is different from pwd code
> > AFAIK). So IMHO no failure is possible in our case.
> 
> I've found the test program.
> This uses readlinkat() to get the full path /proc/self/fd/0.
> It should be inside the chroot, but the comparison done
> to detect the 'root' fails.

That's intentional and relied-upon behavior. In glibc alone for tty
validation it wants the full link path returned. So any change in this
is an immediate widespread userspace regression.

> 
> Now maybe any rename that would hit this is invalid
> for other reasons.
> But something is awry somewhere.

It really isn't.

> 
> 	David
> 
> The program below reproduces this when run with stdin
> redirected to a file in the current directory.
> 
> This sequence is used by 'ip netns exec' so isn't actually

Fwiw, it doesn't use chroot() at all. 

> that unusual.
> 
> 	David
> 
> #define _GNU_SOURCE
> #include <unistd.h>
> #include <stdio.h>
> #include <fcntl.h>
> #include <sched.h>
> 
> static void print_link(const char *where, int fd)
> {
>         char buf[256];
> 
>         printf("%s: %.*s\n", where, (int)readlinkat(fd, "", buf, sizeof buf), buf);
> }
> 
> int main(int argc, char **argv)
> {
>         int link_fd = open("/proc/self/fd/0", O_PATH | O_NOFOLLOW);
> 
>         print_link("initial", link_fd);
>         if (chroot("."))

chroot(2):

"This call changes an ingredient in the pathname resolution process and
does nothing else. In particular, it is not intended [...] to restrict
filesystem system calls.

[...]

This call does not close open file descriptors, and such file
descriptors may allow access to files outside the chroot tree."

>                 return 1;
>         print_link("after chroot", link_fd);
>         if (unshare(CLONE_NEWNS))
>                 return 2;
>         print_link("after unshare", link_fd);
>         return 0;
> }

But anyway, the code sample you provided is using O_PATH | O_NOFOLLOW to
open magic link, i.e., /proc/<pid>/fd/<nr>. That means whatever the
magic link refers to isn't really reopened. You can create these magic
link references trivially for every path:

        int fd = open("/tmp", 0);

        // create fd referencing magic link
        sprintf(buf, "/proc/self/fd/%d", fd);
        int link_fd = open(buf, O_PATH | O_NOFOLLOW);

In fact, you don't even need magic links for that. You can get the same
behavior with any symlink:

        ln -sf /usr /BLUB
        linkt_fd = open("/BLUB", O_PATH | O_NOFOLLOW);

If you pass such a fd to readlinkat() then d_path() will give you the
full path whether it's accessible in your namespace/chroot/pivot_root()
or not.

Look at __prepend_path() current->fs->root is only used to terminate the
walk for fds that are scopable _beneath_ your chroot:

        mkdir -p /A/B/C
        touch /A/B/C/D

        chroot("/A/B/C");
        int fd = open("/A/B/C/D", 0);
        sprintf(buf, "/proc/self/fd/%d", fd);
        int link_fd = open(buf, O_PATH | O_NOFOLLOW);

In this case, you'll see that after chroot("/A/B/C") it'll print:

        /D

And this actually makes a lot of sense. The fd for /A/B/C/D is scoped
beneath your chroot(). But an fd pointing outside of your chroot is not
scoped by the chroot because you can also very well do:

        fchdir(fd-outside-chroot)

And btw, orderings such as:

        chroot()
        unshare(CLONE_NEWNS)

aren't intuitive. It seems that you're under the impression that the
unshare(CLONE_NEWNS) doesn't have any effect on the chroot() but it
does. Going back to the previous example:

        mkdir -p /A/B/C
        touch /A/B/C/D

        chroot("/A/B/C");
        int fd = open("/A/B/C/D", 0);
        sprintf(buf, "/proc/self/fd/%d", fd);
        int link_fd = open(buf, O_PATH | O_NOFOLLOW);

Compare what gets printed after the chroot() and after
unshare(CLONE_NEWNS). You'll see /D after the chroot() but again the
full path /A/B/C/D after the unshare(). Why?

The reason is that if the mount that you're currently chroot()ed into is
copied as part of the unshare(CLONE_NEWNS) then current->fs->root will
be updated to refer to the copy.

But since this is a copy it means that __prepend_path() doesn't
terminate the walk at /D. That's seemingly counterintuitive but makes
sense if you consider that you were moved into a new mount namespace.
The mount the fd refers to is now inaccessible from your mount namespace
and so the full path is returned again.

Yes, that's not straightforward but heavily relied upon so even if we
could change it to be less surprising it would break the hell out of
everyone.

And most of this doesn't have anything to do with ancestor relationships
per se since this code is able to detect concurrent tree modifications
through rename_lock seqlock iirc. That's a related but different
problem. The effects you're seeing are caused by mount semantics more
than anything else.

And btw about /proc/self/fd/0 specifically... Not verifying an fd
pointing to a pty device in any type of sandbox in the age of containers
is ripe for confusion. Quoting from work I did on glibc years ago:

"It's a common practice among container managers to allocate
 a PTY master/slave pair in the host's mount namespace (the slave having
 a path like "/dev/pty/$X"), bind mount the slave to "/dev/console" in
 the container's mount namespace, and send the slave FD to a process in
 the container. Inside of the container, the slave-end isn't available
 at its original path ("/dev/pts/$X"), since the container mount
 namespace has a separate devpts instance from the host (that path may
 or may not exist in the container; if it does exist, it's not the same
 PTY slave device)."
