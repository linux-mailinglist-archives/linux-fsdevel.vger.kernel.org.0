Return-Path: <linux-fsdevel+bounces-18581-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA9A28BA9E1
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2024 11:29:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76C57284586
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2024 09:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B0A314F13C;
	Fri,  3 May 2024 09:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="klHerOiJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C28D14A0B1;
	Fri,  3 May 2024 09:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714728551; cv=none; b=oG+sSP5SBZUTWgWKF+Id8yMjZMzrEPqwNApZEnFdHOHTbSAXNPwiOCb9ZzfxGWSbJOeBqAYW1TsTk5epiDqiy2yMBzSt2+iWW0EWUIT2t5Jl+ajRr/tpIaoiJaJOIwAVm88SRpi5vDEbDmdGfpWkH7khH0zT7XaRHYIoXI+WmBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714728551; c=relaxed/simple;
	bh=9mHY/g/RwNp8N2deb74gRi1TdCW+Iz+e+kCjmQrwbwE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=knZCim6BGIgn7F2ue/0rrhxOdCZ22RkVwJb45bQ28vl73SENGL9kjtdEiNfiPB9uzxAASRxTtCl9fsCkYKKCWS/cvNeDp8zRQkqnOM4yF/m+joo4r9Oiqld4SOhOEL7bFM+bivenwJcNBCfMOKZUDM+PrpQhETi+xArhcYx9GY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=klHerOiJ; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6f4496af4cdso658949b3a.0;
        Fri, 03 May 2024 02:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714728548; x=1715333348; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+7eTUo6HCimJIoCI/EZ9sqrcxu6m9Vj2eA2Iv6aCqfs=;
        b=klHerOiJYhsbXpHDeAszHyAUVSRI35FXW0gqTU8KjUcsObmMe+DOBVU3YaCuTYaSey
         p4jMLIAY1tsdTpmxiHuxdIbjpfP5HwkZwD5iN6KqsFpap3ZlwUouqRk/n/fB99qOl8yw
         AODv3rWRQwgtBsoUH/mWa5BboNuyz2iiolvBYHsyNcSS6vlmQbKXjHQZvWtQ3Xsx7NIE
         EpioLd6A8fp/3x62UE3UZjbj+4L9upOWMvpUo8M9Reo2Zea1CtjKSqVO3DOOX3rPlPXF
         O4JbIGqOUuf2FZ/zse6dHERHvqG27Q12U60qEHEh2ZEBGTdeZ06gK1HyVRkp6BaVmvrr
         nCFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714728548; x=1715333348;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+7eTUo6HCimJIoCI/EZ9sqrcxu6m9Vj2eA2Iv6aCqfs=;
        b=vcLA//HslrZMDgJZAUzyxesnsxrkCM6yiiziItXWMr+gZildjdH57KBLCasn+CuC0A
         g7/19w9+5/OZtN2FFdu46GNaEyuAVJZyKhIjhJBu+x37mlys7QX8u9x+iUUjIcPvSMi5
         /xu2Ix6Ji9F3WtgQXQ3j7El0zpW3x5AJmCuO+O6nBUmyeUrC6wpyuV9oDI48Jm/CJ8k3
         aMD4tXakqb/JnxUJKoLbtMrH5RXmVfuEim1ZKAqzQvXtfHedScsBP8SVGOteOV4bg+Bj
         /708MeqHogmFx81hxoW+px93soD/tHP9axii7pagOEtvAtByqOlsCMMys+6qux4r1hAM
         bNUA==
X-Gm-Message-State: AOJu0YzfnKS746cQsxtgaz1ZBMESsO8swC5aJll2S808L6QFznHXOiOI
	43YsfnNJc0ouKbhkeoKrAbD8YWRyHjt2I5fTMhJCq75se9Dx2uKfLzkhoA==
X-Google-Smtp-Source: AGHT+IFEwb1sNPcruL4LJiJFDy7A9Ztz0W0T2/+EU4vXLds+DEET0sE0nZTUy2IaNgfIT/ytYC3qnA==
X-Received: by 2002:a05:6a21:78a1:b0:1a3:df1d:deba with SMTP id bf33-20020a056a2178a100b001a3df1ddebamr2501668pzc.31.1714728548505;
        Fri, 03 May 2024 02:29:08 -0700 (PDT)
Received: from dw-tp.. ([171.76.87.126])
        by smtp.gmail.com with ESMTPSA id q5-20020a17090311c500b001e41ffb9de7sm2802168plh.28.2024.05.03.02.29.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 02:29:07 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linux-ext4@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	Jan Kara <jack@suse.cz>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCH] ext2: Remove LEGACY_DIRECT_IO dependency
Date: Fri,  3 May 2024 14:58:52 +0530
Message-ID: <f3303addc0b5cd7e5760beb2374b7e538a49d898.1714727887.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit fb5de4358e1a ("ext2: Move direct-io to use iomap"), converted
ext2 direct-io to iomap which killed the call to blockdev_direct_IO().
So let's remove LEGACY_DIRECT_IO config dependency from ext2 Kconfig.

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 fs/ext2/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/ext2/Kconfig b/fs/ext2/Kconfig
index d6cfb1849580..d5bce83ad905 100644
--- a/fs/ext2/Kconfig
+++ b/fs/ext2/Kconfig
@@ -3,7 +3,6 @@ config EXT2_FS
 	tristate "Second extended fs support (DEPRECATED)"
 	select BUFFER_HEAD
 	select FS_IOMAP
-	select LEGACY_DIRECT_IO
 	help
 	  Ext2 is a standard Linux file system for hard disks.

--
2.44.0


