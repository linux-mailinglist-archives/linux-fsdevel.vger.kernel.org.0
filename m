Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 326DF4B4419
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Feb 2022 09:30:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241935AbiBNIaK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Feb 2022 03:30:10 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235975AbiBNIaJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Feb 2022 03:30:09 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 744ED25C61;
        Mon, 14 Feb 2022 00:30:01 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id h8so9254621ejy.4;
        Mon, 14 Feb 2022 00:30:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KBkkpd7Dq9M6IfjuoA2MS0Y+4xS4NTA757oJgLNmxhI=;
        b=RErNG+fEldG/bii9qhme2yoftZjvP8xC2TTC1fIOIEFA2tJ5oog1D/fWmRrQAriYfs
         2XRpJjwWMWjUjD2ghAIE/ZVe7sQSBcAHF6fG1XD0MSqSnIpwoml1/302SDfpbcWpzaXn
         9cmZJZKsx+JK1oPLdFv+rd9IvqCwZ8mxYvB4Vhfi5M/AvJRa8Amg39iWJEi2YYEolm2i
         RYP77Jn3TiniFiX0uYWaCZy67+Y+o+OCPz6AWqSuFWOyRMlnkOciPWhPKoER8go263mD
         p8aNRwYeNJz3N9TcEV9izVOoXoCEHvv1deVptZufWq0rPJU9QHwu/VZU3kPyf2XwP2F8
         I2dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KBkkpd7Dq9M6IfjuoA2MS0Y+4xS4NTA757oJgLNmxhI=;
        b=YwvSGe36PSFegF39a80NA0nTfpIYKRi5IY8BR0Ttb1GmlYV6NvFYoSbOvhx/Ap3Fm9
         EJ4nKCz2H5h8ckkbvd/qUtMXPj64DbeyM0mrDi6a055YZAZ5zGljdDDCeugb8BXxf8NS
         Cu/UpmK9HL/eg40ldPGJiPBflS8/3GAFjWMOzepZt7ywLRE5zuxOIlP10wTuAZro3D2x
         A85sTlsfNbTJPWqNnciPYbXOa/gPuxK1C0WqdnUuLRDoe2Ae5DSu3EQBR/wXEosaR6a1
         nvLI6mRvZTdBbu2iESJs+YgZrtlIH4v9gDIzoSX8JCzjJyXZz3BmeSkPgLl1RmvA5fiC
         5cAQ==
X-Gm-Message-State: AOAM532QOTLrlRZIXcKm2ylsUnZK6E1BdEMdMv/Oa65XasonpzMETA6i
        r6hRovI+WZ9iXCvAkzHKpiaTydTvEStpwy0zI0DVLq1X1c5lsA==
X-Google-Smtp-Source: ABdhPJy5gKp75o7nSKcP/zuOhAWBScMxMSTh0DsLT1cnY7FEb8DaKnFG34WMerR19+IEc42s/rrLv20C/c5Ax/QrSG4=
X-Received: by 2002:a17:906:72c5:: with SMTP id m5mr10508023ejl.63.1644827399906;
 Mon, 14 Feb 2022 00:29:59 -0800 (PST)
MIME-Version: 1.0
References: <20220123100448.GA1468@haolee.io> <YgnGuy0GJzlqCSRj@zeniv-ca.linux.org.uk>
In-Reply-To: <YgnGuy0GJzlqCSRj@zeniv-ca.linux.org.uk>
From:   Hao Lee <haolee.swjtu@gmail.com>
Date:   Mon, 14 Feb 2022 16:29:48 +0800
Message-ID: <CA+PpKPkRMW_=D-=7dOYA95h-oqTGYB=rUyBpitZ9bfgb8OawGA@mail.gmail.com>
Subject: Re: [PATCH] fs/namespace: eliminate unnecessary mount counting
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
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

