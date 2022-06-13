Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A6B754A280
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jun 2022 01:20:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233505AbiFMXT7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Jun 2022 19:19:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbiFMXT6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Jun 2022 19:19:58 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12AD860EC;
        Mon, 13 Jun 2022 16:19:57 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3A7A421A94;
        Mon, 13 Jun 2022 23:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1655162395; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=IkkdWLZCbKTXcy+wyaIkRfefAaKEDvHsBtJt3VONYgA=;
        b=DwoBafhYE+kEHIlypI4/grEhAWzHf/UF0VyDCgMKrgDJIGweAh+P0DadbfI9RAZBJNPQa+
        b4/IGqGuitKJ+50MHrB/4WdGI38yXlh2GAMi0YPwrODaoyDlNw0fAAcpnFtVN3IlE7JsG/
        xSyF9acA9PeEVuQqiHrU7/0jevn20F0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1655162395;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=IkkdWLZCbKTXcy+wyaIkRfefAaKEDvHsBtJt3VONYgA=;
        b=rTVSAXoRTxOBYxsL5LWjJ+V89M/2QCl+IeuxWV/KKnz855LQKX2t8MUT5Qa9Iw3n0NTlzr
        yQtVtGj9veHk/NAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F1619134CF;
        Mon, 13 Jun 2022 23:19:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id M9J8KhjGp2KXbwAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 13 Jun 2022 23:19:52 +0000
Subject: [PATCH RFC 00/12] Allow concurrent directory updates.
From:   NeilBrown <neilb@suse.de>
To:     Al Viro <viro@zeniv.linux.org.uk>, Daire Byrne <daire@dneg.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Chuck Lever <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Date:   Tue, 14 Jun 2022 09:18:21 +1000
Message-ID: <165516173293.21248.14587048046993234326.stgit@noble.brown>
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

VFS currently holds an exclusive lock on a directory during create,
unlink, rename.  This imposes serialisation on all filesystems though
some may not benefit from it, and some may be able to provide finer
grained locking internally, thus reducing contention.

This series allows the filesystem to request that the inode lock be
shared rather than exclusive.  In that case an exclusive lock will be
held on the dentry instead, much as is done for parallel lookup.

The NFS filesystem can easily support concurrent updates (server does
any needed serialiation) so it is converted.

This series also converts nfsd to use the new interfaces so concurrent
incoming NFS requests in the one directory can be handled concurrently.

As a net result, if an NFS mounted filesystem is reexported over NFS,
then multiple clients can create files in a single directory and all
synchronisation will be handled on the final server.  This helps hid
latency on link from client to server.

I include a few nfsd patches that aren't strictly needed for this work,
but seem to be a logical consequence of the changes that I did have to
make.

I have only tested this lightly.  In particular the rename support is
quite new and I haven't tried to break it yet.

I post this for general review, and hopefully extra testing...  Daire
Byrne has expressed interest in the NFS re-export parallelism.

NeilBrown


---

NeilBrown (12):
      VFS: support parallel updates in the one directory.
      VFS: move EEXIST and ENOENT tests into lookup_hash_update()
      VFS: move want_write checks into lookup_hash_update()
      VFS: move dput() and mnt_drop_write() into done_path_update()
      VFS: export done_path_update()
      VFS: support concurrent renames.
      NFS: support parallel updates in the one directory.
      nfsd: allow parallel creates from nfsd
      nfsd: support concurrent renames.
      nfsd: reduce locking in nfsd_lookup()
      nfsd: use (un)lock_inode instead of fh_(un)lock
      nfsd: discard fh_locked flag and fh_lock/fh_unlock


 fs/dcache.c            |  59 ++++-
 fs/namei.c             | 578 ++++++++++++++++++++++++++++++++---------
 fs/nfs/dir.c           |  29 ++-
 fs/nfs/inode.c         |   2 +
 fs/nfs/unlink.c        |   5 +-
 fs/nfsd/nfs2acl.c      |   6 +-
 fs/nfsd/nfs3acl.c      |   4 +-
 fs/nfsd/nfs3proc.c     |  37 +--
 fs/nfsd/nfs4acl.c      |   7 +-
 fs/nfsd/nfs4proc.c     |  61 ++---
 fs/nfsd/nfs4state.c    |   8 +-
 fs/nfsd/nfsfh.c        |  10 +-
 fs/nfsd/nfsfh.h        |  58 +----
 fs/nfsd/nfsproc.c      |  31 +--
 fs/nfsd/vfs.c          | 243 ++++++++---------
 fs/nfsd/vfs.h          |   8 +-
 include/linux/dcache.h |  27 ++
 include/linux/fs.h     |   1 +
 include/linux/namei.h  |  30 ++-
 19 files changed, 791 insertions(+), 413 deletions(-)

--
Signature

