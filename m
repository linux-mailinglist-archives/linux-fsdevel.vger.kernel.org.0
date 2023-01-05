Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B33D65EEB8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Jan 2023 15:26:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233539AbjAEO0z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Jan 2023 09:26:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233880AbjAEO0w (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Jan 2023 09:26:52 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02732568A7
        for <linux-fsdevel@vger.kernel.org>; Thu,  5 Jan 2023 06:26:51 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 83CF73FFDF;
        Thu,  5 Jan 2023 14:26:45 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7744913338;
        Thu,  5 Jan 2023 14:26:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id v54RHSXetmOnCwAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 05 Jan 2023 14:26:45 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id E74E6A0742; Thu,  5 Jan 2023 15:26:44 +0100 (CET)
Date:   Thu, 5 Jan 2023 15:26:44 +0100
From:   Jan Kara <jack@suse.cz>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] udf fixes for 6.2-rc3 and ext2 cleanup
Message-ID: <20230105142644.ubqxsokgthyfi56h@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Authentication-Results: smtp-out1.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: 0.40
X-Spamd-Result: default: False [0.40 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         RCPT_COUNT_TWO(0.00)[2];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         MID_RHS_NOT_FQDN(0.50)[];
         RCVD_COUNT_TWO(0.00)[2];
         RCVD_TLS_ALL(0.00)[]
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

  Hello Linus,

  could you please pull from

git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git for_v6.2-rc3

to get:
 * A lot of fixes of UDF directory handling code (effectively a rewrite of
   directory entry handling). It fixes multiple crashes and corruption
   issues spotted by syzbot.
 * Couple of fixes to UDF extent handling code fixing several
   filesystem corruption issues found by syzbot, fsx, and fsstress.
 * Some followup fixups for the extent handling fixes that went in during
   the merge window.
 * Trivial patch replacing kmap_atomic() usage with kmap_local_page() in
   ext2.

The pull request is somewhat large but given these are all fixes (except
for ext2 conversion) and we are only at rc3, I hope it is fine.

Top of the tree is e86812bfac97. The full shortlog is:

Colin Ian King (1):
      udf: Fix spelling mistake "lenght" -> "length"

Fabio M. De Francesco (1):
      fs/ext2: Replace kmap_atomic() with kmap_local_page()

Jan Kara (30):
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
      udf: Fix extension of the last extent in the file
      udf: Keep i_lenExtents consistent with the total length of extents
      udf: Do not update file length for failed writes to inline files
      udf: Preserve link count of system files
      udf: Detect system inodes linked into directory hierarchy

Tom Rix (1):
      udf: initialize newblock to 0

The diffstat is

 fs/ext2/dir.c      |    4 +-
 fs/udf/dir.c       |  148 ++------
 fs/udf/directory.c |  567 +++++++++++++++++++++-------
 fs/udf/file.c      |   26 +-
 fs/udf/inode.c     |  195 +++-------
 fs/udf/namei.c     | 1062 ++++++++++++++++++----------------------------------
 fs/udf/super.c     |    1 +
 fs/udf/udf_i.h     |    3 +-
 fs/udf/udf_sb.h    |    2 +
 fs/udf/udfdecl.h   |   45 +--
 10 files changed, 920 insertions(+), 1133 deletions(-)

							Thanks
								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
