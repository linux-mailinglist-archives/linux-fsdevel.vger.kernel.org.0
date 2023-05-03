Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA8B56F52CB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 May 2023 10:10:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbjECIK2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 May 2023 04:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbjECIKM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 May 2023 04:10:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11BB64ED6
        for <linux-fsdevel@vger.kernel.org>; Wed,  3 May 2023 01:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683101263;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gAItFTPlViLA5pqMw1tfLrN9/2fArVuO7Mw/NYUVWFo=;
        b=bQdo5e+xJ7grSB6joR6BXdq6u2QyqpKi9AjGO7kngNkgBDj26Qv39YlS5Wn2BcTsqJnw8z
        KwjcgXM+Zd+snBFGAxfq2Vnox9Q/dW30HgIi5/AEDgdlUYofWhsYTg2qm9/DgDIrTrsfjN
        AExVcvkZaa8XNa8Fg3YUbGBVa8xJuLE=
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-502-PCqOry57NaenluX8yICd7Q-1; Wed, 03 May 2023 04:07:40 -0400
X-MC-Unique: PCqOry57NaenluX8yICd7Q-1
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-42f8d8ff18eso50300137.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 May 2023 01:07:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683101259; x=1685693259;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gAItFTPlViLA5pqMw1tfLrN9/2fArVuO7Mw/NYUVWFo=;
        b=Zm5iEE7xThcCzQyA20Nw3+v7azPQjFjPt8JC6kRSkKCLJwr2Xqji3f1Ksn7Oe274mm
         GbZIsQu6P+HicphVN2EMSX/P46La8ZUTwyvuMGsHxQDnrzOK3stphoD9s0DczEhbK3g+
         s+lv7OjY5/71jsqO10OXXeQhLac7d3ZEC6RVTuRKyh/3zLhOSF9seVtHyP1UP8LoQjNh
         YbgDmWCvBlxIBLsaIOxyqiwanTCKSQOBqiHkhHAEIsQYREZdT7r3trljSYUxoCgveso6
         5kxCyK1W9avtifW8JnQMqIUY7vQ5+RmjafK61cqrZXZCDHz/wdv9Wn4mQHECXup2Bkfw
         ATBw==
X-Gm-Message-State: AC+VfDyGU8Rd2aCotpNaAxS0mMhqAiiQC1g1ycgpP21nnPsqjOQuq9Cl
        Sb81aWBgC5d5Fh4iJCUrraU5C39NfRmBQ4nHn3vbHJ6CHS+K5UqrmNu7OWH/bNfDWvb7PX3m+5Q
        psNT+l+V1vHjhe+cX3yfbDEskfZ3W/4zahQ3Hg9YNew==
X-Received: by 2002:a05:6102:4423:b0:425:cf4e:f58 with SMTP id df35-20020a056102442300b00425cf4e0f58mr5826610vsb.2.1683101259595;
        Wed, 03 May 2023 01:07:39 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4gxwahabBGCrNHNF6s+lz4ioJ9i0off0x3X7IY8Rl43m4GKL65v9RDPFIN5Ni52UaiJ5vDPD2ER12791dZuv8=
X-Received: by 2002:a05:6102:4423:b0:425:cf4e:f58 with SMTP id
 df35-20020a056102442300b00425cf4e0f58mr5826607vsb.2.1683101259381; Wed, 03
 May 2023 01:07:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230503060450.GC3223426@dread.disaster.area>
In-Reply-To: <20230503060450.GC3223426@dread.disaster.area>
From:   Ming Lei <ming.lei@redhat.com>
Date:   Wed, 3 May 2023 16:07:28 +0800
Message-ID: <CAFj5m9+xC7ojwz-gA5T+PEiN9NEyUi+bp4D3XuEPD7hoPrZe-g@mail.gmail.com>
Subject: Re: [6.4-current oops] null ptr deref in blk_mq_sched_bio_merge()
 from blkdev readahead
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-block@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, axboe@kernel.dk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 3, 2023 at 2:06=E2=80=AFPM Dave Chinner <david@fromorbit.com> w=
rote:
>
> Hi folks,
>
> fstests running shared/032 on XFS with a default mkfs and mount
> config causes a panic in the block layer when userspace is operating
> directly on the block device like this:
>
> SECTION       -- xfs
> FSTYP         -- xfs (debug)
> PLATFORM      -- Linux/x86_64 test3 6.3.0-dgc+ #1792 SMP PREEMPT_DYNAMIC =
Wed May  3 15:20:20 AEST 2023
> MKFS_OPTIONS  -- -f -m rmapbt=3D1 /dev/pmem1
> MOUNT_OPTIONS -- -o dax=3Dnever -o context=3Dsystem_u:object_r:root_t:s0 =
/dev/pmem1 /mnt/scratch
>
> ....
>
> [   56.070695] run fstests shared/032 at 2023-05-03 15:21:55
> [   56.768890] BTRFS: device fsid 355df15c-7bc5-49b0-9b5d-dc25ce855a9d de=
vid 1 transid 6 /dev/pmem1 scanned by mkfs.btrfs (5836)
> [   57.285879]  pmem1: p1
> [   57.301845] BUG: kernel NULL pointer dereference, address: 00000000000=
000a8
> [   57.304562] #PF: supervisor read access in kernel mode
> [   57.306499] #PF: error_code(0x0000) - not-present page
> [   57.308414] PGD 0 P4D 0
> [   57.309401] Oops: 0000 [#1] PREEMPT SMP
> [   57.310876] CPU: 3 PID: 4478 Comm: (udev-worker) Not tainted 6.3.0-dgc=
+ #1792
> [   57.313517] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIO=
S 1.16.2-debian-1.16.2-1 04/01/2014
> [   57.317089] RIP: 0010:blk_mq_sched_bio_merge+0x7b/0x100

Hi Dave,

It is fixed by:

https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/commi=
t/?h=3Dfor-6.4/block&id=3D38c8e3dfb2a1be863b7f5aad7755d5e9727da8a5

Thanks,
Ming

