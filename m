Return-Path: <linux-fsdevel+bounces-60588-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79CDCB498EC
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Sep 2025 20:53:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A7F31BC6837
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Sep 2025 18:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC0CE3203BB;
	Mon,  8 Sep 2025 18:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sbw+9S/Z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E44182264A3;
	Mon,  8 Sep 2025 18:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757357549; cv=none; b=NkK6QrUFhkwv4EyNStBn+Bc9BRnmPyh8wYSkxy1Bn7jnErMoyC5etIbPGhhDahwotYvBzUG9TKvGZyEsuIMf3NhI44cigdLgKKzJJe2ZzOSX0NHQxZ0zrWdT64XeCe+EcA8hAABo9PQnYyXFLkQC31ne4cZGg95zlQX8irkbpkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757357549; c=relaxed/simple;
	bh=Vf0sfQGa9NYJS5wi+GNi6XmHISQSVuhQBlSiZgVnGAg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kgTfEAJ1AWewgege7K47u5jCdF9OB/732Xl/4bj20kISPUKqI7Rx0kfpajf17YNqCNPN5NCuHCxcJJaCDoIjeiMZBIH8SDuCoGxctlKPOLPYn33bxbp+sRZEcvIelo3Bb1Lcx4vhg0xsJ9Yf4rqIZYnU5BxNKK82JhRaoIN4Oo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sbw+9S/Z; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-24cde6c65d1so34704585ad.3;
        Mon, 08 Sep 2025 11:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757357547; x=1757962347; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cz0e46H0Amt2P31x/YJ/3yAHE3DoTD0Pj8b5/EZ9tLo=;
        b=Sbw+9S/Z/65EfTzf6qONgAtr+qelQ+Z2dIoiM5ioF8E58Xm+CrSN2OXAafzKOjJ5Tp
         p2yabGePF9xXgpUjq2xYsKwtGHPj50l2ZizY5EPEoiQdZUTTLsS6IvWNOeNF6cwF7cyw
         NCzQLLDGfELH9u+ITcSyzYx1GCTBfsjyXaRC1JXLsZlaxBGnuRA/os6jHdzFUOligMZR
         skyaCDa+HIecVMed28/iZzYF7S78H5EIKonVjag72jiGeHbmfOWQMXarAHkGQGSuM/7b
         AerkbLJH4ZLCfVYVrqmJOnVOVBjskbK2alLK4Jz4QB58Kwpk2EKMM1QUnFPAL2rEkv6W
         b5xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757357547; x=1757962347;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cz0e46H0Amt2P31x/YJ/3yAHE3DoTD0Pj8b5/EZ9tLo=;
        b=UZUmyWVsA+jkF4mG6yB1dTTNGwOXCc7Wgw3PEZFjtvxaVQkjvpMiKa74fShpWdwxAe
         xqujDZCUEKK9BVRNQLaO/SfMNBzdRtzrbUpNWE4ViqoCkatrmbe6pycOW8uSAdweICb7
         WK0mM9oO2rwRyAAG6hVSDSzH0nDPEgcx08FPxw/TPC/hms4YTjnLDIYysFmVKPB1IeVB
         1fZl6FtyAQbY/ME2/f0//Ql3gC92c/LCmX5YYuXfOUUN464iXIclF4gGG+jXlvCIaOYf
         h7gjmnJziL2mWuvb8WMCQxqzcbdB3iqj6zUZ3avEALUtv9RqnnsnFF/DnNXnS4JEQw+s
         co5g==
X-Forwarded-Encrypted: i=1; AJvYcCUPSiVCCjD+thMxbH0Vwsf5eDpCb4M9hU8Kooa7wyqZ67MyLL4Mm0njNvndVcJ0vEjsNWtBJO8FlUKz@vger.kernel.org, AJvYcCUkyTCeoRnw7ECr3nzZE8MwNCUSdmntSHdk5cge7p1skMUSHzBLGp1aKE8qFIlkCXxWvM7daIq2rPmp@vger.kernel.org, AJvYcCW2wgJsiFiG9qtgpRVUIijVG3hKpQ9b4ff1rxsE9bHkOUhbNPd7axkGjQkbYnOxyuWwroMSns0Grm/yXA==@vger.kernel.org, AJvYcCWQ42RerTsVrDFdgzhDmtZpex0W/lUUDQkmnlsCcWlhac4XQ7pSWliQ3AXAj0a+V2GktoCBK2VY2ZceRvQqrQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyfEe99Ovnd/uatsncBU4QB5wgSwXpCIJF2ThrlISHmErgAYiEB
	wYSASFFaW5jWl/KwmxBqM/YkYRRsmXqmnVj0rGaa/uf2SB8dzfwd+twL
