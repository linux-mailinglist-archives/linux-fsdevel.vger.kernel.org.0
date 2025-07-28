Return-Path: <linux-fsdevel+bounces-56167-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CFEBB14318
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jul 2025 22:32:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FDEC18C2E2C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jul 2025 20:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3275C27E061;
	Mon, 28 Jul 2025 20:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TMZhD9e2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D41F27A915
	for <linux-fsdevel@vger.kernel.org>; Mon, 28 Jul 2025 20:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753734696; cv=none; b=mXqX5eXWKWw+eGc99BRHJB4G75ktef3ImcgkYKiAB0muD/BtHhkaGF4h6h4rEMat45vZ3byUBxyfIW7ufjgY7A5wJxNVBgVfvXuMDCjpAacmLVR4CKdYcLk6toDjIm0o8u2aFkBPRVpKo3TzFOTZuJqTsxMjmLfnvaR/RrRT3Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753734696; c=relaxed/simple;
	bh=oywUNdy9SXNgRvU0YoeafcjM/3VIs70znQ1LmSPU2B4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=M4sQB4NDxRi9F/B4xU1ZotVd3eF/TC5o8UU540uEYue3TiqB8fLu15rr+/NnYhyQMFvMmXeqi5e6kzkNbLVl/hD72c6QvBn2J6AqdmqQ18nGkkZowL+WaJ5XRdKvRocPFWgh8edU+7KxlJb+r2kFc3c8VjeLhTEpzIq8pavV2Xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TMZhD9e2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753734694;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Why2a90OOR2KPUrmkOK42TjhIsW0VoTnCqJDDVQ6oe4=;
	b=TMZhD9e2KB0CMkDXPjVDmGtdIrb55rhmraJXDqIz2FATt6ZCSyixMfkSDXEByQhGpwkNmM
	HOCm9ks6mLltSL/MjKBLOajmiUa37o1qtibcfRaK3Y0GM8yFuVNrSbRbPTYtzejPYDIZUK
	Vjvan6kb5q5jYp3tolKuGrySZaAh+yo=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-300-OUO4v_EoNvewjXLehEcNZA-1; Mon, 28 Jul 2025 16:31:31 -0400
X-MC-Unique: OUO4v_EoNvewjXLehEcNZA-1
X-Mimecast-MFC-AGG-ID: OUO4v_EoNvewjXLehEcNZA_1753734690
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-ae98864f488so553514966b.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Jul 2025 13:31:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753734689; x=1754339489;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Why2a90OOR2KPUrmkOK42TjhIsW0VoTnCqJDDVQ6oe4=;
        b=h9LrkajMYviFuXxk3JNqUQflLlh2qIeZ4UF1vARMNz09tvSXELh7fBQYRwF86UwMOv
         dI3CUBfvrQ7F+qmUnpm0X7V4WnfQxYtFO0JvCy0W4VMz2ZDMwWPkyw2jRUth5tQ8XeD5
         +LaQF69Gi+OkAf3uaoJZXAwj+wNw/Fk8kwVlXWaCzZKPUOpMls9mZ2XUtTgs9HZlzfsZ
         rcj0ZLNktoZ1YFh7yigdT6R7OmyJOaw95FrwEZ2QgdP7j9Zzyh3QlDu/D0LhKMoKD9Lg
         ONoAhGuc+/u29VSXwcRzf3XNkyEXJ7IdFl3V9PTn8zsNT2UPJD3j7OGteN4rDSBZ4tBW
         YuMQ==
X-Forwarded-Encrypted: i=1; AJvYcCUR3BCdFikasmpoymfYWMtk0ciZb6V/o56JM4hKrujs5h2kiqAggL7x5kF55cjZnFSvzBM9g1CtZwy3wZXN@vger.kernel.org
X-Gm-Message-State: AOJu0YxpDReOw5ISjSZ3jNolDfLbEeLBC//SKBD/GpZ27qRimXzQz7tX
	KurmHkIAG2E+0Ffl8z3kF8AxWfJRVBlEqdnPYgIYw/SVYgoQ+52BV1ggzDENQ/iBfQWKxLNZbCY
	wX7NcitvYtMEZ4zZwzxQBhxpOeShwATlnONvrm097JioLnqWcZ8ndxf2FDOwHJGpIU6d7RcZfX2
	S2Rj8rVenmTxC/j4FltAcDWsJXn1kahrDicXzrb0HhJHLCLx2iuw==
