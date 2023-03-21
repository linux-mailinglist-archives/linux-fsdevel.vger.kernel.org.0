Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 962896C3B91
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Mar 2023 21:18:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbjCUUSZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Mar 2023 16:18:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbjCUUSX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Mar 2023 16:18:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54B7958B4D;
        Tue, 21 Mar 2023 13:17:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 95DD6B818D2;
        Tue, 21 Mar 2023 20:16:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCC08C433EF;
        Tue, 21 Mar 2023 20:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679429797;
        bh=EzK9nGN54zo6R9BW6b4rSDnoo1rTk6C7Ws1kToa1QBY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IIOmnE3apUoSmU9v4l4mmeLhiMqjmO6EFqJ9aFQOz2tvBVAgFtpkufyj/RHHNN+BW
         yqPNsv1OnrI/mCJuWNHf0iUxTfg9epz0eEt3xRUPP/DAvuuqovOEyK7jYsklZ6q//4
         0jhWftU6/LNI7fbHOdecxdDG9Uy6ZZ+1K3pb/TVhlNexG6bh1904ylXwxntQAjC5HM
         kM92BmhO48SiBhrLo8D5IP/mNA50YjhMUJXAcCFltOSEGnxUrFG0GeczY74G7SoOZS
         PyFVBmpTIJ5EWywDswLEcAnNHvIUAdzk/W8ugn2R5WKna7SnHwXIVUyN+UnAWQmamx
         VsY1JXB5D/Ocg==
Date:   Tue, 21 Mar 2023 21:16:32 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Pedro Falcato <pedro.falcato@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Aleksa Sarai <cyphar@cyphar.com>
Subject: Re: [PATCH] do_open(): Fix O_DIRECTORY | O_CREAT behavior
Message-ID: <20230321201632.o2wiz5gk7cz36rn3@wittgenstein>
References: <20230320071442.172228-1-pedro.falcato@gmail.com>
 <20230320115153.7n5cq4wl2hmcbndf@wittgenstein>
 <CAHk-=wjifBVf3ub0WWBXYg7JAao6V8coCdouseaButR0gi5xmg@mail.gmail.com>
 <CAKbZUD2Y2F=3+jf+0dRvenNKk=SsYPxKwLuPty_5-ppBPsoUeQ@mail.gmail.com>
 <CAHk-=wgc9qYOtuyW_Tik0AqMrQJK00n-LKWvcBifLyNFUdohDw@mail.gmail.com>
 <20230321142413.6mlowi5u6ewecodx@wittgenstein>
 <20230321161736.njmtnkvjf5rf7x5p@wittgenstein>
 <CAHk-=wi2mLKn6U7_aXMtP46TVSY6MTHv+ff-+xVFJbO914o65A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=wi2mLKn6U7_aXMtP46TVSY6MTHv+ff-+xVFJbO914o65A@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 21, 2023 at 10:35:47AM -0700, Linus Torvalds wrote:
