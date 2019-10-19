Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71318DDAAF
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Oct 2019 21:24:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726133AbfJSTYS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 19 Oct 2019 15:24:18 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:52865 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbfJSTYS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 19 Oct 2019 15:24:18 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 50D3190012;
        Sat, 19 Oct 2019 15:24:17 -0400 (EDT)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:message-id:mime-version:content-type; s=sasl; bh=5TP
        O2jKqb3wpotHzJJKK+nlqcL4=; b=oWVwFsMyHLVNEuUX2Y3KJHjMdRANUkwbcrE
        aqHlY98//d3FEjw9Qzc2JsZIwY22JSzvUkds2ZAcdYuxdj9QXBDLVwwHcWB8DZx7
        Ag6r4Cn1sMcEcMT2fJSUW0+uO9fo/xsUzvouT9I+wAqL1jMFJFirCc8a9xM7+30N
        7nurOAtY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 49F5E90011;
        Sat, 19 Oct 2019 15:24:17 -0400 (EDT)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=fluxnic.net;
 h=date:from:to:cc:subject:message-id:mime-version:content-type;
 s=2016-12.pbsmtp; bh=+v9a3p3LSiJ/YkkkA16nj2GZCwZ/8pRCMjN0ysc2dHg=;
 b=tSHArGjzCnJc0iG1S/XLTviZDFwOzMJALJw5kiyNUneE57mhRSZ+TyWEDb4ULYLHhXmIVotdtv9wBYq0PE1dhnOLki8BfAKPZ/9StXIHtNpGOW3D/AGugFtJY5qTxGddO5hVc1brw51r10HItO4Hx8WNBC5MEp+Z530Lgu6rARM=
Received: from yoda.home (unknown [24.203.50.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 2559F90010;
        Sat, 19 Oct 2019 15:24:13 -0400 (EDT)
        (envelope-from nico@fluxnic.net)
Received: from xanadu.home (xanadu.home [192.168.2.2])
        by yoda.home (Postfix) with ESMTPSA id 412A62DA0166;
        Sat, 19 Oct 2019 15:24:11 -0400 (EDT)
Date:   Sat, 19 Oct 2019 15:24:11 -0400 (EDT)
From:   Nicolas Pitre <nico@fluxnic.net>
To:     Al Viro <viro@zeniv.linux.org.uk>
cc:     Maxime Bizon <mbizon@freebox.fr>,
        David Howells <dhowells@redhat.com>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH] cramfs: fix usage on non-MTD device
Message-ID: <nycvar.YSQ.7.76.1910191518180.1546@knanqh.ubzr>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Pobox-Relay-ID: 0871BEFC-F2A6-11E9-AD51-B0405B776F7B-78420484!pb-smtp20.pobox.com
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Maxime Bizon <mbizon@freebox.fr>

When both CONFIG_CRAMFS_MTD and CONFIG_CRAMFS_BLOCKDEV are enabled, if
we fail to mount on MTD, we don't try on block device.

Fixes: 74f78fc5ef43 ("vfs: Convert cramfs to use the new mount API")

Signed-off-by: Maxime Bizon <mbizon@freebox.fr>
Signed-off-by: Nicolas Pitre <nico@fluxnic.net>
---
 fs/cramfs/inode.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/cramfs/inode.c b/fs/cramfs/inode.c
index d12ea28836a5..2f04024c3588 100644
--- a/fs/cramfs/inode.c
+++ b/fs/cramfs/inode.c
@@ -958,8 +958,8 @@ static int cramfs_get_tree(struct fs_context *fc)
 
 	if (IS_ENABLED(CONFIG_CRAMFS_MTD)) {
 		ret = get_tree_mtd(fc, cramfs_mtd_fill_super);
-		if (ret < 0)
-			return ret;
+		if (!ret)
+			return 0;
 	}
 	if (IS_ENABLED(CONFIG_CRAMFS_BLOCKDEV))
 		ret = get_tree_bdev(fc, cramfs_blkdev_fill_super);
