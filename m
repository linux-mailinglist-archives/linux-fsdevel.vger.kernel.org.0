Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A49186C36C5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Mar 2023 17:18:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbjCUQR6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Mar 2023 12:17:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbjCUQRv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Mar 2023 12:17:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BF654E5EB;
        Tue, 21 Mar 2023 09:17:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 94DD5B818B9;
        Tue, 21 Mar 2023 16:17:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD326C433D2;
        Tue, 21 Mar 2023 16:17:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679415461;
        bh=jUbbvcgOdoFVj5tMqmxBLecT89FFBORLuZu1c+v65I8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GuwKJerWp9f+6OyuuHNZbpRfjxV690q1d8+JRUhgTz6VhUrfJIq382zfOczZk/Qk4
         gqsc6dQd6ZW3P4fVsXe1Wmn9vzjwW0YXPBzqhGMwkYuwhM2kUpRubHuIPazYisraMe
         J2uVSPToT0J6gBLwZmAb236NZMI1izR2WQlmK0fhL2kTa3ZVolsglIj7z8QNRRJMu2
         V7/o0c9vZ0eDKtUT8rRO3b4DUIZMHX2npviVzTAdzbzgq78erEyZn3WsN6AGj79XdR
         5IsHV1lCs0kn9MiUK3rGBH0YjxA3qkN7jPnZ0ylhZpDbEuqF3Ly1h27Bl06CSgVkF+
         vOQZgxAXsObng==
Date:   Tue, 21 Mar 2023 17:17:36 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Pedro Falcato <pedro.falcato@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Aleksa Sarai <cyphar@cyphar.com>
Subject: Re: [PATCH] do_open(): Fix O_DIRECTORY | O_CREAT behavior
Message-ID: <20230321161736.njmtnkvjf5rf7x5p@wittgenstein>
References: <20230320071442.172228-1-pedro.falcato@gmail.com>
 <20230320115153.7n5cq4wl2hmcbndf@wittgenstein>
 <CAHk-=wjifBVf3ub0WWBXYg7JAao6V8coCdouseaButR0gi5xmg@mail.gmail.com>
 <CAKbZUD2Y2F=3+jf+0dRvenNKk=SsYPxKwLuPty_5-ppBPsoUeQ@mail.gmail.com>
 <CAHk-=wgc9qYOtuyW_Tik0AqMrQJK00n-LKWvcBifLyNFUdohDw@mail.gmail.com>
 <20230321142413.6mlowi5u6ewecodx@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230321142413.6mlowi5u6ewecodx@wittgenstein>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,WEIRD_QUOTING autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 21, 2023 at 03:24:19PM +0100, Christian Brauner wrote:
