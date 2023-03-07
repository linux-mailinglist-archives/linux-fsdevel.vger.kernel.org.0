Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B9866AD9E0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Mar 2023 10:08:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbjCGJIw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Mar 2023 04:08:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbjCGJIu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Mar 2023 04:08:50 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC2C4274AE
        for <linux-fsdevel@vger.kernel.org>; Tue,  7 Mar 2023 01:08:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678180085;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dpiUx3zGKux9wdXXDvIFxrkb+UsNID/89koJxMZ33YU=;
        b=hwz0oHH/M3lRitHSE+jCA9/lLbslj8WzMTliR34elBwlEjwQU6xuGtEy9h8cH/5rsgdhQR
        nPQahFxnGD51Hm/QdICnfFnuKZnteJoXKFGchJv5sZVoBguM3WHvu8m8KUOTmjSxJjwQBQ
        T6ozkZ/eGJKyhl32aEBvd23pbvcRNQY=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-583-D_OxrcXwPganelqE9FpG7g-1; Tue, 07 Mar 2023 04:08:03 -0500
X-MC-Unique: D_OxrcXwPganelqE9FpG7g-1
Received: by mail-io1-f72.google.com with SMTP id a21-20020a5d9595000000b0074c9dc19e16so6667165ioo.15
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Mar 2023 01:08:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678180083;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dpiUx3zGKux9wdXXDvIFxrkb+UsNID/89koJxMZ33YU=;
        b=KSfkBFzKj+IlvtgCApevAiClD+xWEMwdRS1r/PGxL6x8z26qsVO+fqGmFwQrzRkyVe
         CXNoec7oysksyXFXtuRxP7Tgqo13SCil2vJ+1m46ANeC2+af0qlHxEVlA4FJIP5+wb+Y
         DdeCIx5H5a541d1RsgjOSApEp4GKVbJbTAnFqTd5HkRPLhDazK29/j9gGFneJD6m0p7/
         6l1O7+/eQDT2AX+x6c0XfuT1MaSxRyieoP0t2Mzr/nN6lv7yeQQmCvSTk57FSY+ojiIv
         FZkg+2TCH8AUQww0j5RlAbzvJvMj1+pHSUqD/kNG1FEMhw5NO7ggBxiHih/cuj7TWxSh
         onKg==
X-Gm-Message-State: AO0yUKXdvPzwV5r9Q0g+tKsR/PchlDZXR8ccr6gz5mszkELCwQkAofl4
        V+o7uPpw0UPU+bjJLtQz6plBbeeByFvCp8llfXprT0SkSco8AIubjaUDzd9d7ywToKR/yNgWQJq
        jZa0nbsdfZy4zEYVjC5TDblmYZ8ciwTvf8ILGmD62tg==
X-Received: by 2002:a05:6e02:f50:b0:316:ed77:e325 with SMTP id y16-20020a056e020f5000b00316ed77e325mr6881860ilj.1.1678180083147;
        Tue, 07 Mar 2023 01:08:03 -0800 (PST)
X-Google-Smtp-Source: AK7set/E3BFP5y07YEl67msa2F8qHRKBpLfKJEafqYFWKzSAb8r9U+dF1EKeyYQgDrXCmB0c3E8nDnA+gf05sCMJ9TY=
X-Received: by 2002:a05:6e02:f50:b0:316:ed77:e325 with SMTP id
 y16-20020a056e020f5000b00316ed77e325mr6881858ilj.1.1678180082868; Tue, 07 Mar
 2023 01:08:02 -0800 (PST)
