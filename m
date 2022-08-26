Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D2A15A1E99
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Aug 2022 04:16:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244459AbiHZCQu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Aug 2022 22:16:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233431AbiHZCQt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Aug 2022 22:16:49 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 684EFC9EA3;
        Thu, 25 Aug 2022 19:16:48 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 019A420441;
        Fri, 26 Aug 2022 02:16:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1661480207; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=rdewQxjoX3h2OYaDP8Q52JaGQBN0oIzHjo+RTRN04G4=;
        b=MBjbPDKRhm92P0yOj50KQYPjcAwo5rPA217+WOb37bH9d6Hrr/QwT9H8SKTSvFYf95Ujct
        ScnjsCkqwlaqlBCiMaO9hB56oLl3xcyPNA8fouOLDFh2cLSgfDyU4NAxeZA/+Nx7eC4sdY
        hRUh8Syjaimegb0WF51F/EHDozAJszA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1661480207;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=rdewQxjoX3h2OYaDP8Q52JaGQBN0oIzHjo+RTRN04G4=;
        b=DnlkIkPs1iBbbePvziGXurxqyOTbqAazE1qRcEhbnn5zMTgt4Ju9viiCoDAr2SJK2lDKn8
        Q/Q/L9OiKI6a/fBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6B17313A65;
        Fri, 26 Aug 2022 02:16:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 1NFdCQwtCGNCMQAAMHmgww
        (envelope-from <neilb@suse.de>); Fri, 26 Aug 2022 02:16:44 +0000
Subject: [PATCH/RFC 00/10 v5] Improve scalability of directory operations
From:   NeilBrown <neilb@suse.de>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Daire Byrne <daire@dneg.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Chuck Lever <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Date:   Fri, 26 Aug 2022 12:10:43 +1000
Message-ID: <166147828344.25420.13834885828450967910.stgit@noble.brown>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

[I made up "v5" - I haven't been counting]

VFS currently holds an exclusive lock on the directory while making
changes: add, remove, rename.
When multiple threads make changes in the one directory, the contention
can be noticeable.
In the case of NFS with a high latency link, this can easily be
demonstrated.  NFS doesn't really need VFS locking as the server ensures
correctness.

Lustre uses a single(?) directory for object storage, and has patches
for ext4 to support concurrent updates (Lustre accesses ext4 directly,
not via the VFS).

XFS (it is claimed) doesn't its own locking and doesn't need the VFS to
help at all.

This patch series allows filesystems to request a shared lock on
directories and provides serialisation on just the affected name, not the
whole directory.  It changes both the VFS and NFSD to use shared locks
when appropriate, and changes NFS to request shared locks.

The central enabling feature is a new dentry flag DCACHE_PAR_UPDATE
which acts as a bit-lock.  The ->d_lock spinlock is taken to set/clear
it, and wait_var_event() is used for waiting.  This flag is set on all
dentries that are part of a directory update, not just when a shared
lock is taken.

When a shared lock is taken we must use alloc_dentry_parallel() which
needs a wq which must remain until the update is completed.  To make use
of concurrent create, kern_path_create() would need to be passed a wq.
Rather than the churn required for that, we use exclusive locking when
no wq is provided.

One interesting consequence of this is that silly-rename becomes a
little more complex.  As the directory may not be exclusively locked,
the new silly-name needs to be locked (DCACHE_PAR_UPDATE) as well.
A new LOOKUP_SILLY_RENAME is added which helps implement this using
common code.

While testing I found some odd behaviour that was caused by
d_revalidate() racing with rename().  To resolve this I used
DCACHE_PAR_UPDATE to ensure they cannot race any more.

Testing, review, or other comments would be most welcome,

NeilBrown


---

NeilBrown (10):
      VFS: support parallel updates in the one directory.
      VFS: move EEXIST and ENOENT tests into lookup_hash_update()
      VFS: move want_write checks into lookup_hash_update()
      VFS: move dput() and mnt_drop_write() into done_path_update()
      VFS: export done_path_update()
      VFS: support concurrent renames.
      VFS: hold DCACHE_PAR_UPDATE lock across d_revalidate()
      NFSD: allow parallel creates from nfsd
      VFS: add LOOKUP_SILLY_RENAME
      NFS: support parallel updates in the one directory.


 fs/dcache.c            |  72 ++++-
 fs/namei.c             | 616 ++++++++++++++++++++++++++++++++---------
 fs/nfs/dir.c           |  28 +-
 fs/nfs/fs_context.c    |   6 +-
 fs/nfs/internal.h      |   3 +-
 fs/nfs/unlink.c        |  51 +++-
 fs/nfsd/nfs3proc.c     |  28 +-
 fs/nfsd/nfs4proc.c     |  29 +-
 fs/nfsd/nfsfh.c        |   9 +
 fs/nfsd/nfsproc.c      |  29 +-
 fs/nfsd/vfs.c          | 177 +++++-------
 include/linux/dcache.h |  28 ++
 include/linux/fs.h     |   5 +-
 include/linux/namei.h  |  39 ++-
 14 files changed, 799 insertions(+), 321 deletions(-)

--
Signature

