Return-Path: <linux-fsdevel+bounces-56186-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D4A6B1433C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jul 2025 22:33:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E1CC18C2D5D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jul 2025 20:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96F2E2857F7;
	Mon, 28 Jul 2025 20:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eSma5KuA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B74D28468C
	for <linux-fsdevel@vger.kernel.org>; Mon, 28 Jul 2025 20:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753734716; cv=none; b=XdaeGxgMBYehlxSr4nD0QDeuT0v+V72jK0rex0swlNAjwZVTWk/lBkXriKrtgJS4GOxRFXnZHZnkhDllgcfLYb17+u+fZ8uHwCYhfxwLWFjOC+3AmHdheAeTHgW6lu5wHcqyJS155mrP++fgORaWHQ9oWA0DyhYUAuL+fLOV4QY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753734716; c=relaxed/simple;
	bh=XZog9aZiyfgLoq7Tkao+LQWKyegfQweHS6lu6myBM8g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tfztiAV9ryUhiYAEOgeEJ1cjm7fmrec1+54zXhAO8Cmr5bmzUIqqWv51q/M3Nb0aznydshyyNnGO3i/3iUzCRjJukbu2ZDocuPlPEBgs5wcm4w+gj8Vd+FTW8VcpL4i0gu81U5DqfVEaakDzSaJzAb0mWIQvknuC3iT/9U+2e6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eSma5KuA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753734713;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gH0Lip9xmhyDI76+rRDc64g7XoAkacubf8KpRqwbwBI=;
	b=eSma5KuAEr7UnOFVZ7mIcDRc7A5hflUsFIzvtaBh+MYTNB7XH/OEG6CovzsM1cgddLWhoP
	Dp9KNShO+Utuuxxl30cj0ORbxYpA8t0lk0q5+EtxW2kn1vvmjT//hEIfbskkOOYqwu58/3
	/Hsqaesm3MI/foeHh2aFAj5fJmdajIU=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-530-QQcyQmSGMXeiWjSiXRRrLg-1; Mon, 28 Jul 2025 16:31:52 -0400
X-MC-Unique: QQcyQmSGMXeiWjSiXRRrLg-1
X-Mimecast-MFC-AGG-ID: QQcyQmSGMXeiWjSiXRRrLg_1753734711
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-612be84c047so5107952a12.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Jul 2025 13:31:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753734711; x=1754339511;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gH0Lip9xmhyDI76+rRDc64g7XoAkacubf8KpRqwbwBI=;
        b=rbJTAf8eK3hBL6Z/jf05G+9RRX/HHBhpKeFhLOlBP8RCUXn1RK37ztIDQy97TsZi/F
         MsyhLNlfDXDMsc/2balk4s7tDQ7aoD30Yvg4pcQSHPQYi9BMZZfoPLu8LpFhn4OkMO+U
         FKaOJQ4VdLTd4G05K3pdYhEBgp/eFNh1nqhXioUSkea7o0iS3fwAKCfiJicu9Dg0Svid
         fF4YoEoT7yIRFO5JbbA+Mp33Rlogya7OIh1dRJrTOg3LvlryNwgkTdSwT2q8sy7sBFr9
         ESts6Un/MmGpXqkO8BGMjmsvGrUWLjSbcvskecF5jIZMHVZatup6dFHYtSRTVlJDE8AV
         eS5g==
X-Forwarded-Encrypted: i=1; AJvYcCXDk4jseRw7KeSB3HMQJuZjamHD+D6dCA07XtTW/uLVMUQUaknra2TIZRo6Ee+zvILIG98nJOSZcfa/t2k4@vger.kernel.org
X-Gm-Message-State: AOJu0YwqSJ7Guu8N5R/A71lXFyS9z8e6UirFG+/q/6EdNGNFXcbSl388
	NghyYrMpRInQDp9pM6HnnKaUY9tTiy247PF3Ga6lHxOCtQWYewPCkuz9cz3WS6IX4vBX27nWBJW
	MFy8vkKOAyXu2gpqBOzIJXrbwUI/P50vjjsaJ6SSGIMsKu7CEqiKyxTjp/lI3x72xtg==
