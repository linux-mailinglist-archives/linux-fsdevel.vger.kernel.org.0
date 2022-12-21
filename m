Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 330E8653840
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Dec 2022 22:37:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234895AbiLUVhp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Dec 2022 16:37:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbiLUVho (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Dec 2022 16:37:44 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC93E248C5;
        Wed, 21 Dec 2022 13:37:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 59FA96195F;
        Wed, 21 Dec 2022 21:37:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E94BC433EF;
        Wed, 21 Dec 2022 21:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1671658661;
        bh=QReuBni+pWaqttxf2jlsGOGtV+kSy9z4bLCV6tSxSTY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dwDHq5v/uIeXrts1sPYOEIiTRWmnczLiexVPuijiSGNcRU5izOYqlwi1TDb7rg/rM
         EnWrIaB1VnnQZiI33wI97k/htCPu70JP5+CXCKCSuXlA3MDSHwMTUDhQNaXC0fV7tk
         KCOiHndaNcP6U/hRWk3pmh+WSkpMpdnBS170VpMQ=
Date:   Wed, 21 Dec 2022 13:37:40 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     XU pengfei <xupengfei@nfschina.com>
Cc:     keescook@chromium.org, brauner@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] hfsplus: Remove unnecessary variable initialization
Message-Id: <20221221133740.fec49a9b2be29702d10ddca7@linux-foundation.org>
In-Reply-To: <20221221032119.10037-1-xupengfei@nfschina.com>
References: <20221221032119.10037-1-xupengfei@nfschina.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 21 Dec 2022 11:21:20 +0800 XU pengfei <xupengfei@nfschina.com> wrote:

> Variables are assigned first and then used. Initialization is not required.

Looks good to me.

When making such changes I suggest you also look for opportunities to
narrow the scope of the affected variables.  It makes the code easier
to read and to review.

ie,

--- a/fs/hfsplus/xattr.c~hfsplus-remove-unnecessary-variable-initialization-fix
+++ a/fs/hfsplus/xattr.c
@@ -677,7 +677,6 @@ ssize_t hfsplus_listxattr(struct dentry
 	ssize_t res;
 	struct inode *inode = d_inode(dentry);
 	struct hfs_find_data fd;
-	u16 key_len;
 	struct hfsplus_attr_key attr_key;
 	char *strbuf;
 	int xattr_name_len;
@@ -719,7 +718,8 @@ ssize_t hfsplus_listxattr(struct dentry
 	}
 
 	for (;;) {
-		key_len = hfs_bnode_read_u16(fd.bnode, fd.keyoffset);
+		u16 key_len = hfs_bnode_read_u16(fd.bnode, fd.keyoffset);
+
 		if (key_len == 0 || key_len > fd.tree->max_key_len) {
 			pr_err("invalid xattr key length: %d\n", key_len);
 			res = -EIO;
_

