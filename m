Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA153704FBD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 May 2023 15:48:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233760AbjEPNsI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 May 2023 09:48:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232459AbjEPNsH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 May 2023 09:48:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90A11D2;
        Tue, 16 May 2023 06:48:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2B75F62BD9;
        Tue, 16 May 2023 13:48:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6029C433EF;
        Tue, 16 May 2023 13:48:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684244884;
        bh=U9IF6o91jh78GyimnXYwR8h6lHA9PmcW3q40d3nUe1A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bSLh0nGStVedLBbHUeN9WkXVwkbRcF0LALelVZ0mx+S8V95eNwDf7nKILbANoJRnO
         ITEOjDZHHXOSdutlropU7D+Vo7Lq0bZBnXHI7mrL+IogJnGN/bNw4ZA0U8iVhzfx7V
         zztin1Fi33ZK4cyqWel3mJqwKo+MNkqaLYMSEAVK7NS5CYiiX7/EN8TGGB6OEqZjVd
         Fv4L4KVzXjQqg+w4/pEnub6RR/SLPtV3MfBLjbU1SQa2HSaxQ9aN2rIhBR2gXBOYso
         5S04SWZf8MczbhtNDOzdilN1oCejJOZc7NeLl7hgNf21l7hj9flaWOdLzbwBhDcqpD
         OzhaVrDnwscuw==
Date:   Tue, 16 May 2023 15:47:59 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
        Linus Torvalds <torvalds@linuxfoundation.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        ptikhomirov@virtuozzo.com, Andrey Ryabinin <arbn@yandex-team.com>
Subject: Re: [PATCH] fs/coredump: open coredump file in O_WRONLY instead of
 O_RDWR
Message-ID: <20230516-blocken-modifikation-3c657d90a10b@brauner>
References: <CAHk-=wjex4GE-HXFNPzi+xE+w2hkZTQrACgAaScNdf-8hnMHKA@mail.gmail.com>
 <20230516-melancholisch-traten-3336ff6e9d30@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230516-melancholisch-traten-3336ff6e9d30@brauner>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 16, 2023 at 03:46:11PM +0200, Christian Brauner wrote:
> On Thu, 20 Apr 2023 15:04:09 +0300, Vladimir Sementsov-Ogievskiy wrote:
> > This makes it possible to make stricter apparmor profile and don't
> > allow the program to read any coredump in the system.
> > 
> > 
> 
> Applied to the vfs.misc branch of the vfs/vfs.git tree.
> Patches in the vfs.misc branch should appear in linux-next soon.
> 
> Please report any outstanding bugs that were missed during review in a
> new review to the original patch series allowing us to drop it.
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
> branch: vfs.misc
> 
> [1/1] fs/coredump: open coredump file in O_WRONLY instead of O_RDWR
>       https://git.kernel.org/vfs/vfs/c/f84566e710af

I updated the patch to include all the details we unearthed about this.
Linus, I added your SOB. It just made sense imho given that you provided
quite some details on this. Let me know if that bothers you. The patch
now is:

From f84566e710af39895e54d8e812cd47e5e53db671 Mon Sep 17 00:00:00 2001
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Date: Thu, 20 Apr 2023 15:04:09 +0300
Subject: coredump: require O_WRONLY instead of O_RDWR

The motivation for this patch has been to enable using a stricter
apparmor profile to prevent programs from reading any coredump in the
system.

However, this became something else. The following details are based on
Christian's and Linus' archeology into the history of the number "2" in
the coredump handling code.

To make sure we're not accidently introducing some subtle behavioral
change into the coredump code we set out on a voyage into the depths of
history.git to figure out why this was O_RDWR in the first place.

Coredump handling was introduced over 30 years ago in commit
ddc733f452e0 ("[PATCH] Linux-0.97 (August 1, 1992)").
The original code used O_WRONLY:

    open_namei("core",O_CREAT | O_WRONLY | O_TRUNC,0600,&inode,NULL)

However, this changed in 1993 and starting with commit
9cb9f18b5d26 ("[PATCH] Linux-0.99.10 (June 7, 1993)") the coredump code
suddenly used the constant "2":

    open_namei("core",O_CREAT | 2 | O_TRUNC,0600,&inode,NULL)

