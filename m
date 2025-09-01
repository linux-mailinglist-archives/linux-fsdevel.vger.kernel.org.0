Return-Path: <linux-fsdevel+bounces-59863-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76F61B3E6E0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 16:22:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8244A7A7690
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 14:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D19D72FB62B;
	Mon,  1 Sep 2025 14:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uqopxz85"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A6E02EDD76
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Sep 2025 14:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756736532; cv=none; b=khxfdrqXVAJN5CqYDhb6dnLNmg9Njyjpb1Hhs32BrF4KScuwkIjhYT9iYVPYURPftsj4VNEjfDNLjYgVb8sw8OxzhVAY34RdlvYVHu5SPT6nZu/H+CDgCcu4Lz6gZ6L/d5RlrCat3J1NBtmE6TreejfrDc6gscWzy8MhoEASia0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756736532; c=relaxed/simple;
	bh=ZCtZQCFzV9/uWVGMDpBmbTvxbrjZR/3n9JV74DWdh+A=;
	h=Date:From:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BbkramlXdz+z48sv5fLKL8aggavwY60/ze4u8efQ8HShfzCTyT0JHPgeiHzGr74umAzpwftBEINFQp5qkx9ylmu4WDBBXGuFnUYRpJGsn8ammwILyNtC11G+64DIhQwPzYutXJqbpTm8/6c5tKA+GkjH2N8aIS2kqToGa5Y8HA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uqopxz85; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E7B2C4CEF0;
	Mon,  1 Sep 2025 14:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756736531;
	bh=ZCtZQCFzV9/uWVGMDpBmbTvxbrjZR/3n9JV74DWdh+A=;
	h=Date:From:Cc:Subject:References:In-Reply-To:From;
	b=Uqopxz85kGINil1Ie0eZuVVKHGbpEFYyGxZ+yxYyBVTWXe33XEcC5FcvCuXy5lT/Y
	 aJQrfL+AEh8sA11DidWzqdRaKoKlefvy3TBhawz2mAv6dlklUPn3D/FaL35fvDtzqw
	 9J9JDz2bnJTwxBXpqXusd28rhepnQH4+jyPJdyUzP/nzJWxIzBtV37I9GDyrglnYbx
	 z8PtB+Ob+snBqLpF/udslR/nbnmzH1XNCjCzcdaQUGJbtwTHKzej/oMpGEvF5jjnmu
	 FVs+fUC0Ba7jveFvB5N5ZcRaXVj3fBiIKod8tnEhJopzat0K1bI0UTOc0ZKe7+PORh
	 h+STnzC+y7E7g==
Date: Mon, 1 Sep 2025 16:22:06 +0200
From: Alejandro Colomar <alx@kernel.org>
Cc: Alejandro Colomar <alx@kernel.org>, 
	Christoph Hellwig <hch@infradead.org>, "Darrick J. Wong" <djwong@kernel.org>, 
	Johannes Thumshirn <Johannes.Thumshirn@wdc.com>, linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v2] man/man2/readv.2: Document RWF_DONTCACHE
Message-ID: <9e1f1b2d6cf2640161bc84aef24ca40fdb139054.1756736414.git.alx@kernel.org>
X-Mailer: git-send-email 2.50.1
References: <af82ddad-82c1-4941-a5b5-25529deab129@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <af82ddad-82c1-4941-a5b5-25529deab129@kernel.dk>

Add a description of the RWF_DONTCACHE IO flag, which tells the kernel
that any page cache instantiated by this IO, should be dropped when the
operation has completed.

Reported-by: Christoph Hellwig <hch@infradead.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>
Cc: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc: linux-fsdevel@vger.kernel.org
Co-authored-by: Jens Axboe <axboe@kernel.dk>
[alx: editorial improvements; srcfix, ffix]
Signed-off-by: Alejandro Colomar <alx@kernel.org>
---

Hi Jens,

Here's the patch.  We don't need to paste it into writev(2), because
writev(2) is documented in readv(2); they're the same page.

Thanks for the commit message!

Please sign it, if you like it.


Have a lovely day!
Alex


 man/man2/readv.2 | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/man/man2/readv.2 b/man/man2/readv.2
index c3b0a7091..5b2de3025 100644
--- a/man/man2/readv.2
+++ b/man/man2/readv.2
@@ -301,6 +301,39 @@ .SS preadv2() and pwritev2()
 .B RWF_SYNC
 is specified for
 .BR pwritev2 ()).
+.TP
+.BR RWF_DONTCACHE " (since Linux 6.14)"
+Reads or writes to a regular file
+will prune instantiated page cache content
+when the operation completes.
+This is different than normal buffered I/O,
+where the data usually remains in cache
+until such time that it gets reclaimed
+due to memory pressure.
+If ranges of the read or written I/O
+were already in cache before this read or write,
+then those ranges will not be pruned at I/O completion time.
+.IP
+Additionally,
+any range dirtied by a write operation with
+.B RWF_DONTCACHE
+set will get kicked off for writeback.
+This is similar to calling
+.BR sync_file_range (2)
+with
+.I SYNC_FILE_RANGE_WRITE
+to start writeback on the given range.
+.B RWF_DONTCACHE
+is a hint, or best effort,
+where no hard guarantees are given on the state of the page cache
+once the operation completes.
+.IP
+If used on a file system or block device
+that doesn't support it,
+it will return \-1, and
+.I errno
+will be set to
+.BR EOPNOTSUPP .
 .SH RETURN VALUE
 On success,
 .BR readv (),
@@ -368,6 +401,12 @@ .SH ERRORS
 .I statx.
 .TP
 .B EOPNOTSUPP
+.B RWF_DONTCACHE
+was set in
+.I flags
+and the file doesn't support it.
+.TP
+.B EOPNOTSUPP
 An unknown flag is specified in
 .IR flags .
 .SH VERSIONS

Range-diff against v1:
-:  --------- > 1:  9e1f1b2d6 man/man2/readv.2: Document RWF_DONTCACHE

base-commit: aa88bcfabc52b7d4ef52a8e5a4be0260676d81bc
prerequisite-patch-id: b91cde16f48eeae2a44bae89e8cbb41d9034a865
prerequisite-patch-id: 0c0617b91c32758d64e6e8b2f8ddd434199d842b
prerequisite-patch-id: 02385b38b2a5ec5c04a468e888b1bc14aace9ec6
prerequisite-patch-id: 10e6a0e6e2edd5e74767af533958389454f72ab5
prerequisite-patch-id: 2dc3d94ce9d6e965182437c822479f55ec67da07
prerequisite-patch-id: 9e5fef3be8cc4d5d2828c415cf5a923e055640fc
prerequisite-patch-id: 3de1fc513b71447bb13ac740474138c80e3a463e
-- 
2.50.1


