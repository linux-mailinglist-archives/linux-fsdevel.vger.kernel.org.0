Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 812FD40A1E7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Sep 2021 02:27:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238145AbhINA26 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Sep 2021 20:28:58 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:55030 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236554AbhINA26 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Sep 2021 20:28:58 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 1FDF8200AB;
        Tue, 14 Sep 2021 00:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1631579260; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=PFbh9I08qiRIpx/LwQHrN9x2N5uOULjufRHblHpoK4g=;
        b=uuSgtJ0+FRAjj4cM0Uw3gizAGdSOZ9KZJdQa8Xe47I5rWpB/k4+CBglCk9ze0+ku71h0Kj
        DLOGlj0TJIV61exkhj/GiPT941q/fF9d5QndRC2KIKAtbsWDv1tpN5woiO3T0qT26hW9qR
        4D8sFiwSqMqGDl+rMHe/VXOuaFh4drI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1631579260;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=PFbh9I08qiRIpx/LwQHrN9x2N5uOULjufRHblHpoK4g=;
        b=0FOlCmgmDR5J/+kI3Q4QjdyDlONqJLexEA9naFbBESq2iYI7TMeUTBl0wf8j5qeuc63GzD
        MaW4gs77K7fW/GDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B074513ADE;
        Tue, 14 Sep 2021 00:27:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 4YCuG3jsP2ECawAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 14 Sep 2021 00:27:36 +0000
From:   NeilBrown <neilb@suse.de>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.com>
Date:   Tue, 14 Sep 2021 10:13:04 +1000
Subject: [PATCH 0/6] congestion_wait() and GFP_NOFAIL
Cc:     linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Message-ID: <163157808321.13293.486682642188075090.stgit@noble.brown>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

While working on an NFS issue recently I was informed (or maybe
"reminded") that congestion_wait() doesn't really do what we think it
does.   It is indistinguishable from schedule_timeout_uninterruptible().

Some current users for congestion_wait() would be better suited by
__GFP_NOFAIL.   In related discussions it was pointed out that the 
__GFP_NOFAIL documentation could usefully clarify the costs of its use.

So this set of patch addresses some of these issues.  The patches are
all independent and can safely be applied separately in different tress
as appropriate.

They:
 - add or improve documentation relating to these issues
 - make a tiny fix to the page_alloc_bulk_*
 - replace those calls to congestion_wait() which are simply waiting
   to retry a memory allocation.

These are the easy bits.  There are 5 calls to congestion_wait() and one
to wait_iff_congested() in mm/ which need consideration.  There are
multiple calls to congestion_wait in fs/, particularly fs/f2fs/ which
need to be addressed too.  I'll try to form an opinion about these in
coming weeks.

Thanks,
NeilBrown


---

NeilBrown (6):
      MM: improve documentation for __GFP_NOFAIL
      MM: annotate congestion_wait() and wait_iff_congested() as ineffective.
      EXT4: Remove ENOMEM/congestion_wait() loops.
      EXT4: remove congestion_wait from ext4_bio_write_page, and simplify
      XFS: remove congestion_wait() loop from kmem_alloc()
      XFS: remove congestion_wait() loop from xfs_buf_alloc_pages()


 fs/ext4/ext4.h              |  2 +-
 fs/ext4/ext4_jbd2.c         |  8 +++++-
 fs/ext4/extents.c           | 49 ++++++++++++++-----------------------
 fs/ext4/extents_status.c    | 35 ++++++++++++++------------
 fs/ext4/extents_status.h    |  2 +-
 fs/ext4/indirect.c          |  2 +-
 fs/ext4/inode.c             |  6 ++---
 fs/ext4/ioctl.c             |  4 +--
 fs/ext4/page-io.c           | 13 ++++------
 fs/ext4/super.c             |  2 +-
 fs/jbd2/transaction.c       |  8 +++---
 fs/xfs/kmem.c               | 16 +++---------
 fs/xfs/xfs_buf.c            |  6 ++---
 include/linux/backing-dev.h |  7 ++++++
 mm/backing-dev.c            |  9 +++++++
 15 files changed, 86 insertions(+), 83 deletions(-)

--
Signature

