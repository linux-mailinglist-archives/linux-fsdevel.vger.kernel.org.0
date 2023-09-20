Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B245E7A7676
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Sep 2023 10:57:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233866AbjITI5P (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Sep 2023 04:57:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233797AbjITI5O (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Sep 2023 04:57:14 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE416C6
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Sep 2023 01:57:08 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1c469ab6935so109755ad.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Sep 2023 01:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695200228; x=1695805028; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gCaB4LVQz5Zw5EnS/afR9/bgS309JzKYOV6hPcD95GQ=;
        b=XNx4NC4GYkaqbHmCT5sap16QyjixxSxYHvkAWz6dTf2l1SPcW0OG4w1jONY4dpuUuR
         4E3CtmbJ0XPU+DXO8tL6HhsyfdJLL7H9mkwz4bnIEB7NO9tjbTxENLzK8FM7u42E6pSO
         i8Qp/oz+56DdF/JfOYwuxQeMEYmpUU4SV/a45da48005fcqb3zdLzID5Nxxc+h7K07T7
         OFF/oKoMoTlav2XL9/FWuyz+5AmhyUKfpwjHAT8b+6EHE8S/qzgnfI/PrvTBMOw8+4NY
         5XcpfOybZSCGQSbkkYNAFLOj3R0W59ALXFxYU37rrvsxaGnfuFJXr+DzSsXsqlaSCxYg
         bg4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695200228; x=1695805028;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gCaB4LVQz5Zw5EnS/afR9/bgS309JzKYOV6hPcD95GQ=;
        b=WMi7495ojBe4EotbHXv2IPixYwuzHjNCkVM0NeR05Hi1C/HsPuwLrCGEo/otovB0+V
         fxwGSZHsFIXpVkqHBHQcpJWv91eah4R2Ep1MzjoHlAtyrzlhM4NxwnNKUjfsFQ6PsKVO
         +FIyYZsS4z1qHZz8uyoS+Fe5oPShMIelhgmy/BuZB3MOdRP3ZXvv0rVpeAAOU4BYZXCO
         PXisqeaVnTdRtvHiR6kV8DKZKgst9wICvpef9z5bDNXFG6v0amwU1TU1BCQr/gCyJnFj
         HswZZ2BpWn223kNfCKaYyvHoEfSoClpefP5wlUPmMVDxbwpRGlVA3YozFOlwYdQE52Zs
         +wxA==
X-Gm-Message-State: AOJu0Yz2EVAbnkPO4ckB5j2+N8qPvPL2MO8MhYsGql5TpZqCt4QdMH9S
        24pfwY7RymptLsHWLV5MqgmE0Op0391pjVvT1V7y7w==
X-Google-Smtp-Source: AGHT+IG27sQVZz+H2ksdbYnMakCV8uuy/VU9E7xq+vEtRwplNSlDOY8vW8f2mbDcLnt16LsfQVyk9wbzoyZDZ9sWfHk=
X-Received: by 2002:a17:903:1c7:b0:1c1:d934:26bc with SMTP id
 e7-20020a17090301c700b001c1d93426bcmr169727plh.26.1695200228296; Wed, 20 Sep
 2023 01:57:08 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000e534bb0604959011@google.com> <ZPeaH+K75a0nIyBk@dread.disaster.area>
 <CANp29Y4AK9dzmpMj4E9iz3gqTwhG=-_7DfA8knrWYaHy4QxrEg@mail.gmail.com> <20230908082846.GB9560@lst.de>
In-Reply-To: <20230908082846.GB9560@lst.de>
From:   Aleksandr Nogikh <nogikh@google.com>
Date:   Wed, 20 Sep 2023 10:56:56 +0200
Message-ID: <CANp29Y5yx=F1w2s-jHbz1GVWCbOR_Z-gS488L6ERbWQTAX5dRQ@mail.gmail.com>
Subject: Re: [syzbot] [xfs?] INFO: task hung in clean_bdev_aliases
To:     Christoph Hellwig <hch@lst.de>
Cc:     Dave Chinner <david@fromorbit.com>,
        syzbot <syzbot+1fa947e7f09e136925b8@syzkaller.appspotmail.com>,
        djwong@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

#syz set subsystems: iomap

On Fri, Sep 8, 2023 at 10:28=E2=80=AFAM Christoph Hellwig <hch@lst.de> wrot=
e:
>
> On Wed, Sep 06, 2023 at 07:20:15PM +0200, Aleksandr Nogikh wrote:
> >
> > The reason why syzbot marked this report as xfs is that, per
> > MAINTAINERS, fs/iomap/ points to linux-xfs@vger.kernel.org. I can
> > adjust the rules syzbot uses so that these are routed to "block".
> >
> > But should MAINTAINERS actually also not relate IOMAP FILESYSTEM
> > LIBRARY with xfs in this case?
>
> I'd tag it with iomap, as it's a different subsystem just sharing
> the mailing list.  We also have iommu@lists.linux.dev for both the
> iommu and dma-mapping subsystems as a similar example.
>
> But what's also important for issues like this is that often the
> called library code (in this case iomap) if often not, or only
> partially at fault.  So capturing the calling context (in this
> case block) might also be useful.
>
> And to get out of these meta discussions:  I'll look into the actual
> issues in a bit, I'll try to find time despite travelling.
>
