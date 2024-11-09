Return-Path: <linux-fsdevel+bounces-34112-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 503839C28AC
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Nov 2024 01:13:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3A53B22523
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Nov 2024 00:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CF7E33DF;
	Sat,  9 Nov 2024 00:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UMU5aiw9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A8817FE
	for <linux-fsdevel@vger.kernel.org>; Sat,  9 Nov 2024 00:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731111223; cv=none; b=YRnBGLLMoSRhN6E3rVYpm+xCbMH1e2hiPqLPUCeUKNy0YJXObFTsDl+G0+JMH3/ayuLHKfCu8f3mfJMSybFpxzIyN28QZfrgtcyoSAnyf6JgP454q5Img4A8lxce5ohSpNYtqnRFvoVK5sxMeTGswmyT8sAtA78NSSLs9vanf+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731111223; c=relaxed/simple;
	bh=+xKp3CYBPlrr1NwWlw8hM9QKftbbN3hxcqGKB0upoUA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dq0/YvnBd52Ql0NUrFhsnX3IvUDv+llr3wH31cUGH6kU0dDtlFgNuBHV9Bal3v9Wqg4cUUvkRGmDntRA3k/ftLLep2IljgjCXTTjDXfX+xDgZghetJO7pMk2OdxINT9xezZim8oQNIpgRF6zbVqvU0pF711FNkP9AThVznyKcy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UMU5aiw9; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e29687f4cc6so2689213276.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 Nov 2024 16:13:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731111221; x=1731716021; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1zq2JHnawxKVzMEkxsATEgh7nnGTddz5f9xYMm7Tygw=;
        b=UMU5aiw9tQGryP2Tl1O1k1K7i1+jHgugE3EYcrZGAN+3cf+vCVThR/VPBZIxp6KJJF
         x73UWhxC/9MAeMHOy05RiwG0JPT6DJ/9HmWHvTGmHl7LvzWutHCkJPozo9eefANA5wHb
         plMaCGgBfsKsgjSb5u1+ieSMC03QQyryx70k7MLU8Rzbilw8qUazkUh4UI/YE64kwRo5
         xyWtgxjGcFRurFA5glk35GrnhvEssiKDVqer4ptBQP2nA2f0IZg+iJSli/2Mz3F7my2H
         WIoaGljShc65YD7h/GRl5OVZJ1ojaqFDOHBaq+lR8QtnPuNaLGgmwOO0QjmencZ11qLt
         QWCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731111221; x=1731716021;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1zq2JHnawxKVzMEkxsATEgh7nnGTddz5f9xYMm7Tygw=;
        b=YauD3/f1rPCqFjg2nh//9Ek0mKi1ueebDC7zk8uAMLGLeA6H412otkAHCBBkoGRmkw
         xz9Nv0uRy4upQeSKBsYniEWF1m20VzEG4rTs88awpaO8+3pyj0rK+R8srlbmPiOR0jet
         IfDgTH+4r0QmQUutNZb4kNTOiqPlZltLCg/5kd92aNgFzVheCbg69io15krMkfQpHLhT
         qi1CPwwcgBWHOZ3E3axO05ZJjE8LRNe0z7di4F4mb7D1Rgvh1rSPLMsPuFK4Z2Pgspna
         T9haqXHbpkbulV5dHOkgL06tF+gD7i58xn4+Lia1a6xKB0n/Zf44tnrqoANOqPpjj8T2
         GSLw==
X-Forwarded-Encrypted: i=1; AJvYcCW0AM++Wo320PJaWX1xdmLE7g3TN2FMolRo50+zVwp69r89qAiQ/Dz9Y9tAw+dxkwCbTQVz5mJHiP68PBdv@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9sw1J+0w6DCO4hxuWQSqKcRBPhIPCDyHR3rOjo8PxOkbJL5HB
	rbz2QbtGFsFCZcwg+xhwUeIhf7ko4KQq7hpaBhKaaVlOb06egMjd
