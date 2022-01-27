Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0FA649E6DE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jan 2022 17:02:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243352AbiA0QCi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Jan 2022 11:02:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:35064 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243361AbiA0QCh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Jan 2022 11:02:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643299356;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=7FQTIiP8uSrPA9XLCevbyqcBlL979Xzr6Ul1VbrIeY0=;
        b=L6kpnRkh4ktHRvbqOuYy4DoO9vPDuHPrPqDlyUCUywmALAeD2UtK+9w0LRfFgNKHaQMoYl
        QHV9038oUpsm1GulfFsiIUGWk2a/tY4WUHF0y9G+65ii6Z49O446rfAC55Onq1IE2a6haf
        HiAfOqal96xRJroe9UBdmte2RGlp44Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-635-mChErr9KNs2aQ2tmLAhjmw-1; Thu, 27 Jan 2022 11:02:30 -0500
X-MC-Unique: mChErr9KNs2aQ2tmLAhjmw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C97951091DA4;
        Thu, 27 Jan 2022 16:02:28 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.26])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 99021838C4;
        Thu, 27 Jan 2022 16:01:42 +0000 (UTC)
Subject: [PATCH 0/4] cifs: Use fscache I/O again after the rewrite disabled it
From:   David Howells <dhowells@redhat.com>
To:     Steve French <smfrench@gmail.com>
Cc:     Shyam Prasad N <nspmangalore@gmail.com>,
        linux-cifs@vger.kernel.org, linux-cachefs@redhat.com,
        Jeff Layton <jlayton@kernel.org>,
        Matthew Wilcox <willy@infradead.org>, dhowells@redhat.com,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Jeff Layton <jlayton@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-cifs@vger.kernel.org, linux-cachefs@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 27 Jan 2022 16:01:41 +0000
Message-ID: <164329930161.843658.7387773437540491743.stgit@warthog.procyon.org.uk>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Hi Steve,

Here are some patches to make cifs actually do I/O to the cache after it
got disabled in the fscache rewrite[1] plus a warning fix that you might
want to detach and take separately:

 (1) Fix a kernel doc warning.

 (2) Change cifs from using ->readpages() to using ->readahead().

 (3) Provide a netfs cache op to query for the presence of data in the
     cache.[*]

 (4) Make ->readahead() call

The patches can be found here also:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=fscache-rewrite

David

[*] Ideally, we would use the netfslib read helpers, but it's probably better
    to roll iterators down into cifs's I/O layer before doing that[2].

Link: https://lore.kernel.org/r/164021479106.640689.17404516570194656552.stgit@warthog.procyon.org.uk/ [1]
Link: https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=cifs-experimental [2]

---
David Howells (4):
      Fix a warning about a malformed kernel doc comment in cifs by removing the
      cifs: Transition from ->readpages() to ->readahead()
      netfs, cachefiles: Add a method to query presence of data in the cache
      cifs: Implement cache I/O by accessing the cache directly


 Documentation/filesystems/netfs_library.rst |  16 ++
 fs/cachefiles/io.c                          |  59 ++++++
 fs/cifs/connect.c                           |   2 +-
 fs/cifs/file.c                              | 221 ++++++++------------
 fs/cifs/fscache.c                           | 126 +++++++++--
 fs/cifs/fscache.h                           |  79 ++++---
 include/linux/netfs.h                       |   7 +
 7 files changed, 322 insertions(+), 188 deletions(-)


