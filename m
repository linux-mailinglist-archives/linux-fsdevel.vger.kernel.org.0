Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A48BC74D759
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Jul 2023 15:21:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231389AbjGJNVA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Jul 2023 09:21:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231624AbjGJNU7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Jul 2023 09:20:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6B30E5
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Jul 2023 06:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688995208;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BV4nji85a+mPY3kj67G42V3oBEYwbWqct70gcMhmixM=;
        b=LMKvrPyvSnsu3PuA0fiUDuke9HjS2WPEJv3+jmiLJMMuZAGHiD9bWXP1KH51xOMtprv/OX
        GQdvgfdgYNJ+W7EoFw/JCYg1kokNGS9oMycYNCR8pmZSaUT3nALh9p1fVO23r29D45rv1p
        d9VdGIHW6hIzWO/O1frNbQqFYH0OCTA=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-547-zlYMORwPNjWzo7aVlznyZw-1; Mon, 10 Jul 2023 09:20:08 -0400
X-MC-Unique: zlYMORwPNjWzo7aVlznyZw-1
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-55c1c7f872bso3292869a12.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Jul 2023 06:20:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688995206; x=1691587206;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BV4nji85a+mPY3kj67G42V3oBEYwbWqct70gcMhmixM=;
        b=gfEEHtA8VVL94VqY+u6e/Kf1oHc7YG6o3jb/mFBuf5TgsUwio1pnKMb/QtP08nh8Gr
         ua1bMbo2vXWLBDT5mE/vqpi0Kyucf8UuHSPIMFFDgbx2Qu/v0xtA3N1QG6/J4t6/4w0p
         nrvYmPjrSHCzTbjEm1pSbdcI5zW9XZliQLxvC//6u7tF/anru+xiK88GZkG4euPKgm1e
         uyx2RB8E0iOxybiPvNMDAvHloWNL9GtCqVtHDh7scbXXNqjKz98p4o0Ts2NMIU6hjzf8
         0fpoPWupR1QCCQTn/dNNCZGXjudQrdSzMl2FmzngT1TxOLohQbUwm3qu3cJm8ril7aN9
         0Mhw==
X-Gm-Message-State: ABy/qLaPeWVjHoIWjH7EIL19v/8F1xb054ccVWxEjb6dfOqFSib1kdnV
        aGAycjKb8SKe52sDmZ5Zzsy7+Inig23xSFZtiiKNnMP530v/8aBHkVMhqBsBmaAy5A0SL21s1A3
        7n9PooKottUxKxMY48OVenGDG6JBDA6WoG39IqezeQkAJRo52/0CQ
X-Received: by 2002:a17:902:7003:b0:1b3:d4ed:8306 with SMTP id y3-20020a170902700300b001b3d4ed8306mr10048106plk.19.1688995206246;
        Mon, 10 Jul 2023 06:20:06 -0700 (PDT)
X-Google-Smtp-Source: APBJJlG8SeibqeafomP0ohyldI7j5j7dJgFlJrmuNkW6V0W3Pc+EoS6medukPetid8d+FD0HSmKSEh57NmZCbZ2N7rM=
X-Received: by 2002:a17:902:7003:b0:1b3:d4ed:8306 with SMTP id
 y3-20020a170902700300b001b3d4ed8306mr10048091plk.19.1688995205937; Mon, 10
 Jul 2023 06:20:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230523085929.614A.409509F4@e16-tech.com> <20230528235314.7852.409509F4@e16-tech.com>
In-Reply-To: <20230528235314.7852.409509F4@e16-tech.com>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Mon, 10 Jul 2023 15:19:54 +0200
Message-ID: <CAHc6FU5YYADEE1m2skcZxOb5fC24JDcJvHtBoq6ZCttB3BhObA@mail.gmail.com>
Subject: Re: [Cluster-devel] gfs2 write bandwidth regression on 6.4-rc3
 compareto 5.15.y
To:     Wang Yugui <wangyugui@e16-tech.com>
Cc:     Bob Peterson <rpeterso@redhat.com>, cluster-devel@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Wang Yugui,

On Sun, May 28, 2023 at 5:53=E2=80=AFPM Wang Yugui <wangyugui@e16-tech.com>=
 wrote:
> Hi,
>
> > Hi,
> >
> > gfs2 write bandwidth regression on 6.4-rc3 compare to 5.15.y.
> >
> > we added  linux-xfs@ and linux-fsdevel@ because some related problem[1]
> > and related patches[2].
> >
> > we compared 6.4-rc3(rather than 6.1.y) to 5.15.y because some related p=
atches[2]
> > work only for 6.4 now.
> >
> > [1] https://lore.kernel.org/linux-xfs/20230508172406.1CF3.409509F4@e16-=
tech.com/
> > [2] https://lore.kernel.org/linux-xfs/20230520163603.1794256-1-willy@in=
fradead.org/
> >
> >
> > test case:
> > 1) PCIe3 SSD *4 with LVM
> > 2) gfs2 lock_nolock
> >     gfs2 attr(T) GFS2_AF_ORLOV
> >    # chattr +T /mnt/test
> > 3) fio
> > fio --name=3Dglobal --rw=3Dwrite -bs=3D1024Ki -size=3D32Gi -runtime=3D3=
0 -iodepth 1
> > -ioengine sync -zero_buffers=3D1 -direct=3D0 -end_fsync=3D1 -numjobs=3D=
1 \
> >       -name write-bandwidth-1 -filename=3D/mnt/test/sub1/1.txt \
> >       -name write-bandwidth-2 -filename=3D/mnt/test/sub2/1.txt \
> >       -name write-bandwidth-3 -filename=3D/mnt/test/sub3/1.txt \
> >       -name write-bandwidth-4 -filename=3D/mnt/test/sub4/1.txt
> > 4) patches[2] are applied to 6.4-rc3.
> >
> >
> > 5.15.y result
> >       fio WRITE: bw=3D5139MiB/s (5389MB/s),
> > 6.4-rc3 result
> >       fio  WRITE: bw=3D2599MiB/s (2725MB/s)
>
> more test result:
>
> 5.17.0  WRITE: bw=3D4988MiB/s (5231MB/s)
> 5.18.0  WRITE: bw=3D5165MiB/s (5416MB/s)
> 5.19.0  WRITE: bw=3D5511MiB/s (5779MB/s)
> 6.0.5   WRITE: bw=3D3055MiB/s (3203MB/s), WRITE: bw=3D3225MiB/s (3382MB/s=
)
> 6.1.30  WRITE: bw=3D2579MiB/s (2705MB/s)
>
> so this regression  happen in some code introduced in 6.0,
> and maybe some minor regression in 6.1 too?

thanks for this bug report. Bob has noticed a similar looking
performance regression recently, and it turned out that commit
e1fa9ea85ce8 ("gfs2: Stop using glock holder auto-demotion for now")
inadvertently caused buffered writes to fall back to writing single
pages instead of multiple pages at once. That patch was added in
v5.18, so it doesn't perfectly align with the regression history
you're reporting, but maybe there's something else going on that we're
not aware of.

In any case, the regression introduced by commit e1fa9ea85ce8 should
be fixed by commit c8ed1b359312 ("gfs2: Fix duplicate
should_fault_in_pages() call"), which ended up in v6.5-rc1.

Could you please check where we end up with that fix?

Thank you very much,
Andreas

