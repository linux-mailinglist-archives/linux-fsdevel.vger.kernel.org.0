Return-Path: <linux-fsdevel+bounces-73243-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A95ED13624
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 16:00:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5F4A93054824
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 14:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F6C12561AA;
	Mon, 12 Jan 2026 14:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VOqaX7yR";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="fvaA9KOH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92B61E4AF
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Jan 2026 14:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768229404; cv=none; b=f5PGZUEGleKgzKteCOsXPnvohr3kPMQlzb0G+7tI6XEx1RPjNmcPUz+kRugCPCyeXRew65yNCcLAw/O8/L7GtvXwV8kYS2XZk0ByJwU9KVyUpSMbe9TCxOPhrzkq16bCMK39A0/u1abt9L14ZJJRpr05y/0KVkfu65T7xMsMmCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768229404; c=relaxed/simple;
	bh=QDfZ8MkROd0wJjK7M+RYgL9KXYxxKT+CJ2sFh4GPSIA=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WupJf5mA/2hAE97TnrV1VX9S+vqEdq0AmegZ48jYJIR38Dkg31HWTszNBccwfZScutD7nb9j+qdnvQcuB/NA8g1Tw7BcG6ioc6jeY0HEq6OHYSoKekltNOqtcHAB2p9ngH21NtL8PLZNsaIaOM8lAYojsft3dO/jIRcwBYp6r6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VOqaX7yR; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=fvaA9KOH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768229401;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4hgQSkKK+wNsFGyx/8yulCRj19FYSipD3tFWb0OgBMQ=;
	b=VOqaX7yRFLuWrDv0nyWR/3h1oKva4wV/eCCS3VBDdwVDFVRbbYODqeRZrPJXWNnIw7jlJJ
	vrzVVZuTP3uyF8l6U+kvbEDsiDZk/fIS7U+QjrN1TC7JlNGIOBhgoMmqp07c0fJna4fdrZ
	04dyVMx96C4uRcCifjrLim2x0mYG0q8=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-s7d4jjUyPFy7FeOXnnxfvg-1; Mon, 12 Jan 2026 09:50:00 -0500
X-MC-Unique: s7d4jjUyPFy7FeOXnnxfvg-1
X-Mimecast-MFC-AGG-ID: s7d4jjUyPFy7FeOXnnxfvg_1768229399
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-b8718916c9aso155021966b.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Jan 2026 06:50:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768229399; x=1768834199; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4hgQSkKK+wNsFGyx/8yulCRj19FYSipD3tFWb0OgBMQ=;
        b=fvaA9KOHr4r1gzjKOkgmGDoTtOaq4/zZ9spl/+N/cVUhhO13MsQvOjifxVN0wfwr7D
         hkwt6s2it16Hip+0cwCMUyYnCNT5mZlZUgzpVwJ15SgaDyQRO+Crs6qF4AiWCG+XSzaO
         XV5Pw9cAyhmglJd0y0qnbqdIPI+I8OnXopku7VhiYjEOX9IuobjPVgaas2dsSFi9m+2x
         Yrl6qa3STte5/ZLTgGLUkT7wsLa+6ue8KZiic1LBfkj5lJLEFbRAeb3aYaXC/b67Qmuo
         Rh8Y+FB9uC9JlZiYfodzptoW9gm5FjzgFdqRBe72Q1/MgU9WiHbckURI7+9BqjA0t2qc
         ybkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768229399; x=1768834199;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4hgQSkKK+wNsFGyx/8yulCRj19FYSipD3tFWb0OgBMQ=;
        b=HNm1NBceOK+rhs/TG9lNcF7xEnM3j7aCTWTmvf+aigCOmrb8BwCO38tdTdj4WBFp72
         n6VBIB3uh0WCvKkhXtyr6EPz/hxrEdVpAu9AtSgSVGy2u/cC3Kn/FlVLAIjJwR3EaacK
         cEbT6/YqHcg5/1FVLyvmiK1nkReDdgvyDW5d5Cl75ZE+erhDyHjqPjHJewF1y0S9pzhy
         YcGq8137pHjLIXDu4LjYVRm+q+tuumWvDZa62h1PMKH3GlPpW+fMMlSvaIAwQ9QE4Vng
         3tGkiAyvrlbSKBFKqvQJvzlX2braIm8WQT2Ni7LRbCRXfZbAPzE7XRiR0XUi7sVI/Ty+
         2ANw==