MIME-Version: 1.0
References: <e84d009fd32b7a02ceb038db5cf1737db91069d5.camel@redhat.com>
 <CAL7ro1E7KY5yUJOLu6TY0RtAC5304sM3Lvk=zSCrqDrxTPW2og@mail.gmail.com>
 <CAL7ro1FZMRiep582LaiaqqxzYq_XeM2UMxvsHoT-guf_-bqSfg@mail.gmail.com>
 <e81d3776-8239-b8fa-1c64-bdb6f5cbe4df@linux.alibaba.com> <CAL7ro1GwDF1201StXw8xL9xL6y4jW1t+cbLPOmsRUp574+ewQQ@mail.gmail.com>
 <fb9f65b5-a867-1a26-1c74-8c83e5c47f31@linux.alibaba.com> <CAL7ro1Ezvs0V9vUBF_eiDRwvPE8gTemAK12unGLUgRfrC_wLeg@mail.gmail.com>
 <c6328bd6-3587-3e12-2ae0-652bbdc17a6a@linux.alibaba.com>
In-Reply-To: <c6328bd6-3587-3e12-2ae0-652bbdc17a6a@linux.alibaba.com>
From:   Alexander Larsson <alexl@redhat.com>
Date:   Tue, 7 Mar 2023 10:07:51 +0100
Message-ID: <CAL7ro1FPKPWQvHteQq_t=u_LuR4B1Q5c=FBE-tRTN8CfoZCAHw@mail.gmail.com>
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

On Tue, Mar 7, 2023 at 9:34=E2=80=AFAM Gao Xiang <hsiangkao@linux.alibaba.c=
om> wrote:
>
>
>
> On 2023/3/7 16:21, Alexander Larsson wrote:
> > On Mon, Mar 6, 2023 at 5:17=E2=80=AFPM Gao Xiang <hsiangkao@linux.aliba=
ba.com> wrote:
> >
> >>>> I tested the performance of "ls -lR" on the whole tree of
> >>>> cs9-developer-rootfs.  It seems that the performance of erofs (gener=
ated
> >>>> from mkfs.erofs) is slightly better than that of composefs.  While t=
he
> >>>> performance of erofs generated from mkfs.composefs is slightly worse
> >>>> that that of composefs.
> >>>
> >>> I suspect that the reason for the lower performance of mkfs.composefs
> >>> is the added overlay.fs-verity xattr to all the files. It makes the
> >>> image larger, and that means more i/o.
> >>
> >> Actually you could move overlay.fs-verity to EROFS shared xattr area (=
or
> >> even overlay.redirect but it depends) if needed, which could save some
> >> I/Os for your workloads.
> >>
> >> shared xattrs can be used in this way as well if you care such minor
> >> difference, actually I think inlined xattrs for your workload are just
> >> meaningful for selinux labels and capabilities.
> >
> > Really? Could you expand on this, because I would think it will be
> > sort of the opposite. In my usecase, the erofs fs will be read by
> > overlayfs, which will probably access overlay.* pretty often.  At the
> > very least it will load overlay.metacopy and overlay.redirect for
> > every lookup.
>
> Really.  In that way, it will behave much similiar to composefs on-disk
> arrangement now (in composefs vdata area).
>
> Because in that way, although an extra I/O is needed for verification,
> and it can only happen when actually opening the file (so "ls -lR" is
> not impacted.) But on-disk inodes are more compact.
>
> All EROFS xattrs will be cached in memory so that accessing
> overlay.* pretty often is not greatly impacted due to no real I/Os
> (IOWs, only some CPU time is consumed).

So, I tried moving the overlay.digest xattr to the shared area, but
actually this made the performance worse for the ls case. I have not
looked into the cause in detail, but my guess is that ls looks for the
acl xattr, and such a negative lookup will cause erofs to look at all
the shared xattrs for the inode, which means they all end up being
loaded anyway. Of course, this will only affect ls (or other cases
that read the acl), so its perhaps a bit uncommon.

Did you ever consider putting a bloom filter in the h_reserved area of
erofs_xattr_ibody_header? Then it could return early without i/o
operations for keys that are not set for the inode. Not sure what the
computational cost of that would be though.

--=20
=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D=
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D
 Alexander Larsson                                Red Hat, Inc
       alexl@redhat.com         alexander.larsson@gmail.com

