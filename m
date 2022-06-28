Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17AA055C464
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jun 2022 14:49:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344277AbiF1JqU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jun 2022 05:46:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239715AbiF1JqS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jun 2022 05:46:18 -0400
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A1C425C40;
        Tue, 28 Jun 2022 02:46:16 -0700 (PDT)
Received: by mail-vs1-xe36.google.com with SMTP id h7so11463391vsr.11;
        Tue, 28 Jun 2022 02:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4IgmKFK3VH3ZvhQpGkiK4UZuGvz2r1H33d2pbMqIFIM=;
        b=dE+HO5eyQ2DVkH8o5Odc11ewZe0kVcaJpAJfPbSitcs+KbVdwOmS+NguxQUv6brvwk
         OhltC8uyO6l7Wo1O3lUYcaIGt1SqPgkoAhOm6XAUL2xSTB9CofvjPkk1tDTE/6oYz0ip
         ZpVUgJmF800FagfJ6lNqURHBJ7p6JrPD+do/nb2vQqJoSpUCDB+RZub2B7RapHz/QqTh
         0Z+GCpWJifK43SCKMA5A/lbnwfvDkEz1icavAojxrm4Rmdh/n8+92tAl9N1i13TMpFog
         fbNeFV1O9ALO/BYOBtUJSjdr7weN8vK4T+F+6A+0LU0W5xMiQhPSym3ug2vmMiHhCyiS
         GC8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4IgmKFK3VH3ZvhQpGkiK4UZuGvz2r1H33d2pbMqIFIM=;
        b=sIW1HEZIOwzHAwpz+0xam3XEwt1k2/JEtc8/dJS1TR6EPQ2ykCaf9lu/za1yJrfYsa
         UEt9etCAyXppEi1Ow59v7e+RqOT/gLb+EMFW+LQjiCydXRS9DPfUzd6W5Xfwr/5sTijU
         /pujAHzMMfayonc03GRpiAhNjW0w48DXaHubCxfOg3vHMZn+sW+NyrRbRpfNSRZhiCzc
         6AaIW4Wzt4fcxnpC63yi/31kxXs0uuHwagAYhL+bOpO0EGqsmkRJBggdxlADXciGnmoy
         pdRuiz/OEINGBdAwZoWTpfTs/hfLPMxiTpHCyb2O47H6zd98D6m0RF+Hfc9MELyxiEAr
         tM6A==
X-Gm-Message-State: AJIora/7yZ/glBq52lvuQwIksOum1XGPvk3f90AOyi5YZiLxJTYh05zT
        Qy69th+1sbMw3Wvwu/rqIr8f2/ca9QUB1x3ZdGxWYgVmAoTD+w==
X-Google-Smtp-Source: AGRyM1vIFfKWcPZJpPIA869u+QCeQi8g23T6Hb67ZpPjmZ0bxjSQ/Bg5NOGmNaUnNvHtqU+OLAd2jQ0f3PD4UPofUYU=
X-Received: by 2002:a05:6102:34e5:b0:354:5832:5ce8 with SMTP id
 bi5-20020a05610234e500b0035458325ce8mr912476vsb.36.1656409575538; Tue, 28 Jun
 2022 02:46:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220627221107.176495-1-james@openvpn.net>
In-Reply-To: <20220627221107.176495-1-james@openvpn.net>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 28 Jun 2022 12:46:04 +0300
Message-ID: <CAOQ4uxi5mKd1OuAcdFemx=h+1Ay-Ka4F6ddO5_fjk7m6G88MuQ@mail.gmail.com>
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

[+linux-api]

On Tue, Jun 28, 2022 at 1:58 AM James Yonan <james@openvpn.net> wrote:
>
> RENAME_NEWER is a new userspace-visible flag for renameat2(), and
> stands alongside existing flags such as RENAME_NOREPLACE,
> RENAME_EXCHANGE, and RENAME_WHITEOUT.
>
> RENAME_NEWER is a conditional variation on RENAME_NOREPLACE, and
> indicates that if the target of the rename exists, the rename will
> only succeed if the source file is newer than the target (i.e. source
> mtime > target mtime).  Otherwise, the rename will fail with -EEXIST
> instead of replacing the target.  When the target doesn't exist,
> RENAME_NEWER does a plain rename like RENAME_NOREPLACE.
>
> RENAME_NEWER is very useful in distributed systems that mirror a
> directory structure, or use a directory as a key/value store, and need
> to guarantee that files will only be overwritten by newer files, and
> that all updates are atomic.

