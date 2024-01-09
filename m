Return-Path: <linux-fsdevel+bounces-7603-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 52FDF8284E3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jan 2024 12:24:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D997E1F235F5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jan 2024 11:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 621003A1AE;
	Tue,  9 Jan 2024 11:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GSLAF2Mb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7028939FC9
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Jan 2024 11:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704799269;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z0xNWJpdRPanEuZiAQenKRA87zeZrifRwyW7XU8kxYA=;
	b=GSLAF2MbCg3mWsy3PLKVMHxZGHi341HR2h47BeM0ZzIWOjksLKiOP00CIgF1UQF47UTz3g
	bbRS9jRrzv12R9quosdLnoxzqPoDv48RfaCEtEmW/vLMuBqbhXaVIZ358xh6OORZDsMztB
	4z5zSuISx1oNVvzF7883EpYThpn1u4o=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-581-EPXp23K5MHONs8COTGeLaw-1; Tue,
 09 Jan 2024 06:20:58 -0500
X-MC-Unique: EPXp23K5MHONs8COTGeLaw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 357C31C06505;
	Tue,  9 Jan 2024 11:20:57 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.67])
	by smtp.corp.redhat.com (Postfix) with ESMTP id C71151121306;
	Tue,  9 Jan 2024 11:20:53 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
	Jeff Layton <jlayton@kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Dominique Martinet <asmadeus@codewreck.org>
Cc: David Howells <dhowells@redhat.com>,
	Steve French <smfrench@gmail.com>,
	Matthew Wilcox <willy@infradead.org>,
	Marc Dionne <marc.dionne@auristor.com>,
	Paulo Alcantara <pc@manguebit.com>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Tom Talpey <tom@talpey.com>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Ilya Dryomov <idryomov@gmail.com>,
	linux-cachefs@redhat.com,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-erofs@lists.ozlabs.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Simon Horman <horms@kernel.org>,
	kernel test robot <lkp@intel.com>,
	Yiqun Leng <yqleng@linux.alibaba.com>,
	Jia Zhu <zhujia.zj@bytedance.com>
Subject: [PATCH 5/6] cachefiles: Fix signed/unsigned mixup
Date: Tue,  9 Jan 2024 11:20:22 +0000
Message-ID: <20240109112029.1572463-6-dhowells@redhat.com>
In-Reply-To: <20240109112029.1572463-1-dhowells@redhat.com>
References: <20240109112029.1572463-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

In __cachefiles_prepare_write(), the start and pos variables were made
unsigned 64-bit so that the casts in the checking could be got rid of -
which should be fine since absolute file offsets can't be negative, except
that an error code may be obtained from vfs_llseek(), which *would* be
negative.  This breaks the error check.

Fix this for now by reverting pos and start to be signed and putting back
the casts.  Unfortunately, the error value checks cannot be replaced with
IS_ERR_VALUE() as long might be 32-bits.

Fixes: 7097c96411d2 ("cachefiles: Fix __cachefiles_prepare_write()")
Reported-by: Simon Horman <horms@kernel.org>
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202401071152.DbKqMQMu-lkp@intel.com/
Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Simon Horman <horms@kernel.org>
cc: Gao Xiang <hsiangkao@linux.alibaba.com>
cc: Yiqun Leng <yqleng@linux.alibaba.com>
cc: Jia Zhu <zhujia.zj@bytedance.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: linux-cachefs@redhat.com
cc: linux-erofs@lists.ozlabs.org
cc: linux-fsdevel@vger.kernel.org
cc: linux-mm@kvack.org
---
 fs/cachefiles/io.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/cachefiles/io.c b/fs/cachefiles/io.c
index 3eec26967437..9a2cb2868e90 100644
--- a/fs/cachefiles/io.c
+++ b/fs/cachefiles/io.c
@@ -522,7 +522,7 @@ int __cachefiles_prepare_write(struct cachefiles_object *object,
 			       bool no_space_allocated_yet)
 {
 	struct cachefiles_cache *cache = object->volume->cache;
-	unsigned long long start = *_start, pos;
+	loff_t start = *_start, pos;
 	size_t len = *_len;
 	int ret;
 
@@ -556,7 +556,7 @@ int __cachefiles_prepare_write(struct cachefiles_object *object,
 					  cachefiles_trace_seek_error);
 		return pos;
 	}
-	if (pos >= start + *_len)
+	if ((u64)pos >= (u64)start + *_len)
 		goto check_space; /* Unallocated region */
 
 	/* We have a block that's at least partially filled - if we're low on
@@ -575,7 +575,7 @@ int __cachefiles_prepare_write(struct cachefiles_object *object,
 					  cachefiles_trace_seek_error);
 		return pos;
 	}
-	if (pos >= start + *_len)
+	if ((u64)pos >= (u64)start + *_len)
 		return 0; /* Fully allocated */
 
 	/* Partially allocated, but insufficient space: cull. */


