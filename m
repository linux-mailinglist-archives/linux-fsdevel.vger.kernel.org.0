Return-Path: <linux-fsdevel+bounces-35315-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 297D39D3966
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2024 12:22:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E342E284881
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2024 11:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA1C31A7265;
	Wed, 20 Nov 2024 11:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OuxapYRL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B32951A265D;
	Wed, 20 Nov 2024 11:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732101659; cv=none; b=AaPmTkVpV8kdRxZc29AUirzxKtqAg7T0zesnSppoIFpOPUvcCfbngniGLWqq0O3RBgCyyr8KYtA3cRHag6b5IHCnDYNRqsiz1OhODIHTGI7qxAeMMj7qXP5E3dU5CHWSgMEeGNn2WYxwhlhSf7eU+RG4rMjQeJoiK89ewBIyO7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732101659; c=relaxed/simple;
	bh=qsgrmeV4Yho3nXdO/d4sbWEH2Emf8JjJL73+zX9kfF4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HJXLbS2JiUaOhDtS3ZEAjQFzZdGOU2oM5xkeRkoavVDu9EX2ibvHIBVgEp2tkwymVXQ/dVv1nWcyYQlrhkW6Zh1GmKuI0+TG9we2xjikoRAoYf2zcIDvTO4U5sk2U6jQ4lUc0eNPamrje08FnJBArB68tjlLAKlTSZ6Z5qlMkp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OuxapYRL; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5cece886771so1480681a12.0;
        Wed, 20 Nov 2024 03:20:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732101656; x=1732706456; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kLyrUQbJ7DreZ+2eCL0QXJjGPutHdXgYXLv04PixPtY=;
        b=OuxapYRLmv14Kgw/ANAObmnGQH7cSmBx5wpbJQcJToXjSnxuROfy64DKgsNuEcY3IR
         dWAYPKCcoTjWR0bS0+XQq1lDPkOvQMRPuquYAwstrZ+lLPNbRby3yj+Q7qfCGjmlq+0q
         liTJrUTvG4iRpbldBQpKvwXLUQ1iM/7vIJTY7J4uhU0HUsqbzyB4AqjGyTGADboyTjhc
         vB7A8FXYetWOCix/QNJbw0ZLFhI2+su5QSI5CYjvn+LgJbB5hquNkmcUWqqzRZ4rVPoD
         MjBNHGPT0LoraEwIn4BUK4CepDI3SRuCjU388VM3VawhomLmE5ejcNBNFMBfXlCIeX7D
         B7Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732101656; x=1732706456;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kLyrUQbJ7DreZ+2eCL0QXJjGPutHdXgYXLv04PixPtY=;
        b=Wwc4qfXhlI+ynskTSn4okKZ8tOzi5KDkXRF7H9U0ClS3aIKuxfI3KE3brwOAEJJiMw
         Wg6PvO+J96D+mWK7bddm+YcPeVRmm1kwIhJu+tmZDtdxMw06YKG2L7+wiws3ByaATJck
         6ey051YQ75hASsDitGvCMvAV+jZQtFCcWppFhiVeN8gnvfA/lnzMhbDqs4xmik8V3LL/
         cko5wNB4Gb3F55uDWy8yFqbJBsuOJqjx+sMLuyr0IUZmKtiN17ZL+30TAzH6Qjhg3Gmr
         z4X6YAd41dvCKDdJhiNOXhEGk7n8oU0CBtj24HwlKXmUvHCxLj2AzKwaNrPattHomATQ
         Ypig==
X-Forwarded-Encrypted: i=1; AJvYcCUEV974YIHjfbf/JHA+PZeue7xmsshhS6qculM/8Vrhnnr7dEqa5VU7JbD/P+HZDOc3qzY3KxgxwesC51aYUg==@vger.kernel.org, AJvYcCVS1a6TQl3BjDe970sAAOo5ShSWitpX+SRJehF+j0HN6t8PQxuVLPSvuySqOIMccXzAwiJRIqef7Tkn@vger.kernel.org, AJvYcCXfocLeHbqK0d+tPNICDioXXoy3T+5fiZVephoIAsyNrVeFdRAKIpK2rJRyAuL8xKtOnDxuCilzFkYFXrft@vger.kernel.org
X-Gm-Message-State: AOJu0YzUsiMNc+OkBkN9RGhb51pM2bWulG5efSgsJDYghqELbwzgzojX
	CGCAqTygWikH57exCOY4ltdPkeyUPjy67AAJf3e/VABsEkJN8hx1
X-Google-Smtp-Source: AGHT+IG7pW3Dxr7KS89kSKjBWsHbI31GbaM1tb6J62zSZ1xqBnHqjvWaYalwKIjlxD/g6vIF9K38rA==
X-Received: by 2002:a05:6402:320c:b0:5cf:e218:9b08 with SMTP id 4fb4d7f45d1cf-5cfe218aad9mr5811934a12.15.1732101655755;
        Wed, 20 Nov 2024 03:20:55 -0800 (PST)
Received: from f.. (cst-prg-93-87.cust.vodafone.cz. [46.135.93.87])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20df5690csm758559566b.75.2024.11.20.03.20.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 03:20:55 -0800 (PST)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	hughd@google.com,
	linux-ext4@vger.kernel.org,
	tytso@mit.edu,
	linux-mm@kvack.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH v3 3/3] tmpfs: use inode_set_cached_link()
Date: Wed, 20 Nov 2024 12:20:36 +0100
Message-ID: <20241120112037.822078-4-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241120112037.822078-1-mjguzik@gmail.com>
References: <20241120112037.822078-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 mm/shmem.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index c7881e16f4be..135f38eb2ff1 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -3868,6 +3868,7 @@ static int shmem_symlink(struct mnt_idmap *idmap, struct inode *dir,
 	int len;
 	struct inode *inode;
 	struct folio *folio;
+	char *link;
 
 	len = strlen(symname) + 1;
 	if (len > PAGE_SIZE)
@@ -3889,12 +3890,13 @@ static int shmem_symlink(struct mnt_idmap *idmap, struct inode *dir,
 
 	inode->i_size = len-1;
 	if (len <= SHORT_SYMLINK_LEN) {
-		inode->i_link = kmemdup(symname, len, GFP_KERNEL);
-		if (!inode->i_link) {
+		link = kmemdup(symname, len, GFP_KERNEL);
+		if (!link) {
 			error = -ENOMEM;
 			goto out_remove_offset;
 		}
 		inode->i_op = &shmem_short_symlink_operations;
+		inode_set_cached_link(inode, link, len - 1);
 	} else {
 		inode_nohighmem(inode);
 		inode->i_mapping->a_ops = &shmem_aops;
-- 
2.43.0


