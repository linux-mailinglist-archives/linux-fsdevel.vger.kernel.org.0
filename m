Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FCDE55F59D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jun 2022 07:17:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbiF2FPf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Jun 2022 01:15:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbiF2FPf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Jun 2022 01:15:35 -0400
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ADE030566;
        Tue, 28 Jun 2022 22:15:33 -0700 (PDT)
Received: by mail-vs1-xe2c.google.com with SMTP id o13so14071275vsn.4;
        Tue, 28 Jun 2022 22:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zjkjIkj9ZiSRACS0jsL7ordUSEz8lIKXMdA+/FnCisI=;
        b=JcnQtrWpIZXYoSUD3UrPjOwANquc6AsLrcIv7rKY+7RMZSeLYR1JSvkmc1dlUV2Iww
         l/spIxA3dbMuMWgqIEdtV0fby5aNBZQB8iqEwVeERDzV9URsKM915sqhAPMsfTPLD9Vs
         +VHhTsM6g2PvJ1lotU3Zvh3hN1yBdQ2LsaeCs191VhtU/NJxh9OrH7/JTlm/17Rr0iYs
         pLo2vHzhSVXEclBTn7XGWcvWznU5snFUW1Altc3FqZelEGgNM5osaWOFjSHLb4ZPSPst
         jzWH59CBLh4wZG5G47c1Hl88J/npM+DmvrxXxv+WW630Swxx7dS0rBZooQ2o25nreIp2
         ap9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zjkjIkj9ZiSRACS0jsL7ordUSEz8lIKXMdA+/FnCisI=;
        b=nfXr76EeZa+O+ABlhXxhfVFFIY38hsT7nxgDwIIfuhXdMYcj/xfOdzQAq+VVdrbIqZ
         +aamSTKFFZRA8xTzQLUPz9d7acyLFk3MJzB0GOmoBaGo0u5Nl6Ybh9dg53TxkzaF+/vY
         6Vbe3yoBW29iHfbQ+b3EI85P2VAgFTLkKWiH6twVNU9js7qJJYBmU3X/ht6ry8UbE8ti
         PPP3wHhx4QN3SqxT8Smb4ONEplKMgAMf7r4K/gK71qdzU8Oa2fVyFPZc5qScA1B75bwM
         ztytUDLXsobDDUczSMR2mbfFWIhA0x4fn/O9Z+nbx9Bj1m2plMEjIDSW2gFrNfCsAgiM
         rosw==
X-Gm-Message-State: AJIora9ES4ywbwHe+ayZBUDZn2yRhB0jrlmBVosREOUXSOjjEcdtHu91
        MTuwuNUfvqluJJtetvMJcqfp+Dy/SCH/i88fbv8=
X-Google-Smtp-Source: AGRyM1vb2QbAzUKziQm50a3/lamxeOP3Uhr8uToiNPGO1yqXLKlYqOfmD+5Asd1+r0SV44z2cM9JyAyaq5v6Rlcvcyc=
X-Received: by 2002:a05:6102:5dc:b0:354:63f1:df8d with SMTP id
 v28-20020a05610205dc00b0035463f1df8dmr3385291vsf.72.1656479732495; Tue, 28
 Jun 2022 22:15:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220627221107.176495-1-james@openvpn.net> <CAOQ4uxi5mKd1OuAcdFemx=h+1Ay-Ka4F6ddO5_fjk7m6G88MuQ@mail.gmail.com>
 <3062694c-8725-3653-a8e6-de2942aed1c2@openvpn.net>
In-Reply-To: <3062694c-8725-3653-a8e6-de2942aed1c2@openvpn.net>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 29 Jun 2022 08:15:20 +0300
Message-ID: <CAOQ4uxjfZ=c4Orm2VcbsOuqEkdsXViZhxLN55CN5-5ZtSqj4Sg@mail.gmail.com>
Subject: Re: [PATCH] namei: implemented RENAME_NEWER flag for renameat2()
 conditional replace
