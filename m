Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6915B7324D0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jun 2023 03:48:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbjFPBsa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jun 2023 21:48:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjFPBs3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jun 2023 21:48:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C033710F7;
        Thu, 15 Jun 2023 18:48:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 51DEC61BCB;
        Fri, 16 Jun 2023 01:48:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83DF3C433C0;
        Fri, 16 Jun 2023 01:48:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686880107;
        bh=a+g6O30mkOtSF6VuouluYUoVqi8vrmplSWjTo01hFR0=;
        h=Subject:From:To:Cc:Date:From;
        b=TkrgYQ2kWXlINtgwSsk36sFFItnw5kN7Wfq71YZ/JHcvNHmx/jXX/q2hfnr1dX9jw
         AMoelgy1xp765UmibD3f6SQzQW/wRwIdqemtPLcGv3AINa/jHirZXyLecFbbf6JJFv
         Sm3uajW7/pHdJ3PNABFEYp63KV5CXrvCe3okf4paQe4/6JZKsgo+1fFxcu1rYQiMCt
         AZTsXD1ung+U9Aj15HdLneXDChP7mOBSBgABt9l2iPRTraReDOBiAzgvz2QDm9xbxD
         ui+q/XDyrSjJ/MXN3QQu8K376GXo0sPajsbSes9XL33/0uHNMCKlhgOzkuqmhBMkLK
         1nEUcNyz04d6Q==
Subject: [PATCHSET v2 0/3] fs: kernel and userspace filesystem freeze
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     djwong@kernel.org
Cc:     jack@suse.cz, hch@infradead.org, Christoph Hellwig <hch@lst.de>,
        ruansy.fnst@fujitsu.com, mcgrof@kernel.org,
        Jan Kara <jack@suse.cz>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, mcgrof@kernel.org, jack@suse.cz,
        hch@infradead.org, ruansy.fnst@fujitsu.com
Date:   Thu, 15 Jun 2023 18:48:26 -0700
Message-ID: <168688010689.860947.1788875898367401950.stgit@frogsfrogsfrogs>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi all,

Sometimes, kernel filesystem drivers need the ability to quiesce writes
to the filesystem so that the driver can perform some kind of
maintenance activity.  This capability mostly already exists in the form
of filesystem freezing but with the huge caveat that userspace can thaw
any frozen fs at any time.  If the correctness of the fs maintenance
program requires stillness of the filesystem, then this caveat is BAD.

Provide a means for the kernel to initiate its own filesystem freezes.
A freeze of one type can be shared with a different type of freeze, but
nested freezes of the same type are not allowed.  A shared freeze
remains in effect until both holders thaw the filesystem.

This capability will be used (sparingly) by the upcoming xfs online fsck
feature; the fsdax pre-removal code; and hopefully one day by suspend.

If you're going to start using this mess, you probably ought to just
pull from my git trees, which are linked below.

This is an extraordinary way to destroy everything.  Enjoy!
Comments and questions are, as always, welcome.

--D

kernel git tree:
https://git.kernel.org/cgit/linux/kernel/git/djwong/xfs-linux.git/log/?h=kernel-fsfreeze
---
 Documentation/filesystems/vfs.rst |    6 +-
 block/bdev.c                      |    8 +--
 fs/f2fs/gc.c                      |    4 +
 fs/gfs2/glops.c                   |    2 -
 fs/gfs2/super.c                   |    6 +-
 fs/gfs2/sys.c                     |    4 +
 fs/gfs2/util.c                    |    2 -
 fs/ioctl.c                        |    8 +--
 fs/quota/quota.c                  |    5 +-
 fs/super.c                        |  117 ++++++++++++++++++++++++++++++++-----
 include/linux/fs.h                |   16 +++--
 11 files changed, 136 insertions(+), 42 deletions(-)

