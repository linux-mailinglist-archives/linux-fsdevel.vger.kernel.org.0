Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD5062078D4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jun 2020 18:17:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404994AbgFXQP1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Jun 2020 12:15:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404787AbgFXQOE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Jun 2020 12:14:04 -0400
Received: from casper.infradead.org (unknown [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B17CAC061796;
        Wed, 24 Jun 2020 09:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=Bo298b9PL3Uu2rIZ3OmLGqOnn53VokHDlRvRjRJg3qI=; b=fnAZxTCYz/46Hcw/7kbJSkEbDK
        05LcYXy0b8pLZLaxU37cOfNzAFQ1pKuXoGE2mC3eqDscLeBF/BbSpfA2DwSaZ50j4sntWpFsTmwe/
        +TBIxX7OSmc4f6OMj8ER5Y25pIPmMTEZPbFsZeqSIImK6DKarl54m6sV3KhR+q9zFzWf/0H+CaPHb
        xi9Y4Jes8UT3Uy6dT3HuyuieKRTC7PmfItuM64IOgYkTARY+vYpEXMDNKAzaWmAktxtYwQxuUMQgj
        k8tpSIWVCzD2LM/45GycHOcLIQg5VPAsjWlu/r1htWKFCZ7wqNuxUpflQiu0IUF4WqBa/5Sl2oLDd
        S52L5C+Q==;
Received: from [2001:4bb8:180:a3:5c7c:8955:539d:955b] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jo81u-0005xs-Ab; Wed, 24 Jun 2020 16:13:42 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        netfilter-devel@vger.kernel.org
Subject: [PATCH 04/14] fs: unexport __kernel_write
Date:   Wed, 24 Jun 2020 18:13:25 +0200
Message-Id: <20200624161335.1810359-5-hch@lst.de>
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

This is a very special interface that skips sb_writes protection, and not
used by modules anymore.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/read_write.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/read_write.c b/fs/read_write.c
index bbfa9b12b15eb7..2c601d853ff3d8 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -522,7 +522,6 @@ ssize_t __kernel_write(struct file *file, const void *buf, size_t count, loff_t
 	inc_syscw(current);
 	return ret;
 }
-EXPORT_SYMBOL(__kernel_write);
 
 ssize_t kernel_write(struct file *file, const void *buf, size_t count,
 			    loff_t *pos)
-- 
2.26.2

