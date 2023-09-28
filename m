Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97CE47B198C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Sep 2023 13:04:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232128AbjI1LEs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Sep 2023 07:04:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232019AbjI1LEa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Sep 2023 07:04:30 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F575CED;
        Thu, 28 Sep 2023 04:04:20 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FC8BC433C7;
        Thu, 28 Sep 2023 11:04:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695899059;
        bh=F/2vXVnF7RSXFfWEZqx0McB1XYKZ9a+y5sHO9ziDwMc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nPqwZD4Cy7y9WGVms+U5m6Hk04N6LpWf5Jpospahi+28gDJ/vF4Gd0fN34gydOKPu
         /q+Ln9ktX9ZRyI8aVL97aQuJJPAkNIeoIRda2z6q7tpjFVHS/C3pGa6G2sNItKsYw9
         e5JdgqsSnD4gtN5iO6fHdAPtuXSiOyW05wBc+SyaSTkp//stXSjoyzPqQHJmcqh6Px
         LfYGtJyXrcA5gw0QJviu/XKptE3BYohx4HgXXOEw74sShXA1Zbro+f+vBh095sOLVu
         /QMe9UOALNRXBMZvO/Qz6PDfTSxOoF5kUEk5VudpxKjloQyX3MepG4cXSUryYYdTgS
         442JKz+LTgtxQ==
From:   Jeff Layton <jlayton@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     platform-driver-x86@vger.kernel.org
Subject: [PATCH 06/87] drivers/char: convert to new inode {a,m}time accessors
Date:   Thu, 28 Sep 2023 07:02:15 -0400
Message-ID: <20230928110413.33032-5-jlayton@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230928110413.33032-1-jlayton@kernel.org>
References: <20230928110300.32891-1-jlayton@kernel.org>
 <20230928110413.33032-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 drivers/char/sonypi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/sonypi.c b/drivers/char/sonypi.c
index 9211531689b2..22d249333f53 100644
--- a/drivers/char/sonypi.c
+++ b/drivers/char/sonypi.c
@@ -920,7 +920,7 @@ static ssize_t sonypi_misc_read(struct file *file, char __user *buf,
 
 	if (ret > 0) {
 		struct inode *inode = file_inode(file);
-		inode->i_atime = current_time(inode);
+		inode_set_atime_to_ts(inode, current_time(inode));
 	}
 
 	return ret;
-- 
2.41.0

