Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45C3321C29B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Jul 2020 08:49:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728056AbgGKGtB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 11 Jul 2020 02:49:01 -0400
Received: from verein.lst.de ([213.95.11.211]:45371 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727867AbgGKGtA (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 11 Jul 2020 02:49:00 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 9B60168AEF; Sat, 11 Jul 2020 08:48:57 +0200 (CEST)
Date:   Sat, 11 Jul 2020 08:48:57 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-tegra <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH 15/23] seq_file: switch over direct seq_read method
 calls to seq_read_iter
Message-ID: <20200711064857.GA29078@lst.de>
References: <20200707174801.4162712-1-hch@lst.de> <20200707174801.4162712-16-hch@lst.de> <5a2a97f1-58b5-8068-3c69-bb06130ffb35@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a2a97f1-58b5-8068-3c69-bb06130ffb35@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Please try this one:

---
From 5e86146296fbcd7593da1d9d39b9685a5e6b83be Mon Sep 17 00:00:00 2001
From: Christoph Hellwig <hch@lst.de>
Date: Sat, 11 Jul 2020 08:46:10 +0200
Subject: debugfs: add a proxy stub for ->read_iter

debugfs registrations typically go through a set of proxy ops to deal
with refcounting, which need to support every method that can be
supported.  Add ->read_iter to the proxy ops to prepare for seq_file to
be switch to ->read_iter.

Reported-by: Jon Hunter <jonathanh@nvidia.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/debugfs/file.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/debugfs/file.c b/fs/debugfs/file.c
index 8ba32c2feb1b73..dcd7bdaf67417f 100644
--- a/fs/debugfs/file.c
+++ b/fs/debugfs/file.c
@@ -231,6 +231,10 @@ FULL_PROXY_FUNC(read, ssize_t, filp,
 			loff_t *ppos),
 		ARGS(filp, buf, size, ppos));
 
+FULL_PROXY_FUNC(read_iter, ssize_t, iocb->ki_filp,
+		PROTO(struct kiocb *iocb, struct iov_iter *iter),
+		ARGS(iocb, iter));
+
 FULL_PROXY_FUNC(write, ssize_t, filp,
 		PROTO(struct file *filp, const char __user *buf, size_t size,
 			loff_t *ppos),
@@ -286,6 +290,8 @@ static void __full_proxy_fops_init(struct file_operations *proxy_fops,
 		proxy_fops->llseek = full_proxy_llseek;
 	if (real_fops->read)
 		proxy_fops->read = full_proxy_read;
+	if (real_fops->read_iter)
+		proxy_fops->read_iter = full_proxy_read_iter;
 	if (real_fops->write)
 		proxy_fops->write = full_proxy_write;
 	if (real_fops->poll)
-- 
2.26.2

