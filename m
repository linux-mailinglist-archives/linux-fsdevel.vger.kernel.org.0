Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66C423BE774
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jul 2021 13:55:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231358AbhGGL6Q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Jul 2021 07:58:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:30834 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231406AbhGGL6P (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Jul 2021 07:58:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625658935;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=+vPJmQDAbN01lKc36CC7ISIDmAfdSSFNZpFczSJaZAg=;
        b=RNJiMaBn9RQPUV/snzNR2E9o1V+o0SaNUMtoRxtv4MkZlYyShTbMuYwC0OCOO7Map/MSCj
        Jy7zFDaJ3ufkuCKvJgBkERDDk+3y62dqOMdt9p7StxuoV7xz2h2Pgbal8rPOHocwqfZDkg
        K8nKVpRTEnA5ysPfz32/uxKpaz+3KN0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-432-qDUlegIbPQ-cJoiyDfEIsw-1; Wed, 07 Jul 2021 07:55:33 -0400
X-MC-Unique: qDUlegIbPQ-cJoiyDfEIsw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EE230939;
        Wed,  7 Jul 2021 11:55:31 +0000 (UTC)
Received: from max.com (unknown [10.40.192.108])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 964FF5D741;
        Wed,  7 Jul 2021 11:55:26 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     "Darrick J . Wong" <djwong@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        cluster-devel@redhat.com, Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH v3 0/3] iomap: small block problems
Date:   Wed,  7 Jul 2021 13:55:21 +0200
Message-Id: <20210707115524.2242151-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Here's another update of this patch queue.  Changes from v2:

* Reverse the order of the first two patches to make the queue bisect
  clean.  Adjust the patch descriptions accordingly.

* With the second patch, iomap_readpage_actor currently still creates
  iops.  Christoph has indicated that this should now be unnecessary
  as well, but testing has proven that we're not quite at that point,
  yet.

* Don't create iomap_page objects in iomap_page_mkwrite_actor anymore;
  this clearly has become obsolete with the first patch.

Thanks,
Andreas

Andreas Gruenbacher (3):
  iomap: Permit pages without an iop to enter writeback
  iomap: Don't create iomap_page objects for inline files
  iomap: Don't create iomap_page objects in iomap_page_mkwrite_actor

 fs/iomap/buffered-io.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

-- 
2.26.3

