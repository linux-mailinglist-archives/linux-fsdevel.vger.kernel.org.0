Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6679559B059
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Aug 2022 22:19:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234591AbiHTUTJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 20 Aug 2022 16:19:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235238AbiHTUTD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 20 Aug 2022 16:19:03 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F12A812AF7
        for <linux-fsdevel@vger.kernel.org>; Sat, 20 Aug 2022 13:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=f2B88BtT0BwDCUCOMm6ekzS3U/w1aqQ18CQ1ZZdJD/E=; b=t4V9+RqY7T7nt2AplXZGZuwMf7
        s3qXoMRZHZiKje/YQV1Pfsc32jeoxb/0lO+zLdoFJaiQxul0jyhraOYDIoZDmJAM4/NUj/ucvtv+y
        nuc508sDx7XDqrE2PlAGqzyC2v4L03sey6n0yO+T2fJA2bwDTzslN0G8AcAb4hV+Cv5PJ08T2xbwH
        btzgXGsOTMIqHOGNdqb+QWXU9X0nboW7znR+9sc5xGqTx2NdqIMcRy+w9xJgCB0Ds54QJyKIGiDKN
        2+xjRGY44/nrkUjd42RKHK5rSV+G92uTI12jCDdpmbVm/vaYcb9eO5bcgTL2PWwEtpRfowheUmqzj
        7FatFZyg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1oPUvs-006TBb-7J;
        Sat, 20 Aug 2022 20:19:00 +0000
Date:   Sat, 20 Aug 2022 21:19:00 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     dri-devel@lists.freedesktop.org
Subject: [PATCH 6/8] dma_buf: no need to bother with file_inode()->i_mapping
Message-ID: <YwFBtOjAW6wSddh1@ZenIV>
References: <YwFANLruaQpqmPKv@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YwFANLruaQpqmPKv@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

->f_mapping will do just fine

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 drivers/dma-buf/udmabuf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma-buf/udmabuf.c b/drivers/dma-buf/udmabuf.c
index 38e8767ec371..210473d927d8 100644
--- a/drivers/dma-buf/udmabuf.c
+++ b/drivers/dma-buf/udmabuf.c
@@ -210,7 +210,7 @@ static long udmabuf_create(struct miscdevice *device,
 		memfd = fget(list[i].memfd);
 		if (!memfd)
 			goto err;
-		mapping = file_inode(memfd)->i_mapping;
+		mapping = memfd->f_mapping;
 		if (!shmem_mapping(mapping) && !is_file_hugepages(memfd))
 			goto err;
 		seals = memfd_fcntl(memfd, F_GET_SEALS, 0);
-- 
2.30.2

