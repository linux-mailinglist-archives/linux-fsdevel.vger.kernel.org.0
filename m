Return-Path: <linux-fsdevel+bounces-31184-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A35B7992EDC
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 16:20:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 572D51F2304B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 14:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87A731D8DED;
	Mon,  7 Oct 2024 14:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LJq5AwvF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5763C1D88C4;
	Mon,  7 Oct 2024 14:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728310774; cv=none; b=uubrVuUszFz9C7Gq+C3I8OaR7cq9FcVlfF9v7PoBnSe3hFdwVQa4KATVhEujhatEPnEBXSlqnzQ9KHkCIHcdlaAx0U7HRdwZntYEXVjDSZD2h9LBnfJFINrhwmHP/ONIMIarHYmlyReNUSftqtHj2ft77t4drTiG668n66kBrGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728310774; c=relaxed/simple;
	bh=Yr0VcNa3d31VK7J36DITyVxaRn/g63LODRlqdbb7i5Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=B/gYPoUTKEP15hxCIoLgdIXQkMIs8EjC7e6wpq4dAYPHsEL5lMzfWE84tK898idGgsPsq8BCCcyMxhxBXFbf1U41/LQtX7y4WH0gMuTEGx++1Gp+NtUIRLEeePCY6ishNzgxuz0Ajpm+HZ4m0WZXr8LeOuh+D3yIAyCESNfJGC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LJq5AwvF; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-37cd5016d98so3421697f8f.1;
        Mon, 07 Oct 2024 07:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728310770; x=1728915570; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yb8x/+TkEKTW+zsSEc28HlYcogsCJqJhFTDap5pMfcI=;
        b=LJq5AwvF+N7qqya+Q+l1lkhaK3BMQXSsOE0LGyGD6U0hGHhSn7/cJ+r8eEeBoOeB1t
         bPdtkQttcESLiyqwwU4nXEI9OAXmdy8KEdg6/Jomd5yR7GmCHC2ieB6lhfwrlw/DMzTj
         9AQ8wBZWqxzise8ZOlEsBynPw2NGbwArH02iIWEwwTPS4ltfKpvUHevcVuO1OUA7zMhJ
         hax+BrKN7ImrPVyIBoXOWr4cqAtkm1ODhGfaCUq3vejKswp3dvIhhMy+bmkB5L7xnJGR
         qpwYwK7qWC05vmb1KkyyFuekckXhcz7E5Fj1T0cRH30A6EFjbXsypzyOsSumH8XiXePR
         oPBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728310770; x=1728915570;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yb8x/+TkEKTW+zsSEc28HlYcogsCJqJhFTDap5pMfcI=;
        b=mspV/2hmS4VFLipLaEagc1Im0n1971MEzQI/Yo8uPdiffwdvNe8CWyaeT8w+cycXuw
         j0R4hFs1kkkrli68Og2rL6quy2zCE5eY6NpaF6b+4sb2/EFBA3K9o/OUQt9rN7/Pfiy6
         pttt5KIiEErqw/XXb7dz3ozjfCI8BQYpezJU6/m62LwPRW36gfI9PZ2CXZAcg6QaxJfu
         cz24VliBk5O7+BWEEGbskUzy4lyEcsEZuXYbmkzl0e9YO6iLiSK0VMCl++BOQL5L4pDO
         fblc/VB2V9c4qrCFr/KvVtTiBvEHF/zenmLp9xRoJBwYoZPj9zNTUCOEAkX88Q3V0Nq6
         Rt7Q==
X-Forwarded-Encrypted: i=1; AJvYcCUop5lFy3pYXaWkgfi51rXJEcgqECyiCGS/mi30K6Kx0yOEFCYDj2FUNZEBfecbNDHs1RlLdBd4GV6tyLJUKQ==@vger.kernel.org, AJvYcCXzJqYBgZAb9r8F30nzvLEf70JS+1lvlEYBBUj5m95t9ocPUaAAj2btySUhqDysTYRh/NfBjn3yRV846BUd@vger.kernel.org
X-Gm-Message-State: AOJu0Yxp+08HTdb4IHMB88QA/obXbVVOZv/jeq/SnG4h4/hok/LJhnYp
	TzumYrkU2htu6QVBOrAWjMr+70lzhGIgKv27tnQd+AZv0JnqKxFkELf74dBo
X-Google-Smtp-Source: AGHT+IHDyZ2Nd4dRZH/5ILEyuOz/xF/YtmYOlr2675RI+bJVMQ3Tmw6T1jXyzLA4afjDyeCnC2zpnw==
X-Received: by 2002:a5d:5307:0:b0:378:fd4a:b9c7 with SMTP id ffacd0b85a97d-37d0e8e15d2mr6927035f8f.58.1728310769138;
        Mon, 07 Oct 2024 07:19:29 -0700 (PDT)
Received: from amir-ThinkPad-T480.arnhem.chello.nl (92-109-99-123.cable.dynamic.v4.ziggo.nl. [92.109.99.123])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d16970520sm5829396f8f.96.2024.10.07.07.19.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 07:19:28 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Miklos Szeredi <miklos@szeredi.hu>,
	Al Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-unionfs@vger.kernel.org
Subject: [PATCH v3 0/5] Store overlay real upper file in ovl_file
Date: Mon,  7 Oct 2024 16:19:20 +0200
Message-Id: <20241007141925.327055-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

This is v3 of the code to avoid temporary backing file opens in
overlayfs, taking into account Al's and Miklos' comments on v2 [1].

If no further comments, this is going for overlayfs-next.

Thanks,
Amir.

Changes since v2:
- Simplifications to flow (Al)
- Loose backing_file stash in favor of ovl_file (Miklos)

Changes since v1:
- Use helpers ovl_real_file() and ovl_upper_file() to express that
  ovl_real_file() cannot return NULL
- Fix readability and bug is code to select and store stashed upperfile

[1] https://lore.kernel.org/linux-unionfs/20241006082359.263755-1-amir73il@gmail.com/

Amir Goldstein (5):
  ovl: do not open non-data lower file for fsync
  ovl: allocate a container struct ovl_file for ovl private context
  ovl: store upper real file in ovl_file struct
  ovl: convert ovl_real_fdget_path() callers to ovl_real_file_path()
  ovl: convert ovl_real_fdget() callers to ovl_real_file()

 fs/overlayfs/file.c | 301 +++++++++++++++++++++++++-------------------
 1 file changed, 173 insertions(+), 128 deletions(-)

-- 
2.34.1


