Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B16763570C2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Apr 2021 17:47:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344222AbhDGPrO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Apr 2021 11:47:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55068 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1353749AbhDGPrJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Apr 2021 11:47:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617810419;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=vBa++ylKdM6FaV/AsB3jGOj59UUYHkh6Ww/V2KVEjbY=;
        b=c+fq6CSqdPaXsDLjk9sZKP8XRYj6NBP4Ayk733j7mZRrDMp/hhImxZAo7bIJXbEdBZVrpE
        xbaT4DW+hmX4HiacOHBZ7994CJ3Jq8u5GV0eC68ATGn7DGrMYS6dtFCAjpqPnIEZxGr/Ur
        Ivunkv/6hj0Senn4/KUXNO9YMYSMytM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-291-vJ-WsKDbMdGZLbaNmZzTBw-1; Wed, 07 Apr 2021 11:46:57 -0400
X-MC-Unique: vJ-WsKDbMdGZLbaNmZzTBw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0D7E51008076;
        Wed,  7 Apr 2021 15:46:56 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-115-201.rdu2.redhat.com [10.10.115.201])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 43E9D1893C;
        Wed,  7 Apr 2021 15:46:54 +0000 (UTC)
Subject: [PATCH 0/5] netfs: Fixes for the netfs lib
From:   David Howells <dhowells@redhat.com>
To:     jlayton@kernel.org
Cc:     dwysocha@redhat.com, linux-cachefs@redhat.com,
        v9fs-developer@lists.sourceforge.net,
        linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org,
        ceph-devel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 07 Apr 2021 16:46:53 +0100
Message-ID: <161781041339.463527.18139104281901492882.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Hi Jeff,

Here's a bunch of fixes plus a tracepoint for the netfs library.  I'm going
to roll them into other patches, but I'm posting them here for separate
review.

David
---
David Howells (5):
      netfs: Fix a missing rreq put in netfs_write_begin()
      netfs: Call trace_netfs_read() after ->begin_cache_operation()
      netfs: Don't record the copy termination error
      netfs: Fix copy-to-cache amalgamation
      netfs: Add a tracepoint to log failures that would be otherwise unseen


 fs/cachefiles/io.c           | 17 ++++++++++
 fs/netfs/read_helper.c       | 58 +++++++++++++++++++---------------
 include/linux/netfs.h        |  6 ++++
 include/trace/events/netfs.h | 60 ++++++++++++++++++++++++++++++++++++
 4 files changed, 116 insertions(+), 25 deletions(-)


