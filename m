Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1871E78DBB6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Aug 2023 20:46:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238254AbjH3Sh3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Aug 2023 14:37:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243226AbjH3KYi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Aug 2023 06:24:38 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4622CC0;
        Wed, 30 Aug 2023 03:24:36 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 07E0D1F461;
        Wed, 30 Aug 2023 10:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1693391075; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=gNnmc13S0IwyYgEmw0iDClBkRK2wiKonzAqpRKkP+TI=;
        b=QAWjdoFrPUSwju/0lyE4Qk84HWD/CJkRt4H7oKHzvTguG5lyk9On6ooMbw+fDSxg+CaB9u
        VqVjuBowc8rUafZaqsaPFpFehjwJwWy2JVczfiTsZgs8ASvLbMEevDf/cWzE1EWOBVEEm/
        0YfnEB7bGBUnt+EDZqTLgk4g1MhoLJs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1693391075;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=gNnmc13S0IwyYgEmw0iDClBkRK2wiKonzAqpRKkP+TI=;
        b=vix/YAcuMCNne0zO2p4zOQVD3Dsbq333/qdyWYCqe/xM8HFRBxchWuOTHmAI48Ov6MDPdB
        5Z1uoJcldN+ZGNCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EE1F21353E;
        Wed, 30 Aug 2023 10:24:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id DxgXOuIY72R3RwAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 30 Aug 2023 10:24:34 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 678D3A0774; Wed, 30 Aug 2023 12:24:34 +0200 (CEST)
Date:   Wed, 30 Aug 2023 12:24:34 +0200
From:   Jan Kara <jack@suse.cz>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: [GIT PULL] ext2, quota, and udf fixes for 6.6-rc1
Message-ID: <20230830102434.xnlh66omhs6ninet@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

  Hello Linus,

  could you please pull from

git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git for_v6.6-rc1

to get:
* fixes for possible use-after-free issues with quota when racing with
  chown
* fixes for ext2 crashing when xattr allocation races with another
  block allocation to the same file from page writeback code
* fix for block number overflow in ext2
* marking of reiserfs as obsolete in MAINTAINERS
* assorted minor cleanups

Top of the tree is df1ae36a4a0e. The full shortlog is:

Baokun Li (5):
      quota: factor out dquot_write_dquot()
      quota: rename dquot_active() to inode_quota_active()
      quota: add new helper dquot_active()
      quota: fix dqput() to follow the guarantees dquot_srcu should provide
      quota: simplify drop_dquot_ref()

Christoph Hellwig (1):
      quota: use lockdep_assert_held_write in dquot_load_quota_sb

Colin Ian King (1):
      ext2: remove redundant assignment to variable desc and variable best_desc

Georg Ottinger (2):
      ext2: fix datatype of block number in ext2_xattr_set2()
      ext2: improve consistency of ext2_fsblk_t datatype usage

Gustavo A. R. Silva (1):
      udf: Fix -Wstringop-overflow warnings

Jan Kara (1):
      udf: Drop pointless aops assignment

Matthew Wilcox (Oracle) (1):
      ext2: Fix kernel-doc warnings

Piotr Siminski (1):
      MAINTAINERS: change reiserfs status to obsolete

Ye Bin (4):
      ext2: remove ext2_new_block()
      ext2: introduce new flags argument for ext2_new_blocks()
      ext2: fix race between setxattr and write back
      ext2: dump current reservation window info

The diffstat is

 MAINTAINERS        |   2 +-
 fs/ext2/balloc.c   | 136 ++++++++++++++---------------
 fs/ext2/ext2.h     |  14 +--
 fs/ext2/ialloc.c   |   3 -
 fs/ext2/inode.c    |  24 +++---
 fs/ext2/xattr.c    |   7 +-
 fs/quota/dquot.c   | 249 +++++++++++++++++++++++++++--------------------------
 fs/udf/directory.c |   2 +-
 fs/udf/inode.c     |   2 -
 9 files changed, 220 insertions(+), 219 deletions(-)

							Thanks
								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
