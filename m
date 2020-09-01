Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C66F259893
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Sep 2020 18:28:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730899AbgIAQ20 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Sep 2020 12:28:26 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:54124 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728469AbgIAQ2X (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Sep 2020 12:28:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598977702;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Q/jxouQHscjmTrAHRVozJy9AEeAW/LaC4zIz56UQCmk=;
        b=FNu+AcIVdcFBRxObdDg0Ld/r5kSsemANWThnZyHaAK7FYTc7rpZJMiValec2LUZ/jHlmDR
        AT2u6qXg5LxUBnR/gYIUaP1xZ7Wm+r06gz6HuBQvsTqj/GgArBhkQCDJIVcRngXx9j5DAV
        tTXlFGPr0I+Vpdjx2CsLoBQvMDUm/7c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-179-t6RQvitsPEClxJ8wnJRupw-1; Tue, 01 Sep 2020 12:28:18 -0400
X-MC-Unique: t6RQvitsPEClxJ8wnJRupw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 35931807333;
        Tue,  1 Sep 2020 16:28:17 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-113-231.rdu2.redhat.com [10.10.113.231])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2F9F77C564;
        Tue,  1 Sep 2020 16:28:16 +0000 (UTC)
Subject: [RFC PATCH 0/7] mm: Make more use of readahead_control
From:   David Howells <dhowells@redhat.com>
To:     willy@infradead.org
Cc:     dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Date:   Tue, 01 Sep 2020 17:28:15 +0100
Message-ID: <159897769535.405783.17587409235571100774.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Hi Willy,

Here's a set of patches to expand the use of the readahead_control struct,
essentially from do_sync_mmap_readahead() down.  Note that I've been
passing the number of pages to read in rac->_nr_pages, and then saving it
and changing it certain points, e.g. page_cache_readahead_unbounded().

Also pass file_ra_state into force_page_cache_readahead().

Also there's an apparent minor bug in khugepaged.c that I've included a
patch for: page_cache_sync_readahead() looks to be given the wrong size in
collapse_file().

David
---
David Howells (7):
      Fix khugepaged's request size in collapse_file()
      mm: Make ondemand_readahead() take a readahead_control struct
      mm: Push readahead_control down into force_page_cache_readahead()
      mm: Pass readahead_control into page_cache_{sync,async}_readahead()
      mm: Make __do_page_cache_readahead() use rac->_nr_pages
      mm: Fold ra_submit() into do_sync_mmap_readahead()
      mm: Pass a file_ra_state struct into force_page_cache_readahead()


 fs/btrfs/free-space-cache.c |  7 +--
 fs/btrfs/ioctl.c            | 10 +++--
 fs/btrfs/relocation.c       | 14 +++---
 fs/btrfs/send.c             | 15 ++++---
 fs/ext4/dir.c               | 12 ++---
 fs/ext4/verity.c            |  8 ++--
 fs/f2fs/dir.c               | 10 +++--
 fs/f2fs/verity.c            |  8 ++--
 include/linux/pagemap.h     | 11 ++---
 mm/fadvise.c                |  6 ++-
 mm/filemap.c                | 33 +++++++-------
 mm/internal.h               | 16 +------
 mm/khugepaged.c             |  6 +--
 mm/readahead.c              | 89 ++++++++++++++++++-------------------
 14 files changed, 127 insertions(+), 118 deletions(-)


