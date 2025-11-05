Return-Path: <linux-fsdevel+bounces-67206-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 39627C37FF8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 05 Nov 2025 22:26:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1840A4F5A8A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Nov 2025 21:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB7372E2DD2;
	Wed,  5 Nov 2025 21:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YFEzgGst"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F422E1C7C
	for <linux-fsdevel@vger.kernel.org>; Wed,  5 Nov 2025 21:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762377642; cv=none; b=aNS29PN5ga7H0AiK0M8whbU8ZzlfNwrwPwYNpQyKBeHxA/qemL68bMDW9BiM9LTm7kHH5Okx0PRBq159r0OFsYkPgsbJFu182iMvihk7rTJxvsiZsD9xTlGcTSIVIYAwedB8QwEe08dBX8lq4LfmIktlR1LC/8Nmxs+QB+McqPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762377642; c=relaxed/simple;
	bh=VK/9HNFmtl1DbSF5vPhE1RBKf6UQ211G3ScyH9k47P0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bmp/bOq83QbxZuaDj5WTynFmyQ7hhUaKvB2yzUWq8JOob+NByA3U2+DcXhbqeCr6yEZZtbmJtoA784Xy80o04xCZEMhcH49NeVp30DP8QXLT+dl17NLwwB5tYIgpBXKu9oB12UUQGKg5yxhxdh4PIbUMU5AdZCj1Kss7IQRPjf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YFEzgGst; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-477563e28a3so2267035e9.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 05 Nov 2025 13:20:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762377639; x=1762982439; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5lQyzNcm7QV0KWXbua/krd30WIAIDjyyQ9x8CHS4lA4=;
        b=YFEzgGster8N813fTtbmfhPKG2jUi00lrGldxhCCn7u2rZx71O1xYimBLRWS9fz3M6
         S5oUInrDTXM42W0ZpIHmi7xsxNreMXkSaCL9fmVeUukb6pDuqjhBg7GtTwzbwIsJn7dW
         +GPQQDPjTKHfBunEDOSiK1zXJpCL2esUjrwBTkAFuh0zBkDOaMm1P+qfKVLu5z/ue+qc
         Vd/rs931dVPvKlClxg11wwqjkJ7trvYSFQrgsSN+ADK8QMBTt2BPdxvHoM56Qf73DAG4
         Pp2GRcmpm2qfHGGVfy1ZWz+m2sYaHZo2D011uiTypg8BluCP/GBTzMz2Rb4ep+HWyyid
         l/8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762377639; x=1762982439;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5lQyzNcm7QV0KWXbua/krd30WIAIDjyyQ9x8CHS4lA4=;
        b=JaR/o5/dcRJi2Q+tSTnwr9Lgw/S6+IUKzdG/C4tKtRTmGqlDBdlhEu0wiXf/tfiT+Y
         Wu8zQrBhOhgfjNTs/EPLAeUsmUAaw4lo4z1zW2I6rtPtF848OZUONfFn4eG7Ze2s1o2U
         vS7oeipVMmA7HSMidrqPHgLq+2x8v4P3xmMXL49RbJSoyGfPgWfhuXFvSBsewlHjfwyf
         bLGTUavTOytAGhaQcBsOmTRVgKSTUZJ+115V1TUNC7BEs8/7IA9whKqRZkwcS5W3BpSE
         4QeCwu9NK8fTzhMsW3d3LdrAjsVciEku+n4lec8wtXbouPAqlCTCI9aF7FRkFfPvBUH1
         eLJQ==
X-Forwarded-Encrypted: i=1; AJvYcCUWoArCD+PilcsFj/tjQnGEGHS9wZTHE5EgyNspQm1bezeJuafN4KnptbB9FmUbVxCSTDzUwhccdFv8YiBP@vger.kernel.org
X-Gm-Message-State: AOJu0YzCvPYQQyD+yxeiRXU/YBm2NYxnxJDzY0NnKsXsLbMMYpQRxoJf
	/Y9AMssnHixjA2aSdSUJcke34Z4arI5S0Imhd6+v0Jb7UYP+5fbevVKe
