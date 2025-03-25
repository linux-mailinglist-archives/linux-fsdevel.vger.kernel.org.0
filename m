Return-Path: <linux-fsdevel+bounces-44942-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 51612A6EE22
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Mar 2025 11:46:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0051D1891383
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Mar 2025 10:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5A8B255E23;
	Tue, 25 Mar 2025 10:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K2+0VCDU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D683254AE2
	for <linux-fsdevel@vger.kernel.org>; Tue, 25 Mar 2025 10:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742899605; cv=none; b=e48wZ8nzTtTZgKTcHAq/AzgT2AhRCbr9tYfYNb0oi+cJhUVmG6Yds3brerpsaXQOi+v3W9147ha9KM8Hz1j48oABAynOnAOpnHErrNtREbtaqfOm0rA+Qw7z3i+Jutb0HbcdR+vsEOWYkusNtssg4KzZMrelNXjJaTp2XqqgnGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742899605; c=relaxed/simple;
	bh=vkbpeFmqD668MPanvRonoQwCZ0BQK81IhaRcc7RnYTo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tx2zwailEtotQrwHyEe8My9DLLVJEzwI1sg4b7fUAvGP1GpgZ5u+1Sv+UoNanwodJG62cyLrqgv/XfeIRcE7h8vOde5u8ca0O5zipWNKnNyzk7wCYhJuiC+iENmoUZnzFMiJ+fxTXD+LP4vveVH1f6oIEEQCiPYPitaeA2CZOm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K2+0VCDU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742899602;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IL/6aR5DxlrxjOnL/vY3X0cqTZslpUhOi/XOXuXLhhE=;
	b=K2+0VCDUDeiocnZFS7ugxJwxfwK+1hquK05vv/S9dzlndPvU1ggDKcAu6q8AS3k9JetQhm
	sAKWdf15BptWeDC1bPo9aDTA+7fuxnHZa6lRWg2aD3MNEjwYhAQmrrwDLr+mhpHUr1E6/s
	xNsqNSc1XLcog0kWC96wAo5uh34gqQE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-537-S03YhoQ4N0Shabu7sXQFcA-1; Tue, 25 Mar 2025 06:46:38 -0400
X-MC-Unique: S03YhoQ4N0Shabu7sXQFcA-1
X-Mimecast-MFC-AGG-ID: S03YhoQ4N0Shabu7sXQFcA_1742899598
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-399744f742bso1303836f8f.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Mar 2025 03:46:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742899597; x=1743504397;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IL/6aR5DxlrxjOnL/vY3X0cqTZslpUhOi/XOXuXLhhE=;
        b=pIyh9tgxmNACbv96Z9hwl6Jlg9JOvIFqXZ07MB3WA7eFwnhX3Ulsz5eayJSxkuH7am
         Teo2hrI3vUCPe80YrTPBT297Am15teFmRc2qkbfyrQsH9neEJs7yPTLh0/PjyHGiS14f
         w8XzQCA1dNO/a7KUF5GTh2l1XsJPceQmICwkEq1YOH7ZZFiG8hcgYPtw8ol3OFmS2O35
         W7U3CyhxiVkzxD+9lgCFl+zOVIufIe0FIi4HfjHYPZh6/O9WHoVS9NpZ3tbwR0wnam9b
         R21U+r4UMC0O3h4kFLOgShwOIJ9ZCLdX5JTZatqKMUltduposPLLgXNsOR+XFXw9QcMm
         uPvw==
X-Forwarded-Encrypted: i=1; AJvYcCWdpltikLDI+WMZrV2EypugOSKG3I2h0nf1AdWaRZfoDg8tnN5KgOvw92q34wN75srSi4nH9cpx1ZgB/vb5@vger.kernel.org
X-Gm-Message-State: AOJu0YywrGFwKlQBa1iYB7UPBBktMgfcqhStiDYoZF2pZ2G/U1ICEZU8
	gp/zVRmJX1063x8OndudAnsogj2P6U2xVEp3JJIjsdFQnKXP8O7n5R/kI5iC1kUq4N0Dnyhuu+A
	Z02qmNxQ+uweB4OIzErpjNCFKX48Oeu9vgJVqVRrHxm/+Yeuq8sTWuJX1PrBtuRDpRrRMQqk=
