Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46A8D6A99BC
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Mar 2023 15:42:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230422AbjCCOmo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Mar 2023 09:42:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230223AbjCCOmn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Mar 2023 09:42:43 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A3FC39CD9
        for <linux-fsdevel@vger.kernel.org>; Fri,  3 Mar 2023 06:41:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677854514;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5uLk6wWbpW7safLpP+v7hD0RmnKnhmImbtUK7n+QOME=;
        b=fhT4hzYuEGgPN6ySNv/Rc7gl5KGu1kpDNB+/6IWyzG5NUi8tuECDG+cUUYqL+193NWIWqZ
        0k89AdC1oG/oH1ucX5Tb7JcU2rVEzqHaWZRcBW5QnXLZ6mM5EH3AghJ21dsCNuo/rK+PSX
        c5mY8/f8Jn9johKsd3HgNRB4Ww+ckqw=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-554-1rpoS6QuNoyNTOG9-T2kUg-1; Fri, 03 Mar 2023 09:41:48 -0500
X-MC-Unique: 1rpoS6QuNoyNTOG9-T2kUg-1
Received: by mail-il1-f200.google.com with SMTP id g14-20020a92dd8e000000b00316ea7ce6d3so1397856iln.15
        for <linux-fsdevel@vger.kernel.org>; Fri, 03 Mar 2023 06:41:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5uLk6wWbpW7safLpP+v7hD0RmnKnhmImbtUK7n+QOME=;
        b=lVZyJjNq6vailmvEWfYs52e/6rV7QnWfXdWqllKCk9OYG8rs8mHfeBxicFgpBfe4E/
         d96GZ+jwhyO5brxEbxYHZLsdtdiGzf+B02RqS5I7V6gqqVFvfks+pZy0XBPE6MhnyZea
         8M7NhmqdGNp+BFogo8intEGoo+1qHUg6sMTDBbz9KHEDFXlbqRi10OMM7f8xFyb4O8k/
         LgxQ35Y4QHC2bs6jlJadTXqFDwK+OR8Y29mQ4mM0v8JzDKnlwkkljDt2SfLM1A+wvr4k
         ZsXiGonhYxGthfrBY5Nc9v1RwaG+Lre3BnNCWFDhRXLoM8VNFa22kIY5W4WJfVaqtqTY
         AJfg==
X-Gm-Message-State: AO0yUKVn7aJNs9MfxpQSKDGXKl5PW/vCPcSMks+1tQBuiEPLapasyj66
        TP+7OiMJWMO4ElHtLiVfA9oZaKyKR4uBtiPzfKayJVDnYAnXrnnv8ZLeMauz62DJtnYiYqZMGuw
        iorCg7AcsdXHpnHCd461rNi2xOMIkhcUowLxv370dO2z/i4MABA==
X-Received: by 2002:a02:6386:0:b0:3c5:139d:609b with SMTP id j128-20020a026386000000b003c5139d609bmr695812jac.1.1677854504651;
        Fri, 03 Mar 2023 06:41:44 -0800 (PST)
X-Google-Smtp-Source: AK7set+1PuAYFPy9ZXXGkf+RGq7wWFak2DBlzo1ltrKeNssWFhHcEMNKvW1MDPdI2hvCBFx8j4FEHJOGBTHGiJ3Jw64=
X-Received: by 2002:a02:6386:0:b0:3c5:139d:609b with SMTP id
 j128-20020a026386000000b003c5139d609bmr695803jac.1.1677854504426; Fri, 03 Mar
 2023 06:41:44 -0800 (PST)
MIME-Version: 1.0
References: <e84d009fd32b7a02ceb038db5cf1737db91069d5.camel@redhat.com>
 <5958ef1a-b635-96f8-7840-0752138e75e8@linux.alibaba.com> <83829005-3f12-afac-9d05-8ba721a80b4d@linux.alibaba.com>
