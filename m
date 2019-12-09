Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D04031165D1
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2019 05:30:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbfLIEaF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 Dec 2019 23:30:05 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:43740 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726826AbfLIEaF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 Dec 2019 23:30:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=kFZkHr8CuoYDB938S7ssj8nSaK2Pp+HvhqByX31f7+w=; b=ZeCbLMo93b0ewls4BGOvlX4lW
        k1anJS3/nuGRAjMxFQIPnxWm7URKfR5O5GufZad1AguKw6RtmC3M+zp2MAwvZQ0CQ6LHZTv1SGubq
        NbJN/oTCVoRxgL0i5DSLfovQGlENt9ohlmWuEFSSc1+zqzT9A3Zgz4zz7P2iWB78943yKrhdubPcM
        q4sno1MEO33IltGVFu/rvgazwx1uXcrDjrXQjtPPHEynmx7Kn624s2hXJR0aGo+cafScGlxWfj5oa
        eioE9PoYfYJPUTe8gA1OMv3VLOHjAbRBZiC6+GlO+66DcgfYQvQimTgZ+3lIaC2tQhnUaIp4gYlfu
        BuYWv7VeQ==;
Received: from [2601:1c0:6280:3f0::3deb]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ieAgL-0000rM-Fv; Mon, 09 Dec 2019 04:30:01 +0000
To:     Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Jan Kara <jack@suse.cz>, Andreas Gruenbacher <agruenba@redhat.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH RESEND] fs: fix posix_acl.c kernel-doc warnings
Message-ID: <29b0dc46-1f28-a4e5-b1d0-ba2b65629779@infradead.org>
Date:   Sun, 8 Dec 2019 20:30:00 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix kernel-doc warnings in fs/posix_acl.c.
Also fix one typo (setgit -> setgid).

../fs/posix_acl.c:647: warning: Function parameter or member 'inode' not described in 'posix_acl_update_mode'
../fs/posix_acl.c:647: warning: Function parameter or member 'mode_p' not described in 'posix_acl_update_mode'
../fs/posix_acl.c:647: warning: Function parameter or member 'acl' not described in 'posix_acl_update_mode'

Fixes: 073931017b49d ("posix_acl: Clear SGID bit when setting file permissions")

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jan Kara <jack@suse.cz>
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org
Acked-by: Andreas Gruenbacher <agruenba@redhat.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
v2: change *acl to *@acl

 fs/posix_acl.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- linux-next-20191209.orig/fs/posix_acl.c
+++ linux-next-20191209/fs/posix_acl.c
@@ -631,12 +631,15 @@ EXPORT_SYMBOL_GPL(posix_acl_create);
 
 /**
  * posix_acl_update_mode  -  update mode in set_acl
+ * @inode: target inode
+ * @mode_p: mode (pointer) for update
+ * @acl: acl pointer
  *
  * Update the file mode when setting an ACL: compute the new file permission
  * bits based on the ACL.  In addition, if the ACL is equivalent to the new
- * file mode, set *acl to NULL to indicate that no ACL should be set.
+ * file mode, set *@acl to NULL to indicate that no ACL should be set.
  *
- * As with chmod, clear the setgit bit if the caller is not in the owning group
+ * As with chmod, clear the setgid bit if the caller is not in the owning group
  * or capable of CAP_FSETID (see inode_change_ok).
  *
  * Called from set_acl inode operations.

