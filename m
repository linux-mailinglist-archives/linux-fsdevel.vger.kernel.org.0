Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1263290948
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Oct 2020 18:05:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410564AbgJPQFG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Oct 2020 12:05:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2410556AbgJPQEs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Oct 2020 12:04:48 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89F17C0613D3;
        Fri, 16 Oct 2020 09:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=1gAdnouxzpGmlXDQWytpWvnXaVVvGdMiUWIOHN43YgI=; b=PHsOXRefPXYbuJLyhWUENQjtiv
        PvaSV2vCC8WINCdV5AEp+CWhJHRK1p+aNonulN42m466RQIlXw3IHvb/RmNXaOhRzldy1UxbTuDqY
        NcaDewCnsmzuXcHVpziXWnYI9ue3WklexPhlQxnJI0qP9K+wrBh2T/E3jt7iyKhERHWrykln9HYHU
        AcuhU7UL2O5ncbuQK7iGexv0LcVyc1NEntKTSG4YYsK1VFL9hLXL98h0ZxzQvFe/4kZJfHEsSaX7C
        dIWtul+Pv9CexE12o1k6i9W7t8kyhYtguoGau7Kf/zgMdTW5lDReKoy2VvafZqPjD58NOmUCeSSsV
        Ecb8d3sw==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kTSDk-0004s5-Ui; Fri, 16 Oct 2020 16:04:44 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, David Howells <dhowells@redhat.com>,
        Steve French <sfrench@samba.org>, linux-cifs@vger.kernel.org,
        Nicolas Pitre <nico@fluxnic.net>,
        Tyler Hicks <code@tyhicks.com>, ecryptfs@vger.kernel.org,
        "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
        Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v3 00/18] Allow readpage to return a locked page
Date:   Fri, 16 Oct 2020 17:04:25 +0100
Message-Id: <20201016160443.18685-1-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I've dropped the conversion of readpage implementations to synchronous
from this patchset.  I realised I'd neglected the requirement for making
the sleep killable, and that turns out to be more convoluted to fix.

So these patches add:
 - An error-path bugfix for cachefiles.
 - The ability for the filesystem to tell the caller of ->readpage
   that the read was successful and the page was not unlocked.  This is
   a performance improvement for some scenarios that I think are rare.
 - Mildly improved error handling for ext4.

v2: https://lore.kernel.org/linux-fsdevel/20201009143104.22673-1-willy@infradead.org/
v1: https://lore.kernel.org/linux-fsdevel/20200917151050.5363-1-willy@infradead.org/
Matthew Wilcox (Oracle) (18):
  cachefiles: Handle readpage error correctly
  swap: Call aops->readahead if appropriate
  fs: Add AOP_UPDATED_PAGE return value
  mm/filemap: Inline wait_on_page_read into its one caller
  9p: Tell the VFS that readpage was synchronous
  afs: Tell the VFS that readpage was synchronous
  ceph: Tell the VFS that readpage was synchronous
  cifs: Tell the VFS that readpage was synchronous
  cramfs: Tell the VFS that readpage was synchronous
  ecryptfs: Tell the VFS that readpage was synchronous
  ext4: Tell the VFS that readpage was synchronous
  ext4: Return error from ext4_readpage
  fuse: Tell the VFS that readpage was synchronous
  hostfs: Tell the VFS that readpage was synchronous
  jffs2: Tell the VFS that readpage was synchronous
  ubifs: Tell the VFS that readpage was synchronous
  udf: Tell the VFS that readpage was synchronous
  vboxsf: Tell the VFS that readpage was synchronous

 Documentation/filesystems/locking.rst |  7 +++---
 Documentation/filesystems/vfs.rst     | 21 +++++++++++------
 fs/9p/vfs_addr.c                      |  6 ++++-
 fs/afs/file.c                         |  3 ++-
 fs/buffer.c                           | 15 +++++++-----
 fs/cachefiles/rdwr.c                  |  9 ++++++++
 fs/ceph/addr.c                        |  9 ++++----
 fs/cifs/file.c                        |  8 +++++--
 fs/cramfs/inode.c                     |  5 ++--
 fs/ecryptfs/mmap.c                    | 11 +++++----
 fs/ext4/inline.c                      |  9 +++++---
 fs/ext4/readpage.c                    | 24 +++++++++++--------
 fs/fuse/file.c                        |  2 ++
 fs/hostfs/hostfs_kern.c               |  2 ++
 fs/jffs2/file.c                       |  6 +++--
 fs/ubifs/file.c                       | 16 ++++++++-----
 fs/udf/file.c                         |  3 +--
 fs/vboxsf/file.c                      |  2 ++
 include/linux/fs.h                    |  5 ++++
 mm/filemap.c                          | 33 +++++++++++++--------------
 mm/page_io.c                          | 27 ++++++++++++++++++++--
 mm/readahead.c                        |  3 ++-
 22 files changed, 151 insertions(+), 75 deletions(-)

-- 
2.28.0

