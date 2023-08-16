Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7A6077D9A5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Aug 2023 07:09:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241805AbjHPFIL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Aug 2023 01:08:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241817AbjHPFIK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Aug 2023 01:08:10 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72334D1;
        Tue, 15 Aug 2023 22:08:09 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 317AB21961;
        Wed, 16 Aug 2023 05:08:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1692162488; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=kxsKmHWGtKjTsaPWvpb6GoO8un05d93uluQteuNEpjk=;
        b=h5KhqvcTyvJEGrqCdtIGrrikRGa185BCSx0hEuYqm8RPpkL+I9tQ8zCxb3YjlX25ACh+Yy
        piOoQIsJd4vPIEEu14tHvtFqxDgwAdlb7oUHSRa0zeb2LreRu/YiBFMVYaJM/7E39Azy5c
        /BdECTDEOyf/kom8KcxdHx/KVXt39vc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1692162488;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=kxsKmHWGtKjTsaPWvpb6GoO8un05d93uluQteuNEpjk=;
        b=Gi4uKrMGQ6x2tutZgxjlXf3ZfXUKxHPVlAYyNHkQPyusJ2pTcRd5XbK/xUZA6AfS+PZpd8
        wFx/61RDUNoyv3Aw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id ED675133F2;
        Wed, 16 Aug 2023 05:08:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id gOE8NLdZ3GTTTgAAMHmgww
        (envelope-from <krisman@suse.de>); Wed, 16 Aug 2023 05:08:07 +0000
From:   Gabriel Krisman Bertazi <krisman@suse.de>
To:     viro@zeniv.linux.org.uk, brauner@kernel.org, tytso@mit.edu,
        ebiggers@kernel.org, jaegeuk@kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        Gabriel Krisman Bertazi <krisman@suse.de>
Subject: [PATCH v6 0/9] Support negative dentries on case-insensitive ext4 and f2fs
Date:   Wed, 16 Aug 2023 01:07:54 -0400
Message-ID: <20230816050803.15660-1-krisman@suse.de>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

This is v6 of the negative dentry on case-insensitive directories.
Thanks Eric for the review of the last iteration.  This version
drops the patch to expose the helper to check casefolding directories,
since it is not necessary in ecryptfs and it might be going away.  It
also addresses some documentation details, fix a build bot error and
simplifies the commit messages.  See the changelog in each patch for
more details.

Thanks,

---

Gabriel Krisman Bertazi (9):
  ecryptfs: Reject casefold directory inodes
  9p: Split ->weak_revalidate from ->revalidate
  fs: Expose name under lookup to d_revalidate hooks
  fs: Add DCACHE_CASEFOLDED_NAME flag
  libfs: Validate negative dentries in case-insensitive directories
  libfs: Chain encryption checks after case-insensitive revalidation
  libfs: Merge encrypted_ci_dentry_ops and ci_dentry_ops
  ext4: Enable negative dentries on case-insensitive lookup
  f2fs: Enable negative dentries on case-insensitive lookup

 Documentation/filesystems/locking.rst |   3 +-
 Documentation/filesystems/vfs.rst     |  11 ++-
 fs/9p/vfs_dentry.c                    |  11 ++-
 fs/afs/dir.c                          |   6 +-
 fs/afs/dynroot.c                      |   4 +-
 fs/ceph/dir.c                         |   3 +-
 fs/coda/dir.c                         |   3 +-
 fs/crypto/fname.c                     |   3 +-
 fs/dcache.c                           |   8 ++
 fs/ecryptfs/dentry.c                  |   5 +-
 fs/ecryptfs/inode.c                   |   8 ++
 fs/exfat/namei.c                      |   3 +-
 fs/ext4/namei.c                       |  35 +--------
 fs/f2fs/namei.c                       |  25 +-----
 fs/fat/namei_vfat.c                   |   6 +-
 fs/fuse/dir.c                         |   3 +-
 fs/gfs2/dentry.c                      |   3 +-
 fs/hfs/sysdep.c                       |   3 +-
 fs/jfs/namei.c                        |   3 +-
 fs/kernfs/dir.c                       |   3 +-
 fs/libfs.c                            | 107 ++++++++++++++++++--------
 fs/namei.c                            |  18 +++--
 fs/nfs/dir.c                          |   9 ++-
 fs/ocfs2/dcache.c                     |   4 +-
 fs/orangefs/dcache.c                  |   3 +-
 fs/overlayfs/super.c                  |  20 +++--
 fs/proc/base.c                        |   6 +-
 fs/proc/fd.c                          |   3 +-
 fs/proc/generic.c                     |   6 +-
 fs/proc/proc_sysctl.c                 |   3 +-
 fs/reiserfs/xattr.c                   |   3 +-
 fs/smb/client/dir.c                   |   3 +-
 fs/vboxsf/dir.c                       |   4 +-
 include/linux/dcache.h                |  10 ++-
 include/linux/fscrypt.h               |   4 +-
 35 files changed, 216 insertions(+), 136 deletions(-)

-- 
2.41.0

