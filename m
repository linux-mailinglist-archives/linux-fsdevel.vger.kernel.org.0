Return-Path: <linux-fsdevel+bounces-24598-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 161989411AF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2024 14:19:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 627ABB24ECA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2024 12:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26A8519E81D;
	Tue, 30 Jul 2024 12:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Am8G9Y6S"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22231957F0;
	Tue, 30 Jul 2024 12:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722341983; cv=none; b=RrCX2Jh+wPHkr2shg/Y0na80UyVe7zb2aQD58Onmij8tOyr1EsKWNsKsup65KaaDlCTRlbV8kQQd4YOU2fX4lvPmA1infbCX6I8LayHzFM4TLNFNUP0SXTaNGbMoepDi7VIAF6svYNWpJBdNUFuxeECbl/+9RsJ7k5S+g5XnxHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722341983; c=relaxed/simple;
	bh=Na6bYBOwEr1UOvSI96Mi3YFL2ql7LlGEgYQvcbyWNgk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EYqK1rKn4TsrBOh2R30biiQVDsWL3XWfvJAHkWTuYoAIPxiF37DWoFZvCJd54kkzz75PcS46AWvzPi4iSSq88NzfeRuvV3eWQiAy0xg+gDfQCEWCST+XTZtE7C3KVQVx2GYGb2FJ1A3lF1k6qH5dIw/pEN0/6vKW7n0iEuLguYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Am8G9Y6S; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a7d638a1f27so159395166b.2;
        Tue, 30 Jul 2024 05:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722341980; x=1722946780; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zhzbbMF50wjWGe/fOseTA4c3yfyiRq1RlDd9IV2SLmk=;
        b=Am8G9Y6SHXJY9R/me/DZVm0e0gCN/BZCAL33MYPirHtADR97jEcC5AqYBRzUCocaMQ
         gCsb9QtMa5ad1aFuIFqnWiiQjawI1WY5u9bLSbCEcDU0Joa5plhXZ6ZEJWtNGaVw+qIj
         Va4qFYj8q7uO15lsjOctzAzXaI1lxUVM+FtouHwaTvdMFeeeC3uDE1BbjxLeA7U1imWV
         joSXdl8QC5QQSEp2qgx6t0M5xoYlvMC/s5Ow2P0JGRp2D5U+tLTF1QRBTFjknjteu0UE
         uv1yt5qhOFsjEE3qIvoIOEoOdeycaHkF3AdnEplwSkQofgDPMRTrtISd9XQguZq9zQnX
         coiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722341980; x=1722946780;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zhzbbMF50wjWGe/fOseTA4c3yfyiRq1RlDd9IV2SLmk=;
        b=d6N1faSoIx34ZV2hY2dZa4lHsv8AdizgQ5xSWTKeSDSJdXYOXWzvy8L+PNfuLgCALP
         EYWufxF8ab6P8/w6yS/2PbzUwI6nzcOkFHWnB3jyhiLixf4ZsIz67v3/puW92hAhXnm7
         GmrdeDqcwdtxShiZHdO5vW9k+uSAqy8u5iaVcVCBUV3bZXnWgst1LbVnGyrCpCUNyeCl
         MDuCHBvGuCkmEjViY8q+AUjZcmqrsZxsMsXJ9WTWo63J5dEhweXepOTeFXcb7LXErWWV
         JcojOsEW97b8afcQpdcMqAXneqc3N7Ja+Q2xp2BXdfaBhO0sZAJpr8TCf4MBK33p1r/5
         hXvg==
X-Forwarded-Encrypted: i=1; AJvYcCVhgvhWihtgd7L0M5cYQKPYDRvmhH++DOA0zNuluUxc147MCqkjDnADXTu6D5JcBud702LV8WjRtCEBMkTuZEeegesWhiYK9WZNx8tTdQ4R8l4FZcO/qcH1Fhgcb4nDsm/gxxz6WyhtWCpGrg==
X-Gm-Message-State: AOJu0YwpaeYIpjopeprtI5g2obB+Fn52oUhZxU/SGN6U5Uo2n1AglGAc
	oA421w9zALsiPdtPiYdOu8ggrYT6VkNnZY+aFAAxLk4aIO0h5QGt
X-Google-Smtp-Source: AGHT+IHfRp+O14nVgEID49LLxSuex4Ar8OcA5hfvS5NVNTLKChUqfW6WP4zhDTMwJhCu3zBkgzGQRg==
X-Received: by 2002:a05:6402:50c7:b0:5a0:f9f7:6565 with SMTP id 4fb4d7f45d1cf-5b021e1745dmr10267734a12.21.1722341979914;
        Tue, 30 Jul 2024 05:19:39 -0700 (PDT)
Received: from localhost.localdomain (93-103-32-68.dynamic.t-2.net. [93.103.32.68])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ac631b0395sm7224733a12.20.2024.07.30.05.19.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 05:19:39 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: linux-aio@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Benjamin LaHaise <bcrl@kvack.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] fs/aio: Fix __percpu annotation of *cpu pointer in struct kioctx
Date: Tue, 30 Jul 2024 14:18:34 +0200
Message-ID: <20240730121915.4514-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

__percpu annotation of *cpu pointer in struct kioctx is put at
the wrong place, resulting in several sparse warnings:

aio.c:623:24: warning: incorrect type in argument 1 (different address spaces)
aio.c:623:24:    expected void [noderef] __percpu *__pdata
aio.c:623:24:    got struct kioctx_cpu *cpu
aio.c:788:18: warning: incorrect type in assignment (different address spaces)
aio.c:788:18:    expected struct kioctx_cpu *cpu
aio.c:788:18:    got struct kioctx_cpu [noderef] __percpu *
aio.c:835:24: warning: incorrect type in argument 1 (different address spaces)
aio.c:835:24:    expected void [noderef] __percpu *__pdata
aio.c:835:24:    got struct kioctx_cpu *cpu
aio.c:940:16: warning: incorrect type in initializer (different address spaces)
aio.c:940:16:    expected void const [noderef] __percpu *__vpp_verify
aio.c:940:16:    got struct kioctx_cpu *
aio.c:958:16: warning: incorrect type in initializer (different address spaces)
aio.c:958:16:    expected void const [noderef] __percpu *__vpp_verify
aio.c:958:16:    got struct kioctx_cpu *

Put __percpu annotation at the right place to fix these warnings.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Benjamin LaHaise <bcrl@kvack.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 fs/aio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/aio.c b/fs/aio.c
index 6066f64967b3..e8920178b50f 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -100,7 +100,7 @@ struct kioctx {
 
 	unsigned long		user_id;
 
-	struct __percpu kioctx_cpu *cpu;
+	struct kioctx_cpu __percpu *cpu;
 
 	/*
 	 * For percpu reqs_available, number of slots we move to/from global
-- 
2.45.2


