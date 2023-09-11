Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51EE679AD00
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Sep 2023 01:38:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239355AbjIKUyu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Sep 2023 16:54:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242244AbjIKPZr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Sep 2023 11:25:47 -0400
Received: from smtp-8faf.mail.infomaniak.ch (smtp-8faf.mail.infomaniak.ch [IPv6:2001:1600:3:17::8faf])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38D4ADB
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Sep 2023 08:25:39 -0700 (PDT)
Received: from smtp-2-0001.mail.infomaniak.ch (unknown [10.5.36.108])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4RkrBm5qP4zMq839;
        Mon, 11 Sep 2023 15:25:36 +0000 (UTC)
Received: from unknown by smtp-2-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4RkrBm0tZjzMppKQ;
        Mon, 11 Sep 2023 17:25:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1694445936;
        bh=xRV71qoOA4eSkJkXZKaLR821G8Aifhu0kGb7IfAdnmo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rS0GIhkrX37cIGv6CU5tNhMp2PS+t1XwON6aZcMZs0D79MFiJENygNtPpkF3zr1o2
         9yULFeE9hJ4tcYbM/rVNoIroe83I7hblJECMlNyjaUIrnv48wFnmrtvlp1GzZLpW0t
         aQnrGT8ulWZ7ZWxb9xnjocHte0Sv2q6bUeNuacB8=
Date:   Mon, 11 Sep 2023 17:25:31 +0200
From:   =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To:     =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        linux-security-module@vger.kernel.org, Jeff Xu <jeffxu@google.com>,
        Jorge Lucangeli Obes <jorgelo@chromium.org>,
        Allen Webb <allenwebb@google.com>,
        Dmitry Torokhov <dtor@google.com>,
        Paul Moore <paul@paul-moore.com>,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        Matt Bobrowski <repnop@google.com>,
        linux-fsdevel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH v3 0/5] Landlock: IOCTL support
Message-ID: <20230911.jie6Rai8ughe@digikod.net>
References: <20230814172816.3907299-1-gnoack@google.com>
 <20230818.iechoCh0eew0@digikod.net>
 <ZOjCz5j4+tgptF53@google.com>
 <20230825.Zoo4ohn1aivo@digikod.net>
 <20230826.ohtooph0Ahmu@digikod.net>
 <ZPMiVaL3kVaTnivh@google.com>
 <20230904.aiWae8eineo4@digikod.net>
 <ZP7lxmXklksadvz+@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZP7lxmXklksadvz+@google.com>
