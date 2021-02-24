Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5921324727
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Feb 2021 23:51:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235510AbhBXWu5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Feb 2021 17:50:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235330AbhBXWu4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Feb 2021 17:50:56 -0500
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97BD3C061574;
        Wed, 24 Feb 2021 14:50:16 -0800 (PST)
Received: by mail-ot1-x333.google.com with SMTP id c16so3883061otp.0;
        Wed, 24 Feb 2021 14:50:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=AJwgy5s6IIZ9waVTG+Qa1R17TyqtVhDR8SD9mifAfOM=;
        b=APE8Kc7Lk/4af15m4bMi2WNSQm0PuyeGREP5HcYv/un7+2ze7ab3c1sUyBR4pkVc7g
         mVHjmHtBs6hVsTI6z8vKkawQPkOMdHCS55s/v9OMVvnnBqd4VN+QIM9qCbGVzHMoHoX+
         szFblEc4EgBY6bT3zTpFoBdVo+W7yUKzYiyY4vlw904Y81nEtjHm11EKUhL5AFK+4JFO
         mD9p2hw80ZqCtnI2sscLgRubqi9eMfEHHCDiAimi4NulsgPj5YDR7b/OQFjAk+1OXGnM
         i7JBl4G9TQsPNvDRl7Na0If7gdIRh+QzXM82TN3RKBZ28+UsT4m0lzQTiOh/Vcrq4oES
         zf6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=AJwgy5s6IIZ9waVTG+Qa1R17TyqtVhDR8SD9mifAfOM=;
        b=DhZkgnazmO7vMk4HCBdOf2eDdZqGoN1EmyUB0f0jWHcBNe2qAT6b+RZyoLff8+J22x
         8a3YizBCYL8QT+FTziSIp8TihoLurBlQFmrDb0Dm4eOI/Kr+xD+oOmKWUrblyEsBx5Qz
         SxcEpvwg110/aYVvPCRUTgedfAsTWK8mRmmjM2306Gg9OZhZtqq/RNWBVGITy336FvH6
         Q859s0HmAH4rXxADKXpX3PW0iUty+a3Q1Bf/tIBuY0dSBPvQDUJqTixy/YTcWrJQjFfj
         Q921LGcmR/Pxi2pW1LXmspNZos5J3tABvsYez5+BS9XjRlMSxeoU6QxO25na0Kt4iviP
         +clg==
X-Gm-Message-State: AOAM533r03C480FwGfUT8eU47HFEGJJFEiz723Yg+8r0fL5gUYKyLN94
        7zFv3bf9ibZJwWk+jDr44mQp46pjkVaustnYhk+nvcWA+lU=
X-Google-Smtp-Source: ABdhPJyoTIZEwjkgBu+f7msVgJbrv/TbwvF9PgSxq6V+/LYYER93+eKB/7XUQiPq3itMUT5HoM/h6ffH3W9bkoCzDoU=
X-Received: by 2002:a05:6830:1688:: with SMTP id k8mr7910325otr.45.1614207015779;
 Wed, 24 Feb 2021 14:50:15 -0800 (PST)
MIME-Version: 1.0
From:   Amy Parker <enbyamy@gmail.com>
Date:   Wed, 24 Feb 2021 14:50:04 -0800
Message-ID: <CAE1WUT53F+xPT-Rt83EStGimQXKoU-rE+oYgcib87pjP4Sm0rw@mail.gmail.com>
Subject: Adding LZ4 compression support to Btrfs
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The compression options in Btrfs are great, and help save a ton of
space on disk. Zstandard works extremely well for this, and is fairly
fast. However, it can heavily reduce the speed of quick disks, does
not work well on lower-end systems, and does not scale well across
multiple cores. Zlib is even slower and worse on compression ratio,
and LZO suffers on both the compression ratio and speed.

I've been laying out my plans for a backup software recently, and
stumbled upon LZ4. Tends to hover around LZO compression ratios.
Performs better than Zstandard and LZO slightly for compression - but
significantly outpaces them on decompression, which matters
significantly more for users:

zstd 1.4.5:
 - ratio 2.884
 - compression 500 MiB/s
 - decompression 1.66 GiB/s
zlib 1.2.11:
 - ratio 2.743
 - compression 90 MiB/s
 - decompression 400 MiB/s
lzo 2.10:
 - ratio 2.106
 - compression 690 MiB/s
 - decompression 820 MiB/s
lz4 1.9.2:
 - ratio 2.101
 - compression 740 MiB/s
 - decompression 4.5 GiB/s

LZ4's speeds are high enough to allow many applications which
previously declined to use any compression due to speed to increase
their possible space while keeping fast write and especially read
access.

What're thoughts like on adding something like LZ4 as a compression
option in btrfs? Is it feasible given the current implementation of
compression in btrfs?

   -Amy IP
