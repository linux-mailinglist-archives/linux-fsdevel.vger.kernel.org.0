Return-Path: <linux-fsdevel+bounces-63813-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78D8EBCEA20
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Oct 2025 23:43:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3A924268DE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Oct 2025 21:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00D1D303A32;
	Fri, 10 Oct 2025 21:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KLTQY8zG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78AED303C96
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Oct 2025 21:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760132553; cv=none; b=Ce5AzteW+Hhcip+NI9250CgWU43Z6ExlJKq+ruW2AZg9yiUc+m/OptByUKdkz9qNcZMeLLF4RoN6dGyF90MHEbzwW3m6h8Ur/OtY6ZYAZpKdMiwqdKhqgjSNJfhJxj5USDnJCQHSumegBNNxwg57rUDynXn4qyaUUU5R9ZHV0m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760132553; c=relaxed/simple;
	bh=50iMg4cjhPiTK7ZC9StdXLuoYu4mQzjFec4yy2wlFUk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rKIUcNsuD64ELJph+KdCnHzAwwWOLL1/c9kaFpWnd+afh8Du4vETvVvtaTawt4Pr3KUfcf9ODbyLBk6PzJtVOKi+g8wz0+nQIi3hwi6u1ZfkoEhY4qBrrju5To7CxqQgPTC3qnKi5Y/vxkC3rijjDk4oHW7c6I4RqJsroivxO2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KLTQY8zG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760132550;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZPCYbFFACQ3Rv/ZhYJDcxm0pSUm0LvajwjZxksg70Jk=;
	b=KLTQY8zGOT+e/iEGb0hmSD6U5BU9N/Dw6WWx99GPYcPT8DugznuAZAKRwUqs2xJPbhZlDN
	9GPphEof1iYH9UGRv3HDM3eULBUX4BoXaTyE0mjfb7AMS0aU+9T2k8GcJaekyrxpQN/TmQ
	ox8Uf/ytXB416zrnvRDsf6ih1kBprLo=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-T2UBPlNLPlyowGdb7YGAYw-1; Fri, 10 Oct 2025 17:42:29 -0400
X-MC-Unique: T2UBPlNLPlyowGdb7YGAYw-1
X-Mimecast-MFC-AGG-ID: T2UBPlNLPlyowGdb7YGAYw_1760132548
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-42e71d1a064so88171945ab.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Oct 2025 14:42:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760132548; x=1760737348;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZPCYbFFACQ3Rv/ZhYJDcxm0pSUm0LvajwjZxksg70Jk=;
        b=tmfptLRuxJFtclP9WoVf4nLNWif3s7SZKNsJEk8mWx1twf9/FPGldXfEmmrgfNIlWX
         gSkj4H/3FCnV8CjkvsJmI33MtWhCVeqTXUEyOL1PvfLfN0GF5i63wKHT0DbuQP450UZ3
         ZM8XHslUoQeL33LqN8pr/DHxDP5jtgOOdFbXzA3257l10lVK3vDbnHZlptbZkxwtyIKr
         P439UWdIUcoHaXL07t34uZoAxkjQep+GTQ4enAvpDyOXLXq1MgeLNBc7GWBANH8/ps4G
         /NVCuyEzZvQ+0ocfWbcq/Ezo7tCvbX85Z3zKKRHDOQdopbRu2COdYEphKAS60y+Z2m/N
         GC+Q==
X-Gm-Message-State: AOJu0Yy+wPfC3hHqpQzhnlkqwXnKAO3ibr3x/2T3kv/rnmPSCiW1HsTA
	g0G+Nj1ZwPSVYyXJXpk2ymZ+TIj9LtN+Q9VL57N5JJhd0IDVNc6UekgBCpAymoUJVG2y2jvI2ft
	Ule3VJkCNIFIfGJpVmP6FITA6R0ORYVR5WQMDHGWlYedrGe12aujeAB4stDmq+pRRPqg=
