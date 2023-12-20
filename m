Return-Path: <linux-fsdevel+bounces-6542-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 812EA819732
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Dec 2023 04:35:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20D301F265E0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Dec 2023 03:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0A538F59;
	Wed, 20 Dec 2023 03:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DSN2oyqK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E55C98BF9;
	Wed, 20 Dec 2023 03:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-40c38e292c8so1581375e9.0;
        Tue, 19 Dec 2023 19:35:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703043310; x=1703648110; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5McdNYUfS43oFu24jQBDWrkjliOXRVBsUJKO5WYO7k4=;
        b=DSN2oyqKdM/eBiionDaHP82Z8q/P6bi0oP9QQmVUYIQwat6agSr7eL79CsutJf2/4s
         TaROn11mtuX5pFwZIPZiRfIQKuo4RlXAyWtb3e6giSVmmCwe62/5/34WQQ4qfqlD/sNO
         RBZaO+ldElMA6y4pqPgPl/mDRs0G9AkfYNYrpPr4EHycG7eRpAkV/EKCbh+Whu9E0vB9
         ITS+9Vd80DAvCeT7oCVfbz2FyyUitYbepELXmMCTEgNdyVy5JruGj9p4UzryWk31OuOl
         2ZHgusvSiMEkN5nzj2lyb4pCs/5NnEtpeGDH0S+rxZg90LBPijxSPQf38BNUyOtazuDT
         8wuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703043310; x=1703648110;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5McdNYUfS43oFu24jQBDWrkjliOXRVBsUJKO5WYO7k4=;
        b=K9qYj9XBL4Vbv0dOZVQkyQ7Rp9ApheTgzLNoUV21SfK+GPz2hlD7p/LaJpBdoi7jPq
         76oKBN3BJIpHgXrSAJlzMe6kBZpMQTPqtfjZu6EcJsAvwV+T2WZMcN9hy1OLPORcoTRT
         8v57X73wkUV2Bcxd50lT3LrCZk/1Lp8Gk3nILiWOSpNF1wLQiWuprUINcZPqmVf3ZK2h
         lWV/jUjvNVKQ2y0/7+xgpMdPGYwF3IW7Xn+ScKXHmyxacRhPIgZlCewJMljb+UPa91Ug
         jBPCN4YdrtzyX8f7j4bbEQd0X3rTWe/ml2eK8ryCn6LYMfnHyX9tIJeAH8kRjWonDDT9
         qQ4g==
X-Gm-Message-State: AOJu0Yxi2KImpQ/tBJbDgdx3G15/lozIy+tNK86buCEtql+lhBYzYw5C
	LkR+BvLPmzfbH/ljBgh5GGAeLc8mZpo=
X-Google-Smtp-Source: AGHT+IGvf4RzaroOE+YYYMFYLzZbWiyVYW+4FpN0Ajt1G5/AOZ3GwYPxefZXjUb6vQSx0A04WHsAzg==
X-Received: by 2002:a05:600c:6988:b0:40c:29a1:5559 with SMTP id fp8-20020a05600c698800b0040c29a15559mr1007613wmb.67.1703043309918;
        Tue, 19 Dec 2023 19:35:09 -0800 (PST)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id f17-20020a05600c4e9100b0040c310abc4bsm5367543wmq.43.2023.12.19.19.35.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 19:35:09 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>,
	Christian Brauner <brauner@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-unionfs@vger.kernel.org
Subject: [GIT PULL] overlayfs fixes for 6.7-rc7
Date: Wed, 20 Dec 2023 05:35:05 +0200
Message-Id: <20231220033505.735262-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

Please pull an overlayfs fix for a regression from 6.7-rc1.

This branch has been sitting in linux-next for a few days and
it has gone through the usual overlayfs test routines.

The branch merges cleanly with master branch of the moment.

Thanks,
Amir.

----------------------------------------------------------------
The following changes since commit 98b1cc82c4affc16f5598d4fa14b1858671b2263:

  Linux 6.7-rc2 (2023-11-19 15:02:14 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/overlayfs/vfs.git ovl-fixes-6.7-rc7

for you to fetch changes up to 413ba91089c74207313b315e04cf381ffb5b20e4:

  ovl: fix dentry reference leak after changes to underlying layers (2023-12-17 13:33:46 +0200)

----------------------------------------------------------------
overlayfs fixes for 6.7-rc7

----------------------------------------------------------------
Amir Goldstein (1):
      ovl: fix dentry reference leak after changes to underlying layers

 fs/overlayfs/copy_up.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

