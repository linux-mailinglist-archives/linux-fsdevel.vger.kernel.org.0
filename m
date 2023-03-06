Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C3736ABE44
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Mar 2023 12:35:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbjCFLfW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Mar 2023 06:35:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230138AbjCFLfK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Mar 2023 06:35:10 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9C4A527E
        for <linux-fsdevel@vger.kernel.org>; Mon,  6 Mar 2023 03:34:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678102449;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wb+C1NebACK70lEWKobhJI6EdvPzGsmCQTd7LlgFXTc=;
        b=XJNMUHyI3MEHl/zqfpx2KZybSHetCVL5sC5QYQvxlv+Vy8JiF86Sy4PfyyGF1oarigVx7h
        mMbRtzDqBAyQ0MWHDKYQRTWlP6nOPRTLCC2aEF5E33K5wMB4kVTMjn1rE4iTD8jy+t1JO2
        2GQ9FOkQr+6VhSUaADUuf8ZCa9e3V7g=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-7SuHLVltOuGg5OQyxYLSig-1; Mon, 06 Mar 2023 06:34:08 -0500
X-MC-Unique: 7SuHLVltOuGg5OQyxYLSig-1
Received: by mail-il1-f200.google.com with SMTP id j9-20020a056e02220900b0031d93dba5a9so2678732ilf.17
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Mar 2023 03:34:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678102447;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wb+C1NebACK70lEWKobhJI6EdvPzGsmCQTd7LlgFXTc=;
        b=v254eTVCtc+hHcQ3Efmr+LT3JncEC7LDykkY1FbOCsomGgDHRigUitfOk36tafUg3U
         Oz0SfDze+iQLCpi1b4rTXZEcjuQBoF8BcZusyir6avbfQNdyqC/CvL0/U06x39+iL/sm
         44Q1iGnQCGMz5AgH6R0HSyU27c3StB8aPFXYtgGcPRsrdadcji+EQCVG0+hDUbEKI+Ci
         3p1TZJhmWSTNRqyFa4X5HUomV2Fk7pGloOcpXo6nZAXYfiWMNog6+n6hzkkjEUvAp6MK
         zvGKDMfksl4GG8zDR/C9H/yV5McOet+eVIUH914Oe/KpOAj6QwugO3JGx8zhy0x/YjQR
         B+LQ==
X-Gm-Message-State: AO0yUKWBNyCy/nVcvdcleITsmu8TFIRSi6BKoH1sD83hXZWIt12iNmz3
        BYyIW0XVQXm+ZECnR9OeensTfKqeqMeSjHVX3z3wffKDCUB2KvYYvu/hJ0RzQc0JGcko9epk6A5
        MGH5EQk6UBZln2GeyNwtuytBRgeFHusfQ28vZbTPiwjnNjLwP+5Mj
X-Received: by 2002:a05:6e02:f02:b0:316:fa49:3705 with SMTP id x2-20020a056e020f0200b00316fa493705mr5618470ilj.1.1678102447251;
        Mon, 06 Mar 2023 03:34:07 -0800 (PST)
X-Google-Smtp-Source: AK7set8746QHhpXRbQuX2Mbv9w1qFG9JCgZiEDiCKV9H7pT+difdtYwlwHuajQ+JG3C29XxWqRhux5WwOnOld9y/BjU=
X-Received: by 2002:a05:6e02:f02:b0:316:fa49:3705 with SMTP id
 x2-20020a056e020f0200b00316fa493705mr5618455ilj.1.1678102447022; Mon, 06 Mar
 2023 03:34:07 -0800 (PST)
MIME-Version: 1.0
References: <e84d009fd32b7a02ceb038db5cf1737db91069d5.camel@redhat.com> <CAL7ro1E7KY5yUJOLu6TY0RtAC5304sM3Lvk=zSCrqDrxTPW2og@mail.gmail.com>
In-Reply-To: <CAL7ro1E7KY5yUJOLu6TY0RtAC5304sM3Lvk=zSCrqDrxTPW2og@mail.gmail.com>
From:   Alexander Larsson <alexl@redhat.com>
Date:   Mon, 6 Mar 2023 12:33:56 +0100
Message-ID: <CAL7ro1FZMRiep582LaiaqqxzYq_XeM2UMxvsHoT-guf_-bqSfg@mail.gmail.com>
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

On Fri, Mar 3, 2023 at 2:57=E2=80=AFPM Alexander Larsson <alexl@redhat.com>=
 wrote:
