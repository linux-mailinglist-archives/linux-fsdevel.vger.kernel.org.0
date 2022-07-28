Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5AE0583FB5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Jul 2022 15:14:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235837AbiG1NOJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Jul 2022 09:14:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238666AbiG1NOH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Jul 2022 09:14:07 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2316D1BEBA
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Jul 2022 06:14:02 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id CA97520B5C;
        Thu, 28 Jul 2022 13:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1659014040; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=hYV3IX0N8Bo43vhWMGQHX5vZRNDp5Y7RR45p7F9gcfE=;
        b=TCxa+p4e3KBcuGVFt2kNQq7mXX60E3joHhVJCFUtRZipVU1Y6L2xebGBNi17eBFUh1qezn
        qEWk51sQ0kdVX3Or9DxrFY08niS3iPzyHQTeqRDkwGcQVJW2Qkm+stvYSEm5W65G4iAIs7
        hKdB5Q2xMTLfijAWAB21IW0xDTSucd4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1659014040;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=hYV3IX0N8Bo43vhWMGQHX5vZRNDp5Y7RR45p7F9gcfE=;
        b=ldVfau4+50Vg6kY9iDZAvSNZL43jP1KGajAJYQLTEY8iP9QYazETbN+wlZueSnHhSJcEiq
        +WYCXGUst74P2nBA==
Received: from quack3.suse.cz (unknown [10.163.43.118])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id B63362C141;
        Thu, 28 Jul 2022 13:14:00 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id CBBF1A0668; Thu, 28 Jul 2022 15:13:59 +0200 (CEST)
Date:   Thu, 28 Jul 2022 15:13:59 +0200
From:   Jan Kara <jack@suse.cz>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] Fsnotify changes for v5.20-rc1
Message-ID: <20220728131359.ssr6tzw7crt2ovfx@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

  Hello Linus,

  could you please pull from

git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fsnotify_for_v5.20-rc1

to get:
*  support for FAN_MARK_IGNORE which untangles some of the not well defined
   corner cases with fanotify ignore masks
*  small cleanups

I'm sending the pull request early as I'll be on vacation next two weeks.

Top of the tree is feee1ce45a56. The full shortlog is:

Amir Goldstein (3):
      fanotify: prepare for setting event flags in ignore mask
      fanotify: cleanups for fanotify_mark() input validations
      fanotify: introduce FAN_MARK_IGNORE

Oliver Ford (1):
      fs: inotify: Fix typo in inotify comment

Xin Gao (1):
      fsnotify: Fix comment typo

The diffstat is

 fs/notify/fanotify/fanotify.c      |  19 ++++---
 fs/notify/fanotify/fanotify.h      |   2 +
 fs/notify/fanotify/fanotify_user.c | 110 ++++++++++++++++++++++++++++---------
 fs/notify/fdinfo.c                 |   6 +-
 fs/notify/fsnotify.c               |  23 ++++----
 fs/notify/inotify/inotify_user.c   |   2 +-
 include/linux/fanotify.h           |  14 +++--
 include/linux/fsnotify_backend.h   |  89 ++++++++++++++++++++++++++++--
 include/uapi/linux/fanotify.h      |   8 +++
 9 files changed, 214 insertions(+), 59 deletions(-)

							Thanks
								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
