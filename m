Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E415F711B9C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 May 2023 02:48:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233538AbjEZAsA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 May 2023 20:48:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbjEZAr7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 May 2023 20:47:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 682A512E;
        Thu, 25 May 2023 17:47:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E0B7664BE9;
        Fri, 26 May 2023 00:47:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5239CC433EF;
        Fri, 26 May 2023 00:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685062076;
        bh=bhvmQ9VTOqHsxiEi0JRT6zrKpGiRy1Jy+0fL/y8OP3I=;
        h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
        b=BS8jxkcqhBNiG/uJKIkN+WCaSRg/s+TBnodOkqvtAfpnLd0LHTSqi8rwUKz9A2dCv
         yIpr2HzmBEp6mdoJ7nADx7VJCRnmMAqpY4MXWpiFLnB5N6rLsNvZ9ZjKiAPvre5EIh
         HTWoitMdloMadWdu16Q3f2svDz6K3OEyvRomjJVI8CwaZz8Kxzs6PEbsD4K8jc30aT
         Q342b6kDsKmGVlTxpTGVryvvvERFxy75yYxvAhBRniv8I9dSOiSXTGtVnzwOXUgfij
         r1cn0ea6IeKGP5SH6IlmU4DqM+DGFEcwV7JXtQysvoG7ol01vlMj19/bH3tMycKPTL
         xYrx+HILadc3w==
Date:   Thu, 25 May 2023 17:47:55 -0700
Subject: [PATCH 4/7] xfs: teach xfile to pass back direct-map pages to caller
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     djwong@kernel.org
Cc:     Kent Overstreet <kent.overstreet@linux.dev>,
        linux-xfs@vger.kernel.org, willy@infradead.org,
        linux-fsdevel@vger.kernel.org
Message-ID: <168506056512.3729324.14029770819508141928.stgit@frogsfrogsfrogs>
In-Reply-To: <168506056447.3729324.13624212283929857624.stgit@frogsfrogsfrogs>
References: <168506056447.3729324.13624212283929857624.stgit@frogsfrogsfrogs>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Darrick J. Wong <djwong@kernel.org>

Certain xfile array operations (such as sorting) can be sped up quite a
bit by allowing xfile users to grab a page to bulk-read the records
contained within it.  Create helper methods to facilitate this.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 fs/xfs/scrub/trace.h |    2 +
 fs/xfs/scrub/xfile.c |  108 ++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/xfs/scrub/xfile.h |   10 +++++
 3 files changed, 120 insertions(+)


