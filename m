Return-Path: <linux-fsdevel+bounces-71072-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BB2D0CB3B62
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Dec 2025 19:03:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 31A543078388
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Dec 2025 18:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CA4E32695F;
	Wed, 10 Dec 2025 18:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CJ3Uc0Ls";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="HmiB8hDi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2932F6162
	for <linux-fsdevel@vger.kernel.org>; Wed, 10 Dec 2025 18:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765389765; cv=none; b=nYU1HYyq1EuK0ktVg25DEyYWFC+qU4Gj6s+cKpUUjTyLVNBB9wbwHBg+ust68XBAxmyp/GDmbMBsL+abropoAOLrlmtfMqwJZBBXZBnNwQtEVNZ6jHhpUdbMPofZoSF7jPbmN7MkfmebJvr93tPWZ+aMr2Og8ujMs6vnJFbIfcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765389765; c=relaxed/simple;
	bh=J2k3sD39/Cgu/BZdlIoFeG0VEnWhXiSACEUcbH20cA0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dAwpDh5T82KCAsv79QeT3X2THKO+cE1dpJUes5deoS+9QGX7jXjWmzUxPGZwPUI2nvQUTDH/+N70JPQsclEKRd2G6oBsibTXwq4hU2vuqaOkLk8MgIoriqFL9zRA2BNVImy6FfuTqVNMazUOmh/MB69wiEIauTk3okNnkrL1gfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CJ3Uc0Ls; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=HmiB8hDi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765389762;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=wjYOhIExHQImzkTk3bef1GiAcWBOTiJC/ukUbFzqPjQ=;
	b=CJ3Uc0Ls3mWMVFbYtYLUYrVayxgfX0h9tf4HWENNfEL0vB90JF6VBxMitBFe0hwflpvYV4
	i4cLy7YzCDxZ39pOWHwfCUX3Q7itcYpMe0IAixe2poQ8/KU2EQrdt5JrL3TSL/T0HOi5bc
	iwpED4w0JP9QFtYP9vIkMZuN3lphEDU=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-134-MumAgsvINCW1iNweldWgIg-1; Wed, 10 Dec 2025 13:02:41 -0500
X-MC-Unique: MumAgsvINCW1iNweldWgIg-1
X-Mimecast-MFC-AGG-ID: MumAgsvINCW1iNweldWgIg_1765389760
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-34a8a7f90b6so149285a91.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Dec 2025 10:02:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1765389760; x=1765994560; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wjYOhIExHQImzkTk3bef1GiAcWBOTiJC/ukUbFzqPjQ=;
        b=HmiB8hDiAXyg+QG//CK+L+Kvhn2l3z1SlGXUGtFgUHMhuqNC7pqPaLT+RXWL7Enqa7
         Ucjk1bpmoEms3Gk5wLfj6X0YiH2d44HzWxmHLGgtJAahvX1Bfyo55TXTopVjjO1P1j4p
         UYNWBIznQlMNdWlUc/9I+7QbO6aYUhK5I3nehxzT7hMnLdlFRbOtwUPES/lbPG4dTrSD
         X4YJ3WSUm5lOCrqQXI2EwxUctkPEe2+C0BVxsFeD5/6vzMG4dIssrGFcjTet0OPaX9aj
         0D8kYLVNEGeaCXHLohkx6ME+g+ii3SMlJyvd3CezW/qjzCmzDtvwuxoHCGgWwnCqPtWv
         k22g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765389760; x=1765994560;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wjYOhIExHQImzkTk3bef1GiAcWBOTiJC/ukUbFzqPjQ=;
        b=ChlLG2XMc4xeIIvONOrpobng8cjQBpmzNAaT3O35qWHQFmmazuNVLVBCX1IlMd/aJc
         rO2JgpOTHniMWZie83c9KhErotT6g80G7A/R4KFpbtrnZWeyIGXTb/syRTfZ7LUyKAb6
         lErm6iz5r89HqnRlknnjYQILV/l0ZsjmiidggfYyFmMleO25Q4tDUB0+0YYgkAh7LMmr
         FDrfmK3cx0ob9BsLZcQuTDbzYZjXhsAETneJHWU86M7lD0vp4YNMBBflN2qydurwM5v+
         nRNcRxedPOgwRNKolgyDriXfsoKFJkyqyhzHJFcI65+9XaoSJar6vCKFmEPBEnfEVbAE
         Sk0w==