To:     James Yonan <james@openvpn.net>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 29, 2022 at 12:56 AM James Yonan <james@openvpn.net> wrote:
>
> On 6/28/22 03:46, Amir Goldstein wrote:
> > [+linux-api]
> >
> > On Tue, Jun 28, 2022 at 1:58 AM James Yonan <james@openvpn.net> wrote:
> >> RENAME_NEWER is a new userspace-visible flag for renameat2(), and
> >> stands alongside existing flags such as RENAME_NOREPLACE,
> >> RENAME_EXCHANGE, and RENAME_WHITEOUT.
> >>
> >> RENAME_NEWER is a conditional variation on RENAME_NOREPLACE, and
> >> indicates that if the target of the rename exists, the rename will
> >> only succeed if the source file is newer than the target (i.e. source
> >> mtime > target mtime).  Otherwise, the rename will fail with -EEXIST
> >> instead of replacing the target.  When the target doesn't exist,
> >> RENAME_NEWER does a plain rename like RENAME_NOREPLACE.
> >>
> >> RENAME_NEWER is very useful in distributed systems that mirror a
> >> directory structure, or use a directory as a key/value store, and need
> >> to guarantee that files will only be overwritten by newer files, and
> >> that all updates are atomic.
> > This feature sounds very cool.
> > For adding a new API it is always useful if you bring forward a userland
> > tool (rsync?) that intend to use it, preferably with a POC patch.
> > A concrete prospective user is always better than a hypothetical one.
> > Some people hold the opinion that only new APIs with real prospective
> > users should be merged.
>
> Not sure that rsync would be the canonical user, though it might be a
> reasonable POC.  The problem that we are solving is essentially
> near-real-time directory mirroring or replication of one source
> directory to many target directories on follower nodes.  Many writers,
> many readers, filesystem-based, strong guarantees of eventual
> convergence, infinitely scalable.  You have a source directory that
> could be an AWS S3 bucket.  You have potentially thousands of follower
> nodes that want to replicate the source directory on a local
> filesystem.  You have messages flying around the network (Kafka, AWS
> SQS, etc.) representing file updates.  These messages might be reordered
> or duplicated but each contains the file content and a unique
> nanosecond-scale timestamp.  Because the file update throughput can be
> in the thousands of files per second, you might have multiple threads on
> each node, receiving updates, and moving them into the target
> directory.  The only way to guarantee that the state of the mirror
> target directory on all nodes converges to the state of the source
> directory is to have the last-step move operation be atomic and
> conditional to the modification time (so that an earlier version of the
> file doesn't overwrite a later version).
>
> So I understand that there needs to be a strong case to extend the Linux
> API, and I think the argument is that conditional atomic file operations
> enable entirely new classes of applications.  The fact that this can be

Sure it does, but is the condition that you propose going to serve all
the prospect applications or just your application?
You may add to your arguments in favor of mtime that 'mv --update'
and 'rsync --update' could use the new flag.

> facilitated by essentially 5 lines of kernel code is remarkable.
>
> >
> >> While this patch may appear large at first glance, most of the changes
> >> deal with renameat2() flags validation, and the core logic is only
> >> 5 lines in the do_renameat2() function in fs/namei.c:
> >>
> >>          if ((flags & RENAME_NEWER)
> >>              && d_is_positive(new_dentry)
> >>              && timespec64_compare(&d_backing_inode(old_dentry)->i_mtime,
> >>                                    &d_backing_inode(new_dentry)->i_mtime) <= 0)
> >>                  goto exit5;
> >>
> > I have a few questions:
> > - Why mtime?
> > - Why not ctime?
> > - Shouldn't a feature like that protect from overwriting metadata changes
> >    to the destination file?
> >
> > In any case, I would be much more comfortable with comparing ctime
> > because when it comes to user settable times, what if rsync *wants*
> > to update the destination file's mtime to an earlier time that was set in
> > the rsync source?
> >
> > If comparing ctime does not fit your use case and you can convince
> > the community that comparing mtime is a justified use case, we would
> > need to use a flag name to reflect that like RENAME_NEWER_MTIME
> > so we don't block future use case of RENAME_NEWER_CTIME.
> > I hope that we can agree that ctime is enough and that mtime will not
> > make sense so we can settle with RENAME_NEWER that means ctime.
>
> So I actually think that mtime is the better timestamp to use because
> ctime is modified by the rename operation itself, while mtime measures
> the last modification time of the file content, which is what we care about.

That is fine. I am saying there are other use cases that replicate not
only data, but metadata too. Even Cloud files have metadata attached,
so one day, someone else may want to compare ctime, which makes
the work NEWER ambiguous and you need to disambiguate it with
something like RENAME_EXCHANGE_NEWER_MTIME.

>
> >
> >> It's pretty cool in a way that a new atomic file operation can even be
> >> implemented in just 5 lines of code, and it's thanks to the existing
> >> locking infrastructure around file rename/move that these operations
> >> become almost trivial.  Unfortunately, every fs must approve a new
> >> renameat2() flag, so it bloats the patch a bit.
> >>
> >> So one question to ask is could this functionality be implemented
> >> in userspace without adding a new renameat2() flag?  I think you
> >> could attempt it with iterative RENAME_EXCHANGE, but it's hackish,
> >> inefficient, and not atomic, because races could cause temporary
> >> mtime backtracks.  How about using file locking?  Probably not,
> >> because the problem we want to solve is maintaining file/directory
> >> atomicity for readers by creating files out-of-directory, setting
> >> their mtime, and atomically moving them into place.  The strategy
> >> to lock such an operation really requires more complex locking methods
> >> than are generally exposed to userspace.  And if you are using inotify
> >> on the directory to notify readers of changes, it certainly makes
> >> sense to reduce unnecessary churn by preventing a move operation
> >> based on the mtime check.
> >>
> >> While some people might question the utility of adding features to
> >> filesystems to make them more like databases, there is real value
> >> in the performance, atomicity, consistent VFS interface, multi-thread
> >> safety, and async-notify capabilities of modern filesystems that
> >> starts to blur the line, and actually make filesystem-based key-value
> >> stores a win for many applications.
> >>
> >> Like RENAME_NOREPLACE, the RENAME_NEWER implementation lives in
> >> the VFS, however the individual fs implementations do strict flags
> >> checking and will return -EINVAL for any flag they don't recognize.
> >> For this reason, my general approach with flags is to accept
> >> RENAME_NEWER wherever RENAME_NOREPLACE is also accepted, since
> >> RENAME_NEWER is simply a conditional variant of RENAME_NOREPLACE.
> > You are not taking into account that mtime may be cached attribute that is not
> > uptodate in network filesystems (fuse too) so behavior can be a bit
> > unpredictable,
> > unless filesystem code compares also the cache coherency of the attributes
> > on both files and even then, without extending the network protocol this is
> > questionable behavior for client side.
> > So I think your filter of which filesystems to enable is way too wide.
>
> So I'm new to the filesystem code, but my reading of do_renameat2() in
> fs/namei.c seems to indicate that if d_is_positive(dentry) is true, it's
> safe to access the inode struct via d_backing_inode(dentry) and
> dereference mtime.  But what you're saying is that the mtime value
> cached in the inode struct might not be up-to-date for network filesystems?
>

In the client's cache A may be newer than B, while on the server B is actually
newer, but that doesn't matter because...


> >
> > How many of them did you test, I'll take a wild guess that not all of them.
> >
> > Please do not enable RENAME_NEWER is any filesystem that you did
> > not test or that was not tested by some other fs developer using the
> > tests that you write.
>
> So I'm mostly interested in implementing this on local filesystems,

... so don't add the functionality to filesystems that you don't need to add to
and you do not test.

LTP all_filesystems will give you coverage for all the local fs that you should
care about. Other fs could add support for the new flag themselves if the
developers care and test it - that's not your job when adding a new API.

> because the application layer has already done the heavy lifting on the
> networking side so that the filesystem layer can be local, fast, and
> atomic.  So yes, I haven't tested this yet on networked filesystems.
> But I'm thinking that because all functionality is implemented at the
> VFS layer, it should be portable to any fs that also supports
> RENAME_NOREPLACE, with the caveat that it depends on the ability of the
> VFS to get a current and accurate mtime attribute inside the critical
> section between lock_rename() and unlock_rename().
>

The implementation is generic. You just implement the logic in the vfs and
enable it for a few tested filesystems and whoever wants to join the party
is welcome to test their own filesystems and opt-in to the new flag whether
they like. Nothing wrong with that.

w.r.t stability of i_mtime, if I am not mistaken i_mtime itself is
stable with inode
lock held (i.e. after lock_two_nondirectories()), however, as Dave pointed out,
the file's data can be modified in page cache, so as long as the file is open
for write or mmaped writable, the check of mtime is not atomic.

Neil's suggestion to deny the operation on open files makes sense.
You can use a variant of deny_write_access() that takes inode
which implies the error  ETXTBSY for an attempt to exchange newer
with a file that is open for write.

Thanks,
Amir.
