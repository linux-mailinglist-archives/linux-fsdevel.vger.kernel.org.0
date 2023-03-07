Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 153096ADAE4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Mar 2023 10:49:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbjCGJs4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Mar 2023 04:48:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230235AbjCGJsF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Mar 2023 04:48:05 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 269EF5BCB7
        for <linux-fsdevel@vger.kernel.org>; Tue,  7 Mar 2023 01:47:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678182424;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YJR575JV8kX2knbCDipTxEgBqjAwBc9caRJBS/vVxBw=;
        b=c0/+NoGab2kzgJIp06RdBYEyt5BxRFIHjIr1m6b3FLMEhfe8qYy6DIekdM5kDR/lPe5Y3s
        kH3A1lHQhl83o/VRcVMF0JjKJgIJ3QusOty26qp5uSoc2VWVTSbzROUwc5OGRxXIIoqrME
        oNIonapPUd77Bn2R2fTPo/kHv2VJ76s=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-376-b6jXsSzbNBy7lZNXbxYbgg-1; Tue, 07 Mar 2023 04:47:02 -0500
X-MC-Unique: b6jXsSzbNBy7lZNXbxYbgg-1
Received: by mail-io1-f70.google.com with SMTP id y187-20020a6bc8c4000000b0074d28aa136dso6760208iof.13
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Mar 2023 01:47:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678182422;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YJR575JV8kX2knbCDipTxEgBqjAwBc9caRJBS/vVxBw=;
        b=7uKJvg9yf0pwfNJxDKY6oLeo1HqBymhQCeEMntfigEhLOEzdTBZvKHs/0FPgvCgQ3j
         vpSiNIe3t76Dw5xxwZiXAMZKBRwVTIVeFnYtxCG/83xwhFnj7GLiGr1V9+qKrC4OLV0z
         dE+kmw2o3zi1/YFTHreobz/Sk6DKySRUTPEsK7hbUix+3T2J7mVunrleY0FwAcSLCCWS
         slBRszi/x+2qMVt05L62egT5IiIpvYxsWzdngrPF0QozQ+g7rasOoC2vaullbzvoqq9+
         trvj0M1wyB6LvccwWdqGBDbX5VtBJ5rxhH6YihyXBSpkwRXllCIXV/DUXX6oqdi8L8xk
         Gu/A==
X-Gm-Message-State: AO0yUKUXmYgQtBJsCcFk5LGOtAbfQddyuEqiPSEl6Qjm8x+ayVbudOVR
        lsFj2pAEnBQnYSs03xmcGKxb4mZSAjd6ns8SSOaMCiuGUHYTd2RZL4WpGf4AL19weoe2lmIIwYR
        6HShRc69aidMrA/MWIcDXKTcSkUzOdPMx7DKcCyCSHA==
X-Received: by 2002:a6b:fc05:0:b0:744:d7fc:7a4f with SMTP id r5-20020a6bfc05000000b00744d7fc7a4fmr6621895ioh.1.1678182421806;
        Tue, 07 Mar 2023 01:47:01 -0800 (PST)
X-Google-Smtp-Source: AK7set9ZMLpDtuSN4yGSKvKxTlwHPvJjeQKLB0B2tDBLz+u/qnTLTdYhC8ngwmjT0dtpjkwQajkM7gCJtWScsxUATPc=
X-Received: by 2002:a6b:fc05:0:b0:744:d7fc:7a4f with SMTP id
 r5-20020a6bfc05000000b00744d7fc7a4fmr6621887ioh.1.1678182421512; Tue, 07 Mar
 2023 01:47:01 -0800 (PST)
MIME-Version: 1.0
References: <e84d009fd32b7a02ceb038db5cf1737db91069d5.camel@redhat.com>
 <CAL7ro1E7KY5yUJOLu6TY0RtAC5304sM3Lvk=zSCrqDrxTPW2og@mail.gmail.com>
 <CAL7ro1FZMRiep582LaiaqqxzYq_XeM2UMxvsHoT-guf_-bqSfg@mail.gmail.com>
 <e81d3776-8239-b8fa-1c64-bdb6f5cbe4df@linux.alibaba.com> <CAL7ro1GwDF1201StXw8xL9xL6y4jW1t+cbLPOmsRUp574+ewQQ@mail.gmail.com>
 <fb9f65b5-a867-1a26-1c74-8c83e5c47f31@linux.alibaba.com> <CAL7ro1Ezvs0V9vUBF_eiDRwvPE8gTemAK12unGLUgRfrC_wLeg@mail.gmail.com>
 <c6328bd6-3587-3e12-2ae0-652bbdc17a6a@linux.alibaba.com> <CAL7ro1FPKPWQvHteQq_t=u_LuR4B1Q5c=FBE-tRTN8CfoZCAHw@mail.gmail.com>
 <07b3a7e2-5514-1262-2510-7747337640cc@linux.alibaba.com>
