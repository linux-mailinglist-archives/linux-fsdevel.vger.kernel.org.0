Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7FDD4EA8CA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Mar 2022 09:53:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233465AbiC2Huz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Mar 2022 03:50:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231891AbiC2Huz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Mar 2022 03:50:55 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13E551E1110
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Mar 2022 00:49:12 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id r13so23494851wrr.9
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Mar 2022 00:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wxy/Iej0ss3aZnKDyoDV//KxnL4h8C1Wspbi+CmvEfc=;
        b=O17OFjH1TdPp6U7l+bFiFHb+Q8YDAGIMghjmuq+KlzSWxEIpkv5NhZCE+AxNR4edYk
         Za5Uxtbok/ZrSBOpYgNovcfNkVRwPDWI1jftMX348cjvZ7+jTpKsf+Xf5a/FTXAMeUZE
         kVWiWZx9wtwmqQrDRCz6dRDCJCL6W3QS2boCk6bjyrClk4HDLVOafvJcRx2gGNG/+5iB
         YgW9U5e+icjJm468KAHYLDIp04TGaZ5pxAPR7s7I5ARxOGyJWpJnZZhKtV5lDmZ7svob
         GdlRQzXwHxO/kzYa39MgjG/qGyd2Rfx8dxQm4k6t810M76+0+zwmf6eZH+Vv+QtrMwE5
         m6kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wxy/Iej0ss3aZnKDyoDV//KxnL4h8C1Wspbi+CmvEfc=;
        b=JRD5iaNMD+GjQoYOm2Zmpx2AFFmv8MjJWj/omGDgPXfoICiPuG8WmXdLrF9gWj06QB
         TOO6htomsIJRvryRL6G8vZgLgaHI9i/NtxIOMo32XFqqK9uozSjgZLvglAFyzjy+k6Xf
         XjRinmnIOOXKNFEF+rHirj/BU8pkFwjA/wBCPzy5u/zkfVnU6jbO40dcKbj8iTEY2QcG
         jqGfuXFKaxp5KjkPKbur7uYlRWJA0hv730MSdhVUa/+QQgLywAMJz7bmU8b38AOjVjxg
         ZF1rrozgVptFK+3n5NBIo8dayNRPBk2JNK1XePN5yiqZ/wKsoa3qZt9ad5nLWQo4gUvr
         DAkw==
X-Gm-Message-State: AOAM531zf2vvtF4hEyPtEqTToQLHJ9ikjFhmRRSJV+Lq7dYwIkeKKfBq
        plIWi2bmQkrTR0/q+rx5np5IGjgD5lE=
X-Google-Smtp-Source: ABdhPJxN5kx8/JoIkeJBX7oPuMiEZy4r71Jr/xeUXXjMyuxBLvn0EmXaSr2t1njnnhFTz/F8uk2kIA==
X-Received: by 2002:adf:fe4a:0:b0:203:fb08:11d8 with SMTP id m10-20020adffe4a000000b00203fb0811d8mr29331937wrs.356.1648540150438;
        Tue, 29 Mar 2022 00:49:10 -0700 (PDT)
Received: from localhost.localdomain ([77.137.71.203])
        by smtp.gmail.com with ESMTPSA id k40-20020a05600c1ca800b0038c6c8b7fa8sm1534342wms.25.2022.03.29.00.49.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 00:49:09 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 00/16] Evictable fanotify marks
Date:   Tue, 29 Mar 2022 10:48:48 +0300
Message-Id: <20220329074904.2980320-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Jan,

Following the discussion on direct reclaim of fsnotify marks [2],
this patch set includes your suggested fixes to core code along with
implementation of fanotify evictable marks (rebrand of volatile marks).

The LTP test I wrote [3] reproduces that deadlock within seconds on my
small test VM if the FSNOTIFY_GROUP_NOFS flag is removed from fanotify.

To be more exact, depending on the value of vfs_cache_pressure set by
the test, either a deadlock or lockdep warning (or both) are reproduced.
I chose a high value of 500, which usually reproduces only the lockdep
warning, but worked better and faster on several systems I tested on.

Thanks,
Amir.

Changes since v1 [1]:
- Fixes for direct reclaim deadlock
- Add ioctl for direct reclaim test
- Rebrand as FAN_MARK_EVICTABLE
- Remove FAN_MARK_CREATE and allow clearing FAN_MARK_EVICTABLE
- Replace connector proxy_iref with HAS_IREF flag
- Take iref in fsnotify_reclac_mark() rather than on add mark to list
- Remove fsnotify_add_mark() allow_dups/flags argument
- Remove pr_debug() prints

[1] https://lore.kernel.org/r/20220307155741.1352405-1-amir73il@gmail.com/
[2] https://lore.kernel.org/r/20220321112310.vpr7oxro2xkz5llh@quack3.lan/
[3] https://github.com/amir73il/ltp/commits/fan_evictable

Amir Goldstein (16):
  inotify: show inotify mask flags in proc fdinfo
  inotify: move control flags from mask to mark flags
  fsnotify: pass flags argument to fsnotify_add_mark() via mark
  fsnotify: remove unneeded refcounts of s_fsnotify_connectors
  fsnotify: fix wrong lockdep annotations
  fsnotify: create helpers for group mark_mutex lock
  inotify: use fsnotify group lock helpers
  audit: use fsnotify group lock helpers
  nfsd: use fsnotify group lock helpers
  dnotify: use fsnotify group lock helpers
  fsnotify: allow adding an inode mark without pinning inode
  fanotify: factor out helper fanotify_mark_update_flags()
  fanotify: implement "evictable" inode marks
  fanotify: add FAN_IOC_SET_MARK_PAGE_ORDER ioctl for testing
  fanotify: use fsnotify group lock helpers
  fanotify: enable "evictable" inode marks

 fs/nfsd/filecache.c                  |  12 +--
 fs/notify/dnotify/dnotify.c          |  13 +--
 fs/notify/fanotify/fanotify.c        |   6 +-
 fs/notify/fanotify/fanotify.h        |  12 +++
 fs/notify/fanotify/fanotify_user.c   | 128 +++++++++++++++++++++------
 fs/notify/fdinfo.c                   |  22 ++---
 fs/notify/fsnotify.c                 |   4 +-
 fs/notify/group.c                    |  11 +++
 fs/notify/inotify/inotify.h          |  19 ++++
 fs/notify/inotify/inotify_fsnotify.c |   2 +-
 fs/notify/inotify/inotify_user.c     |  46 ++++++----
 fs/notify/mark.c                     | 126 +++++++++++++++-----------
 include/linux/fanotify.h             |   1 +
 include/linux/fsnotify_backend.h     |  86 ++++++++++++++----
 include/uapi/linux/fanotify.h        |   5 ++
 kernel/audit_fsnotify.c              |   3 +-
 kernel/audit_tree.c                  |  32 +++----
 17 files changed, 370 insertions(+), 158 deletions(-)

-- 
2.25.1

