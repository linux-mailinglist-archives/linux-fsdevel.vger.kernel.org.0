Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EA6740EFEE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Sep 2021 04:59:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243196AbhIQDAp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Sep 2021 23:00:45 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:41356 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243049AbhIQDAp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Sep 2021 23:00:45 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 09F2B2007B;
        Fri, 17 Sep 2021 02:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1631847562; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=8pvkjCFdBH92niZgGsbVOrH9zONIePhOsL1BwdfqgnA=;
        b=NrP8J0vhVKv0eLroW/bpzL2ejtwWpy1oEAi7DdQ4kMU5Kv8Oq6l5iLYPu7H9EkxbF1q4/A
        na+xtpPAcJUY68yb7FlQ9lmxSLRRQKANIKbvzZj9RSTof31Djq1vJviErXSODqyW0wqB4e
        LQe1sAc/mk1g9ojaRCFZduOcyNryYAc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1631847562;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=8pvkjCFdBH92niZgGsbVOrH9zONIePhOsL1BwdfqgnA=;
        b=PMuREhLfwiF/t1B800k94ChByfic8xUfzyWra9ANkKBEq5p7ic9AJetd/jrDccwucIyfGK
        Kco4+Zd25/JWTsBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9733913D0B;
        Fri, 17 Sep 2021 02:59:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id wyQIFYUERGFLMwAAMHmgww
        (envelope-from <neilb@suse.de>); Fri, 17 Sep 2021 02:59:17 +0000
Subject: [PATCH 0/6 v2] congestion_wait() and GFP_NOFAIL
From:   NeilBrown <neilb@suse.de>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@suse.com>,
        ". Dave Chinner" <david@fromorbit.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Date:   Fri, 17 Sep 2021 12:56:57 +1000
Message-ID: <163184698512.29351.4735492251524335974.stgit@noble.brown>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This second version:
  - add recipients for the Documentation/core-api changes
  - add fix for __alloc_pages_bulk() to handle GFP_NOFAIL
  - drops the annotations for congestion_wait() as being ineffective
    as that isn't really useful until an alternative is available
  - changes to GFP_NOFAIL documentation changes to focus on the possible
    deadlocks rather than the use of memory reserves
  - Improves ext4 and xfs patches based on feedback from Ted and Dave.

The patches are independent, except that the last patch depends on the
first.

As mentioned last time:

  These are the easy bits.  There are 5 calls to congestion_wait() and
  one to wait_iff_congested() in mm/ which need consideration.  There
  are multiple calls to congestion_wait in fs/, particularly fs/f2fs/
  which need to be addressed too.  I'll try to form an opinion about
  these in coming weeks.

(other interesting comment in original cover letter just duplicates
 observations made in the commit messages of individual patches).

NeilBrown


---

NeilBrown (6):
      MM: Support __GFP_NOFAIL in  alloc_pages_bulk_*() and improve doco
      MM: improve documentation for __GFP_NOFAIL
      EXT4: Remove ENOMEM/congestion_wait() loops.
      EXT4: remove congestion_wait from ext4_bio_write_page, and simplify
      XFS: remove congestion_wait() loop from kmem_alloc()
      XFS: remove congestion_wait() loop from xfs_buf_alloc_pages()


 Documentation/core-api/memory-allocation.rst | 25 ++++++++-
 fs/ext4/ext4.h                               |  2 +-
 fs/ext4/ext4_jbd2.c                          |  4 +-
 fs/ext4/ext4_jbd2.h                          | 14 +++---
 fs/ext4/extents.c                            | 53 ++++++++------------
 fs/ext4/extents_status.c                     | 35 +++++++------
 fs/ext4/extents_status.h                     |  2 +-
 fs/ext4/ialloc.c                             |  3 +-
 fs/ext4/indirect.c                           |  2 +-
 fs/ext4/inode.c                              |  6 +--
 fs/ext4/ioctl.c                              |  4 +-
 fs/ext4/page-io.c                            | 13 ++---
 fs/ext4/super.c                              |  2 +-
 fs/jbd2/transaction.c                        |  8 +--
 fs/xfs/kmem.c                                | 19 +++----
 fs/xfs/xfs_buf.c                             | 14 +++---
 include/linux/gfp.h                          |  6 ++-
 17 files changed, 113 insertions(+), 99 deletions(-)

--
Signature

