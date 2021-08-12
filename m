Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE1A33EAD51
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Aug 2021 00:45:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238363AbhHLWpy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Aug 2021 18:45:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236979AbhHLWpx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Aug 2021 18:45:53 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3175AC061756
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Aug 2021 15:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5RoOrc/QeHUmwLj7isOrdmem34xlMg7fy/9RJonqboo=; b=tn0kUdHE5nqI4VUhzR7IBrZn6w
        Pv+lIZ/1IQZe+iGQ/InKWJ25XSq+Jx2bRDTgnCJ+IysbWsPH0IzikCY/kJ/21BvQVqn6n38bD0hQc
        sWFmXEbiWc10iBh8HUzknD7lH59UOKJoMeZpdQjc/BZOATmWlsE5SXZ4+fkc7nRuIq3BE5gw5EQie
        3NoUWU6Tdqv/2c+I4cuNCaWHrV2yaMyCXFcLe2gdtihUt0ydTrpxCcqYbx7U8tMtrVQFAR9cUvRS4
        h4YHHBdo6hXkxXCOWa5IOUiH5+4P0cA11r8EVLmyWLTP6vhVbXEHjw2zmQyJW1IJTmgnlkSfPsywg
        gZJZhXhQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mEJR2-00F43C-Dd; Thu, 12 Aug 2021 22:44:37 +0000
Date:   Thu, 12 Aug 2021 23:44:24 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH] folio: Add a function to get the host inode for a
 folio
Message-ID: <YRWkSGnk6M+6H/Oh@casper.infradead.org>
References: <162880453171.3369675.3704943108660112470.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <162880453171.3369675.3704943108660112470.stgit@warthog.procyon.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 12, 2021 at 10:42:11PM +0100, David Howells wrote:
> Add a convenience function, folio_inode() that will get the host inode from
> a folio's mapping.
> 
> [Includes netfs and afs changes for illustration, but I'd move those to a
> different patch].

Seems like a good idea.  Across my entire devel tree, I find 36
occurrences:

$ git log -p origin..devel |grep folio.*mapping.*host
+	struct inode *inode = folio->mapping->host;
+	struct inode *dir = folio->mapping->host;
+	unsigned int nr_blocks = i_blocks_per_folio(page->mapping->host, folio);
+	struct btrfs_fs_info *fs_info = btrfs_sb(folio->mapping->host->i_sb);
+	struct afs_vnode *dvnode = AFS_FS_I(folio->mapping->host);
+	tree = &BTRFS_I(folio->mapping->host)->io_tree;
+		btrfs_warn(BTRFS_I(folio->mapping->host)->root->fs_info,
+	struct btrfs_inode *inode = BTRFS_I(folio->mapping->host);
+	inode = folio->mapping->host;
+	struct cifsInodeInfo *cifsi = CIFS_I(folio->mapping->host);
+	struct inode *inode = folio->mapping->host;
+	struct gfs2_sbd *sdp = GFS2_SB(folio->mapping->host);
+	trace_iomap_invalidate_folio(folio->mapping->host, offset, len);
+	nfs_wb_page_cancel(folio_file_mapping(folio)->host, &folio->page);
+	nfs_fscache_invalidate_page(&folio->page, folio->mapping->host);
+	struct inode *inode = folio->mapping->host;
+	struct inode *inode = folio->mapping->host;
+	struct inode *inode = folio->mapping->host;
+	struct inode *inode = folio->mapping->host;
+	struct inode *inode = folio->mapping->host;
+	int err = fuse_readlink_page(folio->mapping->host, &folio->page);
+	struct inode *inode = folio->mapping->host;
+	struct btrfs_inode *inode = BTRFS_I(folios[0]->mapping->host);
+	struct inode *inode = folio->mapping->host;
+		__entry->i_ino = folio->mapping->host->i_ino;
+		if (folio->mapping->host->i_sb)
+			__entry->s_dev = folio->mapping->host->i_sb->s_dev;
+			__entry->s_dev = folio->mapping->host->i_rdev;
+	struct inode *inode = folio->mapping->host;
+	struct inode		*inode = folio->mapping->host;
+	struct inode *inode = folio->mapping->host;
+	struct inode *inode = folio->mapping->host;
+	trace_iomap_invalidatepage(folio->mapping->host, offset, len);
+	trace_iomap_releasepage(folio->mapping->host, folio_pos(folio),
+	struct inode *inode = folio->mapping->host;
+	if (folio->mapping->host->i_sb->s_iflags & SB_I_STABLE_WRITES)

It's only two characters less, but it seems worth doing.
