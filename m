Return-Path: <linux-fsdevel+bounces-77918-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uPWhMiADnGkn/AMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77918-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 08:34:56 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id EE1E3172BD1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 08:34:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D08E3300E487
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 07:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A0B234B697;
	Mon, 23 Feb 2026 07:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cg2qgAb1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B35349B04
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Feb 2026 07:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771832066; cv=none; b=W4OYuLtjy51YWyy/ltiImxAY3K1qnTn8LakwNYZRnR3xzkF5N9CUEzhAijO/qWip5XARbJRot6PKu9nT3NWkVERGWC8z1esnYB34S6IqH9UnuhKYf8MIalMYAF77meYDX3UDxNpse+Vyqg5JiTPely86j3zBUllhhvK0D3wHqzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771832066; c=relaxed/simple;
	bh=GEBZzoosESo4pVyEE900e5vvLvbT0HdkzZFOpsUWUWQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eOyCbK7oHVdjMbvscyiYJeojZEFUGO6bL8Qg/js6tMI/nat1yHv2wbgkgicCDEIkz3joOcv2P4Wa5A9VVU1VAULRPcd5BV2zn1aQA+uY2tlX6cVLRgetdOTY2F0TbK9WzkqUNRr0Ei4fr7C2YWDn/XQ7P+hcgGIDZDRg+pG6YVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cg2qgAb1; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-8249e91bcfbso1475734b3a.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 22 Feb 2026 23:34:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771832065; x=1772436865; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=sTzyqQEPt79Zpwhd6jWg3UfI8Z+bf/09VsUr7zJytLU=;
        b=cg2qgAb1ADlli6AU1OKylDslnicVQckrXqdrW1179KhyPOMDLEAl60AqpteeeAz/Fo
         k5KygpB/vMJmd5KxNncXwG6fwClXZTG2eHW9YWBeHkmvz7MT5bYU8u+yaiF7Epu5ZGzq
         2yd+3gChoAyCkZQ6+FFrTnlMAtzHDPzi52/kPwVF7VgAcYfcOxiYCNmiYilnllUrlEQR
         3VFNu5muSvEzW7MI8l6JQfQ9eno5yuCQh8uVHy5oNeGVrbOjl0hZX4R/lDxfCL8QN9jf
         Jm6KW4yzLmHaFThuJtMJ8f5i5xfwCvnGc/vc1MqXOp0TFHRvzITV05iFqxLyia/2glyJ
         G2rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771832065; x=1772436865;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sTzyqQEPt79Zpwhd6jWg3UfI8Z+bf/09VsUr7zJytLU=;
        b=BCFZJgIbux5CLk/wu8x3tyfVHeAA3bP69ZKrXwc0D2clb72sZpHoEVM8A3dVUdz2Ms
         SxWGAqk25PJJiaoTF2+lWG8cIDBDJ+l6GuvHJGjv8u+cNSAK11r+6KpDA6z+Z9mMvndU
         ZtSUFwsSy/6U5grsl0OH31mMwKIUwXCXXelwjrWoqIy3mLfz39Gf+696JZ2NbaRjOYxY
         4xHwI+fx9J7W74gaeif5zPGvGs3PD4X8HlbqO5uHF6QZCwRV6qYtCQo1xKlNZ9sGISAJ
         VI9OtT+DjWjI5kZHPWlO5N50+g9TqTcFaTPYP0mzHZ8GN3eXZeo/0zVgF7EGiRJdgAQF
         VZIw==
X-Forwarded-Encrypted: i=1; AJvYcCWD/OA61ucgNnho/lHX7mJCYZH9RR57J0i8+CpUvLFhgVQnsMbCrroG64eRt/HP+nOH8PMQqbjVAiplT8JZ@vger.kernel.org
X-Gm-Message-State: AOJu0YzO0uNWokmRC2ATxD9+0qa5V4wNOP2ZVQbwHyIx7hDHcHseNDl4
	Ij5e0lyJSKzJV6+wWexoKaRGAj1wyMkjeDHYJ7tq1gIJWYpGEMXZ+mjwpPx58+adkCBK57KtO/g
	2RIYXSsftWTdnhYqy4F5xB69uHw==
X-Received: from pfbdo13.prod.google.com ([2002:a05:6a00:4a0d:b0:824:b4f6:5f0d])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:1495:b0:81e:c67a:1a79 with SMTP id d2e1a72fcca58-826da9079e7mr6244452b3a.25.1771832064755;
 Sun, 22 Feb 2026 23:34:24 -0800 (PST)
Date: Mon, 23 Feb 2026 07:34:13 +0000
In-Reply-To: <cover.1771831836.git.ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1771831836.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.53.0.345.g96ddfc5eaa-goog
Message-ID: <3d698e6fcf052628629d9bd928fcef5fea049a76.1771831836.git.ackerleytng@google.com>
Subject: [RFC PATCH v3 1/2] XArray tests: Fix check_split tests to store correctly
From: Ackerley Tng <ackerleytng@google.com>
To: willy@infradead.org, akpm@linux-foundation.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Cc: david@kernel.org, michael.roth@amd.com, dev.jain@arm.com, 
	vannapurve@google.com, Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-77918-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ackerleytng@google.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EE1E3172BD1
X-Rspamd-Action: no action

__xa_store() does not set up xas->xa_sibs, and when it calls xas_store(),
xas_store() stops prematurely and does not update node->nr_values to count
all values and siblings. Hence, when working with multi-index XArrays,
__xa_store() cannot be used.

Fix tests by calling xas_store() directly with xas->xa_sibs correctly set
up.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 lib/test_xarray.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/lib/test_xarray.c b/lib/test_xarray.c
index 5ca0aefee9aa5..e71e8ff76900b 100644
--- a/lib/test_xarray.c
+++ b/lib/test_xarray.c
@@ -1846,8 +1846,14 @@ static void check_split_1(struct xarray *xa, unsigned long index,
 	xas_split_alloc(&xas, xa, order, GFP_KERNEL);
 	xas_lock(&xas);
 	xas_split(&xas, xa, order);
-	for (i = 0; i < (1 << order); i += (1 << new_order))
-		__xa_store(xa, index + i, xa_mk_index(index + i), 0);
+	for (i = 0; i < (1 << order); i += (1 << new_order)) {
+		xas_set_order(&xas, index + i, new_order);
+		/*
+		 * Don't worry about -ENOMEM, xas_split_alloc() and
+		 * xas_split() ensures that all nodes are allocated.
+		 */
+		xas_store(&xas, xa_mk_index(index + i));
+	}
 	xas_unlock(&xas);
 
 	for (i = 0; i < (1 << order); i++) {
@@ -1893,8 +1899,14 @@ static void check_split_2(struct xarray *xa, unsigned long index,
 		xas_unlock(&xas);
 		goto out;
 	}
-	for (i = 0; i < (1 << order); i += (1 << new_order))
-		__xa_store(xa, index + i, xa_mk_index(index + i), 0);
+	for (i = 0; i < (1 << order); i += (1 << new_order)) {
+		xas_set_order(&xas, index + i, new_order);
+		/*
+		 * Don't worry about -ENOMEM, xas_split_alloc() and
+		 * xas_split() ensures that all nodes are allocated.
+		 */
+		xas_store(&xas, xa_mk_index(index + i));
+	}
 	xas_unlock(&xas);
 
 	for (i = 0; i < (1 << order); i++) {
-- 
2.53.0.345.g96ddfc5eaa-goog


