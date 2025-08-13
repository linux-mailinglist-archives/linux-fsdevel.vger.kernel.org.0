Return-Path: <linux-fsdevel+bounces-57639-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F0C9B2411E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 08:09:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36DDF188D6FC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 06:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFFF22C21D7;
	Wed, 13 Aug 2025 06:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ueabqbww"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B1F2BEC39;
	Wed, 13 Aug 2025 06:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755065108; cv=none; b=cPWan6Bif/Qy5SdyBKTR2IcNP//XK8DHFEbhmtV7pNCcVU46+IXqP8bYwW7NIxpwDRvfduA57aHGMrUkLgm7Cx9Rp/UqtdFwSUE1WnMIri87mg4BCFXjsnYGcMjYEQ8QRtcyr2CLtKKm5djrecIQFdizuFVLy+uxrDerThY1ixM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755065108; c=relaxed/simple;
	bh=m3ywk8MRrI0GUybHl5CXS4A0Qx6xmxF0rArENEHRFlU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Jhg28PIg1ULaeGG4nYXNFIBxGWTvl2OXODY0XYNIxTCjIqnbuIGnc8/NOnZ+uMVXXtcWrdXkuvKWdYjlXoqC580TUHjadvi7LnaZfzDVh68HBGyKVU9beLl05zXfwaLNR4dbYEIT/B+qCI5O4ml0CClhWWxOKPstv4OlDDzVyAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ueabqbww; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C1A3DC4CEF6;
	Wed, 13 Aug 2025 06:05:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755065107;
	bh=m3ywk8MRrI0GUybHl5CXS4A0Qx6xmxF0rArENEHRFlU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ueabqbwwSevLn80CnFvuAeo/piQ0IREDerm/7F8/aQBjSEov0+01vp/0ORiAU0oth
	 MIMB7+F6FloaWrq6gcRbixMflpjktyUxHzr8Qowyfs6Nzwjuas3Q6sqkXaP0/oPhV3
	 6ZGfbHwzdz0/tP+bslRKN6TNsyKbZQ+u64hlNJGc9sSImO97bt+thCaa/IFf1dXrx0
	 yJ1uWstSUOx64Ob785Fv4Vp3RfW4y6X8wblAK851o1OES+mCpH7vbKvneuBhhMQDME
	 97qvjmPLWTKjSYkP/P7yKXaVGHvsnConYl/3c75riRoQ3O8LN5W2ZV8Vud8+SHeD4L
	 fOaDqk/F8FdaQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0545C87FCF;
	Wed, 13 Aug 2025 06:05:07 +0000 (UTC)
From: Dominique Martinet via B4 Relay <devnull+asmadeus.codewreck.org@kernel.org>
Date: Wed, 13 Aug 2025 15:04:55 +0900
Subject: [PATCH v3 1/2] iov_iter: iterate_folioq: fix handling of offset >=
 folio size
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250813-iot_iter_folio-v3-1-a0ffad2b665a@codewreck.org>
References: <20250813-iot_iter_folio-v3-0-a0ffad2b665a@codewreck.org>
In-Reply-To: <20250813-iot_iter_folio-v3-0-a0ffad2b665a@codewreck.org>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
 Christian Brauner <brauner@kernel.org>, David Howells <dhowells@redhat.com>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Andrew Morton <akpm@linux-foundation.org>
Cc: Maximilian Bosch <maximilian@mbosch.me>, Ryan Lahfa <ryan@lahfa.xyz>, 
 Christian Theune <ct@flyingcircus.io>, Arnout Engelen <arnout@bzzt.net>, 
 linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, Dominique Martinet <asmadeus@codewreck.org>, 
 stable@vger.kernel.org
X-Mailer: b4 0.15-dev-7be4f
X-Developer-Signature: v=1; a=openpgp-sha256; l=2905;
 i=asmadeus@codewreck.org; h=from:subject:message-id;
 bh=+zurJnGiPdQ42lg9XGNahXk/2/5ljCfYqf+N0o+tHH8=;
 b=owEBbQKS/ZANAwAKAatOm+xqmOZwAcsmYgBonCsShzHrj9La+i6jSi5ywyznTL368B7vFcN2F
 958irn8d32JAjMEAAEKAB0WIQT8g9txgG5a3TOhiE6rTpvsapjmcAUCaJwrEgAKCRCrTpvsapjm
 cPd+EACRFAv0U/Fg9DcoFmhsolUeIrFBWJlCqDFmZUi2kaRl8VzoGJkWJ9JPU49txLdcb2vCDud
 yuQg/HqBqEaceSKxpn+KfHljPwb/6APyjJzAvcCveBI5u6L5shWIa19yMsC8pnYIJlwuLC0CMvr
 +4NL/OkYjQbhgwMCH0BCDoxuFZtA9Bin1O8r1oF+zHOcfQJZmjopnbWiHqv5pGuEW9bwFv6dLst
 3IhBIiM/AUdfSgj5zTib/syAkoskG+Y0vCnpWS1i5TnBV7A5jUryG9Bx344Brykv1CZAWu9Vn5C
 6UMWIoXQBJz0/VLyJSRyG2Tp0BoB/Sj4y3HzYf+CJSu8DTiiQF7l2lzJIAG5h+wJcRhtuzEZJ8u
 2fcVg4GvqHFSZ65olTpA0evgGAT2s4t0E5Ehwsu7BQCLvh6yMRwWBzTlvJpdPzXVW8mFklJ5czN
 MWx8LF8mN6e6W32NgDghQmrdlxlzIwehh9TIGOqRxNHRrmo+Niq4vjMTtCJA+S+cbwBLO/cPK1C
 FA3CtvQIAvvKo/ZTElvTayXCHnwTqR3zR1hFXuIjA93AQstcDjjeG6LSdahNLiC34inWWi78KvG
 tXdYdsEk3ZR8f42X4yucIkW5qclcYbFZxVaep/xocPRMknEeEqImiUIXpLW41tbIxJv59DDr2rD
 E1SWP6SHQUFoR7A==
