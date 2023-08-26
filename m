Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C6BE7898AA
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Aug 2023 20:27:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbjHZS0o (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 26 Aug 2023 14:26:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjHZS0l (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 26 Aug 2023 14:26:41 -0400
Received: from smtp-8faf.mail.infomaniak.ch (smtp-8faf.mail.infomaniak.ch [IPv6:2001:1600:3:17::8faf])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E05A8171A
        for <linux-fsdevel@vger.kernel.org>; Sat, 26 Aug 2023 11:26:38 -0700 (PDT)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4RY4yy4c7SzMq14d;
        Sat, 26 Aug 2023 18:26:34 +0000 (UTC)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4RY4yx3skpz3Z;
        Sat, 26 Aug 2023 20:26:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1693074394;
        bh=k9KY2c6i9BmJ9SsZ4rqBiGKgtAJnA3Vgh+QwJPQFQ/M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=msGL4U/LMRUNV5W5PrQcgD48twy701jVMenMizSjGEQgXoUaS1LpjSTSjz9y4iVH8
         9f8h8p1t1pLbIRrgmMR8Z6u36CtsPrzJTageHPEq+bcL1nHcg8MKBQPcS6Vm9DYOkO
         FJDFBTuCwqyvNL8huAFfwE5D/BUclViNxCSgEmSY=
Date:   Sat, 26 Aug 2023 20:26:30 +0200
From:   =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To:     =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
Cc:     linux-security-module@vger.kernel.org, Jeff Xu <jeffxu@google.com>,
        Jorge Lucangeli Obes <jorgelo@chromium.org>,
        Allen Webb <allenwebb@google.com>,
        Dmitry Torokhov <dtor@google.com>,
        Paul Moore <paul@paul-moore.com>,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        Matt Bobrowski <repnop@google.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 0/5] Landlock: IOCTL support
Message-ID: <20230826.ohtooph0Ahmu@digikod.net>
References: <20230814172816.3907299-1-gnoack@google.com>
 <20230818.iechoCh0eew0@digikod.net>
 <ZOjCz5j4+tgptF53@google.com>
 <20230825.Zoo4ohn1aivo@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230825.Zoo4ohn1aivo@digikod.net>
X-Infomaniak-Routing: alpha
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 25, 2023 at 06:50:29PM +0200, Mickaël Salaün wrote:
> On Fri, Aug 25, 2023 at 05:03:43PM +0200, Günther Noack wrote:
> > Hi!
> > 
> > On Fri, Aug 18, 2023 at 03:39:19PM +0200, Mickaël Salaün wrote:
> > > On Mon, Aug 14, 2023 at 07:28:11PM +0200, Günther Noack wrote:
> > > > These patches add simple ioctl(2) support to Landlock.
> > > 
> > > [...]
> > > 
> > > > How we arrived at the list of always-permitted IOCTL commands
> > > > ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > > 
> > > > To decide which IOCTL commands should be blanket-permitted I went through the
> > > > list of IOCTL commands mentioned in fs/ioctl.c and looked at them individually
> > > > to understand what they are about.  The following list is my conclusion from
> > > > that.
> > > > 
> > > > We should always allow the following IOCTL commands:
> > > > 
> > > >  * FIOCLEX, FIONCLEX - these work on the file descriptor and manipulate the
> > > >    close-on-exec flag
> > > >  * FIONBIO, FIOASYNC - these work on the struct file and enable nonblocking-IO
> > > >    and async flags
> > > >  * FIONREAD - get the number of bytes available for reading (the implementation
> > > >    is defined per file type)
> > > 
> > > I think we should treat FIOQSIZE like FIONREAD, i.e. check for
> > > LANDLOCK_ACCESS_FS_READ_FILE as explain in my previous message.
> > > Tests should then rely on something else.
> > 
> > OK, I rewrote the tests to use FS_IOC_GETFLAGS.
> > 
> > Some thoughts on these two IOCTLs:
> > 
> > FIONREAD gives the number of bytes that are ready to read.  This IOCTL seems
> > only useful when the file is open for reading.  However, do you think that we
> > should correlate this with (a) LANDLOCK_ACCESS_FS_READ_FILE, or with (b)
> > f->f_mode & FMODE_READ?  (The difference is that in case (a), FIONREAD will work
> > if you open a file O_WRONLY and you also have the LANDLOCK_ACCESS_FS_READ_FILE
> > right for that file.  In case (b), it would only work if you also opened the
> > file for reading.)
> 
> I think we should allow FIONREAD if LANDLOCK_ACCESS_FS_IOCTL is handled
> and if LANDLOCK_ACCESS_FS_READ_FILE is explicitly allowed for this FD.
> 
> f->f_mode & FMODE_READ would make sense but it should have been handled
> by the kernel; Landlock should not try to fix this inconsistency.
> 
> These are good test cases though.
> 
> It should be noted that SELinux considers FIONREAD as tied to metadata
> reading (FILE__GETATTR). It think it makes more sense to tie it to the
> read right (LANDLOCK_ACCESS_FS_READ_FILE) because it might be
> (legitimately) required to properly read a file and FIONREAD is tied to
> the content of a file, not file attributes.
> 
> > 
> > FIOQSIZE seems like it would be useful for both reading *and* writing? -- The
> > reading case is obvious, but for writers it's also useful if you want to seek
> > around in the file, and make sure that the position that you seek to already
> > exists.  (I'm not sure whether that use case is relevant in practical
> > applications though.) -- Why would FIOQSIZE only be useful for readers?
> 
> Good point! The use case you define for writing is interesting. However,
> would it make sense to seek at a specific offset without being able to
> know/read the content? I guest not in theory, but in practice we might
> want to avoid application to require LANDLOCK_ACCESS_FS_READ_FILE is
> they only require to write (at a specific offset), or to deal with write
> errors. Anyway, I guess that this information can be inferred by trying
> to seek at a specific offset.  The only limitation that this approach
> would bring is that it seems that we can seek into an FD even without
> read nor write right, and there is no specific (LSM) access control for
> this operation (and nobody seems to care about being able to read the
> size of a symlink once opened). If this is correct, I think we should
> indeed always allow FIOQSIZE. Being able to open a file requires
> LANDLOCK_ACCESS_FS_READ or WRITE anyway.  It would be interesting to
> check and test with O_PATH though.

FIOQSIZE should in fact only be allowed if LANDLOCK_ACCESS_FS_READ_FILE or
LANDLOCK_ACCESS_FS_WRITE_FILE or LANDLOCK_ACCESS_FS_READ_DIR are handled
and explicitly allowed for the FD. I guess FIOQSIZE is allowed without read
nor write mode (i.e. O_PATH), so it could be an issue for landlocked
applications but they can explicitly allow IOCTL for this case. When
we'll have a LANDLOCK_ACCESS_FS_READ_METADATA (or something similar), we
should also tie FIOQSIZE to this access right, and we'll be able to
fully handle all the use cases without fully allowing all other IOCTLs.

> 
> > 
> > (In fact, it seems to me almost like FIOQSIZE might rather be missing a security
> > hook check for one of the "getting file attribute" hooks?)
> > 
> > So basically, the implementation that I currently ended up with is:
> > 
> 
> Before checking these commands, we first need to check that the original
> domain handle LANDLOCK_ACCESS_FS_IOCTL. We should try to pack this new
> bit and replace the file's allowed_access field (see
> landlock_add_fs_access_mask() and similar helpers in the network patch
> series that does a similar thing but for ruleset's handle access
> rights), but here is the idea:
> 
> if (!landlock_file_handles_ioctl(file))
> 	return 0;
> 
> > switch (cmd) {
> 	/*
> 	 * Allows file descriptor and file description operations (see
> 	 * fcntl commands).
> 	 */
> >   case FIOCLEX:
> >   case FIONCLEX:
> >   case FIONBIO:
> >   case FIOASYNC:
> 
> >   case FIOQSIZE:

We need to handle FIOQSIZE as done by do_vfs_ioctl: add the same i_mode
checks. A kselftest test should check that ENOTTY is returned according
to the file type and the access rights.

> >     return 0;
> >   case FIONREAD:
> >     if (file->f_mode & FMODE_READ)
> 
> We should check LANDLOCK_ACCESS_FS_READ instead, which is a superset of
> FMODE_READ.
> 
> >       return 0;
> > }
> > 
> > (with some comments in the source code, of course...)
> > 
> > Does that look reasonable to you?
> > 
> > —Günther
> > 
> > -- 
> > Sent using Mutt 🐕 Woof Woof
