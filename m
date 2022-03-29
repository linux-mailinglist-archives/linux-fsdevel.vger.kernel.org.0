Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C66F4EA826
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Mar 2022 08:56:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233183AbiC2G5x (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Mar 2022 02:57:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233176AbiC2G5w (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Mar 2022 02:57:52 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD5592E9CC;
        Mon, 28 Mar 2022 23:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1648536970; x=1680072970;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=W9rT6vlqc3SodDBXU4g+fNkpnCbYcSgS83F6qqt7cis=;
  b=DlLMq2um60+LryjPgeKZJnN6cK6odvkKq0CmnoOU1PgPtrPnkbhgpeUg
   w+ad34j30EQ41lJ6F0IYgV47KCaEboVzt/uXCkt5IHneoCbDJSAYCtDc3
   Mu4jTUeonmfCMsD4wnDByATRA0GKtGarDRnOmVDhlcEeVhmfMRkIv2mLf
   3FQj7nndsGtku7+12WybqV+WrDd/dPviIKMXVTs5YYA3oOU6UUPmwPOhZ
   MEANELFv+OidkpmTlJEKoI5yx+K46YwwfGNb+LMVrEJV+MbRv89OPNIDi
   aKeVS82PSgDwDAeOyNhw59ylfOuIzfVLlXNlJ5qhEKJDxGbkgRLaELabY
   A==;
X-IronPort-AV: E=Sophos;i="5.90,219,1643644800"; 
   d="scan'208";a="197429223"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 29 Mar 2022 14:56:09 +0800
IronPort-SDR: oXm6DLhvtUYCi4KjU8MI0N/MClQ2GhBntpU9WKHFA1pnR3YcmEZu9PoBkPwqMQU/O1OwF0gkuN
 BlCFRcw37R3+gZIcbrugcyxCTQ8kXyRqYiVcTrYWvF2K4Zg8n94TDuQtQsO/nslEgbhwTW7A3e
 yAXc8A1mxnYMXfmKrjJ4InTY2zFKWDmmAfP9h4EBNcQJnldAIWVmbq/HTEUjp7qHZAmtesDKnf
 cphVX89wJ8itSwHLk/bey1rExM3gD56+DPNwBqXEOnXcos+Z19XoER/Rxq8ChF+7q5da5ztMH+
 IRpGMTmMmDvpD4531fiFvNjm
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Mar 2022 23:27:50 -0700
IronPort-SDR: hdEHxztRdcyrnqLhQ0VC7ZKQuKpzbfsNyr0vAnAgwWnTwsDOuQkS2ze7ll+U4Br8haqQ9xod4K
 nfVVVki3hzdTpDMEzmFdVAQAlD4JTDjnR7390tTX+KJG+TTIoErTtAU7egXw5UAj8OzK9G8t88
 c+g434xPLTr6qyUMD9whnOnEfciENFa8UdoJ4kjyHakiGLd/JwnsJXXED5C86P/xeHuR/b3kJx
 Sn3jx0kPYhuFI/MK5w3O9DICNB1NThHZJBKwzmcNQd5cyOGmAWWV0M9yCJJbmTVaXbthG0JJsZ
 6yc=
WDCIronportException: Internal
Received: from 2zx6353.ad.shared (HELO naota-xeon.wdc.com) ([10.225.48.64])
  by uls-op-cesaip02.wdc.com with ESMTP; 28 Mar 2022 23:56:05 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     johannes.thumshirn@wdc.com, linux-fsdevel@vger.kernel.org,
        viro@zeniv.linux.org.uk, david@fromorbit.com,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v4 0/3] protect relocation with sb_start_write
Date:   Tue, 29 Mar 2022 15:55:57 +0900
Message-Id: <cover.1648535838.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This series is a follow-up to the series below [1]. The old series added
an assertion to btrfs_relocate_chunk() to check if it is protected
with sb_start_write(). However, it revealed another location we need
to add sb_start_write() [2].

Also, this series moved the ASSERT from btrfs_relocate_chunk() to
btrfs_relocate_block_group() because we do not need to call
sb_start_write() on a non-data block group [3].

[1] https://lore.kernel.org/linux-btrfs/cover.1645157220.git.naohiro.aota@wdc.com/T/

[2] https://lore.kernel.org/linux-btrfs/cover.1645157220.git.naohiro.aota@wdc.com/T/#e06eecc07ce1cd1e45bfd30a374bd2d15b4fd76d8

[3] https://lore.kernel.org/linux-btrfs/YjMSaLIhKNcKUuHM@debian9.Home/

Patch 1 adds sb_{start,end}_write() to the resumed async balancing.

Patches 2 and 3 add an ASSERT to catch a future error.

--
v4:
  - Fix subject of patch 2 (Filipe)
  - Revise the comment for the ASSERT (Filipe)
v3:
  - Only add sb_write_started(), which we really use. (Dave Chinner)
  - Drop patch "btrfs: mark device addition as mnt_want_write_file" (Filipe Manana)
  - Narrow asserting region to btrfs_relocate_block_group() and check only
    when the BG is data BG. (Filipe Manana)
v2:
  - Use mnt_want_write_file() instead of sb_start_write() for
    btrfs_ioctl_add_dev()
  - Drop bogus fixes tag
  - Change the stable target to meaningful 4.9+

Naohiro Aota (3):
  btrfs: mark resumed async balance as writing
  fs: add a check function for sb_start_write()
  btrfs: assert that relocation is protected with sb_start_write()

 fs/btrfs/relocation.c | 10 ++++++++++
 fs/btrfs/volumes.c    |  2 ++
 include/linux/fs.h    |  5 +++++
 3 files changed, 17 insertions(+)

-- 
2.35.1