X-Developer-Key: i=asmadeus@codewreck.org; a=openpgp;
 fpr=B894379F662089525B3FB1B9333F1F391BBBB00A
X-Endpoint-Received: by B4 Relay for asmadeus@codewreck.org/default with
 auth_id=435
X-Original-From: Dominique Martinet <asmadeus@codewreck.org>
Reply-To: asmadeus@codewreck.org

From: Dominique Martinet <asmadeus@codewreck.org>

It's apparently possible to get an iov advanced all the way up to the
end of the current page we're looking at, e.g.

(gdb) p *iter
$24 = {iter_type = 4 '\004', nofault = false, data_source = false, iov_offset = 4096, {__ubuf_iovec = {
      iov_base = 0xffff88800f5bc000, iov_len = 655}, {{__iov = 0xffff88800f5bc000, kvec = 0xffff88800f5bc000,
        bvec = 0xffff88800f5bc000, folioq = 0xffff88800f5bc000, xarray = 0xffff88800f5bc000,
        ubuf = 0xffff88800f5bc000}, count = 655}}, {nr_segs = 2, folioq_slot = 2 '\002', xarray_start = 2}}

Where iov_offset is 4k with 4k-sized folios

This should have been fine because we're only in the 2nd slot and
there's another one after this, but iterate_folioq should not try to
map a folio that skips the whole size, and more importantly part here
does not end up zero (because 'PAGE_SIZE - skip % PAGE_SIZE' ends up
PAGE_SIZE and not zero..), so skip forward to the "advance to next
folio" code

Reported-by: Maximilian Bosch <maximilian@mbosch.me>
Reported-by: Ryan Lahfa <ryan@lahfa.xyz>
Reported-by: Christian Theune <ct@flyingcircus.io>
Reported-by: Arnout Engelen <arnout@bzzt.net>
Link: https://lkml.kernel.org/r/D4LHHUNLG79Y.12PI0X6BEHRHW@mbosch.me/
Fixes: db0aa2e9566f ("mm: Define struct folio_queue and ITER_FOLIOQ to handle a sequence of folios")
Cc: stable@vger.kernel.org # v6.12+
Acked-by: David Howells <dhowells@redhat.com>
Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>
---
 include/linux/iov_iter.h | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/include/linux/iov_iter.h b/include/linux/iov_iter.h
index c4aa58032faf874ee5b29bd37f9e23c479741bef..f9a17fbbd3980b1fec5f9a7fde812aebef6728d5 100644
--- a/include/linux/iov_iter.h
+++ b/include/linux/iov_iter.h
@@ -160,7 +160,7 @@ size_t iterate_folioq(struct iov_iter *iter, size_t len, void *priv, void *priv2
 
 	do {
 		struct folio *folio = folioq_folio(folioq, slot);
-		size_t part, remain, consumed;
+		size_t part, remain = 0, consumed;
 		size_t fsize;
 		void *base;
 
@@ -168,14 +168,16 @@ size_t iterate_folioq(struct iov_iter *iter, size_t len, void *priv, void *priv2
 			break;
 
 		fsize = folioq_folio_size(folioq, slot);
-		base = kmap_local_folio(folio, skip);
-		part = umin(len, PAGE_SIZE - skip % PAGE_SIZE);
-		remain = step(base, progress, part, priv, priv2);
-		kunmap_local(base);
-		consumed = part - remain;
-		len -= consumed;
-		progress += consumed;
-		skip += consumed;
+		if (skip < fsize) {
+			base = kmap_local_folio(folio, skip);
+			part = umin(len, PAGE_SIZE - skip % PAGE_SIZE);
+			remain = step(base, progress, part, priv, priv2);
+			kunmap_local(base);
+			consumed = part - remain;
+			len -= consumed;
+			progress += consumed;
+			skip += consumed;
+		}
 		if (skip >= fsize) {
 			skip = 0;
 			slot++;

-- 
2.50.1



