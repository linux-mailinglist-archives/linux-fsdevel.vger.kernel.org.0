Return-Path: <linux-fsdevel+bounces-67361-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AB644C3D01A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 06 Nov 2025 19:05:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 44E644F6FC2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Nov 2025 18:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DD1835504D;
	Thu,  6 Nov 2025 18:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m++XvFlg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC6834DCEC
	for <linux-fsdevel@vger.kernel.org>; Thu,  6 Nov 2025 18:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762452083; cv=none; b=GCV+dDWgca5aVOUno8KTPYO/hIUROaJ302yLI+mdvUWiwUUt8AEq4W+4wYqAL7WIJ6+VeEb0uqbxgtHNfkI23aUVAnN4SSYWV21XXrYlddBKdC/5mDybE/TjnftKNTJKL2p4LcYA5VDe+2uZ9hsFRdkvgpNw5uxYzwaV7QcMoOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762452083; c=relaxed/simple;
	bh=ujXfxZ/rw4BEjhU8Wrycg8rg26Ml1Aaup7GlBWzDyZI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PJifTJqoAQpxc8GYVIZdbF2H6CkKH5IeUHEUR5ILOrkCBMeULRhyx6lXRod6lJxDHlI60siUaVmmAnfZAeq7pWXrkLiWQ35q1/SiigYbTD+yVOU4x2ts4wK/xNSAVpNf0pdPbULJR1Zx17OONvrasTsEYBSKgfjJUXj43Ff0Ef8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m++XvFlg; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b729f239b39so100164066b.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 06 Nov 2025 10:01:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762452080; x=1763056880; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xwJ3AQ0ldZfl9MQ5AJahUB+Dg59aqvc0TsxPubrSBz0=;
        b=m++XvFlggLYGtWURJpzC7p/1C9rYObR0h2Tyt10Ec5uh4olTmPPwiGdkW7aSmtfKTP
         oPY8EmvSv9mgZsadOVci/gGUfPTND/8BNUtseqRtzFCnH48A5/qigLhDr4UN1Yp44LIW
         Stpto9z0foT6A0HGJ+IJHT9m3ow+9Qy7yNZ/FRrHBjvdw483rCfl5jqAX30+eMfr2yXQ
         vYm7y0Caa7Oescun6lrsyNiTp6LDf/gQfVt9dxsIIh1R3c9ORJXccBgnP4q2hyJeMb2m
         EtN6itT2HacccrUuSD7JohWIyskBJNVZBqFCAh7MWE2YEdn2sS3Z1fVoDlPB+HkHDUVD
         zCIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762452080; x=1763056880;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xwJ3AQ0ldZfl9MQ5AJahUB+Dg59aqvc0TsxPubrSBz0=;
        b=A3g8ibWMIvBRTrsZpfmIuo1rcIgQpWcuR1xjA5RVx9ziIl0jq0NC18hSujm0nFl5D7
         b6tRLxLqSp1ymVw5e9rc26dLlFCCENId9TtmH0LxYT6LNChRK6qEKq2cS70rECMseL9N
         pTwvYfm6X0lIrtWWqGGo/70ZZ5/cdAAcK97LTy4xYrVNjsluST1nY4q6lP1lPxKWJVbo
         hQH9JlwUeFdD3mPmW+609DczFqV/cg/bI58aWTL4sw5qWvScJszB7NK9u7fc4b+LBv8J
         32vre3S7G3ARIe57ccfyLdF/okghYXrOoyfw6aEjwhfbTStAQ/R0LQLUDTT2WmzJ244c
         914w==
X-Forwarded-Encrypted: i=1; AJvYcCXdrlz8zMlVeIt4/ixiuR/b1u6WZfPPjEV46Z7UyT2iQ50rfwflp3kxn8GDckdJnQARRcCPH4NknxMloAqd@vger.kernel.org
X-Gm-Message-State: AOJu0YyV1mTjMKGvzdnA8/s9M4ExhY/Nz9gVF/FJhD+1R5hHucU29tbq
	uXpHqhTH0xn5kMaeSqR8cBcx+nRhf2bKEeTwJMMrZKDYARTkPAJuHLOM
X-Gm-Gg: ASbGncvuzo9ZXvt3IYNf8WoqVrHD2U1tXSSITo1xPV7lGOqeTtdf+XCLJ8N//nxL7Y6
	ixlFrMFPtWsxuH0ywbTKS3FxYUaUykRZAsbZcXrGAA+Ldy0KXHyqGVfbJNU2ZZdxBbtRre0dStU
	bo1bDrvaLGqNgGU8g57I0ewdkGHbSysw7/6DUOO2MSo2rUBPfEyyQQVUbE07HDemG2OKkJwm3Hd
	eqRE1XiCNFeLKmGxVeEkoLxMB5tQ+PcoW1GsiBL/UA9Fi3CfKvEo0DUJsxVH016ajK1yEyOn8rY
	niw2VFWaJg7JILahFu20YqKy9vcQiegqYdyudGf2t5Nmhd5ajrUF5WPbKqb9LTqrysmvND5WSRg
	+9EaZkKx8sDYbcYo5fgurMN4E/j4ZOecyZmGnQQnIpEDpcUUn3r6ykTLtOo4qFNnPR6jHsj+vzP
	EpUpRtLNmBwe1JkbJjKrtymUqDBWYRw/NJ9UwEQUQBcxh7G7VC
X-Google-Smtp-Source: AGHT+IH23Tiy/uzhlQVevCqmAaX2EuxhMCeC/ChKrhzDKky+KjjBLdpLh4g1NTZxdt8W+eURbqVM8g==
X-Received: by 2002:a17:907:86a3:b0:b4a:e7c9:84c1 with SMTP id a640c23a62f3a-b72b9550caamr52972866b.7.1762452080227;
        Thu, 06 Nov 2025 10:01:20 -0800 (PST)
Received: from f.. (cst-prg-14-82.cust.vodafone.cz. [46.135.14.82])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bfa0f1bbsm15430466b.65.2025.11.06.10.01.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 10:01:19 -0800 (PST)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	tytso@mit.edu,
	torvalds@linux-foundation.org,
	josef@toxicpanda.com,
	linux-btrfs@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH v2 4/4] tmpfs: opt-in for IOP_MAY_FAST_EXEC
Date: Thu,  6 Nov 2025 19:01:02 +0100
Message-ID: <20251106180103.923856-5-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251106180103.923856-1-mjguzik@gmail.com>
References: <20251106180103.923856-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 mm/shmem.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/mm/shmem.c b/mm/shmem.c
index c819cecf1ed9..265456bc6bf0 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -3106,6 +3106,15 @@ static struct inode *__shmem_get_inode(struct mnt_idmap *idmap,
 	}
 
 	lockdep_annotate_inode_mutex_key(inode);
+
+	if (S_ISDIR(mode)) {
+		WARN_ON_ONCE(inode_state_read_once(inode) & I_NEW);
+		/* satisfy an assert inside */
+		inode_state_set_raw(inode, I_NEW);
+		inode_enable_fast_may_exec(inode);
+		inode_state_clear_raw(inode, I_NEW);
+	}
+
 	return inode;
 }
 
-- 
2.48.1


