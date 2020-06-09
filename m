Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62A601F41E9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jun 2020 19:15:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729817AbgFIRPC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Jun 2020 13:15:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727002AbgFIRPC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Jun 2020 13:15:02 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C24B3C05BD1E;
        Tue,  9 Jun 2020 10:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=UpZXoNnaIyWKzV6Z6O45sLy0hwoaGi/+8KOaNyXYIhk=; b=LryZXbKuN2eGOYk2BNZevWXRQ2
        Vz1L4QBFGOZ7HACvE4sUMqRernCPHCikllguj+wYJHCu0s5VtY6ngnkJJji5lXq44AdeRsWaq0bN7
        QSu9A2rvLFuaYkJwrc4JPCvEUVHFFLvWxKhHPacP1AlaZfNW2nByB6c5JGoPwFsz2tdKaSQRYyXNQ
        WrQUwBlH0Figka6mizQcT9XJzl8VgUmLkERrj6tSlrgFfn4EucxYuPj/qcL/JWrUM8U4KrNqFEcpz
        Emt78qXrFbIRmZ+neeEhNevfxV/32D04k3HD9YCVuG4lrNOIo63vJGtd9zCcYFq9YgyupkPoKjPB3
        2SEBcJtg==;
Received: from 213-225-38-56.nat.highway.a1.net ([213.225.38.56] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jihpy-00083s-FN; Tue, 09 Jun 2020 17:14:58 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vegard Nossum <vegard.nossum@oracle.com>
Subject: [PATCH 2/2] sysctl: reject gigantic reads/write to sysctl files
Date:   Tue,  9 Jun 2020 19:08:19 +0200
Message-Id: <20200609170819.52353-3-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200609170819.52353-1-hch@lst.de>
References: <20200609170819.52353-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Instead of triggering a WARN_ON deep down in the page allocator just
give up early on allocations that are way larger than the usual sysctl
values.

Fixes: 32927393dc1c ("sysctl: pass kernel pointers to ->proc_handler")
Reported-by: Vegard Nossum <vegard.nossum@oracle.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/proc/proc_sysctl.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index df2143e05c571e..08c33bd1642dcd 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -564,6 +564,10 @@ static ssize_t proc_sys_call_handler(struct file *filp, void __user *ubuf,
 	if (!table->proc_handler)
 		goto out;
 
+	/* don't even try if the size is too large */
+	if (count > KMALLOC_MAX_SIZE)
+		return -ENOMEM;
+
 	if (write) {
 		kbuf = memdup_user_nul(ubuf, count);
 		if (IS_ERR(kbuf)) {
-- 
2.26.2