In-Reply-To: <07b3a7e2-5514-1262-2510-7747337640cc@linux.alibaba.com>
From:   Alexander Larsson <alexl@redhat.com>
Date:   Tue, 7 Mar 2023 10:46:50 +0100
Message-ID: <CAL7ro1GWQvF+u9eChhDiBcm-YCWiWGSafHJezOSq5K2j-tQfrw@mail.gmail.com>
Subject: Re: [LSF/MM/BFP TOPIC] Composefs vs erofs+overlay
To:     Gao Xiang <hsiangkao@linux.alibaba.com>
Cc:     Jingbo Xu <jefflexu@linux.alibaba.com>,
        lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        Amir Goldstein <amir73il@gmail.com>,
        Christian Brauner <brauner@kernel.org>,
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

On Tue, Mar 7, 2023 at 10:26=E2=80=AFAM Gao Xiang <hsiangkao@linux.alibaba.=
com> wrote:
> On 2023/3/7 17:07, Alexander Larsson wrote:
> > On Tue, Mar 7, 2023 at 9:34=E2=80=AFAM Gao Xiang <hsiangkao@linux.aliba=
ba.com> wrote:
> >>
> >>
> >>
> >> On 2023/3/7 16:21, Alexander Larsson wrote:
> >>> On Mon, Mar 6, 2023 at 5:17=E2=80=AFPM Gao Xiang <hsiangkao@linux.ali=
baba.com> wrote:
> >>>
> >>>>>> I tested the performance of "ls -lR" on the whole tree of
> >>>>>> cs9-developer-rootfs.  It seems that the performance of erofs (gen=
erated
> >>>>>> from mkfs.erofs) is slightly better than that of composefs.  While=
 the
> >>>>>> performance of erofs generated from mkfs.composefs is slightly wor=
se
> >>>>>> that that of composefs.
> >>>>>
> >>>>> I suspect that the reason for the lower performance of mkfs.compose=
fs
> >>>>> is the added overlay.fs-verity xattr to all the files. It makes the
> >>>>> image larger, and that means more i/o.
> >>>>
> >>>> Actually you could move overlay.fs-verity to EROFS shared xattr area=
 (or
> >>>> even overlay.redirect but it depends) if needed, which could save so=
me
> >>>> I/Os for your workloads.
> >>>>
> >>>> shared xattrs can be used in this way as well if you care such minor
> >>>> difference, actually I think inlined xattrs for your workload are ju=
st
> >>>> meaningful for selinux labels and capabilities.
> >>>
> >>> Really? Could you expand on this, because I would think it will be
> >>> sort of the opposite. In my usecase, the erofs fs will be read by
> >>> overlayfs, which will probably access overlay.* pretty often.  At the
> >>> very least it will load overlay.metacopy and overlay.redirect for
> >>> every lookup.
> >>
> >> Really.  In that way, it will behave much similiar to composefs on-dis=
k
> >> arrangement now (in composefs vdata area).
> >>
> >> Because in that way, although an extra I/O is needed for verification,
> >> and it can only happen when actually opening the file (so "ls -lR" is
> >> not impacted.) But on-disk inodes are more compact.
> >>
> >> All EROFS xattrs will be cached in memory so that accessing
> >> overlay.* pretty often is not greatly impacted due to no real I/Os
> >> (IOWs, only some CPU time is consumed).
> >
> > So, I tried moving the overlay.digest xattr to the shared area, but
> > actually this made the performance worse for the ls case. I have not
>
> That is much strange.  We'd like to open it up if needed.  BTW, did you
> test EROFS with acl enabled all the time?

These were all with acl enabled.

And, to test this, I compared "ls -lR" and "ls -ZR", which do the same
per-file syscalls, except the later doesn't try to read the
system.posix_acl_access xattr. The result is:

xattr:        inlined | not inlined
------------+---------+------------
ls -lR cold |  708    |  721
ls -lR warm |  415    |  412
ls -ZR cold |  522    |  512
ls -ZR warm |  283    |  279

In the ZR case the out-of band digest is a win, but not in the lR
case, which seems to mean the failed lookup of the acl xattr is to
blame here.

Also, very interesting is the fact that the warm cache difference for
these to is so large. I guess that is because most other inode data is
cached, but the xattrs lookups are not. If you could cache negative
xattr lookups that seems like a large win. This can be either via a
bloom cache in the disk format or maybe even just some in-memory
negative lookup caches for the inode, maybe even special casing the
acl xattrs.

> > looked into the cause in detail, but my guess is that ls looks for the
> > acl xattr, and such a negative lookup will cause erofs to look at all
> > the shared xattrs for the inode, which means they all end up being
> > loaded anyway. Of course, this will only affect ls (or other cases
> > that read the acl), so its perhaps a bit uncommon.
>
> Yeah, in addition to that, I guess real acls could be landed in inlined
> xattrs as well if exists...

Yeah, but that doesn't help with the case where they don't exist.

> BTW, if you have more interest in this way, we could get in
> touch in a more effective way to improve EROFS in addition to
> community emails except for the userns stuff

I don't really have time to do any real erofs specific work. These are
just some ideas that i got looking at these results.

--=20
=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D=
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D
 Alexander Larsson                                Red Hat, Inc
       alexl@redhat.com         alexander.larsson@gmail.com

