Return-Path: <linux-fsdevel+bounces-52203-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7547AE02DB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 12:41:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6972D189F7B6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 10:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01952224254;
	Thu, 19 Jun 2025 10:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GAf1bD7X"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A1D1E2312;
	Thu, 19 Jun 2025 10:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750329710; cv=none; b=Dq/wSCzEuYkmSSR2S/w3ZpS+h8HZtHHj6+EASjkIir0tAxzQq2LjTiogSajpEdVwQrx1I6L+p6eg5TzmLP752D7SJBkxJYcYMwZb6sXNNZQtiOC74ZbG4gVYrOg6AlESjOG7fEyCC3ckTbT1+569YlAfDJIXY5lLN8zBDL/9hAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750329710; c=relaxed/simple;
	bh=yOHFyXetGd4sDsn2YWB2dQTbHkoyY7sNNv8D6/4PxDo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h5dEjnMZLExyf3nkIlxmX1pwEvhuo4gqAilyCmHlcNta+WhF3yTPPYaZnU0ORcgtTrbiMu97p0dJMlFRZ0+x8uXJF/UBk38rudxxrcVzLWPTVJyo/p/9ljygd0OG31umUfI4grfkCQ0gsK5y4dZzu4zze0Ez/kDjCc00C0KpA0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GAf1bD7X; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7390d21bb1cso476293b3a.2;
        Thu, 19 Jun 2025 03:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750329708; x=1750934508; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SlCg/yuzqjgg/GgWyamhPHBV3hegBzs21uKUSCrkvC4=;
        b=GAf1bD7XbQIPKdwCT1JZBxbm3PFUXxRi7tEX2uhi696e54Qjotpdmt9IFtG/NkmT4P
         zyyq329VnV14Xp3mlgVKX6nDfsoZEhAPfh6Gp6KSilhO06+ypGZFPkjdrjqBqipoSBFY
         tEZZOHwdZ8+FcTNHWkJbcrqQv2+NIPXt+p/lCfFrGNaZn4+R6GytCDi0/m5S5aGmxWXP
         ro3/o4V+8XQh9hM9llee+ndDYqKn4EbddnXFSdP262TzzLmu8q/IKbsj6IqZW9yfvBKK
         7ZjZ4ZttdUdmSkKvrwZUcvYX6Ad8wbUojBgXylf0c28KcPHVEohAcE+l/FQ5MH+oeIkL
         UFXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750329708; x=1750934508;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SlCg/yuzqjgg/GgWyamhPHBV3hegBzs21uKUSCrkvC4=;
        b=FM4H0DGcTVu5/+BJdo8RzbilrIk5guq7bEf1jIpgfMx5nUeQbZJSeJ3jl9s/SAqEZu
         fc98IQ8AVvK/aP+J13pJ8KGeomJjPZK2ZPJC4cgJrq5wIdftT2P6Pd0M+gpfjSTrM86n
         BivwumT2K08ooE1p/i7Gd/WmfA1wbZddbwDa7avdymzxkocYQV6cGCfV6ph9YUuHJGLs
         /KQdi1xXvD2uFIMy869/35t5r9Wdi9tLOXz7url5iNk26UWvUpgp2xK/ubvvpib8hYHr
         TTW+oTJz3zK2NczPubdhkdid9M70fEHIbvk4oqRb5hKMuNFqjC11xO4OetXaueOZ4IjD
         pjLw==
X-Forwarded-Encrypted: i=1; AJvYcCWdl7jK//CxaDvqyAu+nmxPQllFKtAS6cjJc1pBxBr25nvsorSgCeDcdEq/w3kUHIQfw1ffNjKjW3RhIIg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5wBX/EvxnoVwJUuec9Fm9YsuxHFbubWnQ7FxbJv6M1bWexlkW
	HrRvVeit8Ccfzh+GVRnQ/aR677gWwuLpibPyWPcNJ4ZNz/eZ2U8xw3hJ
