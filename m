Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8894C597BD3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Aug 2022 05:00:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242904AbiHRC7Z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Aug 2022 22:59:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242901AbiHRC7Y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Aug 2022 22:59:24 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC76445F69;
        Wed, 17 Aug 2022 19:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ASEUGz7cWLg+rQ8611/fIqPtCeFG8olFVXzJbYSDQzs=; b=Pueurmcq0kfuZIQ+jCxKjdrRP9
        Kg241jyA1XznTr/9t2Dfz1ODc36s+/y73GuvXl7uBs2Akp03PgjoitVPNuYM4v5Km/L/U57VYn9Gq
        UGdcNsCVkNzOQkS+h057cz3jWOXDDQ3DGZdccjj/1rNnH2nxTpBYluxy1QypaA0bC6ddT/6fxC3mD
        1U5JinSOFv0kYDwFbD+yKQq4JJUQPAOfU1p6zMKJ1lMxA2wDtU9F5YNQeKX6r9LXE1g1nUu9HR3SN
        YJPW4od+SXh6w/rIHuh+KAqHyJf790Eq8WXmEL/5GA1AAFR8EAaq7D8tVY/kzJTsGT5BRRDmsTRRr
        5E+rWbzg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1oOVkg-005abP-Ac;
        Thu, 18 Aug 2022 02:59:22 +0000
Date:   Thu, 18 Aug 2022 03:59:22 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] ksmbd: don't open-code %pf
Message-ID: <Yv2rCqD7M8fAhq5v@ZenIV>
References: <Yv2qoNQg48rtymGE@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yv2qoNQg48rtymGE@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/ksmbd/vfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ksmbd/vfs.c b/fs/ksmbd/vfs.c
index 78d01033604c..a0fafba8b5d0 100644
--- a/fs/ksmbd/vfs.c
+++ b/fs/ksmbd/vfs.c
@@ -1743,11 +1743,11 @@ int ksmbd_vfs_copy_file_ranges(struct ksmbd_work *work,
 	*total_size_written = 0;
 
 	if (!(src_fp->daccess & (FILE_READ_DATA_LE | FILE_EXECUTE_LE))) {
-		pr_err("no right to read(%pd)\n", src_fp->filp->f_path.dentry);
+		pr_err("no right to read(%pf)\n", src_fp->filp);
 		return -EACCES;
 	}
 	if (!(dst_fp->daccess & (FILE_WRITE_DATA_LE | FILE_APPEND_DATA_LE))) {
-		pr_err("no right to write(%pd)\n", dst_fp->filp->f_path.dentry);
+		pr_err("no right to write(%pf)\n", dst_fp->filp);
 		return -EACCES;
 	}
 
-- 
2.30.2

