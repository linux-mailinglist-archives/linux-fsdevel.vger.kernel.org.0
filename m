Return-Path: <linux-fsdevel+bounces-44940-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7681A6EE1D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Mar 2025 11:46:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9BE5189116C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Mar 2025 10:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FAF41C5D50;
	Tue, 25 Mar 2025 10:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CoNvGv3j"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139F719ABA3
	for <linux-fsdevel@vger.kernel.org>; Tue, 25 Mar 2025 10:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742899601; cv=none; b=c0CsPxP0xoUEay1Y6j0sHCYkAqEQcFfTlPfkPf1uO83en98+TDEN2Oh/LIB9nb5CGeYXo7QlYUvI7VTV4IdietCwyrdpF2ocZf760tRYDr5YsIAn+j14Zrie8EuJz/AF281/IWXMhn214wydgdpBPak3TAGFWRR/tcJhSZD8XC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742899601; c=relaxed/simple;
	bh=zS3iedtb9CGE+6AikF6XtcfJb/KtdMt4kbhmDjh5djU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z5md9kq8GlQcWcQIZuH+MCa5rgS75NVMNin5wVNbToijzBvMaDOAwzX8V2Alzald3t1KbSdmbz6zwZuOkXLGrRZx3ce1wzB2M5fC3E8jBB+diWCpbPZu5GCa5beP3YJ+lA7+LODeVvKw5MArGTnm9JGQZ2wJL8t2I8ERhHnwvA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CoNvGv3j; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742899598;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=llfCjfXs/RkEx1xDFKie+QOsYGNOm/qxwhosEg+VjwI=;
	b=CoNvGv3j0q8+l4h7nwZMzQmVMB8v/RenQ5PkDd4zkmpPN5HTmEbQ49j/8lnwl9BaLfJ/w8
	3WYbuaW7RX8idcwd5DXVll7PFsNG3dpHRQgx7np5H33s+zO1nHL20Sm56o7mGGirbF75Fr
	6q7nV6q+6cUcjfmVST3jqa6e3jzq1a4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-529-kjQhjRN2NiGzkeLerxZ1MQ-1; Tue, 25 Mar 2025 06:46:37 -0400
X-MC-Unique: kjQhjRN2NiGzkeLerxZ1MQ-1
X-Mimecast-MFC-AGG-ID: kjQhjRN2NiGzkeLerxZ1MQ_1742899596
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3913d8d7c3eso2820677f8f.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Mar 2025 03:46:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742899596; x=1743504396;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=llfCjfXs/RkEx1xDFKie+QOsYGNOm/qxwhosEg+VjwI=;
        b=uYrc0RabtqrThnEE8R4fWiMPr3yY/dPNbNsJK+ARqETGBbIrkXKt3kA87h5ZJ19Kfh
         F/d3PVzRHN7Jvx8T2hLgrV89JVEDn6ocyHwUcdezDCXmjfdFLeum8hvNrhwHz0enEZK4
         pupCgwRxOyAH2zlkHcmTLe9YqJ/asG9BMnzkKKqA1MkD8KfRxYeI+kNMHZ4sLdIqiJ9D
         Us2ora/lsX7KwI96Krz88XQi8DHdt/cA/wDKc5/o5Oni7TP6mBFCOKEUFhQqXhoZoxl/
         +wVsepNgaiA7nKjePRZWXaMyu0iGMeYSOr3MM3e4MlQTdGVWW5GTfC65dmNt0As2hsxE
         87JQ==
X-Forwarded-Encrypted: i=1; AJvYcCVg3Nhhf+IkyKk04zAJNw79EROGHsIdrdCJhZ3H74ItbV5CL6iwtRijm6awDwkQsx5fhyHgIIkgZ7W9WI7a@vger.kernel.org
X-Gm-Message-State: AOJu0YxpuFaZkK/Rc9kxNSEQnsy5/k/OrhPw5Kni9G2wApmZKRBbWkdj
	IvebxdvJBgBtKO+upWhe4MzZ94zpnCC+QXIlLs7yaBZpn5rUsmqZo8nzIyBh1GpNzGVNx+KIq3y
	oQExKIrM8ycoHLP5bPrV7nRBW4NnVAa9kkV5SRD7TEGN2UTvgNHH4LXTVdqMqdsI=
X-Gm-Gg: ASbGnctmsCCm77nnl7MmmQJJdx8yKJoi2IQxxWPzgIv+/foZOEOC3gQUO4uGYwytZgN
	qdiV2PfHjSSi+7+XAHN0fu/98hxRHOfpp5aJn4O6lxwIUIYbT5O8r9i+E28E/Vhjq7XaGJAQIKi
	pWuCYz75htZA1RxNdPJVc7BI/eKkpwUXr5g4fsgDNAXy6zdzgWYW+QZl7blnINDKqcO5MRbtRnm
	xvnVfjY09LKzH1kS5x90O3o4y4mNirt8qvuH9RAP9flB94RCN+/u5+XM6zyy0KkTB/MY8kljcZR
	Rc/T7GYOaHhC9bIf+ftiutS9GXExc0uT4V3owgOA4ICnLZ5JiCtVqjMxnXRx2cS9++E=
X-Received: by 2002:a5d:47a5:0:b0:390:f699:8c27 with SMTP id ffacd0b85a97d-3997f902e3dmr14212174f8f.12.1742899596171;
        Tue, 25 Mar 2025 03:46:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGbPImIP/lo9XeKEIz0Dxt34DSlVTLHymW8RqoW4OZVQLvzK6BjYDTV2S9svurxcLkem4p2mQ==
X-Received: by 2002:a5d:47a5:0:b0:390:f699:8c27 with SMTP id ffacd0b85a97d-3997f902e3dmr14212151f8f.12.1742899595810;
        Tue, 25 Mar 2025 03:46:35 -0700 (PDT)
Received: from maszat.piliscsaba.szeredi.hu (87-97-53-119.pool.digikabel.hu. [87.97.53.119])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9a50c1sm13572203f8f.38.2025.03.25.03.46.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 03:46:35 -0700 (PDT)
From: Miklos Szeredi <mszeredi@redhat.com>
To: linux-unionfs@vger.kernel.org
Cc: Amir Goldstein <amir73il@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	Giuseppe Scrivano <gscrivan@redhat.com>,
	Alexander Larsson <alexl@redhat.com>
Subject: [PATCH v2 0/5] ovl: metacopy/verity fixes and improvements
Date: Tue, 25 Mar 2025 11:46:28 +0100
Message-ID: <20250325104634.162496-1-mszeredi@redhat.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The main purpose of this patchset is allowing metadata/data-only layers to
be usable in user namespaces (without super user privs).

v2:
	- drop broken hunk in param.c (Amir)
	- patch header improvements (Amir)

---
Giuseppe Scrivano (1):
  ovl: remove unused forward declaration

Miklos Szeredi (4):
  ovl: don't allow datadir only
  ovl: make redirect/metacopy rejection consistent
  ovl: relax redirect/metacopy requirements for lower -> data redirect
  ovl: don't require "metacopy=on" for "verity"

 Documentation/filesystems/overlayfs.rst |  7 +++
 fs/overlayfs/namei.c                    | 77 ++++++++++++++++---------
 fs/overlayfs/overlayfs.h                |  2 -
 fs/overlayfs/params.c                   | 16 +----
 fs/overlayfs/super.c                    |  5 ++
 5 files changed, 66 insertions(+), 41 deletions(-)

-- 
2.49.0


