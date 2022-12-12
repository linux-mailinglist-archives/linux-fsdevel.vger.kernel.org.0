Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3222D64A577
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Dec 2022 18:04:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232934AbiLLREc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Dec 2022 12:04:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232814AbiLLREK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Dec 2022 12:04:10 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 306B81056C;
        Mon, 12 Dec 2022 09:04:04 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C35B41FE2B;
        Mon, 12 Dec 2022 17:04:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1670864642; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=PbexLX/SJWGWEaHMvMhd2z7nCseXDShLAsC7Ku5L2ag=;
        b=zng91BHEFl8BjH0bHbXDmDNMtz31OQJ051dnzZ9gIbqSJA578YWqfzhUIW2ZaDFL68foU2
        3xsNWYu8Anmo5by52Xoh4fdxnO58a23PpBm8GsOIlrvoTBArUEwikSoGQdY9fpUeh3t+YV
        hf+6NCWz+UXTBfsUJRA+IBWowkpHwq4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1670864642;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=PbexLX/SJWGWEaHMvMhd2z7nCseXDShLAsC7Ku5L2ag=;
        b=gj0phcg33sAwv0AihoRlz1ZRujeSTuKZmgXjgOh8inURCmpBRG1tUT0b7d2w8gx8p32wrf
        IuC68vsRAoy1KMCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B5C0E13456;
        Mon, 12 Dec 2022 17:04:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id AVdZLAJfl2OvGAAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 12 Dec 2022 17:04:02 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 3D308A0727; Mon, 12 Dec 2022 18:04:02 +0100 (CET)
Date:   Mon, 12 Dec 2022 18:04:02 +0100
From:   Jan Kara <jack@suse.cz>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: [GIT PULL] udf and ext2 fixes for 6.2-rc1
Message-ID: <20221212170402.w4mqtu4a65kphtju@quack3>
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

git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fixes_for_v6.2-rc1

to get:
 * couple of smaller cleanups and fixes for ext2
 * fixes of a data corruption issues in udf when handling holes and
   preallocation extents
 * fixes and cleanups of several smaller issues in udf
 * add maintainer entry for isofs

Top of the tree is 1f3868f06855. The full shortlog is:

Al Viro (1):
      ext2: unbugger ext2_empty_dir()

Bartosz Taudul (1):
      udf: Increase UDF_MAX_READ_VERSION to 0x0260

Bo Liu (1):
      ext2: Fix some kernel-doc warnings

Christoph Hellwig (2):
      ext2: remove ->writepage
      udf: remove ->writepage

Jan Kara (6):
      maintainers: Add ISOFS entry
      ext2: Don't flush page immediately for DIRSYNC directories
      udf: Fix preallocation discarding at indirect extent boundary
      udf: Do not bother looking for prealloc extents if i_lenExtents matches i_size
      udf: Discard preallocation before extending file with a hole
      udf: Fix extending file within last block

Li zeming (1):
      fs: udf: Optimize udf_free_in_core_inode and udf_find_fileset function

Rong Tao (1):
      fs/ext2: Fix code indentation

Shigeru Yoshida (1):
      udf: Avoid double brelse() in udf_rename()

The diffstat is

 MAINTAINERS       |  7 +++++
 fs/ext2/balloc.c  | 12 ++++----
 fs/ext2/dir.c     | 41 +++++++++++++++------------
 fs/ext2/inode.c   |  6 ----
 fs/ext2/super.c   |  2 +-
 fs/udf/inode.c    | 83 +++++++++++++++++++++++--------------------------------
 fs/udf/namei.c    |  8 +++---
 fs/udf/super.c    |  4 +--
 fs/udf/truncate.c | 48 ++++++++++----------------------
 fs/udf/udf_sb.h   |  6 +++-
 10 files changed, 98 insertions(+), 119 deletions(-)

							Thanks
								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
