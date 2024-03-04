Return-Path: <linux-fsdevel+bounces-13540-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38B5E870A5D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 20:14:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD00B1F20613
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 19:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BFBE7C0A7;
	Mon,  4 Mar 2024 19:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bGrd0F2i"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC927C085
	for <linux-fsdevel@vger.kernel.org>; Mon,  4 Mar 2024 19:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709579554; cv=none; b=twH5u8X9DhSYXSRCxsuoQLu8nDjuALAOOjevPDhWEkH808928r5NAMJHqCjd6c6FquFtbzbpult6skd7imQAufoBmTMqZdbDyDVWZNBe9XRhaiYB7VGrQSrXFMr5Xp2nM2SsSN4tTJdYEyLCP7L9RKBvIA/kizBMEFfPBGxSjT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709579554; c=relaxed/simple;
	bh=q0TWMGdcx6UYw2sFq8ZSAnpd1rQAgwPeqQNrYl42ZRc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XNFSAYzoIc8UB4SKhFwLyBW0MZJmwbk/DjpA62RAP53Fe2/bfO72ISJJ28J1dOo/nwy85CkzRUEKh8t7eSW+pULSXvUbFju4BzF3ToMrI54duqlXmInVlhdwRR7S0ol97bUOwo3wwgfhPGR3HPs30IyPoMb8Z69n+8VohV0vWAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bGrd0F2i; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709579551;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tZJgKDbZKO9AEPv9hol4NRfnrrJXjSrBKcTnHhFLOjw=;
	b=bGrd0F2iVVjipJ3h5d9JR4dJ9CYkWruxbxWCvCeQFl5657U6bmHl3zMx9LBs+8xawLG168
	jK+MFFU1l6qYxFMxggW9pwKzo9AtuvS8UXAEqg9pl+ICf6Qtl0DH5Lytdt+r+goDT8ZUwR
	GA4Mmfn0REyvMWoeDtA+cSPSc70kKtQ=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-uXsKw9fVPaeGCPpF2CtYBQ-1; Mon, 04 Mar 2024 14:12:30 -0500
X-MC-Unique: uXsKw9fVPaeGCPpF2CtYBQ-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a45095f33fdso185621166b.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 04 Mar 2024 11:12:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709579549; x=1710184349;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tZJgKDbZKO9AEPv9hol4NRfnrrJXjSrBKcTnHhFLOjw=;
        b=hpm5aAJr4VGO0pL8rOpokYQP4z703Yk5tE5d7Yw1vtvFcwXzigc7uJOBqPqDG7FB9i
         S5U+sk+tmo9ehV2RrE3F7fClstgN2+JUFbOTBGS/2YTCFgIpQ6M745Zw35oLWkXf/0HM
         9+3no1nGiwyxrsOjQ1CQzk9tSsVbDHCS8RDOUGNRGiStNW8xYdHYn8sTHlmT0OqrQXaP
         1d2hOa/8Fd52T0UIgNlrgQ26xWse1lXWdSmx/gxj4dm6xpFJai8zjAOjlOlhnU4heaCN
         QjKEmCayBLDZfno0HFc6rcmehm1bVFAykvmwi3LzB8yJDkKB1dhVWzwsj3ZIBBBRFURX
         CGPQ==
X-Forwarded-Encrypted: i=1; AJvYcCVFFH+3xcgfJbTuSHxhMxiN3twwWMi8Hs4wOMLw4Slc4V4BkMqMxMNhQ7mHyVREiW1KvZE36dubaPUnOoxrTQjt8HQ6oaDXmcgQqeKqHw==
X-Gm-Message-State: AOJu0Ywir6CIUN7kMnsDxAImeneyqFjK1OwlwnRRK2o15hYR5hCPoE79
	iFcbugCPi7rxsxNl5bqUKqNOqFIE9Whg+qiP1bOI+h8Iovd4qkkIhMnQOc2WSYitOyquSlFOlSO
	iLDXsg1gxnUyrPXfJV26cGPPsTuqZ3L1pqek5u2UBIXuQUkv/AyR7rN6/5Rw3gQ==
X-Received: by 2002:a17:906:3950:b0:a45:73b0:bcc3 with SMTP id g16-20020a170906395000b00a4573b0bcc3mr412634eje.34.1709579548798;
        Mon, 04 Mar 2024 11:12:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEcXQkCy+qbM5MpjP28mYSzksscG7NinAKQc6R+cEtFLFSGXNxJn80ppRV0QWT9HBUWJwZUQg==
X-Received: by 2002:a17:906:3950:b0:a45:73b0:bcc3 with SMTP id g16-20020a170906395000b00a4573b0bcc3mr412595eje.34.1709579548091;
        Mon, 04 Mar 2024 11:12:28 -0800 (PST)
Received: from thinky.redhat.com ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id a11-20020a1709064a4b00b00a44a04aa3cfsm3783319ejv.225.2024.03.04.11.12.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 11:12:27 -0800 (PST)
From: Andrey Albershteyn <aalbersh@redhat.com>
To: fsverity@lists.linux.dev,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	chandan.babu@oracle.com,
	djwong@kernel.org,
	ebiggers@kernel.org
Cc: Andrey Albershteyn <aalbersh@redhat.com>
Subject: [PATCH v5 19/24] xfs: don't allow to enable DAX on fs-verity sealsed inode
Date: Mon,  4 Mar 2024 20:10:42 +0100
Message-ID: <20240304191046.157464-21-aalbersh@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240304191046.157464-2-aalbersh@redhat.com>
References: <20240304191046.157464-2-aalbersh@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fs-verity doesn't support DAX. Forbid filesystem to enable DAX on
inodes which already have fs-verity enabled. The opposite is checked
when fs-verity is enabled, it won't be enabled if DAX is.

Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
---
 fs/xfs/xfs_iops.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index 0e5cdb82b231..6f97d777f702 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -1213,6 +1213,8 @@ xfs_inode_should_enable_dax(
 		return false;
 	if (!xfs_inode_supports_dax(ip))
 		return false;
+	if (ip->i_diflags2 & XFS_DIFLAG2_VERITY)
+		return false;
 	if (xfs_has_dax_always(ip->i_mount))
 		return true;
 	if (ip->i_diflags2 & XFS_DIFLAG2_DAX)
-- 
2.42.0


