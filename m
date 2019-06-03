Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2EDE3330EB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2019 15:22:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728480AbfFCNWE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Jun 2019 09:22:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:40904 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727592AbfFCNWE (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Jun 2019 09:22:04 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id F3037AB91;
        Mon,  3 Jun 2019 13:22:02 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 4B8571E3C24; Mon,  3 Jun 2019 15:22:00 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     <linux-ext4@vger.kernel.org>
Cc:     Ted Tso <tytso@mit.edu>, <linux-mm@kvack.org>,
        <linux-fsdevel@vger.kernel.org>,
        Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>
Subject: [PATCH 0/2] fs: Hole punch vs page cache filling races
Date:   Mon,  3 Jun 2019 15:21:53 +0200
Message-Id: <20190603132155.20600-1-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

Amir has reported a that ext4 has a potential issues when reads can race with
hole punching possibly exposing stale data from freed blocks or even corrupting
filesystem when stale mapping data gets used for writeout. The problem is that
during hole punching, new page cache pages can get instantiated in a punched
range after truncate_inode_pages() has run but before the filesystem removes
blocks from the file.  In principle any filesystem implementing hole punching
thus needs to implement a mechanism to block instantiating page cache pages
during hole punching to avoid this race. This is further complicated by the
fact that there are multiple places that can instantiate pages in page cache.
We can have regular read(2) or page fault doing this but fadvise(2) or
madvise(2) can also result in reading in page cache pages through
force_page_cache_readahead().

This patch set fixes the problem for ext4 by protecting all page cache filling
opearation with EXT4_I(inode)->i_mmap_lock. To be able to do that for
readahead, we introduce new ->readahead file operation and corresponding
vfs_readahead() helper. Note that e.g. ->readpages() cannot be used for getting
the appropriate lock - we also need to protect ordinary read path using
->readpage() and there's no way to distinguish ->readpages() called through
->read_iter() from ->readpages() called e.g. through fadvise(2).

Other filesystems (e.g. XFS, F2FS, GFS2, OCFS2, ...) need a similar fix. I can
write some (e.g. for XFS) once we settle that ->readahead operation is indeed a
way to fix this.

								Honza

[1] https://lore.kernel.org/linux-fsdevel/CAOQ4uxjQNmxqmtA_VbYW0Su9rKRk2zobJmahcyeaEVOFKVQ5dw@mail.gmail.com/
