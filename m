Return-Path: <linux-fsdevel+bounces-18523-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 985098BA249
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 May 2024 23:28:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54B03285AB1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 May 2024 21:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A39B1C65FA;
	Thu,  2 May 2024 21:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="ZFY1pj5W"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54CB81C233F
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 May 2024 21:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714685221; cv=none; b=k1L6dRe5lecng6yYaIsFnBos2cQE2eq2Yy64W68Hpj3Bt/jAGMY4cq4F0R6DkakQKChxoGmaGxxGiFWGA4pnkXuYM7exyMhf2YUbTAFqCPt78Ubyd7NrTvXHHfordKkKZsEzS/ZDcsC5npMP5Al6cl1nLi3rZRRFlQJyOHnERMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714685221; c=relaxed/simple;
	bh=ai0A+jvOaoWTjJ8XMXQPgpwOrGyUp9q+UPbAaXoatbM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ngq/Cdv3+aWuN5YU/fs/2H3AUREtYFlMoo/XYmkgdx/iQ4bbVCuLFC29H6ebIm0O+1m8rQeJwd+r97cRmZAA6wAWpk7cz7qhhvQBunRWl9CTqjxW9n7XyKFjpOVdVj+XmjchuzJGcekCdteU8inCLjtGsfhQAIZpHiWwcoWBE/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=ZFY1pj5W; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a51a7d4466bso975007566b.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 May 2024 14:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1714685219; x=1715290019; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XxfLbDO1iQp9CdZDyWPw+FjwW6do8u7NB+ZNT2vfVBM=;
        b=ZFY1pj5WRXgjUHFgbKM1SJOp2MW9LwfO/toRzjQhsqpRE8SBfAJl7MVdbWevTyDNmQ
         taZeG09m0bis2ifAdEWb2dcJ4YCya6+qpN3Fmn09/pIyoDSP+ktyYi77c20NLTFnZvkG
         AVs76rZubFyJ9P9x/JFm14kkn9TYBwaA0vdeyz6zOuoF+iDlaNNKNiCuYkxqIL8Asq9+
         SlGoqyKWCoFBFOq9WMxPCkFHzLcB/QXKXUxiaXh1tfU0TWn4bDnrLz/It8hnhGjRb3pj
         17mXgreQar344I2+bYaNlfBvbJCKKrzn0sBWkHhhfPhJrVhcv6NW2PVjJRqJ0CE6FDKx
         fFFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714685219; x=1715290019;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XxfLbDO1iQp9CdZDyWPw+FjwW6do8u7NB+ZNT2vfVBM=;
        b=t2YcZ+m3DfHQm62fnUWfyqcSZIWYtGXdChwJG+3C7MhGDK7EL13gZuyqjkSTYKs5wt
         ZJvi9rBPzFl6L33GC9ABDC9/BlSoP4YQmVpF0FC1QcueLOwyPmAu05QarWZoAfuwLUFj
         bVQSPhpy/IgxBudq0uM8/Nnlvboh+9Euw/AQ/dW3kQzbxQm+Ibsu5fz+OUANNIrPloLy
         AsbWt75iC4/CwnCMInX9VqkQNmJZezZhSxjc3+Y0CbAWv9STNEHhyRXo1vCcuWKXSOQz
         KhDbKvv8kH0sih6cAe5TqYRLVYIcj9yoO5BXr8trSDDbv1n/A5fna9WTT4xthm0cp2xO
         e9YQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQm0B0VgcPv74kM1u4O0h17ySXCv06p4zkYxMjm37vKCEEWXk945W+ME8OJCw71j6OpOYWZA/spefpg3RdfCWX2/Dl9pFEwDRi5PV3sw==
X-Gm-Message-State: AOJu0YwYm0UMrmNBzZv40jkuIirFvcvcpcXWWcuJBNOQkpAidRIV32Qx
	Bh0H87GachiuhagekytjqYcfoA5fzGgrCOhh7WGHyORSks8Wtwdpt/TB30kyqeo=
X-Google-Smtp-Source: AGHT+IErvofVOlcBRqerAxB7KV24lTnlqlYfvQ1PtbkRzl2rNuYMLblHiMHF3fUAnpQqQn7VMD23ZA==
X-Received: by 2002:a17:906:8314:b0:a58:a1e3:a2cd with SMTP id j20-20020a170906831400b00a58a1e3a2cdmr379328ejx.55.1714685218619;
        Thu, 02 May 2024 14:26:58 -0700 (PDT)
Received: from fedora.fritz.box (aftr-62-216-208-100.dynamic.mnet-online.de. [62.216.208.100])
        by smtp.gmail.com with ESMTPSA id my37-20020a1709065a6500b00a5981fbcb31sm354886ejc.6.2024.05.02.14.26.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 14:26:58 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	David Howells <dhowells@redhat.com>,
	Jeff Layton <jlayton@kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>,
	Baoquan He <bhe@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>,
	Dave Young <dyoung@redhat.com>
Cc: linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-unionfs@vger.kernel.org,
	kexec@lists.infradead.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH 2/4] fscache: Remove duplicate included header
Date: Thu,  2 May 2024 23:26:29 +0200
Message-ID: <20240502212631.110175-2-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240502212631.110175-1-thorsten.blum@toblux.com>
References: <20240502212631.110175-1-thorsten.blum@toblux.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove duplicate included header file linux/uio.h

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 fs/netfs/fscache_io.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/netfs/fscache_io.c b/fs/netfs/fscache_io.c
index 43a651ed8264..7b1ad224956c 100644
--- a/fs/netfs/fscache_io.c
+++ b/fs/netfs/fscache_io.c
@@ -9,7 +9,6 @@
 #include <linux/uio.h>
 #include <linux/bvec.h>
 #include <linux/slab.h>
-#include <linux/uio.h>
 #include "internal.h"
 
 /**
-- 
2.44.0


