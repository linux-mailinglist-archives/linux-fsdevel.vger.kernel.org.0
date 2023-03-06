Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F39E6AC7DB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Mar 2023 17:26:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbjCFQ0M (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Mar 2023 11:26:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230284AbjCFQZw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Mar 2023 11:25:52 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3A9C102
        for <linux-fsdevel@vger.kernel.org>; Mon,  6 Mar 2023 08:23:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678119750;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tDJWU5fhBcSFqQtu+U9+Jw798BgyW4ueAKKUp4CoM1M=;
        b=EJu68mvf/8YNmxLCpFyOottlpC32zj6hBZExaqoDnwXUSb+hEomqf8gwsKMvSKu2wld12w
        ihF7frAm+ISBi4qx7mlXTIK5/CY22Y3Hss1KF3qRWvnCtSCMdxRCzA1kZ9bKet50Jp+upP
        gmW/XXiZUbh2Ic0+MkPQMj5eXg+RGGU=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-392-VKeZWq7EPPGHLK_QAPR7ag-1; Mon, 06 Mar 2023 11:09:15 -0500
X-MC-Unique: VKeZWq7EPPGHLK_QAPR7ag-1
Received: by mail-il1-f199.google.com with SMTP id q8-20020a92ca48000000b00320ed437f04so1286837ilo.19
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Mar 2023 08:09:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678118952;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tDJWU5fhBcSFqQtu+U9+Jw798BgyW4ueAKKUp4CoM1M=;
        b=ELy+Jyu926qNdSdJnelwOewfDDcDoWkSt1hCWPbsfB609dKMsysaN6zDuiOr8j5XbA
         QZXfOyyrJDViIXKLKWuxIXIZQ8IufhkL/n1ghnpEjQIdFQzprnJoihoNWMXURVt+C5bd
         v0DPq5fRBVKOVCPkd6IPcrWIr8+fdKEYg4/oBFSuCtY2tdG6onx+W4quCoXLLGJh9XSk
         YEoGrSvgiEA7dPwPBBl1bZBKB63Ey6ZqwOfudcyoqxkGm7wvcfFujcGl505povlM2VHX
         6XzGIO9ih5XVepuN49dJQGcfb7JN20kOMs9gszZgoihPsp2Bo/upA1Ls7r8USkGov23A
         PjbA==
X-Gm-Message-State: AO0yUKW854Dhf5GcrdeCq9XyBllIsE1BPY6mWrvCW3jzEyRO8VqOvmSQ
        PIzYAe4H9S2SsKsA26vPRiEF3ykWFGGg8UK+8Pu+A2ZYSVkBfs06FyIwHcKokZ3MCk7IxeOcKIM
        EAYhn5buJLEAZBSSadZmtv5YuQuWObH2MlqrdrXW9lA==
X-Received: by 2002:a05:6e02:13e3:b0:313:cc98:7eee with SMTP id w3-20020a056e0213e300b00313cc987eeemr5407583ilj.1.1678118952644;
        Mon, 06 Mar 2023 08:09:12 -0800 (PST)
X-Google-Smtp-Source: AK7set+TFB0L2DQEfSD0uYI+gbWS6uWZQseFdlY+pXsmIXNmGsIqPIGgEg9lwdH627g+fhcyA1s+TFqYMg2LQTQUToQ=
X-Received: by 2002:a05:6e02:13e3:b0:313:cc98:7eee with SMTP id
 w3-20020a056e0213e300b00313cc987eeemr5407573ilj.1.1678118952361; Mon, 06 Mar
 2023 08:09:12 -0800 (PST)
MIME-Version: 1.0
References: <e84d009fd32b7a02ceb038db5cf1737db91069d5.camel@redhat.com>
 <CAL7ro1E7KY5yUJOLu6TY0RtAC5304sM3Lvk=zSCrqDrxTPW2og@mail.gmail.com>
 <CAL7ro1FZMRiep582LaiaqqxzYq_XeM2UMxvsHoT-guf_-bqSfg@mail.gmail.com> <e81d3776-8239-b8fa-1c64-bdb6f5cbe4df@linux.alibaba.com>
In-Reply-To: <e81d3776-8239-b8fa-1c64-bdb6f5cbe4df@linux.alibaba.com>
From:   Alexander Larsson <alexl@redhat.com>
Date:   Mon, 6 Mar 2023 17:09:01 +0100
Message-ID: <CAL7ro1GwDF1201StXw8xL9xL6y4jW1t+cbLPOmsRUp574+ewQQ@mail.gmail.com>
Subject: Re: [LSF/MM/BFP TOPIC] Composefs vs erofs+overlay
To:     Jingbo Xu <jefflexu@linux.alibaba.com>
Cc:     lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        Amir Goldstein <amir73il@gmail.com>,
        Christian Brauner <brauner@kernel.org>,
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

On Mon, Mar 6, 2023 at 4:49=E2=80=AFPM Jingbo Xu <jefflexu@linux.alibaba.co=
m> wrote:
> On 3/6/23 7:33 PM, Alexander Larsson wrote:
> > On Fri, Mar 3, 2023 at 2:57=E2=80=AFPM Alexander Larsson <alexl@redhat.=
com> wrote:
> >>
> >> On Mon, Feb 27, 2023 at 10:22=E2=80=AFAM Alexander Larsson <alexl@redh=
at.com> wrote:
> >>>
> >>> Hello,
> >>>
> >>> Recently Giuseppe Scrivano and I have worked on[1] and proposed[2] th=
e
> >>> Composefs filesystem. It is an opportunistically sharing, validating
> >>> image-based filesystem, targeting usecases like validated ostree
> >>> rootfs:es, validated container images that share common files, as wel=
l
> >>> as other image based usecases.
> >>>
> >>> During the discussions in the composefs proposal (as seen on LWN[3])
> >>> is has been proposed that (with some changes to overlayfs), similar
> >>> behaviour can be achieved by combining the overlayfs
> >>> "overlay.redirect" xattr with an read-only filesystem such as erofs.
> >>>
> >>> There are pros and cons to both these approaches, and the discussion
> >>> about their respective value has sometimes been heated. We would like
> >>> to have an in-person discussion at the summit, ideally also involving
> >>> more of the filesystem development community, so that we can reach
> >>> some consensus on what is the best apporach.
> >>
> >> In order to better understand the behaviour and requirements of the
> >> overlayfs+erofs approach I spent some time implementing direct support
> >> for erofs in libcomposefs. So, with current HEAD of
> >> github.com/containers/composefs you can now do:
> >>
> >> $ mkcompose --digest-store=3Dobjects --format=3Derofs source-dir image=
.erofs
> >>
> >> This will produce an object store with the backing files, and a erofs
> >> file with the required overlayfs xattrs, including a made up one
> >> called "overlay.fs-verity" containing the expected fs-verity digest
> >> for the lower dir. It also adds the required whiteouts to cover the
> >> 00-ff dirs from the lower dir.
> >>
> >> These erofs files are ordered similarly to the composefs files, and we
> >> give similar guarantees about their reproducibility, etc. So, they
> >> should be apples-to-apples comparable with the composefs images.
> >>
> >> Given this, I ran another set of performance tests on the original cs9
> >> rootfs dataset, again measuring the time of `ls -lR`. I also tried to
> >> measure the memory use like this:
> >>
> >> # echo 3 > /proc/sys/vm/drop_caches
> >> # systemd-run --scope sh -c 'ls -lR mountpoint' > /dev/null; cat $(cat
> >> /proc/self/cgroup | sed -e "s|0::|/sys/fs/cgroup|")/memory.peak'
> >>
> >> These are the alternatives I tried:
> >>
> >> xfs: the source of the image, regular dir on xfs
> >> erofs: the image.erofs above, on loopback
> >> erofs dio: the image.erofs above, on loopback with --direct-io=3Don
> >> ovl: erofs above combined with overlayfs
> >> ovl dio: erofs dio above combined with overlayfs
> >> cfs: composefs mount of image.cfs
> >>
> >> All tests use the same objects dir, stored on xfs. The erofs and
> >> overlay implementations are from a stock 6.1.13 kernel, and composefs
> >> module is from github HEAD.
> >>
> >> I tried loopback both with and without the direct-io option, because
> >> without direct-io enabled the kernel will double-cache the loopbacked
> >> data, as per[1].
> >>
> >> The produced images are:
> >>  8.9M image.cfs
> >> 11.3M image.erofs
> >>
> >> And gives these results:
> >>            | Cold cache | Warm cache | Mem use
> >>            |   (msec)   |   (msec)   |  (mb)
> >> -----------+------------+------------+---------
> >> xfs        |   1449     |    442     |    54
> >> erofs      |    700     |    391     |    45
> >> erofs dio  |    939     |    400     |    45
> >> ovl        |   1827     |    530     |   130
> >> ovl dio    |   2156     |    531     |   130
> >> cfs        |    689     |    389     |    51
> >
> > It has been noted that the readahead done by kernel_read() may cause
> > read-ahead of unrelated data into memory which skews the results in
> > favour of workloads that consume all the filesystem metadata (such as
> > the ls -lR usecase of the above test). In the table above this favours
> > composefs (which uses kernel_read in some codepaths) as well as
> > non-dio erofs (non-dio loopback device uses readahead too).
> >
> > I updated composefs to not use kernel_read here:
> >   https://github.com/containers/composefs/pull/105
> >
> > And a new kernel patch-set based on this is available at:
> >   https://github.com/alexlarsson/linux/tree/composefs
> >
> > The resulting table is now (dropping the non-dio erofs):
> >
> >            | Cold cache | Warm cache | Mem use
> >            |   (msec)   |   (msec)   |  (mb)
> > -----------+------------+------------+---------
> > xfs        |   1449     |    442     |   54
> > erofs dio  |    939     |    400     |   45
> > ovl dio    |   2156     |    531     |  130
> > cfs        |    833     |    398     |   51
> >
> >            | Cold cache | Warm cache | Mem use
> >            |   (msec)   |   (msec)   |  (mb)
> > -----------+------------+------------+---------
> > ext4       |   1135     |    394     |   54
> > erofs dio  |    922     |    401     |   45
> > ovl dio    |   1810     |    532     |  149
> > ovl lazy   |   1063     |    523     |  87
> > cfs        |    768     |    459     |  51
> >
> > So, while cfs is somewhat worse now for this particular usecase, my
> > overall analysis still stands.
> >
>
> Hi,
>
> I tested your patch removing kernel_read(), and here is the statistics
> tested in my environment.
>
>
> Setup
> =3D=3D=3D=3D=3D=3D
> CPU: x86_64 Intel(R) Xeon(R) Platinum 8269CY CPU @ 2.50GHz
> Disk: cloud disk, 11800 IOPS upper limit
> OS: Linux v6.2
> FS of backing objects: xfs
>
>
> Image size
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> 8.6M large.composefs (with --compute-digest)
> 8.9M large.erofs (mkfs.erofs)
> 11M  large.cps.in.erofs (mkfs.composefs --compute-digest --format=3Derofs=
)
>
>
> Perf of "ls -lR"
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>                                               | uncached| cached
>                                               |  (ms)   |  (ms)
> ----------------------------------------------|---------|--------
> composefs                                          | 519        | 178
> erofs (mkfs.erofs, DIRECT loop)                    | 497        | 192
> erofs (mkfs.composefs --format=3Derofs, DIRECT loop) | 536        | 199
>
> I tested the performance of "ls -lR" on the whole tree of
> cs9-developer-rootfs.  It seems that the performance of erofs (generated
> from mkfs.erofs) is slightly better than that of composefs.  While the
> performance of erofs generated from mkfs.composefs is slightly worse
> that that of composefs.

I suspect that the reason for the lower performance of mkfs.composefs
is the added overlay.fs-verity xattr to all the files. It makes the
image larger, and that means more i/o.

> The uncached performance is somewhat slightly different with that given
> by Alexander Larsson.  I think it may be due to different test
> environment, as my test machine is a server with robust performance,
> with cloud disk as storage.
>
> It's just a simple test without further analysis, as it's a bit late for
> me :)

Yeah, and for the record, I'm not claiming that my tests contain any
high degree of analysis or rigour either. They are short simple test
runs that give a rough estimate of the overall performance of metadata
operations. What is interesting here is if there are large or
unexpected differences, and from that point of view our results are
basically the same.

--=20
=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D=
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D
 Alexander Larsson                                Red Hat, Inc
       alexl@redhat.com         alexander.larsson@gmail.com