This was curious as in the same commit the kernel switched from
constants to proper defines in other places such as KERNEL_DS and
USER_DS and O_RDWR did already exist.

So why was "2" used? It turns out that open_namei() - an early version
of what later turned into filp_open() - didn't accept O_RDWR.

A semantic quirk of the open() uapi is the definition of the O_RDONLY
flag. It would seem natural to define:

    #define O_RDWR (O_RDONLY | O_WRONLY)

but that isn't possible because:

    #define O_RDONLY 0

This makes O_RDONLY effectively meaningless when passed to the kernel.
In other words, there has never been a way - until O_PATH at least - to
open a file without any permission; O_RDONLY was always implied on the
uapi side while the kernel does in fact allow opening files without
permissions.

The trouble comes when trying to map the uapi flags onto the
corresponding file mode flags FMODE_{READ,WRITE}. This mapping still
happens today and is causing issues to this day (We ran into this
during additions for openat2() for example.).

So the special value "3" was used to indicate that the file was opened
for special access:

    f->f_flags = flag = flags;
    f->f_mode = (flag+1) & O_ACCMODE;
    if (f->f_mode)
            flag++;

This allowed the file mode to be set to FMODE_READ | FMODE_WRITE mapping
the O_{RDONLY,WRONLY,RDWR} flags into the FMODE_{READ,WRITE} flags. The
special access then required read-write permissions and 0 was used to
access symlinks.

But back when ddc733f452e0 ("[PATCH] Linux-0.97 (August 1, 1992)") added
coredump handling open_namei() took the FMODE_{READ,WRITE} flags as an
argument. So the coredump handling introduced in
ddc733f452e0 ("[PATCH] Linux-0.97 (August 1, 1992)") was buggy because
O_WRONLY shouldn't have been passed. Since O_WRONLY is 1 but
open_namei() took FMODE_{READ,WRITE} it was passed FMODE_READ on
accident.

So 9cb9f18b5d26 ("[PATCH] Linux-0.99.10 (June 7, 1993)") was a bugfix
for this and the 2 didn't really mean O_RDWR, it meant FMODE_WRITE which
was correct.

The clue is that FMODE_{READ,WRITE} didn't exist yet and thus a raw "2"
value was passed.

Fast forward 5 years when around 2.2.4pre4 (February 16, 1999) this code
was changed to:

    -       dentry = open_namei(corefile,O_CREAT | 2 | O_TRUNC | O_NOFOLLOW, 0600);
    ...
    +       file = filp_open(corefile,O_CREAT | 2 | O_TRUNC | O_NOFOLLOW, 0600);

At this point the raw "2" should have become O_WRONLY again as
filp_open() didn't take FMODE_{READ,WRITE} but O_{RDONLY,WRONLY,RDWR}.

Another 17 years later, the code was changed again cementing the mistake
and making it almost impossible to detect when commit
378c6520e7d2 ("fs/coredump: prevent fsuid=0 dumps into user-controlled directories")
replaced the raw "2" with O_RDWR.

And now, here we are with this patch that sent us on a quest to answer
the big questions in life such as "Why are coredump files opened with
O_RDWR?" and "Is it safe to just use O_WRONLY?".

So with this commit we're reintroducing O_WRONLY again and bringing this
code back to its original state when it was first introduced in commit
ddc733f452e0 ("[PATCH] Linux-0.97 (August 1, 1992)") over 30 years ago.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Message-Id: <20230420120409.602576-1-vsementsov@yandex-team.ru>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/coredump.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index ece7badf701bc..ead3b05fb8f48 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -646,7 +646,7 @@ void do_coredump(const kernel_siginfo_t *siginfo)
 	} else {
 		struct mnt_idmap *idmap;
 		struct inode *inode;
-		int open_flags = O_CREAT | O_RDWR | O_NOFOLLOW |
+		int open_flags = O_CREAT | O_WRONLY | O_NOFOLLOW |
 				 O_LARGEFILE | O_EXCL;
 
 		if (cprm.limit < binfmt->min_coredump)
-- 
cgit 

