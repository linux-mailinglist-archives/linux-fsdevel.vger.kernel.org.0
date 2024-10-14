Return-Path: <linux-fsdevel+bounces-31917-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 890F999D777
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Oct 2024 21:29:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35ABA1F23CC0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Oct 2024 19:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F5701CEEAA;
	Mon, 14 Oct 2024 19:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YLrllc0f"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7576A1CDFDE
	for <linux-fsdevel@vger.kernel.org>; Mon, 14 Oct 2024 19:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728934085; cv=none; b=sTMM1RgabyamX4+BVj0tEhBhQcjXP5NlCOmBd8Xaj71/Zfgn3Ie5iJ9Vo1yeHBkySOwJvjpgT3bR+lgu2K3G82Kl4/QHq8tzIZnJEVlsLc5/fCxkNjmK5Qioq0ljp1JRzpBwzaugGG/97fobU9Raz+UaZPD4KpIgx727QdLKOhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728934085; c=relaxed/simple;
	bh=0LnQhNZTIgYFvJrfaEghFPghAChVcw6NyGNBMsWk8Y4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MtZ4p2mW86nsGyuUzp8LUBvQri0Cn2cf0dIlLpEXb+r00nwbHL63X1LR9KGBhlSvfWeEJ4u+sf1flSSZoDjtxKh9dW6yrXwssauT4LbZ0Nq8HWbiqnHTgAA97V7S8BzDztX7lW0L8aZVjNkQi3eokhBiASDy0sZzBpY1eWE8q30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YLrllc0f; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-37d51055097so2691987f8f.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Oct 2024 12:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728934083; x=1729538883; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=El+Oir1dCDEahPI/4D66nWpBD6UrhMcN0q77yC/Ouhc=;
        b=YLrllc0f2Tyi7lEj9F9pSeqB5QVlYHbA5JKVIY+qsLWpv6dTGG+wbn2jsikKWqme2y
         RCMfa5PH3D81QAjonMHFAHbt1f85vpu4MAbrMsB3ZCg2dOIMkdIIQTKmHCrvedzhfFxr
         rkhgzIf4fH6pvj4griJWBBHHNOOO4Xmhjt9nbtzMSAKas5XMDBVbbuO560jujTPaNLqJ
         pPjpknLNiqNOM64o0aC/PyxmZ/OOH0suMTK2Spod02QW9n19Ywydjm4DRTcM1nYl/l9U
         LWWZlp+Z4+cLQsc/S9pKKBRoAIRASlEG79lXIDKt/8EsXggyZfKdiv1Y6NdPQKsr7Ck7
         a3Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728934083; x=1729538883;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=El+Oir1dCDEahPI/4D66nWpBD6UrhMcN0q77yC/Ouhc=;
        b=Ak0Sw+XbeISgASFDdtUHkMyFHcHVZz67TsJqd+UI5X2JTMxU9yceizU2GKbKGNgsSa
         YThtw32UNuDYooQshElXqDDCz1S9Ff9fc6lAHqCAL9zKbtycmGOgWZMCbwaADZtFSEHz
         skHos4BP8Q+h1mqPZNYLSSU6zFHN9LQcYJJ/+ZYMxjMozbKxu3qcGB+QdLHZwtLL+7FT
         bdePmN3dbUlzQKO4sUxkkc5pvnoGUO3hGrDjdhi8J9JRn8VvoKckvAB6RssDdBLbDiR2
         ZOF08ixsxPnPiXI4H93vOFhHK3LNB8bDbjpZLld0XHkNa1J1kPVpv/e3Sf8YNPCX6PVw
         8RHg==
X-Forwarded-Encrypted: i=1; AJvYcCVfjCqER1StbmYOmQv8xJhY79bcZ3+cI6wdulPhB0NIDexmLg3GegQ/B52oegFta7ek2W5GU+K0+QSmBBa6@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9jq7G6qL+QXWTPOr4Ff6b/juTgTDJP8pGoCBFp8JYEinkqWo2
	Jb1plbC7cegGAraY3XuGdItRg2Um7mkqPamGWKhqPllJFpfMWympLR5nXqjCY3k=
X-Google-Smtp-Source: AGHT+IH4kNqW4O4sjfdPlc2WNh5wzbtqB0CURkU7AqtDjDBgvDOVkrrKbiEJxutHm2yKtUcJRzw+9A==
X-Received: by 2002:a05:6000:10c1:b0:37d:4a68:61a1 with SMTP id ffacd0b85a97d-37d601cd19amr6438112f8f.56.1728934082534;
        Mon, 14 Oct 2024 12:28:02 -0700 (PDT)
Received: from amir-ThinkPad-T480.arnhem.chello.nl (92-109-99-123.cable.dynamic.v4.ziggo.nl. [92.109.99.123])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b79f9d9sm12162673f8f.77.2024.10.14.12.28.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 12:28:02 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Bernd Schubert <bernd.schubert@fastmail.fm>,
	yangyun <yangyun50@huawei.com>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 0/2] Fix regression in libfuse test_copy_file_range()
Date: Mon, 14 Oct 2024 21:27:57 +0200
Message-Id: <20241014192759.863031-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Miklos,

I figured it was best to split the backing_file interface change from
the fix, but both changes should be targetting stable.

Thanks,
Amir.

Changes since v1:
- Change end_write() callback arguments
- Use pos argument to extend i_size instead of using backing inode size

Amir Goldstein (2):
  fs: pass offset and result to backing_file end_write() callback
  fuse: update inode size after extending passthrough write

 fs/backing-file.c            | 8 ++++----
 fs/fuse/passthrough.c        | 8 ++++----
 fs/overlayfs/file.c          | 9 +++++++--
 include/linux/backing-file.h | 2 +-
 4 files changed, 16 insertions(+), 11 deletions(-)

-- 
2.34.1


