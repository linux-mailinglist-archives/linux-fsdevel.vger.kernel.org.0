Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DF835F785B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Oct 2022 14:54:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbiJGMyK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Oct 2022 08:54:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbiJGMyI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Oct 2022 08:54:08 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34B19F4738;
        Fri,  7 Oct 2022 05:54:08 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id DB7E21F8A8;
        Fri,  7 Oct 2022 12:54:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1665147246; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=2yea1I8bUHEi+w/xoHS0s9Q7Pp5CV/eDJLs78hkBV8I=;
        b=BS0NWwnh0RrdSyqkC3BGUcRthX7wu3nZ5yfKqp3vY91QqcM2t57veK8w08fH6Obru/TIAg
        MBa1bDoJAT6VIfIg71MBZ+gCXdlyjXH8nvfD2S/tjWZ0sgKg+i/Z8NgGnM5sOE7kBRMSnb
        xRPxCiGJG2ejBogdkAes0ix8OyNrKAc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1665147246;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=2yea1I8bUHEi+w/xoHS0s9Q7Pp5CV/eDJLs78hkBV8I=;
        b=s2J0xuBqdfWa0kjXtXzWRpQoGGTCedTyJ8oOBJWpDvaoAcSSEih1o8/KkKvNlbFNsQNKju
        PR2+e/tPVhOtUhDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B555213A9A;
        Fri,  7 Oct 2022 12:54:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id EnbBK24hQGPTaQAAMHmgww
        (envelope-from <jack@suse.cz>); Fri, 07 Oct 2022 12:54:06 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 25D1EA06E9; Fri,  7 Oct 2022 14:54:06 +0200 (CEST)
Date:   Fri, 7 Oct 2022 14:54:06 +0200
From:   Jan Kara <jack@suse.cz>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: [GIT PULL] ext2, udf, reiserfs, and quota fixes for v6.1-rc1
Message-ID: <20221007125406.oaw57vy5zmino5rj@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

  Hello Linus,

  could you please pull from

git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fs-for_v6.1-rc1

to get:
* Fix for udf to make splicing work again
* More disk format sanity checks for ext2 to avoid crashes found by syzbot
* More quota disk format checks to avoid crashes found by fuzzing
* Reiserfs & isofs cleanups

Top of the tree is 191249f70889. The full shortlog is:

Jan Kara (3):
      udf: Support splicing to file
      ext2: Add sanity checks for group and filesystem size
      ext2: Use kvmalloc() for group descriptor array

Jiangshan Yi (1):
      fs/reiserfs: replace ternary operator with min() and min_t()

Minghao Chi (1):
      isofs: delete unnecessary checks before brelse()

Zhihao Cheng (3):
      quota: Check next/prev free block number after reading from quota file
      quota: Replace all block number checking with helper function
      quota: Add more checking after reading from quota file

The diffstat is

 fs/ext2/super.c       | 22 ++++++++++++----
 fs/isofs/inode.c      |  9 +++----
 fs/quota/quota_tree.c | 73 ++++++++++++++++++++++++++++++++++++++++++---------
 fs/reiserfs/prints.c  |  2 +-
 fs/reiserfs/resize.c  |  2 +-
 fs/reiserfs/super.c   |  7 ++---
 fs/udf/file.c         |  1 +
 7 files changed, 86 insertions(+), 30 deletions(-)

							Thanks
								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