X-Infomaniak-Routing: alpha
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 11, 2023 at 12:02:46PM +0200, Günther Noack wrote:
> Hello!
> 
> On Mon, Sep 04, 2023 at 08:08:29PM +0200, Mickaël Salaün wrote:
> > On Sat, Sep 02, 2023 at 01:53:57PM +0200, Günther Noack wrote:
> > > On Sat, Aug 26, 2023 at 08:26:30PM +0200, Mickaël Salaün wrote:
> > > > On Fri, Aug 25, 2023 at 06:50:29PM +0200, Mickaël Salaün wrote:
> > > > > On Fri, Aug 25, 2023 at 05:03:43PM +0200, Günther Noack wrote:
> > > > > > FIONREAD gives the number of bytes that are ready to read.  This IOCTL seems
> > > > > > only useful when the file is open for reading.  However, do you think that we
> > > > > > should correlate this with (a) LANDLOCK_ACCESS_FS_READ_FILE, or with (b)
> > > > > > f->f_mode & FMODE_READ?  (The difference is that in case (a), FIONREAD will work
> > > > > > if you open a file O_WRONLY and you also have the LANDLOCK_ACCESS_FS_READ_FILE
> > > > > > right for that file.  In case (b), it would only work if you also opened the
> > > > > > file for reading.)
> > > > > 
> > > > > I think we should allow FIONREAD if LANDLOCK_ACCESS_FS_IOCTL is handled
> > > > > and if LANDLOCK_ACCESS_FS_READ_FILE is explicitly allowed for this FD.
> > > 
> > > Just paraphrasing for later reference, because I almost misunderstood it:
> > > 
> > > FIONREAD should work even when LANDLOCK_ACCESS_FS_IOCTL is *handled*,
> > > which is lingo for "listed in the ruleset_attr.handled_access_fs".
> > > When it is listed there, that means that the Landlock policy does not
> > > grant the LANDLOCK_ACCESS_FS_IOCTL right.
> > > 
> > > So we treat FIONREAD as blanket-permitted independent of the
> > > LANDLOCK_ACCESS_FS_IOCTL right, under the condition that we have
> > > LANDLOCK_ACCESS_FS_READ_FILE for the file. -- Sounds good to me, will do.
> > 
> > We are almost on the same line but here is the explicit algorithm:
> > 
> > if (LANDLOCK_ACCESS_FS_IOCTL is not handled by the FD's ruleset) {
> > 	allow FIONREAD
> > } else {
> > 	if (LANDLOCK_ACCESS_FS_READ_FILE is handled by the FD's ruleset) {
> > 		if (LANDLOCK_ACCESS_FS_READ_FILE is allowed for the FD) {
> > 			allow FIONREAD
> > 		} else {
> > 			deny FIONREAD
> > 		}
> > 	} else {
> > 		if (LANDLOCK_ACCESS_FS_IOCTL is allowed for FD) {
> > 			allow FIONREAD
> > 		} else {
> > 			deny FIONREAD
> > 		}
> > 	}
> > }
> > 
> > The notation "FD's ruleset" refers to the Landlock domain that was being
> > evaluated when the FD was being opened, not necessarely the current
> > process's domain.
> > 
> > The same logic should apply for all IOCTL delegations, and the tests
> > should check this behavior. We may want to create a new helper to ease
> > this IOCTL delegation and future ones.
> 
> Thank you for making the algorithm that explicit -- that helps to trace down the
> differences.  I can follow the logic now, but I still don't understand what your
> underlying rationale for that is?
> 
> I believe that fundamentally, a core difference is:
> 
> For an access right R and a file F, for these two cases:
> 
>  (a) the access right R is unhandled  (nothing gets restricted)
>  (b) the access right R is handled, but R is granted for F in a rule.
> 
> I believe that accesses in case (a) and (b) to the file F should have the same
> results.
> 
> This is at least how the existing Landlock implementation works, as far as I can
> tell.
> 
> ("Refer" is an exceptional case, but we have documented that it was always
> "implicitly handled" in ABI V1, which makes it consistent again.)
> 
> 
> When I expand your code above to a boolean table, I end up with the following
> decisions, depending on whether IOCTL and READ are handled or not, and whether
> they are explicitly permitted for the file through a rule:
> 
> 
> Mickaël's        IOCTL      IOCTL      IOCTL
> suggestion       handled,   handled,   unhandled
> 2023-09-04       file       file not
>                  permitted  permitted
> --------------------------------------------------
> READ handled,
> file permitted   allow      allow      allow
> 
> READ handled,
> f not permitted  deny       deny       allow
> 
> READ unhandled   allow      deny       allow
> 
> 
> In patch set V3, this is different: Because I think that cases (a) and (b) from
> above should always behave the same, the first and third column and row must be
> symmetric and have the same entries.  So, in patch set V3, it is sufficient if
> *one of* the two rights IOCTL and READ_FILE are present, in order to use the
> FIONREAD IOCTL:
> 
> 
> Günther's        IOCTL      IOCTL      IOCTL
> patch set V3     handled,   handled,   unhandled
> 2023-08-14       file       file not
>                  permitted  permitted
> --------------------------------------------------
> READ handled,
> file permitted   allow      allow      allow
> 
> READ handled,
> f not permitted  allow      deny       allow
> 
> READ unhandled   allow      allow      allow

A first difference is about (READ unhandled) AND (IOCTL handled +
file not permitted). It will not be possible to follow the same logic
with new Landlock access right (e.g. LANDLOCK_ACCESS_FS_READ_METADATA
that should also allow FS_IOC_FSGETXATTR), and I'd like to keep it
consistent.

