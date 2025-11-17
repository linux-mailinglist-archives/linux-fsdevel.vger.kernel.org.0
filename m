Return-Path: <linux-fsdevel+bounces-68801-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 06599C667A5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 23:51:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0D8D236507E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 22:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B144034E747;
	Mon, 17 Nov 2025 22:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2gC/B1Hs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E15733123E
	for <linux-fsdevel@vger.kernel.org>; Mon, 17 Nov 2025 22:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763419641; cv=none; b=eaI969lUReVL7atupXGTIDf67hmnHV/4fNXezAlKW0Ym63eGW0+fo97lmj+HvW+M40tnsBTZ4B8R7QkvY8FDVHo5fJsvSwVXQslDPBVrsgT5a2cPMisOFGkJr30915otapKBNmA2bmi+t7fCvR7dIMt0IbmKqypZMrM0uN2pnM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763419641; c=relaxed/simple;
	bh=bYbDG14TjwlkbMlXcK5doweq0ODCdogjsd0q8OtcKMw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=H/lOVmdp3rHEniaexXa1qxTvgpN9D93mbXVzN6y/For67XQ5IJ1/8NREwcixk/TSrulAMIZ9weK27rQHS/h3uH5Nb4bEU6AZzvAuwcj64LU1pYbfE25712NLptQ5zCZWAVvYDrdz0FHAnrFeNexca0r4/jt02k/aw+K+ZUkiZ+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2gC/B1Hs; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-7b89ee2c1a4so6834194b3a.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Nov 2025 14:47:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763419638; x=1764024438; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=IgOprM20p142HerI0wr78gS0iVMLCiuLJeQSKJuE034=;
        b=2gC/B1HsjoJc2YS+TwlWHjtzvPYJ8fc26b4l2ukDVqoK76fkiFPLVBeu7gDe5ZlflW
         va83tswUTgZNJB70ITt+C+Wh3/4a30eHwqwXsXe/SbT/On/R79Oxj1GzBoDp6TA9jSv4
         uTmj9vsHu4wHnQVCpvXNAxMmL4uG/enA3z3qkTKlT1RkWCGAqVXfC0/+UJcwLX4Q/vUd
         bocS0lmQ1oCcWscn7HRIYHBFg2wDoaIp9GZP+tYFWwqHKlomOMVyPfRye32xMu5dH5Al
         64CDTPVJcpJjpsRG9VhqyEt1PzxroenjEuTKTZPTkNW0DB6m5Zk6V+lzf7F1RPb2SerQ
         UW+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763419638; x=1764024438;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IgOprM20p142HerI0wr78gS0iVMLCiuLJeQSKJuE034=;
        b=D4/07WHxkqkP/U5ajTEvPFnZ3gvIBzY87wwl59g9cNy/fNJyT+RePYSKGejb3wH6C7
         AZanbYL+ev9lc788nCqybNqHzyI9RMD0Eg702Z9UoNDsJmkBbuRrVNBtnRrdmPydxXxX
         jOnF67YlT8DCYfr0mLu8TQH0m8bjcF9asQsx5+Ba1Bv1tcuttHwblkzkYv5dOQg7b4J1
         /AJUC0cTzKU3s8y6zwGcqJbk+vrkqilGTNKOHRjrOylrD6CEmEvty6WkzskrzQOsxntn
         HqxIhJ2/bofoRaf1rqqDWoV2u/xBlBOFHiOL6g0LlDoHMGIdshgbD8A1Vw5atTPpLQZ6
         ak5A==
X-Forwarded-Encrypted: i=1; AJvYcCXmWPKwuV6thLWnLmGoj9QfSZpOUVouUihU3ZHgXAtNm57f1tj1juMkYKMXFHVQFB3dOwxpNiuIXhN6g+N0@vger.kernel.org
X-Gm-Message-State: AOJu0Ywy44p6UVqFTnkm9nk0pMpsSqVANPeodwEZda2ex0qYDQ+uuXQM
	CozCmA4eMKx5GAh7qgTrdrcw6JyRQzz9u8oETVQYAmpsJUSxsNd18xOx8CWRZ20iMbF/dThQFNs
	KGfAw3qlU7cmMzS44NvGzXP0Hrw==
