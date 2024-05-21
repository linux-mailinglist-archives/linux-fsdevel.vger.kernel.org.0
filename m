Return-Path: <linux-fsdevel+bounces-19923-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C9438CB32D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 May 2024 19:59:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AE2D1F2262D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 May 2024 17:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3D3E1494C2;
	Tue, 21 May 2024 17:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fDPzEdJG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1D6149015;
	Tue, 21 May 2024 17:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716314357; cv=none; b=e8+8YuCXjaTOTUucgOvmsU4G1Clx4VCMkqRRcyi5t0A8HPp8FiQyZFbVg3y+JWc/NmSCgu0NFl1wqZx73JpiY/NsacL2ItpOBdxMzsKLLkDpT6UcRNRBu9bivRcht8nOqztUQUiSZTUKJM4qzedhvrrPO8W2By7SrpCeRCRNATM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716314357; c=relaxed/simple;
	bh=pF5hHy19sUckxhcdMkEFs5kvEYZ//ekSfwCm69AGbd8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QCXmVROmaCnzayYIKNHJ/IDtt+WZXDyNLEMMV9VMVHUDsbQCJ8FUe4uyOmhtGrYEovnd4702g3NVYB5WZQgtZfBJS5SUUccHQ45NKJgmEY156gJrJgaEv5Q7KupSyGRfJjBbAIBIQPwJRnDjDbq1YUXY7ryPuMfIy0UfpPcDMmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fDPzEdJG; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1ecddf96313so94011325ad.2;
        Tue, 21 May 2024 10:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716314355; x=1716919155; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XI4mdMYQHMDzDk9xWjXkWCPqz9rl1k4l8GTTN28ztKU=;
        b=fDPzEdJGcl1Fz/kN3HfWEEnx2idgTNqCtf/oyANLXEZ2E0dwiZeD+LOI6YXcxmNH6F
         TDazD1T3afBWh30KLXROF7f/WEal+MolYq5UrvbHQDgoTOPRds/X/hrYDdYB+0u3Hkz4
         YNzgaqySRGffuOBS6aESxl8ICdytzBtyrpxkPJ2GnExiFXVPi+BtVKREz5aOnc17NhJM
         xl+5e08S6JofsYUNZ03UmXTIymgk4NUfYtuaRg5uPkxF6lLY5O7YFlgW9acSt5jyfKxh
         rAOAb0Ccby4tyO7L/7BhQ1k4aZZ8UEOnMlOgKjZtlPfFDsl4Q97/bAKcifBwx5gO8hrn
         FOKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716314355; x=1716919155;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XI4mdMYQHMDzDk9xWjXkWCPqz9rl1k4l8GTTN28ztKU=;
        b=nLxP+cx6+e+GTRynXC6lWmixWQHJKol6kKeUjb0Xt1kkhRYQbsOa7+I4kbBNNq9bbl
         UWAE8TUL0+zCx6lUEoKyEnvU1ALlw+MAqTjJSAEIdTf8m/sQ1/GdM+QRF5WcbJPU+G7w
         RDY5QPncs0SUO35mrKOCgtqy5NZvB40AZAqTXpSLUfrgEQZy5t583IZmikVfikDo9/GE
         tusem8J22buhmvmVr286hUAkd7Lad7ycbV+/1092e8nDncNTl4idrurRWpLI01zN1Ayl
         0613zkPVtAv2KdRytjFVWqWu672lCjMvbI0xgqdfOB77qNbQbj803OOpYheqTgeNqxy3
         Q32A==
X-Forwarded-Encrypted: i=1; AJvYcCW7oyNOnXJcQdaAHd+uDzs07Xyw60xKPFKJDgQH2TjwiJnfjuLclw++hNdE1K1YPMU8eekEoI4RErFvIZ2YI0u2FHFeeB5+7jIRdOWAA1iW9dZUniPae2TpNMjOH751ZCjBHA9zIi38IotLdG/n+7u8ok/tIVVHS8ewp9iwYllWC0YUUnjF92g=
X-Gm-Message-State: AOJu0YwswMk0AkMFUhrImb4zSQB7tmfHGRRe4m6stqrIEyJxHD2pGm+R
	/dOw/UAnjQ3944ETU0X5wWpH9LtRW2WTXULKFVixGJu0sUe1aFuh
