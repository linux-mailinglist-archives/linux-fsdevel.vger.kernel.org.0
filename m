Return-Path: <linux-fsdevel+bounces-16453-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9126689DF00
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Apr 2024 17:27:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C09841C20858
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Apr 2024 15:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1E4B13957B;
	Tue,  9 Apr 2024 15:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="2K3pEAIs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF02E136999
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Apr 2024 15:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712676285; cv=none; b=MKizIfjrz3xoJZZRsw18BtA/1Hd+MPIRu+IIBrwNKDJt0EYiifAdnFsLX/Uf6ulj8TLmpHceiTWX5Bn/Fx2N0BdcelPG6LBb4RG1OSDJvxKUSmAtP+i73N7DbkpZ3gK+kTnw0QQMuGcPvNSX1OJfR+Qkke9fEP5z/LOUMO/HcTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712676285; c=relaxed/simple;
	bh=L8raPWqde16GsYWbCk+qHGSoPzx+xF25H0NtJJiUQrA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pQkLdwR5viqoGgAAjG8BdZFJ0eDrfljjaky50kfbavbyhVErx1+g+wLSgp/CfK0ycXxKxMgcnvToQKEcR90M5eiMHkIrjtVuEJt/AF+qbs5ljoqPPaQbsgJ8M9o6N7JnbLf3Yh58/4kcvUQCMcT1UE3lumkVJPtab001TKFnolE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=2K3pEAIs; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6ecf1d22d78so873917b3a.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 09 Apr 2024 08:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712676283; x=1713281083; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PC3JAGAh91yPLCnyIgZ/a59FqxkcNwJUPV8ww2u3Dso=;
        b=2K3pEAIsxYV7P1KUpAbTcLksBO3dYv2g60jnUziJ4uEi3PJgwt9iro7wp9fV5iyou3
         2fXk1R26vMJuOUg7eT99FlMqYpOh1XrHzyM+ltdnWz70JuHKqPoEsD+pRXijXRHemAut
         m+hGofZDsjdYwczMVHrv1BGMZ1u2sWf273GN8PRN5bB8mCdOZJnRQVNLmumhyJQfSLYE
         2hwLxKSE0L7D0pMd9W8pHRQiN5viMNlVZEqb0CrAdNvQw4Rc3uJPnS4lLIjmzlTMc61C
         YFIPy033Th31tteShL1qqyl6W/5ICD/ERqQoxrzJrZMh1Qzp7jJIfnuAeDiMpePicBmk
         3qAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712676283; x=1713281083;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PC3JAGAh91yPLCnyIgZ/a59FqxkcNwJUPV8ww2u3Dso=;
        b=YvdxYhpXASSBqGqlZfVYJSlOhycYOU07BGR9eK73v7AZp/5oCdBxXErfDETsXEeSIp
         w5Gfn1wml+yK2mMt16oSdi+ngrfru5PZf+UQ+TGjMFGzws/ACtwO+gC7OVMkay8yFWCJ
         Qk3MJbZ+RcUJAQvKouzq/L+FMO9W30nijeB8D2lD0u6WdHP4iYDn1ruTHfugYqdtnkj2
         IxloLAlGV5/1nHzgNaeSbK9q0JXBOARiooDxKyJrjg70RksXuoxQFll6l3UaFuAnTm3+
         y//8AoeO36asW9/wZZ1naQmIZWuVhgWE1obTX7ZgXhumoamsE7EMnZ2Vrwb0oHS/vtp3
         hEow==
X-Gm-Message-State: AOJu0YyvRznUXY+vySkGmAvShL3OH3hrgUFz8LVj5Xn02kGr7D9Fwe/j
	Y+IpUbuwnUPJUZyZB0k5Tiy9qjysPNT+DeKx21exgKu2kbVbjzA8JjzRnDP5jJJMrwHMY2hMeGT
	D
X-Google-Smtp-Source: AGHT+IEc52xWMZzZcrHpnjme9geYxqLp5964NukBO7ZeZNSHOZ1BD9wDx+9lDuJhAiqT69HuUCo3Xg==
X-Received: by 2002:a05:6a21:6d9d:b0:1a3:c621:da8d with SMTP id wl29-20020a056a216d9d00b001a3c621da8dmr171767pzb.1.1712676282899;
        Tue, 09 Apr 2024 08:24:42 -0700 (PDT)
Received: from localhost.localdomain ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id ev6-20020a17090aeac600b002a513cc466esm3945558pjb.45.2024.04.09.08.24.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 08:24:41 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	linux-kernel@vger.kernel.org,
	viro@zeniv.linux.org.uk,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 1/4] iov_iter: add copy_to_iter_full()
Date: Tue,  9 Apr 2024 09:22:15 -0600
Message-ID: <20240409152438.77960-2-axboe@kernel.dk>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240409152438.77960-1-axboe@kernel.dk>
References: <20240409152438.77960-1-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add variant of copy_to_iter() that either copies the full amount asked
for and return success, or ensures that the iov_iter is back to where
it started on failure and returns false.

Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 include/linux/uio.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/linux/uio.h b/include/linux/uio.h
index 00cebe2b70de..9e9510672b28 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -197,6 +197,16 @@ size_t copy_to_iter(const void *addr, size_t bytes, struct iov_iter *i)
 	return 0;
 }
 
+static __always_inline __must_check
+bool copy_to_iter_full(const void *addr, size_t bytes, struct iov_iter *i)
+{
+	size_t copied = copy_to_iter(addr, bytes, i);
+	if (likely(copied == bytes))
+		return true;
+	iov_iter_revert(i, copied);
+	return false;
+}
+
 static __always_inline __must_check
 size_t copy_from_iter(void *addr, size_t bytes, struct iov_iter *i)
 {
-- 
2.43.0


