Return-Path: <linux-fsdevel+bounces-73754-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E19D2D1F901
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 15:56:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B1BE6304D872
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 14:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CFF030C63C;
	Wed, 14 Jan 2026 14:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PxbJ7lls";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="h1VfycVn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC85C2E1F02
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Jan 2026 14:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768402435; cv=none; b=pQcMhjZYWpiHtKYkjFP9uMQRWbpvaZ8eqb3kGS3iGMk8Tff85O1HLesv6ikAVywghvrRQ1G2umg+PznAC3+YzdrxwYlgqcHGYwXbc4iUZyIoBW6IAckfa32SLHnfGOA4vbMFzSvqL0t3dMIEw/jBahjxp45qsFyP3FP8Ax21hbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768402435; c=relaxed/simple;
	bh=THxTZgg9D1P1N1GhCP/Zl66R1SlZvU0XO6ItlN+GM/w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KbFClxy3hnZghtKbb9qMyXKRkm1fwo/yXiyW+NJGJaq7Q2PRUOmFd4/gSStl9xPi0WZKDXZ0Fut0oGtVC+/hR5rC6hSyzQgHTwXajmd5Fa1ei+HMyKvockyYUKXP4JRqXd5tehj6NRf9F3lg4zB9xqHCuP+ETUbcGr/c052PZLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PxbJ7lls; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=h1VfycVn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768402433;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q7Q2Utcub9SFR/TMVzV1M49IZsdM/TLKpqqvgaGYOpM=;
	b=PxbJ7llsmK6qRv8tcUrwDc1a0i7vgIKLlAmHAGLee2KOtq2qqB128PZdp+4gBvcUoonWGw
	1mByOzNVRs+CDLsXJGTBrkHiN70321mkCKnWH4eoe9vNML3jynJXXIntsm0F7xFJKLtv2i
	TAVV93+TZy4tXrOfTfJrYRA3twFFkG0=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-325-JK83mwTLMp-lVwuJbmCtDg-1; Wed, 14 Jan 2026 09:53:52 -0500
X-MC-Unique: JK83mwTLMp-lVwuJbmCtDg-1
X-Mimecast-MFC-AGG-ID: JK83mwTLMp-lVwuJbmCtDg_1768402431
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-64d01707c32so16315226a12.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Jan 2026 06:53:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768402431; x=1769007231; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q7Q2Utcub9SFR/TMVzV1M49IZsdM/TLKpqqvgaGYOpM=;
        b=h1VfycVnEaSyPxQMUOQVPNfYIifL3HqsdcWXNPPKrot5qHZUKrJv3VS3pgYQlCtnsL
         cYFy6/Q/B4ZUVMNoJAdQQf24ZvXBdtacHTGXs2ZUn8CZxwVlGYjsJNlYnhlOZwVpBXaL
         lESurIpNwYbnqlzJga1aClZOvrrFlppcV4j6WAP/X0IJy0Zg81w/dxXXMt9TbDko5m2q
         cN0NE9PciKFMB5l9O8BZJ1D8QDmbAbeN1ny0MB6pyHcFjAaK5n1Ju9oN2sd6pXrop0zE
         5WSJSzd+y7SforyKGHyXW5o2G1sGfh6gjnMsZPRQmAihL8pJmqhtP9nXjdVT686wiYSc
         ZaQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768402431; x=1769007231;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Q7Q2Utcub9SFR/TMVzV1M49IZsdM/TLKpqqvgaGYOpM=;
        b=ukYr/XWSMjsM/CCn+nmTJ+SVy7s/qTFQlayhLIplnj70EwOU8I3uj88WZUkhwAu7Rx
         ZGd/CEqpc/vl6kIxkNNVnQCADagVVyEfAS9NRjHXolqrR8WDR5xBiEdO8g/met+MG5YQ
         3NTHV6uIWI8+tMzkpaVUs+Ca4HiYAL9KZrKXtnmSwW95IhyHvQB1L7WYI1UyhkXF7YZF
         P3AFvppq1UGAMECPOe41pnIlX//A23SJi4+NtTAi9lK11yWPivkLO/eid+sTWuCQ6QcP
         8ZE5F8/B1vY5FvxcVu3IQGcJjtzhj8Uyn0jxvr7H/zJB7kf70wb8CcN/tzysLH2nF8xW
         4Rmw==