>
> On Mon, Feb 27, 2023 at 10:22=E2=80=AFAM Alexander Larsson <alexl@redhat.=
com> wrote:
> >
> > Hello,
> >
> > Recently Giuseppe Scrivano and I have worked on[1] and proposed[2] the
> > Composefs filesystem. It is an opportunistically sharing, validating
> > image-based filesystem, targeting usecases like validated ostree
> > rootfs:es, validated container images that share common files, as well
> > as other image based usecases.
> >
> > During the discussions in the composefs proposal (as seen on LWN[3])
> > is has been proposed that (with some changes to overlayfs), similar
> > behaviour can be achieved by combining the overlayfs
> > "overlay.redirect" xattr with an read-only filesystem such as erofs.
> >
> > There are pros and cons to both these approaches, and the discussion
> > about their respective value has sometimes been heated. We would like
> > to have an in-person discussion at the summit, ideally also involving
> > more of the filesystem development community, so that we can reach
> > some consensus on what is the best apporach.
>
> In order to better understand the behaviour and requirements of the
> overlayfs+erofs approach I spent some time implementing direct support
> for erofs in libcomposefs. So, with current HEAD of
> github.com/containers/composefs you can now do:
>
> $ mkcompose --digest-store=3Dobjects --format=3Derofs source-dir image.er=
ofs
>
> This will produce an object store with the backing files, and a erofs
> file with the required overlayfs xattrs, including a made up one
> called "overlay.fs-verity" containing the expected fs-verity digest
> for the lower dir. It also adds the required whiteouts to cover the
> 00-ff dirs from the lower dir.
>
> These erofs files are ordered similarly to the composefs files, and we
> give similar guarantees about their reproducibility, etc. So, they
> should be apples-to-apples comparable with the composefs images.
>
> Given this, I ran another set of performance tests on the original cs9
> rootfs dataset, again measuring the time of `ls -lR`. I also tried to
> measure the memory use like this:
>
> # echo 3 > /proc/sys/vm/drop_caches
> # systemd-run --scope sh -c 'ls -lR mountpoint' > /dev/null; cat $(cat
> /proc/self/cgroup | sed -e "s|0::|/sys/fs/cgroup|")/memory.peak'
>
> These are the alternatives I tried:
>
> xfs: the source of the image, regular dir on xfs
> erofs: the image.erofs above, on loopback
> erofs dio: the image.erofs above, on loopback with --direct-io=3Don
> ovl: erofs above combined with overlayfs
> ovl dio: erofs dio above combined with overlayfs
> cfs: composefs mount of image.cfs
>
> All tests use the same objects dir, stored on xfs. The erofs and
> overlay implementations are from a stock 6.1.13 kernel, and composefs
> module is from github HEAD.
>
> I tried loopback both with and without the direct-io option, because
> without direct-io enabled the kernel will double-cache the loopbacked
> data, as per[1].
>
> The produced images are:
>  8.9M image.cfs
> 11.3M image.erofs
>
> And gives these results:
>            | Cold cache | Warm cache | Mem use
>            |   (msec)   |   (msec)   |  (mb)
> -----------+------------+------------+---------
> xfs        |   1449     |    442     |    54
> erofs      |    700     |    391     |    45
> erofs dio  |    939     |    400     |    45
> ovl        |   1827     |    530     |   130
> ovl dio    |   2156     |    531     |   130
> cfs        |    689     |    389     |    51

It has been noted that the readahead done by kernel_read() may cause
read-ahead of unrelated data into memory which skews the results in
favour of workloads that consume all the filesystem metadata (such as
the ls -lR usecase of the above test). In the table above this favours
composefs (which uses kernel_read in some codepaths) as well as
non-dio erofs (non-dio loopback device uses readahead too).

I updated composefs to not use kernel_read here:
  https://github.com/containers/composefs/pull/105

And a new kernel patch-set based on this is available at:
  https://github.com/alexlarsson/linux/tree/composefs

The resulting table is now (dropping the non-dio erofs):

           | Cold cache | Warm cache | Mem use
           |   (msec)   |   (msec)   |  (mb)
-----------+------------+------------+---------
xfs        |   1449     |    442     |   54
erofs dio  |    939     |    400     |   45
ovl dio    |   2156     |    531     |  130
cfs        |    833     |    398     |   51

           | Cold cache | Warm cache | Mem use
           |   (msec)   |   (msec)   |  (mb)
-----------+------------+------------+---------
ext4       |   1135     |    394     |   54
erofs dio  |    922     |    401     |   45
ovl dio    |   1810     |    532     |  149
ovl lazy   |   1063     |    523     |  87
cfs        |    768     |    459     |  51

So, while cfs is somewhat worse now for this particular usecase, my
overall analysis still stands.

--=20
=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D=
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D
 Alexander Larsson                                Red Hat, Inc
       alexl@redhat.com         alexander.larsson@gmail.com

