Return-Path: <linux-fsdevel+bounces-7474-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7BE8825679
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jan 2024 16:21:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE41D1C2286C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jan 2024 15:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F8D22E637;
	Fri,  5 Jan 2024 15:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="KpoAMKzf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43CF02E635
	for <linux-fsdevel@vger.kernel.org>; Fri,  5 Jan 2024 15:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 576F13F2C4
	for <linux-fsdevel@vger.kernel.org>; Fri,  5 Jan 2024 15:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1704468104;
	bh=K/MKIQt/2v5+gO4lOQWcPlqIQOmPYkzjUgvkJ8cDKMk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
	b=KpoAMKzfm++1hSyUEjyp0Vr1n9yGe5PckIWSUUuKNM0IZLf4BLJFaZ/ea5TC+Be9w
	 ggZVtaugD96vDu0F/7rYHDStsntQw0pWesCMpQFY5a55WfhdmkRoeriEqKYmaCq58K
	 /ag1HDC9ewSv1TIU5XIx9tvAG0jdCwYxvyHe2p12jC5sY1O+FQjyt4h/tmkEL9lYDu
	 0/FRrH8uz58WrdPsIfeL+Iyy3YTu8O6meq7dSEu4gnMZsOvt22df6dWFdk2q7JKwap
	 5rnt2fNu1pd9Dw/D2rGR+QBAWpa7TEI7qw4cIJ4anAKRKvMheK3XYQQYYH4tHUsoxn
	 o04sH6qlub5fw==
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a28fbc49006so74108366b.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 05 Jan 2024 07:21:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704468103; x=1705072903;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K/MKIQt/2v5+gO4lOQWcPlqIQOmPYkzjUgvkJ8cDKMk=;
        b=so4ADsCRVdpeQv9bVO0snsmVVfpay8PDA9wIObYOA/4c/YZbfbwAbUttfxBNp7bjF2
         l3PMBaa7XTme7p135DfkXdzoYdb3RmCXkqZFPUcTyatwyfpvQYpXpWBqPM9lmxhKSGlk
         ID7cMPaJFVNsJSksyVokd6bKj6QhHlwyInhL4dXIYqcm2qFhtKdkZ4DtXCNEIMb7jtSK
         t65ENXB31PCSZewtMXqh85nq1tXW3P+zNO5B26qyV28pl9qXYlUraSeoK4VImJiQIm+7
         7A4nPjQA+TRHbGxKW4R8SaGseAq4usNNmop2QSp6CfSI2ChGkBnBSOJ3uO8M0lj7Gidj
         lduw==
X-Gm-Message-State: AOJu0Yx6FLkIuThodPgeg29isiGsbyU2mL5Ml9ECRLDPUHcrC1zLQqV4
	x3ygPhDYUp1yA88zTfp6dex/QX9sHzaP4k9iitrHmbW12Q17nCG9jcTTTG+Ga9zbFQnlygA9mm8
	lzR+GdG+/Ed5lLrv02EQ/yjMUC5IoMM8jCTPl0KLUd6oN5biykydVGCBkSw==
X-Received: by 2002:a17:907:7204:b0:a26:8c4d:b0b6 with SMTP id dr4-20020a170907720400b00a268c4db0b6mr2791606ejc.9.1704468103802;
        Fri, 05 Jan 2024 07:21:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGq3s8L43EPolrGptmL+SMamfp1oYJHC4hBjDWLEEuxQ8xChVbi+Equ4y7DZ/VoXFslj4GXcQ==
X-Received: by 2002:a17:907:7204:b0:a26:8c4d:b0b6 with SMTP id dr4-20020a170907720400b00a268c4db0b6mr2791596ejc.9.1704468103553;
        Fri, 05 Jan 2024 07:21:43 -0800 (PST)
Received: from amikhalitsyn.lan ([91.64.72.41])
        by smtp.gmail.com with ESMTPSA id i23-20020a170906115700b00a298adde5a1sm345630eja.189.2024.01.05.07.21.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jan 2024 07:21:43 -0800 (PST)
From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To: mszeredi@redhat.com
Cc: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
	Miklos Szeredi <miklos@szeredi.hu>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/3] fuse: a few small fixes
Date: Fri,  5 Jan 2024 16:21:26 +0100
Message-Id: <20240105152129.196824-1-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Found by chance while working on support for idmapped mounts in fuse
(will send series soon :-)).

Cc: Miklos Szeredi <miklos@szeredi.hu>
Cc: <linux-fsdevel@vger.kernel.org>
Cc: <linux-kernel@vger.kernel.org>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>

Alexander Mikhalitsyn (3):
  fuse: fix typo for fuse_permission comment
  fuse: use GFP_KERNEL_ACCOUNT for allocations in fuse_dev_alloc
  fuse: __kuid_val/__kgid_val helpers in fuse_fill_attr_from_inode()

 fs/fuse/dir.c   | 2 +-
 fs/fuse/inode.c | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

-- 
2.34.1


