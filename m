Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F39AC3A24
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2019 18:16:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389894AbfJAQOt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Oct 2019 12:14:49 -0400
Received: from mail-lj1-f178.google.com ([209.85.208.178]:39283 "EHLO
        mail-lj1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731663AbfJAQOt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Oct 2019 12:14:49 -0400
Received: by mail-lj1-f178.google.com with SMTP id y3so14013202ljj.6
        for <linux-fsdevel@vger.kernel.org>; Tue, 01 Oct 2019 09:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=yDvojJDXIxy3QO5S8Y3gcgPCyfj7/QuWW9tp7qGw8GE=;
        b=l3fXBnnqj4iA/v0nlYfc28y1/3fgN6UZ6+5B7dl6d9l2S0ySU5MS+BKaBuX28kAKTB
         8X3UZqHlvEhrCr3rLAN7u0Qg7SvxXvGaHM3A0qgokIEyKihmVHSHPbgcScrHJFyH3zjh
         bFvqkEedAp8mZja9qk/Sa3iPBZANLVo1utohsQSYO14MugRPM4XOlXpZHUIGg4poXhMN
         UxFP4l6iDHvjOk3xx2Caa2x26P0tfxlV7S7het/3APVusFC7HEkJML3DfqM4LCfJjfQE
         mrQV884OtDAiLCNBSGO+BGScGEWfFweB3aqNJAv9eeCO7qEFXK3BOQP8WWiwrVVPd8ju
         poAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=yDvojJDXIxy3QO5S8Y3gcgPCyfj7/QuWW9tp7qGw8GE=;
        b=lkX5zzXAqpRI+SmE7FHwE7hixtEpIVJr8iBT3W6zuZoqC80ovJG/JIyWRv/wEalthZ
         /uizKk78aBqQPR6yH4jOLLd9nYap+WeH8Mc7YWkaB64Di94SScchtCoBiZctE4dgIyuG
         MeRF3FAOQvHY6dikpP3TvhNP7tdaCc4JNEdDEZdl97a8yOGoKwCJ1OanUJI5kZ4z6sfw
         q3Mx/1qINQqZ4A5xw9IkwhEUyt5YOErRZcUbSTC1/zqud2J2MDSQfQi2MG9NoeNszhkL
         OxZKde16HdzDrMtJEjZRyCntX7j4HEPQye9YUxwzRNQf50oHTTsa19K8mdeLf2s08QRA
         GRqg==
X-Gm-Message-State: APjAAAXHYIplfGdeJpucqgFymAFqXwefhiO87rHfPDjhhtvIdJoDmDsF
        VVTiYUKH0xmn/yVSOXDyLW/aLb1+3Zra4KZ57AdMIQ==
X-Google-Smtp-Source: APXvYqxyT6CymBW0fuxAKQZQMdDE/RvOuFp/Ng1zxh9dkMvgDBw0AI2Tn6dMhW6cqgMf87QxKUAvhznBMWtMPvHhvaU=
X-Received: by 2002:a2e:7f07:: with SMTP id a7mr718564ljd.173.1569946486543;
 Tue, 01 Oct 2019 09:14:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:e00f:0:0:0:0:0 with HTTP; Tue, 1 Oct 2019 09:14:45 -0700 (PDT)
From:   Daegyu Han <hdg9400@gmail.com>
Date:   Wed, 2 Oct 2019 01:14:45 +0900
Message-ID: <CAARcW+ob5=DGWAGZ=eoUTNGsYNnYez44nxSiYFrFwwuYFGyWeQ@mail.gmail.com>
Subject: How can I completely evict(remove) the inode data from memory and
 access the disk next time?
To:     linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi linux file system expert,

I've asked again the general question about Linux file systems.

For example, if there is a file a.txt in the path /foo/ bar,
what should I do to completely evict(remove) the inode of bar
directory from memory and read the inode via disk access?

A few weeks ago. I asked a question about dentry and Ted told me that
there is a negative dentry on Linux.

I tried to completely evict(remove) the dentry cache using FS API in
include/fs.h and dcache.h, and also evict the inode from memory, but I
failed.

The FS API I used is:
dput() // to drop usage count and remove from dentry cache
iput() // to drop usage count and remove from inode cache.

To be honest, I'm confused about which API to cope with my question.

As far as I know, even though metadata is released from the file
system cache, it is managed as an LRU list.

I also saw some code related to CPU cacheline.
When I look at the superblock structure, there are also inodes, dcache
lists, and LRUs.

How can I completely evict the inode from memory and make disk access
as mentioned above?

Thank you in advance.
Daegyu