On Mon, Feb 14, 2022 at 11:04 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Sun, Jan 23, 2022 at 10:04:48AM +0000, Hao Lee wrote:
> > propagate_one() counts the number of propagated mounts in each
> > propagation. We can count them in advance and use the number in
> > subsequent propagation.
>
> You are relying upon highly non-obvious assumptions.  Namely, that
> copies will have the same amount of mounts as source_mnt.  AFAICS,
> it's not true in case of mount --move - there source_mnt might very
> well contain the things that would be skipped in subsequent copies.
> E.g. anything marked unbindable.  Or mntns binds - anything that would
> be skipped by copy_tree() without special flags.
>
> Sure, we could make count_mounts() return just the number of those
> that will go into subsequent copies (with mount --move we don't add
> the original subtree - it's been in the namespace and thus is already
> counted), but
>         1) it creates an extra dependency in already convoluted code
> (copy_tree() and count_mounts() need to be kept in sync, in case we ever
> add new classes of mounts to be skipped)
>         2) I'm *NOT* certain that we won't ever run into the non-move
> cases where the original tree contains something that would be skipped
> from subsequent ones, and there we want to count the original.  Matter of
> fact, we do run into that.  Look:
>
> # arrange a private tree at /tmp/a
> mkdir /tmp/a
> mount --bind /tmp/a /tmp/a
> mount --make-rprivate /tmp/a
> # mountpoint at /tmp/a/x
> mkdir /tmp/a/x
> mount --bind /tmp/a/x /tmp/a/x
> # this will be a peer of /tmp/a/x
> mkdir /tmp/a/y
> # ... and this - a mountpoint in it
> mkdir /tmp/a/x/v
> # ... rbind fodder:
> mkdir /tmp/a/z
> touch /tmp/a/z/f
> # start a new mntns, so we won't run afoul of loop checks
> unshare -m &
> # ... and bind it on /tmp/a/z/f
> mount --bind /proc/$!/ns/mnt /tmp/a/z/f
> # now we can do the rest - it won't spread into child namespace
> # make /tmp/a/x a peer of /tmp/b/x
> mount --make-shared /tmp/a/x
> mount --bind /tmp/a/x /tmp/a/y
> # ... and rbind /tmp/a/z at /tmp/a/x/v
> # which will propagate a copy to /tmp/b/x/v
> # except that mntns bound on /tmp/a/x/v/f will *not* propagate.
> mount --rbind /tmp/a/z /tmp/a/x/v
> # verify that
> stat /tmp/a/x/v
> stat /tmp/a/y/v
> stat /tmp/a/x/v/f
> stat /tmp/a/y/v/f
>
> Result:
>   File: /tmp/a/x/v/
>   Size: 4096            Blocks: 8          IO Block: 4096   directory
> Device: 808h/2056d      Inode: 270607      Links: 2
> Access: (0755/drwxr-xr-x)  Uid: (    0/    root)   Gid: (    0/    root)
> Access: 2022-02-13 21:43:45.058485130 -0500
> Modify: 2022-02-13 21:42:37.142457622 -0500
> Change: 2022-02-13 21:42:37.142457622 -0500
>  Birth: 2022-02-13 21:42:37.142457622 -0500
>   File: /tmp/a/y/v/
>   Size: 4096            Blocks: 8          IO Block: 4096   directory
> Device: 808h/2056d      Inode: 270607      Links: 2
> Access: (0755/drwxr-xr-x)  Uid: (    0/    root)   Gid: (    0/    root)
> Access: 2022-02-13 21:43:45.058485130 -0500
> Modify: 2022-02-13 21:42:37.142457622 -0500
> Change: 2022-02-13 21:42:37.142457622 -0500
>  Birth: 2022-02-13 21:42:37.142457622 -0500
>   File: /tmp/a/x/v/f
>   Size: 0               Blocks: 0          IO Block: 4096   regular empty file
> Device: 4h/4d   Inode: 4026532237  Links: 1
> Access: (0444/-r--r--r--)  Uid: (    0/    root)   Gid: (    0/    root)
> Access: 2022-02-13 21:42:37.146457624 -0500
> Modify: 2022-02-13 21:42:37.146457624 -0500
> Change: 2022-02-13 21:42:37.146457624 -0500
>  Birth: -
>   File: /tmp/a/y/v/f
>   Size: 0               Blocks: 0          IO Block: 4096   regular empty file
> Device: 808h/2056d      Inode: 270608      Links: 1
> Access: (0644/-rw-r--r--)  Uid: (    0/    root)   Gid: (    0/    root)
> Access: 2022-02-13 21:42:37.142457622 -0500
> Modify: 2022-02-13 21:42:37.142457622 -0500
> Change: 2022-02-13 21:42:37.142457622 -0500
>  Birth: 2022-02-13 21:42:37.142457622 -0500
>
>         Note that /tmp/a/x/v and /tmp/a/y/v resolve to the same directory
> (otherwise seen at /tmp/a/z), but /tmp/a/x/v/f and /tmp/a/y/v/f do *not*
> resolve to the same thing - the latter is a regular file on /dev/sda8
> (nothing got propagated there), while the former is *not* - it's an
> mntns descriptor we'd bound on /tmp/a/z/f
>
>         IOW, the first copy has two mount nodes, the second - only one.
> Initial copy at rbind does get mntns binds copied into it - look at
> CL_COPY_MNT_NS_FILE in arguments of copy_tree() call in __do_loopback().
> However, we do *not* propagate that subsequent copies (propagate_one()
> never passes CL_COPY_MNT_NS_FILE).  So that's at least one case where we
> want different contributions from the first copy and every subsequent one.
>
>         So we'd need to run *two* counts, the one to be used from
> attach_recursive_mnt() and another for propagate_one().  With even more
> places where the things could go wrong...

This is really a classic counterexample.
Thanks for your detailed explanation!

>
>         I don't believe it's worth the trouble.  Sure, you run that loop
> only once, instead of once per copy.  And if that's more than noise,
> compared to allocating the same mounts we'd been counting, connecting
> them into tree, hashing, etc., I would be *very* surprised.

Got it. Thanks!

>
> NAKed-by: Al Viro <viro@zeniv.linux.org.uk>
