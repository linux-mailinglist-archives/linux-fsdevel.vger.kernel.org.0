Return-Path: <linux-fsdevel+bounces-27125-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66AFB95EC72
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 10:54:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 960161C21672
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 08:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C86A218027;
	Mon, 26 Aug 2024 08:54:00 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3ED282D7F;
	Mon, 26 Aug 2024 08:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724662440; cv=none; b=Y7B+4Q3MsET7XPCg0XwSviCKbjReVWCNmaHmbjOddS2CmCa1sM0tmcZIRq19TMAG9lpwdebGPlY2Nu2x2jj/RbSe5Tt9Xgf0+r910wmzLQhgR6agxjnDDfLq66Q+9i5XHiOMXN3e2x+u/YBYdQTMdLHqPWEtxHe8SWQaRppPFm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724662440; c=relaxed/simple;
	bh=GuuW1WL+3o/YlrQrEDV2HHdlgrpjkOAllVC8EiRa6m0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=avLa3gnM9QNwVWzDSUOXuyVCud5houlk7QRQTA14PBXqGd/5KcGEAqKX67sC4DaO+w1XdvrUFwz8ta+6y98vsEciaI9dWu2KJtgOYPLVRfRIWrRKWUopXg/28u2XE+kSURYvSzA6QMv6Fd16mPLVdzmk8ALBeOBqhssosx7Wv2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5bebd3b7c22so8145687a12.0;
        Mon, 26 Aug 2024 01:53:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724662437; x=1725267237;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E4kEvuNqKI0xTjj6I4wqTHJS1sNMpYcp7Dr6Uq95pto=;
        b=IdCikk2emG+PWI0q1jcm03OzfrlnwITsbXVZ31CTCm7eIyRpeNqwlRX9EPW81867/i
         gS9153ZCKwgO6hfrXeetkgogGjMQoD5eoX7U+Fck2b1gj0I5ufVv7hLk/8muomOrRviu
         QVYY5hkoXkvq3MroKLxc8+A7oHpVhBBTMcJHTy11hbD9ipbL0p2V89NiHGHo8ObDIQ+u
         zUUqBzTmjviZjcQZfXVeqPuM/lF3nhOJjNVlC6pvfK+Gce+QGUpiTC1jAx8FvZqAOpD4
         tfQas+QNg2NLx37pfR08uYUbhxMce0UBDVZt9WCp2LRyvcNJS0KaFl3EbSqmIYIear7m
         weLg==
X-Forwarded-Encrypted: i=1; AJvYcCUIdyYbSANelapFh4QTlyg5Yzw6NGJPCroZL3QnloTxmRz7zr4w1OE9WeZTXcTj4ZVFUpmRKPCdfkFtdCym8Q==@vger.kernel.org, AJvYcCV9rsLteeQsiW0l5Y/ZPM7a7qg0IC71rht42Xeuv2J9+Utlk8TIdHv4U09dv4tDMRyj45F+G7/DkQSsj6AE@vger.kernel.org, AJvYcCX74Ar/o8KcMLn5Ryc4wgS0Py9KWrHCc2KTYQFwRZJat/5YSnQYcuDT0mAiASG3/I6eAW4nH5rlyI9X1NNBlEDzxmqcE1TO@vger.kernel.org, AJvYcCXCKN393U5jKXaOf5mR5ZK7CY8bzcOMvyDto1XY3XVg6Lv19nRs6ZkSuFQUVTUF4ZefXlP+uD105E7m+tF7ug==@vger.kernel.org
X-Gm-Message-State: AOJu0YxhZ92FqSF8Vvl64R/BsxOglZMGu6adMamb73PTPXvKwInGgeR3
	t4bk8i6Yr6tdNVPsZePyyE2FNwlndAfpzzAV+e95f8vzPx8gsIpL
X-Google-Smtp-Source: AGHT+IF1fJpfy3mPNIRs30Wnajmd99gCu+0+b/DeTT6aTwMVnETwc04A+X+3AnJTgxAHcIGYmfyZ+g==
X-Received: by 2002:a17:907:1c8e:b0:a75:7a8:d70c with SMTP id a640c23a62f3a-a86a2f14394mr1133364766b.4.1724662436552;
        Mon, 26 Aug 2024 01:53:56 -0700 (PDT)
Received: from localhost.localdomain ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a868f21fe18sm630636866b.29.2024.08.26.01.53.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 01:53:56 -0700 (PDT)
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
	linux-kernel@vger.kernel.org,
	Michal Hocko <mhocko@suse.com>
Subject: [PATCH 2/2] mm: drop PF_MEMALLOC_NORECLAIM
Date: Mon, 26 Aug 2024 10:47:13 +0200
Message-ID: <20240826085347.1152675-3-mhocko@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240826085347.1152675-1-mhocko@kernel.org>
References: <20240826085347.1152675-1-mhocko@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michal Hocko <mhocko@suse.com>

There is no existing user of the flag and the flag is dangerous because
a nested allocation context can use GFP_NOFAIL which could cause
unexpected failure. Such a code would be hard to maintain because it
could be deeper in the call chain.

PF_MEMALLOC_NORECLAIM has been added even when it was pointed out [1]
that such a allocation contex is inherently unsafe if the context
doesn't fully control all allocations called from this context.

[1] https://lore.kernel.org/all/ZcM0xtlKbAOFjv5n@tiehlicka/

Signed-off-by: Michal Hocko <mhocko@suse.com>
---
 include/linux/sched.h    | 1 -
 include/linux/sched/mm.h | 7 ++-----
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index f8d150343d42..72dad3a6317a 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1657,7 +1657,6 @@ extern struct pid *cad_pid;
 						 * I am cleaning dirty pages from some other bdi. */
 #define PF_KTHREAD		0x00200000	/* I am a kernel thread */
 #define PF_RANDOMIZE		0x00400000	/* Randomize virtual address space */
-#define PF_MEMALLOC_NORECLAIM	0x00800000	/* All allocation requests will clear __GFP_DIRECT_RECLAIM */
 #define PF_MEMALLOC_NOWARN	0x01000000	/* All allocation requests will inherit __GFP_NOWARN */
 #define PF__HOLE__02000000	0x02000000
 #define PF_NO_SETAFFINITY	0x04000000	/* Userland is not allowed to meddle with cpus_mask */
diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
index 91546493c43d..c49f2b24acb9 100644
--- a/include/linux/sched/mm.h
+++ b/include/linux/sched/mm.h
@@ -260,16 +260,13 @@ static inline gfp_t current_gfp_context(gfp_t flags)
 
 	if (unlikely(pflags & (PF_MEMALLOC_NOIO |
 			       PF_MEMALLOC_NOFS |
-			       PF_MEMALLOC_NORECLAIM |
 			       PF_MEMALLOC_NOWARN |
 			       PF_MEMALLOC_PIN))) {
 		/*
 		 * Stronger flags before weaker flags:
-		 * NORECLAIM implies NOIO, which in turn implies NOFS
+		 * NOIO implies NOFS
 		 */
-		if (pflags & PF_MEMALLOC_NORECLAIM)
-			flags &= ~__GFP_DIRECT_RECLAIM;
-		else if (pflags & PF_MEMALLOC_NOIO)
+		if (pflags & PF_MEMALLOC_NOIO)
 			flags &= ~(__GFP_IO | __GFP_FS);
 		else if (pflags & PF_MEMALLOC_NOFS)
 			flags &= ~__GFP_FS;
-- 
2.46.0


