Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 241C4711BFC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 May 2023 03:04:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbjEZBEy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 May 2023 21:04:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjEZBEx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 May 2023 21:04:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C1D4195;
        Thu, 25 May 2023 18:04:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CFC2260C3F;
        Fri, 26 May 2023 01:04:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D621C433EF;
        Fri, 26 May 2023 01:04:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685063091;
        bh=HfCTt6ykRXErlMmoLlfsIDXmzBepQMiTuZZMR7GtI+o=;
        h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
        b=lToyAzi1DWlfdcSSIjkyXzBs6MJEfhWw9bC8psNTmmcS2/DNqh/ypDI609k+76v/0
         1rDGfXTWJq8N/T86jJLaq+Alg9eT0aGD7lWyHLrxZ4NHOycqMP6ZypOFMQ0BXlAgfw
         kMexIMeMqx39PVgx3CMNNvNWSudbwv9FLh1pbq3rgyqdGcAL9vjAFyB3LoWLccXEdS
         NptbIv2zHqIrLYl+pUyjojY3usRWQS2JU1wegWPhcfx+Qfiei+Mo5xotw1YynxHEdo
         ++2wgChYjp6ZLtS5tXKMG3U6YOVRsfqW0zSMGAHlm4bTt5urRNzleqCX1iHNOVc87s
         KiLqoO0Jo1oLw==
Date:   Thu, 25 May 2023 18:04:50 -0700
Subject: [PATCH 1/9] xfs: dump xfiles for debugging purposes
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     djwong@kernel.org
Cc:     linux-xfs@vger.kernel.org, willy@infradead.org,
        linux-fsdevel@vger.kernel.org
Message-ID: <168506061865.3733082.14220362905242831184.stgit@frogsfrogsfrogs>
In-Reply-To: <168506061839.3733082.9818919714772025609.stgit@frogsfrogsfrogs>
References: <168506061839.3733082.9818919714772025609.stgit@frogsfrogsfrogs>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
index d3e678cd4a2f..851aeb244660 100644
--- a/fs/xfs/scrub/xfile.c
+++ b/fs/xfs/scrub/xfile.c
@@ -431,3 +431,101 @@ xfile_put_page(
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
index 1aae2cd91720..adf5dbdc4c21 100644
--- a/fs/xfs/scrub/xfile.h
+++ b/fs/xfs/scrub/xfile.h
@@ -75,4 +75,6 @@ int xfile_get_page(struct xfile *xf, loff_t offset, unsigned int len,
 		struct xfile_page *xbuf);
 int xfile_put_page(struct xfile *xf, struct xfile_page *xbuf);
 
+int xfile_dump(struct xfile *xf);
+
 #endif /* __XFS_SCRUB_XFILE_H__ */