X-Google-Smtp-Source: AGHT+IHhaw8cihGDeGD+zUXeJgbKIcB5gsMYz1cB7sCZetbMXuUWE1Yeub/1vlqxEDZ7M5X2P6lZ2Q==
X-Received: by 2002:a17:902:7845:b0:1e2:a807:7159 with SMTP id d9443c01a7336-1ef43c09602mr364682635ad.6.1716314355180;
        Tue, 21 May 2024 10:59:15 -0700 (PDT)
Received: from localhost.localdomain ([101.32.222.185])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f2fcdf87besm44646935ad.105.2024.05.21.10.59.10
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 21 May 2024 10:59:14 -0700 (PDT)
From: Kairui Song <ryncsn@gmail.com>
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	"Huang, Ying" <ying.huang@intel.com>,
	Matthew Wilcox <willy@infradead.org>,
	Chris Li <chrisl@kernel.org>,
	Barry Song <v-songbaohua@oppo.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Neil Brown <neilb@suse.de>,
	Minchan Kim <minchan@kernel.org>,
	David Hildenbrand <david@redhat.com>,
	Hugh Dickins <hughd@google.com>,
	Yosry Ahmed <yosryahmed@google.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kairui Song <kasong@tencent.com>,
	Xiubo Li <xiubli@redhat.com>,
	Ilya Dryomov <idryomov@gmail.com>,
	Jeff Layton <jlayton@kernel.org>,
	ceph-devel@vger.kernel.org
Subject: [PATCH v6 03/11] ceph: drop usage of page_index
Date: Wed, 22 May 2024 01:58:45 +0800
Message-ID: <20240521175854.96038-4-ryncsn@gmail.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240521175854.96038-1-ryncsn@gmail.com>
References: <20240521175854.96038-1-ryncsn@gmail.com>
Reply-To: Kairui Song <kasong@tencent.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kairui Song <kasong@tencent.com>

page_index is needed for mixed usage of page cache and swap cache,
for pure page cache usage, the caller can just use page->index instead.

It can't be a swap cache page here, so just drop it.

Signed-off-by: Kairui Song <kasong@tencent.com>
Cc: Xiubo Li <xiubli@redhat.com>
Cc: Ilya Dryomov <idryomov@gmail.com>
Cc: Jeff Layton <jlayton@kernel.org>
Cc: ceph-devel@vger.kernel.org
---
 fs/ceph/dir.c   | 2 +-
 fs/ceph/inode.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index 0e9f56eaba1e..570a9d634cc5 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -141,7 +141,7 @@ __dcache_find_get_entry(struct dentry *parent, u64 idx,
 	if (ptr_pos >= i_size_read(dir))
 		return NULL;
 
-	if (!cache_ctl->page || ptr_pgoff != page_index(cache_ctl->page)) {
+	if (!cache_ctl->page || ptr_pgoff != cache_ctl->page->index) {
 		ceph_readdir_cache_release(cache_ctl);
 		cache_ctl->page = find_lock_page(&dir->i_data, ptr_pgoff);
 		if (!cache_ctl->page) {
diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index 99561fddcb38..a69570ea2c19 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -1863,7 +1863,7 @@ static int fill_readdir_cache(struct inode *dir, struct dentry *dn,
 	unsigned idx = ctl->index % nsize;
 	pgoff_t pgoff = ctl->index / nsize;
 
-	if (!ctl->page || pgoff != page_index(ctl->page)) {
+	if (!ctl->page || pgoff != ctl->page->index) {
 		ceph_readdir_cache_release(ctl);
 		if (idx == 0)
 			ctl->page = grab_cache_page(&dir->i_data, pgoff);
-- 
2.45.0


