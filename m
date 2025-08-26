Return-Path: <linux-fsdevel+bounces-59260-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE203B36E8E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 17:49:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E92DC3B154A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 15:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 387123680A3;
	Tue, 26 Aug 2025 15:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="NpSH2p4T"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC29368081
	for <linux-fsdevel@vger.kernel.org>; Tue, 26 Aug 2025 15:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756222892; cv=none; b=DOcBYytVp3REbb6pwSOXQHm84sbPJjyhppG5rmVdg0cvii7fhaMH7vM3PrqHGx+uKck4IL07srtEkjvbfE9Dy2f54S73EEYk3AHXWEmOODbkK2EoT3cEdk//hWg+E8uFlQqK+mIgWduKAHS11rzXuAVdcU43RxY4RJMB0cjejgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756222892; c=relaxed/simple;
	bh=da2l454EY3RDXmu4EckOSRuB1DAXzvcsmcg7FnzAFBA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=idMIrEAWwN9syz2b1/IIc0k8FFe8uK0iTeTvrsNTUQLttXUkgY2AjnMZh2/HB9V5XGkDJ0v8idChW+y/Ygwf+nuVnUHXFCuc6LJV/LgrqfoH6ojNwK5+j3jWkRYhsEwmNyu6zdCS4IrNm0EYg/7ZtJBseiU5OFbBI+v0WEJ/uYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=NpSH2p4T; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-71d603f13abso50818027b3.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Aug 2025 08:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1756222889; x=1756827689; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1J8X3O3fTDW+jaZZ9ZUDLQSX9BKwP490GcePdQCSTYU=;
        b=NpSH2p4TwrhYqyS+JNvyj2RFxnRO8GderDQpdNwrEtTwAl6etuRWZC0DxEfavawTwr
         JN9oG6Fj5sQf3hsTt8bUNwA98mZ+FjJrmIMs57VdAJ0u//t1x+6G+AatgmBBqgtQeOcL
         EjdHR6EeE5IGJyXx4wQJzJaVYcJDocwsiMlsSsqRdqNazntvaGkEUaZeeGQLXt4j3BwJ
         NG5CKPhg10u9fMotJh80BBGfrfOzbZy54EdJGY//l//ru3UIugRLrwenwxpIFDqw8k44
         yI+RPEaXO7z1pGffmoHJ0gznWoXgnw0mgjuam2HhRefh9VqOfn7OmIp8lw1ijMGQT5A2
         bbJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756222889; x=1756827689;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1J8X3O3fTDW+jaZZ9ZUDLQSX9BKwP490GcePdQCSTYU=;
        b=ZqMdRz32AnWkTlY56ZCLLG1sh/WZnnrUopRjgkXA+KGwe7bguN3wcRHB092PyYGVSL
         0iPuwdqzgYAwUdDgDA490/lb6Iax3N3V51NtYKO7VmQGaxsmwE6RzywQY2Ry9KC3M7qH
         k03885KldI0LuE+TYHDiD7K9w0FF2KpATEuOMALJ1ZD2699s5WJJ1Ta0c3nrAxlftM9I
         1IKUyNXrwt40Cuw3RhvmZsfktU9avbz565k3pxQqCSx5/0vreLZzc7WOI1ncRUhVbcua
         5B7l9tgd11kL2bWIsSaxVQU/pTeqnHle9LpxOdHGe3nBfiBPI4hVIneJukisHFSra++4
         Mwww==
X-Gm-Message-State: AOJu0YyjvJ1lyBGAEdKRj27PCH2rN64S8vlCafCSLBmay3X/V5+9w9eO
	d7j516d+Od2TJbsdsHgojF0o8GSFHpvABxDpflyE3NPwHFTKqi8kmdWoGCANlNdNXTJI0YTDmqp
	zvTLw
X-Gm-Gg: ASbGnct+XHYLtlnPRPQ3eUGKqQzAD/uz6HYbfA/tka0Va6G3CP6wk6i/t3ToMXFLtN4
	EWHdv6O3MVt9qddXINMjgkWzKLHxsb3eVekbAPmg8dz9wXNu/IBCrxkJpu5Ad0sXXZnaTmqJz2Y
	OoSmnodtemelrySk5VJoqi2iJZqlVyqo2vBxB33pHdXj+XeRsMmI8h2xVThOyrhlD15ZVWbqVXa
	crZjp00dQ98foX/FwC7SPC22Tcll+GdQEjobb+I8qPtp9LBPmEtENGJ6u71LaRASZgpNiCvNsh+
	xLH689HcQGDwBSsYC2tDOPJ+ztZCTDONbdkqjpck7qhEWYyigI08kQu4FAHIy+iAtGGKSG2xdjU
	LdNweToa5JVTaYkva+gFMusFD0NdVzqQR16sdvyzgmGX6FJYalI9w8KjlXnU=
X-Google-Smtp-Source: AGHT+IGeqctPLqrW8y8Jmm08bG1yVz3laGgupDgU9tlxtVYuPYypXQM+Rifx08nHERJsv8bMHECX7Q==
X-Received: by 2002:a05:690c:3507:b0:71d:5782:9d58 with SMTP id 00721157ae682-71fdc2b731fmr152872667b3.8.1756222889415;
        Tue, 26 Aug 2025 08:41:29 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71ff18ee79esm25043387b3.73.2025.08.26.08.41.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 08:41:28 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk,
	amir73il@gmail.com
Subject: [PATCH v2 28/54] fs: remove I_WILL_FREE|I_FREEING check in inode_pin_lru_isolating
Date: Tue, 26 Aug 2025 11:39:28 -0400
Message-ID: <aae290b95e0a84f47145256295841c2d5c533d9d.1756222465.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1756222464.git.josef@toxicpanda.com>
References: <cover.1756222464.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the inode is on the LRU list then it has a valid reference and we do
not need to check for these flags.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/inode.c b/fs/inode.c
index 082addba546c..2ceceb30be4d 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -666,7 +666,7 @@ void inode_lru_list_del(struct inode *inode)
 static void inode_pin_lru_isolating(struct inode *inode)
 {
 	lockdep_assert_held(&inode->i_lock);
-	WARN_ON(inode->i_state & (I_LRU_ISOLATING | I_FREEING | I_WILL_FREE));
+	WARN_ON(inode->i_state & I_LRU_ISOLATING);
 	inode->i_state |= I_LRU_ISOLATING;
 }
 
-- 
2.49.0


