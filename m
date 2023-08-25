Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31D70788D6E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Aug 2023 18:51:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344097AbjHYQvA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Aug 2023 12:51:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344092AbjHYQuj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Aug 2023 12:50:39 -0400
Received: from smtp-1908.mail.infomaniak.ch (smtp-1908.mail.infomaniak.ch [IPv6:2001:1600:4:17::1908])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1988410FF
        for <linux-fsdevel@vger.kernel.org>; Fri, 25 Aug 2023 09:50:36 -0700 (PDT)
Received: from smtp-2-0001.mail.infomaniak.ch (unknown [10.5.36.108])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4RXQtc2LsKzMqK2c;
        Fri, 25 Aug 2023 16:50:32 +0000 (UTC)
Received: from unknown by smtp-2-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4RXQtb2yBNzMppKV;
        Fri, 25 Aug 2023 18:50:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1692982232;
        bh=ty3KgYsAGxESWC3Qi9bFtJm/mBxgxRw/J28jeMzy6uc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zvNu/m1PWu9GvmDN9h0erpJ4q2g+KerXW5JgFmR1jT2el7bOkIOwHIYHKiJ1c1RHP
         TpTYfZ13eblr2dSaWLteBN/MxGOQ6pX1DatMg66daTtKxYgvUfnrdPaiyL0nUOeHdN
         m4iofPeCdYzi9PIMkPri18FF9q+5RKA7kS+LNzYc=
Date:   Fri, 25 Aug 2023 18:50:28 +0200
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
Message-ID: <20230825.Zoo4ohn1aivo@digikod.net>
References: <20230814172816.3907299-1-gnoack@google.com>
 <20230818.iechoCh0eew0@digikod.net>
 <ZOjCz5j4+tgptF53@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZOjCz5j4+tgptF53@google.com>
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

On Fri, Aug 25, 2023 at 05:03:43PM +0200, Günther Noack wrote:
> Hi!
> 
> On Fri, Aug 18, 2023 at 03:39:19PM +0200, Mickaël Salaün wrote:
> > On Mon, Aug 14, 2023 at 07:28:11PM +0200, Günther Noack wrote:
> > > These patches add simple ioctl(2) support to Landlock.
> > 
> > [...]
> > 
> > > How we arrived at the list of always-permitted IOCTL commands
> > > ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > 
> > > To decide which IOCTL commands should be blanket-permitted I went through the
> > > list of IOCTL commands mentioned in fs/ioctl.c and looked at them individually
> > > to understand what they are about.  The following list is my conclusion from
> > > that.
> > > 
> > > We should always allow the following IOCTL commands:
> > > 
> > >  * FIOCLEX, FIONCLEX - these work on the file descriptor and manipulate the
> > >    close-on-exec flag
> > >  * FIONBIO, FIOASYNC - these work on the struct file and enable nonblocking-IO
> > >    and async flags
> > >  * FIONREAD - get the number of bytes available for reading (the implementation
> > >    is defined per file type)
> > 
> > I think we should treat FIOQSIZE like FIONREAD, i.e. check for
> > LANDLOCK_ACCESS_FS_READ_FILE as explain in my previous message.
> > Tests should then rely on something else.
> 
> OK, I rewrote the tests to use FS_IOC_GETFLAGS.
> 
> Some thoughts on these two IOCTLs:
> 
> FIONREAD gives the number of bytes that are ready to read.  This IOCTL seems
> only useful when the file is open for reading.  However, do you think that we
> should correlate this with (a) LANDLOCK_ACCESS_FS_READ_FILE, or with (b)
> f->f_mode & FMODE_READ?  (The difference is that in case (a), FIONREAD will work
> if you open a file O_WRONLY and you also have the LANDLOCK_ACCESS_FS_READ_FILE
> right for that file.  In case (b), it would only work if you also opened the
> file for reading.)

I think we should allow FIONREAD if LANDLOCK_ACCESS_FS_IOCTL is handled
and if LANDLOCK_ACCESS_FS_READ_FILE is explicitly allowed for this FD.

f->f_mode & FMODE_READ would make sense but it should have been handled
by the kernel; Landlock should not try to fix this inconsistency.

These are good test cases though.

It should be noted that SELinux considers FIONREAD as tied to metadata
reading (FILE__GETATTR). It think it makes more sense to tie it to the
read right (LANDLOCK_ACCESS_FS_READ_FILE) because it might be
(legitimately) required to properly read a file and FIONREAD is tied to
the content of a file, not file attributes.

> 
> FIOQSIZE seems like it would be useful for both reading *and* writing? -- The
> reading case is obvious, but for writers it's also useful if you want to seek
> around in the file, and make sure that the position that you seek to already
> exists.  (I'm not sure whether that use case is relevant in practical
> applications though.) -- Why would FIOQSIZE only be useful for readers?

Good point! The use case you define for writing is interesting. However,
would it make sense to seek at a specific offset without being able to
know/read the content? I guest not in theory, but in practice we might
want to avoid application to require LANDLOCK_ACCESS_FS_READ_FILE is
they only require to write (at a specific offset), or to deal with write
errors. Anyway, I guess that this information can be inferred by trying
to seek at a specific offset.  The only limitation that this approach
would bring is that it seems that we can seek into an FD even without
read nor write right, and there is no specific (LSM) access control for
this operation (and nobody seems to care about being able to read the
size of a symlink once opened). If this is correct, I think we should
indeed always allow FIOQSIZE. Being able to open a file requires
LANDLOCK_ACCESS_FS_READ or WRITE anyway.  It would be interesting to
check and test with O_PATH though.

> 
> (In fact, it seems to me almost like FIOQSIZE might rather be missing a security
> hook check for one of the "getting file attribute" hooks?)
> 
> So basically, the implementation that I currently ended up with is:
> 

Before checking these commands, we first need to check that the original
domain handle LANDLOCK_ACCESS_FS_IOCTL. We should try to pack this new
bit and replace the file's allowed_access field (see
landlock_add_fs_access_mask() and similar helpers in the network patch
series that does a similar thing but for ruleset's handle access
rights), but here is the idea:

if (!landlock_file_handles_ioctl(file))
	return 0;

> switch (cmd) {
	/*
	 * Allows file descriptor and file description operations (see
	 * fcntl commands).
	 */
>   case FIOCLEX:
>   case FIONCLEX:
>   case FIONBIO:
>   case FIOASYNC:

>   case FIOQSIZE:
>     return 0;
>   case FIONREAD:
>     if (file->f_mode & FMODE_READ)

We should check LANDLOCK_ACCESS_FS_READ instead, which is a superset of
FMODE_READ.

>       return 0;
> }
> 
> (with some comments in the source code, of course...)
> 
> Does that look reasonable to you?
> 
> —Günther
> 
> -- 
> Sent using Mutt 🐕 Woof Woof
