Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0FE1418EE0F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Mar 2020 03:45:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727036AbgCWCpo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 22 Mar 2020 22:45:44 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48110 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727024AbgCWCpo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 22 Mar 2020 22:45:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Date:Message-ID:Subject:From:To:Sender:Reply-To:Cc:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=W4bXDYwfS3EN8dSOa7pgo/9N3vt3vB1jLkTpJl8qckM=; b=hK1p55WFdhHlWdxSHa/nwMk5sc
        MQxfVM/ZOAWIdHd6F2KBDW9IJUXoB54xqrl82x9BUStrqqVx5XLd6egoKVoMfXVhRM1QFEldpFd91
        2/+P8Uth8iOxwMUKiYS989y1+uCPs+Ifi5hCEfMJTW8NZXHCNl8YWCNy7cjKC60gP8NJaYmN3aBTy
        iPNmGuJ1sXGGCLL21SwRlnlqs/FZP5G+IAyKD1RJGTid3QSpseR0oUgKNkd4B2mjrhkIMx8JHWpUX
        c0kSQmHF9omrCPUJm63Gr2rEVsAMBgKSOO81Lruk4Yzrcvces2j8l8Hw/KERw7IZ0IFZr1mUROWpn
        N7kySDmg==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jGD5z-0001Eu-3O; Mon, 23 Mar 2020 02:45:43 +0000
To:     Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-ext4@vger.kernel.org, Jan Kara <jack@suse.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] ext2: fix empty body warnings when -Wextra is used
Message-ID: <e18a7395-61fb-2093-18e8-ed4f8cf56248@infradead.org>
Date:   Sun, 22 Mar 2020 19:45:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

When EXT2_ATTR_DEBUG is not defined, modify the 2 debug macros
to use the no_printk() macro instead of <nothing>.
This fixes gcc warnings when -Wextra is used:

../fs/ext2/xattr.c:252:42: warning: suggest braces around empty body in an ‘if’ statement [-Wempty-body]
../fs/ext2/xattr.c:258:42: warning: suggest braces around empty body in an ‘if’ statement [-Wempty-body]
../fs/ext2/xattr.c:330:42: warning: suggest braces around empty body in an ‘if’ statement [-Wempty-body]
../fs/ext2/xattr.c:872:45: warning: suggest braces around empty body in an ‘else’ statement [-Wempty-body]

I have verified that the only object code change (with gcc 7.5.0) is
the reversal of some instructions from 'cmp a,b' to 'cmp b,a'.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jan Kara <jack@suse.com>
Cc: linux-ext4@vger.kernel.org
---
 fs/ext2/xattr.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- linux-next-20200320.orig/fs/ext2/xattr.c
+++ linux-next-20200320/fs/ext2/xattr.c
@@ -56,6 +56,7 @@
 
 #include <linux/buffer_head.h>
 #include <linux/init.h>
+#include <linux/printk.h>
 #include <linux/slab.h>
 #include <linux/mbcache.h>
 #include <linux/quotaops.h>
@@ -84,8 +85,8 @@
 		printk("\n"); \
 	} while (0)
 #else
-# define ea_idebug(f...)
-# define ea_bdebug(f...)
+# define ea_idebug(inode, f...)	no_printk(f)
+# define ea_bdebug(bh, f...)	no_printk(f)
 #endif
 
 static int ext2_xattr_set2(struct inode *, struct buffer_head *,