X-Gm-Message-State: AOJu0Yy9rIJ1tOQcQT1eMvZ2YfJB3MPY0P17tfdnWlcRTBZagzjv5UZY
	ylReZUSh8pqfV3lN3C+e64eoUjgO7jgVE2J/9fp264tbhp4fIlVFXQH/wpAb5Dfkyh0QR8E0vQj
	AwSV5Ex4Pbk+m+Au7JmuoSdd/oHn2ef83eOkx4PJPCN42Y5wDtqhd090+ubnojX5+dMdANxPQ4+
	8eYpYsvY7M8ribTnX53nKNoPtW2w4IAvEcv0Q3l8V0wW6wa4tr2Gg=
X-Gm-Gg: AY/fxX6bfHROczNGWHfCHI+OUnbB8sfLeBpP/7uIvSGFFzu+jEMQ3x698dD3DDCYFkO
	9b+HG4/Lm0IYWULuA6FIIPYsOOwAYkDlF76cVgMQZWqzhyFHN8jVQjiERX5fhbZ267fu0UFJffS
	SG3gAbkKoQW5C+/d7eFGuc2kRS34cZsni+VRTJJ7dQF1HWL7KRJiIenWJ/dywydIFRdTMAtIQRq
	6EQRVoOUorcQpMLc2nLYWSIdL97yGWQ4H0u2kjzVrHgidZWVmYMVgju1QIBQa5HXjP1/OyVZ2r0
	MDmvrnb2mpmkdxx5S4bUkbeRzl7ZfFvToPKroJ3A13UtKuOhCdHpnhaRA5OwCGu2g55hrDzkymX
	l0KJnaHASCZDMb0ZnJjedjn07+gmbuSu7k1c12hQHng+hxzeWYG5+LsUidjuUSP7O
X-Received: by 2002:a05:6402:3514:b0:64d:2920:ef29 with SMTP id 4fb4d7f45d1cf-653ec102093mr2250699a12.2.1768402431157;
        Wed, 14 Jan 2026 06:53:51 -0800 (PST)
X-Received: by 2002:a05:6402:3514:b0:64d:2920:ef29 with SMTP id 4fb4d7f45d1cf-653ec102093mr2250645a12.2.1768402430477;
        Wed, 14 Jan 2026 06:53:50 -0800 (PST)
Received: from maszat.piliscsaba.szeredi.hu (193-226-246-7.pool.digikabel.hu. [193.226.246.7])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6507bf6d5absm23059608a12.33.2026.01.14.06.53.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 06:53:49 -0800 (PST)
From: Miklos Szeredi <mszeredi@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: Luis Henriques <luis@igalia.com>,
	Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 3/6] fuse: add need_resched() before unlocking bucket
Date: Wed, 14 Jan 2026 15:53:40 +0100
Message-ID: <20260114145344.468856-4-mszeredi@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260114145344.468856-1-mszeredi@redhat.com>
References: <20260114145344.468856-1-mszeredi@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In fuse_dentry_tree_work() no need to unlock/lock dentry_hash[i].lock on
each iteration.

Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/fuse/dir.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index cd6c92be7a2c..3910c5a53835 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -177,9 +177,11 @@ static void fuse_dentry_tree_work(struct work_struct *work)
 				fd->dentry->d_flags |= DCACHE_OP_DELETE;
 				spin_unlock(&fd->dentry->d_lock);
 				d_dispose_if_unused(fd->dentry, &dispose);
-				spin_unlock(&dentry_hash[i].lock);
-				cond_resched();
-				spin_lock(&dentry_hash[i].lock);
+				if (need_resched()) {
+					spin_unlock(&dentry_hash[i].lock);
+					cond_resched();
+					spin_lock(&dentry_hash[i].lock);
+				}
 			} else
 				break;
 			node = rb_first(&dentry_hash[i].tree);
-- 
2.52.0


