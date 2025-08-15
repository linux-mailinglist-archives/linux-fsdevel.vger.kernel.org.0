Return-Path: <linux-fsdevel+bounces-58048-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CEB3EB285C9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Aug 2025 20:25:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 886A3B04493
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Aug 2025 18:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CF5F25A331;
	Fri, 15 Aug 2025 18:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OUokAUE9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295CA3176FD
	for <linux-fsdevel@vger.kernel.org>; Fri, 15 Aug 2025 18:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755282349; cv=none; b=nRUNqml025PPB0fM/6JYlaat+pcfzYiqK8xxo0BpZgAgwArhxdBuc566mZ+h5e9eCrG0SZDKUNN5Tay/QM2qxC9jcCLxHT+XJGlCU1Ea+eLKod5ccHkxxykRWTC8ksjX3xyE337ArtQmMWdPkEWmRxl08K3T/0dlrND5Xa4xT38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755282349; c=relaxed/simple;
	bh=jGtbaA3DgILnezLg+ZtwIkAL1Ixe263nl3i9zsNJKiU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cRCr0fez71gZIxBdVimVn6d8TzoT6822yp0IKpMViCRtL6gA6eK/s2Cm/Nu0Ypa91YvkjR8swONgBX87Qq+EQCSg1AgU6zazAt+jv3FXijtx8j1FG5FLBfGsj3pXv7OBAHE4yaxwgtNsEYFrsW1xVTPbsgXcRotaPmVSPFi0Xso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OUokAUE9; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b4716fbc443so1644143a12.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 Aug 2025 11:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755282347; x=1755887147; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=r7D2ey404K49F3EuTbvYtEkp+AYGINbqQ6tnOUVI5NY=;
        b=OUokAUE9uwQiOs9NP2dSfW44HwTvHZsr2Orp6XUKz2fi3unhyul5ulfS8jBYSaXyyi
         at/UXgwB1fY75gQ7JW7zemMxHFcOTZWnKc75icQX8gjWR+MSuzM30nJ4SI4X5cJKaYh1
         FpoaFLcB2+tZlFaIsh4TAlqFgvohYzS/I3024wWBJl1dxevSHkbWIvxugL3jYcK+V77M
         8rI93Sl8D/nDn/qEQCrBOwGS1F7VhtOwHnJJjUht4Nt8Ifmn+7IoSX1xWwJBFMSPpmIF
         OE/hKup9vq6vqVYcNyu9++tWZZDXCO0zaWwoQDKdU4Mp3Tfl/vG0UIhvDohDMav92wm0
         7X+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755282347; x=1755887147;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r7D2ey404K49F3EuTbvYtEkp+AYGINbqQ6tnOUVI5NY=;
        b=V+VVuBrjHZ6ZlbuVOiezlN+92Lmm6arWhO0YoY1diSD859c/wMaxDtTLl20EYgmYOp
         lkgWolG+umihZUDlM2hfviUgNOEhnDsqoHCrxXec/76ibzlFJx53OPrW0PxNvhHgyxg8
         d57KEDKBL2TZMrfqWEBYWSxAd2cz8WggF0xFGsBcv05Z7ma+XuL+bC2t5AfSXdG2q4JV
         E0ArBmxKwZn5EzcBvGeuk8hQbeOTlDUftfcG0KL6Ku2HcIeaKKGURFuQzh4zub8Il3Uj
         nnyhfVo2nv1M8yGp73u5HFh/WayH5zbsiOT5WDbXBL2pIQnmc4owBMKRAg2T6X8gTD3s
         CUqQ==
X-Forwarded-Encrypted: i=1; AJvYcCWiGd1Ioemp16By6pmORjFwpmO8rF5k4DQohh252s2iuvE9qA7aQVbUUNbIzmZLxc9QVjobB9KVs89a3Lok@vger.kernel.org
X-Gm-Message-State: AOJu0YyN3wvGKfWGeQ7+djwTny3fMPBFTcWuRMRgFHDIw7V8M0A3WtL0
	2BeLzOSXFwY9hTY0vFMlZTu1XWijsYJFdA4xtNLDBhHVsYR9E0MSYRZIUPk7Lw==
X-Gm-Gg: ASbGncuWY9+R52/ku73uhInYGoqR6tqq9VcqsTAlU843D+tcTXOz/xaLY0njcSW1jYU
	NnRGfcrg8OBeYiVRQAVnxy/AFVzMBo5U+tXVvzZAVV9MjSqmdPUjxgImTIQtiWWA4rA59ayTvL7
	XoBpsOr0ZaxVzDYiprREL7olE9/j7hWJqU2bupQjgN3M/eBde6oeZ7oPs8qDP6m41AoFlnlUwNl
	Bmlgnq+pQgbz9twJFvzd9BjgWtXx3QSbYcZqY3QefwZXYt51fcs6opP54F5jEyaoo3rUJ2NtAb8
	nFTnIHriIP8SlL3gxBOoIwnj++Dc7+dWZX9/eRuOqWPMfzTgkwh4vN4JsyQ1O4B/QtBjijqmZkq
	laUDZblgTa3zO+n2qZK6tVPOFk8E=
X-Google-Smtp-Source: AGHT+IFiVuocfCawmJtdIGddAhPrl+GyptzkTWMuUqK0rcRvyuBvcfbvSp7Z/4OyPPaXEZD4gKTvtg==
X-Received: by 2002:a17:90b:35cb:b0:312:e731:5a6b with SMTP id 98e67ed59e1d1-32342122901mr4016500a91.32.1755282347285;
        Fri, 15 Aug 2025 11:25:47 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:a::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3233119263bsm4917522a91.33.2025.08.15.11.25.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 11:25:47 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: brauner@kernel.org
Cc: miklos@szeredi.hu,
	djwong@kernel.org,
	linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH v3 0/2] fuse: inode blocksize fixes for iomap integration
Date: Fri, 15 Aug 2025 11:25:37 -0700
Message-ID: <20250815182539.556868-1-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These 2 patches are fixes for inode blocksize usage in fuse.
The first is neededed to maintain current stat() behavior for clients in the
case where fuse uses cached values for stat, and the second is needed for
fuseblk filesystems as a workaround until fuse implements iomap for reads.

These patches are on top of Christian's vfs.fixes tree.

Thanks,
Joanne

Changelog
v2: https://lore.kernel.org/linux-fsdevel/20250813223521.734817-1-joannelkoong@gmail.com/
v2 -> v3:
- use u8 instead of unsigned char for blkbits type (Darrick)

v1: https://lore.kernel.org/linux-fsdevel/20250812214614.2674485-1-joannelkoong@gmail.com/
v1 -> v2:
- fix spacing to avoid overly long line
- add ctx->blksize check

Joanne Koong (2):
  fuse: reflect cached blocksize if blocksize was changed
  fuse: fix fuseblk i_blkbits for iomap partial writes

 fs/fuse/dir.c    |  3 ++-
 fs/fuse/fuse_i.h | 14 ++++++++++++++
 fs/fuse/inode.c  | 16 ++++++++++++++++
 3 files changed, 32 insertions(+), 1 deletion(-)

-- 
2.47.3


