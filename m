Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBD4C3AA324
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jun 2021 20:25:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231641AbhFPS13 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Jun 2021 14:27:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231379AbhFPS13 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Jun 2021 14:27:29 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BB2DC061574
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Jun 2021 11:25:21 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id z1so3221513ils.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Jun 2021 11:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=WlIUu13nrP+IoJrY8clMEG/aJUfLiLIerD/eovxM2JI=;
        b=b6DN/Koe7PKr6FH5s4EmY8XA+huzj12vrdzep2mlDksQvere3UbyyjQAmz/CTntLXe
         N2Mnb3VLur8+GGdQgorVHt0PJNlKTscVqhWdnw6DpGnVBpMUma7XHe3NRnfQGyGYoU5i
         fKO23u4u7AE7faKOnaL8sWhrOZgs+Frvc8liXG3RXfxGW5cak/oLg+5rLIzvWvqgWJ/u
         /gSUp9IwOrG9bE6Px1qEW7DQVMweEcFlthG5td9xPCFqXurOR2orfUyaE5g7F+1a5IM0
         D833fPBXSukEra2vpMZUcE7s4jIMir6oqDHqUqAqC8j9i8ep80KWrR93yWYmxY2y8Own
         Um8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WlIUu13nrP+IoJrY8clMEG/aJUfLiLIerD/eovxM2JI=;
        b=t5DWc4GFH8T/d0k79tgOQ9+K8GhK66p1PKCjpw+/LrFqmqhTJ6KDjgmIpALct8GqSX
         SwaqRMx88yZVbepU1cCGHge2V57VFh5GzumO3TRUuwHowajdkTWnM51a9ZeQWwBSgQjr
         dVcKFqt32ARTeDHETuXQzf82GgeQAt1gCp3ni7df1V1T/ZqFrc74+J5inEnHkae1SC40
         9/0SF1y2RxlrYsRNGzX2Aw3bjuBPClKbpmfdaW0L1dq1ym4u+4OKzMj4eHSEl+ACyXpd
         i49jlxeYPhafls9/OpB2J2pTQ54lTMt0AlbAaa3bF1EMoSBM5JJJjdjHYhK61FCCHpSz
         vj4Q==
X-Gm-Message-State: AOAM533w+TmsTBMPXh5/tGLqdO26IPJcpvqZSNI9MBF6M2l9pNs4oJ/W
        cqVO+8SAwxY/11ire+rKXRB92Zoi1U3YnutU7hxseFbuGHg=
X-Google-Smtp-Source: ABdhPJwnJmi91F81dshf456TICiRvEf5LdROGniwhZJ8l5aIpDzAeUsMkmqzooX1EeSCWLhqrVstOfVM2ZcdxB3ks9g=
X-Received: by 2002:a05:6e02:14a:: with SMTP id j10mr702496ilr.250.1623867920575;
 Wed, 16 Jun 2021 11:25:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210609181158.479781-1-amir73il@gmail.com> <CAOQ4uxi3vK1eyWk69asycmo5PTyUE9+o7-Ha17CTXYytQiWPZQ@mail.gmail.com>
 <d7a38600-5b4b-487e-9362-790a7b5dde05@www.fastmail.com>
In-Reply-To: <d7a38600-5b4b-487e-9362-790a7b5dde05@www.fastmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 16 Jun 2021 21:25:09 +0300
Message-ID: <CAOQ4uxgzpKRWU2fFgF4OxROHZ84VZw7Ljqt5RvAi4b3ViTNfYg@mail.gmail.com>
Subject: Re: [PATCH] fuse: fix illegal access to inode with reused nodeid
To:     Nikolaus Rath <nikolaus@rath.org>
Cc:     Miklos Szeredi <miklos@szeredi.hu>, Max Reitz <mreitz@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 16, 2021 at 8:25 PM Nikolaus Rath <nikolaus@rath.org> wrote:
>
> Hi Amir,
>
> On Wed, 16 Jun 2021, at 16:03, Amir Goldstein wrote:
> > Per request from Nikolaus, I modified the passthrough_hp example
> > to reuse inodes on last close+unlink, so it now hits the failure in the
> > new test with upstream kernel and it passes the test with this kernel f=
ix.
> >
> > Thanks,
> > Amir.
> >
> > [2] https://github.com/libfuse/libfuse/pull/612
>
> Actually, I am no longer sure this was a good idea. Having the libfuse te=
st suite detect problems that with the kernel doesn't seem to helpful.. I t=
hink the testsuite should identify problems in libfuse.  Currently, having =
the tests means that users might be hesitant to update to the newer libfuse=
 because of the failing test - when in fact there is nothing wrong with lib=
fuse at all.
>

I suppose you are right.
I could take the tesy_syscalls test to xfstest, but fuse support for
xfstests is still WIP.

> I assume the test will start failing on some future kernel (which is why =
it passed CL), and then start passing again for some kernel after that?

I was not aware that it passes CI.
There are no test results available on github.
I am not aware of any specific kernel version where the test should pass,
but the results also depend on the underlying filesystem.
If your underlying filesystem is btrfs, it does not reuse inode numbers
at all, so the test will not fail.

For me the test fails on ext4 and xfs on LTS kernel 5.10.
As I wrote in PR:
"...Fails the modified test_syscalls in this PR on upstream kernel"

If you revert the last commit the test would pass on upstream kernel:
80f2b8b ("passthrough_hp: excercise reusing inode numbers")

We could make behavior of passthrough_hp example depend
on some minimal kernel protocol version or new kernel capability like
FUSE_SETXATTR_EXT if Miklos intends to merge the fix for the coming
kernel release or we could just make that new test optional via pytest opti=
on.

After all, regardless of the kernel bug, this adds test coverage that was
missing, so it also covers a possible future regression in libfuse.

Let me know if you want me to implement any of the listed options.

Thanks,
Amir.
