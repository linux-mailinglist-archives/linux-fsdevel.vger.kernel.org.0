Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 670AE3C610D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jul 2021 18:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235131AbhGLQ7L (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jul 2021 12:59:11 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:34506 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234300AbhGLQ7B (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jul 2021 12:59:01 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id EDC4B21A75;
        Mon, 12 Jul 2021 16:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1626108969; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=Xtj0uq/0myKG76i6UCshFGN5FKtbSNJBLWeNEEm5CDI=;
        b=GjS2IA9SK053DbdzylFNJsY7fStUV8dPVrF7oJWUSr8JYDCbZlHxpna4rF2eACH5+nWrEm
        wSuLJyVJuTpd9sBxg2lNss9r0EgUDL3428YTNt1iOE8N64TqocZi75BYQtR7BSBBDv87IP
        6A3ucYc8Cwm6EnGmqbye6sawTQJ8DYc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1626108969;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=Xtj0uq/0myKG76i6UCshFGN5FKtbSNJBLWeNEEm5CDI=;
        b=5B9eLyhHO+vIbAPuMzJzAB22YkY7v4aEjUn2B2hK46Mclu+15Esnocf6c7/z0YSWpqPuIH
        hiBGFLy6GTEH/JCw==
Received: from quack2.suse.cz (unknown [10.100.224.230])
        by relay2.suse.de (Postfix) with ESMTP id D6C50A3B85;
        Mon, 12 Jul 2021 16:56:09 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id B39BB1F2C73; Mon, 12 Jul 2021 18:56:09 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     <linux-fsdevel@vger.kernel.org>
Cc:     <linux-ext4@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>, Ted Tso <tytso@mit.edu>,
        Dave Chinner <david@fromorbit.com>,
        Matthew Wilcox <willy@infradead.org>, <linux-mm@kvack.org>,
        <linux-xfs@vger.kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net, linux-cifs@vger.kernel.org,
        ceph-devel@vger.kernel.org, Jan Kara <jack@suse.cz>
Subject: [PATCH 0/14 v9] fs: Hole punch vs page cache filling races
Date:   Mon, 12 Jul 2021 18:55:51 +0200
Message-Id: <20210712163901.29514-1-jack@suse.cz>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5196; h=from:subject:message-id; bh=XiQmf05nBMDvngHxQWByxd1f92aY+kMKTDoJHofitYs=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBg7HQTZMMdC5sufdgGKIffBj9wwKgqdITv590HLevy Z7sIsGmJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCYOx0EwAKCRCcnaoHP2RA2aMTB/ 0YTOgw9rZ2dhbmzLjJSc3gKbebvfbU4BCC8HS49Oq6gau26jy4GOmldKR1QLjxYomEwmOSt/EYaDBK uAq/t3ZD4sNEeDSGYAj3dFIWPNtJFLkZ/X091EDAH3DTYOWxDbRSuxtdXOQQ8PSvW1aLbLb5bhCvKr 3o4gkK+g5pCZLQ3a9+DPQ0iNXTJx5bMZT390m6HWyhHGqdoSHS30+vws5GZ8eeGPa4TaveOO0F9/tr h5Dc3/AlGTVWvmF7qUWqh9NKEFnXVCALnQVHVkGLNaAxdPdrtgS4dpt6gZq33krhLnlp/Jvyap4I9R W65IC1Z2kJ/oS+DkSpZ1co4C46fEfQ
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

here is another version of my patches to address races between hole punching
and page cache filling functions for ext4 and other filesystems. The only
significant change since last time is the change in patch 3/14 requested by
Linus that we don't acquire invalidate_lock when the page is already in the
page cache and uptodate. Darrick, Christoph, can you please review that change?

Out of all filesystem supporting hole punching, only GFS2 and OCFS2 remain
unresolved. GFS2 people are working on their own solution (cluster locking is
involved), OCFS2 has even bigger issues (maintainers informed, looking into
it).

Once this series lands, I'd like to actually make sure all calls to
truncate_inode_pages() happen under mapping->invalidate_lock, add the assert
and then we can also get rid of i_size checks in some places (truncate can
use the same serialization scheme as hole punch). But that step is mostly
a cleanup so I'd like to get these functional fixes in first.

The series can be also pulled from:
git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git hole_punch_fixes

Changes since v8:
* Rebased on top of 5.14-rc1
* Fixed up conflict in f2fs
* Modified filemap_fault() to acquire invalidate lock only when creating page
  in the page cache or loading it from the disk
* Added some reviewed-by's

Changes since v7:
* Rebased on top of 5.13-rc6
* Added some reviewed-by tags
* Simplified xfs_isilocked() changes as Dave Chinner suggested
* Minor documentation formulation improvements

Changes since v6:
* Added some reviewed-by tags
* Added wrapper for taking invalidate_lock similar to inode_lock
* Renamed wrappers for taking invalidate_lock for two inodes
* Added xfs patch to make xfs_isilocked() work better even without lockdep
* Some minor documentation fixes

Changes since v5:
* Added some reviewed-by tags
* Added functions for locking two mappings and using them from XFS where needed
* Some minor code style & comment fixes

Changes since v4:
* Rebased onto 5.13-rc1
* Removed shmfs conversion patches
* Fixed up zonefs changelog
* Fixed up XFS comments
* Added patch fixing up definition of file_operations in Documentation/vfs/
* Updated documentation and comments to explain invalidate_lock is used also
  to prevent changes through memory mappings to existing pages for some VFS
  operations.

Changes since v3:
* Renamed and moved lock to struct address_space
* Added conversions of tmpfs, ceph, cifs, fuse, f2fs
* Fixed error handling path in filemap_read()
* Removed .page_mkwrite() cleanup from the series for now

Changes since v2:
* Added documentation and comments regarding lock ordering and how the lock is
  supposed to be used
* Added conversions of ext2, xfs, zonefs
* Added patch removing i_mapping_sem protection from .page_mkwrite handlers

Changes since v1:
* Moved to using inode->i_mapping_sem instead of aops handler to acquire
  appropriate lock

---
Motivation:

Amir has reported [1] a that ext4 has a potential issues when reads can race
with hole punching possibly exposing stale data from freed blocks or even
corrupting filesystem when stale mapping data gets used for writeout. The
problem is that during hole punching, new page cache pages can get instantiated
and block mapping from the looked up in a punched range after
truncate_inode_pages() has run but before the filesystem removes blocks from
the file. In principle any filesystem implementing hole punching thus needs to
implement a mechanism to block instantiating page cache pages during hole
punching to avoid this race. This is further complicated by the fact that there
are multiple places that can instantiate pages in page cache.  We can have
regular read(2) or page fault doing this but fadvise(2) or madvise(2) can also
result in reading in page cache pages through force_page_cache_readahead().

There are couple of ways how to fix this. First way (currently implemented by
XFS) is to protect read(2) and *advise(2) calls with i_rwsem so that they are
serialized with hole punching. This is easy to do but as a result all reads
would then be serialized with writes and thus mixed read-write workloads suffer
heavily on ext4. Thus this series introduces inode->i_mapping_sem and uses it
when creating new pages in the page cache and looking up their corresponding
block mapping. We also replace EXT4_I(inode)->i_mmap_sem with this new rwsem
which provides necessary serialization with hole punching for ext4.

								Honza

[1] https://lore.kernel.org/linux-fsdevel/CAOQ4uxjQNmxqmtA_VbYW0Su9rKRk2zobJmahcyeaEVOFKVQ5dw@mail.gmail.com/

Previous versions:
Link: https://lore.kernel.org/linux-fsdevel/20210208163918.7871-1-jack@suse.cz/
Link: https://lore.kernel.org/r/20210413105205.3093-1-jack@suse.cz
Link: https://lore.kernel.org/r/20210423171010.12-1-jack@suse.cz
Link: https://lore.kernel.org/r/20210512101639.22278-1-jack@suse.cz
Link: https://lore.kernel.org/r/20210525125652.20457-1-jack@suse.cz
Link: https://lore.kernel.org/r/20210607144631.8717-1-jack@suse.cz
Link: http://lore.kernel.org/r/20210615090844.6045-1-jack@suse.cz # v8
