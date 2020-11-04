Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64AB52A5FAE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Nov 2020 09:34:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbgKDIeZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Nov 2020 03:34:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725812AbgKDIeY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Nov 2020 03:34:24 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31B26C0613D3;
        Wed,  4 Nov 2020 00:34:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=b2Fd/OiDJYNfX586ImlTF4ycJioykyPqmXwMnPPANko=; b=c5UoOMaEg6CKOTEIDo9Xqg1KpG
        TYiuaASDVS47WTENY50MEwpVHQreig5OMM9/uRDR/Rhv/QVyCtKqoeKNlsxZrTrUARyxrHDvUJaOz
        FA1r0ZyYPNOt02XH8mPlK+9LrJ2L2yUEKJiNILvCUCX9+P5THC+G8eFgCudw9m8hTjlb2PdNcR5yT
        7zGJDO4tIQWzfeW5bOm9B2YRrqYBKNRt6zOvQYt8Z3msyv1rdqz+9qP2eAGL4LiEjibd1jg7sshM4
        3Fd7NvN5sOCa7RCg3bq1GGMAoekTddt5jCkxZj2XDVJCHxuRNw+ql2+v02KgBddwtLIiccSSFyj1R
        YqmZ+qPg==;
Received: from 089144208145.atnat0017.highway.a1.net ([89.144.208.145] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kaEFG-0004Y2-K7; Wed, 04 Nov 2020 08:34:20 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] proc: wire up generic_file_splice_read for iter ops
Date:   Wed,  4 Nov 2020 09:27:34 +0100
Message-Id: <20201104082738.1054792-3-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201104082738.1054792-1-hch@lst.de>
References: <20201104082738.1054792-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Wire up generic_file_splice_read for the iter based proxy ops, so
that splice reads from them work.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Tested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/proc/inode.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/proc/inode.c b/fs/proc/inode.c
index 58c075e2a452d6..bde6b6f69852d2 100644
--- a/fs/proc/inode.c
+++ b/fs/proc/inode.c
@@ -597,6 +597,7 @@ static const struct file_operations proc_iter_file_ops = {
 	.llseek		= proc_reg_llseek,
 	.read_iter	= proc_reg_read_iter,
 	.write		= proc_reg_write,
+	.splice_read	= generic_file_splice_read,
 	.poll		= proc_reg_poll,
 	.unlocked_ioctl	= proc_reg_unlocked_ioctl,
 	.mmap		= proc_reg_mmap,
@@ -622,6 +623,7 @@ static const struct file_operations proc_reg_file_ops_compat = {
 static const struct file_operations proc_iter_file_ops_compat = {
 	.llseek		= proc_reg_llseek,
 	.read_iter	= proc_reg_read_iter,
+	.splice_read	= generic_file_splice_read,
 	.write		= proc_reg_write,
 	.poll		= proc_reg_poll,
 	.unlocked_ioctl	= proc_reg_unlocked_ioctl,
-- 
2.28.0

