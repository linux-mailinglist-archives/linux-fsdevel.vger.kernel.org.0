Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3280B3EAECB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Aug 2021 05:10:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234370AbhHMDLH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Aug 2021 23:11:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233065AbhHMDLG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Aug 2021 23:11:06 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08536C061756;
        Thu, 12 Aug 2021 20:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=gZcz0sPokS3rjSwIc/zbOFKv7/ggHbMI5Tcke621bHQ=; b=sIsJf+EBhnIakLEGIBAOM6pre9
        ljVp9tIHnCmKf/jmtoM2VFszcC9hOrgR0zproHC7teEkzt/ew4geDzo3odzyOe9gIKcsI7uHXYalt
        KNvBaef0y9twR1FFUfYkBWWjgAx0645SJx82dTj+1Odrx3AeFk7YSCQyNaJIyg4kaBBfJFGikS/lP
        n1DXpPU/1TaQgQpjFdCWAxw91Ny6FjTbYP8oFDMNreOCjU0o0pZqNAhWu8sBAndXKNEnwI85wofRQ
        7fWSOWIQv7kDKvMz31aKVxt4QIVmtwkugkruKAxcMHfg7YCZOyR75AXcZRN42ooKeQQSVmHshpc7M
        I3jieDhQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mENZj-00FG6Z-Rk; Fri, 13 Aug 2021 03:09:53 +0000
Date:   Fri, 13 Aug 2021 04:09:39 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        Trond Myklebust <trond.myklebust@primarydata.com>,
        linux-nfs@vger.kernel.org, viro@zeniv.linux.org.uk,
        jlayton@kernel.org, sfrench@samba.org,
        torvalds@linux-foundation.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 1/5] nfs: Fix write to swapfile failure due to
 generic_write_checks()
Message-ID: <YRXicziD5Jy74PZj@casper.infradead.org>
References: <162879971699.3306668.8977537647318498651.stgit@warthog.procyon.org.uk>
 <162879972678.3306668.10709543333474121000.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <162879972678.3306668.10709543333474121000.stgit@warthog.procyon.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 12, 2021 at 09:22:06PM +0100, David Howells wrote:
> Trying to use a swapfile on NFS results in every DIO write failing with
> ETXTBSY because generic_write_checks(), as called by nfs_direct_write()
> from nfs_direct_IO(), forbids writes to swapfiles.

Why does nfs_direct_write() call generic_write_checks()?

ie call generic_write_checks() earlier, and only swap would bypass them.

diff --git a/fs/nfs/direct.c b/fs/nfs/direct.c
index 2e894fec036b..7e2ca6b5fc5f 100644
--- a/fs/nfs/direct.c
+++ b/fs/nfs/direct.c
@@ -905,9 +905,6 @@ ssize_t nfs_file_direct_write(struct kiocb *iocb, struct iov_iter *iter)
 	dfprintk(FILE, "NFS: direct write(%pD2, %zd@%Ld)\n",
 		file, iov_iter_count(iter), (long long) iocb->ki_pos);
 
-	result = generic_write_checks(iocb, iter);
-	if (result <= 0)
-		return result;
 	count = result;
 	nfs_add_stats(mapping->host, NFSIOS_DIRECTWRITTENBYTES, count);
 
diff --git a/fs/nfs/file.c b/fs/nfs/file.c
index 1fef107961bc..91b2e3214836 100644
--- a/fs/nfs/file.c
+++ b/fs/nfs/file.c
@@ -611,6 +611,10 @@ ssize_t nfs_file_write(struct kiocb *iocb, struct iov_iter *from)
 	errseq_t since;
 	int error;
 
+	result = generic_write_checks(iocb, from);
+	if (result < 0)
+		return result;
+
 	result = nfs_key_timeout_notify(file, inode);
 	if (result)
 		return result;
@@ -621,8 +625,6 @@ ssize_t nfs_file_write(struct kiocb *iocb, struct iov_iter *from)
 	dprintk("NFS: write(%pD2, %zu@%Ld)\n",
 		file, iov_iter_count(from), (long long) iocb->ki_pos);
 
-	if (IS_SWAPFILE(inode))
-		goto out_swapfile;
 	/*
 	 * O_APPEND implies that we must revalidate the file length.
 	 */
@@ -636,7 +638,6 @@ ssize_t nfs_file_write(struct kiocb *iocb, struct iov_iter *from)
 
 	since = filemap_sample_wb_err(file->f_mapping);
 	nfs_start_io_write(inode);
-	result = generic_write_checks(iocb, from);
 	if (result > 0) {
 		current->backing_dev_info = inode_to_bdi(inode);
 		result = generic_perform_write(file, from, iocb->ki_pos);
@@ -677,10 +678,6 @@ ssize_t nfs_file_write(struct kiocb *iocb, struct iov_iter *from)
 	nfs_add_stats(inode, NFSIOS_NORMALWRITTENBYTES, written);
 out:
 	return result;
-
-out_swapfile:
-	printk(KERN_INFO "NFS: attempt to write to active swap file!\n");
-	return -ETXTBSY;
 }
 EXPORT_SYMBOL_GPL(nfs_file_write);
 