X-Gm-Gg: ASbGncvJw/9yA9ar6yt1uRh5n2BMrnUWZygArHfZPOCUl67l9Z64UtwHqXBtPASbd0B
	0n3XXMsT71b3abvwSPMCSoty7JzaaSHpkeoH7bUvOzyuWpl8db+5xBGJkn/UaiagKjP5XpuRwT5
	baSG8zc4k1dCld8qXM2490wexdMG4lLGOs+c2wPSVdHU/yD+T2ZQH6ucvwnw/sMoWH0UKoMU382
	FQR6IljWWjBeo8DWjx90tDqDMKPNoLpYj8kjpPmCEHKjfqMkqmLGfEPos9v6U6BR0aUNUsUOVc7
	CXzv4oejPcYG4q/uboGtXfzNENKuKIW62DsMRn6oHYsim9vBIhGKUhc/UM0mN5NUVWw=
X-Received: by 2002:a05:6000:2cd:b0:391:2f2f:818 with SMTP id ffacd0b85a97d-3997f8edc1dmr15905512f8f.9.1742899597445;
        Tue, 25 Mar 2025 03:46:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEw5sCn6O0eZPQdrxPvOONhB4Ut43Nqsv6iiLVmfKeBePtnVQmM3EmzBo2MGDhKqQ2BMNL+cw==
X-Received: by 2002:a05:6000:2cd:b0:391:2f2f:818 with SMTP id ffacd0b85a97d-3997f8edc1dmr15905478f8f.9.1742899597091;
        Tue, 25 Mar 2025 03:46:37 -0700 (PDT)
Received: from maszat.piliscsaba.szeredi.hu (87-97-53-119.pool.digikabel.hu. [87.97.53.119])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9a50c1sm13572203f8f.38.2025.03.25.03.46.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 03:46:36 -0700 (PDT)
From: Miklos Szeredi <mszeredi@redhat.com>
To: linux-unionfs@vger.kernel.org
Cc: Amir Goldstein <amir73il@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	Giuseppe Scrivano <gscrivan@redhat.com>,
	Alexander Larsson <alexl@redhat.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 1/5] ovl: don't allow datadir only
Date: Tue, 25 Mar 2025 11:46:29 +0100
Message-ID: <20250325104634.162496-2-mszeredi@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250325104634.162496-1-mszeredi@redhat.com>
References: <20250325104634.162496-1-mszeredi@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In theory overlayfs could support upper layer directly referring to a data
layer, but there's no current use case for this.

Originally, when data-only layers were introduced, this wasn't allowed,
only introduced by the "datadir+" feature, but without actually handling
this case, resulting in an Oops.

Fix by disallowing datadir without lowerdir.

Reported-by: Giuseppe Scrivano <gscrivan@redhat.com>
Fixes: 24e16e385f22 ("ovl: add support for appending lowerdirs one by one")
Cc: <stable@vger.kernel.org> # v6.7
Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/overlayfs/super.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index 86ae6f6da36b..b11094acdd8f 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -1137,6 +1137,11 @@ static struct ovl_entry *ovl_get_lowerstack(struct super_block *sb,
 		return ERR_PTR(-EINVAL);
 	}
 
+	if (ctx->nr == ctx->nr_data) {
+		pr_err("at least one non-data lowerdir is required\n");
+		return ERR_PTR(-EINVAL);
+	}
+
 	err = -EINVAL;
 	for (i = 0; i < ctx->nr; i++) {
 		l = &ctx->lower[i];
-- 
2.49.0


