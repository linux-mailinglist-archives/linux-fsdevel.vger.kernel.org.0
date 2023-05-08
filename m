Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAB026F9D44
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 May 2023 03:17:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232171AbjEHBRg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 7 May 2023 21:17:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230415AbjEHBRe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 7 May 2023 21:17:34 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A569344BB;
        Sun,  7 May 2023 18:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=Dfem53zrntMgc2qqg7QZM5Lqki4oNKLb/3jLs6sJE6o=; b=1EwyMiqSjlSLnsJolBQR1M0slR
        m1V2goyyTWA/q7GwV6LBquiEcdPW6eMwOmsbA/QXdSxJF9R+P7q9vol9B3LePWIONNa06ML28OY3+
        TbWN+peWbMX40LunkaRbsHNOVeAalveCsVpHbWDwVwVZbcheVf6DgtxtGA2aIixYUi+xrl6Pa9pEd
        BKZ4jnmBRwTBDe93W1lK0W1v2I2LZW04o+6pYvNW05HQgaee5jgYQuDB6V69Y8PpIq27zizUmHAVF
        c7bR1p9yrqRld4NDmXQiZ9wMuo+jrdnNcDVsT+Vo8NSBjAz8Tgu9X5QNP4Z5bmnjSqZu3lzzg9Leh
        tyWssACw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pvpV7-00GvYw-2V;
        Mon, 08 May 2023 01:17:17 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     hch@infradead.org, djwong@kernel.org, sandeen@sandeen.net,
        song@kernel.org, rafael@kernel.org, gregkh@linuxfoundation.org,
        viro@zeniv.linux.org.uk, jack@suse.cz, jikos@kernel.org,
        bvanassche@acm.org, ebiederm@xmission.com
Cc:     mchehab@kernel.org, keescook@chromium.org, p.raghav@samsung.com,
        da.gomez@samsung.com, linux-fsdevel@vger.kernel.org,
        kernel@tuxforce.de, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 0/6] vfs: provide automatic kernel freeze / resume 
Date:   Sun,  7 May 2023 18:17:11 -0700
Message-Id: <20230508011717.4034511-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

It's been about 5 months since the last v3 RFC for fs freeze. Now
that some of us will have time at LSFMM to discuss stuff I figured
it would be good to try to get the last pieces, if any discussed,
and put out a new patch set based on the latests feedback. This
time I boot tested, and stress tested the patches. From what I can
tell I confirm nothing regresses, we just end up now with a new world
where if your platform does support s3  / s4 we'll kick into gear the
automatic kernel freeze.

To help with testing, as this is a rather tiny bit obscure area with
virtualization, I've gone ahead and extended kdevops with support for
always enabling s3 / s4, so it should be easy to test guest bring up
there.

I've picked out using stress-ng now to have fun stress testing suspend,
the insane will try:

./stress-ng --touch 8192 --touch-method creat

Resume works but eventually suspend will trickle tons of OOMs and so
we gotta find a sweet spot to automate this somehow in fstests somehow.
I am not sure how we're gonna test this moving forward on fstests but
perhaps worth talking about at LSFMM for ideas.

Anyway, your filesystem will not participate in the auto kernel
freeze / thaw unless your filesystem gets the kthread freezer junk
removed and sets a flag. I'll post 3 patches for the 3 main filesystems
after this. I've carried and advanced the SmPL patch for a few years
now, and magically it all still works.

[0] https://lkml.kernel.org/r/20230114003409.1168311-1-mcgrof@kernel.org

Luis Chamberlain (6):
  fs: unify locking semantics for fs freeze / thaw
  fs: add frozen sb state helpers
  fs: distinguish between user initiated freeze and kernel initiated
    freeze
  fs: move !SB_BORN check early on freeze and add for thaw
  fs: add iterate_supers_excl() and iterate_supers_reverse_excl()
  fs: add automatic kernel fs freeze / thaw and remove kthread freezing

 block/bdev.c           |   9 +-
 fs/ext4/ext4_jbd2.c    |   2 +-
 fs/f2fs/gc.c           |   9 +-
 fs/gfs2/glops.c        |   2 +-
 fs/gfs2/super.c        |  11 +-
 fs/gfs2/sys.c          |  12 ++-
 fs/gfs2/util.c         |   7 +-
 fs/ioctl.c             |  14 ++-
 fs/quota/quota.c       |   4 +-
 fs/super.c             | 239 +++++++++++++++++++++++++++++++++--------
 fs/xfs/xfs_trans.c     |   3 +-
 include/linux/fs.h     |  54 +++++++++-
 kernel/power/process.c |  15 ++-
 13 files changed, 313 insertions(+), 68 deletions(-)

-- 
2.39.2

