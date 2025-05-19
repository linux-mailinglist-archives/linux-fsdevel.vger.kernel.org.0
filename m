Return-Path: <linux-fsdevel+bounces-49447-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 968DCABC70F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 20:20:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD8EC17CCEB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 18:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8023289354;
	Mon, 19 May 2025 18:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h5e95Wuq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCFC11EF0BE;
	Mon, 19 May 2025 18:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747678822; cv=none; b=SZx2G04Lidi7bZSRUEexe3IIPmP4WiX9kwrDr5MwhKEaNX6vknr8gwd2S4aGOsRUEeX7n9vSgBEds6S7BgEG8a9LsfmYtWVuukXqJ5vhk6acz1LUUMIWwP22ixmvY4rTiNY7bWHugHHbHt3aI6XkyaUowdaUCiPZ0CvcxPEtCHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747678822; c=relaxed/simple;
	bh=b5ji2K6f2Ku/TyTzuIesHXwafT9EHdlC9m2hxzuRLRk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S4VS+Ku5vh7a25KocUlmlEd14r8lRKQz8n6rbXlMNjfhOj+ucpxPiwTDDpiFrciNyqyDNu7W1xc+8GYfMIcbk+KUf+9l2KvbTUNy2UYD8wncN9e54UBA1f6OIPfmpQWeOWa09MeftQP66Zl6hSlaQxUTmli5sEi9yNiC7MkFRe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h5e95Wuq; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-af908bb32fdso3731569a12.1;
        Mon, 19 May 2025 11:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747678819; x=1748283619; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9/KyEuRSPiSuyMw5ngKFNJ+p7EpaLylEIwid+f+mH9k=;
        b=h5e95WuqqmGX6SyX5jtK3Kff7JVRRMZNFnO41RpsrEX9mCXN6JhA4HucvLYW92Gz9Z
         lkrKOSU5YXY0Hg2o/T2NuDrzbONW2u7+MxlmrTvP8q3UUQ5vyMTp4sUJkfB7Q8ja2DGH
         gokWtAUCkrpLE3KRwb/MTTJOxNBuefW1okH3/xfNF0HXttk3LsHtEh6rW9uVUkU0F4Ha
         q3CkIAufgXoKlnFfPTTTTFBhchtjEv0Futd4tbVc2zJCAEpz8cjKym7wrvjV970jMqij
         NK68rqyzvggdTFusiFr8gP1yMGMjPSW65KsW1ELv2pym+/lSeTUt5U1+liFrsOpN35gn
         keBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747678819; x=1748283619;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9/KyEuRSPiSuyMw5ngKFNJ+p7EpaLylEIwid+f+mH9k=;
        b=w19cSQOXcmv4mAdSy8udQBAOD24Sh0ani8OOktzrxfneBwiNo83pRZBtfpDT2GUpEG
         Fuu97H8O4RLFaTyQnyRubYLH6w0MeIDiQN1k53rQIdq4rcmno3UlgOwdv0EIBJmpixKD
         iH3PQJuZtPsmbD/0dMUDBA2E5M4T7U2n13vLOCMIxky7MIwseHLiRxWkD9ET0RGcWInc
         aSG4NbF/auvIR/Ej9Mb15E7nmq09ia6l/JOW2kWAZmw/B9H43SgQ9CQAPYIvsOj1EpYH
         IZTJ7E5tnH7Jrdn/9GrAWq8q7bM3ac6Ck1MXr75MKnCaiYMTgTgSg/9pBdy7IZwWFB2N
         I7cg==
X-Forwarded-Encrypted: i=1; AJvYcCVnK4dObffvLmh8f+6StGPrOWEa9ypp/VctaCJheU3yLjpR/nRAYDUim0eDY1yS+DyRCzU0ZGvGQxABq6fX@vger.kernel.org
X-Gm-Message-State: AOJu0YxM+278u3e7xBYnm5X6ALgHNljIgLAAtWyl2dVYhdLOPsDJXa7c
	xPakzd/tzYYaGu6m9mMZqFdTZ6KJkugu/vUPjsPIBsOUz/MHQ3AGRvLzn8pSpA==
X-Gm-Gg: ASbGncvWdpGjx1hA1PqWE5VgXVeNxZ5m1eCgOlRNrHpo7tYNayvk0cyojx4n2czX89X
	wWo0smNhALytu2ZskJO/O9/de0cfEj7MTFckebBwiIhev66bU1CmXLaRqFV89rZJaIMTRbaQ+f6
	Wxb9nd9qhqR+R3NGLcYKFqxRiyIuW/sQEhL3Pu4LIRGdjn0Amz+i8BFfPg6znqWMU09aB6q4uAP
	OBx5uSxjnFvJidor+xtsPH/9aW+FDyL0D0FCBW8ARKA274FuZYP6JBQ0KQJ1YorVxxnhQHLs8E4
	Gh5YqRMwdoSjjuhP+pol06ssAkuyojfwrBarCg7wEwvPFf0AH+rklgM/xrz7QR4Yn8I=
X-Google-Smtp-Source: AGHT+IEr+FtrGndei4LD0Uxf6Cpb/2rWq1yuzEPTDXMaJ6b6oJO5SfihSPpn8VPR7JxDP4BWiaygNg==
X-Received: by 2002:a17:902:d48d:b0:232:557c:2501 with SMTP id d9443c01a7336-232557c2657mr47801085ad.10.1747678819050;
        Mon, 19 May 2025 11:20:19 -0700 (PDT)
Received: from dw-tp.ibmuc.com ([171.76.82.96])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-231d4ed4ec3sm63156245ad.233.2025.05.19.11.20.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 11:20:18 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linux-ext4@vger.kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>,
	Jan Kara <jack@suse.cz>,
	John Garry <john.g.garry@oracle.com>,
	djwong@kernel.org,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>,
	linux-fsdevel@vger.kernel.org,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCH v1 5/5] ext4: Add a WARN_ON_ONCE for querying LAST_IN_LEAF instead
Date: Mon, 19 May 2025 23:49:30 +0530
Message-ID: <ee6e82a224c50b432df9ce1ce3333c50182d8473.1747677758.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1747677758.git.ritesh.list@gmail.com>
References: <cover.1747677758.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We added the documentation in ext4_map_blocks() for usage of
EXT4_GET_BLOCKS_QUERY_LAST_IN_LEAF flag. But It's better to add
a WARN_ON_ONCE in case if anyone tries using this flag with CREATE to
avoid a random issue later. Since depth can change with CREATE and it
needs to be re-calculated before using it in there.

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 fs/ext4/extents.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 7683558381dc..ea5158703d2d 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -4444,9 +4444,11 @@ int ext4_ext_map_blocks(handle_t *handle, struct inode *inode,
 	 * need to re-calculate the depth as it might have changed due to block
 	 * allocation.
 	 */
-	if (flags & EXT4_GET_BLOCKS_QUERY_LAST_IN_LEAF)
+	if (flags & EXT4_GET_BLOCKS_QUERY_LAST_IN_LEAF) {
+		WARN_ON_ONCE(flags & EXT4_GET_BLOCKS_CREATE);
 		if (!err && ex && (ex == EXT_LAST_EXTENT(path[depth].p_hdr)))
 			map->m_flags |= EXT4_MAP_QUERY_LAST_IN_LEAF;
+	}
 
 	ext4_free_ext_path(path);
 
-- 
2.49.0


