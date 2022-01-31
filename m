Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E4974A3CC7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Jan 2022 05:04:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357515AbiAaEEI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 30 Jan 2022 23:04:08 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:38096 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237371AbiAaEEH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 30 Jan 2022 23:04:07 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id F2A5D1F37B;
        Mon, 31 Jan 2022 04:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1643601846; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=a1hKKv4tQs0IkB2xFQLDfa5QVFGb4OvJBNqopkGrr6k=;
        b=fiVkEAwxRDflObUldBuKWNJQJVCMu9eTTko+720oBoKH20RkmraMDCjs0Iy00tjy/uphUk
        128iAjXpmRCycvT2drQM/OATXxz69rsiprFbeB2pPwa9L9eR8aiP2KJRgd4bmESc8+RqhM
        0lrloqgzFrVvw8R08CSdyUMX4lq4gLg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1643601846;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=a1hKKv4tQs0IkB2xFQLDfa5QVFGb4OvJBNqopkGrr6k=;
        b=uob4sOy+PK8E9TZ09Wj6Bhv0xAVwnyLeFUUFdeVvKXtH0q63G8ED3ptWJSVL4uJG3uhlu4
        DO1m665lXtn3d/Cw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B1220133A4;
        Mon, 31 Jan 2022 04:04:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id B7tCG7Jf92GMCQAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 31 Jan 2022 04:04:02 +0000
Subject: [PATCH 0/3] remove dependence of inode_congested()
From:   NeilBrown <neilb@suse.de>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
Cc:     linux-mm@kvack.org, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 31 Jan 2022 15:03:53 +1100
Message-ID: <164360127045.4233.2606812444285122570.stgit@noble.brown>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Miklos pointed out that the filesystems which set the bdi congestion
flags do gain some value from that, and simply removing the code is not
appropriate.

Specifically, readahead and/or writeback are skipped when the congestion
flags are set.

We can mostly move this skipping into the filesystem.
->readahead can do nothing if reads are congested.
->writepage and ->wrtepages can do nothing for WB_SYNC_NONE if writes
  are congested.

Currently only *some* WB_SYNC_NONE writes are skipped due to congestion.
Those from sync_file_range() and those used for page migration are not.
Also, shrink_page_list() will now cause PageActive to be set if
->writepage skips due to congestion.

I don't expect these changes to be a problem, but I have no experience
to base that on.

Review/comments most welcome,

Thanks,
NeilBrown



---

NeilBrown (3):
      fuse: remove reliance on bdi congestion
      nfs: remove reliance on bdi congestion
      ceph: remove reliance on bdi congestion


 fs/ceph/addr.c            | 22 +++++++++++++---------
 fs/ceph/super.c           |  1 +
 fs/ceph/super.h           |  1 +
 fs/nfs/write.c            | 12 ++++++++++--
 include/linux/nfs_fs_sb.h |  1 +
 5 files changed, 26 insertions(+), 11 deletions(-)

--
Signature

