Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEA15659E7C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Dec 2022 00:41:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235616AbiL3XlW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Dec 2022 18:41:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235598AbiL3XlV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Dec 2022 18:41:21 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D8F71DF16;
        Fri, 30 Dec 2022 15:41:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CF44B61B98;
        Fri, 30 Dec 2022 23:41:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34C69C433EF;
        Fri, 30 Dec 2022 23:41:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672443680;
        bh=aRnBOh9zi0c4v4kkPL5oV9hI5IvYjK4oHtf4Vzkec9M=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=AWVVvH9DqniUiTdVJlXTjsTDIb3BIkGQBo/EBGsSMs3b5ZpLI5tkAARnn/ZzMLmAf
         6VVkFh84/2JBSKKWkJ/ZwWp8TUk2VBhL+LpaIKW93BYnuNeeR43k7KpfZTvKp6pM0s
         pbxRPz0OUaQOSRRatwm3jEg2jhgTIzjdKHa8qP7tdSstq5ADA9DRpz8yFH6QCu1O+k
         VkRNAO2c/1FRptnzpySEtQPJX6VjFgocAC0MiP3a0TJNXGJ6UqOHIpn/L84nPE9R1Z
         Bflw9E04zuhkYFEHwW2bitQYA16ShyigveipkBIPb51Sv/1JEALPDIqMpTSCodbfPP
         Bs/hdaqFwIXeg==
Subject: [PATCH 1/7] xfs: dump xfiles for debugging purposes
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     djwong@kernel.org
Cc:     linux-xfs@vger.kernel.org, willy@infradead.org,
        linux-fsdevel@vger.kernel.org
Date:   Fri, 30 Dec 2022 14:13:26 -0800
Message-ID: <167243840613.696535.9415083931801777839.stgit@magnolia>
In-Reply-To: <167243840589.696535.4812770109109400531.stgit@magnolia>
References: <167243840589.696535.4812770109109400531.stgit@magnolia>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Darrick J. Wong <djwong@kernel.org>

Add a debug function to dump an xfile's contents for debug purposes.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/xfs/scrub/xfile.c |   98 ++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/xfs/scrub/xfile.h |    2 +
 2 files changed, 100 insertions(+)


diff --git a/fs/xfs/scrub/xfile.c b/fs/xfs/scrub/xfile.c
index 7090a8e12b60..1b858b6a53c8 100644
--- a/fs/xfs/scrub/xfile.c
+++ b/fs/xfs/scrub/xfile.c
@@ -424,3 +424,101 @@ xfile_put_page(
 		return -EIO;
 	return 0;
 }
+
+/* Dump an xfile to dmesg. */
+int
+xfile_dump(
+	struct xfile		*xf)
+{
+	struct xfile_stat	sb;
+	struct inode		*inode = file_inode(xf->file);
+	struct address_space	*mapping = inode->i_mapping;
+	loff_t			holepos = 0;
+	loff_t			datapos;
+	loff_t			ret;
+	unsigned int		pflags;
+	bool			all_zeroes = true;
+	int			error = 0;
+
+	error = xfile_stat(xf, &sb);
+	if (error)
+		return error;
+
+	printk(KERN_ALERT "xfile ino 0x%lx isize 0x%llx dump:", inode->i_ino,
+			sb.size);
+	pflags = memalloc_nofs_save();
+
+	while ((ret = vfs_llseek(xf->file, holepos, SEEK_DATA)) >= 0) {
+		datapos = rounddown_64(ret, PAGE_SIZE);
+		ret = vfs_llseek(xf->file, datapos, SEEK_HOLE);
+		if (ret < 0)
+			break;
+		holepos = min_t(loff_t, sb.size, roundup_64(ret, PAGE_SIZE));
+
+		while (datapos < holepos) {
+			struct page	*page = NULL;
+			void		*p, *kaddr;
+			u64		datalen = holepos - datapos;
+			unsigned int	pagepos;
+			unsigned int	pagelen;
+
+			cond_resched();
+
+			if (fatal_signal_pending(current)) {
+				error = -EINTR;
+				goto out_pflags;
+			}
+
+			pagelen = min_t(u64, datalen, PAGE_SIZE);
+
+			page = shmem_read_mapping_page_gfp(mapping,
+					datapos >> PAGE_SHIFT, __GFP_NOWARN);
+			if (IS_ERR(page)) {
+				error = PTR_ERR(page);
+				if (error == -EIO)
+					printk(KERN_ALERT "%.8llx: poisoned",
+							datapos);
+				else if (error != -ENOMEM)
+					goto out_pflags;
+
+				goto next_pgoff;
+			}
+
+			if (!PageUptodate(page))
+				goto next_page;
+
+			kaddr = kmap_local_page(page);
+			p = kaddr;
+
+			for (pagepos = 0; pagepos < pagelen; pagepos += 16) {
+				char prefix[16];
+				unsigned int linelen;
+
+				linelen = min_t(unsigned int, pagelen, 16);
+
+				if (!memchr_inv(p + pagepos, 0, linelen))
+					continue;
+
+				snprintf(prefix, 16, "%.8llx: ",
+						datapos + pagepos);
+
+				all_zeroes = false;
+				print_hex_dump(KERN_ALERT, prefix,
+						DUMP_PREFIX_NONE, 16, 1,
+						p + pagepos, linelen, true);
+			}
+			kunmap_local(kaddr);
+next_page:
+			put_page(page);
+next_pgoff:
+			datapos += PAGE_SIZE;
+		}
+	}
+	if (all_zeroes)
+		printk(KERN_ALERT "<all zeroes>");
+	if (ret != -ENXIO)
+		error = ret;
+out_pflags:
+	memalloc_nofs_restore(pflags);
+	return error;
+}
diff --git a/fs/xfs/scrub/xfile.h b/fs/xfs/scrub/xfile.h
index 0172bd9eeab0..b7f046016b1b 100644
--- a/fs/xfs/scrub/xfile.h
+++ b/fs/xfs/scrub/xfile.h
@@ -75,4 +75,6 @@ int xfile_get_page(struct xfile *xf, loff_t offset, unsigned int len,
 		struct xfile_page *xbuf);
 int xfile_put_page(struct xfile *xf, struct xfile_page *xbuf);
 
+int xfile_dump(struct xfile *xf);
+
 #endif /* __XFS_SCRUB_XFILE_H__ */