A second difference is about (READ handled + f not permitted) AND
(IOCTL handled + file permitted). The reasoning was to avoid giving too
much power to LANDLOCK_ACCESS_FS_IOCTL and dowgrade it as new access
rights are implemented. This looks quite similar to the CAP_SYS_ADMIN
right that can basically do anything, and new capabilites are mainly a
subset of this one. My proposal was to incrementally downgrade the power
given by LANDLOCK_ACCESS_FS_IOCTL while still being compatible. On the
I was thinking that, if we make a requirement to have the "new correct"
access right, the application update might drop the IOCTL access right.
I now think this reasoning is flawed.

Indeed, this comparaison doesn't fit well because IOCTLs are not a
superset of all access rights, and because nothing can force developers
that already gave access to all IOCTLs for a file to not just add
another access right (instead of swapping them).

Instead, I think user space libraries should manage this kind of access
right swapping when possible and have a fallback mechanism relying on
the LANDLOCK_ACCESS_FS_IOCTL right. This would be valuable because they
may be updated before the (stable system) kernel, and this would be
easier for developers to manage.

In a nutshell, it is about giving control for an action (e.g. FIONREAD)
to either a unique access right or to a set of access rights. At first,
I would have preferred to have a unique access right to control an
action, because it is simpler (e.g. for audit/debug). On the other hand,
we need to handle access rights that allow the same action (e.g. file
read OR write for FIOQSIZE). I now think your approach (i.e. set of
access rights to control an action) could make more sense. Another good
point is to not downgrade the power of LANDLOCK_ACCESS_FS_IOCTL, which
could in fact be difficult to understand for users. Nested Landlock
domains should also be easier to manage with this logic.

> 
> 
> I have not spelled out the boolean logic tables for FIOQSIZE in the same way
> (they would also have three dimensions, strictly speaking), but I assume that
> the fundamental difference is the same -- you're also mentioning the "subtle
> difference between not handled and explicitly allowed" below.
> 
> I honestly don't think that these cases should be different - it complicates
> both the contract with the callers and our internal implementation if we need to
> differentiate between three different configurations (handled + permitted,
> handled + not permitted, unhandled), rather than collapsing these into two
> (permitted, not permitted) as we currently do.
> 
> I would like to encourage users of Landlock to "handle" as many rights as
> possible, and then poke holes into these restrictions for the files they need.
> But that is only an easy sell if we can actually guarantee that it behaves the
> same as if the right was unhandled.

I agree with that, but there are compatibility limitations, hence the
first difference. This case should be rare though, i.e. app not
supporting an existing access right but still willing to support a new
one (IOCTL).

