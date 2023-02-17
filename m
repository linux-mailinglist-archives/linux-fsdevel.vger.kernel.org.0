Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25E4269AAA6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Feb 2023 12:43:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbjBQLnr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Feb 2023 06:43:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjBQLnq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Feb 2023 06:43:46 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F7AB5BD86
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Feb 2023 03:43:44 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 5AFDF338BC;
        Fri, 17 Feb 2023 11:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1676634223; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=FcDOFahDw/rEohl+PiQu3YgicH8XCnIK7g04TJs6Xa0=;
        b=Hmp2o2liyldjfciC5mepoNfHCdK0ARWXZvjh9KRjNOcu6WoLiG+U1pEsNkjbSDSA3R+t8r
        nQrT0woPyKgBdazV8j8WmSYe0gergwAJSYRFj2AVEmZ+4d3GTfQsXn4SEmzbUtWoK5QpZA
        7pimLWV6jTzowP8FmzMyiKg+b0u1y+M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1676634223;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=FcDOFahDw/rEohl+PiQu3YgicH8XCnIK7g04TJs6Xa0=;
        b=wnTPSXi8ZXPDcDMKDYS87A7dLg+UOWWNHLEjKFZzNllLlEu98qmSq+u/OrACxencrZ5xkA
        AFxheShSjsm0KPCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 45AA513274;
        Fri, 17 Feb 2023 11:43:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id eBNwEG9o72OMUQAAMHmgww
        (envelope-from <jack@suse.cz>); Fri, 17 Feb 2023 11:43:43 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id B2A37A06E1; Fri, 17 Feb 2023 12:43:42 +0100 (CET)
Date:   Fri, 17 Feb 2023 12:43:42 +0100
From:   Jan Kara <jack@suse.cz>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] UDF and ext2 fixes
Message-ID: <20230217114342.vafa3sf7tm4cojh6@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

  Hello Linus,

  could you please pull from

git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fixes_for_v6.3-rc1

to get:
  * Rewrite of udf directory iteration code to address multiple syzbot
    reports
  * Fixes to udf extent handling and block mapping code to address several
    syzbot reports and filesystem corruption issues uncovered by fsx &
    fsstress
  * Convert udf to kmap_local()
  * Add sanity checks when loading udf bitmaps
  * Drop old VARCONV support which I've never seen used and which was broken
    for quite some years without anybody noticing
  * Finish conversion of ext2 to kmap_local()
  * One fix to mpage_writepages() on which other udf fixes depend

Top of the tree is df97f64dfa31. The full shortlog is:

Christoph Hellwig (1):
      ext2: propagate errors from ext2_prepare_chunk

Colin Ian King (2):
      udf: Fix spelling mistake "lenght" -> "length"
      udf: remove redundant variable netype

Fabio M. De Francesco (1):
      fs/ext2: Replace kmap_atomic() with kmap_local_page()

