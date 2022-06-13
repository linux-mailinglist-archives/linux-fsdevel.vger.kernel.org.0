Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA81154985A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jun 2022 18:36:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380118AbiFMN5g (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Jun 2022 09:57:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380287AbiFMNyB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Jun 2022 09:54:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03A4D42A21;
        Mon, 13 Jun 2022 04:34:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 91BBF612D0;
        Mon, 13 Jun 2022 11:34:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DE7FC34114;
        Mon, 13 Jun 2022 11:34:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1655120065;
        bh=ZjDVsKHFBSnws36ePAnZg275uQcp5H4PcRvFzlD2OCY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GdOw7yAMTFxOtA1uIG2rgNiapakQfWnLMWiyHKauhP60cOEWFLhhU6YCfuehZ7/3F
         SEMXPUP2zht6b6B9NZ5JUOBkLujbvj8izhd3/QNwn8xvHfP6o+PN9XsSrQZDUAe3tu
         G+4cVlx+UfapznwBQ8Vo+Zp5V5G4MeRrM+yCMJTE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
        David Howells <dhowells@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Mike Marshall <hubcap@omnibond.com>,
        Gao Xiang <xiang@kernel.org>, linux-afs@lists.infradead.org,
        v9fs-developer@lists.sourceforge.net, devel@lists.orangefs.org,
        linux-erofs@lists.ozlabs.org, linux-cachefs@redhat.com,
        linux-fsdevel@vger.kernel.org, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.18 222/339] iov_iter: Fix iter_xarray_get_pages{,_alloc}()
Date:   Mon, 13 Jun 2022 12:10:47 +0200
Message-Id: <20220613094933.390057932@linuxfoundation.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220613094926.497929857@linuxfoundation.org>
References: <20220613094926.497929857@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: David Howells <dhowells@redhat.com>

[ Upstream commit 6c77676645ad42993e0a8bdb8dafa517851a352a ]

The maths at the end of iter_xarray_get_pages() to calculate the actual
size doesn't work under some circumstances, such as when it's been asked to
extract a partial single page.  Various terms of the equation cancel out
and you end up with actual == offset.  The same issue exists in
iter_xarray_get_pages_alloc().

Fix these to just use min() to select the lesser amount from between the
amount of page content transcribed into the buffer, minus the offset, and
the size limit specified.

This doesn't appear to have caused a problem yet upstream because network
filesystems aren't getting the pages from an xarray iterator, but rather
passing it directly to the socket, which just iterates over it.  Cachefiles
*does* do DIO from one to/from ext4/xfs/btrfs/etc. but it always asks for
whole pages to be written or read.

Fixes: 7ff5062079ef ("iov_iter: Add ITER_XARRAY")
Reported-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Alexander Viro <viro@zeniv.linux.org.uk>
cc: Dominique Martinet <asmadeus@codewreck.org>
cc: Mike Marshall <hubcap@omnibond.com>
cc: Gao Xiang <xiang@kernel.org>
cc: linux-afs@lists.infradead.org
cc: v9fs-developer@lists.sourceforge.net
cc: devel@lists.orangefs.org
cc: linux-erofs@lists.ozlabs.org
cc: linux-cachefs@redhat.com
cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 lib/iov_iter.c | 20 ++++----------------
 1 file changed, 4 insertions(+), 16 deletions(-)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 6dd5330f7a99..dda6d5f481c1 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -1434,7 +1434,7 @@ static ssize_t iter_xarray_get_pages(struct iov_iter *i,
 {
 	unsigned nr, offset;
 	pgoff_t index, count;
-	size_t size = maxsize, actual;
+	size_t size = maxsize;
 	loff_t pos;
 
 	if (!size || !maxpages)
@@ -1461,13 +1461,7 @@ static ssize_t iter_xarray_get_pages(struct iov_iter *i,
 	if (nr == 0)
 		return 0;
 
-	actual = PAGE_SIZE * nr;
-	actual -= offset;
-	if (nr == count && size > 0) {
-		unsigned last_offset = (nr > 1) ? 0 : offset;
-		actual -= PAGE_SIZE - (last_offset + size);
-	}
-	return actual;
+	return min(nr * PAGE_SIZE - offset, maxsize);
 }
 
 /* must be done on non-empty ITER_IOVEC one */
@@ -1602,7 +1596,7 @@ static ssize_t iter_xarray_get_pages_alloc(struct iov_iter *i,
 	struct page **p;
 	unsigned nr, offset;
 	pgoff_t index, count;
-	size_t size = maxsize, actual;
+	size_t size = maxsize;
 	loff_t pos;
 
 	if (!size)
@@ -1631,13 +1625,7 @@ static ssize_t iter_xarray_get_pages_alloc(struct iov_iter *i,
 	if (nr == 0)
 		return 0;
 
-	actual = PAGE_SIZE * nr;
-	actual -= offset;
-	if (nr == count && size > 0) {
-		unsigned last_offset = (nr > 1) ? 0 : offset;
-		actual -= PAGE_SIZE - (last_offset + size);
-	}
-	return actual;
+	return min(nr * PAGE_SIZE - offset, maxsize);
 }
 
 ssize_t iov_iter_get_pages_alloc(struct iov_iter *i,
-- 
2.35.1