X-Google-Smtp-Source: AGHT+IHt3CECjc0LvtErN+zNsDWUlnT2nINWdkDh2DI0sc2U1xUk6pEKLRjlwIMDsVLz9YrA0ApDsw==
X-Received: by 2002:a05:6902:a0a:b0:e33:2605:f826 with SMTP id 3f1490d57ef6-e337f873c8bmr4561170276.23.1731111221150;
        Fri, 08 Nov 2024 16:13:41 -0800 (PST)
Received: from localhost (fwdproxy-nha-112.fbsv.net. [2a03:2880:25ff:70::face:b00c])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e336ee20911sm898505276.8.2024.11.08.16.13.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 16:13:40 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Cc: josef@toxicpanda.com,
	bernd.schubert@fastmail.fm,
	jefflexu@linux.alibaba.com,
	willy@infradead.org,
	shakeel.butt@linux.dev,
	kernel-team@meta.com
Subject: [PATCH 02/12] fuse: support large folios for retrieves
Date: Fri,  8 Nov 2024 16:12:48 -0800
Message-ID: <20241109001258.2216604-3-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241109001258.2216604-1-joannelkoong@gmail.com>
References: <20241109001258.2216604-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for folios larger than one page size for retrieves.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/fuse/dev.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 9914cc1243f4..5be666af3ebe 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -1719,7 +1719,7 @@ static int fuse_retrieve(struct fuse_mount *fm, struct inode *inode,
 	unsigned int num;
 	unsigned int offset;
 	size_t total_len = 0;
-	unsigned int num_pages, cur_pages = 0;
+	unsigned int num_pages;
 	struct fuse_conn *fc = fm->fc;
 	struct fuse_retrieve_args *ra;
 	size_t args_size = sizeof(*ra);
@@ -1737,6 +1737,7 @@ static int fuse_retrieve(struct fuse_mount *fm, struct inode *inode,
 
 	num_pages = (num + offset + PAGE_SIZE - 1) >> PAGE_SHIFT;
 	num_pages = min(num_pages, fc->max_pages);
+	num = min(num, num_pages << PAGE_SHIFT);
 
 	args_size += num_pages * (sizeof(ap->folios[0]) + sizeof(ap->descs[0]));
 
@@ -1757,25 +1758,29 @@ static int fuse_retrieve(struct fuse_mount *fm, struct inode *inode,
 
 	index = outarg->offset >> PAGE_SHIFT;
 
-	while (num && cur_pages < num_pages) {
+	while (num) {
 		struct folio *folio;
-		unsigned int this_num;
+		unsigned int folio_offset;
+		unsigned int nr_bytes;
+		unsigned int nr_pages;
 
 		folio = filemap_get_folio(mapping, index);
 		if (IS_ERR(folio))
 			break;
 
-		this_num = min_t(unsigned, num, PAGE_SIZE - offset);
+		folio_offset = ((index - folio->index) << PAGE_SHIFT) + offset;
+		nr_bytes = min(folio_size(folio) - folio_offset, num);
+		nr_pages = (offset + nr_bytes + PAGE_SIZE - 1) >> PAGE_SHIFT;
+
 		ap->folios[ap->num_folios] = folio;
-		ap->descs[ap->num_folios].offset = offset;
-		ap->descs[ap->num_folios].length = this_num;
+		ap->descs[ap->num_folios].offset = folio_offset;
+		ap->descs[ap->num_folios].length = nr_bytes;
 		ap->num_folios++;
-		cur_pages++;
 
 		offset = 0;
-		num -= this_num;
-		total_len += this_num;
-		index++;
+		num -= nr_bytes;
+		total_len += nr_bytes;
+		index += nr_pages;
 	}
 	ra->inarg.offset = outarg->offset;
 	ra->inarg.size = total_len;
-- 
2.43.5


