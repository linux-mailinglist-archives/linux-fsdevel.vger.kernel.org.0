Return-Path: <linux-fsdevel+bounces-28915-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E84497096E
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Sep 2024 21:24:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A426A1F21643
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Sep 2024 19:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 636AE178CE4;
	Sun,  8 Sep 2024 19:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RH7DVrYY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53DF4177991;
	Sun,  8 Sep 2024 19:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725823436; cv=none; b=Onado79lGRmFAxYuyut6nN2NfvTqiSHLH9d+M83A64MDbUmbCS8hFUt10eV5TpO88BbhpGok0+C8dipRmvwaacaxGphH/P2uIjGCr8q5DbxiddJvTWsH4XSMbyAQIAhTxO0Tm6rvm77ubu1lRJ3OJaHUMKp+QRlRwY8ipMS7gvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725823436; c=relaxed/simple;
	bh=m/W0s303G6CAVDATz7o5LzmdnZ3kzZdIQCH0Cbz1fgQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Mv75iY3ABj1JsWlWhXfp36/eN6Sz+mPBAph8Z0v4/rsO/fGlZ3+xpO79x5P7CwXImwmZRcj8NvlYhI2Ou9w9QfMwA5NriyU5GF4WSGsNjp7ClXRIwOPU61z3n9JcWTi7DnPvpa5V9PV0KlZTB8hWcKLTfmFF7grZCfq2jP3256k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RH7DVrYY; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7a99de9beb2so119103785a.3;
        Sun, 08 Sep 2024 12:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725823434; x=1726428234; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JXrFgzwbiTSr4Ylz2mlW0T8OOl+bUrZIiSty64NIZsA=;
        b=RH7DVrYYBDtING8D4bs6m4l2mVr6oALwVsqQj/ONyBNQkUeuuV6KEQJ/LgrKAnX7a+
         2UtDHUII+Ovo0NqfoGtdxntd+dJwvsGl+E57UCRBz6wA7l/wkIeUH0JhJ0HeGXndbZ+9
         mc2o5FDp0VtLG7wcca7Pi92DAN92tXw7Xgju+sI74M6nL6M9fkk+9QOS8jhvn5Urklt4
         MnHTnzU0xFuSRJRSRfxJeQVgv9Spb4i+U3unv4eacfJZ493iBoH43LfEAQMISmbT/Uvw
         6JWDnPOeZJ1rpxavjurTWfhfXRVGZAbSA2UcKHI2ZKt5rnyjTyLuzC/B5ibOCo/619Qt
         ABmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725823434; x=1726428234;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JXrFgzwbiTSr4Ylz2mlW0T8OOl+bUrZIiSty64NIZsA=;
        b=ROd5KGfX2ZTDJOdCsAulBOqjIbwegMpWH7YxCRL1PXZxrTcfUC3WiMqnSEOb8H+dcl
         YqE7tYWLYAZsN5q5L3n9w5PlQ0FfC3Bdp40HEZ6ZJjfQpUCmcGqAviimHVqhRMt35Sp0
         SXUoCsrmlUIZBX/KRrQdim1MbeSyHB0k8HroNuh5rbDGHW3S0eWxN2XD+84QqjNowxuf
         Edb5fMW11Xnx0Ag8jX699PJQA6SRyNSDuDzNiF7EN8sukSayaR+AvpZlnlwg7dpZJ9yb
         46X+BFsZ1mWqIA0nGp13PsXHxXM6aBhN7aBdaCERmg0Kn0C5Myd2BQsQ6tOr4kP7IqwT
         xL+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUTq4yClqTLYZp6U7Xb0ldtdVUMrTywuDaCDCKE4RhTWiN+sDSmXbLLqxICMjs8H6HbjSCB8hctzldZ50141A==@vger.kernel.org, AJvYcCUe+PKQsDUc14MbDy0Kh64tOMTHwpapFpiiAOJ8WaMuHlVD03nZvLGu2jqhxozb8CpVItuRml+heNc=@vger.kernel.org, AJvYcCVfoOeSNxvemZxJPIZ4gcCk8ltcraI+G+A9n0ViWEwXtHfVqcg+pcxARY/IRAeY0DM7SkEBzrP7yaNvES2c@vger.kernel.org
X-Gm-Message-State: AOJu0YxlLJmQsHZk+shldToXLVq9cy6uecMTl97WkQ3ef1K1uWteUR9U
	i11Y1IXIymhfpRW1OqaQsUBQ+wbkL/QwvSQrXQpoq6ai8ReUvI1Y
X-Google-Smtp-Source: AGHT+IGgKnSGL4uaFiJd97SurDl/WRYL/3PCh4JiAicvu+wT8MBh5XrPuZh99WHUqGS9aW7p6JSFXg==
X-Received: by 2002:a05:620a:40cf:b0:79f:793:9a63 with SMTP id af79cd13be357-7a99737a8ffmr1464157785a.44.1725823434041;
        Sun, 08 Sep 2024 12:23:54 -0700 (PDT)
Received: from localhost.localdomain (d24-150-189-55.home.cgocable.net. [24.150.189.55])
        by smtp.googlemail.com with ESMTPSA id af79cd13be357-7a9a7969043sm151309485a.44.2024.09.08.12.23.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Sep 2024 12:23:53 -0700 (PDT)
From: Dennis Lam <dennis.lamerice@gmail.com>
To: dhowells@redhat.com,
	jlayton@kernel.org,
	corbet@lwn.net
Cc: netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dennis Lam <dennis.lamerice@gmail.com>
Subject: [PATCH] docs:filesystems: fix spelling and grammar mistakes on netfs library page
Date: Sun,  8 Sep 2024 15:23:09 -0400
Message-ID: <20240908192307.20733-3-dennis.lamerice@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Dennis Lam <dennis.lamerice@gmail.com>
---
 Documentation/filesystems/netfs_library.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/filesystems/netfs_library.rst b/Documentation/filesystems/netfs_library.rst
index 4cc657d743f7..cc8e7a249de5 100644
--- a/Documentation/filesystems/netfs_library.rst
+++ b/Documentation/filesystems/netfs_library.rst
@@ -111,12 +111,12 @@ The following services are provided:
  * Allow the netfs to expand a readahead request in both directions to meet its
    needs.
 
- * Allow the netfs to partially fulfil a read, which will then be resubmitted.
+ * Allow the netfs to partially fulfill a read, which will then be resubmitted.
 
  * Handle local caching, allowing cached data and server-read data to be
    interleaved for a single request.
 
- * Handle clearing of bufferage that aren't on the server.
+ * Handle clearing of bufferages that aren't on the server.
 
  * Handle retrying of reads that failed, switching reads from the cache to the
    server as necessary.
-- 
2.46.0


