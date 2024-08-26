Return-Path: <linux-fsdevel+bounces-27123-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8938995EC6C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 10:54:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAFE11C21636
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 08:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33D2D13D8B8;
	Mon, 26 Aug 2024 08:53:59 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E10918027;
	Mon, 26 Aug 2024 08:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724662438; cv=none; b=IW9EFmca9eI8q82Kb/WrBXL/T/2xWDl0pSJ7nJ0EDjnjUqxWzKg5uFpSmeA9wWHufZUNVK0CxeRYhluASG5wSeQVLVjE9/8sAhBmZTo/du7WCWmnqI/KkMErdBV2jFr2Z220sldeYNUOj9qKz8uoTlKLYQNVk4cVlyFnoSCslxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724662438; c=relaxed/simple;
	bh=38PYgfBDOgmNZ6SWVY3f4zWpCuTfdX6HwO52RgcsoAc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QR0wyKZtOhnpP4LVUjsJ3dOIz7cd/00ZjBKnrcfP5zfIQbijyizRPj1WpKSVfrRKp4c9YZRcCxhxHjJs4fHiIk8MKxWB2R1rV7ZmOLApBEWidNHlryS3jn1XvEp3c/YUBkXX0MNclPxo4qEzINlmY5lodbnFoh5SA7ckJUh9VYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5bed83488b3so4712765a12.0;
        Mon, 26 Aug 2024 01:53:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724662436; x=1725267236;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OoJCp3I2BA9KRjpRd6U32PSSLO6IqLbkxDMlM0I2ct8=;
        b=WuhS1JunozL4UP2sGVriKvJsHoIAHUbaDaRIGGRAt5gfJp1aIwzQe6Gm3/TH8wrQv/
         kHLLDGWz95sAs+wFWlH4rTCOcFkqjaTeAW8AgxtzYd30QwT8kS9Dyho1ky5yBUcBCNhI
         ajBoSI6ERij/48nTQxb2Dsk7A11cH3E+WPPqGR+QO6/mCpmF2zbP8Ak8v2DH2Y93iVI+
         cTXVcxUHqlfEmXdqrIWzimAiOT3UOBZqH5SlYjX3F3cYXpZ/geVc+XFOBVTNnfnsiVR/
         Olj2DXeCvmMa+CRtz3cKo2La6MzB3UjyxqzLpPNHsrVlllUPO/XLyVDICrPDZHEHDgyr
         L2iA==
X-Forwarded-Encrypted: i=1; AJvYcCUujoWp2p5BJjB7p+GI7gkDlwWcYcJXNuDci8YFA9niaKdvDbQ8GT84IpMn4jsllltcWj3lFEPbwdcCTWxQiw==@vger.kernel.org, AJvYcCVDCtuRPKjlJHqesxWyRSiyKLr/0f++DE13o5hfjxi8K9pvW7fMYO1U3q9C9F6kUVA4VQu4HXUp5Mz8l0jj@vger.kernel.org, AJvYcCWw13IxGUw76BF3yl0zSwWzz4eN0o/eV8+MNCqP1EnfJRlWEAMuyFd7OuUN0eMb8Ckex7p3XlywgXmFfP1o204GFsJ8EHWD@vger.kernel.org, AJvYcCXlJoAanGWTnd02cVpjNfYWj8SqxTNmvgUZJ5/zhcoWMonu9rC87Gf/E0BLipAu+FddY02+tZaw0RlvV213JA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzlxhQVQEVXaJbkHVKGCPNPlNAHRzymFQREOtaOZgFwP0kEmGOE
	RhaVLKHjMwLM6vSKpvXhWRJX9xKpotEgYA24f5lLIW2a1MBX46Gq
X-Google-Smtp-Source: AGHT+IEGem3Ufu8tZwQeokdMzmP3eaFZqmvIML5mh8Xq54tW+A+yVSA/vBHoHsP+JHd+JsIfra7TMw==
X-Received: by 2002:a17:907:31cb:b0:a86:b00a:7a27 with SMTP id a640c23a62f3a-a86b00a7cfbmr511137966b.60.1724662434947;
        Mon, 26 Aug 2024 01:53:54 -0700 (PDT)
Received: from localhost.localdomain ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a868f21fe18sm630636866b.29.2024.08.26.01.53.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 01:53:54 -0700 (PDT)
From: Michal Hocko <mhocko@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Christoph Hellwig <hch@lst.de>,
	Yafang Shao <laoar.shao@gmail.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	jack@suse.cz,
	Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-bcachefs@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] get rid of PF_MEMALLOC_NORECLAIM
Date: Mon, 26 Aug 2024 10:47:11 +0200
Message-ID: <20240826085347.1152675-1-mhocko@kernel.org>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

https://lore.kernel.org/all/20240812090525.80299-1-laoar.shao@gmail.com/T/#u
attempted to build on top of PF_MEMALLOC_NORECLAIM introduced by 
eab0af905bfc ("mm: introduce PF_MEMALLOC_NORECLAIM,
PF_MEMALLOC_NOWARN"). This flag has been merged even though there was an
explicit push back from the MM people - https://lore.kernel.org/all/ZcM0xtlKbAOFjv5n@tiehlicka/

These two patches are dropping the flag and use an explicit GFP_NOWAIT
allocation context in the bcache inode allocation code. This required to
push gfp mask down to inode_init_always and its LSM hooks. I am not really
familiar with this code so please give it a thorough review.