X-Gm-Gg: ASbGncs0V+edKf17hUOEDHRcBokV76NuBTwVNchAd4qxlioG0dDFy0N1X/l96TlCb5b
	yu+O3qcy45LGGwRI0gpg+NnunYOWs+OgcvXFKRzItJxZpXiKt4aitW8agm46qNQpSctgqhZEKiy
	x9NPLxYUQLp00VVyPMzmYmGZyIAjGawXiyWpvy4gqMqSXSu31tBWQ3pXdIL5e3WD6SJPIiVIC99
	Tezityjrc62UYtvru70Uqm2D5qmFmcmOSAHchTSdiFWX94AYooU4p9SuO/KQ538hHK5HseyHLcf
	Ii7BvQsJuh749es7H01Kppe2/p3ePIAU1tlCtDmmXjod8J9o6EZYQtLRl61Ypzy+pKcCUuNU31d
	3CYdrwc1fDy1k14o5VN1839FVRH7fj0t3C94hc1quQ0i736GYx9S0es8/6qmg6jN3fhngTDBA8n
	fy6/ubYX+19ELyNogyi5zGFDwi8AsgaaEBY5wZlkcL+o1Fw/YB
X-Google-Smtp-Source: AGHT+IFPFme+C9Eiy3ItncLEn8BR0aSw2Xo1OTHfhpspKa2xDTBJtCTWjqboomnBE7dSFjby7JDOpQ==
X-Received: by 2002:a05:600c:8a0a:20b0:477:5639:ff66 with SMTP id 5b1f17b1804b1-47762089cc1mr5883485e9.13.1762377638603;
        Wed, 05 Nov 2025 13:20:38 -0800 (PST)
Received: from f.. (cst-prg-14-82.cust.vodafone.cz. [46.135.14.82])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477625c2f90sm8914505e9.12.2025.11.05.13.20.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 13:20:38 -0800 (PST)
From: Mateusz Guzik <mjguzik@gmail.com>
To: mic@digikod.net,
	brauner@kernel.org
Cc: linux-security-module@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	viro@zeniv.linux.org.uk,
	eadavis@qq.com,
	gnoack@google.com,
	jack@suse.cz,
	jannh@google.com,
	max.kellermann@ionos.com,
	m@maowtm.org,
	syzbot+12479ae15958fc3f54ec@syzkaller.appspotmail.com,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH 2/2] landlock: fix splats from iput() after it started calling might_sleep()
Date: Wed,  5 Nov 2025 22:20:25 +0100
Message-ID: <20251105212025.807549-2-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251105212025.807549-1-mjguzik@gmail.com>
References: <20251105212025.807549-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

At this point it is guaranteed this is not the last reference.

However, a recent addition of might_sleep() at top of iput() started
generating false-positives as it was executing for all values.

Remedy the problem by using the newly introduced iput_not_last().

Reported-by: syzbot+12479ae15958fc3f54ec@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/68d32659.a70a0220.4f78.0012.GAE@google.com/
Fixes: 2ef435a872ab ("fs: add might_sleep() annotation to iput() and more")
Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 security/landlock/fs.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index 0bade2c5aa1d..d9c12b993fa7 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -1335,11 +1335,10 @@ static void hook_sb_delete(struct super_block *const sb)
 			 * At this point, we own the ihold() reference that was
 			 * originally set up by get_inode_object() and the
 			 * __iget() reference that we just set in this loop
-			 * walk.  Therefore the following call to iput() will
-			 * not sleep nor drop the inode because there is now at
-			 * least two references to it.
+			 * walk.  Therefore there are at least two references
+			 * on the inode.
 			 */
-			iput(inode);
+			iput_not_last(inode);
 		} else {
 			spin_unlock(&object->lock);
 			rcu_read_unlock();
-- 
2.48.1


