Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 595C06B51CE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Mar 2023 21:27:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231324AbjCJU1z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Mar 2023 15:27:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231501AbjCJU1u (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Mar 2023 15:27:50 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5ABF13904A;
        Fri, 10 Mar 2023 12:27:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
        Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=gBu6dqFBmTlnBNN/3dBzmxDyuOoDYqEuUSTw7+2tapw=; b=cufGUn6vVZHnDYRUkw2J4bg61p
        LopqM5vE4bTdDfW3qL+fYb4fjgDal5K6qAX0ibMs0T/VR2NWJkw83aJaO0yYEfBxxAtFrn+DpyJ0s
        JLB/QwJW+z3WWA3FVN7UJa1q9mOO/ucNJT6t2pe76qeGrEgJlSJJCA/tcIUvohoGu2TZOiPl1mWw2
        BLCe3YLO4xGAtUxpmiXNQM/OMpOcGOWZaGpJ0ly3jkbUsxW7w/PocV8afbHEvls2vwyBnuZsIuI5z
        VoCtxaMBhev4qJI3KfP0Za0To8sm1YDgS+aPQwtppl94U9ALt/0aR+XorLd7bKEYEdo0ZrqSxspHK
        FmSteXJg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pajKz-00FPlR-1j;
        Fri, 10 Mar 2023 20:27:37 +0000
Date:   Fri, 10 Mar 2023 20:27:37 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [git pull] vfs.git fixes
Message-ID: <20230310202737.GV3390869@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

fs/file.c one is a genuine missing speculation barrier in pick_file() (reachable
e.g. via close(2)); alpha one is strictly speaking not a bug fix, but only
because confusion between preempt_enable() and preempt_disable() is harmless
on architecture without CONFIG_PREEMPT.  Looks like alpha.git picked the
wrong version of patch - that braino used to be there in early versions, but
it had been fixed quite a while ago...  I've checked what ended up in mainline,
fortunately all other parts of commit match the latest variant in my tree.

The following changes since commit fe15c26ee26efa11741a7b632e9f23b01aca4cc6:

  Linux 6.3-rc1 (2023-03-05 14:52:03 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-fixes

for you to fetch changes up to 609d54441493c99f21c1823dfd66fa7f4c512ff4:

  fs: prevent out-of-bounds array speculation when closing a file descriptor (2023-03-09 22:46:21 -0500)

----------------------------------------------------------------
pick_file() speculation fix + fix for alpha mis(merge,cherry-pick)

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

----------------------------------------------------------------
Al Viro (1):
      alpha: fix lazy-FPU mis(merged/applied/whatnot)

Theodore Ts'o (1):
      fs: prevent out-of-bounds array speculation when closing a file descriptor

 arch/alpha/lib/fpreg.c | 4 ++--
 fs/file.c              | 1 +
 2 files changed, 3 insertions(+), 2 deletions(-)
