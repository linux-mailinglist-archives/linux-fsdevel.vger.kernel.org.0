Return-Path: <linux-fsdevel+bounces-32590-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D5E49AB2D7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Oct 2024 17:56:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED7BD1F2476A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Oct 2024 15:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9E1B1A2653;
	Tue, 22 Oct 2024 15:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZaYOGnh1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99AE01A2C11
	for <linux-fsdevel@vger.kernel.org>; Tue, 22 Oct 2024 15:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729612521; cv=none; b=jNiI5+hG4x3lV1xImtSW/lals+voSOsfx19r3PwHMWUksGPnEj4M2gmbv79aND+PR1wD+VPdmPZNCv9th9Co1R83ZBIvfEn1tcOYfEuFn+TDBEKFVfNsqsgbzg6eiK64DtaBTUQltMXnEwbIS88jBD+iLvMTd/yD+GHwMng3Ewg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729612521; c=relaxed/simple;
	bh=kTLw0hgo0+cYh6r64B8i7yfL8r0MnFxeYn7YWEkly9s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KimK+BRoTHVafB67l4J5S2CtVwazBtSuwenYqxEsQUm/XRBZQcwc38SoZ/ZX4ZjN7f+SZ+ss5QSfMBKAcG0iXnDfClGEeqgTt78ytTLsCsH8wCH82q6KD9ULzWCrclNBSaLU+OgC5TYIeey0PQ88UDCHmyGmkN+sIC4ff5k8Q+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZaYOGnh1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729612518;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=pwGtQvC81dqyNm43NxPVg8sA977EphKdArcGHIL+8OA=;
	b=ZaYOGnh1re1ElmqroFP8K/ifaJwZm1EuuCo1vu4Mf7usG29HNSNgMg6Yr5CYkfaz8dQS1p
	HZDWHDNYJTfbGLj2m2rYeD+xAeH4e5cOdAuENwWoENXurTt3Is3/mzmKxBtUkUMaB2xIyv
	HVqU31yKaImxx6tNeFmTfCQIJE9lEOA=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-6gPUfxhZPGqBAiYOUvCkmQ-1; Tue, 22 Oct 2024 11:55:17 -0400
X-MC-Unique: 6gPUfxhZPGqBAiYOUvCkmQ-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-5c9217064f6so3612416a12.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Oct 2024 08:55:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729612516; x=1730217316;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pwGtQvC81dqyNm43NxPVg8sA977EphKdArcGHIL+8OA=;
        b=D7FsPll33s4MdRSUiGuLTC2MKb7i3nTSCuxciBlrJieaH+spwqh9+CBdwI5jy/0Bvo
         AFkspDiHEQ66CXzUQYdveN6fyG9lro/5aLCDeLwyJXgSersTT4obVuOHGE7FRbn3AZ1q
         R4v7uw3hEHPiclgjuu8p2oWyqb9ECApEvVowrmxa/JSuQR4l6BgkXlxCxCOXMbdvHHct
         nt2Ti+aoPAZkuXiXDBe+p3U9uM7DkIvORM+Gpny2DvO4+Ow1+4CmM1nJbum1ZN77bQzd
         X5si22JTerdBZbr1+QBMmtDn6zd/fAdtacLMRN/iWKqCGard5gg7+Es22M2unBzl0aUj
         52EQ==
X-Forwarded-Encrypted: i=1; AJvYcCXSc09GRN6ePSYZxIeqKBfXNZrZ+rRmsfjLKSVCVsOLCflJmC8FwTLJgnCIuvhW9CIwyeg3UiTYReNHYHzP@vger.kernel.org
X-Gm-Message-State: AOJu0YxPDu9OIx2a/4BBFzhEySJZb+02MFSiaPEDyEzwngy8BQUO16i6
	WJ0J5quOLZbVGyqEf/NwnZfWkzkTfF1giIU/cPMu2FC3sksKn3YxV81hVjXE0/JMT5W/wO7NdCv
	+kcGcw47xuDRJtiRf/IjRjQNYVEPIj139M4syiheskuj1dSqomv/b1i9WnqiJuCY=
X-Received: by 2002:a17:907:7288:b0:a99:ee4e:266d with SMTP id a640c23a62f3a-a9a69a64da4mr1801248066b.1.1729612515768;
        Tue, 22 Oct 2024 08:55:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF3Lw2/iGPDt/n8MXRHhBIMVt7QiFCu/xfqjC+U2bDsH1SV9s/KOPtnqIsHxljqjuQNr374UQ==
X-Received: by 2002:a17:907:7288:b0:a99:ee4e:266d with SMTP id a640c23a62f3a-a9a69a64da4mr1801245766b.1.1729612515362;
        Tue, 22 Oct 2024 08:55:15 -0700 (PDT)
Received: from maszat.piliscsaba.szeredi.hu (193-226-214-118.pool.digikabel.hu. [193.226.214.118])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a912d5fcesm358874066b.26.2024.10.22.08.55.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 08:55:14 -0700 (PDT)
From: Miklos Szeredi <mszeredi@redhat.com>
To: linux-unionfs@vger.kernel.org
Cc: Amir Goldstein <amir73il@gmail.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH] ovl: clarify dget/dput in ovl_cleanup()
Date: Tue, 22 Oct 2024 17:55:11 +0200
Message-ID: <20241022155513.303860-1-mszeredi@redhat.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a comment explaining the reason for the seemingly pointless extra
reference.

Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/overlayfs/dir.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index ab65e98a1def..9e97f7dffd90 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -28,6 +28,10 @@ int ovl_cleanup(struct ovl_fs *ofs, struct inode *wdir, struct dentry *wdentry)
 {
 	int err;
 
+	/*
+	 * Cached negative upper dentries are generally not useful, so grab a
+	 * ref to the victim to keep it from turning negative.
+	 */
 	dget(wdentry);
 	if (d_is_dir(wdentry))
 		err = ovl_do_rmdir(ofs, wdir, wdentry);
-- 
2.47.0


