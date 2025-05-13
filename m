Return-Path: <linux-fsdevel+bounces-48903-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3FD5AB5802
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 17:05:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C744C461E61
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 15:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 159882BE116;
	Tue, 13 May 2025 15:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="KbPxyJf/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935802BCF4B
	for <linux-fsdevel@vger.kernel.org>; Tue, 13 May 2025 15:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747148620; cv=none; b=Fq65ioQn7yQT6+Qgzw9duJBQK2+lbP7gJvGytlhfpvz4V8D6TaiA1mRloN7WgTQddY9gRVxIPXMJAPzfQJzUECEXYrKMmA5pWhafg7OmrXuajtcju5IOUO+FwGLvAkY8+f+30Nbmk9Ez+yeItyNBKHobsbs+Ak+tOglcEp/v4b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747148620; c=relaxed/simple;
	bh=PMgcI+gzWNBZdH84wqXv0h46FvJNnnr9jLaGVUU+pnQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MVAa2oQQAnDRaWK0NzPzvRD/NUyOJMajNmMEWAnvbYvYsGzkGR+0B8YMYGlrO2RukAk+hzggy6tqQoMzUuDcXg+qc+Fz9s/d084DYw+T+B0ySLEr7kycNEIck+w002KVRMZAMRwsywZySHAIjIm+wOM7PmGBVXrFRCs66qabJjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=KbPxyJf/; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-43d2d952eb1so42605185e9.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 May 2025 08:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1747148617; x=1747753417; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dWFGB/K+zig4Ure16KVPt1hrUDBz+TRZotq7diqgJ2M=;
        b=KbPxyJf/tDwNRrmCizrrUBPBe53d60IqH6Itu7hphHbOLF8gqdg5AUQt4cJ9o+q8oN
         vwjHBKAFgVoWAwfg0NZwg4XZ4KRFTSby5gcJwHgzN5WkVYVWNQruG4e50FLn9jXvKWl+
         ZnR8AANLYv60p6LKIEPWvN4tlsN1laxOO90aCEuats9vwf1qnjS1GPXpt7bnivr1sPBn
         7HZCUYalghg54pvyi+sT+Yx9ciFUs9mA3m+3/LEUXx+3znsvccUVMiw5WHZBg5HS/J4I
         gfXpea6J3NPH8awRvKhrPM0htT6GyOFgq9T4SZAlZtjXp94QxdNVmLytgTgMJgTggZL1
         mklw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747148617; x=1747753417;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dWFGB/K+zig4Ure16KVPt1hrUDBz+TRZotq7diqgJ2M=;
        b=lkNJySrxEYGYSZHhwqBUoQXbrduow7oJuXqCnDRBd7zDm23HHuaW/t81otOAYHlaOA
         6B9QDK5k1Lj9mmbN/XZoMHIzwPO/eZivy/QwV8eKtlgRu7tDCmdok1MmI2c9bWE+Zzzn
         gsncufKUxYEQXfCJZxWPbB0qA4AsitJb3M7LKD+LA8RiNBXaAVW46hHTrnuOnUN58q1Z
         UnDQr0GtN8sXmn+4l69VWUaJA/NG2GRTMQdNAgDKR1p/e34iTygjajGrXtmV9toOU+Hu
         lVcFYjsQUwS5c0Kn0JgatlLQpuBIDERnJRqlxO4jphqA14AsLZaU/cRY+/HfK7RPNIOF
         MHgg==
X-Forwarded-Encrypted: i=1; AJvYcCUAyTbl6iBbcYuc3AJ4OodBsQ1Iqnh8GaEARsHydV1jwnQwT0diNZxxszERu29TJzRDYfEMsYvtPpl+lRzD@vger.kernel.org
X-Gm-Message-State: AOJu0YxkKYMQqH2VtBY2V9gSDs1rAd9oL+QkBCkHNHoLiiYeatUBkmon
	UGDMXCCpcQcKSrkJOTIFNxX44bg2o4ANJxaHEKuhp6J1st0LYEp6tTAlTHwa+Qdq6NmH/5ka9ca
	vaEyBCg==
X-Gm-Gg: ASbGncv4zpo0uAvMfad/OHhe0xOajL9FPY0vGHPqUX+KQzBNw6nmDcUv/5ZGhV/5z27
	NLvYZYpu8Q6I6IKGxLntrFibUJ2glX/HSF4WJu7JwRXd+udSwqY7AId1I9Amervd52S41Utc+wK
	3v1wq3EneFK4+mXWKYIDpOdU80qy1koI+uApmtV72/8H91gGYgq6xj5JQjis57HWaSW8s6jesCq
	Epd9IDjXBFii72kz9+tN0AswB7X1Cn6I0d3QnSRtZQx80TFd4qMrnpy2C+bEe/08HvjqJ7ENG2U
	dz+DBQ+HCV/66vAZh5Ct8M2lkJ2VsaMlRoXvj27A5zB2gfL68wA/IWCvKLeeKiVTHrr7TIW2Tkl
	E/gyHnoLJZ57QcTl7d7megdS8IJYTGYFT272PK3/UQadGyRgCsTQ=
X-Google-Smtp-Source: AGHT+IG0mWUuNxFzrWUI/GF4eUADxQbQomCRaJ5w8tGJbA+MKSqy/z8Nl9zpSz5XWu/bKLjdYI9vZA==
X-Received: by 2002:a05:600c:a112:b0:442:d9f2:df4c with SMTP id 5b1f17b1804b1-442d9f2eab3mr105883385e9.22.1747148616753;
        Tue, 13 May 2025 08:03:36 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f46c100023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f46:c100:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442cd34bc2fsm106800805e9.20.2025.05.13.08.03.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 May 2025 08:03:35 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v2 3/4] fs/open: make do_truncate() killable
Date: Tue, 13 May 2025 17:03:26 +0200
Message-ID: <20250513150327.1373061-3-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250513150327.1373061-1-max.kellermann@ionos.com>
References: <20250513150327.1373061-1-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allows killing processes that are waiting for the inode lock.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
v2: split into separate patches

Review here (though nothing about do_truncate()):
 https://lore.kernel.org/linux-fsdevel/20250512-unrat-kapital-2122d3777c5d@brauner/

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 fs/open.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/open.c b/fs/open.c
index d2f2df52c458..7828234a7caa 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -60,7 +60,10 @@ int do_truncate(struct mnt_idmap *idmap, struct dentry *dentry,
 	if (ret)
 		newattrs.ia_valid |= ret | ATTR_FORCE;
 
-	inode_lock(dentry->d_inode);
+	ret = inode_lock_killable(dentry->d_inode);
+	if (ret)
+		return ret;
+
 	/* Note any delegations or leases have already been broken: */
 	ret = notify_change(idmap, dentry, &newattrs, NULL);
 	inode_unlock(dentry->d_inode);
-- 
2.47.2


