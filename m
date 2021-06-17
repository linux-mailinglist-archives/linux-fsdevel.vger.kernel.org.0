Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFCF23AAEAB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jun 2021 10:24:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbhFQI0J (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Jun 2021 04:26:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:37776 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229773AbhFQI0I (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Jun 2021 04:26:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623918240;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Ecr4SaZppkR6LC4jjThumUcPziwAjzPppqw1CbdJdos=;
        b=FocE6FumFRfpxREFNmT+/uhHlBzJzVenfKsfLjyor2PL41EiS/ienWtlz7C3aCnwqvsOrE
        REbutZnTPOXT4f0EHihcLhuzH0VTpKFXW1Gut9A5Kre5yx7HvUKVwOEYYX1kygtSRX5knl
        wPZePoKwlUG1dPTWy7fR764dSi9JV9M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-82-x2ro2a0eNQuCs3530FCC5A-1; Thu, 17 Jun 2021 04:23:59 -0400
X-MC-Unique: x2ro2a0eNQuCs3530FCC5A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AF051100C62B;
        Thu, 17 Jun 2021 08:23:57 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-118-65.rdu2.redhat.com [10.10.118.65])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CD47B5C1C5;
        Thu, 17 Jun 2021 08:23:52 +0000 (UTC)
Subject: [PATCH v2 0/3] netfs, afs: Fix netfs_write_begin and THP handling
From:   David Howells <dhowells@redhat.com>
To:     linux-cachefs@redhat.com, linux-afs@lists.infradead.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        ceph-devel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew W Elble <aweits@rit.edu>, dhowells@redhat.com,
        Jeff Layton <jlayton@kernel.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 17 Jun 2021 09:23:51 +0100
Message-ID: <162391823192.1173366.9740514875196345746.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Here are some patches to fix netfs_write_begin() and the handling of THPs in
that and afs_write_begin/end() in the following ways:

 (1) Use offset_in_thp() rather than manually calculating the offset into
     the page.

 (2) In the future, the len parameter may extend beyond the page allocated.
     This is because the page allocation is deferred to write_begin() and
     that gets to decide what size of THP to allocate.

 (3) In netfs_write_begin(), extract the decision about whether to skip a
     page out to its own helper and have that clear around the region to be
     written, but not clear that region.  This requires the filesystem to
     patch it up afterwards if the hole doesn't get completely filled.

 (4) Due to (3), afs_write_end() now needs to handle short data write into
     the page by generic_perform_write().  I've adopted an analogous
     approach to ceph of just returning 0 in this case and letting the
     caller go round again.

I wonder if generic_perform_write() should pass in a flag indicating
whether this is the first attempt or a second attempt at this, and on the
second attempt we just completely prefill the page and just let the partial
write stand - which we have to do if the page was already uptodate when we
started.

The patches can be found here:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=afs-fixes

David

Link: https://lore.kernel.org/r/20210613233345.113565-1-jlayton@kernel.org/
Link: https://lore.kernel.org/r/162367681795.460125.11729955608839747375.stgit@warthog.procyon.org.uk/

Changes
=======

ver #2:
   - Removed a var that's no longer used (spotted by the kernel test robot)
   - Removed a forgotten "noinline".

ver #1:
   - Prefixed the Jeff's new helper with "netfs_".
   - Don't call zero_user_segments() for a full-page write.
   - Altered the beyond-last-page check to avoid a DIV.
   - Removed redundant zero-length-file check.
   - Added patches to fix afs.

---
David Howells (2):
      afs: Handle len being extending over page end in write_begin/write_end
      afs: Fix afs_write_end() to handle short writes

Jeff Layton (1):
      netfs: fix test for whether we can skip read when writing beyond EOF


 fs/afs/write.c         | 12 +++++++++--
 fs/netfs/read_helper.c | 49 +++++++++++++++++++++++++++++++-----------
 2 files changed, 46 insertions(+), 15 deletions(-)


