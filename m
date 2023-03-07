Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5B5B6ADB36
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Mar 2023 10:57:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231139AbjCGJ5o (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Mar 2023 04:57:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230459AbjCGJ5j (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Mar 2023 04:57:39 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 799AD5615D
        for <linux-fsdevel@vger.kernel.org>; Tue,  7 Mar 2023 01:56:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678183001;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KoUQUqk0Tk16AH05lotUQDG6XAkp82NihC6ABFospAs=;
        b=P7z5D1ttJMzoRvjE7FY9zhhdeEaEglK2jzG6TgetF3OFhjIzyy3QZ1P9wvHmxmJwdQduVz
        Z9J8pKiXvaAq9WWeFmIUBTFf62sPTzQzwYT7PnBL86kWBeX/ZJeBcyTMf/Glpsv6HuuJBu
        mHfJOTPJBv4H8QHVTdANRncN01+XpnI=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-500-Y8JQrbiFO8OlC-pbhNA4CA-1; Tue, 07 Mar 2023 04:56:40 -0500
X-MC-Unique: Y8JQrbiFO8OlC-pbhNA4CA-1
Received: by mail-il1-f198.google.com with SMTP id m7-20020a924b07000000b003170cef3f12so6911240ilg.22
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Mar 2023 01:56:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678183000;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KoUQUqk0Tk16AH05lotUQDG6XAkp82NihC6ABFospAs=;
        b=6rODebelnnRzJK6+ftvucy4n1FJy0nphQahng7Qx+u4QI92xGyq8BxZi7iAvw7CvF4
         wiGcPLQmjKpmThDCfO7oFk7PYsUIxvJqu168atZw/umlWFcVFulX7wqw12/9XViwOFFq
         3v1k3ZXWOe5cSbG0dPlUWZmAM0f8h/HcV+S0kRw6ibotkAYJq8A8CkVbE1pZur4OCJeb
         uBlATkRsI/Zq26L2Qwm4g20FFmedojBH3/t6FiTFJaKXJJqsTgA/Q9BlIjF7kBkkJmkK
         lpQXVr+tH7CeWwKWTlcSXOMMfaojMONf+A87/B9lUA0N4xxqemPYndBVrQLN4Liul2JT
         VsfQ==
X-Gm-Message-State: AO0yUKXEl5fihi6N6eahNpRMHDi+HP5TO74kq+2Lka7W4Sf+v8ATg3Ff
        iAZZkLie3wO9c8sLE85/7qmuF4K5Q3saHeLy8OockaYeXpX8rZn2G/UKoJ0L37kWtK3KvgTGnwi
        +d80ZHYihDIP2tEiyYDZDr8sTl5eGZ43PVD+z7deiAA==
X-Received: by 2002:a92:c208:0:b0:30e:e796:23c1 with SMTP id j8-20020a92c208000000b0030ee79623c1mr6783081ilo.1.1678182999900;
        Tue, 07 Mar 2023 01:56:39 -0800 (PST)
X-Google-Smtp-Source: AK7set/TFBcHkCO8rATH10CymGqD9tL/eIbVgZ5bm29/yl+QaBnKwTQz7r89i4pZw1n2gUWJwfLPnHGqbconPHBBfZk=
X-Received: by 2002:a92:c208:0:b0:30e:e796:23c1 with SMTP id
 j8-20020a92c208000000b0030ee79623c1mr6783073ilo.1.1678182999657; Tue, 07 Mar
 2023 01:56:39 -0800 (PST)
MIME-Version: 1.0
References: <e84d009fd32b7a02ceb038db5cf1737db91069d5.camel@redhat.com>
 <CAL7ro1E7KY5yUJOLu6TY0RtAC5304sM3Lvk=zSCrqDrxTPW2og@mail.gmail.com>
 <CAL7ro1FZMRiep582LaiaqqxzYq_XeM2UMxvsHoT-guf_-bqSfg@mail.gmail.com>
 <e81d3776-8239-b8fa-1c64-bdb6f5cbe4df@linux.alibaba.com> <CAL7ro1GwDF1201StXw8xL9xL6y4jW1t+cbLPOmsRUp574+ewQQ@mail.gmail.com>
 <fb9f65b5-a867-1a26-1c74-8c83e5c47f31@linux.alibaba.com> <CAL7ro1Ezvs0V9vUBF_eiDRwvPE8gTemAK12unGLUgRfrC_wLeg@mail.gmail.com>
 <c6328bd6-3587-3e12-2ae0-652bbdc17a6a@linux.alibaba.com> <CAL7ro1FPKPWQvHteQq_t=u_LuR4B1Q5c=FBE-tRTN8CfoZCAHw@mail.gmail.com>
 <07b3a7e2-5514-1262-2510-7747337640cc@linux.alibaba.com> <2a9d79b0-1610-2f66-9a72-a8a938030247@linux.alibaba.com>
In-Reply-To: <2a9d79b0-1610-2f66-9a72-a8a938030247@linux.alibaba.com>
From:   Alexander Larsson <alexl@redhat.com>
Date:   Tue, 7 Mar 2023 10:56:28 +0100
Message-ID: <CAL7ro1GMAKrYG3gWJHx2UwVTQo=UjKWSH6iBbpoBO_a-ybbieQ@mail.gmail.com>
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

On Tue, Mar 7, 2023 at 10:38=E2=80=AFAM Gao Xiang <hsiangkao@linux.alibaba.=
com> wrote:
>
> On 2023/3/7 17:26, Gao Xiang wrote:
> >
> >
> > On 2023/3/7 17:07, Alexander Larsson wrote:
> >> On Tue, Mar 7, 2023 at 9:34=E2=80=AFAM Gao Xiang <hsiangkao@linux.alib=
aba.com> wrote:
> >>>
> >>>
> >>>
> >>> On 2023/3/7 16:21, Alexander Larsson wrote:
> >>>> On Mon, Mar 6, 2023 at 5:17=E2=80=AFPM Gao Xiang <hsiangkao@linux.al=
ibaba.com> wrote:
> >>>>
> >>>>>>> I tested the performance of "ls -lR" on the whole tree of
> >>>>>>> cs9-developer-rootfs.  It seems that the performance of erofs (ge=
nerated
> >>>>>>> from mkfs.erofs) is slightly better than that of composefs.  Whil=
e the
> >>>>>>> performance of erofs generated from mkfs.composefs is slightly wo=
rse
> >>>>>>> that that of composefs.
> >>>>>>
> >>>>>> I suspect that the reason for the lower performance of mkfs.compos=
efs
> >>>>>> is the added overlay.fs-verity xattr to all the files. It makes th=
e
> >>>>>> image larger, and that means more i/o.
> >>>>>
> >>>>> Actually you could move overlay.fs-verity to EROFS shared xattr are=
a (or
> >>>>> even overlay.redirect but it depends) if needed, which could save s=
ome
> >>>>> I/Os for your workloads.
> >>>>>
> >>>>> shared xattrs can be used in this way as well if you care such mino=
r
> >>>>> difference, actually I think inlined xattrs for your workload are j=
ust
> >>>>> meaningful for selinux labels and capabilities.
> >>>>
> >>>> Really? Could you expand on this, because I would think it will be
> >>>> sort of the opposite. In my usecase, the erofs fs will be read by
> >>>> overlayfs, which will probably access overlay.* pretty often.  At th=
e
> >>>> very least it will load overlay.metacopy and overlay.redirect for
> >>>> every lookup.
> >>>
> >>> Really.  In that way, it will behave much similiar to composefs on-di=
sk
> >>> arrangement now (in composefs vdata area).
> >>>
> >>> Because in that way, although an extra I/O is needed for verification=
,
> >>> and it can only happen when actually opening the file (so "ls -lR" is
> >>> not impacted.) But on-disk inodes are more compact.
> >>>
> >>> All EROFS xattrs will be cached in memory so that accessing
> >>> overlay.* pretty often is not greatly impacted due to no real I/Os
> >>> (IOWs, only some CPU time is consumed).
> >>
> >> So, I tried moving the overlay.digest xattr to the shared area, but
> >> actually this made the performance worse for the ls case. I have not
> >
> > That is much strange.  We'd like to open it up if needed.  BTW, did you
> > test EROFS with acl enabled all the time?
> >
> >> looked into the cause in detail, but my guess is that ls looks for the
> >> acl xattr, and such a negative lookup will cause erofs to look at all
> >> the shared xattrs for the inode, which means they all end up being
> >> loaded anyway. Of course, this will only affect ls (or other cases
> >> that read the acl), so its perhaps a bit uncommon.
> >
> > Yeah, in addition to that, I guess real acls could be landed in inlined
> > xattrs as well if exists...
> >
> >>
> >> Did you ever consider putting a bloom filter in the h_reserved area of
> >> erofs_xattr_ibody_header? Then it could return early without i/o
> >> operations for keys that are not set for the inode. Not sure what the
> >> computational cost of that would be though.
> >
> > Good idea!  Let me think about it, but enabling "noacl" mount
> > option isn't prefered if acl is no needed in your use cases.
>
>            ^ is preferred.

That is probably the right approach for the composefs usecase. But
even when you want acls, typically only just a few files have acls
set, so it might be interesting to handle the negative acl lookup case
more efficiently.

--=20
=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D=
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D
 Alexander Larsson                                Red Hat, Inc
       alexl@redhat.com         alexander.larsson@gmail.com

