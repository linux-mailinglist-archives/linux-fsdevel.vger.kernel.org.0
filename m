Return-Path: <linux-fsdevel+bounces-47024-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E789A97DC6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 06:25:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CCE517E33F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 04:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96322265CB1;
	Wed, 23 Apr 2025 04:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n1cHNFZw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED814265613;
	Wed, 23 Apr 2025 04:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745382336; cv=none; b=BwgeuJ7VG46jeXOpJj6hED+d8fxhpWp716Rc49ednDVbnnqcCYX7Pxr5/Vw/wUduWj0q1w5+ZP/U1zv8iiWCL7yT7WcNncaGkJZf3dnCLV22m4R995YxQyp2QHieyAnpkbM4uBCEl4CJ59r7yzV25RLF1nNmLNfXvXyENFjrkvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745382336; c=relaxed/simple;
	bh=69mAU3YkbHSYRyOavkWloFSSNjLBECWZP9yZSw7M4E0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qRoSCOlZ9ogJ7/hQlU+P338M7pekzIxpnrPn+/f9C6ttw+2NqnI8ChSbO6Yl1adGAeCKEwTAfNvgVhRqH2YKtQ1MqpGinIfpaMPykTHgG0xDScpk5tdTlrVF8gcaMv3F6mdXS5XcUCosUJHc6H9QHVQTao6ifxgnRLgeNo6BOB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n1cHNFZw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E295C4CEEA;
	Wed, 23 Apr 2025 04:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745382335;
	bh=69mAU3YkbHSYRyOavkWloFSSNjLBECWZP9yZSw7M4E0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n1cHNFZwco+fLA9PDbBY05EwDhJ0yMf249hWHlXGgSmgmWwbH5E6ecEKxgMVgNbey
	 fD00Nlht6efbzKtDY/iaCyeSHEYVQGl1E8ydz2c1JKWzizTWltQh+my/xdyyO5Yi1x
	 siEPMyhhBB/INzE5F3+PhHLajHpxuN6P7BrhGWvnlhhqrz+MKWIfMIObYEodcXE0ao
	 aq4enXv5Lhh53rnJ5wMTmCS2mJaau+vWjlcHNozbNsywLJ5q3pnEovDYx2C65mNcJ+
	 QCdms9GWcDhyQpmVBL3wKQNb87ckVX0d6iND4mxinvTkonyTWemTG9KHfE5xnLY+OU
	 ClZvoMbC3uarQ==
From: trondmy@kernel.org
To: linux-nfs@vger.kernel.org
Cc: linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH 2/3] filemap: Mark folios as dropbehind in generic_perform_write()
Date: Wed, 23 Apr 2025 00:25:31 -0400
Message-ID: <b7ea4a2b3a8f38e2777ac0363a364141cf3db2e8.1745381692.git.trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1745381692.git.trond.myklebust@hammerspace.com>
References: <cover.1745381692.git.trond.myklebust@hammerspace.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Trond Myklebust <trond.myklebust@hammerspace.com>

The iocb flags are not passed down to the write_begin() callback that is
allocating the folio, so we need to set the dropbehind folio flag from
inside the generic_perform_write() function itself.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 mm/filemap.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/mm/filemap.c b/mm/filemap.c
index 12f694880bb8..4c383f29e828 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -4136,6 +4136,11 @@ ssize_t generic_perform_write(struct kiocb *iocb, struct iov_iter *i)
 		copied = copy_folio_from_iter_atomic(folio, offset, bytes, i);
 		flush_dcache_folio(folio);
 
+		if (iocb->ki_flags & IOCB_DONTCACHE)
+			folio_set_dropbehind(folio);
+		else if (folio_test_dropbehind(folio))
+			folio_clear_dropbehind(folio);
+
 		status = a_ops->write_end(file, mapping, pos, bytes, copied,
 						folio, fsdata);
 		if (unlikely(status != copied)) {
-- 
2.49.0


