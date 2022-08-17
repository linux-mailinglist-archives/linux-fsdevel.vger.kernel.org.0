Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F38DA5974C3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Aug 2022 19:07:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241144AbiHQRGY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Aug 2022 13:06:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241158AbiHQRGS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Aug 2022 13:06:18 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73513A0329
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Aug 2022 10:06:12 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id o22so18311583edc.10
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Aug 2022 10:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=eIu4tM4zrO0ueRitKFFS3qy0kk8CRRaOxWVgGHjIOXw=;
        b=eKR1KwlySgpG/CbiZmFFtN6Dig7PlWsVMjnId1eaIn0QyeeopvYCS3OTr2rbAGack/
         IiXIDlx4N2pgFue5fTA3OyjwyxFm8mGmUTmAuEEtPpRHhxMWsvZmHuqrWPdUTnVbsWkK
         qQXivlh2A1NoeMq2LVVvPauyEmia0YhCfmf+M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=eIu4tM4zrO0ueRitKFFS3qy0kk8CRRaOxWVgGHjIOXw=;
        b=DSI3SK1FHHrkxBCqolSILrMtFMWzVYT50fPqiYLdNLa4dG00yboV5wVMjCRh5e1xjy
         /RxVjVsL67axVS06oGNfB9EEAI2NifUodbPTYmCCI6h8dOTlKxD0RVbGofy4tiUDtjeC
         zO7xPvcEKIWuug7I+PfNTrj6nfTGhx4+Z4JYhv+hqTwXDXCyBl+79VkeRb8UthuO+Mnr
         Pwxl7xRIk/oifp+lGzaEp0xoFcu6qVBgrOXBYzcMdPSE7r4sexN75oo2gn1V2kg0fdTW
         d895e20TeLYL6+IiegdCl9+0TQytU1KqdAjE/QVySVb7wVObkf/7zuoXNd5HGaTW8ubd
         xuXA==
X-Gm-Message-State: ACgBeo2bDTBrgf/f98HhDj/WLZSUvIGcUlxIFOFjGSsCZODnM/XFyzed
        PpCn7GJNOT3pJw3fabKCU70Vp2Y+ruyKARScZgs=
X-Google-Smtp-Source: AA6agR7UTZBV0/92PoCZQl5Pgev5kMTRk8iNUFAYcXqPb91y6DbCYulQnAZVXc9UIr1sDnyf/ojFmA==
X-Received: by 2002:aa7:cc06:0:b0:440:7258:ad16 with SMTP id q6-20020aa7cc06000000b004407258ad16mr23344717edt.74.1660755970851;
        Wed, 17 Aug 2022 10:06:10 -0700 (PDT)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com. [209.85.221.51])
        by smtp.gmail.com with ESMTPSA id r11-20020a056402018b00b00445f9faf13csm312534edv.72.2022.08.17.10.06.09
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Aug 2022 10:06:10 -0700 (PDT)
Received: by mail-wr1-f51.google.com with SMTP id v3so16970365wrp.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Aug 2022 10:06:09 -0700 (PDT)
X-Received: by 2002:adf:e843:0:b0:225:221f:262 with SMTP id
 d3-20020adfe843000000b00225221f0262mr2866952wrn.193.1660755969507; Wed, 17
 Aug 2022 10:06:09 -0700 (PDT)
MIME-Version: 1.0
References: <YvvBs+7YUcrzwV1a@ZenIV> <CAHk-=wgkNwDikLfEkqLxCWR=pLi1rbPZ5eyE8FbfmXP2=r3qcw@mail.gmail.com>
 <Yvvr447B+mqbZAoe@casper.infradead.org> <20220816201438.66v4ilot5gvnhdwj@cs.cmu.edu>
 <CAHk-=wghBfgOkH2jjr4OrQ7d+CLdspq1xaQK3L8x6BuDPv0eiw@mail.gmail.com> <CAOQ4uxhoAAjKOe4w+z2_NCO9PF5KD=6oKuqQQ8xcMUe=buh89A@mail.gmail.com>
In-Reply-To: <CAOQ4uxhoAAjKOe4w+z2_NCO9PF5KD=6oKuqQQ8xcMUe=buh89A@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 17 Aug 2022 10:05:53 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiQ_VQDekBvtB0D0CzFAm4HSc3_J+euxdn5vKjuAoK9dQ@mail.gmail.com>
Message-ID: <CAHk-=wiQ_VQDekBvtB0D0CzFAm4HSc3_J+euxdn5vKjuAoK9dQ@mail.gmail.com>
Subject: Re: Switching to iterate_shared
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 17, 2022 at 12:25 AM Amir Goldstein <amir73il@gmail.com> wrote:
>
> All the "complexity" is really very tidy and neat inside iterate_dir()
> I honestly don't see what the big fuss is about.

