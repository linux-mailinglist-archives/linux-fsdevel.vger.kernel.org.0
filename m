Return-Path: <linux-fsdevel+bounces-68800-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 95167C667A2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 23:50:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0DAE9363BB2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 22:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 089AE34DB77;
	Mon, 17 Nov 2025 22:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g7BTvmZO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E313446C4
	for <linux-fsdevel@vger.kernel.org>; Mon, 17 Nov 2025 22:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763419639; cv=none; b=jbBuOpgidhqv/FDwI0StLxHNfEynjueMGi7QQ11vhzTJedfvivAxzDKHq3tOZ+wUpo3jcndTkdhONNhgDG35tQGMrBNyklyLYBGyMsrlPBdYpIF66SrN04Q+q8ZRbKfoDsy/AGdmEkm7tljduT+4LMh4whiMV5Vid6EMqskABP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763419639; c=relaxed/simple;
	bh=tfIrZCoJ3VIjC7+RLHtxfRRKbaNTL7uBfbInHHXOwE8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fVPIzBQaCJbd3f8a3OQ9BKYoxyHFVk/ccD4n5sasn5S3EWeeVDaSGWALocpK2/eum3RzvVwYiQH2cKZ2sfOYAntahLod1s50QM4FegSmnvFpcqVItLq8OaZdt1yUmlAoIOGmQRBVx3W19pQc2w2iaSyHndTxizbEJ493o3cjLU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=g7BTvmZO; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-7b82c2c2ca2so7211208b3a.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Nov 2025 14:47:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763419637; x=1764024437; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZYrCejxRy7zqyBcb6FQMxX806Q+d7GZ40YGLARpuYbw=;
        b=g7BTvmZOI/LSZ+tuNi5YY1JLkZMh4ONfi18XrXYPP7djTk7BsfWZbQ05hBzn4+9EGa
         /RfRUQQmgi4BE+ZMkTSGzG07Q3EfqCejwn67KWf+aPXw3Ivj7ehMFFv1r3oTXDVPkCRn
         A7NbbJvnE5sp4LG2cEqtVC9eoG30CUh9orn1313aINsUKPwwwO0IXbb2ru7enpGaGd9h
         9quVpRSRd/uTGDSvVaCck51sWWVqNFY40MmsTqbec5uUf2mrMWCfdXEpSzBaYwvk30D4
         K1szaxXI2ps1mWvOm7Qgfme+7L4jIFTpUIwVps6NMvGlkuYm3pCOXeg5HR1uaYtmf31z
         iCSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763419637; x=1764024437;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZYrCejxRy7zqyBcb6FQMxX806Q+d7GZ40YGLARpuYbw=;
        b=Eh5hZ+C5Xa2+51Q0yyr8AYRyKO3bf4a4mrC07BqxhKHFrYO8VLmBMD7ejJHinlhV20
         6HuS4EEP77ugnm9RgqprqKCA+nseybNT7XSJ7APOu7PzFrPpZ++fRE1P+mziqZnXpY+K
         QazBwX+2VIX9paL1C89p5KmEWwdcFFtQFOcoGZOpwucbpHShouAfFvquVy/7/rzOFY8i
         L/hBoVJ0plm7CBZA5sMrrEPnijJBjklCo8aJ93VQEcUZwdRPg9jEjCS3zYovls/rUP5S
         CdFgcN6qGh9x68aZqqPbRy/HVZhQSYBs9AZNLLr32OBi1QLdY9pxiUWMoKmi5xCIGbwH
         5gMw==
X-Forwarded-Encrypted: i=1; AJvYcCUuvFdnIoPAeoXL58YCS5wYfFyeVziQFJPwxhEyS7uo1v+PWfcVODceXey5DcrNheUDnaon5fLy/bHesoo1@vger.kernel.org
X-Gm-Message-State: AOJu0Yxq93PCpsgLjGrG3NJwEj5YJIAHXhh1vpE5J57IoeK+ScTld1Pw
	L/CAySBEJvxP7Gjv03lkKDl7T1sLQU03+o3XPc8J9TrrBgN8lKcd9BUJsm30b79CovU4PAeu/PG
	+3EB4mimU0OTnkUWblTVGWugJdg==
X-Google-Smtp-Source: AGHT+IF6X8M1O0ViseXJqknBCFgh9mD5b/95Oi6jmON/74K3wmmst3PfgAJtVAD5wgeUf0evNnb0s3MpsbBQZ/irZw==
X-Received: from pgbfe13.prod.google.com ([2002:a05:6a02:288d:b0:bc8:cea8:200a])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:33a1:b0:344:8ef7:7a03 with SMTP id adf61e73a8af0-35ba2992e6dmr19087812637.56.1763419636821;
 Mon, 17 Nov 2025 14:47:16 -0800 (PST)
Date: Mon, 17 Nov 2025 14:46:58 -0800
In-Reply-To: <20251117224701.1279139-1-ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251117224701.1279139-1-ackerleytng@google.com>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
Message-ID: <20251117224701.1279139-2-ackerleytng@google.com>
Subject: [RFC PATCH 1/4] XArray: Initialize nodes while splitting instead of
 while allocating
From: Ackerley Tng <ackerleytng@google.com>
To: willy@infradead.org, akpm@linux-foundation.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Cc: david@redhat.com, michael.roth@amd.com, vannapurve@google.com, 
	Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="UTF-8"

Currently, newly allocated nodes in xas_split_alloc are initialized
immediately upon allocation. This occurs before the node's specific role,
shift, and offset within the splitting hierarchy are determined.

Move the call to __xas_init_node_for_split() from xas_split_alloc() to
xas_split(). This removes any dependence on "entry" during node allocation,
in preparation for extending xa_split* functions to support multi-level
splits, where intermediate nodes need not have their slots initialized.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---

After moving the call to __xas_init_node_for_split() from
xas_split_alloc() to xas_split(), void *entry is unused and no longer
needs to be passed to xas_split_alloc().

I would like to get feedback on moving initialization into xas_split()
before making a full refactoring to remove void *entry as a parameter
to xas_split_alloc().

 lib/xarray.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/xarray.c b/lib/xarray.c
index edb877c2d51c..636edcf014f1 100644
--- a/lib/xarray.c
+++ b/lib/xarray.c
@@ -1060,7 +1060,6 @@ void xas_split_alloc(struct xa_state *xas, void *entry, unsigned int order,
 		if (!node)
 			goto nomem;

-		__xas_init_node_for_split(xas, node, entry);
 		RCU_INIT_POINTER(node->parent, xas->xa_alloc);
 		xas->xa_alloc = node;
 	} while (sibs-- > 0);
@@ -1103,6 +1102,7 @@ void xas_split(struct xa_state *xas, void *entry, unsigned int order)
 			struct xa_node *child = xas->xa_alloc;

 			xas->xa_alloc = rcu_dereference_raw(child->parent);
+			__xas_init_node_for_split(xas, child, entry);
 			child->shift = node->shift - XA_CHUNK_SHIFT;
 			child->offset = offset;
 			child->count = XA_CHUNK_SIZE;
--
2.52.0.rc1.455.g30608eb744-goog

