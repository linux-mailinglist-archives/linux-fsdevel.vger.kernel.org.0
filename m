Return-Path: <linux-fsdevel+bounces-9388-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65E11840973
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 16:15:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E464CB23C5E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 15:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAC1615350B;
	Mon, 29 Jan 2024 15:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VZv7GpTt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D01DE153500
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Jan 2024 15:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706541317; cv=none; b=LhHxtgPAJLSoLIvSs21+WMl3Gw+hbnSxqDvDnh+JQKDASWmOXL9yR1CHA8vYewl0aChtzUAnsdAq7Q49/SMuXP11q7+MjhRmuR9y3JNfM2OOkf0TVPJvIVqGJyQcnklmbb7QdZlmmM0vN3jj/8/+2LdyqW+AP2FA/U617LWl9Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706541317; c=relaxed/simple;
	bh=DOdxrWw2lWZoKdWSImHC+WZRij0NJNSsd42rGu6TYMo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IVmJbBFRyGEoOSqMsmIUUlfDcrSUuhtbRiBRXnm3MJMGDfDLkGaI4KN2qyluyqNwJ+5jjuq43sij+8gJwyRVpeRbZaMjqQX5HitsHguDkv+B0Xv90hJXuCCPahHw1B2DjKchuotSfxtPIokXIcyhm9k8Ebxsip5JzVFmUseeD+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VZv7GpTt; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-40ee9e21f89so27465095e9.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Jan 2024 07:15:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706541314; x=1707146114; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CO6dSX8s++RLvcioBcV/aw8ivA28MIqmUT9bpWh0gEY=;
        b=VZv7GpTt5e7GfEe6RAp2rtweU2vvQ+5E+6rgYAtu8kcAwOB0GpW0OEZhf4rKC/P2J8
         TBun9uKKvdoRm0VCmi2d7PivH2KS3aemnEK4gJ8KJLBPj8K8mu1vI2TDeRNW7gseqUP/
         ifJqyHc+bLseozh5JN6GJj/Rz0qJQnaYH36tXUGf4cdXxdxa09u6zBJaUoG1bJIm+7x8
         FqMyf0meOTNmqd1qqADfm5GVE6/F0wE1XZWb0vav54I+FebCO3EdFSSAbHywkonJ5qOC
         pM63qEBq8DupUYs6TUBLSMtmTntP9SmAmpx8HVQxnexxHfT3sKrHu8EijKuov2C1x7Ae
         cFqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706541314; x=1707146114;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CO6dSX8s++RLvcioBcV/aw8ivA28MIqmUT9bpWh0gEY=;
        b=TR3TXPToQcOtBTf2qoJ7OZoTpKNyET5ACaoVNDbui/Bfpi+SbjL0D6y5v+tC/1JB83
         CI9+/2p6ofVgFm24T/qV67lfbwIp38OKTeXuC6tEj+KIbeC+54rALXdsC3h7LWDlQJzU
         qNdUWh90obtf+CxDTaR+HS7nRA1OABP6jwFdV1+s8oK5W7QTXnGxuZB+IMNo3nJecfCb
         kBesR75IqzeL9hloFrr/IDlk52JWIkPlI4DhMQ+9SP8WSO8A+M00NMI3qYfMt0MlaGc1
         qOIfHXKt3UcwsF2IImXpCRWsy1Xn4s9x9AjxLsr/b5h+mT5yaQViNNFib8cA1YRbVg+O
         FLTw==
X-Gm-Message-State: AOJu0Yz0UTF7jpIF50oWSem+jFDz1QSMdJtr9JTvhj1lKpWwy5Y5UY5g
	FVuZHb8evWLPTnjJa2SM0qZbD/ZVu5HBm2sq//bD0vnYIkjN23Eo
X-Google-Smtp-Source: AGHT+IHXsIIT1SD0vDPsZ3ocIsVIuzizNU3Bw8BqoBf1EplTwSVUDvyH+/RwQBmb/dpHKLQYKw2niA==
X-Received: by 2002:adf:f044:0:b0:33a:eb10:e9e8 with SMTP id t4-20020adff044000000b0033aeb10e9e8mr2376477wro.43.1706541313828;
        Mon, 29 Jan 2024 07:15:13 -0800 (PST)
Received: from localhost.localdomain ([147.235.201.119])
        by smtp.gmail.com with ESMTPSA id r6-20020adfca86000000b0033aed7423e8sm3060353wrh.11.2024.01.29.07.15.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 07:15:13 -0800 (PST)
From: Tony Solomonik <tony.solomonik@gmail.com>
To: 
Cc: willy@infradead.org,
	axboe@kernel.dk,
	linux-fsdevel@vger.kernel.org,
	brauner@kernel.org,
	Tony Solomonik <tony.solomonik@gmail.com>
Subject: [PATCH v8 0/2] io_uring: add support for ftruncate
Date: Mon, 29 Jan 2024 17:15:05 +0200
Message-Id: <20240129151507.14885-1-tony.solomonik@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240124083301.8661-1-tony.solomonik@gmail.com>
References: <20240124083301.8661-1-tony.solomonik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds support for doing truncate through io_uring, eliminating
the need for applications to roll their own thread pool or offload
mechanism to be able to do non-blocking truncates.

Tony Solomonik (2):
  Add do_ftruncate that truncates a struct file
  io_uring: add support for ftruncate

 fs/internal.h                 |  1 +
 fs/open.c                     | 52 +++++++++++++++++++----------------
 include/uapi/linux/io_uring.h |  1 +
 io_uring/Makefile             |  2 +-
 io_uring/opdef.c              | 10 +++++++
 io_uring/truncate.c           | 48 ++++++++++++++++++++++++++++++++
 io_uring/truncate.h           |  4 +++
 7 files changed, 94 insertions(+), 24 deletions(-)
 create mode 100644 io_uring/truncate.c
 create mode 100644 io_uring/truncate.h


base-commit: d3fa86b1a7b4cdc4367acacea16b72e0a200b3d7
-- 
2.34.1