X-Gm-Gg: ASbGncuSy7oapdh61sK13CRS/oYjSo4PRlbyxd5VNnsquf5tKcVbGmt9RtkJGrQLwpG
	DuLvq62GiiNrmflYddtVpiRbmjycnhmcimhcO4TVmTOmEoSd3+n/iQkYR2y8Bq6LOtbrJw/MLDo
	NAGPljlV/b8myGzykOzZI+fn6tjuRPfzkD9JxWzL/0+qddCimROosvvP2kyHwTCYO+ZdqVMg5IH
	iMJDVtkrx+UH0qPMZHuwwmbTK3jbnNOoOT1CPAknCZ7kF4xMsXOgcBZUrPVs8tOFYQG9fvWyk7N
	SqYaPzUbDzafZVar72dahdsq1ShMvAFRH0dfrANKu2lB9NH7VBvTUFc=
X-Received: by 2002:a05:6e02:178b:b0:425:744b:52d3 with SMTP id e9e14a558f8ab-42f87380d9dmr144056235ab.11.1760132547993;
        Fri, 10 Oct 2025 14:42:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGN9W2IC/SA0+yMXYj+bexcHnyhvZRXEQnWhjpte5lw9OnE4asaSu6KQ3Uaia/qiH+7I5ocnw==
X-Received: by 2002:a05:6e02:178b:b0:425:744b:52d3 with SMTP id e9e14a558f8ab-42f87380d9dmr144055155ab.11.1760132547477;
        Fri, 10 Oct 2025 14:42:27 -0700 (PDT)
Received: from big24.xxmyappdomainxx.com ([79.127.136.56])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-42f9027855bsm24382895ab.11.2025.10.10.14.42.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 14:42:27 -0700 (PDT)
From: Eric Sandeen <sandeen@redhat.com>
To: v9fs@lists.linux.dev
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ericvh@kernel.org,
	lucho@ionkov.net,
	asmadeus@codewreck.org,
	linux_oss@crudebyte.com,
	eadavis@qq.com,
	Eric Sandeen <sandeen@redhat.com>
Subject: [PATCH V3 3/4] 9p: create a v9fs_context structure to hold parsed options
Date: Fri, 10 Oct 2025 16:36:18 -0500
Message-ID: <20251010214222.1347785-4-sandeen@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251010214222.1347785-1-sandeen@redhat.com>
References: <20251010214222.1347785-1-sandeen@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch creates a new v9fs_context structure which includes
new p9_session_opts and p9_client_opts structures, as well as
re-using the existing p9_fd_opts and p9_rdma_opts to store options
during parsing. The new structure will be used in the next
commit to pass all parsed options to the appropriate transports.

Signed-off-by: Eric Sandeen <sandeen@redhat.com>
---
 include/net/9p/client.h    | 90 ++++++++++++++++++++++++++++++++++++++
 include/net/9p/transport.h | 32 --------------
 2 files changed, 90 insertions(+), 32 deletions(-)

diff --git a/include/net/9p/client.h b/include/net/9p/client.h
index 2d46f8017bd5..cc18443f7d51 100644
--- a/include/net/9p/client.h
+++ b/include/net/9p/client.h
@@ -132,6 +132,96 @@ struct p9_client {
 	char name[__NEW_UTS_LEN + 1];
 };
 
