Return-Path: <linux-fsdevel+bounces-59991-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C03EB40744
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Sep 2025 16:44:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 874113BCC6B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Sep 2025 14:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A921131282C;
	Tue,  2 Sep 2025 14:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gDna7JXN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715C930EF64
	for <linux-fsdevel@vger.kernel.org>; Tue,  2 Sep 2025 14:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756824116; cv=none; b=OWynNFQ21JuFjZHItSOFmcJzkXNMMOkWWJ2qzr/w8wjAzgDQ+5P/yUpkhVeParqV55hD4eMKSzT6xA5rr+nEN4Wz3LGAgxEbJUYnl9uxbhjXvKvVhrU8iHmXIyVz9lkJpgLZDSRE467HALbflKjQmnGWpYpH9d72MEo5cVYjW+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756824116; c=relaxed/simple;
	bh=msg0NorC9rofgPWWRCL61q+PA5CfGeup9VpG1kvBNNQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ViOcQGr0DZSaD1ERcQuFa0c9zPRm2Rtuq4lBm4yNW1TPBiTa9WYXk1yaj9jBAXMNXslNwgZu+qCrAKGEmua6y8qC35DgRPcJccnv72XmcABvBlTu7iMXiDOPZHHFGRB6JroUkp2WMBu4zLy7M+n33Ci1l2+jHdq/9jeopeUTCeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gDna7JXN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756824113;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=cUMxp73B6Ahs4ZgXxkyKn+wP4py8NIDii8C/gN6r3Ak=;
	b=gDna7JXNbckKewVkX3741Y6FGtMxfb+WhY0eYAASrNV7JZdz5mkZvHZe4imXrP+UQ0TzqG
	mbs14fACk3pfqQcLaL5/kfU0b41rnbR5T07IeNku5PVy7Fc0HPzk5zSnCdSFMn3D9f86l0
	nsYBoJeCxSh/sN5oxtcchIXD9sRFF0s=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-375-WnXrHYexPveeXf4WNcqFIA-1; Tue, 02 Sep 2025 10:41:51 -0400
X-MC-Unique: WnXrHYexPveeXf4WNcqFIA-1
X-Mimecast-MFC-AGG-ID: WnXrHYexPveeXf4WNcqFIA_1756824110
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-61d0976931aso5195117a12.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 Sep 2025 07:41:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756824110; x=1757428910;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cUMxp73B6Ahs4ZgXxkyKn+wP4py8NIDii8C/gN6r3Ak=;
        b=tVl0UR0MRvskZXLVT/z/02IwZEQavdB11qKuvd4mbEpofgV45MfuKMB/yjQNcS+YbK
         r3C4ZNweiuREit9jzPpVW65eLwxE5xwq2Jkq2/vuneLr78OnIsQRbylMuAdNz3htun0H
         ZpFlPaGyH98ydTvw2uNzn/3SbNGInEICyYh0xPGRZMuq6HKakgvvHFq3Rccd8in6qBMB
         u2MN9JA+Zfaw1MMqNpJDpBQ0KRNCsgHsT8etZagDXZF9fq82BJj2TtFLaVNwUfTirbvs
         Xvtd8buqsgkjNtLIcz8gvdKR6XO6wabOzA9reib3QoK7yjhek3XjW2Yl2d+gi9Uqzqzt
         hmTw==
X-Gm-Message-State: AOJu0YxI8M9cf/IQn86HA5PLUOlOzAqJoy8dXfTmwbGQXhHpzagNX9Us
	3T1BCEI/MVp49H+5hAyVcpMOkMxZpSsuVjzCf1DPnLgZnoiAnegeEpoz0N3fO3yoOzX3opENOc6
	nsSDjAElISQGaheFHloevB0TICSywl5mUG0e8d3uk1vpawlGhQpZ+SN5W9oh7yfrTMwkuJOhRCZ
	fW3W9T9danVPyGPFA+gTXR5AOGKhPLsEqQ22VReXDONfhy7jDEU8LG8A==
X-Gm-Gg: ASbGncvQDKg3qz+WSdZKOMhQHii7xeNfnYoRVq3Xvvg1MQNHn+kXyvNhvFL4S9Uvena
	T9L8dEHsChHokpZIEGfD6gU4ekwcQZvnqvtfB+famnWtSIWchlyhl3jdTipvvYSj9kiylKWvPjZ
	uP6AcRpiWFbGR894n4JDzUBwXJZNrERWI+qulsJXVC0PWY5s1wKfRqWaAQu0cQLEz9X+wFfh1S8
	lZ/wfUm1knvG0GfD9TK+H6bvNWFNRVgX9i+V/J1zUN5arU0mL/yUaAvxj3VvX4HFimEOpYQnTNW
	BwkTseT4G1sY+MzFRSFkKa4XN7fd3pwamuYuzcvKlaiouDuBAEkZaRWo5EPWqbTHTHHQZOJH1Ft
	qXNaOCd7od+iz4ZC0NFZdlD0=
X-Received: by 2002:a05:6402:1941:b0:61c:e977:b6e1 with SMTP id 4fb4d7f45d1cf-61d26ac4167mr10665134a12.7.1756824110159;
        Tue, 02 Sep 2025 07:41:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFhQ8URViXRDF5V0jZLKsyqsLg249r0LQpsUXXxq2hLXVO8hNw/V2/w6GwRPYbx13FM6wUpZw==
X-Received: by 2002:a05:6402:1941:b0:61c:e977:b6e1 with SMTP id 4fb4d7f45d1cf-61d26ac4167mr10665099a12.7.1756824109648;
        Tue, 02 Sep 2025 07:41:49 -0700 (PDT)
Received: from maszat.piliscsaba.szeredi.hu (188-142-155-210.pool.digikabel.hu. [188.142.155.210])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61cfc1c77f9sm9704514a12.8.2025.09.02.07.41.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 07:41:49 -0700 (PDT)
From: Miklos Szeredi <mszeredi@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: Jim Harris <jiharris@nvidia.com>
Subject: [PATCH 1/4] fuse: remove FUSE_NOTIFY_CODE_MAX from <uapi/linux/fuse.h>
Date: Tue,  2 Sep 2025 16:41:43 +0200
Message-ID: <20250902144148.716383-1-mszeredi@redhat.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Constants that change value from version to version have no place in an
interface definition.

Hopefully this won't break anything.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 include/uapi/linux/fuse.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index 6b9fb8b08768..30bf0846547f 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -680,7 +680,6 @@ enum fuse_notify_code {
 	FUSE_NOTIFY_DELETE = 6,
 	FUSE_NOTIFY_RESEND = 7,
 	FUSE_NOTIFY_INC_EPOCH = 8,
-	FUSE_NOTIFY_CODE_MAX,
 };
 
 /* The read buffer is required to be at least 8k, but may be much larger */
-- 
2.49.0


