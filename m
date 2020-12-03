Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6C0E2CCCA8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Dec 2020 03:31:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729390AbgLCCbW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Dec 2020 21:31:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40509 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727102AbgLCCbW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Dec 2020 21:31:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606962595;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=+hq4CZba87gfHccYoQYynvzAXiy+JKLLnrQ2htmc5jM=;
        b=Eid0nf+vTuiqK8QZZ6Z6ienTzxs3A0BGyitWSjfT9aYgTZwNaCi9fs9HtokgS8jMB5LlLm
        ba4b9Nkw7WCMYZz0Agphz3n7U5m4zDbjLvkAMPX76F7X6oKvNz6EatsRy/02wJd30woYvr
        CaNWrGBWPv/dJe97D0YyigeprREzksQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-107-S5CTPj-aNwic-kX28sNaiw-1; Wed, 02 Dec 2020 21:29:54 -0500
X-MC-Unique: S5CTPj-aNwic-kX28sNaiw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AC3C3185E48B;
        Thu,  3 Dec 2020 02:29:52 +0000 (UTC)
Received: from localhost (ovpn-12-87.pek2.redhat.com [10.72.12.87])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A4CC15D6BA;
        Thu,  3 Dec 2020 02:29:48 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Pavel Begunkov <asml.silence@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH V2 0/2] block: add bio_iov_iter_nvecs for figuring out nr_vecs
Date:   Thu,  3 Dec 2020 10:29:38 +0800
Message-Id: <20201203022940.616610-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

Add add bio_iov_iter_nvecs for figuring out nr_vecs, so that we can
avoid iov_iter_npages() for bvec iter.

V2:
	- split out renaming part into one patch

Ming Lei (2):
  block: add bio_iov_iter_nvecs for figuring out nr_vecs
  block: rename the local variable for holding return value of
    bio_iov_iter_nvecs

 fs/block_dev.c       | 30 +++++++++++++++---------------
 fs/iomap/direct-io.c | 14 +++++++-------
 include/linux/bio.h  | 10 ++++++++++
 3 files changed, 32 insertions(+), 22 deletions(-)

Cc: Pavel Begunkov <asml.silence@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: linux-fsdevel@vger.kernel.org


-- 
2.28.0

