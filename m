Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6CAE1F41E0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jun 2020 19:12:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729426AbgFIRMs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Jun 2020 13:12:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727021AbgFIRMs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Jun 2020 13:12:48 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23FB5C05BD1E;
        Tue,  9 Jun 2020 10:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=Xfx824IqwGWHG7uI7+NTCcQdTS7fjG1Dt9prfSku5nU=; b=YmbHU39F5GanrjWbGmq5ZtjDFA
        PUsJPiF76e6CY7729gSjHFSTZMFd5qaY6POzgSTBgaQZcmw+qF9ZxxFRvwVqTWu1UUNyLQrqQZVg8
        /zNZJ0OpqKzY5cOSh+yj1WnK+9MM9vXVxSKY+tQW1PhDDH1d06/+Ls+Fw/rc/hIGVU7Uwi7S/EOra
        M4Tg91+LESYmhkpGxQ57QHt9v8ItJopcsltaInb8NlGe5BY5vV9aA5OelFB7Z7V9SsiTZbGO1Ws+a
        hdTMocoSXEoa2CSxRyAPFrHzG3tFSoAJ09g3fZ4/zc5ZnZdvASJlMLQp0/OTI7C+aKdFmdfcfaU4v
        /ZTJbpvQ==;
Received: from 213-225-38-56.nat.highway.a1.net ([213.225.38.56] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jihnp-0007Oj-C7; Tue, 09 Jun 2020 17:12:45 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        build test robot <lkp@intel.com>
Subject: [PATCH 1/2] cdrom: fix an incorrect __user annotation on cdrom_sysctl_info
Date:   Tue,  9 Jun 2020 19:08:18 +0200
Message-Id: <20200609170819.52353-2-hch@lst.de>
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

No user pointers for sysctls anymore.

Fixes: 32927393dc1c ("sysctl: pass kernel pointers to ->proc_handler")
Reported-by: build test robot <lkp@intel.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/cdrom/cdrom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cdrom/cdrom.c b/drivers/cdrom/cdrom.c
index e3bbe108eb542f..410060812e9dbf 100644
--- a/drivers/cdrom/cdrom.c
+++ b/drivers/cdrom/cdrom.c
@@ -3518,7 +3518,7 @@ static int cdrom_print_info(const char *header, int val, char *info,
 }
 
 static int cdrom_sysctl_info(struct ctl_table *ctl, int write,
-                           void __user *buffer, size_t *lenp, loff_t *ppos)
+                           void *buffer, size_t *lenp, loff_t *ppos)
 {
 	int pos;
 	char *info = cdrom_sysctl_settings.info;
-- 
2.26.2

