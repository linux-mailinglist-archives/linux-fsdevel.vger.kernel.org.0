Return-Path: <linux-fsdevel+bounces-6788-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D29481CA76
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Dec 2023 14:03:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F7B71C21848
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Dec 2023 13:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BF811C6A5;
	Fri, 22 Dec 2023 13:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E6C8iK+F"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2BEA18C20
	for <linux-fsdevel@vger.kernel.org>; Fri, 22 Dec 2023 13:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703250137;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2kygMq0mAMv991cW3YZ7Hd3ppnOgYBjhmi7vw/LesYI=;
	b=E6C8iK+FZQD2y6A/TCvV9qF8wUFAKXk4DdPN0c1gZ4Dp5h62S6ciqJ2/YaXvNF1w9z229r
	U5+7iPpBhDvMVpFErAx8sV8kTnpqrHK77cflxIb5+wZnDLT1enQueD7uGFKC5qtDUpcLsK
	gCOO5VchGxs+juFiPBjSfGv5xQmuHKo=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-15--QeBZETQMO6dAe6PTzC6cQ-1; Fri,
 22 Dec 2023 08:02:12 -0500
X-MC-Unique: -QeBZETQMO6dAe6PTzC6cQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5329D386914F;
	Fri, 22 Dec 2023 13:02:11 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.39.195.169])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 82A9251E3;
	Fri, 22 Dec 2023 13:02:07 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20231221132400.1601991-5-dhowells@redhat.com>
References: <20231221132400.1601991-5-dhowells@redhat.com> <20231221132400.1601991-1-dhowells@redhat.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: dhowells@redhat.com, Gao Xiang <xiang@kernel.org>,
    Chao Yu <chao@kernel.org>, Yue Hu <huyue2@coolpad.com>,
    Jeffle Xu <jefflexu@linux.alibaba.com>,
    Steve French <smfrench@gmail.com>,
    Matthew Wilcox <willy@infradead.org>,
    Marc Dionne <marc.dionne@auristor.com>,
    Paulo Alcantara <pc@manguebit.com>,
    Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>,
    Dominique Martinet <asmadeus@codewreck.org>,
    Eric Van Hensbergen <ericvh@kernel.org>,
    Ilya Dryomov <idryomov@gmail.com>,
    Christian Brauner <christian@brauner.io>, linux-cachefs@redhat.com,
    linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org,
    linux-nfs@vger.kernel.org, ceph-devel@vger.kernel.org,
    v9fs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
    linux-mm@kvack.org, netdev@vger.kernel.org,
    linux-kernel@vger.kernel.org, linux-erofs@lists.ozlabs.org
Subject: [PATCH] Fix EROFS Kconfig
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2265064.1703250126.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 22 Dec 2023 13:02:06 +0000
Message-ID: <2265065.1703250126@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

This needs an additional change (see attached).

diff --git a/fs/erofs/Kconfig b/fs/erofs/Kconfig
index 1d318f85232d..1949763e66aa 100644
--- a/fs/erofs/Kconfig
+++ b/fs/erofs/Kconfig
@@ -114,7 +114,8 @@ config EROFS_FS_ZIP_DEFLATE
 =

 config EROFS_FS_ONDEMAND
 	bool "EROFS fscache-based on-demand read support"
-	depends on CACHEFILES_ONDEMAND && (EROFS_FS=3Dm && FSCACHE || EROFS_FS=3D=
y && FSCACHE=3Dy)
+	depends on CACHEFILES_ONDEMAND && FSCACHE && \
+		(EROFS_FS=3Dm && NETFS_SUPPORT || EROFS_FS=3Dy && NETFS_SUPPORT=3Dy)
 	default n
 	help
 	  This permits EROFS to use fscache-backed data blobs with on-demand