The worst part of it is conceptual, and the conditional locking.

No, it's not a huge maintenance burden, but it's quite the ugly wart
in our vfs layer that generally has pretty clean abstractions.

The non-shared version can also be a real performance problem on some
loads, but that's mainly a "real local filesystem" issue. Samba used
to (and presumably still does) do a *lot* of readdir calls for all the
name mangling.

We used to have similar horrors wrt ioctl's with the big kernel lock -
you can still see signs of that in the naming (ie the 'ioctl' function
pointer in the file operations structure is called 'unlocked_ioctl' -
even though it's been over a decade since we got rid of the 'locked'
one).

So that thing is just nasty.

> If filesystems do need to synchronize creates/deletes with readdir
> they would need to add a new internal lock and take it for every
> dir operation - it seems like a big hustle for little good reason.

Most of the time, they have that lock *anyway* - or, as I looked at
two cases, don't need any locking at all.

The pathname lookup parts of a filesystem need to be able to handle
concurrency within a directory anyway, because of how '->lookup()'
works.  Yes, our dentry layer helps a lot and serializes individual
name lookups, but basically no filesystem can rely on _just_ i_rwsem
anyway.

Of course, those locks are often about things like "read page X from
directory Y", so the locking can be about things like block allocation
etc. The bigger conceptual races - filename creation, lookup of the
same entry concurrently - are already handled by the VFS layer.

So those locks generally already exist. They just need to be checked
cover readdir too.

Normally readdir iteration is very similar to lookup().

The *one* exception tends to be directory entry caches, although
sometimes those too are shared with lookup.

> Perhaps it would have been more elegant to replace the
> iterate_shared/iterate duality with an fs_type flag.
> And it would be very simple to make that change.

No.

You're missing the point. It's not the *flag* and "we have two
different iterate functions" that is the ugly part.

Making it a filesystem flag would not have made any difference - it
would still be the same horrendous wart at the vfs level, and it would
be in some sense worse because now it's split into two different
independent things that are tied together.

> Hmm, I wonder. Can gentents() proceed without f_pos_lock on
> single f_count and then a cloned fd created and another gentents()
> races with the first one?

That would break much more important system calls than getdents (ie
basic read/write).

So if fdget_pos() were to be broken, we have much bigger issues.

In case  you care, the thing that protects us against another thread
using the same file descriptor is

  fdget_pos ->
    __fdget_pos ->
      __fdget ->
        __fdget_light ->
          check current->files->count
          do full __fdget() if it's > 1

and then __fdget_pos() does that

                if (file_count(file) > 1) {
                        v |= FDPUT_POS_UNLOCK;
                        mutex_lock(&file->f_pos_lock);
                }

check afterwards.

IOW, this code is carefully written to avoid both the file pointer
reference increment *and* the f_pos_lock in the common case of a
single-threaded process that only has the file open once.

But if 'current->files->count' is elevated - iow some other thread has
access to the file array and might be open/close/dup'ing files, we
take the file reference.

And then if the file is open through multiple file descriptors (which
might be in another file table entirely), _or_ if we just took the
file refernce due to that threading issue - then in either of those
cases we will also now take the file pos lock.

End result: either this system call is the only one that can access
that file, or we have taken the file pos lock.

Either way, getdents() ends up being serialized wrt that particular open file.

Now, you can actually screw this up if you really try: the file pos
lock obviously also is conditional on FMODE_ATOMIC_POS.

So if you have a filesystem that does "stream_open()" to clear
FMODE_ATOMIC_POS, that can avoid the file pos lock entirely.

So don't do that. I'm looking at fuse and FOPEN_STREAM, and that looks
a bit iffy.

(Of course, for a virtual filesystem, if you want to have a getdents()
that doesn't allow lseek, and that doesn't use f_pos for getdents but
just some internal other logic, clearing FMODE_ATOMIC_POS might
actually be entirely intentional. It's not like the file pos lock is
really _required_).

> I tried to look at ovl_iterate(). The subtlety is regarding the internal
> readdir cache.

Ok, from a quick look, you do have

        cache = ovl_dir_cache(d_inode(dentry));

so yeah, the cache is per-inode and thus different 'struct file'
entries for the same directory will need locking.

> Compared to fuse_readdir(), which is already "iterate_shared"
> and also implements internal readdir cache, fuse adds an internal
> mutex (quote) "against (crazy) parallel readdir on same open file".

Maybe the FUSE lock is *because* fuse allows that FOPEN_STREAM?

> Considering this protection is already provided by f_pos_lock
> 99% of the time,

It's not 99% of the time.

f_pos_lock is reliable. You have to explicitly turn it off. FUSE is
either confused and does pointless locking, or has done that
stream_open() thing to explicitly turn off the vfs locking.

Or, probably more realistically, the fuse code goes back to before we
did f_pos_lock.

                Linus