diff --git a/fs/xfs/scrub/trace.h b/fs/xfs/scrub/trace.h
index 11c8b82a174e..cf210681d028 100644
--- a/fs/xfs/scrub/trace.h
+++ b/fs/xfs/scrub/trace.h
@@ -823,6 +823,8 @@ DEFINE_EVENT(xfile_class, name, \
 DEFINE_XFILE_EVENT(xfile_pread);
 DEFINE_XFILE_EVENT(xfile_pwrite);
 DEFINE_XFILE_EVENT(xfile_seek_data);
+DEFINE_XFILE_EVENT(xfile_get_page);
+DEFINE_XFILE_EVENT(xfile_put_page);
 
 TRACE_EVENT(xfarray_create,
 	TP_PROTO(struct xfarray *xfa, unsigned long long required_capacity),
diff --git a/fs/xfs/scrub/xfile.c b/fs/xfs/scrub/xfile.c
index e1125a3e39eb..d3e678cd4a2f 100644
--- a/fs/xfs/scrub/xfile.c
+++ b/fs/xfs/scrub/xfile.c
@@ -323,3 +323,111 @@ xfile_stat(
 	statbuf->bytes = ks.blocks << SECTOR_SHIFT;
 	return 0;
 }
+
+/*
+ * Grab the (locked) page for a memory object.  The object cannot span a page
+ * boundary.  Returns 0 (and a locked page) if successful, -ENOTBLK if we
+ * cannot grab the page, or the usual negative errno.
+ */
+int
+xfile_get_page(
+	struct xfile		*xf,
+	loff_t			pos,
+	unsigned int		len,
+	struct xfile_page	*xfpage)
+{
+	struct inode		*inode = file_inode(xf->file);
+	struct address_space	*mapping = inode->i_mapping;
+	const struct address_space_operations *aops = mapping->a_ops;
+	struct page		*page = NULL;
+	void			*fsdata = NULL;
+	loff_t			key = round_down(pos, PAGE_SIZE);
+	unsigned int		pflags;
+	int			error;
+
+	if (inode->i_sb->s_maxbytes - pos < len)
+		return -ENOMEM;
+	if (len > PAGE_SIZE - offset_in_page(pos))
+		return -ENOTBLK;
+
+	trace_xfile_get_page(xf, pos, len);
+
+	pflags = memalloc_nofs_save();
+
+	/*
+	 * We call write_begin directly here to avoid all the freezer
+	 * protection lock-taking that happens in the normal path.  shmem
+	 * doesn't support fs freeze, but lockdep doesn't know that and will
+	 * trip over that.
+	 */
+	error = aops->write_begin(NULL, mapping, key, PAGE_SIZE, &page,
+			&fsdata);
+	if (error)
+		goto out_pflags;
+
+	/* We got the page, so make sure we push out EOF. */
+	if (i_size_read(inode) < pos + len)
+		i_size_write(inode, pos + len);
+
+	/*
+	 * If the page isn't up to date, fill it with zeroes before we hand it
+	 * to the caller and make sure the backing store will hold on to them.
+	 */
+	if (!PageUptodate(page)) {
+		void	*kaddr;
+
+		kaddr = kmap_local_page(page);
+		memset(kaddr, 0, PAGE_SIZE);
+		kunmap_local(kaddr);
+		SetPageUptodate(page);
+	}
+
+	/*
+	 * Mark each page dirty so that the contents are written to some
+	 * backing store when we drop this buffer, and take an extra reference
+	 * to prevent the xfile page from being swapped or removed from the
+	 * page cache by reclaim if the caller unlocks the page.
+	 */
+	set_page_dirty(page);
+	get_page(page);
+
+	xfpage->page = page;
+	xfpage->fsdata = fsdata;
+	xfpage->pos = key;
+out_pflags:
+	memalloc_nofs_restore(pflags);
+	return error;
+}
+
+/*
+ * Release the (locked) page for a memory object.  Returns 0 or a negative
+ * errno.
+ */
+int
+xfile_put_page(
+	struct xfile		*xf,
+	struct xfile_page	*xfpage)
+{
+	struct inode		*inode = file_inode(xf->file);
+	struct address_space	*mapping = inode->i_mapping;
+	const struct address_space_operations *aops = mapping->a_ops;
+	unsigned int		pflags;
+	int			ret;
+
+	trace_xfile_put_page(xf, xfpage->pos, PAGE_SIZE);
+
+	/* Give back the reference that we took in xfile_get_page. */
+	put_page(xfpage->page);
+
+	pflags = memalloc_nofs_save();
+	ret = aops->write_end(NULL, mapping, xfpage->pos, PAGE_SIZE, PAGE_SIZE,
+			xfpage->page, xfpage->fsdata);
+	memalloc_nofs_restore(pflags);
+	memset(xfpage, 0, sizeof(struct xfile_page));
+
+	if (ret < 0)
+		return ret;
+	if (ret != PAGE_SIZE)
+		return -EIO;
+	return 0;
+}
diff --git a/fs/xfs/scrub/xfile.h b/fs/xfs/scrub/xfile.h
index f91c90efd04a..d08a202f3882 100644
--- a/fs/xfs/scrub/xfile.h
+++ b/fs/xfs/scrub/xfile.h
@@ -6,6 +6,12 @@
 #ifndef __XFS_SCRUB_XFILE_H__
 #define __XFS_SCRUB_XFILE_H__
 
+struct xfile_page {
+	struct page		*page;
+	void			*fsdata;
+	loff_t			pos;
+};
+
 struct xfile {
 	struct file		*file;
 };
@@ -55,4 +61,8 @@ struct xfile_stat {
 
 int xfile_stat(struct xfile *xf, struct xfile_stat *statbuf);
 
+int xfile_get_page(struct xfile *xf, loff_t offset, unsigned int len,
+		struct xfile_page *xbuf);
+int xfile_put_page(struct xfile *xf, struct xfile_page *xbuf);
+
 #endif /* __XFS_SCRUB_XFILE_H__ */