X-Forwarded-Encrypted: i=1; AJvYcCUTsp7JNhqFNXoXpi5OMAQrzVAXY+S0DldB9fLijkXSt9k1bDhyxMAsgLqHdAQiZvu87sr1D5MoMG6VBdHA@vger.kernel.org
X-Gm-Message-State: AOJu0Yym7ooItte0EVrv+QEyUeSAoS7C2u+oV9V3ABy7Nha9CgZZ0d5v
	Jroaa2YrPjqUo9hcvjusGpXN7D1YB33kcPzuh6GSaAwIE5KM9mDYO/qOQeX18njfBq0KWpnDGVe
	LayXUN8mL7Bi/15NwsM69R4PkH8DJLxb6i9e4t25MMS2FCI49TgYXHztu5OuevonDRQ==
X-Gm-Gg: ASbGnctGl/ioTlwbXpvl4QGNC1qBDUrUNfmKH+y3d8Q89Zg/VtbgODAZc6rTJGzaxOj
	191f1bUEyeK5ufqGlsjV2syv6SEm51kyn+41JWdas+trC0KbwNqtaor53vcUAL/nK0e7ZgwXn/M
	I4PUt+5jB3ZncOnIsTVTHgJqYPphqFvF8hpaLIPHld5cFALZ3ndjZigmLq2UROfGi80BLKgZN9/
	q6uXVGMjghweXOMGL4pIVs+0Qdim6Z4rDv+DEQz/WPQ8JAjZ9G+4VFJL7ubp5dtQoPSmfhqQNqW
	IPAty/O4RWaAgxe4IzuO+Mw2tv0aF0JuZbub4uwxpMdv7Qqmv4bwWE7hCE8IV75Tzx65+fj7968
	7LeZLtBTpaGJrmUUAZkGRhWZ2Mq+hwQd3aTyFrw==
X-Received: by 2002:a05:6300:210c:b0:366:1b59:6991 with SMTP id adf61e73a8af0-366e03d6b88mr3106913637.3.1765389760059;
        Wed, 10 Dec 2025 10:02:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGGla8HfyjFMsMqdu/X6ZXmW39DAlPFLVU8QMXXxfV/LWlpE1a+hOGiRXVb6F/ju1z7+bWKow==
X-Received: by 2002:a05:6300:210c:b0:366:1b59:6991 with SMTP id adf61e73a8af0-366e03d6b88mr3106864637.3.1765389759395;
        Wed, 10 Dec 2025 10:02:39 -0800 (PST)
Received: from dkarn-thinkpadp16vgen1.punetw6.csb ([2402:e280:3e0d:a45:3861:8b7f:6ae1:6229])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c0c2bfa0845sm128206a12.28.2025.12.10.10.02.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Dec 2025 10:02:38 -0800 (PST)
From: Deepakkumar Karn <dkarn@redhat.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Deepakkumar Karn <dkarn@redhat.com>
Subject: [PATCH] fs/buffer: add alert in try_to_free_buffers() for folios without buffers
Date: Wed, 10 Dec 2025 23:32:28 +0530
Message-ID: <20251210180228.211655-1-dkarn@redhat.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

try_to_free_buffers() can be called on folios with no buffers attached
when filemap_release_folio() is invoked on a folio belonging to a mapping
with AS_RELEASE_ALWAYS set but no release_folio operation defined.

In such cases, folio_needs_release() returns true because of the
AS_RELEASE_ALWAYS flag, but the folio has no private buffer data. This
causes try_to_free_buffers() to call drop_buffers() on a folio with no
buffers, leading to a null pointer dereference.

Adding a check in try_to_free_buffers() to return early if the folio has no
buffers attached, with WARN_ON_ONCE() to alert about the misconfiguration.
This provides defensive hardening.

Signed-off-by: Deepakkumar Karn <dkarn@redhat.com>
---
 fs/buffer.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/buffer.c b/fs/buffer.c
index 838c0c571022..b229baa77055 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -2948,6 +2948,10 @@ bool try_to_free_buffers(struct folio *folio)
 	if (folio_test_writeback(folio))
 		return false;
 
+	/* Misconfigured folio check */
+	if (WARN_ON_ONCE(!folio_buffers(folio)))
+		return false;
+
 	if (mapping == NULL) {		/* can this still happen? */
 		ret = drop_buffers(folio, &buffers_to_free);
 		goto out;
-- 
2.52.0


