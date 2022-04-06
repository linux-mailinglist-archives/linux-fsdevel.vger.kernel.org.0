Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB8054F6A3C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Apr 2022 21:45:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232290AbiDFTqy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Apr 2022 15:46:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231789AbiDFTpx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Apr 2022 15:45:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E4CB1DE59B;
        Wed,  6 Apr 2022 11:09:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B891461C4B;
        Wed,  6 Apr 2022 18:09:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B317FC385A3;
        Wed,  6 Apr 2022 18:09:24 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Josef Bacik <josef@toxicpanda.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
        Will Deacon <will@kernel.org>, linux-fsdevel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/3] Avoid live-lock in btrfs fault-in+uaccess loop
Date:   Wed,  6 Apr 2022 19:09:19 +0100
Message-Id: <20220406180922.1522433-1-catalin.marinas@arm.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

I finally got around to reviving this series. However, I simplified it
from v2 and focussed on solving the btrfs search_ioctl() problem only:

https://lore.kernel.org/r/20211201193750.2097885-1-catalin.marinas@arm.com

The btrfs search_ioctl() function can potentially live-lock on arm64
with MTE enabled due to a fault_in_writeable() + copy_to_user_nofault()
unbounded loop. The uaccess can fault in the middle of a page (MTE tag
check fault) even if a prior fault_in_writeable() successfully wrote to
the beginning of that page. The btrfs loop always restarts the fault-in
loop from the beginning of the user buffer, hence the live-lock.

The series introduces fault_in_subpage_writeable() together with the
arm64 probing counterpart and the btrfs fix.

I don't think with the current kernel anything other than btrfs
search_ioctl() can live-lock. The buffered file I/O can already cope
with current fault_in_*() + copy_*_user() loops (the uaccess makes
progress). Direct I/O either goes via GUP + kernel mapping access (and
memcpy() can't fault) or, if the user buffer is not PAGE aligned, it may
fall back to buffered I/O. So we really only care about
fault_in_writeable(), hence this simplified series. If at some point
we'll need to address other places, we can expand the sub-page probing
to the other fault_in_*() functions.

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

