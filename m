Return-Path: <linux-fsdevel+bounces-20260-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CFB88D08C7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 May 2024 18:36:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C61EB28F1C0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 May 2024 16:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29B55155C98;
	Mon, 27 May 2024 16:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DJ/FbSdF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C714061FDB;
	Mon, 27 May 2024 16:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716827783; cv=none; b=TGtqT4JXayeueEIImpJT4QE/Wy9LUOtzSEicfjiTsV/NcGE2RTcbIdkF0GIdUgo2/8hwdHuIajBfQyP0SBM7IRmyjc/s26wEP4bf3/YqC+XMq9zu35GZn/8VazB6sGAvXovmyRf6NbsFqoKaphn5I+YZqtpCYs7GvN1L4QmYpIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716827783; c=relaxed/simple;
	bh=p/AcaZr6TQ0ufKxEuDnUWDVfPD8xmPPtDJJOswjtURc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qeCq838CoPKJHkC7Cm4P9zZlly1tXoEgrKrFo7ye+KlCcpbMYRnVf1TVc0tOcLKmKkK4oeflO5IBsSLkkx3y6QbJtxSyXE4bxmTiKooYPHdhclJz21sC4LN5PKaG/toOCjN0x7hvVINJOWHjlAfrwdLTgq+UHQezppRgrihMCK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=DJ/FbSdF; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=8EKRG22z1xnqyUg5G8bRLOhT2RWzJZUcC73o1Yr1tDo=; b=DJ/FbSdF9ms7pCqDA3oiKoFFIp
	GuXHVsBBtYTej2LgFzqL9+NQ8Sm1ny6A2lIhJHwWOCNU6RQAa6idFA3VgYFJkVkUa2kuY6FdT++3E
	U1RtI0LKO7l0KdNmAgyf2UpjbR/LKxgeJ2ZVNnClTIzhBrldGXJ+qXpm1CP6DqvHu+KqDGFhw430i
	uMwuMTejBrNN7t4wCI+vgmfgGWbYgoD6V7JKukSemnloWJh91Vy4zS/kE789mAUYQL1MSkxRH0m69
	BA/GWDcN+98vfpxrDXrH5GuL5SjTMH2CkfSpJtr7WN5bjzCVv1RF/uGqp8qPATND0IK1n5csSnOgW
	SpW9CAoQ==;
Received: from 2a02-8389-2341-5b80-3177-e4c1-2108-f294.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:3177:e4c1:2108:f294] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sBdKd-0000000Ft6E-38vQ;
	Mon, 27 May 2024 16:36:20 +0000
From: Christoph Hellwig <hch@lst.de>
To: Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna@kernel.org>,
	Matthew Wilcox <willy@infradead.org>
Cc: linux-nfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org
Subject: support large folios for NFS
Date: Mon, 27 May 2024 18:36:07 +0200
Message-ID: <20240527163616.1135968-1-hch@lst.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Hi all,

this series adds large folio support to NFS, and almost doubles the
buffered write throughput from the previous bottleneck of ~2.5GB/s
(just like for other file systems).

The first patch is an old one from willy that I've updated very slightly.
Note that this update now requires the mapping_max_folio_size helper
merged into Linus' tree only a few minutes ago.

Diffstat:
 fs/nfs/file.c  |    4 +++-
 fs/nfs/inode.c |    1 +
 mm/filemap.c   |   40 +++++++++++++++++++++++++---------------
 3 files changed, 29 insertions(+), 16 deletions(-)