> 
> 
> > BTW, FIONREAD requested on another FS would call vfs_ioctl() twice. This
> > should probably be fixed. Any though Christian?
> > 
> > > 
> > > 
> > > > > > FIOQSIZE seems like it would be useful for both reading *and* writing? -- The
> > > > > > reading case is obvious, but for writers it's also useful if you want to seek
> > > > > > around in the file, and make sure that the position that you seek to already
> > > > > > exists.  (I'm not sure whether that use case is relevant in practical
> > > > > > applications though.) -- Why would FIOQSIZE only be useful for readers?
> > > > > 
> > > > > Good point! The use case you define for writing is interesting. However,
> > > > > would it make sense to seek at a specific offset without being able to
> > > > > know/read the content? I guest not in theory, but in practice we might
> > > > > want to avoid application to require LANDLOCK_ACCESS_FS_READ_FILE is
> > > > > they only require to write (at a specific offset), or to deal with write
> > > > > errors. Anyway, I guess that this information can be inferred by trying
> > > > > to seek at a specific offset.  The only limitation that this approach
> > > > > would bring is that it seems that we can seek into an FD even without
> > > > > read nor write right, and there is no specific (LSM) access control for
> > > > > this operation (and nobody seems to care about being able to read the
> > > > > size of a symlink once opened). If this is correct, I think we should
> > > > > indeed always allow FIOQSIZE. Being able to open a file requires
> > > > > LANDLOCK_ACCESS_FS_READ or WRITE anyway.  It would be interesting to
> > > > > check and test with O_PATH though.
> > > > 
> > > > FIOQSIZE should in fact only be allowed if LANDLOCK_ACCESS_FS_READ_FILE or
> > > > LANDLOCK_ACCESS_FS_WRITE_FILE or LANDLOCK_ACCESS_FS_READ_DIR are handled
> > > > and explicitly allowed for the FD. I guess FIOQSIZE is allowed without read
> > > > nor write mode (i.e. O_PATH), so it could be an issue for landlocked
> > > > applications but they can explicitly allow IOCTL for this case. When
> > > > we'll have a LANDLOCK_ACCESS_FS_READ_METADATA (or something similar), we
> > > > should also tie FIOQSIZE to this access right, and we'll be able to
> > > > fully handle all the use cases without fully allowing all other IOCTLs.
> > > 
> > > I implemented this check for the Landlock access rights in the ioctl hook, but
> > > when testing it I realized that I could not ever get it to fail in practice:
> > > 
> > > ioctl(2) generally returns EBADF when the file was opened with O_PATH.  Early in
> > > the ioctl(2) syscall implementation, it returns EBADF when the struct fd does
> > > not have the ->file attribute set.  (This is even true for the commands to
> > > manipulate the Close-on-exec flag, which don't strictly need that. But they
> > > might work through fcntl.)
> > 
> > Yes, this is expected, but I'd like to keep these tests to guarantee
> > this behavior with all future kernel versions as well.
> > 
> > > 
> > > In my understanding from the open(2) man page, the only ways to open files are
> > > with one of O_RDONLY, O_RDWR, O_WRONLY or O_PATH:
> > > 
> > > - O_RDONLY: we had LANDLOCK_ACCESS_FS_READ_FILE at the time of open(2).
> > > - O_WRONLY: we had LANDLOCK_ACCESS_FS_WRITE_FILE at the time of open(2).
> > > - O_RDWR: we had both of these two rights at the time of open(2).
> > > - O_PATH: any ioctl(2) attempt returns EBADF early on
> > > 
> > > So at the time that the ioctl security hook gets called, we already know that
> > > the user must have had one of the LANDLOCK_ACCESS_FS_READ_FILE or
> > > LANDLOCK_ACCESS_FS_WRITE_FILE rights -- checking for it again is not strictly
> > > necessary?
> > 
> > This is not the case if LANDLOCK_ACCESS_FS_{READ,WRITE}_FILE are not
> > handled by the ruleset, see the subtle difference between not handled
> > and explicitly allowed. Here is the corresponding explicit algorithm:
> > 
> > if (LANDLOCK_ACCESS_FS_IOCTL is not handled by the FD's ruleset) {
> > 	allow FIOQSIZE
> > } else {
> > 	if (LANDLOCK_ACCESS_FS_READ_FILE is handled by the FD's ruleset) {
> > 		if (LANDLOCK_ACCESS_FS_READ_FILE is allowed for the FD) {
> > 			allow FIOQSIZE
> > 		} else {
> > 			if (LANDLOCK_ACCESS_FS_WRITE_FILE is handled by the FD's ruleset) {
> > 				if (LANDLOCK_ACCESS_FS_WRITE_FILE is allowed for the FD) {
> > 					allow FIOQSIZE
> > 				} else {
> > 					deny FIOQSIZE
> > 				}
> > 			} else {
> > 				if (LANDLOCK_ACCESS_FS_IOCTL is allowed for FD) {
> > 					allow FIOQSIZE
> > 				} else {
> > 					deny FIOQSIZE
> > 				}
> > 			}
> > 		}
> > 	} else {
> > 		if (LANDLOCK_ACCESS_FS_WRITE_FILE is handled by the FD's ruleset) {
> > 			if (LANDLOCK_ACCESS_FS_WRITE_FILE is allowed for the FD) {
> > 				allow FIOQSIZE
> > 			} else {
> > 				deny FIOQSIZE
> > 			}
> > 		} else {
> > 			if (LANDLOCK_ACCESS_FS_IOCTL is allowed for FD) {
> > 				allow FIOQSIZE
> > 			} else {
> > 				deny FIOQSIZE
> > 			}
> > 		}
> > 	}
> > }
> > 
> > > 
> > > Am I missing something here?  (In particular, am I overlooking additional ways
> > > to call open(2) where the read and write rights are not necessary, other than
> > > O_PATH?)
> > 
> > You're correct about the file mode and IOCTL returning EBADF for O_PATH,
> > but you didn't take into account the fact that (for whatever reason)
> > rulesets may not handle read/write file access rights.
> > 
> > > 
> > > I'd propose this path forward: Let's keep the check for the rights as you
> > > suggested, but I would just keep it as an additional safety net there, for
> > > Landlock's internal consistency, and in case that future Linux versions
> > > introduce new ways to open files.
> > 
> > Yes, you're correct, this is the right approach. Even if the kernel
> > doesn't need additional checks for now, we should still give
> > guarantees/promises that we can keep (i.e. part of Landlock's code), and
> > be consistent with Landlock's internals and code documentation.
> > 
> > > I believe that at the moment, that check is
> > > equivalent to always permitting the FIOQSIZE command in that hook (with the same
> > > logic as for FIOCLEX, FIONCLEX etc).
> > 
> > Not if LANDLOCK_ACCESS_FS_READ_FILE or LANDLOCK_ACCESS_FS_WRITE_FILE are
> > not allowed.
> > 
> > > 
> > > 
> > > > > > (In fact, it seems to me almost like FIOQSIZE might rather be missing a security
> > > > > > hook check for one of the "getting file attribute" hooks?)
> > > > > > 
> > > > > > So basically, the implementation that I currently ended up with is:
> > > > > > 
> > > > > 
> > > > > Before checking these commands, we first need to check that the original
> > > > > domain handle LANDLOCK_ACCESS_FS_IOCTL. We should try to pack this new
> > > > > bit and replace the file's allowed_access field (see
> > > > > landlock_add_fs_access_mask() and similar helpers in the network patch
> > > > > series that does a similar thing but for ruleset's handle access
> > > > > rights), but here is the idea:
> > > > > 
> > > > > if (!landlock_file_handles_ioctl(file))
> > > > > 	return 0;
> > > > > 
> > > > > > switch (cmd) {
> > > > > 	/*
> > > > > 	 * Allows file descriptor and file description operations (see
> > > > > 	 * fcntl commands).
> > > > > 	 */
> > > > > >   case FIOCLEX:
> > > > > >   case FIONCLEX:
> > > > > >   case FIONBIO:
> > > > > >   case FIOASYNC:
> > > > > 
> > > > > >   case FIOQSIZE:
> > > > 
> > > > We need to handle FIOQSIZE as done by do_vfs_ioctl: add the same i_mode
> > > > checks. A kselftest test should check that ENOTTY is returned according
> > > > to the file type and the access rights.
> > > 
> > > It's not clear to me why we would need to add the same i_mode checks for
> > > S_ISDIR() || S_ISREG() || S_ISLNK() there?  If these checks in do_vfs_ioctl()
> > > fail, it returns -ENOTTY.  Is that not an appropriate error already?
> > 
> > The LSM IOCTL hook is called before do_vfs_ioctl(), and I think that
> > Landlock should not change the error codes according to the error types
> > (i.e. return ENOTTY when the inode is something else than a directory,
> > regular file, or symlink). Indeed, I think it's valuable to not blindly
> > return EACCES when the IOCTL doesn't make sense for this file type. This
> > should help user space handle meaningful error messages, inconsistent
> > requests, and fallback mechanisms. Tests should check these return
> > codes, see the network patch series (and especially the latest reviews
> > and changes) that takes care of this kind of error codes compatibility.
> > 
> > We could also return 0 (i.e. accept the request) and rely on the
> > do_vfs_ioctl() check to return ENOTTY, but this is unnecessary risky
> > from an access control point of view. Let's directly return ENOTTY as a
> > safeguard (which BTW also avoids some useless CPU instructions) and test
> > this behavior.
> > 
> > I think an access control mechanism, and especially Landlock, should be
> > as discreet as possible, and help developers quickly debug issues (and
> > avoid going through the access control layer if it doesn't make sense).
> > I think error ordering like this could be useful but I'd like to get
> > other point of views.
> 
> I see what you mean now, OK.
> 
> Another option, btw, would be to return ENOTTY generally when Landlock denies an
> IOCTL attempt, instead of EACCES, as I have previously suggested in
> https://lore.kernel.org/all/ZNpnrCjYqFoGkwyf@google.com/ -- should we maybe just
> do that instead?
> 
> I believe that users of ioctl(2) should be better equipped to deal with ENOTTY,
> because that is an error that ioctl(2) can return in general, whereas EACCES can
> only be returned if one of the specific subcommands returns it.
> 
> According to the man page, ENOTTY is the error that ioctl(2) returns if the
> given "request does not apply to the kind of object that the file descriptor fd
> references".
> 
> That is not 100% what is happening here, but from the errors listed in ioctl(2),
> this seems to be the closest, semantically.
> 
> What do you think?

ENOTTY has a (kinda) well-defined semantic, which should not depend on
an access control. Other LSMs already return EACCES for denied IOCTLs,
so the man page should be updated with this information instead. ;)

> 
> > 
> > > 
> > > 
> > > > > >     return 0;
> > > > > >   case FIONREAD:
> > > > > >     if (file->f_mode & FMODE_READ)
> > > > > 
> > > > > We should check LANDLOCK_ACCESS_FS_READ instead, which is a superset of
> > > > > FMODE_READ.
> > > 
> > > Done.
> > 
> > We could also mimic the do_vfs_ioctl() checks according to the file
> > being a regular file or not, but I think the FIONREAD semantic is well
> > defined and delegating this command to underlying VFS implementations
> > should not be an issue and be controlled the same way. It seems that
> > only the pipe FS also implements this IOCTL and we should treat it the
> > same way as for regular files. We should keep an eye on new
> > implementations of this IOCTL though, but I guess the limit of our
> > review stops at the FUSE boundary.
> > 
> > We should also allow all IOCTLs implemented by pipefifo_fops. They are
> > unrelated to the underlying filesystem (and then don't store data) but
> > they can still be found on any of them, they can only have an impact on
> > the related IPC (not directly system-wide like char/block devices), and
> > these kind of files may be swapped from a FD unrelated to the filesystem
> > to a named pipe according to application configuration (e.g. pipe
> > redirection). IOCTLs on unix named socket should also be allowed, but
> > anyway, they cannot be opened with open(2) (ENXIO is returned), so
> > socket FDs should never get any restriction because of a path_beneath
> > rule, so we can simply ignore this case (but still document and test
> > it).
> 
> Thanks, that's a good observation!  Adding named pipes and named unix sockets to
> the TODO list for the next iteration.  I had not thought of these.
> 
> 
> > Thinking more about the IOCTL control, I think we should help as much as
> > possible developers to not require the LANDLOCK_ACCESS_FS_IOCTL right
> > because that would mask their intent and it would grant a lot of
> > potentially-undefined accesses. Delegating at least most VFS IOCTLs
> > (i.e. standardized/generic IOCTLs) to regular Landlock access rights
> > should then be encouraged.
> > 
> > Even if new VFS IOCTLs should be scarce and new VFS syscalls should be
> > encouraged instead, we will still be able to delegate future VFS IOCTLs
> > to existing Landlock access rights according to their semantic.
> 
> OK, the approach makes sense.  I'll respond on these individual items as I get
> around to implement them when we have clarified the unhandled/handled+permitted
> question above.
> 
> 
> > Taking the list of VFS IOCTLs you extracted, here is my updated point of
> > view:
> > >  * FIFREEZE, FITHAW - work on superblock(!) to freeze/thaw the file
> > >    system. Requires CAP_SYS_ADMIN.
> > 
> > These acts on an entire filesystem, not a file, and this is an
> > administrative task, so we can rely on LANDLOCK_ACCESS_FS_IOCTL to
> > control these ones for now.
> > 
> > >  * FICLONE, FICLONERANGE, FIDEDUPRANGE - making files share physical storage
> > >    between multiple files.  These only work on some file systems, by design.
> > 
> > For these IOCTLs, the kernel already check file permission with the
> > remap_verify_area() and generic_file_rw_checks() calls. We should then
> > follow the same logic. However, we should not check if the FD has the
> > read/write Landlock access rights in the IOCTL hook (to only check once,
> > and avoid TOCTOU), but only check if they are handled. The effective
> > checks will be done by the VFS code, and we can then keep the current
> > error ordering.
> > 
> > FICLONE, FICLONERANGE should delegate to LANDLOCK_ACCESS_FS_WRITE_FILE.
> > The other FD, extracted from IOCTL argument, is checked against the
> > read permission, but this should only be part of a comment (in our IOCTL
> > hook implementation).
> > 
> > FIDEDUPRANGE should delegate to LANDLOCK_ACCESS_FS_READ_FILE
> > 
> > >  * Commands that read file system internals:
> > >    * FS_IOC_FIEMAP - get information about file extent mapping
> > >      (c.f. https://www.kernel.org/doc/Documentation/filesystems/fiemap.txt)
> > 
> > For FS_IOCT_FIEMAP, there is no file permission check. This should be
> > delegated to LANDLOCK_ACCESS_FS_READ_FILE or
> > LANDLOCK_ACCESS_FS_WRITE_FILE for the same reasons as FIOQSIZE.
> > 
> > I'm not sure if we'll have to care about FIEMAP_FLAG_XATTR, but that
> > should not be an issue for now.
> > 
> > >    * FIBMAP - get a file's file system block number
> > 
> > There is no file permission check for FIBMAP (only the process's
> > capabilities).  I think the Landlock checks should be the same as for
> > FS_IOCT_FIEMAP.
> > 
> > >    * FIGETBSZ - get file system blocksize
> > 
> > I guess this also enables to optimize file storage. It would probably
> > make sense to delegate this one to LANDLOCK_ACCESS_FS_WRITE_FILE, or
> > follow the FIOQSIZE logic?
> > 
> > >  * Accessing file attributes:
> > >    * FS_IOC_GETFLAGS, FS_IOC_SETFLAGS - manipulate inode flags (ioctl_iflags(2))
> > 
> > These should be delegated to a future LANDLOCK_ACCESS_FS_READ_METADATA,
> > so only LANDLOCK_ACCESS_FS_IOCTL for now.
> > 
> > >    * FS_IOC_FSGETXATTR, FS_IOC_FSSETXATTR - more attributes
> > 
> > These should be delegated to a future LANDLOCK_ACCESS_FS_WRITE_METADATA,
> > so only LANDLOCK_ACCESS_FS_IOCTL for now.
> > 
> > >  * FS_IOC_RESVSP, FS_IOC_RESVSP64, FS_IOC_UNRESVSP, FS_IOC_UNRESVSP64,
> > >    FS_IOC_ZERO_RANGE: Backwards compatibility with legacy XFS preallocation
> > >    syscalls which predate fallocate(2).
> > 
> > ioctl_preallocate()-related IOCTLs should also be controlled like
> > FIONREAD but according to LANDLOCK_ACCESS_FS_WRITE_FILE because there is
> > in fact already a check with the vfs_fallocate/security_file_permission
> > call.
> > 
> > We should also check an IOCTL from an unrestricted special filesystems,
> > e.g. NS_GET_NSTYPE.
> > 
> > What do you think?
