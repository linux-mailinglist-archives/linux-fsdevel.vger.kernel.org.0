Return-Path: <linux-fsdevel+bounces-44941-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCF11A6EE20
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Mar 2025 11:46:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB9F21891E3B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Mar 2025 10:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B4371EF0B4;
	Tue, 25 Mar 2025 10:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hDcJombd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32BF91EFF83
	for <linux-fsdevel@vger.kernel.org>; Tue, 25 Mar 2025 10:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742899604; cv=none; b=BirPeSUe/oAZ8wF8w/+JW3agq+yKOpc4aOTn0DnLl/cudRxV2mjEu10LCpKbvYyU8Cz6FKy1KAWiwwC1tLJplhh0rce3FTUggMAZmLiViw9CJ2eVjySkCipdJJ9uxTKnn7qqGTbRjBPaviyIH0tuj8/TtkPelxEn8y7G1ikNGdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742899604; c=relaxed/simple;
	bh=A2MAB2OVxVruIya4DNf3xEcT8dkPUjuHu37dCQmkK/I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a9q9Q1hZRbezP0BI6KLZ2PgysRcsPSRgcXjkKUlRqUD8BOx+qdtOHrxpeoZZuxxzxb1SlN8q8UWrhDR9SlORdbrVha3b6snv2H/USsb/ELaMrvUIG9qxdfurf8MLnvCVlkL4rbV+0OZ3zn0j04yqWJvjo7uPWU1V70BKkohLLsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hDcJombd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742899601;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SmfiCZHWD0A3bKyst7i0VZyUuheFYdh0T7DksOUWd2k=;
	b=hDcJombdP50+89/PPJ4ksO3e/Dbj2qrgCdadCZgT2W1T6TnD4tvBOVIQWOfLBvjP65ozI3
	nnCxjABCgeBs/qPjQCaifpoM7SmPOtagWqV4Y75diA+Y7eO7h1eHDg4ijYXdhspKV+Pq8E
	cmvF3Sct/y3yEe970iL4HkRxrt+HmsU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-142-rO1S0YeeOwuqChYGK91WBg-1; Tue, 25 Mar 2025 06:46:39 -0400
X-MC-Unique: rO1S0YeeOwuqChYGK91WBg-1
X-Mimecast-MFC-AGG-ID: rO1S0YeeOwuqChYGK91WBg_1742899599
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3978ef9a284so2081142f8f.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Mar 2025 03:46:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742899598; x=1743504398;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SmfiCZHWD0A3bKyst7i0VZyUuheFYdh0T7DksOUWd2k=;
        b=OFx5p2ze6QUQAc1CNoaRqYNEPGb3dR1Dq2dtlwe6wiwk/MHA1AGiuUyb73gxQsCOT7
         fXIazEzPGZWh8Oia03Rw8cigTFJnF5CNShloNvybaycT1oz3YllnEr0CCGNk0tKOxIDg
         SFzGE2Va/GfRDG7u7+TWA2terwdn/0CUi1eFyP5OwvlQI0sVp8zzt/iC3rNxs/XnOi6V
         zsgLhrJP4WI+Qoksujr3DDOtRcdfR0Hvh5h5pMHMBCSScQ9nL3dbneox/+HOR9huUAIf
         UO65G+zR3OEWGe3koY60gris/DAHfmaGv8yU/B0EowitpPPT71YzZEBFo5zlBSltpy25
         R9iQ==
X-Forwarded-Encrypted: i=1; AJvYcCWrcuB8LIY3F/SwEzSAc4VXBix001ygQAtQ3o5wN/vsF1VIzfxzQbrjpp9maTIcGghCKrOzAGgTxbFYZlMy@vger.kernel.org
X-Gm-Message-State: AOJu0YzSH2gBxGqTuWUhPVwkpd+VXVzeu6v1Hn/RMdq2/VKQB5ZYOMwW
	opkz8rHaMvbnPP780Qcttht5AzLNgCT7jjqzDm0rFd16RLN2ZpffcJe9HN6ntIX03JZnfAAL2FV
	H82AHV5ucW9yGJM+niGdyvUwLgBcrB/Xm0JbPD2W3VKlEJnoLgOBreBSvnIyCLd0=
X-Gm-Gg: ASbGnctfTInxUXvd0ZtMvMD8WDx9Hq4TIsnF5Zty8zlQ2TnACvGVDKxzMdI84/jwRAr
	Yw/nRmfcoCqPf/mnxPc8CVOcjC3O5TgCLBqbo6Rv3LoM1SRrajkc9rzQsaFJp6GG9o6/d3vy82i
	fivWN9Z71ZUmOvPtOWXZUS03y4tgLGSGeVFn1nRcK9uGelqLFF+D6HhhbqTFhMW5inKct8kGdCT
	d+bMJewUtp0LBXC8SI0vI+MMTQQN0vhagoSOlbNBfRtWUSFrOI6sC3Q7mFPYfwB/8+pAKJEaebL
	5s5fIDfzXTbKlkfCKBCxJuoweD7UYoDo/MOZ0vtFJrbmzDxIzMXSXeJ6YLAu3zZsi4Q=
X-Received: by 2002:a05:6000:1faf:b0:391:2f2f:836 with SMTP id ffacd0b85a97d-3997f8fa7f6mr13206186f8f.17.1742899598581;
        Tue, 25 Mar 2025 03:46:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGIEw0CctFzZmufeUGJGyZuFijGYL4BzledWUp12aifF3ZxDHZPmWLvGl/HUY9yjW5VnNO+Rw==
X-Received: by 2002:a05:6000:1faf:b0:391:2f2f:836 with SMTP id ffacd0b85a97d-3997f8fa7f6mr13206161f8f.17.1742899598259;
        Tue, 25 Mar 2025 03:46:38 -0700 (PDT)
Received: from maszat.piliscsaba.szeredi.hu (87-97-53-119.pool.digikabel.hu. [87.97.53.119])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9a50c1sm13572203f8f.38.2025.03.25.03.46.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 03:46:37 -0700 (PDT)
From: Miklos Szeredi <mszeredi@redhat.com>
To: linux-unionfs@vger.kernel.org
Cc: Giuseppe Scrivano <gscrivan@redhat.com>,
	Amir Goldstein <amir73il@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	Alexander Larsson <alexl@redhat.com>
Subject: [PATCH v2 2/5] ovl: remove unused forward declaration
Date: Tue, 25 Mar 2025 11:46:30 +0100
Message-ID: <20250325104634.162496-3-mszeredi@redhat.com>
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

From: Giuseppe Scrivano <gscrivan@redhat.com>

The ovl_get_verity_xattr() function was never added, only its declaration.

Signed-off-by: Giuseppe Scrivano <gscrivan@redhat.com>
Fixes: 184996e92e86 ("ovl: Validate verity xattr when resolving lowerdata")
Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/overlayfs/overlayfs.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index 0021e2025020..be86d2ed71d6 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -540,8 +540,6 @@ int ovl_set_metacopy_xattr(struct ovl_fs *ofs, struct dentry *d,
 bool ovl_is_metacopy_dentry(struct dentry *dentry);
 char *ovl_get_redirect_xattr(struct ovl_fs *ofs, const struct path *path, int padding);
 int ovl_ensure_verity_loaded(struct path *path);
-int ovl_get_verity_xattr(struct ovl_fs *ofs, const struct path *path,
-			 u8 *digest_buf, int *buf_length);
 int ovl_validate_verity(struct ovl_fs *ofs,
 			struct path *metapath,
 			struct path *datapath);
-- 
2.49.0


