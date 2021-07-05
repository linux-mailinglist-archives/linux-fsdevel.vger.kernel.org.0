Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCE323BC281
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Jul 2021 20:18:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbhGESVN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Jul 2021 14:21:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29133 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229725AbhGESVN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Jul 2021 14:21:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625509116;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=O6aeNK5vFpQ3FyqA48YXzAW2Fvve8m6zFcu2OqMh/kk=;
        b=ZqVhuHTib/spiSouFyQbEbyZpQ2KZCyKaRaSBoJA6Lg6NLSNzywlmYH4LicT2JgGABDm2H
        jiT6XEgIdYW1U/O8dwIZM+CvAbjPvWwS/8lIiFfVqzC7HJyCPIvExI/fVyeXO7SmhlTrtS
        SyvQjgJrPf9LmoNHmgeMXvzC2oTF55Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-187-PGrzh3bFM9GS-h9hYCTFrg-1; Mon, 05 Jul 2021 14:18:32 -0400
X-MC-Unique: PGrzh3bFM9GS-h9hYCTFrg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 826811835AC2;
        Mon,  5 Jul 2021 18:18:31 +0000 (UTC)
Received: from max.com (unknown [10.40.193.232])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 686C319D9D;
        Mon,  5 Jul 2021 18:18:26 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     "Darrick J . Wong" <djwong@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        cluster-devel@redhat.com, Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH v2 0/2] iomap: small block problems
Date:   Mon,  5 Jul 2021 20:18:22 +0200
Message-Id: <20210705181824.2174165-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Here are the two fixes that make sure that iop objects get attached to
pages eventually (in iomap_writepage_map if not earlier), but not too
early (before inline inodes are read).  These are the fixes required for
making gfs2 filesystems with a block size smaller than the page size
work again.

As Christoph has pointed out [*], there are several more cases in which
we can avoid iop creation.  Those improvements are still left to be done.

[*] https://lore.kernel.org/linux-fsdevel/YNqy0E4xFwHDhK32@infradead.org/

Thanks,
Andreas

Andreas Gruenbacher (2):
  iomap: Don't create iomap_page objects for inline files
  iomap: Permit pages without an iop to enter writeback

 fs/iomap/buffered-io.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

-- 
2.26.3

