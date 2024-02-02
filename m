Return-Path: <linux-fsdevel+bounces-10010-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 964BA847005
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 13:17:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D996288B19
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 12:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB0EB140788;
	Fri,  2 Feb 2024 12:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dJrQ1SYa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F16141998
	for <linux-fsdevel@vger.kernel.org>; Fri,  2 Feb 2024 12:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706876251; cv=none; b=LNTFz7rdA88frjcL99qRJHnWhcAKCPxLl2eBbzOvzGKQibQd/Qh63wFSruMqefQAtXIs7V1Q6BtMiDerjNVF9cyCj1ufyOOevjuH8hjRgYaZqGtJAXFtN3fRqPwj4Wg+ayIzQjUuFkK4hsNxcPs/xIHVUQs24vgp35gRW1WqSjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706876251; c=relaxed/simple;
	bh=pTKkt4HDy5cHafjWqvRLIghyQiaeiOTEEWK32KvorGc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=alJD4j68UqA1nK6m2PaI80V7ZGQAvflDk/tSzoy/diuDWCP4Y1zYUvjYbmEBjko5VP8fZ1fcd3n+zTaJKp2+1HKWn14/iMF4X7s85URXhQ4+RwdllKB2GqIEcYo3OoCW/YoZ08pfC3RoWTbQYcp8QVefItSnCYwzgBqd2o+uYOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dJrQ1SYa; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-40e80046246so4030835e9.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 02 Feb 2024 04:17:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706876248; x=1707481048; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kdeDSOAKJ5pfj4o7Pq9ratOpidbjA9SWUn8FNbD+huE=;
        b=dJrQ1SYa0vs26G/+1Ol8gOeTgPXx0peJWi6ZVB/Vau0ChWt1LmxYlefoux+LZNWtO8
         7Jv/sNbH3+tMFLyXr7QD4vkjlrUtmz996myXDzlAhTJKjpIVWslnLuwOEOcDpVMSBgKe
         S7+UG2OCyFBnb+D08W4ctuk/E1oLThZ1CFTLCWvTopMJAmIMczAyy57xKmjnCRE1bRo4
         Pk7J87mjST6JvfQ8ttwuj2nKnjVJVEVYWhymupslcHSwsCmMnjsg2DkPfI8H69Wdx+ht
         ao+g4GIKhUU/1jlHWwNK1lhLusXtdUHQWxc3J9Ljn5tsHF6qZvD31E+frAabyY8/z5WL
         84yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706876248; x=1707481048;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kdeDSOAKJ5pfj4o7Pq9ratOpidbjA9SWUn8FNbD+huE=;
        b=F8c0AJkiJ6sgcS0MeKR0z8gBuJoYt5j68P2cLZ/Qsp8Kz8cVcv3OW+IuVflRxHgGHs
         GqgoSzDYugk++YRCm1yv6qoZnoCbgJFclccjxp+rGB4G1Fq2XwGBNk1zFckyZMLMpyfb
         LQ9A0/IquZLfE6m+OwOGwIsElzhHgURpmL6czbhK1q4ATM8vgFtOiyNHgkSclAbn5XcO
         JBO8NOE1uuQhg3dnhMmfgNTpFs7R5hCkI5IfnpjE3E8kGlrVRoGwFfthrcbQzhcvQ64I
         J3i6sbyKUKON9HKJ5gKTTfo1uhuRj5m1qoozSRS+0SckXZyeYEkuzwOv3o7edtdveTxL
         Gmhg==
X-Gm-Message-State: AOJu0YzC/kQ98LlMQ0zOZlksyGeH+sw+z5SBWM58ZTTm8sE9YP0QDvOR
	vZHtErOaNuk+Mo27YSlEtBf7aEXp9624Bm5POiFdUjiILOmBB9Iv
X-Google-Smtp-Source: AGHT+IF+MQZDhcQgMZpUqVDmemfWmpz5Ugt+hUvllzBgd4lxb4p8KKlJVBGOOO+A3nGPU+zN8ZEC/w==
X-Received: by 2002:a05:600c:3552:b0:40e:7990:6b5 with SMTP id i18-20020a05600c355200b0040e799006b5mr1534604wmq.18.1706876247655;
        Fri, 02 Feb 2024 04:17:27 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUXtZy5xuUKFTA/WfGuVFSGNc15YVSVKhKCNqe8Zpb91VduRmlMIGQsIfJsMRnnpjey9fIOeI1ZlqAR+TISkecnbYoPEjUkjP6x9pb9NGGuO/T5S0y64dRlyHE9eYOl4phEMM88J8kTnanJQk8xZa0jW0lu2DVwnaWy5uQPp6hbb1+SapMKcPkhO2dC3g==
Received: from localhost.localdomain ([147.235.201.119])
        by smtp.gmail.com with ESMTPSA id s15-20020a05600c45cf00b0040e3635ca65sm7364736wmo.2.2024.02.02.04.17.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 04:17:27 -0800 (PST)
From: Tony Solomonik <tony.solomonik@gmail.com>
To: 
Cc: willy@infradead.org,
	axboe@kernel.dk,
	linux-fsdevel@vger.kernel.org,
	brauner@kernel.org,
	Tony Solomonik <tony.solomonik@gmail.com>
Subject: [PATCH v9 0/2] io_uring: add support for ftruncate
Date: Fri,  2 Feb 2024 14:17:22 +0200
Message-Id: <20240202121724.17461-1-tony.solomonik@gmail.com>
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
 fs/open.c                     | 53 ++++++++++++++++++-----------------
 include/uapi/linux/io_uring.h |  1 +
 io_uring/Makefile             |  2 +-
 io_uring/opdef.c              | 10 +++++++
 io_uring/truncate.c           | 48 +++++++++++++++++++++++++++++++
 io_uring/truncate.h           |  4 +++
 7 files changed, 93 insertions(+), 26 deletions(-)
 create mode 100644 io_uring/truncate.c
 create mode 100644 io_uring/truncate.h


base-commit: d3fa86b1a7b4cdc4367acacea16b72e0a200b3d7
-- 
2.34.1


