Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCADF6958B1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Feb 2023 06:51:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231414AbjBNFvY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Feb 2023 00:51:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231276AbjBNFvW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Feb 2023 00:51:22 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3CA21C7DC
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Feb 2023 21:51:20 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id mg23so7530746pjb.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Feb 2023 21:51:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8LU/okpc0vZcXm8CCZxp1LGT46fDsSKcXpDCSfWC8tI=;
        b=Vm9Y2HlUhz22D7VhnfHdqdHN401APD3SO+dvlsbPw+2oGoI1HWvaplnwDJwTIKVdXm
         kVz+wfy/SVtUvJY/YSrnmfjswFbPpsJ/8uDcm9rm0F2q36zVXbB5gd8owRp++v9nUYbK
         DTcTS0/fnRY+F00vg4q4SN2N8i4uSW4TbGiBrCcWkt+GkL4NlUbuw8w+YR2zAVHv6gne
         B+FE2L9MDwabK6mhIC6GwjObVnMW3S6qJgtx1jrKRMA1zayWe5u/NsXu51i/N/BPf63j
         fRWXyEfX371gdfRuMn60WFhFPOSK3W7fSKj+4VLRs8yU2fmpvcSAWV/nrvyfgMIeyhCi
         AqbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8LU/okpc0vZcXm8CCZxp1LGT46fDsSKcXpDCSfWC8tI=;
        b=36xQWFkpOxxFyhplUrepQj4jTFS9Rx78Eg4LCCiq6NdzfX6XqR/fqb8Yu60NWwrSoK
         aOX9xZjz6Y6nfCXNmJRxrEJUvR8yAyUfg0VrvPlJR6f2ou2tX8rSJxgPyOKVmcpf+68Z
         ter5vr7wqGbsYKsr7eGQhUDy6euOtaoik2OqlhFupwA0EYmOOFLGO84OSJKw01lEP9T1
         eCJImykXMgh4PoILV33QKLbKeuZJrZMl42dZo0e5IwjV0+DQu2lKk1uM9bg/7l8NxXUr
         pGJTB/uZi+Su9p5tvPedCj3UxSg2DH4KBzCwtSImWp4DIhY3mIa2PozI40MHiNhaZcnP
         A8Zw==
X-Gm-Message-State: AO0yUKV8Yms8JdJjv8JHCxR0F9LX2djRKRyk4YlzpNEnnyK/bp3PHnhu
        OqIhfZPj7LVxVgtK6w7jlL8d+heh72v+WuN+
X-Google-Smtp-Source: AK7set/QnX9N3N0vRb+nNVcWyA/dDUo33jwndBNX2o/WEhmk7NYspcsh3IkTA8e6MLpGBoY2qxn7bA==
X-Received: by 2002:a05:6a21:33a6:b0:bf:199e:9b0 with SMTP id yy38-20020a056a2133a600b000bf199e09b0mr1185941pzb.49.1676353880310;
        Mon, 13 Feb 2023 21:51:20 -0800 (PST)
Received: from dread.disaster.area (pa49-181-4-128.pa.nsw.optusnet.com.au. [49.181.4.128])
        by smtp.gmail.com with ESMTPSA id h14-20020a62b40e000000b0058dbb5c5038sm8874959pfn.182.2023.02.13.21.51.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 21:51:19 -0800 (PST)
Received: from [192.168.253.23] (helo=devoid.disaster.area)
        by dread.disaster.area with esmtp (Exim 4.92.3)
        (envelope-from <dave@fromorbit.com>)
        id 1pRoDk-00F5yH-FU; Tue, 14 Feb 2023 16:51:16 +1100
Received: from dave by devoid.disaster.area with local (Exim 4.96)
        (envelope-from <dave@devoid.disaster.area>)
        id 1pRoDk-00HNdF-1C;
        Tue, 14 Feb 2023 16:51:16 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     linux-xfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH 0/3] xfs, iomap: fix writeback failure handling
Date:   Tue, 14 Feb 2023 16:51:11 +1100
Message-Id: <20230214055114.4141947-1-david@fromorbit.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi folks,

We just had a report of a WARN in the XFS writeback code where
delayed allocation was not finding a delayed allocation extent in
the extent tree here:

https://bugzilla.kernel.org/show_bug.cgi?id=217030

Turns out that this is a regression that resulted from removing the
dirty page invalidation on writeback error behaviour that XFS had
for many, many years. Essentially, if we are not invalidating the
dirty cached data on error, we should not be invalidating the
delalloc extent that backs the dirty data. Bad things happen when we
do that.....

This series of patches first adds Darrick's code to mark inodes as
unhealthy when bad extent maps or corruption during allocation is
detected.

The second patch expands on this sickness detection to
cover delalloc conversion failures due to corruption detected during
allocation. It then uses this sickness to trigger removal of the
unconvertable delalloc extents after the VFS has discarded the
cached data during inode reclaim, rather than throwing warnings and
assert failures due to stray unconverted delalloc extents. Those
will still happen if the inode is healthy, hence the need for
ensuring we mark inodes sick correctly.

The last patch then removes xfs_discard_folio() as all it does is
punch the delalloc extent incorrectly. Given that there are now no
other users of ->discard_folio(), that gets removed too.

This has run for a couple of hours with the original reproducer
code, whereas without these patches a current 6.2-rc7 kernel fails
in seconds. No fstests regressions have been seen either, with both
1kB and 4kB block size auto group tests runs now completed.

-Dave.


