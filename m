Return-Path: <linux-fsdevel+bounces-72832-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CAF1D04472
	for <lists+linux-fsdevel@lfdr.de>; Thu, 08 Jan 2026 17:18:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D2DAB30D5373
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jan 2026 15:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D515A3DA7EA;
	Thu,  8 Jan 2026 12:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KAIQnxHm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAAFF3C0081
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 Jan 2026 12:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767876027; cv=none; b=pNvya5aKN5vICu9uzjYs+0ucZE/dReFmdlcC+Z0frjBv67wNUVlO/9LQQLlgb+Id1adVI7SjLWsX/o6g1hCa1f1Ky5XhsT7zGYJVpMD931RVK1ZopF5NWN+b0aaMtoqIfINVArFSZNx7JH56X9GmI8H18Ux4o2LO6PooJr+SJuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767876027; c=relaxed/simple;
	bh=I3fq5noxSehDcyal7G1/qI8gRqDEfiON/e94iUBgHnM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JJhh1hyMquk9PCcTCvL5HV5r/Bq/grLVDpxOYP0kLjdX6jaJ5GJDZG0AbSKOb/+djxBhuaVjw1b8oy7TzM5Ma1vn1hmrpWLEiReVROhXDM+TO4nCUZxMnTn367gPdzb+GTcbeLfER0xDB1BHIYr5NKVHQugn/qUg235LH9V8Z0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KAIQnxHm; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2a0a95200e8so19705745ad.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 08 Jan 2026 04:40:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767876025; x=1768480825; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4dlOWSwPt/7OLfxqZ2lQ40XDlyJQbigyk2o9VvelnSw=;
        b=KAIQnxHmUIYqa5XkxYuFY/iiHOyRrn+HMwZATMCykwdqWA30ZX05giGllFk7J4qZkP
         NpwNFpYRJHTTnjJIVsPsOEsPfOpIzQPCB3iRvvZWeXay9V1Koj3qtrwLqNAwYGEAhfQk
         xFKkJ4cURR3erU3rIX0d4I4eUolRHHbuDt8svtcyAeqg9sc3PEmxY4wn6NAHOb6y/X31
         vDtFZZKe0YNLogHW9g85EbfxNGClIl1PugZu5PNxBbRQ2JI6SjI4c5bofJaA4uDDiJ2Z
         vYrJVnMUgYjUYgg0rUDzNKhhb2PmVqkXI2HsbpiT/91EQ+LIJxkpAdd/sAufVOQqX9wF
         diRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767876025; x=1768480825;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4dlOWSwPt/7OLfxqZ2lQ40XDlyJQbigyk2o9VvelnSw=;
        b=Pn+eiv6eb2SqY/H6XG4MxiH2RtZfIRSpKDve7bzOOEFlt4kWW2GOidp8ei66seZLJD
         rEOgntVvmCL1Ad8BZcL0UtcuCKWa7QTE4Yx/JCfPqSfVKaxU6lTp5GEhDaSFvAeiG92x
         UBg7CvmMbANTTh6uEvCaFmNK6o8yO0wwBo1e/jNso42DyDyzOKygRnmnFvmoH1pP1aO1
         4/IE+YTEUot5qcbnWelPxVI2ulypvvlp5TKLoO9bxt3NYYlpo+50Yx2Tn3wXmvnfRfKR
         wkYjIXzq61X9eDYBxAzfeS6CeKRWFMBU5wF2JlovrpD8/+nNAXkONlMvM7yUL/g5yYgz
         XK3A==
X-Forwarded-Encrypted: i=1; AJvYcCWlU1yQg7iNpRJ2sPtNHmRBgRVCegc0/D1qF1J2nxDjzV8qjOxTCxc6x8cPHs6JFSVFXYYcoMypqDaQ6Zmb@vger.kernel.org
X-Gm-Message-State: AOJu0Yyb/T200aPiXTeNFOv8/QDDpVnGgQne+sLTr5OhBxK2BMQAkeDc
	Zs8xhwoESHrRDpFXCb3yE+zeSgRK3SP7OUh4+7cW0snw8mgWr7BKqRWE
X-Gm-Gg: AY/fxX5ilO2UwCAtBV93WH/vmnmPBVL9ZCpLxQPczg4EClKFsHvpIHwT6CyMq487Ydc
	zpOHP9lzS2QaejfHp+vD5HBqxR/OK+fc3B2m+tbuTPjDr9WwRg0cAxwMcQWcTuxStmVOkHTQbjd
	g5gqfjgMRP8sGueHFe11zmrYzi/XIKfpT5hknK+7b5xPwuEMVRVg3OKW4/ubANLu/ietyOzomqW
	Vp2s9jO0UeGTRNzOFI4YSf4rqThkVcwzs3mjtNZKOEu1wtzashIOb69U/tsyScYpmDE4hj9Ac7F
	RN23oaA9dygAVe7zYpbXjdAzq3kW0luOMCg7giiCauQvt6l17IvdFMyGapY2x2gHGu0/zEmI/Gt
	wz9bdIilBN/KyFJqvUSCqEjiuS11pJMUimBDNzcdTHXJW8qQlDbSjFZ67qn/DwltIMryYfUU8BW
	5V0wI=
X-Google-Smtp-Source: AGHT+IEEoj1JTojQ2DgoCrIyIqOducGqfdzKTZ9olImjfgPWxDAdOY4kkh13Lgqcr9kesWvBx3UAxw==
X-Received: by 2002:a17:903:1745:b0:2a1:4c31:333 with SMTP id d9443c01a7336-2a3ee445ae3mr56242315ad.19.1767876025072;
        Thu, 08 Jan 2026 04:40:25 -0800 (PST)
Received: from localhost ([2a12:a304:100::205b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3cb2fe3sm79705945ad.59.2026.01.08.04.40.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 04:40:24 -0800 (PST)
From: Jinchao Wang <wangjinchao600@gmail.com>
To: Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@kernel.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: Jinchao Wang <wangjinchao600@gmail.com>
Subject: [PATCH 1/2] mm: add filemap_lock_folio_nowait helper
Date: Thu,  8 Jan 2026 20:39:24 +0800
Message-ID: <20260108123957.1123502-1-wangjinchao600@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce filemap_lock_folio_nowait() to allow non-blocking folio lock
attempts using FGP_NOWAIT. This allows callers to avoid AB-BA deadlocks
by dropping higher-level locks when a folio is already locked.

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 include/linux/pagemap.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 31a848485ad9..b9d818a9409b 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -825,6 +825,12 @@ static inline struct folio *filemap_lock_folio(struct address_space *mapping,
 	return __filemap_get_folio(mapping, index, FGP_LOCK, 0);
 }
 
+static inline struct folio *filemap_lock_folio_nowait(struct address_space *mapping,
+						      pgoff_t index)
+{
+	return __filemap_get_folio(mapping, index, FGP_LOCK | FGP_NOWAIT, 0);
+}
+
 /**
  * filemap_grab_folio - grab a folio from the page cache
  * @mapping: The address space to search
-- 
2.43.0


