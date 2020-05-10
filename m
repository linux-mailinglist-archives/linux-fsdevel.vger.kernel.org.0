Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55C781CC87B
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 May 2020 09:57:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729417AbgEJH5W (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 10 May 2020 03:57:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729330AbgEJH4u (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 10 May 2020 03:56:50 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57029C05BD09;
        Sun, 10 May 2020 00:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=oCdrIxNzR4NHS2NDYxpGK2EFu2WHsVdB0VGTwPSxhuk=; b=Q+7UfgQ3Rdq+rLentMN2OrWKT3
        jTnHLTbJ6Yo8QYhjLeB8vp2MreobznJtTFQ0jlaiUn5RGr0TWosPvI6rcQTJE/Et+fDYfoHslzFqw
        /BWbCS4JJSasi/72B4NdftCFoYId60ALrCeqbqSFqlmZALTsuQbRcxZdE7gVEMRUZ+2jJgbwFOeTc
        q0RSZogxgE3wUwtPbM4tnpRSA/1iH3V8P+QeyF82EweD60S2UCkj7Bj8IUJ6rB3V0/NRIyG7Xj/d5
        ro+hoo6ZZWAwhBD9nnrcR3crM1Fw3XFyChwrI8FcD9H77DOo0SD2ywb9vJJFHT9ycuVP7MGMEc0Zc
        hBawSvig==;
Received: from [2001:4bb8:180:9d3f:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jXgpC-0001El-6j; Sun, 10 May 2020 07:56:38 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Roman Zippel <zippel@linux-m68k.org>
Cc:     Jessica Yu <jeyu@kernel.org>, Michal Simek <monstr@monstr.eu>,
        x86@kernel.org, linux-alpha@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-c6x-dev@linux-c6x.org, linux-hexagon@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, openrisc@lists.librecores.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-um@lists.infradead.org, linux-xtensa@linux-xtensa.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 27/31] exec: only build read_code when needed
Date:   Sun, 10 May 2020 09:55:06 +0200
Message-Id: <20200510075510.987823-28-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200510075510.987823-1-hch@lst.de>
References: <20200510075510.987823-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Only build read_code when binary formats that use it are built into the
kernel.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/exec.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/exec.c b/fs/exec.c
index 06b4c550af5d9..a4f766f296f8f 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1027,6 +1027,8 @@ int kernel_read_file_from_fd(int fd, void **buf, loff_t *size, loff_t max_size,
 }
 EXPORT_SYMBOL_GPL(kernel_read_file_from_fd);
 
+#if defined(CONFIG_HAVE_AOUT) || defined(CONFIG_BINFMT_FLAT) || \
+    defined(CONFIG_BINFMT_ELF_FDPIC)
 ssize_t read_code(struct file *file, unsigned long addr, loff_t pos, size_t len)
 {
 	ssize_t res = vfs_read(file, (void __user *)addr, len, &pos);
@@ -1035,6 +1037,7 @@ ssize_t read_code(struct file *file, unsigned long addr, loff_t pos, size_t len)
 	return res;
 }
 EXPORT_SYMBOL(read_code);
+#endif
 
 /*
  * Maps the mm_struct mm into the current task struct.
-- 
2.26.2

