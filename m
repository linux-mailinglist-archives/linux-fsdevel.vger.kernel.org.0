Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA22B6A98F1
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Mar 2023 14:58:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbjCCN6O (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Mar 2023 08:58:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjCCN6N (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Mar 2023 08:58:13 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72D2861505
        for <linux-fsdevel@vger.kernel.org>; Fri,  3 Mar 2023 05:57:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677851844;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hvxxAue+VLw8xzy0zNw3JlYWZvTzkWPg16GbP/7CN+0=;
        b=Pbfx6JxWf2crgt6ko0g2+IcMEr4Hrdg39j/qeHNKkH5j3hGdxNBj+pUm8nQXjO+ONvAgwh
        RKxsmUkhEpoBjjQ9Z0yoU/ujvR4Jw9rePGLqpqtA793gWrS1K3GymLy1aGmZQyWVIeN2iK
        We58AC8cqAT7wWclkjX/mlGYDdTZjV8=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-144-6A8YX6TZOwSK4fY-FVUqaw-1; Fri, 03 Mar 2023 08:57:23 -0500
X-MC-Unique: 6A8YX6TZOwSK4fY-FVUqaw-1
Received: by mail-il1-f198.google.com with SMTP id a5-20020a92ce45000000b00318aa18d2fbso1357665ilr.23
        for <linux-fsdevel@vger.kernel.org>; Fri, 03 Mar 2023 05:57:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hvxxAue+VLw8xzy0zNw3JlYWZvTzkWPg16GbP/7CN+0=;
        b=V4WtZR1HtDRjqLIHNsjq6EsrJ3ETx17gs14OJrctxJ2hcYY/y1NrsqIs1HnaODnY8R
         GXT4x2T7kB38FyHW20y6+u1fCdWTGv63EmvbdPV3yQqtBufMSXDZtt+g7ekYnCIWVl6p
         phoTzBVX1ZyUDwJqCxNS00gyGFPRjsafZHjxhEDkLqEyF/0HtpkyhAavPIDmvHfjAMPm
         P+GKNM752nHYw0JoR5hBe7lK131KpREE3IvIEE3RzRZ5ymBFbfoLpMGqOHm0J19LlCYo
         XWP6aRnroOvGuBeuKbl5G+Oip2mWB5++dLGKTqG0Y/UBkeoIcktcTgHEHKRsPVQpz0SV
         NuWQ==
X-Gm-Message-State: AO0yUKWskf5Td6C7OXlwKUjOCGzZY7zEdIxhF1+EwWEqvU58PuiAmRwY
        uyhjg66M4gXAaOqVLbjSV6El7umq6YlPhD4ofLEptPuzjM6s2PzE9GIfVsxZQwbsrEerBB09ZYN
        firpYdxa9DCLJXH678on01gS4hGqXx9MOv18tO/DILa2KJx7CpQ==
X-Received: by 2002:a02:7a45:0:b0:3ae:e73b:ff26 with SMTP id z5-20020a027a45000000b003aee73bff26mr633557jad.1.1677851842603;
        Fri, 03 Mar 2023 05:57:22 -0800 (PST)
X-Google-Smtp-Source: AK7set9bbTMjVooiVumMen+2N373tA0B62WHY6M/VKQVgqungEpCApSGdPwuPmajr8dNn/q75u9Q5l3vzZPzec7uvQ0=
X-Received: by 2002:a02:7a45:0:b0:3ae:e73b:ff26 with SMTP id
 z5-20020a027a45000000b003aee73bff26mr633544jad.1.1677851842329; Fri, 03 Mar
 2023 05:57:22 -0800 (PST)
MIME-Version: 1.0
References: <e84d009fd32b7a02ceb038db5cf1737db91069d5.camel@redhat.com>
In-Reply-To: <e84d009fd32b7a02ceb038db5cf1737db91069d5.camel@redhat.com>
From:   Alexander Larsson <alexl@redhat.com>
Date:   Fri, 3 Mar 2023 14:57:11 +0100
Message-ID: <CAL7ro1E7KY5yUJOLu6TY0RtAC5304sM3Lvk=zSCrqDrxTPW2og@mail.gmail.com>
Subject: Re: [LSF/MM/BFP TOPIC] Composefs vs erofs+overlay
To:     lsf-pc@lists.linux-foundation.org
Cc:     linux-fsdevel@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>,
        Christian Brauner <brauner@kernel.org>,
        Jingbo Xu <jefflexu@linux.alibaba.com>,
        Gao Xiang <hsiangkao@linux.alibaba.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Dave Chinner <david@fromorbit.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 27, 2023 at 10:22=E2=80=AFAM Alexander Larsson <alexl@redhat.co=
m> wrote:
>
> Hello,
>
> Recently Giuseppe Scrivano and I have worked on[1] and proposed[2] the
> Composefs filesystem. It is an opportunistically sharing, validating
> image-based filesystem, targeting usecases like validated ostree
> rootfs:es, validated container images that share common files, as well
> as other image based usecases.
>
> During the discussions in the composefs proposal (as seen on LWN[3])
> is has been proposed that (with some changes to overlayfs), similar
> behaviour can be achieved by combining the overlayfs
> "overlay.redirect" xattr with an read-only filesystem such as erofs.
>
> There are pros and cons to both these approaches, and the discussion
> about their respective value has sometimes been heated. We would like
> to have an in-person discussion at the summit, ideally also involving
> more of the filesystem development community, so that we can reach
> some consensus on what is the best apporach.

In order to better understand the behaviour and requirements of the
overlayfs+erofs approach I spent some time implementing direct support
for erofs in libcomposefs. So, with current HEAD of
github.com/containers/composefs you can now do:

$ mkcompose --digest-store=3Dobjects --format=3Derofs source-dir image.erof=
s

This will produce an object store with the backing files, and a erofs
file with the required overlayfs xattrs, including a made up one
called "overlay.fs-verity" containing the expected fs-verity digest
for the lower dir. It also adds the required whiteouts to cover the
00-ff dirs from the lower dir.

These erofs files are ordered similarly to the composefs files, and we
give similar guarantees about their reproducibility, etc. So, they
should be apples-to-apples comparable with the composefs images.

Given this, I ran another set of performance tests on the original cs9
rootfs dataset, again measuring the time of `ls -lR`. I also tried to
measure the memory use like this:

# echo 3 > /proc/sys/vm/drop_caches
# systemd-run --scope sh -c 'ls -lR mountpoint' > /dev/null; cat $(cat
/proc/self/cgroup | sed -e "s|0::|/sys/fs/cgroup|")/memory.peak'

These are the alternatives I tried:

xfs: the source of the image, regular dir on xfs
erofs: the image.erofs above, on loopback
erofs dio: the image.erofs above, on loopback with --direct-io=3Don
ovl: erofs above combined with overlayfs
ovl dio: erofs dio above combined with overlayfs
cfs: composefs mount of image.cfs

All tests use the same objects dir, stored on xfs. The erofs and
overlay implementations are from a stock 6.1.13 kernel, and composefs
module is from github HEAD.

I tried loopback both with and without the direct-io option, because
without direct-io enabled the kernel will double-cache the loopbacked
data, as per[1].

The produced images are:
 8.9M image.cfs
11.3M image.erofs

And gives these results:
           | Cold cache | Warm cache | Mem use
           |   (msec)   |   (msec)   |  (mb)
-----------+------------+------------+---------
xfs        |   1449     |    442     |    54
erofs      |    700     |    391     |    45
erofs dio  |    939     |    400     |    45
ovl        |   1827     |    530     |   130
ovl dio    |   2156     |    531     |   130
cfs        |    689     |    389     |    51

I also ran the same tests in a VM that had the latest kernel including
the lazyfollow patches (ovl lazy in the table, not using direct-io),
this one ext4 based:

           | Cold cache | Warm cache | Mem use
           |   (msec)   |   (msec)   |  (mb)
-----------+------------+------------+---------
ext4       |   1135     |    394     |    54
erofs      |    715     |    401     |    46
erofs dio  |    922     |    401     |    45
ovl        |   1412     |    515     |   148
ovl dio    |   1810     |    532     |   149
ovl lazy   |   1063     |    523     |    87
cfs        |    719     |    463     |    51

Things noticeable in the results:

* composefs and erofs (by itself) perform roughly  similar. This is
  not necessarily news, and results from Jingbo Xu match this.

* Erofs on top of direct-io enabled loopback causes quite a drop in
  performance, which I don't really understand. Especially since its
  reporting the same memory use as non-direct io. I guess the
  double-cacheing in the later case isn't properly attributed to the
  cgroup so the difference is not measured. However, why would the
  double cache improve performance?  Maybe I'm not completely
  understanding how these things interact.

* Stacking overlay on top of erofs causes about 100msec slower
  warm-cache times compared to all non-overlay approaches, and much
  more in the cold cache case. The cold cache performance is helped
  significantly by the lazyfollow patches, but the warm cache overhead
  remains.

* The use of overlayfs more than doubles memory use, probably
  because of all the extra inodes and dentries in action for the
  various layers. The lazyfollow patches helps, but only partially.

* Even though overlayfs+erofs is slower than cfs and raw erofs, it is
  not that much slower (~25%) than the pure xfs/ext4 directory, which
  is a pretty good baseline for comparisons. It is even faster when
  using lazyfollow on ext4.

* The erofs images are slightly larger than the equivalent composefs
  image.

In summary: The performance of composefs is somewhat better than the
best erofs+ovl combination, although the overlay approach is not
significantly worse than the baseline of a regular directory, except
that it uses a bit more memory.

On top of the above pure performance based comparisons I would like to
re-state some of the other advantages of composefs compared to the
overlay approach:

* composefs is namespaceable, in the sense that you can use it (given
  mount capabilities) inside a namespace (such as a container) without
  access to non-namespaced resources like loopback or device-mapper
  devices. (There was work on fixing this with loopfs, but that seems
  to have stalled.)

* While it is not in the current design, the simplicity of the format
  and lack of loopback makes it at least theoretically possible that
  composefs can be made usable in a rootless fashion at some point in
  the future.

And of course, there are disadvantages to composefs too. Primarily
being more code, increasing maintenance burden and risk of security
problems. Composefs is particularly burdensome because it is a
stacking filesystem and these have historically been shown to be hard
to get right.


The question now is what is the best approach overall? For my own
primary usecase of making a verifying ostree root filesystem, the
overlay approach (with the lazyfollow work finished) is, while not
ideal, good enough.

But I know for the people who are more interested in using composefs
for containers the eventual goal of rootless support is very
important. So, on behalf of them I guess the question is: Is there
ever any chance that something like composefs could work rootlessly?
Or conversely: Is there some way to get rootless support from the
overlay approach? Opinions? Ideas?


[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it/?id=3Dbc07c10a3603a5ab3ef01ba42b3d41f9ac63d1b6



--
=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D=
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D
 Alexander Larsson                                Red Hat, Inc
       alexl@redhat.com         alexander.larsson@gmail.com

