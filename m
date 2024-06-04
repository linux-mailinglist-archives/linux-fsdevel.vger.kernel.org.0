Return-Path: <linux-fsdevel+bounces-20949-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 599148FB3AF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 15:25:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 128B22888FE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 13:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE61C1474BC;
	Tue,  4 Jun 2024 13:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PQmvHyiH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E003146D6C;
	Tue,  4 Jun 2024 13:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717507500; cv=none; b=OT2WhREduLAMKsqXp+UXIqSRZcWy4621nBXPeDZGYxX+tZ8s5wA3uUtNXahIRIc38MV175y0UOFcU/kdGDpWFfFRiBw0G9HWn72S0tXitiZ5Rmni+PJGJPirMC3BbXt2OpfvHd+cUY81QU2Dc2B3MUIUNXRRZBJwOy6sj0PGITs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717507500; c=relaxed/simple;
	bh=T2/osWnXAD1uSlPCmzL6dpoWNczcQU25jIG3QiXttIE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qwW2a1+55aU+qfYuOqL4PcTgbQ5CnfdETZ9PzpZrh6e238noToWH5jv/HhuPJRU6VP0ROxQleTIF6+1++E3sdv3LDDiwUZhCrLKqarb3mBncB3TYdKfRdMEdwM7FzqjHMxR7BDal8l+kNTJOVRSpsUZa2KfJnNxudxYXZmOtfo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PQmvHyiH; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-52b962c4bb6so3881914e87.3;
        Tue, 04 Jun 2024 06:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717507497; x=1718112297; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wWD819RSY+sbW9pqUSEBujkwCj1Ln6oQgmPrO7AFSQw=;
        b=PQmvHyiHBjTdEPyXDulPXwodykdvgCiy+B6sLdXjE5SEp6VBZ5BL6ZH2hHDhBbWAI0
         yuq56nNiNuve9w/P0zo0pXN2XHc4CBQ8GBJmohkkG13SJQHf3+mbRR9mrXxM7rA6Ijlx
         p94M38fmKG0KZBVNNdLYtpXdle3VjIdl42W3CyAPlDavTO0zte0nAkxeDQ93VPJPUh3M
         jCl+I7sMq5pULJne+PFXdZ1JJuJRNB54vo7J9XcoeWDQs2R+siOQV8G5XSqOh9Fvugrr
         vpaiUWNMLrchHuJvP7hqOf2kS2hfrYux9vDdyR7R4M0CcZNGMdEjTAbiZECTkGHntPzy
         9nHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717507497; x=1718112297;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wWD819RSY+sbW9pqUSEBujkwCj1Ln6oQgmPrO7AFSQw=;
        b=WfqDvfyqw0W56QB9OqBDyj1bNpr/7pRKL8q0uB6MyeEsu4vuYi2KPlyP1N7qnHZ3xT
         +Yf/9SNBkkQcj7OwnFqvk8jWd0eFEbrJShf3BAPs9eU+BD88OTKyVqISnfNsPBeEyuaG
         jeJguM6DYEwYxs2YimOWqlA6R/1X5GhaB9wd9JAVYmvlauWxoNMCGf3rkbG7M/a7X5uN
         aRUe/sszyzMgTsmY89IRjsZzvyYJO66e83ETit1X/Z82dg06/CjY+MMMUiY17zfnTbzD
         z62zGwODh66ykbe40hAtThXH3+ZPuWwFEYEoMYc4fk2KO3v+ANoVT3QYuoS6ex0VBTyI
         +SAw==
X-Forwarded-Encrypted: i=1; AJvYcCUn1nEzgRf7UF+Olfbm3rs//53q0Hc50/QeGfMKhVyW64ZVLjZUl8GjXbM19ePTmFERUIwhFTJ9oWyLvTm4zK8kmtCUMUO+ntgVa4hIMngGI9eJj48YpNYwom6ZfznNsvy4hOPO2Y0024m2JQ==
X-Gm-Message-State: AOJu0YwVdDb5iU6s7tyh16Gc3b4eYCFLNQCd0nK98XM1qFqYIM8rlGXC
	mC7+TAqGwrSNl5Hgb/NZDTI2b7a568cqo0+ZBj1QP4ZJlWxAi+Zs
X-Google-Smtp-Source: AGHT+IHNppZsJwGPfYxOUJaQlSsf4Cct7ii7XOXuvfwsag/ICoBlSB6PvcaH7M289MnkWNKHc+DuKw==
X-Received: by 2002:a19:7501:0:b0:52a:7d01:84cd with SMTP id 2adb3069b0e04-52b89563555mr9988883e87.30.1717507496448;
        Tue, 04 Jun 2024 06:24:56 -0700 (PDT)
Received: from f.. (cst-prg-8-232.cust.vodafone.cz. [46.135.8.232])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a68cdc32bd9sm437225966b.142.2024.06.04.06.24.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 06:24:55 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	axboe@kernel.dk,
	daclash@linux.microsoft.com,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [HACK PATCH] fs: dodge atomic in putname if ref == 1
Date: Tue,  4 Jun 2024 15:24:48 +0200
Message-ID: <20240604132448.101183-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The struct used to be refcounted with regular inc/dec ops, atomic usage
showed up in commit 03adc61edad4 ("audit,io_uring: io_uring openat
triggers audit reference count underflow").

If putname spots a count of 1 there is no legitimate way of anyone to
bump it and these modifications are low traffic (names are not heavily)
shared, thus one can do a load first and if the value of 1 is found the
atomic can be elided -- this is the last reference..

When performing a failed open this reduces putname on the profile from
~1.60% to ~0.2% and bumps the syscall rate by just shy of 1% (the
discrepancy is due to now bigger stalls elsewhere).

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---

This is a lazy hack.

The race is only possible with io_uring which has a dedicated entry
point, thus a getname variant which takes it into account could store
the need to use atomics as a flag in struct filename. To that end
getname could take a boolean indicating this, fronted with some inlines
and the current entry point renamed to __getname_flags to hide it.

Option B is to add a routine which "upgrades" to atomics after getname
returns, but that's a littly fishy vs audit_reusename.

At the end of the day all spots which modify the ref could branch on the
atomics flag.

I opted to not do it since the hack below undoes the problem for me.

I'm not going to fight for this hack though, it is merely a placeholder
until someone(tm) fixes things.

If the hack is considered a no-go and the appraoch described above is
considered fine, I can submit a patch some time this month to sort it
out, provided someone tells me how to name a routine which grabs a ref
-- the op is currently opencoded and "getname" allocates instead of
merely refing. would "refname" do it?

 fs/namei.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 37fb0a8aa09a..f9440bdb21d0 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -260,11 +260,13 @@ void putname(struct filename *name)
 	if (IS_ERR(name))
 		return;
 
-	if (WARN_ON_ONCE(!atomic_read(&name->refcnt)))
-		return;
+	if (unlikely(atomic_read(&name->refcnt) != 1)) {
+		if (WARN_ON_ONCE(!atomic_read(&name->refcnt)))
+			return;
 
-	if (!atomic_dec_and_test(&name->refcnt))
-		return;
+		if (!atomic_dec_and_test(&name->refcnt))
+			return;
+	}
 
 	if (name->name != name->iname) {
 		__putname(name->name);
-- 
2.39.2


