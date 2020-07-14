Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6F6021FCB3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jul 2020 21:11:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730965AbgGNTI4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Jul 2020 15:08:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730198AbgGNTIx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Jul 2020 15:08:53 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A322C061794;
        Tue, 14 Jul 2020 12:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=BDxqNAyXTxzLLCgYDAkjeG7ETUtTJqGj9qruExt6hQ4=; b=jbGQngvVuzXKT8N+TaSzkVnsIy
        TIhImTs77/i/C8718Y8Qn3T8pmPJpu+4MN4uETRii8aUpey96ZZxNLecbin9T9CR4NLQG2ck/WLxR
        Rn5DoF3TV/mBmRF3TLHsoW24E5ZEZVGxe64zeXBxlsJJ8dHeG63cAD2o42kfhzSEwsdBIgwwUpJLM
        GO1cck0PorBhdHcittMmNalv9/4av3KIC0FRwi9KeIQBzk/beAKPL6c3wdbOoDLHpBffxvDvBLNq5
        ATj36va3+CVflk8UOYtp7YkZED2mU/99nAUfF6TeHn7BOH22JsJXAtI2ZEcDVYPcGP0G57EXS1yje
        wIH0k3MA==;
Received: from [2001:4bb8:188:5f50:f037:8cfe:627e:7028] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jvQIN-0005pH-9X; Tue, 14 Jul 2020 19:08:51 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     linux-kernel@vger.kernel.org
Cc:     "H. Peter Anvin" <hpa@zytor.com>, Song Liu <song@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-raid@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 02/23] fs: add a vfs_fchmod helper
Date:   Tue, 14 Jul 2020 21:04:06 +0200
Message-Id: <20200714190427.4332-3-hch@lst.de>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200714190427.4332-1-hch@lst.de>
References: <20200714190427.4332-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a helper for struct file based chmode operations.  To be used by
the initramfs code soon.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/open.c          | 9 +++++++--
 include/linux/fs.h | 1 +
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/fs/open.c b/fs/open.c
index 103c66309bee67..75166f071d280a 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -602,14 +602,19 @@ static int chmod_common(const struct path *path, umode_t mode)
 	return error;
 }
 
+int vfs_fchmod(struct file *file, umode_t mode)
+{
+	audit_file(file);
+	return chmod_common(&file->f_path, mode);
+}
+
 int ksys_fchmod(unsigned int fd, umode_t mode)
 {
 	struct fd f = fdget(fd);
 	int err = -EBADF;
 
 	if (f.file) {
-		audit_file(f.file);
-		err = chmod_common(&f.file->f_path, mode);
+		err = vfs_fchmod(f.file, mode);
 		fdput(f);
 	}
 	return err;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 0ddd64ca0b45c0..635086726f2053 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1745,6 +1745,7 @@ int vfs_mkobj(struct dentry *, umode_t,
 		void *);
 
 int vfs_fchown(struct file *file, uid_t user, gid_t group);
+int vfs_fchmod(struct file *file, umode_t mode);
 
 extern long vfs_ioctl(struct file *file, unsigned int cmd, unsigned long arg);
 
-- 
2.27.0