This feature sounds very cool.
For adding a new API it is always useful if you bring forward a userland
tool (rsync?) that intend to use it, preferably with a POC patch.
A concrete prospective user is always better than a hypothetical one.
Some people hold the opinion that only new APIs with real prospective
users should be merged.

>
> While this patch may appear large at first glance, most of the changes
> deal with renameat2() flags validation, and the core logic is only
> 5 lines in the do_renameat2() function in fs/namei.c:
>
>         if ((flags & RENAME_NEWER)
>             && d_is_positive(new_dentry)
>             && timespec64_compare(&d_backing_inode(old_dentry)->i_mtime,
>                                   &d_backing_inode(new_dentry)->i_mtime) <= 0)
>                 goto exit5;
>

I have a few questions:
- Why mtime?
- Why not ctime?
- Shouldn't a feature like that protect from overwriting metadata changes
  to the destination file?

In any case, I would be much more comfortable with comparing ctime
because when it comes to user settable times, what if rsync *wants*
to update the destination file's mtime to an earlier time that was set in
the rsync source?

If comparing ctime does not fit your use case and you can convince
the community that comparing mtime is a justified use case, we would
need to use a flag name to reflect that like RENAME_NEWER_MTIME
so we don't block future use case of RENAME_NEWER_CTIME.
I hope that we can agree that ctime is enough and that mtime will not
make sense so we can settle with RENAME_NEWER that means ctime.

> It's pretty cool in a way that a new atomic file operation can even be
> implemented in just 5 lines of code, and it's thanks to the existing
> locking infrastructure around file rename/move that these operations
> become almost trivial.  Unfortunately, every fs must approve a new
> renameat2() flag, so it bloats the patch a bit.
>
> So one question to ask is could this functionality be implemented
> in userspace without adding a new renameat2() flag?  I think you
> could attempt it with iterative RENAME_EXCHANGE, but it's hackish,
> inefficient, and not atomic, because races could cause temporary
> mtime backtracks.  How about using file locking?  Probably not,
> because the problem we want to solve is maintaining file/directory
> atomicity for readers by creating files out-of-directory, setting
> their mtime, and atomically moving them into place.  The strategy
> to lock such an operation really requires more complex locking methods
> than are generally exposed to userspace.  And if you are using inotify
> on the directory to notify readers of changes, it certainly makes
> sense to reduce unnecessary churn by preventing a move operation
> based on the mtime check.
>
> While some people might question the utility of adding features to
> filesystems to make them more like databases, there is real value
> in the performance, atomicity, consistent VFS interface, multi-thread
> safety, and async-notify capabilities of modern filesystems that
> starts to blur the line, and actually make filesystem-based key-value
> stores a win for many applications.
>
> Like RENAME_NOREPLACE, the RENAME_NEWER implementation lives in
> the VFS, however the individual fs implementations do strict flags
> checking and will return -EINVAL for any flag they don't recognize.
> For this reason, my general approach with flags is to accept
> RENAME_NEWER wherever RENAME_NOREPLACE is also accepted, since
> RENAME_NEWER is simply a conditional variant of RENAME_NOREPLACE.

You are not taking into account that mtime may be cached attribute that is not
uptodate in network filesystems (fuse too) so behavior can be a bit
unpredictable,
unless filesystem code compares also the cache coherency of the attributes
on both files and even then, without extending the network protocol this is
questionable behavior for client side.
So I think your filter of which filesystems to enable is way too wide.

How many of them did you test, I'll take a wild guess that not all of them.

Please do not enable RENAME_NEWER is any filesystem that you did
not test or that was not tested by some other fs developer using the
tests that you write.

>
> I noticed only one fs driver (cifs) that treated RENAME_NOREPLACE
> in a non-generic way, because no-replace is the natural behavior
> for CIFS, and it therefore considers RENAME_NOREPLACE as a hint that
> no replacement can occur.  Aside from this special case, it seems
> safe to assume that any fs that supports RENAME_NOREPLACE should
> also be able to support RENAME_NEWER out of the box.
>
> I did not notice a general self-test for renameat2() at the VFS
> layer (outside of fs-specific tests), so I created one, though
> at the moment it only exercises RENAME_NEWER.  Build and run with:
>
>   make -C tools/testing/selftests TARGETS=renameat2 run_tests

Please make sure to also add test coverage in fstests and/or LTP.
See fstest generic/024 for RENAME_NOREPLACE and LTP test
renameat201 as examples.
renameat201 can and should be converted to newlib and run with
.all_filesystems = 1.
This is the easiest and fastest way for you to verify your patch
on the common fs that are installed on your system.
LTP maintainers can help you with that.

Thanks,
Amir.