> On Mon, Mar 20, 2023 at 01:24:52PM -0700, Linus Torvalds wrote:
> > On Mon, Mar 20, 2023 at 12:27 PM Pedro Falcato <pedro.falcato@gmail.com> wrote:
> > >
> > > 1) Pre v5.7 Linux did the open-dir-if-exists-else-create-regular-file
> > > we all know and """love""".
> > 
> > So I think we should fall back to this as a last resort, as a "well,
> > it's our historical behavior".
> > 
> > > 2) Post 5.7, we started returning this buggy -ENOTDIR error, even when
> > > successfully creating a file.
> > 
> > Yeah, I think this is the worst of the bunch and has no excuse (unless
> > some crazy program has started depending on it, which sounds really
> > *really* unlikely).
> > 
> > > 3) NetBSD just straight up returns EINVAL on open(O_DIRECTORY | O_CREAT)
> > > 4) FreeBSD's open(O_CREAT | O_DIRECTORY) succeeds if the file exists
> > > and is a directory. Fails with -ENOENT if it falls onto the "O_CREAT"
> > > path (i.e it doesn't try to create the file at all, just ENOENT's;
> > > this changed relatively recently, in 2015)
> > 
> > Either of these sound sensible to me.
> > 
> > I suspect (3) is the clearest case.
> 
> Yeah, we should try that.
> 
> > 
> > And (4) might be warranted just because it's closer to what we used to
> > do, and it's *possible* that somebody happens to use O_DIRECTORY |
> > O_CREAT on directories that exist, and never noticed how broken that
> > was.
> 
> I really really hope that isn't the case because (4) is pretty nasty.
> Having to put this on a manpage seems nightmarish.
> 
> > 
> > And (4) has another special case: O_EXCL. Because I'm really hoping
> > that O_DIRECTORY | O_EXCL will always fail.
> 
> I've detailed the semantics for that in the commit message below...
> 
> > 
> > Is the proper patch something along the lines of this?
> 
> Yeah, I think that would do it and I think that's what we should try to
> get away with. I just spent time and took a look who passes O_DIRECTORY
> and O_CREAT and interestingly there are a number of comments roughly
> along the lines of the following example:
> 
> /* Ideally we could use openat(O_DIRECTORY | O_CREAT | O_EXCL) here
>  * to create and open the directory atomically
> 
> suggests that people who specify O_DIRECTORY | O_CREAT are interested in
> creating a directory. But since this never did work they don't tend to
> use that flag combination (I've collected a few samples in [1] to [4].).
> 
> (As a sidenote, posix made an interpretation change a long time ago to
> at least allow for O_DIRECTORY | O_CREAT to create a directory (see [3]).
> 
> But that's a whole different can of worms and I haven't spent any
> thoughts even on feasibility. And even if we should probably get through
> a couple of kernels with O_DIRECTORY | O_CREAT failing with EINVAL first.)
> 
> > 
> >    --- a/fs/open.c
> >    +++ b/fs/open.c
> >    @@ -1186,6 +1186,8 @@ inline int build_open_flags(const struct
> > open_how *how, struct open_flags *op)
> > 
> >         /* Deal with the mode. */
> >         if (WILL_CREATE(flags)) {
> >    +            if (flags & O_DIRECTORY)
> >    +                    return -EINVAL;
> 
> This will be problematic because for weird historical reasons O_TMPFILE
> includes O_DIRECTORY so this would unfortunately break O_TMPFILE. :/
> I'll try to have a patch ready in a bit.

So, had to do some testing first:

This survives xfstests:
        sudo ./check -g unlink,idmapped
which pounds on the creation and O_TMPFILE paths.

It also survives LTP:
        # The following includes openat2, openat, open, fsopen, open_tree, etc.
        sudo ./runtltp -f syscalls open

I've also written a (very nasty) test script:

        #define _GNU_SOURCE
        #include <fcntl.h>
        #include <stdio.h>
        #include <stdlib.h>

        int main(int argc, char *argv[])
        {
                int fd;

                fd = open("/tmp/TEST", O_DIRECTORY | O_CREAT);
                if (fd >= 0)
                        printf("%d\n", fd);
                else
                        printf("%m: fd(%d)\n", fd);

                fd = open("/tmp/TEST", O_DIRECTORY | O_CREAT | O_EXCL);
                if (fd >= 0)
                        printf("%d\n", fd);
                else
                        printf("%m: fd(%d)\n", fd);

                fd = open("/tmp/TEST", O_DIRECTORY | O_EXCL);
                if (fd >= 0)
                        printf("%d\n", fd);
                else
                        printf("%m: fd(%d)\n", fd);

                exit(EXIT_SUCCESS);
        }
        ubuntu@vm1:~/ssd$ sudo ./create_test
        Invalid argument: fd(-1)
        Invalid argument: fd(-1)
        No such file or directory: fd(-1)

I think this should work. From the commit message it's hopefully clear
that this is proper semantic change. But I think we might be able to
pull this off given how rare this combination should be and how
unnoticed the current regression has gone and for how long...

So I came up with the following description trying to detail the
semantics prior to v5.7, post v5.7 up until this patch, and then after
the patch. Linus, I added your SOB to this but tell me if you'd rather
not be associated with this potential mess...

It would be very nice if we had tests for the new behavior. So if @Pedro
would be up for it that would be highly appreciated. If not I'll put it
on my ToDo...

So I can carry this and sent a pr or it can be picked up directly. I'm
not fuzzed. Hopefully there are no surprises or objections...

From 6bc6e6a4c9ed0dcbe0c85cbbaca90953e27889e5 Mon Sep 17 00:00:00 2001
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 21 Mar 2023 09:18:07 +0100
Subject: [PATCH] open: return EINVAL for O_DIRECTORY | O_CREAT

After a couple of years and multiple LTS releases we received a report
that the behavior of O_DIRECTORY | O_CREAT changed starting with v5.7.

On kernels prior to v5.7 combinations of O_DIRECTORY, O_CREAT, O_EXCL
had the following semantics:

(1) open("/tmp/d", O_DIRECTORY | O_CREAT)
    * d doesn't exist:                create regular file
    * d exists and is a regular file: ENOTDIR
    * d exists and is a directory:    EISDIR

(2) open("/tmp/d", O_DIRECTORY | O_CREAT | O_EXCL)
    * d doesn't exist:                create regular file
    * d exists and is a regular file: EEXIST
    * d exists and is a directory:    EEXIST

(3) open("/tmp/d", O_DIRECTORY | O_EXCL)
    * d doesn't exist:                ENOENT
    * d exists and is a regular file: ENOTDIR
    * d exists and is a directory:    open directory

On kernels since to v5.7 combinations of O_DIRECTORY, O_CREAT, O_EXCL
have the following semantics:

(1) open("/tmp/d", O_DIRECTORY | O_CREAT)
    * d doesn't exist:                ENOTDIR (create regular file)
    * d exists and is a regular file: ENOTDIR
    * d exists and is a directory:    EISDIR

(2) open("/tmp/d", O_DIRECTORY | O_CREAT | O_EXCL)
    * d doesn't exist:                ENOTDIR (create regular file)
    * d exists and is a regular file: EEXIST
    * d exists and is a directory:    EEXIST

(3) open("/tmp/d", O_DIRECTORY | O_EXCL)
    * d doesn't exist:                ENOENT
    * d exists and is a regular file: ENOTDIR
    * d exists and is a directory:    open directory

This is a fairly substantial semantic change that userspace didn't
notice until Pedro took the time to deliberately figure out corner
cases. Since no one noticed this breakage we can somewhat safely assume
that O_DIRECTORY | O_CREAT combinations are likely unused.

The v5.7 breakage is especially weird because while ENOTDIR is returned
indicating failure a regular file is actually created. This doesn't make
a lot of sense.

Time was spent finding potential users of this combination. Searching on
codesearch.debian.net showed that codebases often express semantical
expectations about O_DIRECTORY | O_CREAT which are completely contrary
to what our code has done and currently does.

The expectation often is that this particular combination would create
and open a directory. This suggests users who tried to use that
combination would stumble upon the counterintuitive behavior no matter
if pre-v5.7 or post v5.7 and quickly realize neither semantics give them
what they want. For some examples see the code examples in [1] to [3]
and the discussion in [4].

There are various ways to address this issue. The lazy/simple option
would be to restore the pre-v5.7 behavior and to just live with that bug
forever. But since there's a real chance that the O_DIRECTORY | O_CREAT
quirk isn't relied upon we should try to get away with murder(ing bad
semantics) first. If we need to Frankenstein pre-v5.7 behavior later so
be it.

