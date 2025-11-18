Return-Path: <linux-fsdevel+bounces-68920-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 470ACC68462
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 09:49:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3460E4E2901
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 08:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 394B22C21FA;
	Tue, 18 Nov 2025 08:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N0dVckqG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B142EDD4D
	for <linux-fsdevel@vger.kernel.org>; Tue, 18 Nov 2025 08:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763455742; cv=none; b=Sre1SN5pw987+fSbvJcNaLpuEqRhYxbwa3399BZ0ySrhL0b+evhHSClc+UVeowFAyTL295QBCa3iksSiTUjcZjvTR3lxnDirUbTJkn3TuNsCeMThzjC1U8tXVek+jLLuFmpeHTqvgre5dPqVZg2RTdsrClEpSlICspHbbAN81FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763455742; c=relaxed/simple;
	bh=RuTyOcTIQsIa1VQF+wrIemSx1Hn8e8BwIKHEiQA93sc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HHzZjimFeqYZuj4Rj40alZu99NMCXnGvdrFgPbWoOTiGtA25KjQFIHO/odWM/GKYEFDD1YIILx2CpkenEgqOi85erGhG+H6RRSE9bFfgxgkeUZvpM3k91Qoa6b8TdkJ7ui5rJJomVXA0/yzdt4PVN1/x9SBSerKZpuHn6aekAUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N0dVckqG; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-343774bd9b4so4836064a91.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Nov 2025 00:49:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763455740; x=1764060540; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vp0MpNZH1XSmnkdi/mlOHPVzzuRzZWUK9O/KMKN+QwY=;
        b=N0dVckqGlw0GL37+tAN7TF9F4J3CDoyUYi8q3zi0QYddyhu7Og9G/xvhGhAHEmmkI/
         xKX/qf/1oNI1WjELrF4q7i1udQQojyXoOTCwfgC6VDa2bPTQ97fz9t+N2pNQsvd0nW0M
         SAO3p42fv/Cv6PKZ7TvS5Xr/GbWlVd/B2rjlX7f1eAnnvZ657aJp71LM5YtCELDdjXGY
         0VS7RIk4WXjR8RRMI7FRiCoNBHq7On+tYDYpqZpax4DWP5Rr1wRiIQPkDaAJsu6zzd49
         rNJntq+yYY23LWc2k5cTh2h5fm8Ns475bN1SlA5i3Tl6IsPvieqTPUJ0I0ClmcWoMhiF
         qpNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763455740; x=1764060540;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vp0MpNZH1XSmnkdi/mlOHPVzzuRzZWUK9O/KMKN+QwY=;
        b=EfN7+mkMMQ/K6rFFEYxKgBsCuJWQKQ1BZh88CcZtt9NxPAu85GmnKUFQbVV1d6HAJj
         XcUPQfs03wnMepTR4wg/Fe/tujFcJ11i2WKTEbNo15GG/FB05So9Jh24SHVqeXWPmKaK
         UgBDG7YnyyP292wEuPk6XhQdVda+IBCuMqPl9cT/k2VZkItyBQeIg2AHtmkzBa75zk5j
         1VJKzyGERZuAqgQkHvmnrebws60l72OpAeRR7K2b93pDg84wJAD8B7Msxw5wNdNlzYeF
         P72KeqtqVD1ePY0YyXNBeMfCtBYyAO9pC0YSjnwSToagaqqg1fxji4PYi5GEUO11UCPz
         Cx9A==
X-Gm-Message-State: AOJu0YwrozIihZpMvA/ODgtoXBAZPa3K71x97vTx1XKoztQ2sx6NgwIC
	86j47x9cBc9/JqQrYnds5ony1sZZ4/fmmip6ogOkVbe/XQW4HIiOiuHn
X-Gm-Gg: ASbGncu1u8SQWyVQ5aY41LVvNUsIkWy+v9jZwxRnUOV1622ELidZYX3tvvAlQnwM+wZ
	wHIGy5e5Z459KArQ5Hp6NYy/mBk6pNQt3vwGqlRvlG/QVAjaDIPdBgQppSNfxbYQvJU5Kg4K3IL
	yL1I908dYFLQM8pQVDh27DhnRIbbsQYFADKRLtO1vCEgSgM23h8AyhUnJju1aVj22+SHD+FY6GV
	vpBZjOMF7bIjotSKkWBlxloXH2RiygtmEMcdycOT9Mw3Jp92KYkofXGHU04o+r4iHEEoGNB7Lsd
	gnPUzyYVwWzrCNs9qh1r9FcIRvYd4GXCwiJIzgAsfG1mnpEGVb1dmmRUlGd2kjbGnqi334Csqi6
	6Ebf0RH89Xqn5SWFl8mFfiJIVb/QkTcCrQFZO5/B7wFizArLQqTPHsbLQW6QKHsuJGqMmfPLqFl
	2P
X-Google-Smtp-Source: AGHT+IG+GRClDMkEK2hjiVfmJtVo3DrOWbGJbOp09mNb0w4tfFqhDJXjtqwFu7hlYuGncAjBckJb8A==
X-Received: by 2002:a17:90b:2d85:b0:340:bc27:97b8 with SMTP id 98e67ed59e1d1-343f9e9fed3mr17027369a91.10.1763455740049;
        Tue, 18 Nov 2025 00:49:00 -0800 (PST)
Received: from fedora ([2405:201:3017:184:2d1c:8c4c:2945:3f7c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-345b01d934csm964041a91.1.2025.11.18.00.48.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 00:48:59 -0800 (PST)
From: Bhavik Sachdev <b.sachdev1904@gmail.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	criu@lists.linux.dev,
	Aleksa Sarai <cyphar@cyphar.com>,
	Bhavik Sachdev <b.sachdev1904@gmail.com>,
	Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
	Jan Kara <jack@suse.cz>,
	John Garry <john.g.garry@oracle.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Andrei Vagin <avagin@gmail.com>,
	Alexander Mikhalitsyn <alexander@mihalicyn.com>,
	Miklos Szeredi <miklos@szeredi.hu>
Subject: [PATCH v6 1/2] statmount: permission check should return EPERM
Date: Tue, 18 Nov 2025 14:16:41 +0530
Message-ID: <20251118084836.2114503-2-b.sachdev1904@gmail.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251118084836.2114503-1-b.sachdev1904@gmail.com>
References: <20251118084836.2114503-1-b.sachdev1904@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, statmount() returns ENOENT when caller is not CAP_SYS_ADMIN
in the current user namespace. This should be EPERM instead.

Suggested-by: Miklos Szeredi <miklos@szeredi.hu>
Signed-off-by: Bhavik Sachdev <b.sachdev1904@gmail.com>
---
 fs/namespace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 2bad25709b2c..ee36d67f1ac2 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -5795,7 +5795,7 @@ SYSCALL_DEFINE4(statmount, const struct mnt_id_req __user *, req,
 
 	if (kreq.mnt_ns_id && (ns != current->nsproxy->mnt_ns) &&
 	    !ns_capable_noaudit(ns->user_ns, CAP_SYS_ADMIN))
-		return -ENOENT;
+		return -EPERM;
 
 	ks = kmalloc(sizeof(*ks), GFP_KERNEL_ACCOUNT);
 	if (!ks)
-- 
2.51.1


