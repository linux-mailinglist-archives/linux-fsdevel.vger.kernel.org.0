Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15DCF6EE06E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Apr 2023 12:35:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233766AbjDYKfL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Apr 2023 06:35:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233622AbjDYKfG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Apr 2023 06:35:06 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D3F04EF4;
        Tue, 25 Apr 2023 03:35:03 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id F017C1FDA3;
        Tue, 25 Apr 2023 10:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1682418901; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=EngxOr74LmD+EbDulAtSDHNKsS4yfnnsS8WxkABG620=;
        b=hkX4+cXab6GUL3+As3qcBu7lHvRzJAsrhiF996u6c63ZA5vEAX+Kx+615wL0iaXM0KqFd/
        tkwRTGnUyViwrKB65duNZx/CKbtnUYMH0zk5Kv+KsGzjtQsGT3qGbQYx0NPos0hyKnOxUP
        rehRSB41KQ9TECr0b0OQwfsv9ewPu8Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1682418901;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=EngxOr74LmD+EbDulAtSDHNKsS4yfnnsS8WxkABG620=;
        b=lV4JD/4m0ZIcxP9Cp10olRava0PsnYDz+YCj6wflrsuav5DneVTAPfiCtodLxiE6GCWLPj
        yKV7rPfPOf6sZFCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E0EA4138E3;
        Tue, 25 Apr 2023 10:35:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id c+LeNtWsR2SGLQAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 25 Apr 2023 10:35:01 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 69228A0729; Tue, 25 Apr 2023 12:35:01 +0200 (CEST)
Date:   Tue, 25 Apr 2023 12:35:01 +0200
From:   Jan Kara <jack@suse.cz>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: [GIT PULL] ext2, reiserfs, udf, and quota cleanups and fixes for
 6.4-rc1
Message-ID: <20230425103501.ib4qoy4j5a3mzf2c@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

  Hello Linus,

  could you please pull from

git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fs_for_v6.4-rc1

To get a couple of small fixes and cleanups for ext2, udf, reiserfs, and
quota. The biggest change in this pull is making CONFIG_PRINT_QUOTA_WARNING
depend on BROKEN with an outlook for removing it completely in an year or
so.

Top of the tree is 36d532d713db. The full shortlog is:

Colin Ian King (1):
      ext2: remove redundant assignment to pointer end

Jan Kara (3):
      ext2: Correct maximum ext2 filesystem block size
      ext2: Check block size validity during mount
      quota: Use register_sysctl_init() for registering fs_dqstats_table

Luis Chamberlain (1):
      quota: simplify two-level sysctl registration for fs_dqstats_table

Matthew Wilcox (Oracle) (1):
      udf: Use folios in udf_adinicb_writepage()

Tom Rix (2):
      reiserfs: remove unused sched_count variable
      reiserfs: remove unused iter variable

Yangtao Li (5):
      udf: use wrapper i_blocksize() in udf_discard_prealloc()
      quota: fixup *_write_file_info() to return proper error code
      quota: make dquot_set_dqinfo return errors from ->write_info
      quota: update Kconfig comment
      quota: mark PRINT_QUOTA_WARNING as BROKEN

The diffstat is

 fs/ext2/ext2.h        |  3 ++-
 fs/ext2/super.c       |  7 +++++++
 fs/ext2/xattr.c       |  1 -
 fs/quota/Kconfig      |  4 ++--
 fs/quota/dquot.c      | 24 ++----------------------
 fs/quota/quota_v1.c   |  2 +-
 fs/quota/quota_v2.c   |  2 +-
 fs/reiserfs/journal.c |  2 --
 fs/reiserfs/stree.c   |  2 --
 fs/udf/inode.c        | 10 +++++-----
 fs/udf/truncate.c     |  4 ++--
 11 files changed, 22 insertions(+), 39 deletions(-)

							Thanks
								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
