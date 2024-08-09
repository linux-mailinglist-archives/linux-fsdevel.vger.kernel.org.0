Return-Path: <linux-fsdevel+bounces-25525-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2231D94D196
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Aug 2024 15:50:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 554351C20C32
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Aug 2024 13:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AF1C1957FD;
	Fri,  9 Aug 2024 13:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=grsecurity.net header.i=@grsecurity.net header.b="cuK/19ym"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA081DFE4
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 Aug 2024 13:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723211453; cv=none; b=FV7DLsVSyC540SiDuSiOsik7DmrwSBQu+jLawIpRQvpUjopNXujzWBYK0s7/tu4QzhtnOXeUARo2CMpxFJc1DFJ/53o1rsBMiHpxpI9eBmeyyPte5G9a2Okg12qC+0MEnPVAVhewdj1t77V1BqU+fpVIJHxLLHgBQVlVnpWpVbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723211453; c=relaxed/simple;
	bh=8VXVkijJVYOudc51d16DRap/MnTRCD1bNvkCPlpdPIg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=izXn4QVxsZqfOZ8v0Ir52xBb2QTHTMv8DFaeJ/niEcVAko2Wd8jxBYREzcn3b0CH/Lfu2bWABj8GsJT5pXSaRhc58mR+Z1ahDIoCdIs5awL6Sxmvd9whGRgjVMyupT3ZgFO0KSZZyiUAGkGF4BFJmNdLz4+sOlJEZaPhx4M3FBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=grsecurity.net; spf=pass smtp.mailfrom=opensrcsec.com; dkim=pass (2048-bit key) header.d=grsecurity.net header.i=@grsecurity.net header.b=cuK/19ym; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=grsecurity.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensrcsec.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2ef23d04541so22410011fa.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 09 Aug 2024 06:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=grsecurity.net; s=grsec; t=1723211450; x=1723816250; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VrXClc+hdla+EQ6sAd35hB5qF2J1V7ARtFD4VnI10xQ=;
        b=cuK/19ymkGi7OkcSuiBSBe6FsHvehbZChegMVbW9d2bIUWWQahXncV9FhFewEb3vGo
         cEPzngzNvEFzms6rruLp7w4kYpJ0SAlk8XnEQr+OYXv2eU3IRBNRLbbgYTQogO3h6JNY
         gGbkCP7iiagC8bD2VBNBHuFnx0MenO7+piA2mg6gdJOGOGH8QYpfF3CtJW5xO6m0AAiP
         Vkw20wH2Z9IDu/V0sOtdClUgAtka/LjBcFGCUUnF+lYu3AOlWSCI7nKGLQ4UGXw3jjxt
         f3KZW7ae1sB5uJid1efTv9zzijKNclkuk0mDPGg5FUuE5NFrOFJxkCv09JaD6cafZ1fv
         Ig8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723211450; x=1723816250;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VrXClc+hdla+EQ6sAd35hB5qF2J1V7ARtFD4VnI10xQ=;
        b=mOUgqj6lFYMxZDhyaixkcG3IByePd3WBkN5KkCavFjZ8RY3dpEhG8QEhxaEmQksm2H
         iIzMmT36Qhq4OkhabVUzrJiORVGFD9sQ7v02vjvqp+shuA8v+txImf2uuaC1SRAY738s
         H4ulPcAwNHfOhkWBYhST19jlNn+2U6a9JN93jXAZ3k7FpeXQHYtXX2Jc8kU1OLWbjp2H
         8GRv+cVFCPGlQhgdgzUczq6b0/rvqSdbylzKW95L/7uRDRfIXoadnpWALzHNH1nPvyih
         F5cofPUnk9HJyDrUWxcb3a9aYSZoqhAiTJebgEXLMRd5pzsEcfzmk77c2TQb+tolNAE/
         WW9A==
X-Gm-Message-State: AOJu0Yzc7qaS4/RoM60sVwHk1Z1aoQtktxd+f/9lZ9OKpILKpBe6xfBX
	TqnpBhHAdANaPR6aSFdTOhz8JZmQFmvbNsDR9kBAluBnkQsSpXOGxwJae04Rv5EPDmfVsfzc3m8
	g
X-Google-Smtp-Source: AGHT+IGLsGkjh4jvQRt2XS1icYtDlISJ5BcVLCJNM6329WueVf5J1rYY6Bo5KoJ9Wgo4tbXTP9Gc5g==
X-Received: by 2002:a05:6512:3e0a:b0:52b:8ef7:bf1f with SMTP id 2adb3069b0e04-530ee979d77mr1195469e87.17.1723211449443;
        Fri, 09 Aug 2024 06:50:49 -0700 (PDT)
Received: from x1.fritz.box (p200300f6af3dec00bc0487030dc7beee.dip0.t-ipconnect.de. [2003:f6:af3d:ec00:bc04:8703:dc7:beee])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9c12ad3sm842920866b.88.2024.08.09.06.50.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 06:50:49 -0700 (PDT)
From: Mathias Krause <minipli@grsecurity.net>
To: linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Jan Kara <jack@suse.cz>,
	Mathias Krause <minipli@grsecurity.net>
Subject: [PATCH] file: fix typo in take_fd() comment
Date: Fri,  9 Aug 2024 15:50:35 +0200
Message-Id: <20240809135035.748109-1-minipli@grsecurity.net>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The explanatory comment above take_fd() contains a typo, fix that to not
confuse readers.

Signed-off-by: Mathias Krause <minipli@grsecurity.net>
---
Btw, include/linux/file.h could get an entry in MAINTAINERS, maybe, as
could a few others matching the include/linux/fs*.h pattern?

 include/linux/file.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/file.h b/include/linux/file.h
index 237931f20739..59b146a14dca 100644
--- a/include/linux/file.h
+++ b/include/linux/file.h
@@ -110,7 +110,7 @@ DEFINE_CLASS(get_unused_fd, int, if (_T >= 0) put_unused_fd(_T),
  *
  * f = dentry_open(&path, O_RDONLY, current_cred());
  * if (IS_ERR(f))
- *         return PTR_ERR(fd);
+ *         return PTR_ERR(f);
  *
  * fd_install(fd, f);
  * return take_fd(fd);
-- 
2.39.2