Jan Kara (71):
      udf: Define EFSCORRUPTED error code
      udf: New directory iteration code
      udf: Convert udf_readdir() to new directory iteration
      udf: Convert udf_expand_dir_adinicb() to new directory iteration
      udf: Move udf_expand_dir_adinicb() to its callsite
      udf: Implement searching for directory entry using new iteration code
      udf: Convert udf_lookup() to use new directory iteration code
      udf: Convert udf_get_parent() to new directory iteration code
      udf: Convert empty_dir() to new directory iteration code
      udf: Provide function to mark entry as deleted using new directory iteration code
      udf: Convert udf_rmdir() to new directory iteration code
      udf: Convert udf_unlink() to new directory iteration code
      udf: Implement adding of dir entries using new iteration code
      udf: Convert udf_add_nondir() to new directory iteration
      udf: Convert udf_mkdir() to new directory iteration code
      udf: Convert udf_link() to new directory iteration code
      udf: Convert udf_rename() to new directory iteration code
      udf: Remove old directory iteration code
      udf: Truncate added extents on failed expansion
      udf: Do not bother merging very long extents
      udf: Handle error when expanding directory
      udf: Handle error when adding extent to symlink
      udf: Handle error when adding extent to a file
      udf: Allocate name buffer in directory iterator on heap
      udf: Move setting of i_lenExtents into udf_do_extend_file()
      udf: Keep i_lenExtents consistent with the total length of extents
      udf: Do not update file length for failed writes to inline files
      udf: Preserve link count of system files
      udf: Detect system inodes linked into directory hierarchy
      udf: Zero udf name padding
      udf: Propagate errors from udf_advance_blk()
      udf: Fix directory iteration for longer tail extents
      udf: Unify types in anchor block detection
      udf: Drop VARCONV support
      udf: Move incrementing of goal block directly into inode_getblk()
      udf: Factor out block mapping into udf_map_block()
      udf: Use udf_bread() in udf_get_pblock_virt15()
      udf: Use udf_bread() in udf_load_vat()
      udf: Do not call udf_block_map() on ICB files
      udf: Convert udf_symlink_filler() to use udf_bread()
      udf: Fold udf_block_map() into udf_map_block()
      udf: Pass mapping request into inode_getblk()
      udf: Add flag to disable block preallocation
      udf: Use udf_map_block() in udf_getblk()
      udf: Fold udf_getblk() into udf_bread()
      udf: Protect rename against modification of moved directory
      udf: Push i_data_sem locking into udf_expand_file_adinicb()
      udf: Push i_data_sem locking into udf_extend_file()
      udf: Simplify error handling in udf_file_write_iter()
      udf: Protect truncate and file type conversion with invalidate_lock
      udf: Allocate blocks on write page fault
      fs: gracefully handle ->get_block not mapping bh in __mpage_writepage
      udf: Do not allocate blocks on page writeback
      udf: Fix file corruption when appending just after end of preallocated extent
      udf: Fix off-by-one error when discarding preallocation
      udf: Unify .read_folio for normal and in-ICB files
      udf: Convert in-ICB files to use udf_writepages()
      udf: Convert in-ICB files to use udf_direct_IO()
      udf: Convert in-ICB files to use udf_write_begin()
      udf: Convert all file types to use udf_write_end()
      udf: Add handling of in-ICB files to udf_bmap()
      udf: Switch to single address_space_operations
      udf: Mark aops implementation static
      udf: Move udf_adinicb_readpage() to inode.c
      udf: Switch udf_adinicb_readpage() to kmap_local_page()
      udf: Convert udf_adinicb_writepage() to memcpy_to_page()
      udf: Convert udf_expand_file_adinicb() to avoid kmap_atomic()
      udf: Don't return bh from udf_expand_dir_adinicb()
      udf: Limit file size to 4TB
      udf: Fix file counting in LVID
      udf: Avoid directory type conversion failure due to ENOMEM

Kees Cook (1):
      udf: Use unsigned variables for size calculations

Tom Rix (1):
      udf: remove reporting loc in debug output

Vladislav Efanov (1):
      udf: Check consistency of Space Bitmap Descriptor

The diffstat is

 fs/ext2/dir.c      |   17 +-
 fs/ext2/ext2.h     |    5 +-
 fs/ext2/namei.c    |   21 +-
 fs/mpage.c         |    2 +
 fs/udf/balloc.c    |   33 +-
 fs/udf/dir.c       |  148 ++-----
 fs/udf/directory.c |  579 +++++++++++++++++++++-------
 fs/udf/file.c      |  176 ++++-----
 fs/udf/ialloc.c    |   31 +-
 fs/udf/inode.c     |  602 +++++++++++++++--------------
 fs/udf/lowlevel.c  |    7 +-
 fs/udf/misc.c      |   18 +-
 fs/udf/namei.c     | 1093 +++++++++++++++++++---------------------------------
 fs/udf/partition.c |    9 +-
 fs/udf/super.c     |   77 ++--
 fs/udf/symlink.c   |   28 +-
 fs/udf/truncate.c  |    6 +-
 fs/udf/udf_i.h     |    3 +-
 fs/udf/udf_sb.h    |    3 +-
 fs/udf/udfdecl.h   |   57 ++-
 20 files changed, 1362 insertions(+), 1553 deletions(-)

							Thanks
								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
