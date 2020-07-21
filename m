Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD76A22858D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jul 2020 18:30:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730410AbgGUQ2l (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Jul 2020 12:28:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730281AbgGUQ2k (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Jul 2020 12:28:40 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0F67C061794;
        Tue, 21 Jul 2020 09:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=kzfawodPPH5N/MMitLbdMROtyNQfWaS/yDMEugbp1H8=; b=tSHzESsKJpVOpOJu/E0Ydn5lom
        MErSA9hWSS1z0meOljoEPyjmP86RehTWjDNqxCMzjIZhjdvz6Hio42O5MokHmXk4apA5i83rfEVyB
        8RaJkavwR0IXVcWkHmA+2MdXq4C6+MkUTs8smArIFhy9KQDurtoPVt8rOBq2+ElIYABs8Hm0iY7qX
        Ffp5eGUHcLuKVuLHPGbzexajxkwkL6zj+NBgLO1ysXb151gca81m/ngJFqhRoAiLg31NMNCqfO1gY
        Bq3e/sB4J0tFEW+RNreJYvKYurXQhOwIkHtmKmklEiIHOTFJ9odBDZIUrIYiPCHYlc+CEb+/7dYS5
        kC29u5OA==;
Received: from [2001:4bb8:18c:2acc:5b1c:6483:bd6d:e406] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jxv87-0007Tc-VS; Tue, 21 Jul 2020 16:28:36 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Subject: [PATCH 11/24] init: open code do_utimes in do_utime
Date:   Tue, 21 Jul 2020 18:28:05 +0200
Message-Id: <20200721162818.197315-12-hch@lst.de>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200721162818.197315-1-hch@lst.de>
References: <20200721162818.197315-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Open code the trivial utimes case in a version that takes proper kernel
pointers.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 init/initramfs.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/init/initramfs.c b/init/initramfs.c
index 3823d15e5d2619..6135b55286fc35 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -104,13 +104,20 @@ static void __init free_hash(void)
 static long __init do_utime(char *filename, time64_t mtime)
 {
 	struct timespec64 t[2];
+	struct path path;
+	int error;
 
 	t[0].tv_sec = mtime;
 	t[0].tv_nsec = 0;
 	t[1].tv_sec = mtime;
 	t[1].tv_nsec = 0;
 
-	return do_utimes(AT_FDCWD, filename, t, AT_SYMLINK_NOFOLLOW);
+	error = kern_path(filename, 0, &path);
+	if (error)
+		return error;
+	error = vfs_utimes(&path, t);
+	path_put(&path);
+	return error;
 }
 
 static __initdata LIST_HEAD(dir_list);
-- 
2.27.0

