Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ABFB4BB08F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Feb 2022 05:14:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbiBREOl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Feb 2022 23:14:41 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbiBREOk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Feb 2022 23:14:40 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84EE3583B3;
        Thu, 17 Feb 2022 20:14:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1645157664; x=1676693664;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=H/dXdbVtB8MzZs/Z/1aXOVpb/jjAr1JVjXbzsbWHIdo=;
  b=ENqn4T9gJ/yfSoR8bXr9YQ2AFn6ChoBa3coUkoPM++C+CTnhu0snjIyT
   LPYnAIocjmJgW+OEMKlZ5UqVfcO8sKrjkgzliB7GISCqi8/j58wWC9LrT
   BIR7pR+ReMXgvPw5pMBIgYHaJZrBi2YrN+KMBqXgRCV/A1URuzpm1NQgZ
   6FxaTYDY8YJsKgy8g3820t/zm7wWUxKecohZ5FbJdMpZ4VQaXmnkwXus/
   l2m3Y0YAm5eNVB+7Ze2ndIWQr+rTEoYtGTE3EX+7/u6OnLzEm9kefdbSY
   qu1RZ6JMMZsMtHMYTe5Wg1Dq13LohXO2iUtV/ogU5PG0nwOXEoKBWjRCR
   g==;
X-IronPort-AV: E=Sophos;i="5.88,377,1635177600"; 
   d="scan'208";a="194229483"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 18 Feb 2022 12:14:24 +0800
IronPort-SDR: /FwKIGnyqlhy7kzRpmSUrvzBBmMmtHOHw3gur7SeBMEgOOznss8sMdi0ieWpKhi6MTtypcOPgZ
 jkvlhwgO+gTjjKOM4mRMmlY5yhHm9inm/JwZjQjDYeWpvyoZ9FwA0AjjccyUR0OPam4Sp+8wJk
 K54Q0hMABRd37MpA6YXh5Ryg6dyiGiX0ZnVWyL28zyCIOvLwpUJD6Rd0UiUK2fdeR/IFpZxCu1
 gK2pCE/tF/EHoPqR5WnGP98bc0JONwj6yXMnb7Blm2Bduh2BMrlgR7iXTuNRd0jbuktQ2CpbCJ
 3LpVRO2YO6TEUYbzns/1/YZ8
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2022 19:46:01 -0800
IronPort-SDR: e/hOwBEyw/SzQjHAjZHclBaTI+HImiL0khCr7nKeRszI+66jxTC/royP3GpBpv6dBREMSJ3Mxl
 5KuOkvRYn9ot3K7LOXbl/r2I2v7iLSFNxTUb1oPVpXjFlMkSMESsp4tQqe13zKFXWhUqRAkEOv
 iJxvbed2ZIRIohv+LyD/6ayQLC7X2tbsYHvpE1uMGS19XpUNeOxtcQS1UNyPaY84eVIfpoicHO
 qW6YdCkvWc+0jVDOgrK99USgdMDrSFoXoirelCIJcKarLO8wOwIasUWack0eXag/RQcdN1QQRs
 XqY=
WDCIronportException: Internal
Received: from fdxrrn2.ad.shared (HELO naota-xeon.wdc.com) ([10.225.54.90])
  by uls-op-cesaip01.wdc.com with ESMTP; 17 Feb 2022 20:14:22 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     johannes.thumshirn@wdc.com, linux-fsdevel@vger.kernel.org,
        viro@zeniv.linux.org.uk, david@fromorbit.com,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v3 0/2] btrfs: zoned: mark relocation as writing
Date:   Fri, 18 Feb 2022 13:14:17 +0900
Message-Id: <cover.1645157220.git.naohiro.aota@wdc.com>
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
v3:
  - Return bool instead of asserting and let caller decide what to do
    (suggested by Dave Chinner)
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

