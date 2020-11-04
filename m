Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C08C2A5FBA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Nov 2020 09:37:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728700AbgKDIhC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Nov 2020 03:37:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728658AbgKDIgm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Nov 2020 03:36:42 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0590C0613D3;
        Wed,  4 Nov 2020 00:36:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=ngN0FA3BbaF2skTQb81SDx6NNnA9B+apeh1z2VF7HOU=; b=ZNIp7O1FFH5oXUqJB4DZ9+A4WO
        0mJFCWHS9x83+NHiPMjZCrWjZgkFGU7Mxp5whdALp2uqPqHJT5EQrivT48y29bsE2ims8XQpjI1iG
        R4/fSG2U4yUnJ2CLW55ygK6gb5mPCA4r1Rh7wUCsl51yEZG+AJb6yTp0fTCMk7xZ4sHrMbCoz36HI
        B2oGDLWrM5SoxXGwTKI2BPup7heJpwZv1G2Bkx8mW054F9SnVhKgIgfgz9QFa69rh5yPq7153uGlH
        98XnIP7pV2vshUuqgmxHDjNPMClHnJyLj78LGOvXTDMvyaQxQ/8BEFpTcGVnjOsHmurKDiLh71xn5
        PxdHKkDQ==;
Received: from 089144208145.atnat0017.highway.a1.net ([89.144.208.145] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kaEHQ-0004kc-0T; Wed, 04 Nov 2020 08:36:36 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] proc/cpuinfo: switch to ->read_iter
Date:   Wed,  4 Nov 2020 09:27:35 +0100
Message-Id: <20201104082738.1054792-4-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201104082738.1054792-1-hch@lst.de>
References: <20201104082738.1054792-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Implement ->read_iter so that the Android bionic test suite can use
this random proc file for its splice test case.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/proc/cpuinfo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/proc/cpuinfo.c b/fs/proc/cpuinfo.c
index d0989a443c77df..419760fd77bdd8 100644
--- a/fs/proc/cpuinfo.c
+++ b/fs/proc/cpuinfo.c
@@ -19,7 +19,7 @@ static int cpuinfo_open(struct inode *inode, struct file *file)
 static const struct proc_ops cpuinfo_proc_ops = {
 	.proc_flags	= PROC_ENTRY_PERMANENT,
 	.proc_open	= cpuinfo_open,
-	.proc_read	= seq_read,
+	.proc_read_iter	= seq_read_iter,
 	.proc_lseek	= seq_lseek,
 	.proc_release	= seq_release,
 };
-- 
2.28.0