> On Tue, Mar 21, 2023 at 9:17 AM Christian Brauner <brauner@kernel.org> wrote:
> >
> >  #define WILL_CREATE(flags)     (flags & (O_CREAT | __O_TMPFILE))
> > +#define INVALID_CREATE(flags) \
> > +       ((flags & (O_DIRECTORY | O_CREAT)) == (O_DIRECTORY | O_CREAT))
> >  #define O_PATH_FLAGS           (O_DIRECTORY | O_NOFOLLOW | O_PATH | O_CLOEXEC)
> >
> >  inline struct open_how build_open_how(int flags, umode_t mode)
> > @@ -1207,6 +1209,10 @@ inline int build_open_flags(const struct open_how *how, struct open_flags *op)
> >                 if (!(acc_mode & MAY_WRITE))
> >                         return -EINVAL;
> >         }
> > +
> > +       if (INVALID_CREATE(flags))
> > +               return -EINVAL;
> > +
> >         if (flags & O_PATH) {
> >                 /* O_PATH only permits certain other flags to be set. */
> >                 if (flags & ~O_PATH_FLAGS)
> 
> So the patch looks simple enough, but
> 
>  (a) I'm not entirely sure I like the extra indirection through
> another #define. This impenetrable thicket of different macros makes
> it a bit hard to see what is going on. I'm not blaming you for it, it
> predates this patch, but..
> 
>  (b) this seems to make that O_TMPFILE_MASK macro pointless.

So I tried to justify this in the commit message but it might've gotten lost in
there. My thinking had been:

    With this patch, we categorically reject O_DIRECTORY | O_CREAT and
    return EINVAL. That means, we could write this in a way that makes the
    if ((flags & O_TMPFILE_MASK) != O_TMPFILE) check superfluous but let's
    not do that. The check documents the peculiar aspects of O_TMPFILE quite
    nicely and can serve as a reminder how easy it is to break.

But I'm not married to keeping it and it could be misleading.

> 
> I think (b) kind of re-inforces the point of (a) here.
> 
> The only reason for O_TMPFILE_MASK is literally that old historical
> "make sure old kernels return errors when they don't support
> O_TEMPFILE", and thus the magic re-use of old bit patterns.
> 
> But now that we do that "return error if both O_DIRECTORY and O_CREAT
> are set", the O_TMPFILE_MASK check is basically dead, because it ends
> up checking for that same bit pattern except also __O_TMPFILE.

Yes.

> 
> And that is *not* obvious from the code, exactly because of that
> thicket of different macros.
> 
> In fact, since that whole
> 
>         if ((flags & O_TMPFILE_MASK) != O_TMPFILE)
>                 return -EINVAL;
> 
> is done inside an "if (flags & __O_TMPFILE)", the compiler might as
> well reduce it *exactly* down to that exact same test as
> INVALID_CREATE() now is.
> 
> So I really get the feeling that the macros actually hide what is
> going on, and are the exact opposite of being helpful. Case in point:
> with your patch, you now have the exact same test twice in a row,
> except it *looks* like two different tests and one of them is
> conditional on __O_TMPFILE.

Yeah, see above why I did that originally.

> 
> For all I know, the compiler may actually notice the redundancy and
> remove one of them, but we shouldn't write bad code with the
> expectation that "the compiler will fix it up". Particularly when it
> just makes it harder for people to understand too.

But yes, that is a valid complaint so - without having tested - sm like:

diff --git a/fs/open.c b/fs/open.c
index 4401a73d4032..3c5227d84cfe 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -1195,6 +1195,13 @@ inline int build_open_flags(const struct open_how *how, struct open_flags *op)
                op->mode = 0;
        }

+       /*
+        * Block nonsensical creation requests and ensure that O_CREAT isn't
+        * slipped alongside O_TMPFILE which relies on O_DIRECTORY.
+        */
+       if ((flags & (O_DIRECTORY | O_CREAT)) == (O_DIRECTORY | O_CREAT))
+               return -EINVAL;
+
        /*
         * In order to ensure programs get explicit errors when trying to use
         * O_TMPFILE on old kernels, O_TMPFILE is implemented such that it
@@ -1202,7 +1209,7 @@ inline int build_open_flags(const struct open_how *how, struct open_flags *op)
         * have to require userspace to explicitly set it.
         */
        if (flags & __O_TMPFILE) {
-               if ((flags & O_TMPFILE_MASK) != O_TMPFILE)
+               if ((flags & O_TMPFILE) != O_TMPFILE)
                        return -EINVAL;
                if (!(acc_mode & MAY_WRITE))
                        return -EINVAL;
diff --git a/include/uapi/asm-generic/fcntl.h b/include/uapi/asm-generic/fcntl.h
index 1ecdb911add8..80f37a0d40d7 100644
--- a/include/uapi/asm-generic/fcntl.h
+++ b/include/uapi/asm-generic/fcntl.h
@@ -91,7 +91,6 @@

 /* a horrid kludge trying to make sure that this will fail on old kernels */
 #define O_TMPFILE (__O_TMPFILE | O_DIRECTORY)
-#define O_TMPFILE_MASK (__O_TMPFILE | O_DIRECTORY | O_CREAT)

 #ifndef O_NDELAY
 #define O_NDELAY       O_NONBLOCK
diff --git a/tools/include/uapi/asm-generic/fcntl.h b/tools/include/uapi/asm-generic/fcntl.h
index b02c8e0f4057..1c7a0f6632c0 100644
--- a/tools/include/uapi/asm-generic/fcntl.h
+++ b/tools/include/uapi/asm-generic/fcntl.h
@@ -91,7 +91,6 @@

 /* a horrid kludge trying to make sure that this will fail on old kernels */
 #define O_TMPFILE (__O_TMPFILE | O_DIRECTORY)
-#define O_TMPFILE_MASK (__O_TMPFILE | O_DIRECTORY | O_CREAT)

 #ifndef O_NDELAY
 #define O_NDELAY       O_NONBLOCK
--
2.34.1

