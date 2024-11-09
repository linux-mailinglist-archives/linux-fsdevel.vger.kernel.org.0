Return-Path: <linux-fsdevel+bounces-34115-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABAD59C28AF
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Nov 2024 01:14:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 177AEB222D5
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Nov 2024 00:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17B8453A7;
	Sat,  9 Nov 2024 00:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C3f+rTJM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191924A1E
	for <linux-fsdevel@vger.kernel.org>; Sat,  9 Nov 2024 00:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731111228; cv=none; b=ZQkdqdRmbjKZ0dC2NQ4zK9mEZVSdRfqEdSuUIykU5DzkhRuNajxR8Q831OEME5sjbQyBxT44oxhYJCOe0pWtV9ZTMM8xYkz+QbqiVeZUAjKm72Va+UM7l9DAF7qvxdadNn0essJtHpUXf8KHTiQfOgR9BjV7/77uR9bW7jVL8XU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731111228; c=relaxed/simple;
	bh=ylITfFLJ65tewDbFcAB+D+4nBXZqswDNP4LcxXdd2M0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pbxrx0jvkdlgCFahP2CBBW6V4jcPo7dTT7TeKvaSGaTiMcqQLFe5xqrC6oxNKVw8RobDDdvpZpyweCPMcRQIQZdfvaMkqs7PHePoUu6fPWyxm8y01UWGoqDIVvzXnkmo1nuNZAYiigCcGazUdXYmA5Seoid3+ygHkxKCoadmISE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C3f+rTJM; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e28fa2807eeso2786956276.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 Nov 2024 16:13:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731111226; x=1731716026; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FQUHw1Z8Y07Pw/jGBhMnupfm1VKH725NM4ibcSiLPBQ=;
        b=C3f+rTJM3cZ23/2bdrWZpxj65xaGWgp6RH9kcdyYeMY5ALbIwCbC1uR6TU01Ao5Y2X
         j5RR3jew733oVhIvUMSGUutevDjCY2ZLiPin2M5sePtVI5lv8LilHnFYML5rvylNwPq8
         4QwHnzGjzjFmgPUeGfC9zUIrzRSS6gVG+d2qOFkqsloZUOiVp9O2CnBKK6Q040kbvCHo
         8A8F70YgOjlLYQdGFqp61fx601muKnqgGSGlFsGeSCiip9dlJKAxOZMKyHOfv/G0Lomc
         Jdy0xbk2/zApJtnWS0yFnJIDNdAtuYIDIiG/CAXPEjxavD5bh8Vo8FbwaE/ZiqMuAo/c
         fTMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731111226; x=1731716026;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FQUHw1Z8Y07Pw/jGBhMnupfm1VKH725NM4ibcSiLPBQ=;
        b=w/CYA5ZDdaAPc1zl9cy0X3uhgJgYg1GZse+GrnbHM8U7JHCLbgcOKxFGQbGpMJ9W2t
         F4PwLoeoD0LSI/KMevSkVvYrkQJU+9Y+aP16wfQpEyuFPsRUWJk+letuAlwm4K3/WkL8
         gqYTZE7e/G+/SxMYAz8x9lhJtZjiaxRe/gE8ytIpds00RC1GXLmIFwVIOh8+exlkSIL8
         WcJc24zMilLom7KIFR14joBarZtYWj9S+gZODY//Av/Qj13LK+h0zoeTcZqRCFZuDOGp
         TlTOL6zk9FInFyIC2vB9e9JsbypuNVGhvUylOy4sQdw2Ji9Vd6sFTlLANJY8U8NlpZxF
         0onQ==
X-Forwarded-Encrypted: i=1; AJvYcCWcc8jodfB6WZYdM+w8/Fh6h4N0nRbsyWeR+Qeytzi94yyI6Y3e4FD+UbWTmwoaLZR6mpa8ppQO3Oo66A80@vger.kernel.org
X-Gm-Message-State: AOJu0YwbXBNone/sNSs6xdkll1OetcWqE4DhRK+sgWxkA8VJVkoiAgFt
	h/KnRkxVycP0oG9S0DoeD65YprV3Y4vBfjYUgjdJP8A/JF1JBVJq
X-Google-Smtp-Source: AGHT+IHo6KUglK+KSDAnLEPI0YnlwAFdt5WpZFJ/vE11xgsK/0nvfy72NTpSXquxRaPDO7M53pulVw==
X-Received: by 2002:a05:690c:6302:b0:6e5:bf26:578 with SMTP id 00721157ae682-6eaddd96d06mr54477957b3.17.1731111226108;
        Fri, 08 Nov 2024 16:13:46 -0800 (PST)
Received: from localhost (fwdproxy-nha-000.fbsv.net. [2a03:2880:25ff::face:b00c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6eace8d5386sm9476187b3.7.2024.11.08.16.13.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 16:13:45 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Cc: josef@toxicpanda.com,
	bernd.schubert@fastmail.fm,
	jefflexu@linux.alibaba.com,
	willy@infradead.org,
	shakeel.butt@linux.dev,
	kernel-team@meta.com
Subject: [PATCH 05/12] fuse: support large folios for folio reads
Date: Fri,  8 Nov 2024 16:12:51 -0800
Message-ID: <20241109001258.2216604-6-joannelkoong@gmail.com>
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

Add support for folios larger than one page size for folio reads into
the page cache.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/fuse/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 6ee23ab9b7f2..399bc8898cc4 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -797,7 +797,7 @@ static int fuse_do_readfolio(struct file *file, struct folio *folio)
 	struct inode *inode = folio->mapping->host;
 	struct fuse_mount *fm = get_fuse_mount(inode);
 	loff_t pos = folio_pos(folio);
-	struct fuse_folio_desc desc = { .length = PAGE_SIZE };
+	struct fuse_folio_desc desc = { .length = folio_size(folio) };
 	struct fuse_io_args ia = {
 		.ap.args.page_zeroing = true,
 		.ap.args.out_pages = true,
-- 
2.43.5


