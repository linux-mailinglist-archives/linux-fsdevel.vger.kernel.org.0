Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5480B29E8CB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Oct 2020 11:16:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726285AbgJ2KQ3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Oct 2020 06:16:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725997AbgJ2KQ3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Oct 2020 06:16:29 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EF5FC0613D2;
        Thu, 29 Oct 2020 03:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=djfj5Ib6kVbLvDyqsMvYxF4Q43ZPZBiaaNCRhHm946I=; b=AgDpgKJwWTyUWQK15eoU1FISLY
        gdkzXBMNTiwBjujM2z9iX3mDGMMkpNtM5ox1plCtkheKCetPSVw4z7XVw9PlrFJI5EEdCysO3ojjI
        RJl2wz3/v5hZMR+h9O+P3t9F+CWSeUiXwvHVR6mbK7fxJkzCDvbHzu2tJggt6qq4iCtAr++bctgu8
        bXaSmokW8BKYPgSYV3sYxS9LKfiBGtpDj+2TfSkfwwF+KUkEOGIoP12d86gtLbbtPHOVdm9doRKXS
        dq4xhiHp1VUluVxg0EJ1bkJQ+hSG5LaQOubSn383nFG3DoK9DVjnBiMVe5Oxp31h5ixwMgo9BCgCn
        Os10omtg==;
Received: from 089144193201.atnat0002.highway.a1.net ([89.144.193.201] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kY4yo-00043u-A8; Thu, 29 Oct 2020 10:16:26 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] proc: wire up generic_file_splice_read for iter ops
Date:   Thu, 29 Oct 2020 11:09:49 +0100
Message-Id: <20201029100950.46668-3-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201029100950.46668-1-hch@lst.de>
References: <20201029100950.46668-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Wire up generic_file_splice_read for the iter based proxy ops, so
that splice reads from them work.

Signed-off-by: Christoph Hellwig <hch@lst.de>
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