In-Reply-To: <83829005-3f12-afac-9d05-8ba721a80b4d@linux.alibaba.com>
From:   Alexander Larsson <alexl@redhat.com>
Date:   Fri, 3 Mar 2023 15:41:33 +0100
Message-ID: <CAL7ro1E_g9M1S6Eg45B63Sdfif4qrj7rdYSyWEW_OaOD833dUA@mail.gmail.com>
Subject: Re: [LSF/MM/BFP TOPIC] Composefs vs erofs+overlay
To:     Jingbo Xu <jefflexu@linux.alibaba.com>
Cc:     Gao Xiang <hsiangkao@linux.alibaba.com>,
        Christian Brauner <brauner@kernel.org>,
        Amir Goldstein <amir73il@gmail.com>,
        linux-fsdevel@vger.kernel.org, lsf-pc@lists.linux-foundation.org
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

On Wed, Mar 1, 2023 at 4:47=E2=80=AFAM Jingbo Xu <jefflexu@linux.alibaba.co=
m> wrote:
>
> Hi all,
>
> On 2/27/23 6:45 PM, Gao Xiang wrote:
> >
> > (+cc Jingbo Xu and Christian Brauner)
> >
> > On 2023/2/27 17:22, Alexander Larsson wrote:
> >> Hello,
> >>
> >> Recently Giuseppe Scrivano and I have worked on[1] and proposed[2] the
> >> Composefs filesystem. It is an opportunistically sharing, validating
> >> image-based filesystem, targeting usecases like validated ostree
> >> rootfs:es, validated container images that share common files, as well
> >> as other image based usecases.
> >>
> >> During the discussions in the composefs proposal (as seen on LWN[3])
> >> is has been proposed that (with some changes to overlayfs), similar
> >> behaviour can be achieved by combining the overlayfs
> >> "overlay.redirect" xattr with an read-only filesystem such as erofs.
> >>
> >> There are pros and cons to both these approaches, and the discussion
> >> about their respective value has sometimes been heated. We would like
> >> to have an in-person discussion at the summit, ideally also involving
> >> more of the filesystem development community, so that we can reach
> >> some consensus on what is the best apporach.
> >>
> >> Good participants would be at least: Alexander Larsson, Giuseppe
> >> Scrivano, Amir Goldstein, David Chinner, Gao Xiang, Miklos Szeredi,
> >> Jingbo Xu
> > I'd be happy to discuss this at LSF/MM/BPF this year. Also we've addres=
sed
> > the root cause of the performance gap is that
> >
> > composefs read some data symlink-like payload data by using
> > cfs_read_vdata_path() which involves kernel_read() and trigger heuristi=
c
> > readahead of dir data (which is also landed in composefs vdata area
> > together with payload), so that most composefs dir I/O is already done
> > in advance by heuristic  readahead.  And we think almost all exist
> > in-kernel local fses doesn't have such heuristic readahead and if we ad=
d
> > the similar stuff, EROFS could do better than composefs.
> >
> > Also we've tried random stat()s about 500~1000 files in the tree you sh=
ared
> > (rather than just "ls -lR") and EROFS did almost the same or better tha=
n
> > composefs.  I guess further analysis (including blktrace) could be show=
n by
> > Jingbo later.
> >
>
> The link path string and dirents are mix stored in a so-called vdata
> (variable data) section[1] in composefs, sometimes even in the same
> block (figured out by dumping the composefs image).  When doing lookup,
> composefs will resolve the link path.  It will read the link path string
> from vdata section through kernel_read(), along which those dirents in
> the following blocks are also read in by the heuristic readahead
> algorithm in kernel_read().  I believe this will much benefit the
> performance in the workload like "ls -lR".

This is interesting stuff, and honestly I'm a bit surprised other
filesystems don't try to readahead directory metadata to some degree
too. It seems inherent to all filesystems that they try to pack
related metadata near each other, so readahead would probably be
useful even for read-write filesystems, although even more so for
read-only filesystems (due to lack of fragmentation).

But anyway, this is sort of beside the current issue. There is nothing
inherent in composefs that makes it have to do readahead like this,
and correspondingly, if it is a good idea to do it, erofs could do it
too,

--=20
=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D=
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D
 Alexander Larsson                                Red Hat, Inc
       alexl@redhat.com         alexander.larsson@gmail.com

