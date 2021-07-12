Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 851E73C6101
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jul 2021 18:56:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234766AbhGLQ7C (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jul 2021 12:59:02 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:54352 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234266AbhGLQ7B (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jul 2021 12:59:01 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id EB86D1FFC4;
        Mon, 12 Jul 2021 16:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1626108969; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9yEcA8XH1+Aq+HogCsZ38H71sADSF6n5eh1Yuc7mdUU=;
        b=idn4FWeQKRJqBP40knKINn6h25aesqwGHAjw7L1RcocMd7xaK5Sdkgkty5sOdKSFlnSjcQ
        Wx1nQrt2Tl6GrjF3TbktZrEOmbL4tGD4m1Guo8I0S7oA3N6d7tcoVda0FGu0Oa+7Wrxmcy
        f6k6UuSXjitgQ7/hDl54Nh/bLoWxSPk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1626108969;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9yEcA8XH1+Aq+HogCsZ38H71sADSF6n5eh1Yuc7mdUU=;
        b=ZtvIBDSSca7WOpnlIlhXywxDagDPFi2VN1PDK6bpSvMFWJOof37XoPjt9IuM2Aa1etLK4d
        IwxJC8LYfh/IL+AQ==
Received: from quack2.suse.cz (unknown [10.100.224.230])
        by relay2.suse.de (Postfix) with ESMTP id D6CF2A3B89;
        Mon, 12 Jul 2021 16:56:09 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id B98701F2AA9; Mon, 12 Jul 2021 18:56:09 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     <linux-fsdevel@vger.kernel.org>
Cc:     <linux-ext4@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>, Ted Tso <tytso@mit.edu>,
        Dave Chinner <david@fromorbit.com>,
        Matthew Wilcox <willy@infradead.org>, <linux-mm@kvack.org>,
        <linux-xfs@vger.kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net, linux-cifs@vger.kernel.org,
        ceph-devel@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH 02/14] documentation: Sync file_operations members with reality
Date:   Mon, 12 Jul 2021 18:55:53 +0200
Message-Id: <20210712165609.13215-2-jack@suse.cz>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210712163901.29514-1-jack@suse.cz>
References: <20210712163901.29514-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2323; h=from:subject; bh=gIg3iIztJVQoIlghVq1+fJXqU7kYO/MEXF6k8jlkFes=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBg7HQaQHe8HLcxNePecMEKAXHjeRLFAXwNY+MydxMY E0Cx61GJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCYOx0GgAKCRCcnaoHP2RA2R0cCA Ce7oPViJYsHG8/ch4tj9ytaWabFvhU9qAa2Mb8zqfoRMDv3PZSuTmQfeSChslezfK004VtuHfp0Wmq rCIeQ1IA39fD/wH8pHDF9pTRbbS+RuYeuD+Qp2ai2I8WiGbhjmgWmV00gTKQl5q9RO3JOFuE19+kCU I2TmSof6im7HJ0YwA2WBiYNJqOD6I/WhnwSVxfn2Jdzdx+l1Zxo7seV8h6A7AEkjvteEF5JcwNuQN1 TE99lrq1wdG8IDLk8JoAtPO9FRtpNj9iPNjC87pqN4qQl05cjwJVeUJmDQaqcw6lzEOcNP/qUSPbhe i68ih2izUsJFu4lY8I4EhFtvrB9K2g
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Sync listing of struct file_operations members with the real one in
fs.h.

Acked-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 Documentation/filesystems/locking.rst | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/Documentation/filesystems/locking.rst b/Documentation/filesystems/locking.rst
index 2183fd8cc350..cdf15492c699 100644
--- a/Documentation/filesystems/locking.rst
+++ b/Documentation/filesystems/locking.rst
@@ -506,6 +506,7 @@ prototypes::
 	ssize_t (*write) (struct file *, const char __user *, size_t, loff_t *);
 	ssize_t (*read_iter) (struct kiocb *, struct iov_iter *);
 	ssize_t (*write_iter) (struct kiocb *, struct iov_iter *);
+	int (*iopoll) (struct kiocb *kiocb, bool spin);
 	int (*iterate) (struct file *, struct dir_context *);
 	int (*iterate_shared) (struct file *, struct dir_context *);
 	__poll_t (*poll) (struct file *, struct poll_table_struct *);
@@ -518,12 +519,6 @@ prototypes::
 	int (*fsync) (struct file *, loff_t start, loff_t end, int datasync);
 	int (*fasync) (int, struct file *, int);
 	int (*lock) (struct file *, int, struct file_lock *);
-	ssize_t (*readv) (struct file *, const struct iovec *, unsigned long,
-			loff_t *);
-	ssize_t (*writev) (struct file *, const struct iovec *, unsigned long,
-			loff_t *);
-	ssize_t (*sendfile) (struct file *, loff_t *, size_t, read_actor_t,
-			void __user *);
 	ssize_t (*sendpage) (struct file *, struct page *, int, size_t,
 			loff_t *, int);
 	unsigned long (*get_unmapped_area)(struct file *, unsigned long,
@@ -536,6 +531,14 @@ prototypes::
 			size_t, unsigned int);
 	int (*setlease)(struct file *, long, struct file_lock **, void **);
 	long (*fallocate)(struct file *, int, loff_t, loff_t);
+	void (*show_fdinfo)(struct seq_file *m, struct file *f);
+	unsigned (*mmap_capabilities)(struct file *);
+	ssize_t (*copy_file_range)(struct file *, loff_t, struct file *,
+			loff_t, size_t, unsigned int);
+	loff_t (*remap_file_range)(struct file *file_in, loff_t pos_in,
+			struct file *file_out, loff_t pos_out,
+			loff_t len, unsigned int remap_flags);
+	int (*fadvise)(struct file *, loff_t, loff_t, int);
 
 locking rules:
 	All may block.
-- 
2.26.2

