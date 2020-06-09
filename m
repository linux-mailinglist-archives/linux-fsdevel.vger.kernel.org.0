Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1C961F3AC9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jun 2020 14:41:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728238AbgFIMlI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Jun 2020 08:41:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726848AbgFIMlH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Jun 2020 08:41:07 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53DACC05BD1E
        for <linux-fsdevel@vger.kernel.org>; Tue,  9 Jun 2020 05:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:To:From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=rcWeTmk1KNP9kPmO9fBgdrwUrtPvboGP7WIdfU2onPM=; b=kSR3oYrTfpvxS6rFGEbdWShPga
        OU0o9heherZRCuZ4IHo1bj5Fj14MI49bZEmAl2KWPGR6VEyyD1O9coHiFK0lrTOWbGBHO8RtpS4VB
        Kself4+843YawiBKZTAt0DbUpd0mqHsxN3p4vK3lcMBmljYpzsFNXqiqzjptd4beTlvgwAqcMWxOq
        NkHpMj+a+7dYxISUvXzWjcwYpjNTHNIf5JtULqvfq4crCerOzyRcy9szA1qhKPIK4XrADIK+yi5vl
        9IXTFy0L3UH49wQ75vc8v3YnMHyMn7aqDwKchk2TVYL2RMhILO5w/rsOFiAYtcB07dXe+fGvz+OII
        llrzkFrA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jidYs-0006aM-45
        for linux-fsdevel@vger.kernel.org; Tue, 09 Jun 2020 12:41:02 +0000
Date:   Tue, 9 Jun 2020 05:41:02 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Subject: Disentangling address_space and inode
Message-ID: <20200609124102.GB19604@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I have a modest proposal ...

 struct inode {
-	struct address_space i_data;
 }

+struct minode {
+	struct inode i;
+	struct address_space m;
+};

 struct address_space {
-	struct inode *host;
 }

This saves one pointer per inode, and cuts all the pagecache support
from inodes which don't need to have a page cache (symlinks, directories,
pipes, sockets, char devices).

This was born from the annoyance of going from a struct page to a filesystem:
page->mapping->host->i_sb->s_type

That's four pointer dereferences.  This would bring it down to three:
i_host(page->mapping)->i_sb->s_type

I could see (eventually) interfaces changing to pass around a
struct minode *mapping instead of a struct address_space *mapping.  But
I know mapping->host and inode->i_mapping sometimes have some pretty
weird relationships and maybe there's a legitimate usage that can't be
handled by this change.

Every filesystem which does use the page cache would have to be changed
to use a minode instead of an inode, which is why this proposal is so
very modest.  But before I start looking into it properly, I thought
somebody might know why this isn't going to work.

I know about raw devices:
                file_inode(filp)->i_mapping =
                        bdev->bd_inode->i_mapping;

and this seems like it should work for that.  I know about coda:
                coda_inode->i_mapping = host_inode->i_mapping;

and this seems like it should work there too.

DAX just seems confused:
        inode->i_mapping = __dax_inode->i_mapping;
        inode->i_mapping->host = __dax_inode;
        inode->i_mapping->a_ops = &dev_dax_aops;

GFS2 might need to embed an entire minode instead of just a mapping in its
glocks and its superblock:
fs/gfs2/glock.c:                mapping->host = s->s_bdev->bd_inode;
fs/gfs2/ops_fstype.c:   mapping->host = sb->s_bdev->bd_inode;

NILFS ... I don't understand at all.  It seems to allocate its own
private address space in nilfs_inode_info instead of using i_data (why?)
and also allocate more address spaces for metadata inodes.
fs/nilfs2/page.c:       mapping->host = inode;

So that will need to be understood, but is there a fundamental reason
this won't work?

Advantages:
 - Eliminates a pointer dereference when moving from mapping to host
 - Shrinks all inodes by one pointer
 - Shrinks inodes used for symlinks, directories, sockets, pipes & char
   devices by an entire struct address_space.

Disadvantages:
 - Churn
 - Seems like it'll grow a few data structures in less common filesystems
   (but may be important for some users)