X-Gm-Gg: ASbGncs79GQWmONEDWoPzoAknJqrZjJCttwO2JS9Z31Tc7wcLYktGLU/1E9JLjHSQvU
	ieC9eGiXG/1c2fTJWJdOD+XdG0Zfz/w2oWRB2HSnYQ9k7yBO6RA1Qar4ZKsKLsZ1IzxjupVzzJJ
	CAdia3fRhFxq0pLBELqdNI9ZCqxBoynxHFxCALyHQG2zUKgPNxQEIw8y55CJLdEOfE70wcFgwk7
	JdzEq1WTexsXGQkgQnhoo1xKJyI5pKufr2Iy/+77sC7m4wGmBIg5xchrXoj2EBIUs97pFQHrCFb
	FjrQxqkvz6eJ1yj5UkszUC0YazlkkZXqCLmgqR2pfUcN+Q==
X-Received: by 2002:a17:907:7f0c:b0:ad8:9257:573a with SMTP id a640c23a62f3a-af616efc71dmr1429830066b.5.1753734689383;
        Mon, 28 Jul 2025 13:31:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IElqLNNpMpUzeIxl4kr/PFatnBAKdgVdcL/2FQoChJ3mBvf5eeLG5rjoJQ3gDbaVWDOhBqS3g==
X-Received: by 2002:a17:907:7f0c:b0:ad8:9257:573a with SMTP id a640c23a62f3a-af616efc71dmr1429825766b.5.1753734688875;
        Mon, 28 Jul 2025 13:31:28 -0700 (PDT)
Received: from [127.0.0.2] (ip-217-030-074-039.aim-net.cz. [217.30.74.39])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615226558d3sm2730656a12.45.2025.07.28.13.31.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 13:31:28 -0700 (PDT)
From: Andrey Albershteyn <aalbersh@redhat.com>
X-Google-Original-From: Andrey Albershteyn <aalbersh@kernel.org>
Date: Mon, 28 Jul 2025 22:30:12 +0200
Subject: [PATCH RFC 08/29] ext4: use a per-superblock fsverity workqueue
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250728-fsverity-v1-8-9e5443af0e34@kernel.org>
References: <20250728-fsverity-v1-0-9e5443af0e34@kernel.org>
In-Reply-To: <20250728-fsverity-v1-0-9e5443af0e34@kernel.org>
To: fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
 linux-xfs@vger.kernel.org, david@fromorbit.com, djwong@kernel.org, 
 ebiggers@kernel.org, hch@lst.de
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1033; i=aalbersh@kernel.org;
 h=from:subject:message-id; bh=8eioOXLwKFbWQjOAzR05yR6o85tqQ9fD9/ewRMN73qY=;
 b=owJ4nJvAy8zAJea2/JXEGuOHHIyn1ZIYMtrviStxfr8V+zzu88HeFq/NhRLCl9kXnNFsPcB6e
 /qJDIHzVtkdpSwMYlwMsmKKLOuktaYmFUnlHzGokYeZw8oEMoSBi1MAJmL/guF/6StJt4ZHu6Un
 uucKypWZSByuXP24xklOeHFOkcuX5k+VDP+07MNvHDm/Yo/UfNu9K/zj3jfwikiapM5v9Wv/+qO
 iei8/AGH0SCI=
X-Developer-Key: i=aalbersh@kernel.org; a=openpgp;
 fpr=AE1B2A9562721A6FC4307C1F46A7EA18AC33E108

From: "Darrick J. Wong" <djwong@kernel.org>

Switch ext4 to use a per-sb fsverity workqueue instead of a systemwide
workqueue.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/ext4/super.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index c7d39da7e733..dcb9d1933c2e 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -5373,6 +5373,17 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 #endif
 #ifdef CONFIG_FS_VERITY
 	sb->s_vop = &ext4_verityops;
+	/*
+	 * Use a high-priority workqueue to prioritize verification work, which
+	 * blocks reads from completing, over regular application tasks.
+	 *
+	 * For performance reasons, don't use an unbound workqueue.  Using an
+	 * unbound workqueue for crypto operations causes excessive scheduler
+	 * latency on ARM64.
+	 */
+	err = fsverity_init_wq(sb, WQ_HIGHPRI, num_online_cpus());
+	if (err)
+		goto failed_mount3a;
 #endif
 #ifdef CONFIG_QUOTA
 	sb->dq_op = &ext4_quota_operations;

-- 
2.50.0