X-Forwarded-Encrypted: i=1; AJvYcCUBOrlU94idBdwLqIitOw6YNBI3tjWNl74dU0tX6DJjUgDQtF93UXM+kBxX+aqJW4s55C7AzIAXJZhjDiwT@vger.kernel.org
X-Gm-Message-State: AOJu0YyDDOGA41jHz9iKOjBg1smFFF5pt+U5InhJrW2RjFJKN+Ud/Huc
	aIMYOfcvJ19In7NB9b9UJ3IXH91egblTimkKoCD3DEUyEFxiJIIkQ44z82qvV7+X6h52BCpSBiT
	w1L0Xvnq43b1Y/kUIRHZN7V4laI7D4FuXTNH3qeWtEZaGl8gXw2jHBKO0x203+EPXjA==
X-Gm-Gg: AY/fxX5vVMD1dLqTIMoYeirMZcLveJ7ctW2AJhj10cxFcSEmjDSifSt0bP6nGvYMWzj
	ttNyjJRZ0UYSl68rAnXKzYINzzTml5pMScDqcG2RKZ4DzbjZiZA5Gn60Yu+Ker+U9/wMHH9K9g+
	kKAlDLIibmW+E9nWRnXXjjC2mzf1f9g1Rxlyi/nIwnsEdrdRAMIx0+1UylytUlIy91dazey54Z5
	QBCyGilHMCK1LUqEEQPXz6gH7bh04T7M+7Ou/nLzB4rUyyJP6Vu8BN9EDom9fQrq/eNY+hcpdz9
	jipMIavJhnfj+V/OTTGey1ucehGmaHQPKtAdL7w1zAvSY3yD5B+H4VEg8h1j6Zfe0XXzTbQg62g
	=
X-Received: by 2002:a17:906:ef0c:b0:b73:8b79:a31a with SMTP id a640c23a62f3a-b8444c6c0bdmr1718264366b.16.1768229399191;
        Mon, 12 Jan 2026 06:49:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGKY6lRBB+8CcKc1C5F87kN75SYxXHWrYKMTeyuCLT+7rcJtaMRuQ85TjaYABVcbwCN2IaTLw==
X-Received: by 2002:a17:906:ef0c:b0:b73:8b79:a31a with SMTP id a640c23a62f3a-b8444c6c0bdmr1718262466b.16.1768229398665;
        Mon, 12 Jan 2026 06:49:58 -0800 (PST)
Received: from thinky ([217.30.74.39])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6507b8c3f89sm17933541a12.5.2026.01.12.06.49.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 06:49:58 -0800 (PST)
From: Andrey Albershteyn <aalbersh@redhat.com>
X-Google-Original-From: Andrey Albershteyn <aalbersh@kernel.org>
Date: Mon, 12 Jan 2026 15:49:57 +0100
To: fsverity@lists.linux.dev, linux-xfs@vger.kernel.org, 
	ebiggers@kernel.org, linux-fsdevel@vger.kernel.org, aalbersh@kernel.org, 
	aalbersh@redhat.com, djwong@kernel.org
Cc: djwong@kernel.org, david@fromorbit.com, hch@lst.de
Subject: [PATCH v2 2/22] fsverity: expose ensure_fsverity_info()
Message-ID: <unedx6vzej4wyd2ieani54tvvubox2epnl4eghv4caykbzinef@g72j7l2hcufp>
References: <cover.1768229271.patch-series@thinky>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1768229271.patch-series@thinky>

This function will be used by XFS's scrub to force fsverity activation,
therefore, to read fsverity context.

Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
---
 fs/verity/open.c         | 4 ++--
 include/linux/fsverity.h | 2 ++
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/verity/open.c b/fs/verity/open.c
index 77b1c977af..956ddaffbf 100644
--- a/fs/verity/open.c
+++ b/fs/verity/open.c
@@ -350,7 +350,7 @@
 	return 0;
 }
 
-static int ensure_verity_info(struct inode *inode)
+int fsverity_ensure_verity_info(struct inode *inode)
 {
 	struct fsverity_info *vi = fsverity_get_info(inode);
 	struct fsverity_descriptor *desc;
@@ -380,7 +380,7 @@
 {
 	if (filp->f_mode & FMODE_WRITE)
 		return -EPERM;
-	return ensure_verity_info(inode);
+	return fsverity_ensure_verity_info(inode);
 }
 EXPORT_SYMBOL_GPL(__fsverity_file_open);
 
diff --git a/include/linux/fsverity.h b/include/linux/fsverity.h
index b75e232890..16a6e51705 100644
--- a/include/linux/fsverity.h
+++ b/include/linux/fsverity.h
@@ -196,6 +196,8 @@
 int __fsverity_prepare_setattr(struct dentry *dentry, struct iattr *attr);
 void __fsverity_cleanup_inode(struct inode *inode);
 
+int fsverity_ensure_verity_info(struct inode *inode);
+
 /**
  * fsverity_cleanup_inode() - free the inode's verity info, if present
  * @inode: an inode being evicted

-- 
- Andrey


