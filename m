Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB490207887
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jun 2020 18:15:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404794AbgFXQOF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Jun 2020 12:14:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404678AbgFXQOC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Jun 2020 12:14:02 -0400
Received: from casper.infradead.org (unknown [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2C08C0613ED;
        Wed, 24 Jun 2020 09:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=PIZcUHBXRzg4FA/EeFx1uXo9md1v0NkQLsX0zI2zg6M=; b=F6M/qB6g9/5tPao1/ANmNaFFIu
        7eBKcM5NjloKBPTgvN+++s4++INLJU5YYEuo1b9XkD7NAu7Jt+K9JZx5EmiVKj8o5h3MictoI/P3z
        8GQWVWmVhwk9SfZaVTg0Ly95IkfJHD1swQ1WuZq7DO5oYUlk7DbB9TKJGRyZ87zXAwnpeBVa3HPZq
        t7UoReJHe1r3CGQiu1f8wvuy/eZTYu0bkjKPicdqz36qxLSUAt9whbJpBxnGe+fIt7m7HWxVTdtGh
        m5NnfbVMRzS0EO96IoudEVBKkpb0+F5hRbBrYq52I1KgSOimKlzW6qGJ/gaCNnoAxJsMGEgoL+8yT
        BQ5oaoog==;
Received: from [2001:4bb8:180:a3:5c7c:8955:539d:955b] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jo81t-0005xm-5R; Wed, 24 Jun 2020 16:13:41 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        netfilter-devel@vger.kernel.org
Subject: [PATCH 03/14] bpfilter: switch to kernel_write
Date:   Wed, 24 Jun 2020 18:13:24 +0200
Message-Id: <20200624161335.1810359-4-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200624161335.1810359-1-hch@lst.de>
References: <20200624161335.1810359-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

While pipes don't really need sb_writers projection, __kernel_write is an
interface better kept private, and the additional rw_verify_area does not
hurt here.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 net/bpfilter/bpfilter_kern.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bpfilter/bpfilter_kern.c b/net/bpfilter/bpfilter_kern.c
index c0f0990f30b604..1905e01c3aa9a7 100644
--- a/net/bpfilter/bpfilter_kern.c
+++ b/net/bpfilter/bpfilter_kern.c
@@ -50,7 +50,7 @@ static int __bpfilter_process_sockopt(struct sock *sk, int optname,
 	req.len = optlen;
 	if (!bpfilter_ops.info.pid)
 		goto out;
-	n = __kernel_write(bpfilter_ops.info.pipe_to_umh, &req, sizeof(req),
+	n = kernel_write(bpfilter_ops.info.pipe_to_umh, &req, sizeof(req),
 			   &pos);
 	if (n != sizeof(req)) {
 		pr_err("write fail %zd\n", n);
-- 
2.26.2

