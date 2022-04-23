Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3501450C90C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Apr 2022 12:09:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234729AbiDWKKz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 23 Apr 2022 06:10:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234289AbiDWKKy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 23 Apr 2022 06:10:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0A141B2B00;
        Sat, 23 Apr 2022 03:07:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 75650B80AD3;
        Sat, 23 Apr 2022 10:07:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE488C385A5;
        Sat, 23 Apr 2022 10:07:53 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Al Viro <viro@zeniv.linux.org.uk>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>, Will Deacon <will@kernel.org>,
        linux-fsdevel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/3] Avoid live-lock in btrfs fault-in+uaccess loop
Date:   Sat, 23 Apr 2022 11:07:48 +0100
Message-Id: <20220423100751.1870771-1-catalin.marinas@arm.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

A minor update from v3 here:

https://lore.kernel.org/r/20220406180922.1522433-1-catalin.marinas@arm.com

In patch 3/3 I dropped the 'len' local variable, so the btrfs patch
simply replaces fault_in_writeable() with fault_in_subpage_writeable()
and adds a comment. I kept David's ack as there's no functional change
since v3.

Andrew, since there was no objection last time around, I'd like this
series to land in 5.19. As it touches arch, fs and mm, it should
probably go in via the mm tree but I'm also happy to merge the series
via arm64. Please let me know if you have any preference.

The btrfs search_ioctl() function can potentially live-lock on arm64
with MTE enabled due to a fault_in_writeable() + copy_to_user_nofault()
unbounded loop. The uaccess can fault in the middle of a page (MTE tag
check fault) even if a prior fault_in_writeable() successfully wrote to
the beginning of that page. The btrfs loop always restarts the fault-in
loop from the beginning of the user buffer, hence the live-lock.

The series introduces fault_in_subpage_writeable() together with the
arm64 probing counterpart and the btrfs fix.

Thanks.

Catalin Marinas (3):
  mm: Add fault_in_subpage_writeable() to probe at sub-page granularity
  arm64: Add support for user sub-page fault probing
  btrfs: Avoid live-lock in search_ioctl() on hardware with sub-page
    faults

 arch/Kconfig                     |  7 +++++++
 arch/arm64/Kconfig               |  1 +
 arch/arm64/include/asm/mte.h     |  1 +
 arch/arm64/include/asm/uaccess.h | 15 +++++++++++++++
 arch/arm64/kernel/mte.c          | 30 ++++++++++++++++++++++++++++++
 fs/btrfs/ioctl.c                 |  7 ++++++-
 include/linux/pagemap.h          |  1 +
 include/linux/uaccess.h          | 22 ++++++++++++++++++++++
 mm/gup.c                         | 29 +++++++++++++++++++++++++++++
 9 files changed, 112 insertions(+), 1 deletion(-)


base-commit: b2d229d4ddb17db541098b83524d901257e93845