X-Gm-Gg: ASbGncuingCX1osOPfT+6rg9SkoFnfmcu0oFqhG9z6E4BUkAXXjO01ybarToefn1HIf
	Zw/Pkszc7dYNmbCBIExLze0eJovipaErPcD0mPJWK+vvRr7UWqxl0gh6SOrHHzZpPQSf5lW9El8
	aGmFoZS4Px/SwRf73w5GD8VNeTWIafrf5kMuJ7wF6MUcZj0Z1+0Z/tNu9iEdKe7FXbCCBkw1M3/
	cbccRAWX5vZIZJI+X+QlHK+asAQkjy2A6NrD3i2jfPtq/WO15jLaXpf1JPSmoP9aXeyzQBCjTo7
	ZaaI1LwNmb6JM2r61KXvMfFQgLaWTYqu2kvztbN6jmXjEVBrZR8r4lKdQQtDTiRtW/eqK9RdGdk
	V8y5xDQ9GcHDFm/TNuszz
X-Google-Smtp-Source: AGHT+IECjTQyz8QiLYczrIfMIMBQHbgKHIFAZtO+Nh9Ohrqppw0Ed0LvhNuk3CwBkGBxPYsRNb0Qpg==
X-Received: by 2002:a05:6a21:9987:b0:1ee:c8e7:203c with SMTP id adf61e73a8af0-21fbd5566fcmr34251508637.24.1750329708245;
        Thu, 19 Jun 2025 03:41:48 -0700 (PDT)
Received: from avinash-INBOOK-Y2-PLUS.. ([2401:4900:88e2:4433:750f:1851:bea4:26db])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b2fe168a221sm10609746a12.56.2025.06.19.03.41.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jun 2025 03:41:47 -0700 (PDT)
From: avinashlalotra <abinashlalotra@gmail.com>
X-Google-Original-From: avinashlalotra <abinashsinghlalotra@gmail.com>
To: jack@suse.cz,
	amir73il@gmail.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	avinashlalotra <abinashsinghlalotra@gmail.com>,
	syzbot+8eb51728519f6659ef7b@syzkaller.appspotmail.com
Subject: [RFC PATCH] fsnotify: initialize destroy_next to avoid KMSAN uninit-value warning
Date: Thu, 19 Jun 2025 16:11:40 +0530
Message-ID: <20250619104140.105835-1-abinashsinghlalotra@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

KMSAN reported an uninitialized value use in
fsnotify_connector_destroy_workfn(), specifically when accessing
`conn->destroy_next`:

    BUG: KMSAN: uninit-value in fsnotify_connector_destroy_workfn+0x108/0x160
    Uninit was created at:
     slab_alloc_node mm/slub.c:4197 [inline]
     kmem_cache_alloc_noprof+0x81b/0xec0 mm/slub.c:4204
     fsnotify_attach_connector_to_object fs/notify/mark.c:663

The struct fsnotify_mark_connector was allocated using
kmem_cache_alloc(), but the `destroy_next` field was never initialized,
leading to a use of uninitialized memory when the work function later
traversed the destroy list.

Fix this by explicitly initializing `destroy_next` to NULL immediately
after allocation.

Reported-by: syzbot+8eb51728519f6659ef7b@syzkaller.appspotmail.com
Signed-off-by: avinashlalotra <abinashsinghlalotra@gmail.com>
---
 fs/notify/mark.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/notify/mark.c b/fs/notify/mark.c
index 798340db69d7..28013046f732 100644
--- a/fs/notify/mark.c
+++ b/fs/notify/mark.c
@@ -665,6 +665,7 @@ static int fsnotify_attach_connector_to_object(fsnotify_connp_t *connp,
 		return -ENOMEM;
 	spin_lock_init(&conn->lock);
 	INIT_HLIST_HEAD(&conn->list);
+	conn->destroy_next = NULL;
 	conn->flags = 0;
 	conn->prio = 0;
 	conn->type = obj_type;
-- 
2.43.0


