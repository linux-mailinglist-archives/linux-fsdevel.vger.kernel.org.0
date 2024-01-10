Return-Path: <linux-fsdevel+bounces-7691-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F835829633
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jan 2024 10:22:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A727286B42
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jan 2024 09:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF8AB3F8FF;
	Wed, 10 Jan 2024 09:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Dg3kbq00"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A1D3F8D2;
	Wed, 10 Jan 2024 09:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=SRlTQ4JibYJcOmgh50kWG725LphAqsA74nKJKgMAVp4=; b=Dg3kbq00hAKG9Jac9pBCT8H0hY
	gQ8Pe7mzKNIEig0gdVS8L1YQm0lhILIpgErWpRQQhhUxLv9H0RVqQ3mwJIZgCK71qmej5Pzo80Gdc
	esoiR5D75fIZEZkE2YGIQ0nRjdBJgj5NgoZ0u6hyM5l308ERxwn5zQS37wJOuDp3WVhw9DmbPux0P
	jbkJFK7k3ROEFnFSjfok+rePV67Oo3t8DURPYH89imUH1WfUTjQEQmy1GSAcXWYC8OlDc8YzNDXUE
	PvxJ1Yxm5WtS8mPmLMaHV4I181FWwxPbMxc4CbckfiLDECitlWA61LzaC24kAJ/8WbYHany1t520v
	wVR5xXoQ==;
Received: from [2001:4bb8:191:2f6b:27f:45ef:e74a:3466] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rNUly-00AsAw-0n;
	Wed, 10 Jan 2024 09:21:18 +0000
From: Christoph Hellwig <hch@lst.de>
To: Matthew Wilcox <willy@infradead.org>,
	Hugh Dickins <hughd@google.com>,
	Chandan Babu R <chandan.babu@oracle.com>
Cc: "Darrick J . Wong" <djwong@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Howells <dhowells@redhat.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Christian Koenig <christian.koenig@amd.com>,
	Huang Rui <ray.huang@amd.com>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
	intel-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	x86@kernel.org,
	linux-sgx@vger.kernel.org,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	keyrings@vger.kernel.org
Subject: [PATCH 2/2] xfs: disable large folio support in xfile_create
Date: Wed, 10 Jan 2024 10:21:09 +0100
Message-Id: <20240110092109.1950011-3-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240110092109.1950011-1-hch@lst.de>
References: <20240110092109.1950011-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

The xfarray code will crash if large folios are force enabled using:

   echo force > /sys/kernel/mm/transparent_hugepage/shmem_enabled

Fixing this will require a bit of an API change, and prefeably sorting out
the hwpoison story for pages vs folio and where it is placed in the shmem
API.  For now use this one liner to disable large folios.

Reported-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/xfs/scrub/xfile.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/xfs/scrub/xfile.c b/fs/xfs/scrub/xfile.c
index 090c3ead43fdf1..1a8d1bedd0b0dc 100644
--- a/fs/xfs/scrub/xfile.c
+++ b/fs/xfs/scrub/xfile.c
@@ -94,6 +94,11 @@ xfile_create(
 
 	lockdep_set_class(&inode->i_rwsem, &xfile_i_mutex_key);
 
+	/*
+	 * We're not quite ready for large folios yet.
+	 */
+	mapping_clear_large_folios(inode->i_mapping);
+
 	trace_xfile_create(xf);
 
 	*xfilep = xf;
-- 
2.39.2