So let's simply return EINVAL categorically for O_DIRECTORY | O_CREAT
combinations. In addition to cleaning up the old bug this also opens up
the possiblity to make that flag combination do something more intuitive
in the future.

Starting with this commit the following semantics apply:

(1) open("/tmp/d", O_DIRECTORY | O_CREAT)
    * d doesn't exist:                EINVAL
    * d exists and is a regular file: EINVAL
    * d exists and is a directory:    EINVAL

(2) open("/tmp/d", O_DIRECTORY | O_CREAT | O_EXCL)
    * d doesn't exist:                EINVAL
    * d exists and is a regular file: EINVAL
    * d exists and is a directory:    EINVAL

(3) open("/tmp/d", O_DIRECTORY | O_EXCL)
    * d doesn't exist:                ENOENT
    * d exists and is a regular file: ENOTDIR
    * d exists and is a directory:    open directory

One additional note, O_TMPFILE is implemented as:

    #define __O_TMPFILE    020000000
    #define O_TMPFILE      (__O_TMPFILE | O_DIRECTORY)
    #define O_TMPFILE_MASK (__O_TMPFILE | O_DIRECTORY | O_CREAT)

For older kernels it was important to return an explicit error when
O_TMPFILE wasn't supported. So it is implemented to look like
O_DIRECTORY | O_RDWR but without O_CREAT. The reason was that
O_DIRECTORY | O_CREAT used to work and created a regular file. Allowing
it to be specified would've potentially caused a regular file to be
created on older kernels while the caller would believe they created an
actual O_TMPFILE. So instead O_TMPFILE has included O_DIRECTORY | O_RDWR
and the code uses O_TMPFILE_MASK to check that O_CREAT isn't specified
returning EINVAL if it is.

