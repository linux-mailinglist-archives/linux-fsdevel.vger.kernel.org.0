Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98D9F217589
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jul 2020 19:49:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728804AbgGGRtS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Jul 2020 13:49:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728471AbgGGRsR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Jul 2020 13:48:17 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14197C061755;
        Tue,  7 Jul 2020 10:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=PIZcUHBXRzg4FA/EeFx1uXo9md1v0NkQLsX0zI2zg6M=; b=UTUPIlR6WQ9gbpj9oAyWWz2BsR
        P3RItcDIDoSx/mQl8E1LH3rfmfp9B6H7lcjkM6v0K7aSTu9gFSw09qAy6wMGwNKVTu3yty1qMeGNq
        34uLpX2d/UnJPXWo98PJq3nlXgcC1v/iXyEdOtoyGhVC65sOH60b5WnRj2w/9v9VeqHyGK6X7FmeA
        5BzQPRU6hktMA4PqUub5DFadHMy/9rmmrBrAUxzyEb+koA5inbSF/5kKZtiJvdNzufjCvODircTS7
        NH2kxFOvOSleSJDPU3MalGwkjMoTbW2lSm1RKDdeUwjEibm+7WXlhdgjLEPsN271ZvYT4qBtsse78
        pEU9tPSg==;
Received: from [2001:4bb8:18c:3b3b:a49f:8154:a2b7:8b6c] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jsrhP-0003HI-AY; Tue, 07 Jul 2020 17:48:07 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 03/23] bpfilter: switch to kernel_write
Date:   Tue,  7 Jul 2020 19:47:41 +0200
Message-Id: <20200707174801.4162712-4-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200707174801.4162712-1-hch@lst.de>
References: <20200707174801.4162712-1-hch@lst.de>
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

