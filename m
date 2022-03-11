Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD7804D5C72
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Mar 2022 08:38:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345883AbiCKHjo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Mar 2022 02:39:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231806AbiCKHjn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Mar 2022 02:39:43 -0500
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4329854192;
        Thu, 10 Mar 2022 23:38:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1646984320; x=1678520320;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Z5u3LqlY1kSo9XnO/9zauzMLbkpz1taSA/Y/ODlZBf8=;
  b=emJU+LimmC6HjprhDgtV8boCjVUjxoegCAr6fA2PKmuAhfN113OQxIld
   1/5B69ZKP2xk4Ci3g9E7foVeUgyue4G6imY7Krc4pdLhjXqVdBKuhpnJW
   K2uFkt/B0sd0+Rj5JlDWJVrVzRwPEqMmst5/1fAkLPWB3lE56TXE/+XF5
   BdFjGReQFU3EsK0q3OnTdemwh2TaIDKkSD2+8WDxBc0jMnih9cho4sr2e
   y7+ypFhLjB/Msg7fBvcnazlXlmvLrITc967lZ5I6U8gXmJUZUtFuqqh7y
   OTgwkBTxG8y2xnOI+reRpt2AVytmh+kIVqcrY4wQUj7LXuSuRHVcY/iPg
   Q==;
X-IronPort-AV: E=Sophos;i="5.90,173,1643644800"; 
   d="scan'208";a="199899077"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 11 Mar 2022 15:38:40 +0800
IronPort-SDR: /h9MT0ky4KxrRa4PTm9nGthsoqGS3Tg23AU8OOpeQmqJZSoOGO12zQH2tzlE2XExYVbVtQEdoZ
 u7cnSpaFWxaUjpzbr3uPWlxzOBM0l8hAEBwHSvaejfp0fMFyg5PHCdNDjA4HVkitbAykurrxLc
 5gL+57F1Ub0wn6FEhECY1XgY32sh0jOL+80kzrMo+P53HMhlHlQg+a5tSgtuIkSLEGRzKEy56J
 NcZtSn05UEZa8vdQtcVALd1IC26Ti82ewiF/EyMLYh02bQFthNPA/vBKBtG2umodLZnJQH1sHS
 j64I+m769giHgR7ytsDr3X41
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2022 23:10:53 -0800
IronPort-SDR: rwr0mTT5O5W/t65w8nH0qc3B3PGCPM7uvp+WlItYWAWGjao63kQwkophwMLmanGYqa9SBuvoUQ
 YgQcPDb+9sBv3+ZRcbmhp6x3avUDtvYkddN4ogxBfTjP77IKvGveLoOUWT4q6ZHzVchyP798rZ
 HXd2rh6bFFiwlQkJxI8wYeFRo0sbDmGa4T8RU/23KAB7owYz/iw1vi+E9SZXtyFdKoe1hY9uGy
 NzOQrqDmlNPvLA0NZY/9Cmqk/RvhIoV86l9bvLSReuXMGZYfV5RKnmjuCfgJezbVIeN9x5p1g7
 yZM=
WDCIronportException: Internal
Received: from dyv5jr2.ad.shared (HELO naota-xeon.wdc.com) ([10.225.50.231])
  by uls-op-cesaip02.wdc.com with ESMTP; 10 Mar 2022 23:38:40 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     johannes.thumshirn@wdc.com, linux-fsdevel@vger.kernel.org,
        viro@zeniv.linux.org.uk, david@fromorbit.com,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 0/4] protect relocation with sb_start_write
Date:   Fri, 11 Mar 2022 16:38:01 +0900
Message-Id: <cover.1646983176.git.naohiro.aota@wdc.com>
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

This series is a follow-up to the series below. The old series added
an assertion to btrfs_relocate_chunk() to check if it is protected
with sb_start_write(). However, it revealed another location we need
to add sb_start_write() [1].

https://lore.kernel.org/linux-btrfs/cover.1645157220.git.naohiro.aota@wdc.com/T/

[1] https://lore.kernel.org/linux-btrfs/cover.1645157220.git.naohiro.aota@wdc.com/T/#e06eecc07ce1cd1e45bfd30a374bd2d15b4fd76d8

Patches 1 and 2 add sb_{start,end}_write() to the resumed async
balancing and device addition.

Patches 3 and 4 add an ASSERT to catch a future error.

Note: I added Fixes tag as "5accdf82ba25 ("fs: Improve filesystem
freezing handling")" considering that sb_start_write() is missing from
the introduction of it. But, I'm not sure this commit is correct or
not.

Naohiro Aota (4):
  btrfs: mark resumed async balance as writing
  btrfs: mark device addition as sb_writing
  fs: add check functions for sb_start_{write,pagefault,intwrite}
  btrfs: assert that relocation is protected with sb_start_write()

 fs/btrfs/ioctl.c   |  2 ++
 fs/btrfs/volumes.c |  5 +++++
 include/linux/fs.h | 20 ++++++++++++++++++++
 3 files changed, 27 insertions(+)

-- 
2.35.1

