Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2356610807
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Oct 2022 04:34:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235879AbiJ1CeP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Oct 2022 22:34:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235291AbiJ1CeO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Oct 2022 22:34:14 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABEB8BCBAE;
        Thu, 27 Oct 2022 19:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=ePAnUqBsHfpEZfy8Hk6sJVchTl2kYrXoUq+WAcUoWDA=; b=ZNZOHoy8NsrV2R7T2RHyOEnnLO
        El93uHcdcPtvooH/1/jUJkhref5Yzh5UUxmkjA8e0CzFFGms4qY80y3yHqrotbI2ObZznWKryK3W8
        lvqZOVHceYpxEm24dCbauiXa0BpHEXDgelJRsw1tbSeowLk+UiH43/8BBPikOcVroWqUkToS6snx3
        gMr3bs/XQ70IzefyXBqOO0ri4+MoK3C8swTqXFe0U/K2UkoGSyxoiAzEpoVNHbw/cnv11KvRnpJZ5
        lmIOUlcr6mxlYpgDkjvFatgSAkzgOjo2/RgTXwm2oULj9LGklOJ6uDFNU1J0XP9JV+pFhGUGurXYh
        mE4k0MdA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1ooFBx-00EorN-1f;
        Fri, 28 Oct 2022 02:33:53 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     David Howells <dhowells@redhat.com>, willy@infradead.org,
        dchinner@redhat.com, Steve French <smfrench@gmail.com>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Rohith Surabattula <rohiths.msft@gmail.com>,
        Jeff Layton <jlayton@kernel.org>,
        Ira Weiny <ira.weiny@intel.com>, torvalds@linux-foundation.org,
        linux-cifs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 08/12] [target] fix iov_iter_bvec() "direction" argument
Date:   Fri, 28 Oct 2022 03:33:48 +0100
Message-Id: <20221028023352.3532080-8-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221028023352.3532080-1-viro@zeniv.linux.org.uk>
References: <Y1btOP0tyPtcYajo@ZenIV>
 <20221028023352.3532080-1-viro@zeniv.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 drivers/target/target_core_file.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/target/target_core_file.c b/drivers/target/target_core_file.c
index 28aa643be5d5..55935040541b 100644
--- a/drivers/target/target_core_file.c
+++ b/drivers/target/target_core_file.c
@@ -337,7 +337,7 @@ static int fd_do_rw(struct se_cmd *cmd, struct file *fd,
 		len += sg->length;
 	}
 
-	iov_iter_bvec(&iter, READ, bvec, sgl_nents, len);
+	iov_iter_bvec(&iter, is_write, bvec, sgl_nents, len);
 	if (is_write)
 		ret = vfs_iter_write(fd, &iter, &pos, 0);
 	else
@@ -473,7 +473,7 @@ fd_execute_write_same(struct se_cmd *cmd)
 		len += se_dev->dev_attrib.block_size;
 	}
 
-	iov_iter_bvec(&iter, READ, bvec, nolb, len);
+	iov_iter_bvec(&iter, WRITE, bvec, nolb, len);
 	ret = vfs_iter_write(fd_dev->fd_file, &iter, &pos, 0);
 
 	kfree(bvec);
-- 
2.30.2

