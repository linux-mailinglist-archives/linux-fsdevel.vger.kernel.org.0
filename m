Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2993A76185F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jul 2023 14:29:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231922AbjGYM3r (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Jul 2023 08:29:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjGYM3r (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Jul 2023 08:29:47 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CCF71718;
        Tue, 25 Jul 2023 05:29:45 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1bb81809ca8so25583065ad.3;
        Tue, 25 Jul 2023 05:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690288185; x=1690892985;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ymQ+FiFZ56PMVsSIsuwOlZ4AMBPQrUUmZoPILmBCguA=;
        b=EzyV9G1njSOfNwhJWq4d2whkbyspecS6NO1Ix7kxDKg3vy+pu5vgxTx1RMyT/Scd85
         xgQJ4GI3l4UbspExgnDqs/1idIR1Lbu3FPmYwXwhU3ut1tls9HEc+0/x5buUU28R/1q0
         P+phBbSTm+PDrZUfeXKbML3AyLsU+jZnvlIpzLXTlltONk3qm5xsI9hlLfaNFCoQBWQQ
         qtmXCT4ll3nXLpXCwN8hP8IrcQ//Iff1zKJ1CTGfVi1ZaxVCM2cOgLpXuYKwE5/Eu9GX
         k8oNp5USaHHZ/h5ETI5CkyMMylFH7Fnn3Gc4kQTbVsksBIB946EcOV/HZkpmmQHy6pee
         ps3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690288185; x=1690892985;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ymQ+FiFZ56PMVsSIsuwOlZ4AMBPQrUUmZoPILmBCguA=;
        b=QSNzdLqTINt1z94SNquocIiH8K8iqrI+jYSmR+2lcXn0zaNsYXxc96R2aP2sXs3QJl
         4m4MNKki+Rek3+Rmgjv2eVA7k6Ng7snJF/ag77xQXxE5QDPlqs9Tuh0NEjNVlVNEQlow
         YLh+16DGne9q1J3hlLoYkvT8ARqPwlchvVfAkZuUc6FRygcL3wgDfz3w8W09sPIHbx+E
         BBGhH9zvVeIEMobXNsqAdL8bTwSI6Dm5uJiBDU2VgjopaYdmi9v1x7CwKuHnI0MRtT3H
         z5X+7AtRnOnU8BDLk6RlAiwJ2JNCqAxJp+kj1gU6fdypijaxLkb4QthR/AsSr/TdujYA
         tXog==
X-Gm-Message-State: ABy/qLYW9RjD8weLwZYKxJQiXQ2zxVdZE1F5ige8mug55dFx42jGLWYn
        fGa5QHuBXAPpUx9g9xy6Ipk=
X-Google-Smtp-Source: APBJJlFI9ad2PhbUENHenimsoEtxA85StEwAMTYsibyTX5LDiHF/GL0beYkJBjOnXMyF5pa04xxkFA==
X-Received: by 2002:a17:902:d305:b0:1bb:a125:f828 with SMTP id b5-20020a170902d30500b001bba125f828mr5641548plc.68.1690288184906;
        Tue, 25 Jul 2023 05:29:44 -0700 (PDT)
Received: from dw-tp.localdomain ([49.207.232.207])
        by smtp.gmail.com with ESMTPSA id n12-20020a170903110c00b001b89b1b99fasm10941795plh.243.2023.07.25.05.29.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 05:29:44 -0700 (PDT)
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     "Darrick J . Wong" <darrick.wong@oracle.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [GIT PULL] iomap: Add per-block dirty state tracking to iomap
Date:   Tue, 25 Jul 2023 17:59:32 +0530
Message-Id: <20230725122932.144426-1-ritesh.list@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello Darrick,

Here's the pull request for adding per-block dirty tracking bitmap support to iomap.

The following changes since commit d42bd17c6a20638ddf96862bfc0c47e481c28392:

  Merge tag 'large-folio-writes' of git://git.infradead.org/users/willy/pagecache into iomap-6.6-merge (2023-07-24 16:12:29 -0700)

are available in the Git repository at:

  https://github.com/riteshharjani/linux tags/iomap-per-block-dirty-tracking

for you to fetch changes up to 4ce02c67972211be488408c275c8fbf19faf29b3:

  iomap: Add per-block dirty state tracking to improve performance (2023-07-25 10:55:56 +0530)

----------------------------------------------------------------------
iomap today only tracks per-block update state bitmap, this series extends
the support by adding per-block dirty state bitmap tracking to iomap buffered
I/O path. This helps in reducing the write amplification and improve
write performance for large folio writes and for platforms with higher
pagesize compared to blocksize.

We have seen ~83% performance improvement with these patches using
database benchmarking tests, with XFS on 64k pagesize.
fio benchmark (as shown in the last patch which adds dirty tracking
support) showed close to 16x performance improvement when tested with
64K pagesize on 4k blocksize XFS using nvme on Power.

------------------------------------------------------------------------
Ritesh Harjani (IBM) (8):
  iomap: Rename iomap_page to iomap_folio_state and others
  iomap: Drop ifs argument from iomap_set_range_uptodate()
  iomap: Add some uptodate state handling helpers for ifs state bitmap
  iomap: Fix possible overflow condition in iomap_write_delalloc_scan
  iomap: Use iomap_punch_t typedef
  iomap: Refactor iomap_write_delalloc_punch() function out
  iomap: Allocate ifs in ->write_begin() early
  iomap: Add per-block dirty state tracking to improve performance

 fs/gfs2/aops.c         |   2 +-
 fs/iomap/buffered-io.c | 411 +++++++++++++++++++++++++++++------------
 fs/xfs/xfs_aops.c      |   2 +-
 fs/zonefs/file.c       |   2 +-
 include/linux/iomap.h  |   1 +
 5 files changed, 292 insertions(+), 126 deletions(-)

--
-ritesh


