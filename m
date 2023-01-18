Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 827C2672230
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jan 2023 16:55:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbjARPzD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Jan 2023 10:55:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230392AbjARPyM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Jan 2023 10:54:12 -0500
X-Greylist: delayed 887 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 18 Jan 2023 07:51:05 PST
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9665E5411B;
        Wed, 18 Jan 2023 07:51:04 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1674055579;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=7IKaIZufY5EGrmY+2gZX2D6okxDALZBycWye212MQWU=;
        b=KQ2JYehjt8IsHlBydNzu9XsmK6tK6Nv0G7DIYqxD3LikJK1w8OsI4ofRZVpBfF5Ou2H8iP
        I+nkFfGnZvOvk+MDkiGzNrGIMADZY52GfJ227Q1v2/lGahIOiN4I28zMGHS+4noJVeen8S
        chewX+VzQRWgyQzAvdYxwg9fcHO8KQ4=
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     linux-kernel@vger.kernel.org
Cc:     Kent Overstreet <kent.overstreet@linux.dev>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 1/2] fs/aio: Use kmap_local() instead of kmap()
Date:   Wed, 18 Jan 2023 10:26:02 -0500
Message-Id: <20230118152603.28301-1-kent.overstreet@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Originally, we used kmap() instead of kmap_atomic() for reading events
out of the completion ringbuffer because we're using copy_to_user(),
which can fault.

Now that kmap_local() is a thing, use that instead.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Benjamin LaHaise <bcrl@kvack.org
Cc: linux-aio@kvack.org
Cc: linux-fsdevel@vger.kernel.org
---
 fs/aio.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index 5b2ff20ad3..3f795ed2a2 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -1246,10 +1246,10 @@ static long aio_read_events_ring(struct kioctx *ctx,
 		avail = min(avail, nr - ret);
 		avail = min_t(long, avail, AIO_EVENTS_PER_PAGE - pos);
 
-		ev = kmap(page);
+		ev = kmap_local_page(page);
 		copy_ret = copy_to_user(event + ret, ev + pos,
 					sizeof(*ev) * avail);
-		kunmap(page);
+		kunmap_local(ev);
 
 		if (unlikely(copy_ret)) {
 			ret = -EFAULT;
-- 
2.39.0

