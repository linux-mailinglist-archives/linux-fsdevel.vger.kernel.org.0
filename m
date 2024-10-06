Return-Path: <linux-fsdevel+bounces-31111-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A11C8991D2A
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Oct 2024 10:24:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49F911F21D4E
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Oct 2024 08:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4F50170A01;
	Sun,  6 Oct 2024 08:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hqgzbLw1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A46E1155C97;
	Sun,  6 Oct 2024 08:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728203047; cv=none; b=i3q0T/XdoSkRConnp8+78UsSCZhvx3DFzqDRLuX25VLFdgmwJ3yC7iIB1oaLSoO7u/Si/oE46ehf8kTkVAGrYBoEnDZrTwYcqMEbJtql8BTbRRrl6Qy2p/FFp9/jDoGHnmQRN8YGGB1J9mTgmEbgdGnJqYmuN6mbgL9/2sxHbrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728203047; c=relaxed/simple;
	bh=NKSwy5YTRyxPw3pWwkRGoeyy+OVeH9BRUPZnvUHEMmg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LUHs0vRlwEJQ6yXNCB93A0WYlxPxgZtcxOdiuWU1F0XC24rhZP6WAIbDkRiPGcmkNdpA9v6mxtU0UFpgLqqgdPV8Cvptl9cJRWfF/a8GmeFpoz+Nd5NYPjE11zp7wNiiBKWL15nlHCIHWXk0sryUZS7LpdveLapjFwmug7iIwFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hqgzbLw1; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a993f6916daso121954766b.1;
        Sun, 06 Oct 2024 01:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728203044; x=1728807844; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MtZ2oChEhuCDlTxBTHZ/VN7SRGbs0CbHT4jD+XOBEWc=;
        b=hqgzbLw1oFzFOfP0zff5wG4kYd+bBAWHaQO1F9IdG/+ysPonw02L3Pl5F7UMpLprll
         bqFt+RYkcz/2V1GjOoKWbY5Gne/jqdmUWt+TlDOYqk0C2QEK+5RF5OB783NgUr7Cdn0k
         Gjz3X4L4h8SLA4AD5MND3TEuewCU3GeufIf8tehaLQWxQQiGqxpSif5IDwbKe/VtZZhl
         zfxnvHZWq47TjHKFeoyN5MAOmRj7hFVl3fvQCz9UhIVWPR2ytrHVmlra21qBS1WCXZgZ
         +zdU6UWZIOGZkOG6r+oiz6r4zOwXw0PMZBHTKW/nz46O/RDL6z6BTJjWtBaFAPvhE0hp
         hITg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728203044; x=1728807844;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MtZ2oChEhuCDlTxBTHZ/VN7SRGbs0CbHT4jD+XOBEWc=;
        b=KU6sBoo/m/eRd3qMYpkxWxCSIpLTx6msbx+Dg2388d92oLn00rzKlxdAHTLbl6HDrO
         uNVx16RYPOU6NOQQ6VaDZiG+st10r9Vj4qmtBuwK6J0MDF/dY3TAvq8CWXcShGIbH358
         rqd5qs860bKfgEAfcmJY/oHbMkQYF1B9Ie7STJkK1/Goovc3WgMuWHk+DDc0MOMyaSNB
         kqd78Cn+Kb/kmK/JuY/jC3u405/BFWdtr1gTG8yhrAb9UxcUrSNvg1+rj6EhWBXkzp4k
         L2+U08E9S6PDvQBKOjE2Df6kv+/pgQDvtXa0f+SSwd5bxXctFu4EFZ0/glLhNWclPoVF
         4aoQ==
X-Forwarded-Encrypted: i=1; AJvYcCVim5iGqhCdBrbJOnvOxstPqgWm64OsNsBsKP3RqchrFnwoclSVeUnjAv5a6z9Yb/scRjHuoSQtm3XNYF1yBA==@vger.kernel.org, AJvYcCWSNXBPXXBZiH2eT2CYsWrup+SmxjOrWyRzHHblBaElFyOcmmjB2GFC0VnwBI+K7HnFaRdZXh0yVk8O+Bo/@vger.kernel.org
X-Gm-Message-State: AOJu0YxeWsmTT+EP2WhQ54OLU7m3FBM3/DW0JfsfDaGheiJxj5DMgyrE
	sG+0tO7PzpnyE/bVMj4ZOZ5XG/wC7S52WCytvqVXWp5Gr9watLLP
X-Google-Smtp-Source: AGHT+IH0IgS6HavzdYGrraraghSeXVJX3Y+MEbAX5jai1vGi5hMhmp3e2rILRzMmqHvOQY2rN2DUqw==
X-Received: by 2002:a17:906:f590:b0:a99:4275:baf4 with SMTP id a640c23a62f3a-a994275dec8mr336411166b.18.1728203043633;
        Sun, 06 Oct 2024 01:24:03 -0700 (PDT)
Received: from amir-ThinkPad-T480.arnhem.chello.nl (92-109-99-123.cable.dynamic.v4.ziggo.nl. [92.109.99.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a993fdd2202sm153215766b.55.2024.10.06.01.24.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Oct 2024 01:24:02 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Miklos Szeredi <miklos@szeredi.hu>,
	Al Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-unionfs@vger.kernel.org
Subject: [PATCH v2 0/4] Stash overlay real upper file in backing_file
Date: Sun,  6 Oct 2024 10:23:55 +0200
Message-Id: <20241006082359.263755-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

This is v2 of the code to avoid temporary backing file opens in
overlayfs, taking into account Al's comments on v1 [1].

Miklos,

The implementation of ovl_real_file_path() helper is roughly based on
ovl_real_dir_file().

do you see any problems with this approach or any races not handled?
Note that I did have a logical bug in v1 (always choosing the stashed
upperfile if it exists), so there may be more.

Thanks,
Amir.

Changes since v1:
- Use helpers ovl_real_file() and ovl_upper_file() to express that
  ovl_real_file() cannot return NULL
- Fix readability and bug is code to select and store stashed upperfile

[1] https://lore.kernel.org/linux-fsdevel/20241004102342.179434-1-amir73il@gmail.com/

Amir Goldstein (4):
  ovl: do not open non-data lower file for fsync
  ovl: stash upper real file in backing_file struct
  ovl: convert ovl_real_fdget_path() callers to ovl_real_file_path()
  ovl: convert ovl_real_fdget() callers to ovl_real_file()

 fs/file_table.c     |   7 ++
 fs/internal.h       |   6 +
 fs/overlayfs/file.c | 288 ++++++++++++++++++++++++++------------------
 3 files changed, 182 insertions(+), 119 deletions(-)

-- 
2.34.1


