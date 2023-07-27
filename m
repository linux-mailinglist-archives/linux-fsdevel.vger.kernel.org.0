Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAC0D765F60
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jul 2023 00:26:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231910AbjG0W0Z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Jul 2023 18:26:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231161AbjG0W0Y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Jul 2023 18:26:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F8E9F0;
        Thu, 27 Jul 2023 15:26:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2CAC161F57;
        Thu, 27 Jul 2023 22:26:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B3A8C433C8;
        Thu, 27 Jul 2023 22:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690496782;
        bh=UzwAVXbMWr5JTX/opul0wx09viU+StUKnkzR+uAL2o8=;
        h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
        b=AtBuc3tnPKbwPCnzmGMj+yIBVQwGI6dHk4M/pHtluI4O+SmxmJTwvl0FUoi2JCqZ3
         R6TR52zpuPO+SGgCIgMQE0bMwyJ2BQDWbcxC66o08wm7qCvns2nVfKOYSsKHUMc5zb
         xoq38hB1r9Urid9TDcmd0EaiOrX0xy6jQKOM3wdMf1jAv9BG81HrfLqtzPlSO91IiD
         Z7YFg0C6II/RJwytKlxn5KsPQvxpgeuj10B+0bLG5C9YtsDyTZjtFtDx1jnGNuZ4Cs
         LNEQhGb3/yvuYO9oIV1uDkFnY73RJjVveWAyEddw4riGM1GW/z9+tgLua8/Ezm5uUD
         SbonDfG8lyuQw==
Date:   Thu, 27 Jul 2023 15:26:22 -0700
Subject: [PATCH 4/7] xfs: teach xfile to pass back direct-map pages to caller
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     djwong@kernel.org
Cc:     Kent Overstreet <kent.overstreet@linux.dev>,
        Dave Chinner <dchinner@redhat.com>, linux-xfs@vger.kernel.org,
        willy@infradead.org, linux-fsdevel@vger.kernel.org
Message-ID: <169049623629.921478.14096108643276749973.stgit@frogsfrogsfrogs>
In-Reply-To: <169049623563.921478.13811535720302490179.stgit@frogsfrogsfrogs>
References: <169049623563.921478.13811535720302490179.stgit@frogsfrogsfrogs>
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

Certain xfile array operations (such as sorting) can be sped up quite a
bit by allowing xfile users to grab a page to bulk-read the records
contained within it.  Create helper methods to facilitate this.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Kent Overstreet <kent.overstreet@linux.dev>
Reviewed-by: Dave Chinner <dchinner@redhat.com>
---
 fs/xfs/scrub/trace.h |    2 +
 fs/xfs/scrub/xfile.c |  108 ++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/xfs/scrub/xfile.h |   10 +++++
 3 files changed, 120 insertions(+)


diff --git a/fs/xfs/scrub/trace.h b/fs/xfs/scrub/trace.h
index 1c9a31dc4e223..f8c814e07587f 100644
--- a/fs/xfs/scrub/trace.h
+++ b/fs/xfs/scrub/trace.h
@@ -821,6 +821,8 @@ DEFINE_EVENT(xfile_class, name, \
 DEFINE_XFILE_EVENT(xfile_pread);
 DEFINE_XFILE_EVENT(xfile_pwrite);
 DEFINE_XFILE_EVENT(xfile_seek_data);
+DEFINE_XFILE_EVENT(xfile_get_page);
+DEFINE_XFILE_EVENT(xfile_put_page);
 
 TRACE_EVENT(xfarray_create,
 	TP_PROTO(struct xfarray *xfa, unsigned long long required_capacity),
diff --git a/fs/xfs/scrub/xfile.c b/fs/xfs/scrub/xfile.c
index 19d512887980f..d98e8e77c684f 100644
--- a/fs/xfs/scrub/xfile.c
+++ b/fs/xfs/scrub/xfile.c
@@ -310,3 +310,111 @@ xfile_stat(
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
index 9328a37fedaa3..7065abd97a9a9 100644
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
@@ -54,4 +60,8 @@ struct xfile_stat {
 
 int xfile_stat(struct xfile *xf, struct xfile_stat *statbuf);
 
+int xfile_get_page(struct xfile *xf, loff_t offset, unsigned int len,
+		struct xfile_page *xbuf);
+int xfile_put_page(struct xfile *xf, struct xfile_page *xbuf);
+
 #endif /* __XFS_SCRUB_XFILE_H__ */

