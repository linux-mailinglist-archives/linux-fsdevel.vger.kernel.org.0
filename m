Return-Path: <linux-fsdevel+bounces-45998-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD4E3A8106D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Apr 2025 17:44:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF2E4189EC14
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Apr 2025 15:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3C48226D0C;
	Tue,  8 Apr 2025 15:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i75VhIwH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33CA522B8A1
	for <linux-fsdevel@vger.kernel.org>; Tue,  8 Apr 2025 15:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744126823; cv=none; b=HPcMp6y0RVXNhUERdRd4ImT6Z4Mbh6SIn4HpSRgF+DUoeLiwegNurvuwCxGhlCxK19waI+WpZSqWDOaFI2XQg+MoZJkYbacDbKP6X6OYes4RDGk3lnC9EY5cvV+HefyNFauLxPJ/uRi22f4K7jvzfwkYxpE7Fx2UFneinDJ5WMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744126823; c=relaxed/simple;
	bh=3OqX7/HXnAJ7kWQYc8jrodPhsTz38Nm57Ur1bhCHh+U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UmHoAxesZFFfrQZ7E/muLps8FNv0lW5AgvvWudFdN6FklfZesuElzROguoJ0kWg0IFUN578eIALDQyDROu/RK5I2CZ5JR+IcpZpx45LECfOPF1gpah+q70ZWvXPV/5pVxTxBYdiU6sUGgE8EgFpcPOYC70Ebzp3fRbv2X4h2H3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i75VhIwH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744126818;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PN6AWjrtRHghDIIvCf4IOAVUwqVcmDLtwrlJMGXZbVE=;
	b=i75VhIwHedMZsVWuNTAxp7KVzbFMwQjlNMkodPj/qTWYFouJAQsEXYRN31S2rKQn4E1lvF
	/ezvuWYJsg4EtZVJC+Nik3s5DF4bOu8Be0DJ6zUIs5bbzZL/5QF7q2gDpaXxyWJRXlBUH8
	tBbJ96UZ9SEIfyjZVXLqBBylwVyvI6w=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-459-l0D0Q4r9Mmi-q2L8TbS-2g-1; Tue, 08 Apr 2025 11:40:17 -0400
X-MC-Unique: l0D0Q4r9Mmi-q2L8TbS-2g-1
X-Mimecast-MFC-AGG-ID: l0D0Q4r9Mmi-q2L8TbS-2g_1744126816
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-ac25852291cso578330566b.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 08 Apr 2025 08:40:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744126816; x=1744731616;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PN6AWjrtRHghDIIvCf4IOAVUwqVcmDLtwrlJMGXZbVE=;
        b=PSdS805s/MjMzHPDxaJArxDDdMKl1PiLx4hVXzNN9vLcucoBvzLLsK2+U1LpqcZbAg
         /T26yFSlX1tjWaXxcJuRcqVXw2GKtapP0IE4MIsuFr21U/HEL6Icr8QsJA+F/Dm0BbM4
         CFeWblBXM/k3QDdqmMpii5DxmDpYV+dRbbxhiiFb1Cf7Bi4TljO3L+GRo5a6PsO/5q81
         C7xT9ZfSDNNOU+E6onuoTVzDf+FI70+XhFhnq30S694QvqSTaoc6+zuSE3Bjq6WYxRfS
         iRI8coWmkk3beD1ngpT1GmAuzpz8c+wQHGTzCskPv7jc0IIoWSXlSBtTub0ZsIpHQITL
         tKzw==
X-Forwarded-Encrypted: i=1; AJvYcCUA7toQOoNhIYcyZ68zBAAZgGJAczBY64bUNMUutpmIfY9h3n3xyv26Dhqyw9Rp2OeEodwgc8nIgR4Ii0Bf@vger.kernel.org
X-Gm-Message-State: AOJu0YxJUj6Pzbrsov48bG8/cz35NJL+de4NrEP5fx7KPuQfme1ntUXF
	g+5cNXpmR50wxkUhCTaJFJfaHmrRQvhIxKyaPIqLXlUNYk+2ShU3a0XHU9KWmWk6KMwQdffgxTn
	QIhxY+BoF9cTLDwziTSxed57DBea4MSqgrAqpGtp7PGF5YF5S0F+K1tIgRhMJgTc=
X-Gm-Gg: ASbGncucRY4i8TLYpwzaG1OD8FzSuTuMz2igyvLkJfTYLIBSo2yhCW779MvqrWPETCe
	rG1EMjbLqQJnF5iOlad3Mrj8hPImTU3Qk/WEJ7QaAMo3lMamZKSF7ffFTj2HOU6jWoWnR3uW71u
	NYCWmoOhtDAv3NEsDqaM5W6E8U+IiwNcq3gLRUNXI0MDon28XWn6z4aVwXAeyF2O2jwsY43NFYw
	HJxRqQrJfd9HxTkKFl3eOh4NykQAbG9Da9H3i9ISTQPvzTw+6pILQJmsK0Jj1nACcukaMn364Pu
	ANkW0IxoSPlXkkPrPXp9izUN9zgqSOisD1XvV2tYLcEzFZDwTdTFMMMDf8axLPeL93GyVf7L
