Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BB3872B5D2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jun 2023 05:15:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233235AbjFLDPZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 11 Jun 2023 23:15:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234829AbjFLDPT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 11 Jun 2023 23:15:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 932D1BB;
        Sun, 11 Jun 2023 20:15:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2862D61DD5;
        Mon, 12 Jun 2023 03:15:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 842A7C433EF;
        Mon, 12 Jun 2023 03:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686539717;
        bh=0eRTs3svg79u/dKsIAsTmywYGTVwICyy5aMVS1Akj1Q=;
        h=Subject:From:To:Cc:Date:From;
        b=B3VIk0zPKQ27wLkcyA9wSo2/4tLN2JL1+7r/OP+SKRxEKiU5st4xlWdVYDMnCc1fX
         jqbkoEJrBnWy5uiy9yaC1hDSWS9dABQveRNfHcZzsHrgch4Bb09aTbz6NbnSEOfbFN
         BDw+WTo/paqrioP7CGj6VDaWQR+SK6Kxkix37M+ia54Xlq1FzjJreuUb2Ig74y68oE
         UYcOCarpR4uV/hEvRzHkMJPZQLj0hcpoJ+2Z1PvUzpvlbKbrIiR+uNk/cesL5vAbyB
         Bft1cJ0S1X32k/iqkoFs5365q23svdObUuWVJJ+FglloKxJSAhXbgaBPZc8CDEH2sM
         j8KiUEfAP+VrQ==
Subject: [PATCHSET RFC 0/3] fs: kernel and userspace filesystem freeze
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     djwong@kernel.org
Cc:     ruansy.fnst@fujitsu.com, mcgrof@kernel.org, hch@infradead.org,
        Jan Kara <jack@suse.cz>, jack@suse.cz,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        mcgrof@kernel.org, jack@suse.cz, hch@infradead.org,
        ruansy.fnst@fujitsu.com
Date:   Sun, 11 Jun 2023 20:15:16 -0700
Message-ID: <168653971691.755178.4003354804404850534.stgit@frogsfrogsfrogs>
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
 Documentation/filesystems/vfs.rst |    4 +
 block/bdev.c                      |    8 +--
 fs/f2fs/gc.c                      |    4 +
 fs/gfs2/glops.c                   |    2 -
 fs/gfs2/super.c                   |    6 +-
 fs/gfs2/sys.c                     |    4 +
 fs/gfs2/util.c                    |    2 -
 fs/ioctl.c                        |    8 +--
 fs/quota/quota.c                  |    5 +-
 fs/super.c                        |  110 ++++++++++++++++++++++++++++++++-----
 include/linux/fs.h                |   16 +++--
 11 files changed, 128 insertions(+), 41 deletions(-)