X-Google-Smtp-Source: AGHT+IFt4bVWCbvV/lEzgpQt0fY3yUVaqZMHxZy+py5k3Obvyp7sDCutsUiYmrIPPvg3OqxNSYChRny0dADI/4XOEw==
X-Received: from pgcz6.prod.google.com ([2002:a63:7e06:0:b0:bbe:55e3:6800])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:a10a:b0:344:97a7:8c5c with SMTP id adf61e73a8af0-35ba2692141mr16860636637.48.1763419638413;
 Mon, 17 Nov 2025 14:47:18 -0800 (PST)
Date: Mon, 17 Nov 2025 14:46:59 -0800
In-Reply-To: <20251117224701.1279139-1-ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251117224701.1279139-1-ackerleytng@google.com>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
Message-ID: <20251117224701.1279139-3-ackerleytng@google.com>
Subject: [RFC PATCH 2/4] XArray: Update xas_split_alloc() to allocate enough
 nodes to split large entries
From: Ackerley Tng <ackerleytng@google.com>
To: willy@infradead.org, akpm@linux-foundation.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Cc: david@redhat.com, michael.roth@amd.com, vannapurve@google.com, 
	Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="UTF-8"

The xas_split_alloc() function was previously limited in its ability to
handle splits for large entries, specifically those requiring the XArray's
height to increase by more than one level. It contained a WARN_ON for such
cases and only allocated nodes for a single level of the tree.

Introduce a new helper function, __xas_alloc_nodes(), to centralize the
node allocation logic.

Update xas_split_alloc() to determine the total number of nodes required
across all new levels, then use __xas_alloc_nodes() to allocate them.

This change removes the previous limitation and allows xas_split_alloc() to
allocate enough nodes to support splitting for arbitrarily large entries.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 lib/xarray.c | 52 ++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 36 insertions(+), 16 deletions(-)

diff --git a/lib/xarray.c b/lib/xarray.c
index 636edcf014f1..b7c44a75bb03 100644
--- a/lib/xarray.c
+++ b/lib/xarray.c
@@ -1028,6 +1028,27 @@ static void __xas_init_node_for_split(struct xa_state *xas,
 	}
 }

+static void __xas_alloc_nodes(struct xa_state *xas, unsigned int num_nodes, gfp_t gfp)
+{
+	struct xa_node *node;
+	unsigned int i;
+
+	for (i = 0; i < num_nodes; ++i) {
+		node = kmem_cache_alloc_lru(radix_tree_node_cachep, xas->xa_lru, gfp);
+		if (!node)
+			goto nomem;
+
+		RCU_INIT_POINTER(node->parent, xas->xa_alloc);
+		xas->xa_alloc = node;
+	}
+
+	return;
+
+nomem:
+	xas_destroy(xas);
+	xas_set_err(xas, -ENOMEM);
+}
+
 /**
  * xas_split_alloc() - Allocate memory for splitting an entry.
  * @xas: XArray operation state.
@@ -1046,28 +1067,27 @@ void xas_split_alloc(struct xa_state *xas, void *entry, unsigned int order,
 		gfp_t gfp)
 {
 	unsigned int sibs = (1 << (order % XA_CHUNK_SHIFT)) - 1;
+	unsigned int shift = order - (order % XA_CHUNK_SHIFT);
+	unsigned int level_nodes;
+	unsigned int nodes = 0;

-	/* XXX: no support for splitting really large entries yet */
-	if (WARN_ON(xas->xa_shift + 2 * XA_CHUNK_SHIFT <= order))
-		goto nomem;
-	if (xas->xa_shift + XA_CHUNK_SHIFT > order)
+	if (shift <= xas->xa_shift)
 		return;

-	do {
-		struct xa_node *node;
+	shift -= XA_CHUNK_SHIFT;

-		node = kmem_cache_alloc_lru(radix_tree_node_cachep, xas->xa_lru, gfp);
-		if (!node)
-			goto nomem;
+	level_nodes = sibs + 1;
+	for (;;) {
+		nodes += level_nodes;

-		RCU_INIT_POINTER(node->parent, xas->xa_alloc);
-		xas->xa_alloc = node;
-	} while (sibs-- > 0);
+		if (shift == xas->xa_shift)
+			break;

-	return;
-nomem:
-	xas_destroy(xas);
-	xas_set_err(xas, -ENOMEM);
+		nodes *= XA_CHUNK_SIZE;
+		shift -= XA_CHUNK_SHIFT;
+	}
+
+	__xas_alloc_nodes(xas, nodes, gfp);
 }
 EXPORT_SYMBOL_GPL(xas_split_alloc);

--
2.52.0.rc1.455.g30608eb744-goog