X-Gm-Gg: ASbGncuJWkto2cVcxUGViMFjM+9wp+brIlsvdhs9oq6efRXPNA2hJBcydno+6+0afhQ
	DLS63T4AAaMv7q/XCGgYvfDnsksSSRaksDjk6do7hxC6V4xUCOysB8HQ+Bbyudxe99EfWkKUH38
	DG9qWMVFJzEK92U0oVfArK7HmGz2WgkGu4DYfSryGDE2wQTARR9AVxrutiQAUrR1VzbMJfEuDnX
	jF+kDOWbLX0q48yl9YDBh7bozpnx98+SDU3qRtStahaNMpN6D4tfHl9QBBZhYQobPqX1W4zkva+
	VYWkdBwxTyBTT17VJaRMyVZvL2rYTz8lvzcdQ/TeUb1NNyWx4BvhhmCAiKXpiL5vukXLseAR/xJ
	uuEzGidQNdCxBnsEb
X-Google-Smtp-Source: AGHT+IE+l+BXURNmfdy0m2VV1VNkMDGB2osHHSSbmfc0bl8WNEUpwSDjnUBgNzIdhJAO7Jj04uFyrQ==
X-Received: by 2002:a17:902:d584:b0:24c:cfcc:1743 with SMTP id d9443c01a7336-251737d44efmr105556145ad.58.1757357547244;
        Mon, 08 Sep 2025 11:52:27 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:7::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24af8ab7e7bsm190930565ad.138.2025.09.08.11.52.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 11:52:27 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: brauner@kernel.org,
	miklos@szeredi.hu
Cc: hch@infradead.org,
	djwong@kernel.org,
	hsiangkao@linux.alibaba.com,
	linux-block@vger.kernel.org,
	gfs2@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com,
	linux-xfs@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH v2 07/16] iomap: rename iomap_readpage_iter() to iomap_read_folio_iter()
Date: Mon,  8 Sep 2025 11:51:13 -0700
Message-ID: <20250908185122.3199171-8-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250908185122.3199171-1-joannelkoong@gmail.com>
References: <20250908185122.3199171-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

->readpage was deprecated and reads are now on folios.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/iomap/buffered-io.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index fc8fa24ae7db..c376a793e4c5 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -423,7 +423,7 @@ static void iomap_read_folio_range_bio_async(const struct iomap_iter *iter,
 	}
 }
 
-static int iomap_readpage_iter(struct iomap_iter *iter,
+static int iomap_read_folio_iter(struct iomap_iter *iter,
 		struct iomap_readpage_ctx *ctx)
 {
 	const struct iomap *iomap = &iter->iomap;
@@ -484,7 +484,7 @@ int iomap_read_folio(struct folio *folio, const struct iomap_ops *ops)
 	trace_iomap_readpage(iter.inode, 1);
 
 	while ((ret = iomap_iter(&iter, ops)) > 0)
-		iter.status = iomap_readpage_iter(&iter, &ctx);
+		iter.status = iomap_read_folio_iter(&iter, &ctx);
 
 	iomap_submit_read_bio(&ctx);
 
@@ -511,7 +511,7 @@ static int iomap_readahead_iter(struct iomap_iter *iter,
 		if (WARN_ON_ONCE(!ctx->cur_folio))
 			return -EINVAL;
 		ctx->folio_owned = false;
-		ret = iomap_readpage_iter(iter, ctx);
+		ret = iomap_read_folio_iter(iter, ctx);
 		if (ret)
 			return ret;
 	}
-- 
2.47.3


