Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CFE4F19F56C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Apr 2020 14:03:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727946AbgDFMDf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Apr 2020 08:03:35 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45100 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727909AbgDFMDf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Apr 2020 08:03:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=PV8JJxEiLr08d7AGp8vNVfJqXdm678ymZF9p2kLqXew=; b=TrNZMNspY0PX1BOvuJelHbbkXY
        lhyqo5jZSiRg9/Qg5pN2W/mYCBH14sBVPcDHJuelwhAhkkry2M0TD1bXF9znhj+xADGq6xNgt8XIk
        Gb65j+D8qGt0Q4l+0Y3B6Lht59ahpbj5FSTdVjXbzhzIIxoaztU17I7x04MkSKMmKMxTmDeMhAqpY
        ERvbLh5kny23f3mMIHhj1zvENJ77NmORIyymEpX+6/oGu0w72XSMCvd84JO/GI0VL0wyS9yhvFzvB
        kQB+sRGsEXeDpyAPRK7kNyIlkd3myqCQRUl2RepqggixrnIGN7DPfe71Ix4g0AHAqnKZ8Kf/5oPTq
        wskuh5/A==;
Received: from [2001:4bb8:180:5765:7ca0:239a:fe26:fec2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jLQTQ-0003Pu-Ui; Mon, 06 Apr 2020 12:03:29 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Jeremy Kerr <jk@ozlabs.org>, Arnd Bergmann <arnd@arndb.de>,
        linuxppc-dev@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 6/6] exec: open code copy_string_kernel
Date:   Mon,  6 Apr 2020 14:03:12 +0200
Message-Id: <20200406120312.1150405-7-hch@lst.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200406120312.1150405-1-hch@lst.de>
References: <20200406120312.1150405-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Currently copy_string_kernel is just a wrapper around copy_strings that
simplifies the calling conventions and uses set_fs to allow passing a
kernel pointer.  But due to the fact the we only need to handle a single
kernel argument pointer, the logic can be sigificantly simplified while
getting rid of the set_fs.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/exec.c | 43 ++++++++++++++++++++++++++++++++++---------
 1 file changed, 34 insertions(+), 9 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index b2a77d5acede..7c64cae8ad0a 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -592,17 +592,42 @@ static int copy_strings(int argc, struct user_arg_ptr argv,
  */
 int copy_string_kernel(const char *arg, struct linux_binprm *bprm)
 {
-	int r;
-	mm_segment_t oldfs = get_fs();
-	struct user_arg_ptr argv = {
-		.ptr.native = (const char __user *const  __user *)&arg,
-	};
+	int len = strnlen(arg, MAX_ARG_STRLEN) + 1 /* terminating null */;
+	unsigned long pos = bprm->p;
+
+	if (len == 0)
+		return -EFAULT;
+	if (!valid_arg_len(bprm, len))
+		return -E2BIG;
+
+	/* We're going to work our way backwords. */
+	arg += len;
+	bprm->p -= len;
+	if (IS_ENABLED(CONFIG_MMU) && bprm->p < bprm->argmin)
+		return -E2BIG;
+
+	while (len > 0) {
+		unsigned int bytes_to_copy = min_t(unsigned int, len,
+				min_not_zero(offset_in_page(pos), PAGE_SIZE));
+		struct page *page;
+		char *kaddr;
 
-	set_fs(KERNEL_DS);
-	r = copy_strings(1, argv, bprm);
-	set_fs(oldfs);
+		pos -= bytes_to_copy;
+		arg -= bytes_to_copy;
+		len -= bytes_to_copy;
 
-	return r;
+		page = get_arg_page(bprm, pos, 1);
+		if (!page)
+			return -E2BIG;
+		kaddr = kmap_atomic(page);
+		flush_arg_page(bprm, pos & PAGE_MASK, page);
+		memcpy(kaddr + offset_in_page(pos), arg, bytes_to_copy);
+		flush_kernel_dcache_page(page);
+		kunmap_atomic(kaddr);
+		put_arg_page(page);
+	}
+
+	return 0;
 }
 EXPORT_SYMBOL(copy_string_kernel);
 
-- 
2.25.1

