Return-Path: <linux-fsdevel+bounces-74032-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 307B5D29C7D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 02:55:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F2B2A3035047
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 01:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 950362E7165;
	Fri, 16 Jan 2026 01:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JovXsckH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2605C1DE8BB
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 Jan 2026 01:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768528531; cv=none; b=P8NUx/MYKTFrLQYJIAT4hrBJYjISNJH3nkVwwg+AkLf0IwQL6QjMw4md/kuXWDKsnrekdnoKAghEXnyniSo2tMuJOoB3OHOJQWXdt0Wz3Zv34olK/opuf2ph/4JE86K4ECjpvTnnjPumU7PCXnXzLvQjdAAxWPPxl/y4YZ8VjTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768528531; c=relaxed/simple;
	bh=zvrNni6tStglwtNCyQ5vuEk3OyizaJS7MZvlDsebqw0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X4IJFYCeDhqaUlm9Mh09dGE1j6n5B28PDh5cmeJ3dGe4NdTQZCU5+PlS5L3JE5afPpn2W2J2JrbDYCwhxrI+8nRxBFhvyKL5SO+JhFqr1WtBXdkRw7ACt/Gcv56MUTv1nGVgjF5Z/gVI8sph4hNHR0eqLFM0NuBmPfTXLKJbSnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JovXsckH; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-81f3c14027cso869226b3a.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Jan 2026 17:55:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768528526; x=1769133326; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ETjNils5toNHZvGqEsstOgQN+E6gaEfG8qqVmbphiwI=;
        b=JovXsckHfLy59XR9KYEPxCZfTsPaGQ6uOeLlyktc9ExVqaRayCH6bd6vEP6csVD8s6
         L4cuAjpnYlQKuoIipmNGSOSv3zYkHmIZvZe5zmlUO3+kQTC21tF8aODcCpIsEjDtbSr9
         TgoGPB0IpIjfpPAKSXFnSb5Vf1jB6EV0RFokMq+TYyF9vS/Y8JLeeNNvSxRPoX7ipUdc
         xJiBKgz/DM4Mt9KKMkHb2yJf9lXwmePJ1qmsm5TM1EgvoD7ouCFt679ha7hdMbcRH5PZ
         9F/0U9SYAi6svaGg2hG6xLFeHzMNcvnKL/AuuQUGooXvln5jh5BkvqdKRO2ycPOyMo09
         5L6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768528526; x=1769133326;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ETjNils5toNHZvGqEsstOgQN+E6gaEfG8qqVmbphiwI=;
        b=sZsn3mx+w3himBuf7496lYb996c7txmwrTE5/YSzjiRQ/S+mvgZKPzM0Hbk2lrvWkc
         oewd+UEUcl93+rDr1jcNLbJAbPxMC+9GOWCv/vu2idD26ozTVdIWuVzqSeFBa+5PyDUQ
         +HsLibCfyQe3w8u/SYctOuUBZXzOkBIu2+mc8DgHblB1ZA6m1O8YBGu8sdeT34+LTWed
         r/PgfSJ0yaKkvXyLBABONlQs+2pPVLURke58yO8xGX74y0glYcBU1Z1Fk2fFTA4k7S9q
         GnIIBzCZ5swwpCMQ+1WOjTJwsi4Ua6EibLXyFX2HnfD/bMn1waeksPjHg/KsJcU9kkfP
         6uNw==
X-Forwarded-Encrypted: i=1; AJvYcCXtb2+w9wWpx0nOuq6f605++XHmV45skd1/MtD1gJLlCoZ7qaLYzfMEi0Dj2OaJzCleku9Xn4AiLUWzJNXB@vger.kernel.org
X-Gm-Message-State: AOJu0YzvKA4X3vvx9DvKsHCADTSS7A9i3JIN8RPxAOmQU2rmYRdJoErX
	QvK5v4/nf1xGJ9FNElVztrEO14+WfqWRHSMLS7CmkXafsllS7p42U2/qJ2ZQ0w==
X-Gm-Gg: AY/fxX5p++j5GzEcKCkzDjE/Qme0kmAsffN1XxCI++yPCRrqCb3ePGmjcPhxDlaHuY+
	0a0zOxVR2Sff5VBdKt78iq4pryozepCqD0Jhpm1jKwoWDFxwV2Eg1etis0DoimhA5+gVVtRQ3kV
	inOE2hf44zB3SVkzSVKTihU8Vpio66A4GWP3beGgTVrmJqkVfiWsMCuMGjp5EIROPGc+9KMWKGt
	7ZoRVBDa+ksM46hDw7qZ0nAQxzHy0pPz72j/AMmQzQzej2+my7wNN1RJxRxsqQqJKHzKI9oAjRC
	T2sSLE7YEvbR3g2Yr85v1CLWfsXQaLxvAn8xkWmS67wWzLyTh2PM35obLVdlBZsgzAWza4Ls0Fj
	4bw+iLZAOM3A5yRWE2mRmRQI2kTjx39lwRsoMzFyrlwlYNyBewQarNcYavkpyCuSjVbUvJbDPQF
	0gcTBY4A==
X-Received: by 2002:a05:6a00:2394:b0:81f:3eb0:de43 with SMTP id d2e1a72fcca58-81fa065f8d7mr1349858b3a.8.1768528526531;
        Thu, 15 Jan 2026 17:55:26 -0800 (PST)
Received: from localhost ([2a03:2880:ff:52::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-81fa10be07fsm569527b3a.20.2026.01.15.17.55.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 17:55:26 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: brauner@kernel.org
Cc: willy@infradead.org,
	djwong@kernel.org,
	hch@infradead.org,
	bfoster@redhat.com,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 0/1] iomap: fix readahead folio refcounting race
Date: Thu, 15 Jan 2026 17:54:51 -0800
Message-ID: <20260116015452.757719-1-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch is on top of Christian's vfs.fixes tree.

This fixes a race for readahead folios that was introduced by commit
b2f35ac4146d ("iomap: add caller-provided callbacks for read and readahead").

The change in the patch was sanity-tested on fuse and xfs (with large folios
disabled) by running generic/112 for both readahead and read_folio (simulated
by commenting out the ->readahead() callback).

Changelog
---------
v1: https://lore.kernel.org/linux-fsdevel/20260114180255.3043081-1-joannelkoong@gmail.com/
* Invalidate ctx->cur_folio instead of retaining readahead caller refcount (Matthew)

Joanne Koong (1):
  iomap: fix readahead folio refcounting race

 fs/iomap/buffered-io.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

-- 
2.47.3


