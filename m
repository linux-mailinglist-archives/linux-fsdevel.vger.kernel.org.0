Return-Path: <linux-fsdevel+bounces-4231-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F8947FDF79
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 19:42:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA787B20B10
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 18:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7128A5DF0A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 18:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PDn1bH1b"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10A21BC
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Nov 2023 08:56:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701276990;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=mwPpdhlYYaHD0bYeEis0CU8df9ASTS3wuKo9KB9sGXI=;
	b=PDn1bH1bN0Tlwi8UVxl27x/26iAkhSoYl2xgql4kQed/MTxAxJK/YlH/OEKlqSdZCvrJkX
	lzGmwJGu1Dkxrl3QO8ySctLJhZsRmxSu1G8l/xX+l7CVVHCiWY4PNxkFQvnX6k3AflB1YQ
	y5Pq2ukqYe2EKam0HH+V+tJvEohcV/I=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-15-LUmdmRd7NrCAEP8vXLpuJw-1; Wed, 29 Nov 2023 11:56:24 -0500
X-MC-Unique: LUmdmRd7NrCAEP8vXLpuJw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 16518185A794;
	Wed, 29 Nov 2023 16:56:24 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.161])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 9A1C51C060BB;
	Wed, 29 Nov 2023 16:56:22 +0000 (UTC)
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
Subject: [PATCH 0/3] cifs: Fixes for copy_file_range() and FALLOC_FL_INSERT/ZERO_RANGE
Date: Wed, 29 Nov 2023 16:56:16 +0000
Message-ID: <20231129165619.2339490-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

Hi Steve,

Here are three patches for cifs:

 (1) Fix FALLOC_FL_ZERO_RANGE support to change i_size if the file is
     extended.

 (2) Fix FALLOC_FL_INSERT_RANGE support to change i_size after it moves the
     EOF on the server.

 (3) Fix copy_file_range() support to handle invalidation and flushing of
     overlapping dirty data correctly, to move the EOF on the server to
     deal with lazy flushing of locally dirty data and to set the i_size
     afterwards if the copy extended the file.

I've pushed the patches here also:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=cifs-fixes

David

David Howells (3):
  cifs: Fix FALLOC_FL_ZERO_RANGE by setting i_size if EOF moved
  cifs: Fix FALLOC_FL_INSERT_RANGE by setting i_size after EOF moved
  cifs: Fix flushing, invalidation and file size with copy_file_range()

 fs/smb/client/cifsfs.c  | 80 +++++++++++++++++++++++++++++++++++++++--
 fs/smb/client/smb2ops.c | 13 +++++--
 2 files changed, 88 insertions(+), 5 deletions(-)