X-Gm-Gg: ASbGnct5gVVKXQXQjjOpfBsohdN+djP2n5ztIpAt8d5xyFFy07wLVbVCd0QsZcNSd8y
	wo6xy62IBKuvWfV36fSKAmXu8b4oBeOYPdBfftULViFBGX5JZUDfTKiGat/J2dTDVfNeCG9PZfy
	49+emxg7Wkd2VZ6G0zzjiv0Yh7PjT3e4xeRN/WLNyFXFuFFC7jSShuRb5hQTV3s08lp2kot6TBE
	xRWHhHc6yKBC/AguO28QnNgN/68gAQ8c5frAJGaUKD6/WULnUTVAv529O9lw7Zp4min3dv6eqVH
	D0RTPtyQyhFF/kVtYUZ3s2B85WBSr5GAHqKuDNcA6nx8KA==
X-Received: by 2002:a05:6402:2756:b0:609:d491:8d7c with SMTP id 4fb4d7f45d1cf-614f1f66f87mr11976071a12.33.1753734710738;
        Mon, 28 Jul 2025 13:31:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHI3KbTQXSSj5d0i+WPVKT4xKWHTGAUK9qnZRk/deHjUofLu4acifg7ReKqkBwYsZpz0medqQ==
X-Received: by 2002:a05:6402:2756:b0:609:d491:8d7c with SMTP id 4fb4d7f45d1cf-614f1f66f87mr11976045a12.33.1753734710264;
        Mon, 28 Jul 2025 13:31:50 -0700 (PDT)
Received: from [127.0.0.2] (ip-217-030-074-039.aim-net.cz. [217.30.74.39])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615226558d3sm2730656a12.45.2025.07.28.13.31.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 13:31:49 -0700 (PDT)
From: Andrey Albershteyn <aalbersh@redhat.com>
X-Google-Original-From: Andrey Albershteyn <aalbersh@kernel.org>
Date: Mon, 28 Jul 2025 22:30:33 +0200
Subject: [PATCH RFC 29/29] xfs: enable ro-compat fs-verity flag
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250728-fsverity-v1-29-9e5443af0e34@kernel.org>
References: <20250728-fsverity-v1-0-9e5443af0e34@kernel.org>
In-Reply-To: <20250728-fsverity-v1-0-9e5443af0e34@kernel.org>
To: fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
 linux-xfs@vger.kernel.org, david@fromorbit.com, djwong@kernel.org, 
 ebiggers@kernel.org, hch@lst.de
Cc: Andrey Albershteyn <aalbersh@redhat.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1038; i=aalbersh@kernel.org;
 h=from:subject:message-id; bh=/S+exzUxtYfMmpJRCWmXU4e4VlkdT3KBsUDTnMS5dHE=;
 b=owJ4nJvAy8zAJea2/JXEGuOHHIyn1ZIYMtrvSdbUMs6aPjvsoGNA8Cp/k1aH29nLGDmvrs7ZN
 vW67AK+rdwdpSwMYlwMsmKKLOuktaYmFUnlHzGokYeZw8oEMoSBi1MAJiI/keG/R+3FQz9ndnRe
 eGTkurXGke/IjlchefdnNWj3KQTMbH4Ux/A/KWgHS3vJ+Se8VZ/9Ele9Dk4J8Zhrvkmz696230+
 KO+vZAAuSSbM=
X-Developer-Key: i=aalbersh@kernel.org; a=openpgp;
 fpr=AE1B2A9562721A6FC4307C1F46A7EA18AC33E108

From: Andrey Albershteyn <aalbersh@redhat.com>

Finalize fs-verity integration in XFS by making kernel fs-verity
aware with ro-compat flag.

Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
[djwong: add spaces]
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/xfs/libxfs/xfs_format.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_format.h b/fs/xfs/libxfs/xfs_format.h
index 1cd9106d852b..b61dccf8cc38 100644
--- a/fs/xfs/libxfs/xfs_format.h
+++ b/fs/xfs/libxfs/xfs_format.h
@@ -378,8 +378,9 @@ xfs_sb_has_compat_feature(
 #define XFS_SB_FEAT_RO_COMPAT_ALL \
 		(XFS_SB_FEAT_RO_COMPAT_FINOBT | \
 		 XFS_SB_FEAT_RO_COMPAT_RMAPBT | \
-		 XFS_SB_FEAT_RO_COMPAT_REFLINK| \
-		 XFS_SB_FEAT_RO_COMPAT_INOBTCNT)
+		 XFS_SB_FEAT_RO_COMPAT_REFLINK | \
+		 XFS_SB_FEAT_RO_COMPAT_INOBTCNT | \
+		 XFS_SB_FEAT_RO_COMPAT_VERITY)
 #define XFS_SB_FEAT_RO_COMPAT_UNKNOWN	~XFS_SB_FEAT_RO_COMPAT_ALL
 static inline bool
 xfs_sb_has_ro_compat_feature(

-- 
2.50.0


