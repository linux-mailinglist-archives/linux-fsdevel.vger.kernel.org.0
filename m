Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0D194B05FA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Feb 2022 07:00:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234888AbiBJGA0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Feb 2022 01:00:26 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234843AbiBJGAZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Feb 2022 01:00:25 -0500
X-Greylist: delayed 63 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 09 Feb 2022 22:00:25 PST
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9BCC1C5;
        Wed,  9 Feb 2022 22:00:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1644472825; x=1676008825;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=nLWO0zv5ga8JDIL415WS0zp/IX26NowD/xpo/Z6wKSs=;
  b=JScJ6SkbjGeAvzJ4CUmkbAIKD23QOXu0ZfcJjpvK2EPKGqqG1TiDQdfg
   E9iakvE3NGRrjzDKbKvCt8T/BQ++xIWU3If3RuKTunoxi+WoHFr/9GaIl
   r2rROJigDf1T6HVqYux/Kd0chchRzvXCkG672sLAgWetm3VMNkhoRmbwY
   ssXJ5BDISI2Q9B5YHvnh4Nuh6r0jL1N45EgkqwOY5QpxAdq6ywsvyljBF
   oyDCLzLI0ta31gDip5SqovgDZ1UC0UcNCnISsgR3+efo/cQ+CMmkf/bAi
   6sWKKFvOxpdiYLtJQA6WsFc11M2zVaLMseeD4/jIlsalKNESNcjDNOGt2
   w==;
X-IronPort-AV: E=Sophos;i="5.88,357,1635177600"; 
   d="scan'208";a="191512594"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 10 Feb 2022 13:59:21 +0800
IronPort-SDR: utELQluCya6K90Jg+z4CiH19//ZR8X4qQ8ANhRsFvAgCXdWpBot0FLbh/hGg+dbZ6/lI+pvdQE
 +pkICr97qlziE8NpJm5KgkWoSGPL6LDgqGObh3JL+Ez4LFOR6+lu+dK0KboitnkxRRrPiEhXrS
 3llTwGbFYtSbsPGDuxgKBQxYeEm7yhurhpfWQAHK0FJAqodNCUN6lOW5ArdCvQH1eJjqm9Xx1F
 enx8NYeXnUHLOcWv69GMEOCD8F6f9twKlfq8rdYBCD6IgZXoqLhSiikyBe9MEqqYVmGeErQf84
 DZJBLkAlphrdrJEz91HDWXrF
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 21:32:19 -0800
IronPort-SDR: Gd/TcRlfOTUXdswlqWg6qaT/NtNiJ2Ap7U4tPiSSZWtq/jvFd+ltEckxcP2c+kLbyXbfB6O2c+
 xp5JP5PO5d2pUBajg3p84tjHyUD4ao9a9+etFbE9AgDyVKflvBc/3c/JrIE5JOwpbtWNwURqww
 gcFKM7y9bWuIS15YY1g1pHz28ddcZ2j7oJchTgDCS9NTBQp8zSClMNLWuTdkZpFX/o5IaVuXQA
 ZzsSv+zyDXctAxl1/GyPEWGKwUBe+H6EleADr8e5o68m7MX87fRhLi2ZSKtLeqTisY+cGybnOS
 DiE=
WDCIronportException: Internal
Received: from chmc3h2.ad.shared (HELO naota-xeon.wdc.com) ([10.225.51.94])
  by uls-op-cesaip02.wdc.com with ESMTP; 09 Feb 2022 21:59:22 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     johannes.thumshirn@wdc.com, linux-fsdevel@vger.kernel.org,
        viro@zeniv.linux.org.uk, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v2 0/2] btrfs: zoned: mark relocation as writing
Date:   Thu, 10 Feb 2022 14:59:03 +0900
Message-Id: <cover.1644469146.git.naohiro.aota@wdc.com>
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

There is a hung_task issue with running generic/068 on an SMR
device. The hang occurs while a process is trying to thaw the
filesystem. The process is trying to take sb->s_umount to thaw the
FS. The lock is held by fsstress, which calls btrfs_sync_fs() and is
waiting for an ordered extent to finish. However, as the FS is frozen,
the ordered extent never finish.

Having an ordered extent while the FS is frozen is the root cause of
the hang. The ordered extent is initiated from btrfs_relocate_chunk()
which is called from btrfs_reclaim_bgs_work().

The first patch is a preparation patch to add asserting functions to
check if sb_start_{write,pagefault,intwrite} is called.

The second patch adds sb_{start,end}_write and the assert function at
proper places.

Changelog:
v2:
  - Implement asserting functions not to directly touch the internal
    implementation

Naohiro Aota (2):
  fs: add asserting functions for sb_start_{write,pagefault,intwrite}
  btrfs: zoned: mark relocation as writing

 fs/btrfs/block-group.c |  8 +++++++-
 fs/btrfs/volumes.c     |  6 ++++++
 include/linux/fs.h     | 20 ++++++++++++++++++++
 3 files changed, 33 insertions(+), 1 deletion(-)

-- 
2.35.1