+/**
+ * struct p9_fd_opts - holds client options during parsing
+ * @msize: maximum data size negotiated by protocol
+ * @prot-Oversion: 9P protocol version to use
+ * @trans_mod: module API instantiated with this client
+ *
+ * These parsed options get transferred into client in
+ * apply_client_options()
+ */
+struct p9_client_opts {
+	unsigned int msize;
+	unsigned char proto_version;
+	struct p9_trans_module *trans_mod;
+};
+
+/**
+ * struct p9_fd_opts - per-transport options for fd transport
+ * @rfd: file descriptor for reading (trans=fd)
+ * @wfd: file descriptor for writing (trans=fd)
+ * @port: port to connect to (trans=tcp)
+ * @privport: port is privileged
+ */
+struct p9_fd_opts {
+	int rfd;
+	int wfd;
+	u16 port;
+	bool privport;
+};
+
+/**
+ * struct p9_rdma_opts - Collection of mount options for rdma transport
+ * @port: port of connection
+ * @privport: Whether a privileged port may be used
+ * @sq_depth: The requested depth of the SQ. This really doesn't need
+ * to be any deeper than the number of threads used in the client
+ * @rq_depth: The depth of the RQ. Should be greater than or equal to SQ depth
+ * @timeout: Time to wait in msecs for CM events
+ */
+struct p9_rdma_opts {
+	short port;
+	bool privport;
+	int sq_depth;
+	int rq_depth;
+	long timeout;
+};
+
+/**
+ * struct p9_session_opts - holds parsed options for v9fs_session_info
+ * @flags: session options of type &p9_session_flags
+ * @nodev: set to 1 to disable device mapping
+ * @debug: debug level
+ * @afid: authentication handle
+ * @cache: cache mode of type &p9_cache_bits
+ * @cachetag: the tag of the cache associated with this session
+ * @uname: string user name to mount hierarchy as
+ * @aname: mount specifier for remote hierarchy
+ * @dfltuid: default numeric userid to mount hierarchy as
+ * @dfltgid: default numeric groupid to mount hierarchy as
+ * @uid: if %V9FS_ACCESS_SINGLE, the numeric uid which mounted the hierarchy
+ * @session_lock_timeout: retry interval for blocking locks
+ *
+ * This strucure holds options which are parsed and will be transferred
+ * to the v9fs_session_info structure when mounted, and therefore largely
+ * duplicates struct v9fs_session_info.
+ */
+struct p9_session_opts {
+	unsigned int flags;
+	unsigned char nodev;
+	unsigned short debug;
+	unsigned int afid;
+	unsigned int cache;
+#ifdef CONFIG_9P_FSCACHE
+	char *cachetag;
+#endif
+	char *uname;
+	char *aname;
+	kuid_t dfltuid;
+	kgid_t dfltgid;
+	kuid_t uid;
+	long session_lock_timeout;
+};
+
+/* Used by mount API to store parsed mount options */
+struct v9fs_context {
+	struct p9_client_opts	client_opts;
+	struct p9_fd_opts	fd_opts;
+	struct p9_rdma_opts	rdma_opts;
+	struct p9_session_opts	session_opts;
+};
+
 /**
  * struct p9_fid - file system entity handle
  * @clnt: back pointer to instantiating &p9_client
diff --git a/include/net/9p/transport.h b/include/net/9p/transport.h
index 88702953b1ef..ebbb4b50ee20 100644
--- a/include/net/9p/transport.h
+++ b/include/net/9p/transport.h
@@ -21,38 +21,6 @@
 #define P9_RDMA_RQ_DEPTH	32
 #define P9_RDMA_TIMEOUT		30000		/* 30 seconds */
 
-/**
- * struct p9_fd_opts - per-transport options for fd transport
- * @rfd: file descriptor for reading (trans=fd)
- * @wfd: file descriptor for writing (trans=fd)
- * @port: port to connect to (trans=tcp)
- * @privport: port is privileged
- */
-
-struct p9_fd_opts {
-	int rfd;
-	int wfd;
-	u16 port;
-	bool privport;
-};
-
-/**
- * struct p9_rdma_opts - Collection of mount options for rdma transport
- * @port: port of connection
- * @privport: Whether a privileged port may be used
- * @sq_depth: The requested depth of the SQ. This really doesn't need
- * to be any deeper than the number of threads used in the client
- * @rq_depth: The depth of the RQ. Should be greater than or equal to SQ depth
- * @timeout: Time to wait in msecs for CM events
- */
-struct p9_rdma_opts {
-	short port;
-	bool privport;
-	int sq_depth;
-	int rq_depth;
-	long timeout;
-};
-
 /**
  * struct p9_trans_module - transport module interface
  * @list: used to maintain a list of currently available transports
-- 
2.51.0


