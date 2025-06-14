Return-Path: <linux-fsdevel+bounces-51668-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DE61AD9E28
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Jun 2025 17:43:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0A7B3BB006
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Jun 2025 15:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C8FD1A8F84;
	Sat, 14 Jun 2025 15:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NeRmp0/e"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F9881BD9C9
	for <linux-fsdevel@vger.kernel.org>; Sat, 14 Jun 2025 15:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749915765; cv=none; b=Kb8FLfHE0E/rN0IYZh38Kp8Ubin7Vu7VjiWUsVPL4P9SyixtrcgOuQVg03IJoZPQGrYAr8AexCxmFiKCPtLVwTzxaGvr2g5m+7kUhL4ODpI3jZ/4YJ2Xmgm5eOqksvtQ+LxTw2hsALw+SSFLAZuezq8R073Haj8FCDYKB0db0sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749915765; c=relaxed/simple;
	bh=b/254BVTvwDZ8AWwsMuNPnQOm+uAF+fVvBBcvNK1P5k=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=OKa9UCjGs8kSavrv7rkBvUSp2+KMnewJDc8XYO7MTh17SMr6afAL8Gd7K93cKvXzA+CE7XQWZrnkLpe1wMsIqbsRKdIEKuOYWXVUCkzbgoZk8Ph1E6aqJjBmk7DskLUzTuqX78BkkGWeO4EbwGRztqVwTTOUbXVQKYxByHI4bc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NeRmp0/e; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b2c4331c50eso2497382a12.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 14 Jun 2025 08:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749915763; x=1750520563; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c1baDzcWv2NWKLsqR/QCJDx0I1LZOiZPhpRutdOAWPk=;
        b=NeRmp0/eCRjyEjtwKz7dE0lT8Uln7A+n4oz0TPJ7mofGvzW+NU1FdRZlSISldQGB5a
         78v19IFqGrXJjxCYQGVzr/SrrbKvqzQcOeaslStBrgp/gRpS/530S0mVYNcyd03cU/y+
         0NPTFbsRBYl/K6ejp5hxRxVLmuJVKmdVblnJGqXRNCfVwQlFQE8KiEYzDxC7WuCDHCZS
         xGnompxXRrAPzGhCwInTNKBk6vXJCY3/d5CGHYNULY4iOUJ0sFKQS30J8D7U/1V9Y8Df
         mTcvT8X7SCkt6BaWFDNzq+MiS36XmLb9L0vobdpVbtKETXcDMXabqMmeUxD0/VSpdF3t
         +xUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749915763; x=1750520563;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=c1baDzcWv2NWKLsqR/QCJDx0I1LZOiZPhpRutdOAWPk=;
        b=VbvWvrlGzoIas46paBcrFJ2+esNg5Lq51GnFWvQJ4RjHiGqWL29W4gKkgNvhzzjaDA
         B8DjUIePuOcCoptmFZdvgQrUMBFJDJA+CjCRxi1/HeGCo62/XJv8qvbGrKAoxxKg5gJf
         n3oPLjkDkqUcwcqU94tSi1YdRvfHjFgVOOi6Brx+cU7LlFHI08kLs7FaV/sGLRV5tENB
         /DOWvBT3iG0Knqh8aWuDg2DW+Qc4evvBA+YBkmk17xIGvlBoD3w9t9xftweVSgYyMeMM
         De0B+w87jm47WQ9mioy8pHHaxZ/0MRmI6/oakC40iQfgqE046AwmVxapS5SOuOa4CdZX
         iYbA==
X-Gm-Message-State: AOJu0YyZ5styCiM/ethK+gF+dj4JiwykcNigKX114OaScAnlbh/ZNgL2
	uyDIzb6grKPu4y3Agwq6721mPf9exA6ygHHGqqcotaZo/Ivs0mthUnsb//pMe5NyBcg=
X-Gm-Gg: ASbGnctgqX2U0YUivf73W2y+PFH+9uu+06kOItxtKuMri11G1cOgnXcZRQKBZuUV5iB
	OVawJy+nm6jv49RRofc+6GfcR29lr3DZk8HJeHaDSJ0ph1X3J8fc0YjATy24micU3Xwx5M+e6Aw
	aTiWbLP5WofF5SCeVgE0Qis4M1fCPLaPATOtrx9KxS0njkKF8O4apGjYUIU0s1JN+Qt5+EtsN0T
	tuS5PNA9wrv74mMGDo6yudAvGCSAQWFkoO8JTB7opf9bAxF+vHDl0s78ldw9i+A7l1CWNy0QNRk
	7K+Mh1CH5ISIjWZ3Tw3rqSTNMmRnBAWXmkDB4wfVlWUYWZVB5krxdQbmmjo4CI33657qh2xBgJo
	wR7y4lw/rk382AuHURR//3LWWpqWobrU3kwd1Y7xRyvV3W0KpaN4AV89j/s0L3iuGsQ5C
X-Google-Smtp-Source: AGHT+IG9wf+GjoXJtFE97YVd67/jW8IApRFrr5Ny9q8/BiVDBkHH7/pG9BRW/pJLmqjF5/I3+SEqOg==
X-Received: by 2002:a17:903:320b:b0:235:f4f7:a62b with SMTP id d9443c01a7336-2366b13af7bmr53921545ad.41.1749915762764;
        Sat, 14 Jun 2025 08:42:42 -0700 (PDT)
Received: from ?IPV6:fd00:6868:6868:0:181a:9c87:74ec:8055? ([2409:8a00:1846:4440:5e02:14ff:fe47:9533])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365decaf71sm31777885ad.217.2025.06.14.08.42.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Jun 2025 08:42:42 -0700 (PDT)
Message-ID: <83907912-d8eb-462c-8851-2c6f44755d68@gmail.com>
Date: Sat, 14 Jun 2025 23:41:21 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-fsdevel@vger.kernel.org
Cc: mszeredi@redhat.com, bschubert@ddn.com
From: Feng Shuo <steve.shuo.feng@gmail.com>
Subject: [PATCH] fuse: fix the io_uring flag processing in init reply
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Fix the expression of the io_uring flag processing.

Signed-off-by: Feng Shuo <steve.shuo.feng@gmail.com>
---
 fs/fuse/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index bfe8d8af46f3..ef0ab9a6893c 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1434,7 +1434,7 @@ static void process_init_reply(struct fuse_mount *fm, struct fuse_args *args,
 				else
 					ok = false;
 			}
-			if (flags & FUSE_OVER_IO_URING && fuse_uring_enabled())
+			if ((flags & FUSE_OVER_IO_URING) && fuse_uring_enabled())
 				fc->io_uring = 1;
 
 			if (flags & FUSE_REQUEST_TIMEOUT)
-- 
2.43.0

