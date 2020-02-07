Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03040155785
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2020 13:18:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbgBGMSe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Feb 2020 07:18:34 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:50259 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726674AbgBGMSd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Feb 2020 07:18:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581077912;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=pxrUa6yYHA3zJIHAlCPUQ/AE6W3gc0p6oLCPdoOC3gQ=;
        b=MOhpjdsmrtv6VD8rf5PyOpGrBfGMIX84c7loAVNZRWEyUp/1lIJePyY0GNr7FshaPJXLTm
        nDmu184VwjhgEALnXEKFhc1XWkkFUgIhdp3OWxkEfh1LF3GvzQy5BJ4YLP/ldYFTETZOBo
        YfEe2fJD48zk1nqSFaScNdg83R/ih40=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-374-P4izfVLVNRmSKF8mjDbykQ-1; Fri, 07 Feb 2020 07:18:31 -0500
X-MC-Unique: P4izfVLVNRmSKF8mjDbykQ-1
Received: by mail-wr1-f72.google.com with SMTP id w17so1172167wrr.9
        for <linux-fsdevel@vger.kernel.org>; Fri, 07 Feb 2020 04:18:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pxrUa6yYHA3zJIHAlCPUQ/AE6W3gc0p6oLCPdoOC3gQ=;
        b=ZY3702+Fpz2vwAdeoQh5S4QxgonZ56ZZ7V4RyZ2L/s3/XHradD0drmrJSzEtBsPqHD
         6dhLuX58b6+SCxgC/gqPCyXx9sdNp30+kZSR2JCF2a4MWmCJvYjoDwBcp9B2A0wUqgcb
         X1YklgWid8da6sdkUOxzyQ74NEexmUlXvKYybBRgeq3pyqqQaKSx/NTaWnmtnG4sugvN
         IsjbsA/AVKx2c7KiBTw75EJsdZnl8tDwsel/nj5vCPzI1jsxzzhKiRvIEs1jUh02M/PE
         v+gNhlI9ulIiuxYMKbsYHVpLfPLnIH42+IDoQ0AzFFw4F4YRNUitIImqVg3n0nt4pE3m
         fgrA==
X-Gm-Message-State: APjAAAXvMppWsSU2BsclTsPcTpVU751zK8r5iWcoBvtAi9CrzzWUFf4E
        BsA/9mORy5GE7LnLWCujb3qT/oF+Ok35FhxNZmXKE+QH49YLxeNe+LuKFski13xNzOCWGDM2cZs
        TnVL1rAbtEnY5ahfoyV6uQftAiQ==
X-Received: by 2002:a1c:a796:: with SMTP id q144mr4298679wme.6.1581077910044;
        Fri, 07 Feb 2020 04:18:30 -0800 (PST)
X-Google-Smtp-Source: APXvYqzKEXxdDxWJyfAf+c8pu5kIy5L1/FnZRZqZlI9Kr7rf2JhF89b17yHm9fzoIeVW9ACTo+FORQ==
X-Received: by 2002:a1c:a796:: with SMTP id q144mr4298656wme.6.1581077909819;
        Fri, 07 Feb 2020 04:18:29 -0800 (PST)
Received: from steredhat.redhat.com (host209-4-dynamic.27-79-r.retail.telecomitalia.it. [79.27.4.209])
        by smtp.gmail.com with ESMTPSA id 4sm3103789wmg.22.2020.02.07.04.18.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2020 04:18:29 -0800 (PST)
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        io-uring@vger.kernel.org
Subject: [PATCH] io_uring: flush overflowed CQ events in the io_uring_poll()
Date:   Fri,  7 Feb 2020 13:18:28 +0100
Message-Id: <20200207121828.105456-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In io_uring_poll() we must flush overflowed CQ events before to
check if there are CQ events available, to avoid missing events.

We call the io_cqring_events() that checks and flushes any overflow
and returns the number of CQ events available.

We can avoid taking the 'uring_lock' since the flush is already
protected by 'completion_lock'.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 fs/io_uring.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 77f22c3da30f..02e77e86abaf 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -6301,7 +6301,7 @@ static __poll_t io_uring_poll(struct file *file, poll_table *wait)
 	if (READ_ONCE(ctx->rings->sq.tail) - ctx->cached_sq_head !=
 	    ctx->rings->sq_ring_entries)
 		mask |= EPOLLOUT | EPOLLWRNORM;
-	if (READ_ONCE(ctx->rings->cq.head) != ctx->cached_cq_tail)
+	if (io_cqring_events(ctx, false))
 		mask |= EPOLLIN | EPOLLRDNORM;
 
 	return mask;
-- 
2.24.1

