Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7F69F8F52
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2019 13:09:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbfKLMJd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Nov 2019 07:09:33 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:50723 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725985AbfKLMJd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Nov 2019 07:09:33 -0500
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1Mow4E-1i6i501wis-00qSUF; Tue, 12 Nov 2019 13:09:12 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     "Darrick J . Wong" <darrick.wong@oracle.com>
Cc:     linux-xfs@vger.kernel.org, y2038@lists.linaro.org, arnd@arndb.de,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        Dave Chinner <david@fromorbit.com>,
        Brian Foster <bfoster@redhat.com>,
        Allison Collins <allison.henderson@oracle.com>,
        linux-fsdevel@vger.kernel.org
Subject: [RFC 0/5] xfs: y2038 conversion
Date:   Tue, 12 Nov 2019 13:09:05 +0100
Message-Id: <20191112120910.1977003-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:jy9HetgOdO3YgbWR57uIO7Yd3hfmVdHWEyuc5XdOauceZfzxZI+
 6Zu35EHoXSX4CpIkYQtUUrqafnLK1dtw8dCcUfG13KrYmRQk0+5k2NFziKU5HaYGeNjIhHD
 0EZrsaQCVW0qqafOpiz6OlHmfxpiOdPpR7LhvzOSE3/LRe3v3ksNOdwqVTu9qyNGGSj+5pP
 L2n5mDebBOUMOhkBIxYOA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:1zdPUXtFy4E=:W5jxLg+LdGHfdeP1xnO0Ou
 BKDmosS8v1KFMea59o9fnsAbixtRA/m1Ut32NT7wX8/8QxuiqR7K7R4C0wuQdIQR8TKP4nb6P
 3mNCATRcm9pE+PBfnCcyereL4U9pgOS3OP6u7N3SnbVLhYDEZu5y7LBbDL11y3A+FTL+Xc+e7
 tB72LteqTh9pcOksq3hi+nU70NJ6iUoxv4C3VyvrZ6WW7TbT6f1RAtZkiERJzq8gYCtjf2u7C
 zXUDGkZdmtGxg4H4FWHEZaqAR6H5k1ftYXkhNxlbvlMiOtAnzFmgAG1Jo/HaL6G9cgVSdxwxl
 osMSnTphakqhnAs9lDSsTWVKd7S0nMQDN729be9US4Mlf+PgmpG8tCNPJB1CCLIqJ+AR6hk7n
 nuOmyliHONl8URgx2X4fgHExwlcyxr0TdZRaOPzTQrt4sV+wpXUlzmWIC8jECKSscTMJiteoH
 0GjDLHoJrq1nLtnGXghM3hcRC9l7SsrgrSEoUVbAmmptNQbfTD7VoK+IMcbHsnSF1uGar75h0
 rgNpjXZZNZmfLibBJ34v3YUFZJGOgEfivkm1a5WQYeTKKCcADvn11gjZ/eyxU5nrDuoDbKrsh
 CRrpBGjurjgiQ81KSW/qTNYMYrRYhZEzpTDdgV3nAMCG3XQpALuL2dnAW2Y0ppQJfvjJlPgEu
 OkuZkTkaP4HajwAjKiSZG1Oe88wka4gziQvbbdr+YVq6dm6b45GgcBGeCDYE5ODGHoEM57leE
 6KFhrGKW0EIBKA/amPCjJnj2CcVAYI/lsJWL2WyVMUWO1gUuPRR8aaiTql4//aXN9c392uehZ
 feeKRYl0JfOHkk5qSu6fqlhlGVIdGZzJneRhgXd74tB3rHrqdrNk8SHhBIiEE/owUKBc8SI3l
 B6tfPziPGMnpSzIDz63A==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is part of a longer set of changes to clean up the last remaining
bits for the y2038 conversion. In XFS, three distinct problems need to
be addressed:

1. The use of time_t in kernel sources -- I'm in the process
   of removing all of them so we can remove the definition itself,
   making it harder to write new y2038-unsafe code. This part is
   trivially done as a side-effect of the other two.

2. The use of time_t in a user API header for ioctls. When
   building against a new 32-bit libc with 64-bit time_t, the structures
   no longer match and we get incorrect data from ioctls.  Unfortunately,
   there is no good way to fix XFS_IOC_FSBULKSTAT, I considered different
   approaches and in the end came up with three variants that are all
   part of this series. The idea is to pick just one of course.

3. On-disk timestamps hitting the y2038 limit. This applies to both
   inode timestamps and quota data. Both are extended to 40 bits,
   with the minimum timestamp still being year 1902, and the maximum
   getting extended from 2038 to 36744.

Please review and let me know which of ioctl API changes makes the
most sense. I have not done any actual runtime testing on the patches,
so this is clearly too late for the next merge window, but I hope to
get it all merged for v5.6.

      Arnd

Arnd Bergmann (5):
  xfs: [variant A] avoid time_t in user api
  xfs: [variant B] add time64 version of xfs_bstat
  xfs: [variant C] avoid i386-misaligned xfs_bstat
  xfs: extend inode format for 40-bit timestamps
  xfs: use 40-bit quota time limits

 fs/xfs/libxfs/xfs_dquot_buf.c   |   6 +-
 fs/xfs/libxfs/xfs_format.h      |  11 +-
 fs/xfs/libxfs/xfs_fs.h          |  37 +++++-
 fs/xfs/libxfs/xfs_inode_buf.c   |  28 +++--
 fs/xfs/libxfs/xfs_inode_buf.h   |   1 +
 fs/xfs/libxfs/xfs_log_format.h  |   6 +-
 fs/xfs/libxfs/xfs_trans_inode.c |   3 +-
 fs/xfs/xfs_dquot.c              |  29 +++--
 fs/xfs/xfs_inode.c              |   3 +-
 fs/xfs/xfs_inode_item.c         |  10 +-
 fs/xfs/xfs_ioctl.c              | 195 +++++++++++++++++++++++++++++++-
 fs/xfs/xfs_ioctl.h              |  12 ++
 fs/xfs/xfs_ioctl32.c            | 160 +++++---------------------
 fs/xfs/xfs_ioctl32.h            |  26 ++---
 fs/xfs/xfs_iops.c               |   3 +-
 fs/xfs/xfs_itable.c             |   2 +-
 fs/xfs/xfs_qm.c                 |  18 ++-
 fs/xfs/xfs_qm.h                 |   6 +-
 fs/xfs/xfs_qm_syscalls.c        |  16 ++-
 fs/xfs/xfs_quotaops.c           |   6 +-
 fs/xfs/xfs_super.c              |   2 +-
 fs/xfs/xfs_trans_dquot.c        |  17 ++-
 22 files changed, 387 insertions(+), 210 deletions(-)

-- 
2.20.0

