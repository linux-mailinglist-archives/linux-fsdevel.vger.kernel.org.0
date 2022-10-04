Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0476D5F4505
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Oct 2022 16:01:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbiJDOBV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Oct 2022 10:01:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbiJDOBT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Oct 2022 10:01:19 -0400
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D91BC5C9EF;
        Tue,  4 Oct 2022 07:01:18 -0700 (PDT)
Received: by mail-vs1-xe2c.google.com with SMTP id k6so14712812vsc.8;
        Tue, 04 Oct 2022 07:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=sHPpV+Zh8QwJD6mj7hOFzfKbEYUQmmrctOSQdfNcEmU=;
        b=G/EI6Xup1a9hw6DspSSgvkwobTfcXeFWqeJ+N+JM89AbEMjTNqR8FHAYxoUHzt5P0T
         Y0m6JcciaHnHfE87UPKY0eyEJlJrqkm0qAWsr5VkocYYxQFNHwrHxrF3lJRoPTrmjVJo
         A///oZ5g7qkAPSTJsEdQCvYuIi91VjpTS6EuLip8auNGTVlxmWDMgLRymaxXQ/t6EviU
         3w3dvVJgA/APYFWhFOn7ISC2h6Jy4K405BUEVF/xZaES0p+mOyCMUeRTKepGzigptXzH
         KZHTtkI0gckKT5PJEZz5sff/jsXnGZD9iixJkj9GBiyEczAGr1lcqrYdeak/DBxYWLFn
         UuhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=sHPpV+Zh8QwJD6mj7hOFzfKbEYUQmmrctOSQdfNcEmU=;
        b=AozyzXtuHymqLfllMM+STRtBxpopXKVS5D0Oy1bjgAewIPVH8aKR73RoVd9IElDHE3
         C5G7OEpTTRLqk/5fVtrbd/IYPjfLfsBvr/vnWNrBfvsZYp2pxCwhKjYvHO9HWsKbQPFP
         TZ79NL88aNmDUz8Uc0+E1cFGO5Ziq0TRSNly09TZjv7m9relH6WDoPxfE66HTqbyM5lA
         n+qpNLEGCUCG2M5XnDvwBcwiac3MzGoN7iCz0ctFstGGQllSUZxIIh1o65iRFsBB+yuw
         CGGrJ+ZD+PpcmjukBVjfIEr/SaKkR9M94jCe9WcXVu88h3mNp8gCJMlQgyF5yuQV5/x8
         099Q==
X-Gm-Message-State: ACrzQf1mTwvvAzY+uN7NvUBJN/ya0DVLBlSTEpF3pyzrMlPjm3lSEJj6
        Qmu/XAxc+SvatSE8XgTKtv4r6P9zWKpgtLDyzHk=
X-Google-Smtp-Source: AMsMyM7xYGsBMrj6Mji2B71bcpvHEmP/+D+DjL2bruJHeoOh7TtXefQdHFeKe7B3ax0V6hUOogl/azzt7DD+ZVW/ymM=
X-Received: by 2002:a67:df08:0:b0:3a6:cb22:8fe7 with SMTP id
 s8-20020a67df08000000b003a6cb228fe7mr411523vsk.71.1664892077864; Tue, 04 Oct
 2022 07:01:17 -0700 (PDT)
MIME-Version: 1.0
References: <20221003123040.900827-1-amir73il@gmail.com> <20221003123040.900827-3-amir73il@gmail.com>
 <20221004105932.bpvqstjrfpud5rcs@wittgenstein>
In-Reply-To: <20221004105932.bpvqstjrfpud5rcs@wittgenstein>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 4 Oct 2022 17:01:06 +0300
Message-ID: <CAOQ4uxgXYTdUoE5MpG-UzdZUtVYQ1FpjTHEc8FjEQAmgqj0hyQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] ovl: remove privs in ovl_fallocate()
To:     Christian Brauner <brauner@kernel.org>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Yang Xu <xuyang2018.jy@fujitsu.com>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Filipe Manana <fdmanana@kernel.org>,
        linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 4, 2022 at 1:59 PM Christian Brauner <brauner@kernel.org> wrote:
>
> On Mon, Oct 03, 2022 at 03:30:40PM +0300, Amir Goldstein wrote:
> > Underlying fs doesn't remove privs because fallocate is called with
> > privileged mounter credentials.
> >
> > This fixes some failure in fstests generic/683..687.
> >
> > Fixes: aab8848cee5e ("ovl: add ovl_fallocate()")
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > ---
> >  fs/overlayfs/file.c | 12 +++++++++++-
> >  1 file changed, 11 insertions(+), 1 deletion(-)
> >
> > diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
> > index c8308da8909a..e90ac5376456 100644
> > --- a/fs/overlayfs/file.c
> > +++ b/fs/overlayfs/file.c
> > @@ -517,9 +517,16 @@ static long ovl_fallocate(struct file *file, int mode, loff_t offset, loff_t len
> >       const struct cred *old_cred;
> >       int ret;
> >
> > +     inode_lock(inode);
> > +     /* Update mode */
> > +     ovl_copyattr(inode);
> > +     ret = file_remove_privs(file);
>
> First, thank you for picking this up!
>
> Let me analyze generic/683 failure of Test1 to see why you still see
> failures in this test:
>
> echo "Test 1 - qa_user, non-exec file $verb"
> setup_testfile
> chmod a+rws $junk_file
> commit_and_check "$qa_user" "$verb" 64k 64k
>
> So this creates a file with 6666 permissions. While the file has the
> S_ISUID and S_ISGID bits set it does not have the S_IXGRP set. This is
> important in a little bit.
>
> On a regular filesystem like xfs what will happen is:
>
> sys_fallocate()
> -> vfs_fallocate()
>    -> xfs_file_fallocate()
>       -> file_modified()
>          -> __file_remove_privs()
>             -> dentry_needs_remove_privs()
>                -> should_remove_suid()
>             -> __remove_privs()
>                newattrs.ia_valid = ATTR_FORCE | kill;
>                -> notify_change()
>
> In should_remove_suid() we can see that ATTR_KILL_SUID is raised
> unconditionally because the file in the test has S_ISUID set.
>
> But we also see that ATTR_KILL_SGID won't be set because while the file
> is S_ISGID it is not S_IXGRP (see above) which is a condition for
> ATTR_KILL_SGID being raised.
>
> So by the time we call notify_change() we have attr->ia_valid set to
> ATTR_KILL_SUID | ATTR_FORCE. Now notify_change() sees that
> ATTR_KILL_SUID is set and does:
>
> ia_valid = attr->ia_valid |= ATTR_MODE
> attr->ia_mode = (inode->i_mode & ~S_ISUID);
>
> which means that when we call setattr_copy() later we will definitely
> update inode->i_mode. Note that attr->ia_mode still contain S_ISGID.
>
> Now we call into the filesystem's ->setattr() inode operation which will end up
> calling setattr_copy(). Since ATTR_MODE is set we will hit:
>
> if (ia_valid & ATTR_MODE) {
>         umode_t mode = attr->ia_mode;
>         vfsgid_t vfsgid = i_gid_into_vfsgid(mnt_userns, inode);
>         if (!vfsgid_in_group_p(vfsgid) &&
>             !capable_wrt_inode_uidgid(mnt_userns, inode, CAP_FSETID))
>                 mode &= ~S_ISGID;
>         inode->i_mode = mode;
> }
>

Can you think of a reason why the above should not be done
in notify_change() before even calling to ->setattr()?

Although, it wouldn't help because ovl_setattr() does:

    if (attr->ia_valid & (ATTR_KILL_SUID|ATTR_KILL_SGID))
        attr->ia_valid &= ~ATTR_MODE;

> and since the caller in the test is neither capable nor in the group of the
> inode the S_ISGID bit is stripped.
>
> But now contrast this with overlayfs even after your changes. When
> ovl_setattr() is hit from ovl_fallocate()'s call to file_remove_privs()
> and calls ovl_do_notify_change() then we are doing this under the
> mounter's creds and so the S_ISGID bit is retained:
>
> sys_fallocate()
> -> vfs_fallocate()
>    -> ovl_fallocate()
>       -> file_remove_privs()
>          -> dentry_needs_remove_privs()
>             -> should_remove_suid()
>          -> __remove_privs()
>             newattrs.ia_valid = attr_force | kill;
>             -> notify_change()
>                -> ovl_setattr()
>                   // TAKE ON MOUNTER'S CREDS
>                   -> ovl_do_notify_change()
>                   // GIVE UP MOUNTER'S CREDS
>      // TAKE ON MOUNTER'S CREDS
>      -> vfs_fallocate()
>         -> xfs_file_fallocate()
>            -> file_modified()
>               -> __file_remove_privs()
>                  -> dentry_needs_remove_privs()
>                     -> should_remove_suid()
>                  -> __remove_privs()
>                     newattrs.ia_valid = attr_force | kill;
>                     -> notify_change()

The model in overlayfs is that security is checked twice
once on overlay inode with caller creds and once again
on xfs inode with mounter creds. Either of these checks
could result in clearing SUID/SGID bits.

In the call stack above, the outer should_remove_suid()
with caller creds sets ATTR_KILL_SUID and then the outer
notify_change() clears SUID and sets ATTR_MODE,
but ovl_setattr() clears ATTR_MODE and then the inner
notify_change() re-clears SUID and sets ATTR_MODE again.

If the outer notify_change() would have checked the in_group_p()
condition, clear SGID and set a flag ATTR_KILL_SGID_FORCE
then the inner notify_change() would see this flag and re-clear
SGID bit, just the same as it does with SUID bit in the stack stace
above.

Is this making any sense?

Thanks,
Amir.
