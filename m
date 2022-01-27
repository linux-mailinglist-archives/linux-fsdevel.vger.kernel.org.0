Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B6A449E6EA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jan 2022 17:03:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243404AbiA0QDA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Jan 2022 11:03:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:33065 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243435AbiA0QC4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Jan 2022 11:02:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643299375;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vr8MVboMfidaqAf+5kH93+E3eBI6Ub7REUxzQJOQP4A=;
        b=REh4GUJWMTu8j6JoNdVtorA3aWth5ur7Gg/vbQDHmMivn03i7p4zEa1gaa88pjCPaqn7Cl
        pHYmeg/H1Q66cgUFdlEsk5Dbkx71WtpDUkVWBh0tXnEdB0hchO+2/5SkGglFpcgRa+J9Fv
        xspmA1Z6Wa2pzW6qkma41Aoln07VDDo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-336-XlBLsyEkMVeD_6orGR2kKw-1; Thu, 27 Jan 2022 11:02:54 -0500
X-MC-Unique: XlBLsyEkMVeD_6orGR2kKw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1E6DD86A8A4;
        Thu, 27 Jan 2022 16:02:53 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.26])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 26DAA708C7;
        Thu, 27 Jan 2022 16:02:50 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 3/4] netfs,
 cachefiles: Add a method to query presence of data in the cache
From:   David Howells <dhowells@redhat.com>
To:     Steve French <smfrench@gmail.com>
Cc:     linux-cachefs@redhat.com, dhowells@redhat.com,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Jeff Layton <jlayton@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-cifs@vger.kernel.org, linux-cachefs@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 27 Jan 2022 16:02:50 +0000
Message-ID: <164329937029.843658.11237280189554156735.stgit@warthog.procyon.org.uk>
In-Reply-To: <164329930161.843658.7387773437540491743.stgit@warthog.procyon.org.uk>
References: <164329930161.843658.7387773437540491743.stgit@warthog.procyon.org.uk>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a netfs_cache_ops method by which a network filesystem can ask the
cache about what data it has available and where so that it can make a
multipage read more efficient.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: linux-cachefs@redhat.com
---

 Documentation/filesystems/netfs_library.rst |   16 +++++++
 fs/cachefiles/io.c                          |   59 +++++++++++++++++++++++++++
 include/linux/netfs.h                       |    7 +++
 3 files changed, 82 insertions(+)

diff --git a/Documentation/filesystems/netfs_library.rst b/Documentation/filesystems/netfs_library.rst
index 136f8da3d0e2..4f373a8ec47b 100644
--- a/Documentation/filesystems/netfs_library.rst
+++ b/Documentation/filesystems/netfs_library.rst
@@ -462,6 +462,10 @@ operation table looks like the following::
 			     struct iov_iter *iter,
 			     netfs_io_terminated_t term_func,
 			     void *term_func_priv);
+
+		int (*query_occupancy)(struct netfs_cache_resources *cres,
+				       loff_t start, size_t len, size_t granularity,
+				       loff_t *_data_start, size_t *_data_len);
 	};
 
 With a termination handler function pointer::
@@ -536,6 +540,18 @@ The methods defined in the table are:
    indicating whether the termination is definitely happening in the caller's
    context.
 
+ * ``query_occupancy()``
+
+   [Required] Called to find out where the next piece of data is within a
+   particular region of the cache.  The start and length of the region to be
+   queried are passed in, along with the granularity to which the answer needs
+   to be aligned.  The function passes back the start and length of the data,
+   if any, available within that region.  Note that there may be a hole at the
+   front.
+
+   It returns 0 if some data was found, -ENODATA if there was no usable data
+   within the region or -ENOBUFS if there is no caching on this file.
+
 Note that these methods are passed a pointer to the cache resource structure,
 not the read request structure as they could be used in other situations where
 there isn't a read request structure as well, such as writing dirty data to the
diff --git a/fs/cachefiles/io.c b/fs/cachefiles/io.c
index 04eb52736990..753986ea1583 100644
--- a/fs/cachefiles/io.c
+++ b/fs/cachefiles/io.c
@@ -191,6 +191,64 @@ static int cachefiles_read(struct netfs_cache_resources *cres,
 	return ret;
 }
 
+/*
+ * Query the occupancy of the cache in a region, returning where the next chunk
+ * of data starts and how long it is.
+ */
+static int cachefiles_query_occupancy(struct netfs_cache_resources *cres,
+				      loff_t start, size_t len, size_t granularity,
+				      loff_t *_data_start, size_t *_data_len)
+{
+	struct cachefiles_object *object;
+	struct file *file;
+	loff_t off, off2;
+
+	*_data_start = -1;
+	*_data_len = 0;
+
+	if (!fscache_wait_for_operation(cres, FSCACHE_WANT_READ))
+		return -ENOBUFS;
+
+	object = cachefiles_cres_object(cres);
+	file = cachefiles_cres_file(cres);
+	granularity = max_t(size_t, object->volume->cache->bsize, granularity);
+
+	_enter("%pD,%li,%llx,%zx/%llx",
+	       file, file_inode(file)->i_ino, start, len,
+	       i_size_read(file_inode(file)));
+
+	off = cachefiles_inject_read_error();
+	if (off == 0)
+		off = vfs_llseek(file, start, SEEK_DATA);
+	if (off == -ENXIO)
+		return -ENODATA; /* Beyond EOF */
+	if (off < 0 && off >= (loff_t)-MAX_ERRNO)
+		return -ENOBUFS; /* Error. */
+	if (round_up(off, granularity) >= start + len)
+		return -ENODATA; /* No data in range */
+
+	off2 = cachefiles_inject_read_error();
+	if (off2 == 0)
+		off2 = vfs_llseek(file, off, SEEK_HOLE);
+	if (off2 == -ENXIO)
+		return -ENODATA; /* Beyond EOF */
+	if (off2 < 0 && off2 >= (loff_t)-MAX_ERRNO)
+		return -ENOBUFS; /* Error. */
+
+	/* Round away partial blocks */
+	off = round_up(off, granularity);
+	off2 = round_down(off2, granularity);
+	if (off2 <= off)
+		return -ENODATA;
+
+	*_data_start = off;
+	if (off2 > start + len)
+		*_data_len = len;
+	else
+		*_data_len = off2 - off;
+	return 0;
+}
+
 /*
  * Handle completion of a write to the cache.
  */
@@ -545,6 +603,7 @@ static const struct netfs_cache_ops cachefiles_netfs_cache_ops = {
 	.write			= cachefiles_write,
 	.prepare_read		= cachefiles_prepare_read,
 	.prepare_write		= cachefiles_prepare_write,
+	.query_occupancy	= cachefiles_query_occupancy,
 };
 
 /*
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index b46c39d98bbd..614f22213e21 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -244,6 +244,13 @@ struct netfs_cache_ops {
 	int (*prepare_write)(struct netfs_cache_resources *cres,
 			     loff_t *_start, size_t *_len, loff_t i_size,
 			     bool no_space_allocated_yet);
+
+	/* Query the occupancy of the cache in a region, returning where the
+	 * next chunk of data starts and how long it is.
+	 */
+	int (*query_occupancy)(struct netfs_cache_resources *cres,
+			       loff_t start, size_t len, size_t granularity,
+			       loff_t *_data_start, size_t *_data_len);
 };
 
 struct readahead_control;