With this patch, we categorically reject O_DIRECTORY | O_CREAT and
return EINVAL. That means, we could write this in a way that makes the
if ((flags & O_TMPFILE_MASK) != O_TMPFILE) check superfluous but let's
not do that. The check documents the peculiar aspects of O_TMPFILE quite
nicely and can serve as a reminder how easy it is to break.

As Aleksa pointed out O_PATH is unaffected by this change since it
always returned EINVAL if O_CREAT was specified - with or without
O_DIRECTORY.

Link: https://lore.kernel.org/lkml/20230320071442.172228-1-pedro.falcato@gmail.com
Link: https://sources.debian.org/src/flatpak/1.14.4-1/subprojects/libglnx/glnx-dirfd.c/?hl=324#L324 [1]
Link: https://sources.debian.org/src/flatpak-builder/1.2.3-1/subprojects/libglnx/glnx-shutil.c/?hl=251#L251 [2]
Link: https://sources.debian.org/src/ostree/2022.7-2/libglnx/glnx-dirfd.c/?hl=324#L324 [3]
Link: https://www.openwall.com/lists/oss-security/2014/11/26/14 [4]
Reported-by: Pedro Falcato <pedro.falcato@gmail.com>
Cc: Aleksa Sarai <cyphar@cyphar.com>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
---
This survives xfstests:

        sudo ./check -g unlink,idmapped

which pounds on the creation and O_TMPFILE paths.

It also survives LTP:

        sudo ./runtltp -f syscalls openat2
        sudo ./runtltp -f syscalls openat
        # The following includes openat2, openat, open, fsopen, open_tree, etc.
        sudo ./runtltp -f syscalls open
        sudo ./runtltp -f syscalls create_file
        sudo ./runtltp -f syscalls create_files

I've also written a (very nasty) test script:

        #define _GNU_SOURCE
        #include <fcntl.h>
        #include <stdio.h>
        #include <stdlib.h>

        int main(int argc, char *argv[])
        {
                int fd;

                fd = open("/tmp/TEST", O_DIRECTORY | O_CREAT);
                if (fd >= 0)
                        printf("%d\n", fd);
                else
                        printf("%m: fd(%d)\n", fd);

                fd = open("/tmp/TEST", O_DIRECTORY | O_CREAT | O_EXCL);
                if (fd >= 0)
                        printf("%d\n", fd);
                else
                        printf("%m: fd(%d)\n", fd);

                fd = open("/tmp/TEST", O_DIRECTORY | O_EXCL);
                if (fd >= 0)
                        printf("%d\n", fd);
                else
                        printf("%m: fd(%d)\n", fd);

                exit(EXIT_SUCCESS);
        }
        ubuntu@vm1:~/ssd$ sudo ./create_test
        Invalid argument: fd(-1)
        Invalid argument: fd(-1)
        No such file or directory: fd(-1)
---
 fs/open.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/open.c b/fs/open.c
index 4401a73d4032..39e360f9490d 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -1135,6 +1135,8 @@ struct file *open_with_fake_path(const struct path *path, int flags,
 EXPORT_SYMBOL(open_with_fake_path);
 
 #define WILL_CREATE(flags)	(flags & (O_CREAT | __O_TMPFILE))
+#define INVALID_CREATE(flags) \
+	((flags & (O_DIRECTORY | O_CREAT)) == (O_DIRECTORY | O_CREAT))
 #define O_PATH_FLAGS		(O_DIRECTORY | O_NOFOLLOW | O_PATH | O_CLOEXEC)
 
 inline struct open_how build_open_how(int flags, umode_t mode)
@@ -1207,6 +1209,10 @@ inline int build_open_flags(const struct open_how *how, struct open_flags *op)
 		if (!(acc_mode & MAY_WRITE))
 			return -EINVAL;
 	}
+
+	if (INVALID_CREATE(flags))
+		return -EINVAL;
+
 	if (flags & O_PATH) {
 		/* O_PATH only permits certain other flags to be set. */
 		if (flags & ~O_PATH_FLAGS)
-- 
2.34.1

