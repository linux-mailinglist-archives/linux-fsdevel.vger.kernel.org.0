Return-Path: <linux-fsdevel+bounces-75973-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sDxoLbtJfWlZRQIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75973-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Jan 2026 01:15:55 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 183B8BF8D4
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Jan 2026 01:15:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 29169302172B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Jan 2026 00:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14AE12F5308;
	Sat, 31 Jan 2026 00:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LzL2GztJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E1EB285C98
	for <linux-fsdevel@vger.kernel.org>; Sat, 31 Jan 2026 00:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769818547; cv=none; b=t7F+DIeP1Nlr9Qpsc0gz7b/NDNQdkqzFUV8RLOY9dHfh44Z/bpa8sMqV85yAauO2+a7dg2NdyggtjpoXpJZWga7HnO0r2WQ+2HXsuvXqfpgTSH04qk7Y5hyVxnbNeQlZa0KGsSi6pFKpm8FVOnTOuas9/Z17Y0B6zaFj7FqxiE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769818547; c=relaxed/simple;
	bh=U96qo2VZqSW1KcTqxsIfY/OMfSrjBrN5cMAQ1859HvA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=jnLdgdlnMKOLMKqGAWsGWWrDJOGMMBRLuM17N86qLGbJsXTDlOZbc7fhW1ZyRoAlqk4hCdj16rmgBQG3m9qxcYjualKnVu6bI93rgotRAm+RXvtbpX2L3AvN0fDjAV1p+PUHoVSr1aWyBGNs2v1yVXm03tzOgSOOhy9OJ45gn1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LzL2GztJ; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2a0a4b748a0so49824595ad.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Jan 2026 16:15:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769818546; x=1770423346; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tie1ca0WqdbWncjWD6Fm6z7ENfJLpUk05Sjlx+K86FM=;
        b=LzL2GztJtaiMr5cpcaeMW9ClBR+TbKFRnwzH0Ka+7k+l3KITAZu1Z/hsa5iMsy0xBf
         +Pe6zrn8lwKS9Ca2rCrEJeQTJg50HjQCPxe55K0qjL6UuyzTNsgeDBpeTUwL8efhyWti
         k2wXJLeK2ECErBVwghxEifLqBrALQa9zXm6PJC7OVW36rYQSizOs2w9zMocAR7hAdzLn
         tWWWioSPVKkbJ3UlNAFQXqMTFG1+znSeLCZzXj6x1WzZwIhV6vGrYCPmtQLAPuikb3XF
         FxHCpV5PLyNuVlQWv/bO/pNVhRaF1GH4buMaTt7sl/VwaVfeD3BkVlEiWLWBrOC1u/wG
         mQlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769818546; x=1770423346;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tie1ca0WqdbWncjWD6Fm6z7ENfJLpUk05Sjlx+K86FM=;
        b=nEnfDl3IhZtDM3LfjpX5TBIRG1bUF7a1Tya/gBcjfPUWFGqUP6XWuhzymGqq/BqLSB
         dkCL0gKxdq92U+RMThC621zDoyOAy1HeGoVy1oQX/MD/vwK9MpcYI5wxe/V+xFbYTxNZ
         eSklhOW5p53vhloF/qd/558UgNS72+EjZGCjcv1/TLNIua1macWcLtow+Lx7kQqtv4jU
         YgPyOk/bQmRqykUyY3N3CGdFyO41rh5u87raMsZU3lVxVe9dkKm+2z+MbOSf0bJ0l9Bd
         55rCm8ZEwbTR1jZNKQHmw3qhpDUpcpJNN02sDRy6s9bl3qYTQrPpEDQtgdYBycJujYFi
         dNvg==
X-Forwarded-Encrypted: i=1; AJvYcCVQOcBCwMOgqsZC/Z7p1V5gU9WYfb7PpiOM54Z9h00ngtLdZSvNyb700wTKEdehGmGl+Hssdp9D218SmFYQ@vger.kernel.org
X-Gm-Message-State: AOJu0YwZ/tW2o177ykMOKX9ngCsq2G/k9GSXxuuzy2CeWOG2UkdQGhTs
	vIHpdZqwdDt8GhKz4Ydg//49Xh1Lxp4zEGJ7Aq0KmVUwHhNKcBpPS96TaeHFGRH6PawIC0MScR3
	3tXllBhumwoDyFB4cianJpXVl5g==
X-Received: from plrd9.prod.google.com ([2002:a17:902:aa89:b0:2a3:e79c:6cfb])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:124c:b0:2a0:de4f:ca7 with SMTP id d9443c01a7336-2a8d959c1e8mr47669015ad.1.1769818545853;
 Fri, 30 Jan 2026 16:15:45 -0800 (PST)
Date: Fri, 30 Jan 2026 16:15:36 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.rc1.225.gd81095ad13-goog
Message-ID: <cover.1769817142.git.ackerleytng@google.com>
Subject: [RFC PATCH v1 0/2] Fix storing in XArray check_split tests
From: Ackerley Tng <ackerleytng@google.com>
To: willy@infradead.org, akpm@linux-foundation.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Cc: david@redhat.com, michael.roth@amd.com, dev.jain@arm.com, 
	vannapurve@google.com, Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-75973-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ackerleytng@google.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 183B8BF8D4
X-Rspamd-Action: no action

Hi,

I hit an assertion while making some modifications to
lib/test_xarray.c [1] and I believe this is the fix.

In check_split, the tests split the XArray node and then store values
after the split to verify that splitting worked. While storing and
retrieval works as expected, the node's metadata, specifically
node->nr_values, is not updated correctly.

This led to the assertion being hit in [1], since the storing process
did not increment node->nr_values sufficiently, while the erasing
process assumed the fully-incremented node->nr_values state.

Would like to check my understanding on these:

1. In the multi-index xarray world, is node->nr_values definitely the
   total number of values *and siblings* in the node?

2. IIUC xas_store() has significantly different behavior when entry is
   NULL vs non-NULL: when entry is NULL, xas_store() does not make
   assumptions on the number of siblings and erases all the way till
   the next non-sibling entry. This sounds fair to me, but it's also
   kind of surprising that it is differently handled when entry is
   non-NULL, where xas_store() respects xas->xa_sibs.

3. If xas_store() is dependent on its caller to set up xas correctly
   (also sounds fair), then there are places where xas_store() is
   used, like replace_page_cache_folio() or
   migrate_huge_page_move_mapping(), where xas is set up assuming 0
   order pages. Are those buggy?

[1] https://lore.kernel.org/all/20251028223414.299268-1-ackerleytng@google.com/

Ackerley Tng (2):
  XArray tests: Fix check_split tests to store correctly
  XArray tests: Verify xa_erase behavior in check_split

 lib/test_xarray.c | 28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

--
2.53.0.rc1.225.gd81095ad13-goog