X-Received: by 2002:a17:906:5a4b:b0:ac7:e492:40d with SMTP id a640c23a62f3a-ac7e49209ddmr1102000666b.32.1744126816369;
        Tue, 08 Apr 2025 08:40:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHj8lXffDci56FA1P0NxUfnXmOBj0Hc3hmrjp4qZZ1KQy4AcmxFhC8j1v3veuCkfZ6qbLKmOw==
X-Received: by 2002:a17:906:5a4b:b0:ac7:e492:40d with SMTP id a640c23a62f3a-ac7e49209ddmr1101999166b.32.1744126815959;
        Tue, 08 Apr 2025 08:40:15 -0700 (PDT)
Received: from maszat.piliscsaba.szeredi.hu (193-226-212-63.pool.digikabel.hu. [193.226.212.63])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac7c01bb793sm927553766b.161.2025.04.08.08.40.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 08:40:15 -0700 (PDT)
From: Miklos Szeredi <mszeredi@redhat.com>
To: linux-unionfs@vger.kernel.org
Cc: Amir Goldstein <amir73il@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	Giuseppe Scrivano <gscrivan@redhat.com>,
	Alexander Larsson <alexl@redhat.com>
Subject: [PATCH v3 3/3] ovl: don't require "metacopy=on" for "verity"
Date: Tue,  8 Apr 2025 17:40:04 +0200
Message-ID: <20250408154011.673891-4-mszeredi@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408154011.673891-1-mszeredi@redhat.com>
References: <20250408154011.673891-1-mszeredi@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This allows the "verity" mount option to be used with "userxattr" data-only
layer(s).

Also it allows dropping the "metacopy=on" option when the "datadir+" option
is to be used.  This cleanly separates the two features that have been
lumped together under "metacopy=on":

 - data-redirect: data access is redirected to the data-only layer

 - meta-copy: copy up metadata only if possible

Previous patches made sure that with "userxattr" metacopy only works in the
lower -> data scenario.

In this scenario the lower (metadata) layer must be secured against
tampering, in which case the verity checksums contained in this layer can
ensure integrity of data even in the case of an untrusted data layer.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/overlayfs/params.c | 26 ++------------------------
 1 file changed, 2 insertions(+), 24 deletions(-)

diff --git a/fs/overlayfs/params.c b/fs/overlayfs/params.c
index 2468b436bb13..e297681ecac7 100644
--- a/fs/overlayfs/params.c
+++ b/fs/overlayfs/params.c
@@ -871,18 +871,6 @@ int ovl_fs_params_verify(const struct ovl_fs_context *ctx,
 		config->uuid = OVL_UUID_NULL;
 	}
 
-	/* Resolve verity -> metacopy dependency */
-	if (config->verity_mode && !config->metacopy) {
-		/* Don't allow explicit specified conflicting combinations */
-		if (set.metacopy) {
-			pr_err("conflicting options: metacopy=off,verity=%s\n",
-			       ovl_verity_mode(config));
-			return -EINVAL;
-		}
-		/* Otherwise automatically enable metacopy. */
-		config->metacopy = true;
-	}
-
 	/*
 	 * This is to make the logic below simpler.  It doesn't make any other
 	 * difference, since redirect_dir=on is only used for upper.
@@ -890,18 +878,13 @@ int ovl_fs_params_verify(const struct ovl_fs_context *ctx,
 	if (!config->upperdir && config->redirect_mode == OVL_REDIRECT_FOLLOW)
 		config->redirect_mode = OVL_REDIRECT_ON;
 
-	/* Resolve verity -> metacopy -> redirect_dir dependency */
+	/* metacopy -> redirect_dir dependency */
 	if (config->metacopy && config->redirect_mode != OVL_REDIRECT_ON) {
 		if (set.metacopy && set.redirect) {
 			pr_err("conflicting options: metacopy=on,redirect_dir=%s\n",
 			       ovl_redirect_mode(config));
 			return -EINVAL;
 		}
-		if (config->verity_mode && set.redirect) {
-			pr_err("conflicting options: verity=%s,redirect_dir=%s\n",
-			       ovl_verity_mode(config), ovl_redirect_mode(config));
-			return -EINVAL;
-		}
 		if (set.redirect) {
 			/*
 			 * There was an explicit redirect_dir=... that resulted
@@ -970,7 +953,7 @@ int ovl_fs_params_verify(const struct ovl_fs_context *ctx,
 	}
 
 
-	/* Resolve userxattr -> !redirect && !metacopy && !verity dependency */
+	/* Resolve userxattr -> !redirect && !metacopy dependency */
 	if (config->userxattr) {
 		if (set.redirect &&
 		    config->redirect_mode != OVL_REDIRECT_NOFOLLOW) {
@@ -982,11 +965,6 @@ int ovl_fs_params_verify(const struct ovl_fs_context *ctx,
 			pr_err("conflicting options: userxattr,metacopy=on\n");
 			return -EINVAL;
 		}
-		if (config->verity_mode) {
-			pr_err("conflicting options: userxattr,verity=%s\n",
-			       ovl_verity_mode(config));
-			return -EINVAL;
-		}
 		/*
 		 * Silently disable default setting of redirect and metacopy.
 		 * This shall be the default in the future as well: these
-- 
2.49.0


