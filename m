Return-Path: <linux-fsdevel+bounces-34880-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 940B69CDB37
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 10:14:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58727282FB1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 09:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B26D318F2C1;
	Fri, 15 Nov 2024 09:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R5I9e5Co"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C4E318B470
	for <linux-fsdevel@vger.kernel.org>; Fri, 15 Nov 2024 09:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731662033; cv=none; b=eSo8imNRNcnDhfM/Hr4y5NxZ3c5nVbqcGmIrT2APJq5NMTLvkvYhCwsHEyNBKGGt4ZRs7/p55rTSWVkAx3ajRj0jOIiWjumRzZaYNpVEhpUiL9a6J20WB5bdMLuyIrV219hWZH8t59h7jav2yDd+BtDsseuKyLfa0Q2j88YKQVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731662033; c=relaxed/simple;
	bh=1gpbH+F/EyAt7/qdUtEQNzUhRagbx8xAr7oPVt5RjTg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=jNZ5J7HCQPYhfyfvLxGy6PkLeOlTXRcfGjqFF3nJ7nK/aDxT+YxIGSM8fELnsLTylopA2E6EPTxNdyHxWMeUuvYWglG/YWiYgIJ8vOqk1YNyDvC5ZumZw2RjjihPstdinE2lVtAzY8jgSrb6AWJfESf/fqsacocn73Zp+/Hc11U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=R5I9e5Co; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-432d9b8558aso9698165e9.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 Nov 2024 01:13:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731662030; x=1732266830; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B8COCFgpNqgb0Y7Anvsa8b6bhjh2JHm033ij5t0kw0Q=;
        b=R5I9e5CoPM/aQPgX41XFKdbka73yFh+88oqZ/9hJqCCj+0y9MQRtJIX9f+wRfDaHLv
         KiVC8C4n77YvLqMopfeX8Lk6JS/QuXvG0llSlpBBZAcqvZkr1fkLFjj+UtGw83XLgpCI
         Obw0F1/nuX9CdXbq/YplY36vIqKtuDzmtMa8nuNocUaNnqOcBs41UxHVP1b20xoSkZY/
         t2MOCoWP8/Ff3xRbxSafG0g6mKXekMr5mzPGmns7nljistl59aD3RKjWsR/B0+FZA3mJ
         514/v9ROijofCtf/w/U0ifxdYgyeh3QXNzXdCPhVfnpvDd3oqbphHkDNfhw0eT/ipqD1
         QV9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731662030; x=1732266830;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B8COCFgpNqgb0Y7Anvsa8b6bhjh2JHm033ij5t0kw0Q=;
        b=shuSoKyNI9VQhG7WOvcSQ4y1idsKHogDIknWWa0blMsy3oISVy2MVH65AOXYu4+q0S
         x7p+goG89q+8SwdRLLgX11nsXbqk7hr+t2u827pw67+//OdLj7XJIrwq9iuI9BuwoyBp
         6KFiHn76UoN2XsrEFMoBGkWqXlBCMRtPM7wvcMy8ptEMy7RKSHbf+bwbcGn/KMKvbM4u
         xtHQJu+BbCQvE2xKPAdcaBgMynavbTAJLSHDVScw5bDF5Jr4P6lpxrv3siTp/5f+k4Wc
         wCVYka/iyLyHTkQINkucJ7G7eyfSwCIckt6yQPFbGOAUPHwNZO9bkG6BdKOF+wdmHj+A
         kLkA==
X-Forwarded-Encrypted: i=1; AJvYcCWjNYRWDhqtdXnwjnnFm8SrZTSrYCz0Cbx8JQ6gwxUn7GNEDf84wb8OkW3oxJ3mbrzr5yBPElMu2Rgn9xjt@vger.kernel.org
X-Gm-Message-State: AOJu0YyTFWEJzi73GAOQnu4sgfh7gezyRN0x6pGw0EvbfizotkgrybR5
	6E43ifQFDVkOhOd0dxCZmk5PnZB64UF/WUhxwMC5/edU534O0nWG7s0n3eOU6Vw=
X-Google-Smtp-Source: AGHT+IFDwyeF9NdbO3uA8WPZbwIsipDKiK7gl4rjQvHP2ciMl3NTCJLQxQXZjpw4OVLXp1FI70A9Yw==
X-Received: by 2002:a05:600c:a4c:b0:42c:b991:98bc with SMTP id 5b1f17b1804b1-432d95ad53cmr54878725e9.0.1731662029843;
        Fri, 15 Nov 2024 01:13:49 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432da298c81sm51915835e9.39.2024.11.15.01.13.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 01:13:49 -0800 (PST)
Date: Fri, 15 Nov 2024 12:13:46 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: David Howells <dhowells@redhat.com>
Cc: Jeff Layton <jlayton@kernel.org>, netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] netfs: Remove duplicate check in
 netfs_cache_read_terminated()
Message-ID: <dfc4ac23-88eb-4293-b4dd-e617779ee7ac@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

There are two checks for "if (transferred_or_error > 0)".  Delete
the second check.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 fs/netfs/read_collect.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/netfs/read_collect.c b/fs/netfs/read_collect.c
index 7f3a3c056c6e..431166d4f103 100644
--- a/fs/netfs/read_collect.c
+++ b/fs/netfs/read_collect.c
@@ -597,10 +597,8 @@ void netfs_cache_read_terminated(void *priv, ssize_t transferred_or_error, bool
 
 	if (transferred_or_error > 0) {
 		subreq->error = 0;
-		if (transferred_or_error > 0) {
-			subreq->transferred += transferred_or_error;
-			__set_bit(NETFS_SREQ_MADE_PROGRESS, &subreq->flags);
-		}
+		subreq->transferred += transferred_or_error;
+		__set_bit(NETFS_SREQ_MADE_PROGRESS, &subreq->flags);
 	} else {
 		subreq->error = transferred_or_error;
 	}
-- 
2.45.2


