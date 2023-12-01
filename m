Return-Path: <linux-fsdevel+bounces-4527-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90DB980004C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 01:36:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1BD21C20866
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 00:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B2CB1CA8F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 00:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bk+1BZci"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33BC7197
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Nov 2023 16:22:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701390133;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=0zKFElyLnd/c3LCDl+o0d2JWbeCKrzkMuVD1x9/nP0A=;
	b=bk+1BZci6eXLTWjkiy0Kbe4iedziNX4UPQ1e9GNryme+XXIl43sXauXb0pcNj9p5CdrabU
	zPW9PIqs9QTIxgpd7anRaLaYZSH7mPUNmiu39qh6Uy2iPsUUxdlHGHsTFXDiJQt5Gzwl/R
	Ed5vssXVynl8o2qdX/bzu4VJuRVs1iI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-547-xWcjLnFuNKiizn4o9Zd-4Q-1; Thu, 30 Nov 2023 19:22:08 -0500
X-MC-Unique: xWcjLnFuNKiizn4o9Zd-4Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 52A8B811E7B;
	Fri,  1 Dec 2023 00:22:07 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.161])
	by smtp.corp.redhat.com (Postfix) with ESMTP id D2A7740C6EB9;
	Fri,  1 Dec 2023 00:22:05 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Steve French <sfrench@samba.org>
Cc: David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.com>,
	Shyam Prasad N <nspmangalore@gmail.com>,
	Rohith Surabattula <rohiths.msft@gmail.com>,
	Matthew Wilcox <willy@infradead.org>,
	Jeff Layton <jlayton@kernel.org>,
	linux-cifs@vger.kernel.org,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 0/2] cifs: Fixes for copy_file_range() and FICLONE
Date: Fri,  1 Dec 2023 00:21:59 +0000
Message-ID: <20231201002201.2981258-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

Hi Steve,

Here are two patches for cifs:

 (1) Fix copy_file_range() support to handle invalidation and flushing of
     overlapping dirty data correctly, to move the EOF on the server to
     deal with lazy flushing of locally dirty data and to set the i_size
     afterwards if the copy extended the file.

 (2) Fix FICLONE which has the same set of bugs as (1).

I've pushed the patches here also:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=cifs-fixes

David

David Howells (2):
  cifs: Fix flushing, invalidation and file size with copy_file_range()
  cifs: Fix flushing, invalidation and file size with FICLONE

 fs/smb/client/cifsfs.c | 170 +++++++++++++++++++++++++++++++++++++----
 1 file changed, 156 insertions(+), 14 deletions(-)


