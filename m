Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B349375A5D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 May 2021 20:43:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236528AbhEFSop (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 May 2021 14:44:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:30649 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236548AbhEFSo0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 May 2021 14:44:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620326607;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ACdZqYT3a7dk3ajOhXH45FYCMcy7i2DJuah9s4rEVpM=;
        b=bX5q6BRmHdu+zfVqhE0zAHXWNf0ePw01DKexI0EdPZLqVQmRQI3vI5Tcf+zxHaj+Er1lp1
        J93Uvgjyf+vItve3Q3Mb4jmxpG89ujoWPg0xX3HOeWDotM1Da0gpUVJcbGd4ltZ7I98v30
        V0/tHIJ4lsNtfDaTPY7zlgTn5U/cnyA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-162-ib2gnDbFOmOTqqJz76Q1vg-1; Thu, 06 May 2021 14:43:25 -0400
X-MC-Unique: ib2gnDbFOmOTqqJz76Q1vg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EDFDF8030CF;
        Thu,  6 May 2021 18:43:24 +0000 (UTC)
Received: from horse.redhat.com (ovpn-114-166.rdu2.redhat.com [10.10.114.166])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CC6E25D72F;
        Thu,  6 May 2021 18:43:19 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 4E853225FCE; Thu,  6 May 2021 14:43:19 -0400 (EDT)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, virtio-fs@redhat.com,
        miklos@szeredi.hu
Cc:     vgoyal@redhat.com, dgilbert@redhat.com,
        linux-kernel@vger.kernel.org, dan.carpenter@oracle.com
Subject: [PATCH 2/2] virtiofs, dax: Fixed smatch warning about ret being uninitialized
Date:   Thu,  6 May 2021 14:43:04 -0400
Message-Id: <20210506184304.321645-3-vgoyal@redhat.com>
In-Reply-To: <20210506184304.321645-1-vgoyal@redhat.com>
References: <20210506184304.321645-1-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Dan reported a smatch warning about "ret" being uninitialized. Fix it.

fs/fuse/dax.c:197 dmap_removemapping_list() error: uninitialized symbol 'ret'.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 fs/fuse/dax.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/fuse/dax.c b/fs/fuse/dax.c
index f06fdad3f7b1..1608b6606ef0 100644
--- a/fs/fuse/dax.c
+++ b/fs/fuse/dax.c
@@ -253,7 +253,10 @@ static int dmap_removemapping_list(struct inode *inode, unsigned int num,
 	struct fuse_removemapping_one *remove_one, *ptr;
 	struct fuse_removemapping_in inarg;
 	struct fuse_dax_mapping *dmap;
-	int ret, i = 0, nr_alloc;
+	int ret = 0, i = 0, nr_alloc;
+
+	if (!num)
+		return ret;
 
 	nr_alloc = min_t(unsigned int, num, FUSE_REMOVEMAPPING_MAX_ENTRY);
 	remove_one = kmalloc_array(nr_alloc, sizeof(*remove_one), GFP_NOFS);
-- 
2.25.4

