Return-Path: <linux-fsdevel+bounces-58682-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB3BDB30717
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 22:53:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D45C96418F8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 20:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CBA5392A60;
	Thu, 21 Aug 2025 20:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="KvXv2mkc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB3E392A43
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Aug 2025 20:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755807687; cv=none; b=tpSPjzD+uwRLmuEl272asY/6ZKwx8cr5xxE8q9rCade+o18/IXhfz5YKaYV9yCu8v7D24cqV4iG3PIIZq9yTLxBGXeS1+n2Wzn/A7Sgb8eekCggQDv8FG/ot09YCoIantuC9brLDhlLQ1Q/cVE7geOOn7AMZxfdccmgej7xo67k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755807687; c=relaxed/simple;
	bh=i4hePIMWRF5Mzc731oRxQkAAktt67HnoQ6nCM1aZbyw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cwJdH94vtgoxvgNyfsqQMBZ20BvRSYJuEUdVqhelxq9LhFMlU5emswYnesOnNc5tUfVWKiF+Iap7fuBGx2GklHiAOOJG3SwYdDDABeYNZqx6Gg6ZPUwrXpckR6oQaHmQVl5JmlQVAE6dUjPjmhVL02NQ5Y/6JeQMe2obU6UBJJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=KvXv2mkc; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e9343256981so1787286276.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Aug 2025 13:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1755807685; x=1756412485; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ag9tvG0VI18Yk1eq/2xT5jiAIgHSAzuzC353p9H0cHc=;
        b=KvXv2mkcwwtjYomjJXpU7AH9jjeFpZ+w4rnpP2bRduLCuMXcWm7ON3fJpdvhkPRdz6
         nXDB/vfXkpukTP9Vz2l+YEqtf//LPg12OIgaOAMSgpYC4yfXj9drbE+ByoZLXGEQjYFU
         WmIDh1nWva4SitZVFIh7z5wJvQn4b9K79CQtgVwQgCOD3n31Ke3A7hcZhJikZgdQdFWa
         OYuEFMithHzKj9RuH6okpoxgbWMuwiBr8Kd6gaqPnY0guii9GuoZ72B4rWoQhAVVFq+J
         salYIDUSGGCrwhQ3utJg6MTnbg5Gl6tAstLrwHUOleXUh9E9T//WfShqX2at3ggNX0BP
         zYRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755807685; x=1756412485;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ag9tvG0VI18Yk1eq/2xT5jiAIgHSAzuzC353p9H0cHc=;
        b=ekeP/iEExUJ9PaaVXDEb0xBoQpfd0JgnvBZglO+7t/VV4GCITnPAvqMs5oaD7Zxspv
         NAZ0Co836R9yC1e6Kxis0r6Z6LnhcVCYQCwjBUwKU8dsVmBF6FqHtVQ6adnQ9fTPyuo+
         rjQOlJe2mlA+A30rIBe4HKVmb81Zj2AfdvA2iFcUBF9sfqKhbNCMi43C28fBrxa+sNio
         yFsto1r5dwpHrl5gB+Ls9lh5MCnZ/eXmCHscWVkT3CCJjwj/ANs09c//wSd2WjHx5r84
         zlbhPbPMLNMa+B4wbPHS8nfPW+viAP1HCEP/uSXP6R1Pte195HytcGAFsO0CqW1a0W/j
         Knsg==
X-Gm-Message-State: AOJu0YzqH+K5y3uZLgQSEB97InniCEg16mn24rO9rf1I5XGr7QQABVkV
	k45bfPekmtwMRSKfUpjMD/Zql0FlGX41vB1miOvS9cEmi/k0SYs5PvHvni0pIhy7RNld7UIcQHL
	PDDruzWRJyQ==
X-Gm-Gg: ASbGnctvQyIwzBHtB+qba7oz8AI8pP3z7sE36L805doZQK33qy1zaq15ANFLMXyJs6N
	Sd4TGuwD5RXsoV2SseCxYfUcIlXlOqG+q89ywlBRRANWIGB78Yc5bm80/RZMxqnO3sajlAVcCF3
	gvt6a0UUJuRyTT/BFBo3MdbV0SL0uLKyn352Iz1ghQ+2NjM6CJ5UXO+WPzwXCSPjzDhiOxdTlSd
	TNc9JrweUdfH3wYVLWahPPZ2+QYIQ+J6USCb4h9Ss6u34443zKiHo79LERfzJS1TvVKlS2PQg5R
	ZvWmGUJg2Yoyd/e0SwzGuMfM+zi4mUXgA/Iw5IzxIJqStM7wyc1xvutC+MxDw3QzChd6EuJWXQt
	7KaFWw4M+JWxWQeUlGdk0J8JMURprd9ZhdWyp7UZ/YL4u90dFKr5zU/Ebretmq3YstmicuwHCh+
	8BSUnY
X-Google-Smtp-Source: AGHT+IEBylvc7AHp4BniCBq5Q1DyNIynT9BLRz0rP2zm0l1TKcTJo/hsMPaTkP6ZgkuFyU8mOePjTg==
X-Received: by 2002:a05:6902:701:b0:e95:1521:3d93 with SMTP id 3f1490d57ef6-e951d08e7c5mr623429276.15.1755807684641;
        Thu, 21 Aug 2025 13:21:24 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e9348b2c51fsm4962060276.7.2025.08.21.13.21.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 13:21:23 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk
Subject: [PATCH 45/50] pnfs: use i_count refcount to determine if the inode is going away
Date: Thu, 21 Aug 2025 16:18:56 -0400
Message-ID: <8b63d783e7896e857380857ec4c40a00e17d8d73.1755806649.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1755806649.git.josef@toxicpanda.com>
References: <cover.1755806649.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove the I_FREEING and I_CLEAR check in PNFS and replace it with a
i_count reference check, which will indicate that the inode is going
away.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/nfs/pnfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/pnfs.c b/fs/nfs/pnfs.c
index a3135b5af7ee..042a5f152068 100644
--- a/fs/nfs/pnfs.c
+++ b/fs/nfs/pnfs.c
@@ -317,7 +317,7 @@ pnfs_put_layout_hdr(struct pnfs_layout_hdr *lo)
 			WARN_ONCE(1, "NFS: BUG unfreed layout segments.\n");
 		pnfs_detach_layout_hdr(lo);
 		/* Notify pnfs_destroy_layout_final() that we're done */
-		if (inode->i_state & (I_FREEING | I_CLEAR))
+		if (refcount_read(&inode->i_count) == 0)
 			wake_up_var_locked(lo, &inode->i_lock);
 		spin_unlock(&inode->i_lock);
 		pnfs_free_layout_hdr(lo);
-- 
2.49.0


