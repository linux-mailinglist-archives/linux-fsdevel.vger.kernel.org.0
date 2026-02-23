Return-Path: <linux-fsdevel+bounces-77916-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YNwBHHkBnGn6+wMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77916-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 08:27:53 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D2854172A36
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 08:27:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4EC6330528A3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 07:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2DC134AB16;
	Mon, 23 Feb 2026 07:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aXHTMusH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E2E34B693
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Feb 2026 07:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771831536; cv=none; b=qn3gVD0Z0+mESCXwtTnHoFtnzfMBW4h0MQDtxrKWE2dq4ROsGgBTj1NiFeDy7dbhg9Xc6gjPW8DlNStQvob7k7eL3zX1N1aMiB37lEXC+v7pOFZzaOLWzvDsQQM9bZeFJwQVy5rAO72CdPYU/Mq50oZbm9W8E35mfUpo10YbWbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771831536; c=relaxed/simple;
	bh=8TT9Tx32iVjvXy73qsnKNxVBUZf2+bktrNgUPXib0vE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=P8kq5ij3AueMqL0R3HZoX3qVA2MXI1RY4zme4v/bixRPSzaBFC3LM2Swe1VtYp8HK7gimH/ubwCRLRwXo0cAmS8sFDcTNbiSbnpxc5maIVb7PijaaxXMk0P/VwR/WdoIv5pbtkursTmlsfYi9r+e8f/WaJ/7XJgKylDks6BxcJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aXHTMusH; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2a75ed2f89dso37434985ad.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 22 Feb 2026 23:25:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771831535; x=1772436335; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QO6T3Hywklu95Q2Lh4PbmzrawpSi1ul2o5nH7XzPx2M=;
        b=aXHTMusHTsJYrSkY6FeIw8Ru3rC/YhEPJAoDZhkkvxQwh7pv7uQNMaocOH1+JJpzQC
         Qrw8CZ/GDvVfgo08THBhLpdzdh++8i03SodOCV2GNQiBwR5lg40hz5OxAMjo5VfSKL4R
         ts6FWX73m/lHpUy+PgOWo8xwHUEgE+CwdxqxRLNrykq46OMB/5jyFtOJOXVEicHt9/IQ
         FWp70getqymqujzsTFdLo29goJ5Xa3HnX2iapKigmPVwgocmZDQkYAg+1EQBaUpHQ3PU
         CNtEujLJRoE+pZVf357PEbrzKveMy+J1oGLONrmctz9Zf7PaFhjslpmOTJ0A6XsUQpim
         7Mlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771831535; x=1772436335;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QO6T3Hywklu95Q2Lh4PbmzrawpSi1ul2o5nH7XzPx2M=;
        b=dbuNuVz9YiC7eEShY4ERloddbP9Cx9bVtrvwG0PFp9m52CBCH+lD+ZTj1/LN6nckcv
         RQpwBrWLIwi91N3WeAyE4U1iA6uyofBA6I0DKZwHt4YkWjw+dfXqqhtAVYGKaCZCm1BA
         7C+mEbCzIbKk8NlJCCCl6qVZ21j/ZwGjD1fWLBxYUl2ZpT4oKhAg09Zx5rAH2CoLgowk
         ydhCpIrUe3KlRo6AJAS8dhuYY+1RZphJ7uhfrJDQnasbx32ivy7L7Fl/t6hSrBA8yRmi
         Hi3CHtqXTNdtibgtocMDAmAa6W0Ize0/XWnDl4jMoXyOwRdIlu6y33kj0E14w/+AVMw8
         jmeg==
X-Forwarded-Encrypted: i=1; AJvYcCWbyC8lb6sqPBLdhx9DQAaLABbmDb/tfH/rndil2hJy+lhs8FZormfv+eNfM0f6AH6BpipK79fOQ5sbWU08@vger.kernel.org
X-Gm-Message-State: AOJu0YxEVimywbC+8D+8xY2CYQKInia1dk6Y8BO5z9IG5bjatkFueUPa
	l7K1c1+HfCpZhuDEEJiqTrgBoAtsnptZaASC3zZy491Ad5+aKpaaHCroiomngGiBe2WO7gs5vDz
	pdl72NaRESrn/OOHPkb+jJ+yBdg==
X-Received: from pjbbp12.prod.google.com ([2002:a17:90b:c0c:b0:34c:2797:7072])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:4b28:b0:2a9:43a9:d367 with SMTP id d9443c01a7336-2ad745a5e98mr58917065ad.51.1771831534600;
 Sun, 22 Feb 2026 23:25:34 -0800 (PST)
Date: Mon, 23 Feb 2026 07:25:28 +0000
In-Reply-To: <cover.1771831180.git.ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1771831180.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.53.0.345.g96ddfc5eaa-goog
Message-ID: <bad1921421199c3009a773d006c1f8782e90452b.1771831180.git.ackerleytng@google.com>
Subject: [RFC PATCH v1 RESEND 2/2] XArray tests: Verify xa_erase behavior in check_split
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-77916-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ackerleytng@google.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D2854172A36
X-Rspamd-Action: no action

Both __xa_store() and xa_erase() use xas_store() under the hood, but when
the entry being stored is NULL (as in the case of xa_erase()),
xas->xa_sibs (and max) is only checked if the next entry is not a sibling,
hence allowing xas_store() to keep iterating, hence updating
node->nr_values correctly.

Add xa_erase() to check_split tests that verify functionality, with the
added intent to illustrate the usage differences between __xa_store(),
xas_store() and xa_erase() with regard to multi-index XArrays.

Change-Id: Ibbbae5e6339b46203f22658cc84ea9f16025fa14
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 lib/test_xarray.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/lib/test_xarray.c b/lib/test_xarray.c
index e71e8ff76900b..bb9471a3df65c 100644
--- a/lib/test_xarray.c
+++ b/lib/test_xarray.c
@@ -1874,6 +1874,10 @@ static void check_split_1(struct xarray *xa, unsigned long index,
 	rcu_read_unlock();
 	XA_BUG_ON(xa, found != 1 << (order - new_order));
 
+	for (i = 0; i < (1 << order); i += (1 << new_order))
+		xa_erase(xa, index + i);
+	XA_BUG_ON(xa, !xa_empty(xa));
+
 	xa_destroy(xa);
 }
 
@@ -1926,6 +1930,10 @@ static void check_split_2(struct xarray *xa, unsigned long index,
 	}
 	rcu_read_unlock();
 	XA_BUG_ON(xa, found != 1 << (order - new_order));
+
+	for (i = 0; i < (1 << order); i += (1 << new_order))
+		xa_erase(xa, index + i);
+	XA_BUG_ON(xa, !xa_empty(xa));
 out:
 	xas_destroy(&xas);
 	xa_destroy(xa);
-- 
2.53.0.345.g96ddfc5eaa-goog


