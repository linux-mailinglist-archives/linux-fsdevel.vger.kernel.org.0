Return-Path: <linux-fsdevel+bounces-13545-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED817870A6D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 20:14:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8ABC280E45
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 19:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 301737E0F1;
	Mon,  4 Mar 2024 19:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XzW4L2+J"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 272DD7E10E
	for <linux-fsdevel@vger.kernel.org>; Mon,  4 Mar 2024 19:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709579559; cv=none; b=dIJBEeyEhEfjr9X+TkAlAvM+ph9I/t3S4SfCUceR35WKxV5l+a5ri+5/CjUzl7O9WSv+WvlqW+1dXSclTfAAMUC94ApEqllDHPlDtxNXpP2M6sPVXmyQuO4FbkWWYjlTB38aPE8znLRKOkBQ5swg61vtVDrUNc4r6EGpvhEOYqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709579559; c=relaxed/simple;
	bh=Vv6pshJlKGTE98xSJNd6Xk8HKI+ZQ4JRPxzDEoR1Lmg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yw0YsDfU6QtyVEEtppzQY4wgLuF2ijTnRUd88SFK76Le02JchfZiIBJaRX3zm+MnH8bP0/jrW3+SgBQ8K6jYHuWDZHt/0eMnmqBwTeO9LvEMqtJjFMYjcU/+tlrb5QeQd+6Lf6m++stO47VW/rTYo2fZEqAPJpvh5+c7fmkhqXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XzW4L2+J; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709579557;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZV6cPRqKx5ix6M5gdtJYtyedkYWhw05+92IPp1Ctzuk=;
	b=XzW4L2+JTIf+Pffe8MwWmFgZyEdu6PvWTow+HgGdjsUta5DP15k17e362Oln+5lTquBEC5
	RSb/JhOLZVPfpHcmLteFXKu1z16B9NirY8Q4qLcvxoHtqqddUKGSRVfkBcJ4bexXjNV4Nv
	9k9kNsUcd5Q2jFO7eiEAoqmFAVBp6kA=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-_eiujDMNO1qDGzdbbFHR0g-1; Mon, 04 Mar 2024 14:12:36 -0500
X-MC-Unique: _eiujDMNO1qDGzdbbFHR0g-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a357c92f241so345844166b.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 04 Mar 2024 11:12:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709579554; x=1710184354;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZV6cPRqKx5ix6M5gdtJYtyedkYWhw05+92IPp1Ctzuk=;
        b=vryQ4l0sX7Jc1WZgXYxw+NK0MfgoyTSJL7+wpR0m1kFWm8psDeKq2uWVXdG05xwM4m
         j6eQ7PfO39KtNWiUq3wqnOWYsobzerBoOidseIJhOgEBqTvbP+Tg2WgYWOcR6eZs6PpT
         bGjQbxTN09PqQJa5g8HsHvBWH4/2kDbYeCUDPUol94aCGGgi5WNm4pBwtbUheI68jm76
         xUu/+EGMxCmiXDaENtZrSU2h/7ohzXU1dR6oTmNUsr429Wl4ll3NIuvutaEASg3+RXdE
         LiA+4lEE2fn0oPOdu45IFECeF7lTMT8y5Ow+GyyNWwzQsbwkygbsLTHqZDdpdALwgzSp
         NY6g==
X-Forwarded-Encrypted: i=1; AJvYcCXChIXv/rS+jo6pycciEBIEpdcIRTehaXLkDzfSqRXYbFT7ktwhj1+vXLM4TWCtZgCZ5Z8xF20yzxkq2T7wWHOeyIyomt29UDFWVDLXhw==
X-Gm-Message-State: AOJu0YyrwKRVKc0E9JowbSvJqNSVQd+kQZGY6WlUDiA/D8ES42pnH9Ua
	SBH4eOjZpnVfnvNlsGY1fSWxAgIxVfcJoXTNhPQVhq68tuGLxT+0nGp0Etqo8UxA5wOFdto2tup
	kKMk3uSPlJUGtLX+dG1EhqkUSrVC9womMZjAKFiAjbQOl2057SaEXm1oVJX+Efw==
X-Received: by 2002:a17:906:a3cd:b0:a45:1f03:4f23 with SMTP id ca13-20020a170906a3cd00b00a451f034f23mr3215552ejb.52.1709579554822;
        Mon, 04 Mar 2024 11:12:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEr0NI1aFj9SyMPj6KLK6wqTh72eLYmQdqNJLscKrLdEp90sMnUKsBE06KkZVd9YcuteqLjDA==
X-Received: by 2002:a17:906:a3cd:b0:a45:1f03:4f23 with SMTP id ca13-20020a170906a3cd00b00a451f034f23mr3215547ejb.52.1709579554621;
        Mon, 04 Mar 2024 11:12:34 -0800 (PST)
Received: from thinky.redhat.com ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id a11-20020a1709064a4b00b00a44a04aa3cfsm3783319ejv.225.2024.03.04.11.12.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 11:12:33 -0800 (PST)
From: Andrey Albershteyn <aalbersh@redhat.com>
To: fsverity@lists.linux.dev,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	chandan.babu@oracle.com,
	djwong@kernel.org,
	ebiggers@kernel.org
Cc: Andrey Albershteyn <aalbersh@redhat.com>
Subject: [PATCH v5 24/24] xfs: enable ro-compat fs-verity flag
Date: Mon,  4 Mar 2024 20:10:47 +0100
Message-ID: <20240304191046.157464-26-aalbersh@redhat.com>
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

Finalize fs-verity integration in XFS by making kernel fs-verity
aware with ro-compat flag.

Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
---
 fs/xfs/libxfs/xfs_format.h | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_format.h b/fs/xfs/libxfs/xfs_format.h
index 3ce2902101bc..be66f0ab20cb 100644
--- a/fs/xfs/libxfs/xfs_format.h
+++ b/fs/xfs/libxfs/xfs_format.h
@@ -355,10 +355,11 @@ xfs_sb_has_compat_feature(
 #define XFS_SB_FEAT_RO_COMPAT_INOBTCNT (1 << 3)		/* inobt block counts */
 #define XFS_SB_FEAT_RO_COMPAT_VERITY   (1 << 4)		/* fs-verity */
 #define XFS_SB_FEAT_RO_COMPAT_ALL \
-		(XFS_SB_FEAT_RO_COMPAT_FINOBT | \
-		 XFS_SB_FEAT_RO_COMPAT_RMAPBT | \
-		 XFS_SB_FEAT_RO_COMPAT_REFLINK| \
-		 XFS_SB_FEAT_RO_COMPAT_INOBTCNT)
+		(XFS_SB_FEAT_RO_COMPAT_FINOBT  | \
+		 XFS_SB_FEAT_RO_COMPAT_RMAPBT  | \
+		 XFS_SB_FEAT_RO_COMPAT_REFLINK | \
+		 XFS_SB_FEAT_RO_COMPAT_INOBTCNT| \
+		 XFS_SB_FEAT_RO_COMPAT_VERITY)
 #define XFS_SB_FEAT_RO_COMPAT_UNKNOWN	~XFS_SB_FEAT_RO_COMPAT_ALL
 static inline bool
 xfs_sb_has_ro_compat_feature(
-- 
2.42.0


