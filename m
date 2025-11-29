Return-Path: <linux-fsdevel+bounces-70209-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2429BC93AEE
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Nov 2025 10:15:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8DDF34E2B47
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Nov 2025 09:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E07E426A0A7;
	Sat, 29 Nov 2025 09:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gTZRvdLq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3FB32741A6
	for <linux-fsdevel@vger.kernel.org>; Sat, 29 Nov 2025 09:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764407721; cv=none; b=Lw8x2iyxaEovjgkYATMbnitaL1P4ru2rgg9tkRRUYXTrY7zyCTEx1FGuggRSYoPhHrJanVKRB+6j6HLJAVVQL0X+lPjbOMuJpplPqfqjNL/2K7jDv4whxDKx5Eds/pyHIiMyqtx1uS6U47jJLPWEgWX9KXs9VHUvTwfKEcZ+HQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764407721; c=relaxed/simple;
	bh=1H3tSySb8RYZ9Xz952vACbtvWTupkLqx1w90JROwSJk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GCHc8zzoYa7SRlhzIFCt63OAeQt4Owi7ptI4Kyk3KwA4N6E7YWYGChAOG5u6MlJCsCFB49A+lJonNUqOwIIUdVt+rfeAbe4u0VB6g8EQhm8TZEidFSaDBa1TrNTq02Uo5NjnGDIBmHyI1TuNyU7KpJn/1zb9/7jIYPpJZkl724Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gTZRvdLq; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7aa9be9f03aso2254133b3a.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 29 Nov 2025 01:15:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764407719; x=1765012519; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RTLbYX7bNTCm4TW5N/uHN1/H0O/wwjH+DS42MIfV7UI=;
        b=gTZRvdLqFAb/4YHMcqeFdjmsrcmNzl0o75pRwHqejAnlAtjEBSfJ3rdcmE0KCoAMxz
         8aDfS28qehGIKRHuYCr+Q7HBiW6uRw4SaB4o+IGn7jh0DTlvLKWaE2UfjMhnaKzy8Mun
         5z3I4e4j9lk1e7lpLgHEKzGTP6NOXg+6Y6D4GIS1CFY5bzTXvbnITAxX6q3Grs/VMpWI
         kDJaW5B1yWNj9PTLfthJUcvgWKyhSqlSiaguH4zcsOZZCknt4wJo0p1boB5w12ainCgF
         riPiv0yOm+1gxtUeHLxYnocVqVtzWJV/Iv5vkicp94K6cP0Fs3gJQVKHsFLk8KwBDuPU
         3mCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764407719; x=1765012519;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RTLbYX7bNTCm4TW5N/uHN1/H0O/wwjH+DS42MIfV7UI=;
        b=axsAp3J1a9JOxF+3yHRX2O+LFh2BVNL8MSeZqJ2VfDWgNHFAPhGKU3hcfV/bIhi9Tc
         BYnrCzY24ZzH50HDN6KjTgq67iQ5ypFNpq7ygAcgKJmZhNe6rEhwqFMYKm9nugJOsIBy
         ROsUgpZ1Si3j03W8bKBPItDgampHrRzVIL2nW9lZj44VtoJ6WOHndYMMjOI8nDk65HXz
         gCkHJZ3g4ZVjSB0fiNJGwjd+Oew6sIcxVqbeRxA4VGkl/COIRbnsUZ6VUeWstXJlqXdQ
         ra//+BwmHi79nUBjF0XDwaXRpqD/Q/btqUt1BxpuYnfMaO/2ONALgv77dkioCCpKtrCC
         knvA==
X-Gm-Message-State: AOJu0YxOiI/TvcjAmmETp7EW3y0/FE7u0IF5Yc/1tkqW4V9Hk5+knh8M
	s9ue/QSrFY3CQax2GrNDe9iMU5PKD1Rgzl38jYwSiJPRucdVpyN7M3vL
X-Gm-Gg: ASbGncsvnXSohCyAsbcNH9/vdd2C3AmC6Q0buFicIJmjWvoAfy7VJrldKcwe+H29DZ5
	7nJFRQiySze53u2Xnxx0Nvv/ELoUDBJ/O2Be/A/5wObXbu19eO8+sLns6v/SI5IbjOBKQi713qy
	Q+s9VV8U9dsinnodlTWrJyOo9Uw17ltcb5VN2jYN1+SUbmPiufMstOMwbbFbFzKV6fFku2dqugs
	BnbExiuLjb58wXT70FquVIe7Yo07CY0Gkdd2t5RmB1EOY2gygvizURPi9Fx1R5YHF366gck8vl5
	gBxBaEamELfe0iRuPC7PxyXvn2XIx+Scsw1aUQoDfFZQKEJMp1X4VIS2c5gUmn+O7hb3yKUofz9
	nTlWhhGJrgzU8poUUYQgHGX0J7Lq146vd+V/425SibvL32T8hs0ffre3ecznay/Cn5bqdhGUk6E
	0ed8weEp0FPIg=
X-Google-Smtp-Source: AGHT+IFKJjzpV9EYUo0mUxqBF81hGWIOAODYyB9YBLMIQiF1odGWwtu4fNZsuEorPfh62DeARpYtCA==
X-Received: by 2002:a05:6a00:2293:b0:7ab:995a:46b0 with SMTP id d2e1a72fcca58-7c58e110869mr34201519b3a.15.1764407719096;
        Sat, 29 Nov 2025 01:15:19 -0800 (PST)
Received: from fedora ([2405:201:3017:184:2d1c:8c4c:2945:3f7c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7d15e7db416sm7300563b3a.41.2025.11.29.01.15.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Nov 2025 01:15:18 -0800 (PST)
From: Bhavik Sachdev <b.sachdev1904@gmail.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	criu@lists.linux.dev,
	Jan Kara <jack@suse.cz>,
	Jeff Layton <jlayton@kernel.org>,
	Aleksa Sarai <cyphar@cyphar.com>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Bhavik Sachdev <b.sachdev1904@gmail.com>,
	Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
	Andrei Vagin <avagin@gmail.com>,
	Alexander Mikhalitsyn <alexander@mihalicyn.com>,
	John Hubbard <jhubbard@nvidia.com>,
	Amir Goldstein <amir73il@gmail.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Andrew Donnellan <ajd@linux.ibm.com>
Subject: [PATCH v7 1/3] statmount: permission check should return EPERM
Date: Sat, 29 Nov 2025 14:41:20 +0530
Message-ID: <20251129091455.757724-2-b.sachdev1904@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251129091455.757724-1-b.sachdev1904@gmail.com>
References: <20251129091455.757724-1-b.sachdev1904@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, statmount() returns ENOENT when caller is not CAP_SYS_ADMIN
in the user namespace owner of target mount namespace. This should be
EPERM instead.

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
2.52.0


