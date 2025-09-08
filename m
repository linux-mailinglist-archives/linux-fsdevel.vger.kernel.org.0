Return-Path: <linux-fsdevel+bounces-60586-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FF59B498E2
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Sep 2025 20:53:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B234B3B133F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Sep 2025 18:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E8A232038D;
	Mon,  8 Sep 2025 18:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E44BwjB2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E92F32264A3;
	Mon,  8 Sep 2025 18:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757357546; cv=none; b=QIx2dmo0pbSUxLIKi6NnELFH5gfnafhu1PBQTvCNh74JlWpPy6MXkvHxDyTQPlqhaMUddqZlRrAXVy9CsO06DOElofLuLAIqMGExknyOJ7dsZwgaQzI8ocwBNxvfglkXms1JM44fia/LPo0rxSQuGJj4ZNN4jOCPQw0zkQw8S5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757357546; c=relaxed/simple;
	bh=AzP6wIhsfCMv6GgiBHJJ9xI5qf9k06WzrDIB8putFD4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n8l7dAnUV+K6mrYbrc8ljMCs4c2/e4/+a+J0537cAEo0BpkwPv7RD5lXILZ+VRNCWRHy/JMj8zCEzmfz3RFNKajckAgl1OyANzseWeXMEhflQww2iiyt3GYmOP2u+n5DKgEdjwNsn3TqomjKZKYgd1RUuNbgRs3FUamtsuL57gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E44BwjB2; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b5229007f31so1313186a12.2;
        Mon, 08 Sep 2025 11:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757357544; x=1757962344; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nXe/e51gNFNgtjm8LXJWMHURg7TDHqHIgvxmJBN741w=;
        b=E44BwjB2zZfeA6hgwOP3cXZi+tJH9ga7euIuPC6ZbrVBBnXqCXdV8O8cGemoAVZFYp
         9PoOLlUaCzVWHrGBTHTPEaZG7EUI02zrSG2+hSZLVb81HPTOLt+/WD24/NENuZgUysNQ
         dmJ0WCYqOHGReqJ0cU4kvju9+Mges1X6Ed1AkOlJAKd0vVzclNETXrP2zj4wRfgzr3CD
         EfzyDm0OlW5h6kTYllaEBaOTJIjVroczjIBDE0mxp1tW24FgTkWrKdA9yzdAXGPzbIEL
         d95iJcNXDZBYCa983NMaMKSzv4ecSCX7RItRQ0tmBxYnQnJQlmL7fr+ziUEQRbHZAONC
         NpPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757357544; x=1757962344;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nXe/e51gNFNgtjm8LXJWMHURg7TDHqHIgvxmJBN741w=;
        b=hx8NXgg/9eINtQHxtKEANcYOctqUa2cMnaOuCwNkp1JIDPOJG0y2rFu0NJoZQrzQWd
         9YBOm1x0k6Xyd2x5NPCWF3n1F85qLJ9cwofoq1Qc96ibyxlkyMToP8Zsivn3G4z9RQy+
         51/e6gyKZU0j5VHv69og3h/DPrMxmsUcOdJKqdxUeKpYogQOjymuL93O/hKjSKQA9/ej
         UDGYP+uoTXKG3D/HzVrQBdsF1QQ6DEDzLnxw0STAPz4YnFZnbRCgnCBIzU+XVlsHXiz/
         vhsSps4RifqE3Bln0MVr0jLyXRF/RRRfQE7A1GY0cJ+aGDRB3xh3/qWmOk+Xi+1b8+C8
         8TWA==
X-Forwarded-Encrypted: i=1; AJvYcCU2AVAxwkZLFBA5Mv5dteV5QjrufR/pm9dvFoOz2xkjiLzpOSVXGHa+/0cu8YavA6oJGPmm/Ndc/4j2@vger.kernel.org, AJvYcCUMTRk8o4koW9z+aXQHo6b2cCRsxpdxz61XxDzMDCLMpIVAyQKJUQy1lQfacAi4SIn1iDuml1Wt4ZU/@vger.kernel.org, AJvYcCWNyeei5P2WJy1VUS5P3NLUAICc7DZz353WDFk77RwThL2XzlT+Pxq++v9hp47orJQVWERtuXpoKLWYy4jH9g==@vger.kernel.org, AJvYcCXQgicOwN0S8Cvap9VhKlYuBTUznJxCxjb1LaQVPHRGKweFuFAcm+ZDyV0awNl3484iI1z8Ix4guH3W3Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YwplMeBRRB93P6MV1AR3WmjL3rUCpVhmyjNrZBsVjaO20zt6J3x
	JZaMSrNTeXD3K+BglX3AQVZL6donfLjsKBgQZRvifiA8OCjNZWY6pXuD
X-Gm-Gg: ASbGncsRLrFGdwukJgmnfeW700GBUoGvh6T8Pfe0tgidVa6c8VbYTYQNa0aaP+CAqtu
	cbRYtO5x05kd5NxQgiNyQjqbuvNPCQj2YzcKZVlfh73SJY6WC5KwxP9WaywtVsXRr+v0Ya4sDLi
	HAvKp8Fvvko9jWnmhzOL67e9g9Imhw/PHI503PerGR9M4axMKSBPzXWDww6/kS8gC+5gagk9cCy
	zybfUABDam7hGLpb4GxNq70LIW4seW004o/BuNiXGoJazsI3y9wtG+lPaKWFf38vVbNaorgzBYU
	4mfScWu+/lL/+g9wBWF/4dkTL38WkIKpVvhgpsO5mZTVVz7lbjHoEcAqy7M8MDaszGsZcyk4Y9B
	ULFohRbvRdRU6H5iQuAVE9BWCabFS
X-Google-Smtp-Source: AGHT+IHfaouKKNXgATrlBmub3luWLowfDYAilRWQ/VG6KFRMkRa972NbFxFR3iGutKYJlxXCE9pMJQ==
X-Received: by 2002:a17:902:ce03:b0:24c:bc02:78a4 with SMTP id d9443c01a7336-2516e98142dmr132772265ad.24.1757357544102;
        Mon, 08 Sep 2025 11:52:24 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:41::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7726a3fbb32sm20348401b3a.53.2025.09.08.11.52.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 11:52:23 -0700 (PDT)
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
Subject: [PATCH v2 05/16] iomap: propagate iomap_read_folio() error to caller
Date: Mon,  8 Sep 2025 11:51:11 -0700
Message-ID: <20250908185122.3199171-6-joannelkoong@gmail.com>
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

Propagate any error encountered in iomap_read_folio() back up to its
caller (otherwise a default -EIO will be passed up by
filemap_read_folio() to callers). This is standard behavior for how
other filesystems handle their ->read_folio() errors as well.

Remove the out of date comment about setting the folio error flag.
Folio error flags were removed in commit 1f56eedf7ff7 ("iomap:
Remove calls to set and clear folio error flag").

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/iomap/buffered-io.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index a83a94bc0be9..51d204f0e077 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -500,12 +500,7 @@ int iomap_read_folio(struct folio *folio, const struct iomap_ops *ops)
 	if (!ctx.folio_owned)
 		folio_unlock(folio);
 
-	/*
-	 * Just like mpage_readahead and block_read_full_folio, we always
-	 * return 0 and just set the folio error flag on errors.  This
-	 * should be cleaned up throughout the stack eventually.
-	 */
-	return 0;
+	return ret;
 }
 EXPORT_SYMBOL_GPL(iomap_read_folio);
 
-- 
2.47.3


