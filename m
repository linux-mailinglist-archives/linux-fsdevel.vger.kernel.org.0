Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDA3B788FA4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Aug 2023 22:14:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230508AbjHYUNS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Aug 2023 16:13:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230311AbjHYUNB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Aug 2023 16:13:01 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 631E2268A;
        Fri, 25 Aug 2023 13:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=F1WbLqbj42rFKdEfNHbvyp//mIEsUiihUVG1zG6jIzA=; b=psJ91V+gEIAI8q58w+arOFw/9X
        2iJBN7dUWDw9a9jp/ybHV81BjxPitQgfyMYlVFq1QavFs6ZDw8MsEydVhPne/fUEHePmrArx5TuLG
        dkukVniPCyf6k+Rh0BMhWMMpkG4xIbbonZ4Gi0MPE6zxPVlZhjEXvv8n4FPTMSPFGsFyCo00Trne6
        ASHSVL0JVCHd7QFzBLhVI+i2WG3uqVesQUeaMo2rYJp3MFE7p579OW5PiDlfIAV6Op0BYbzyrgIOp
        jlJoQ3czrzOAbMNnAWObD4QfrtbqSPA8ItTOfGW09U/V7AiCLJJaskYjRBXoklxTBvGkJWFi2IvHG
        SioK4tqA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qZdAU-001SZc-VB; Fri, 25 Aug 2023 20:12:30 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Xiubo Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Jeff Layton <jlayton@kernel.org>, ceph-devel@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 00/15] Many folio conversions for ceph
Date:   Fri, 25 Aug 2023 21:12:10 +0100
Message-Id: <20230825201225.348148-1-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I know David is working to make ceph large-folio-aware from the bottom up.
Here's my attempt at making the top (ie the part of ceph that interacts
with the page cache) folio-aware.  Mostly this is just phasing out use
of struct page in favour of struct folio and using the new APIs.

The fscrypt interaction still needs a bit of work, but it should be a
little easier now.  There's still some weirdness in how ceph interacts
with the page cache; for example it holds folios locked while doing
writeback instead of dropping the folio lock after setting the writeback
flag.  I'm not sure why it does that, but I don't want to try fixing that
as part of this series.

I don't have a ceph setup, so these patches are only compile tested.
I really want to be rid of some compat code, and cecph is sometimes the
last user (or really close to being the last user).

Matthew Wilcox (Oracle) (15):
  ceph: Convert ceph_writepages_start() to use folios a little more
  ceph: Convert ceph_page_mkwrite() to use a folio
  mm: Delete page_mkwrite_check_truncate()
  ceph: Add a migrate_folio method
  ceph: Remove ceph_writepage()
  ceph: Convert ceph_find_incompatible() to take a folio
  ceph: Convert writepage_nounlock() to take a folio
  ceph: Convert writepages_finish() to use a folio
  ceph: Use a folio in ceph_filemap_fault()
  ceph: Convert ceph_read_iter() to use a folio to read inline data
  ceph: Convert __ceph_do_getattr() to take a folio
  ceph: Convert ceph_fill_inode() to take a folio
  ceph: Convert ceph_fill_inline_data() to take a folio
  ceph: Convert ceph_set_page_fscache() to ceph_folio_start_fscache()
  netfs: Remove unused functions

 .../filesystems/caching/netfs-api.rst         |  30 +-
 fs/ceph/addr.c                                | 351 ++++++++----------
 fs/ceph/file.c                                |  20 +-
 fs/ceph/inode.c                               |  14 +-
 fs/ceph/mds_client.h                          |   2 +-
 fs/ceph/super.h                               |   8 +-
 include/linux/netfs.h                         |  15 -
 include/linux/pagemap.h                       |  28 --
 8 files changed, 197 insertions(+), 271 deletions(-)

-- 
2.40.1

