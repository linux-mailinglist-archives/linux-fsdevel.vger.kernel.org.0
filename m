Return-Path: <linux-fsdevel+bounces-27234-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ACFB95FAB2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 22:33:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57B621F21824
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 20:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C1CF13B588;
	Mon, 26 Aug 2024 20:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T581WEhI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01EAC881E
	for <linux-fsdevel@vger.kernel.org>; Mon, 26 Aug 2024 20:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724704392; cv=none; b=m4zFFJqlYUNZDp8RhjqnH+BYNeql9QeVKCnVT9BubyqiEMoIzVP2Zp5fqlwVpBLUWGyn+eljeqKPyJhoHbRoxxB0VIJaFiSTet8OdncUdhXFAZ09zGtRRiPsPm0r3i6VY270sFr5id0Cc3Iy0FQ1KsXrlUPcnp89dvvwbMPlZxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724704392; c=relaxed/simple;
	bh=9YU9m9iFLAntykrr7Ix0THCqWRP3UqfIFg9V9METD60=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=i2+j/PLpPXUvoiKe0AoZb4scuVmoqRm10qe6XpHfXnJwH+z8g72ZwSgf+zuuuQbIQhiElE45Hl400MxlG/MZln6lOHN4HoET+xAbYO/DKrtvhmzkSbReDkb9qMj+WfaNE+FtZtwEgXyX3Z6BszohJOX118es5o66i5D19jAu3TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T581WEhI; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6c0ac97232bso39232267b3.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Aug 2024 13:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724704389; x=1725309189; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+qZYYGpbLD3uPOiq52eAf17aMBl/U3t+WM6sWGoM08U=;
        b=T581WEhIQLXJy3AfeKkPlTkNtOZNgI/4GQbFOTLvY8/flgYd1U1W81NrkDQuial0iz
         gXIKgmf1yZPm4bjbJmYOwPjI+Nzu/Zg1lGg2bWUWO9LBhQbTm0Hqnj7POqMU4NNH9xdI
         cp6dtgQP8j22jn/znelqkK5FJFCXlz9RZL559FTpgwG96tr3Q0m06Qkh5CAxBF6fw7OI
         7c35mHZ/m99/iOIvc94FGN8733ZFt2aKLa0Jzu6YXd6kuLlGbP4CFLURwjWWz5qfIcZa
         SIZiZ6R1NyuuzZ7ie2b48BXvDRx+nWuM48crYVWxliQYNBrCvzv+RKs1dYywA86+qjmg
         SWDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724704389; x=1725309189;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+qZYYGpbLD3uPOiq52eAf17aMBl/U3t+WM6sWGoM08U=;
        b=BfQvcMBkD2lrgud2aCL259OHQwt3bD6C+9/p0/f6VnGJiuqoB9ue3sKrAnUpIOhlZo
         Giak3dIL3yLZHQXqNditB5xKFAOlHDfHfb7M1HzNA9O4ZUBURKNW0UcL9448uprt9Ren
         V5DpmNoD6uFDwNxKU6yCoERt3H3NwHRxXPM+X0b0bjYpyl+e0YE7dEatKkaar2ds6aE9
         wkPZHDn2in/Ptx9I9DZQotI2TPFl9rmGLAfY6126nsaPRjrIpDIQf5cJgmMk48NjWkhq
         bUkI/AkEHv9uEftVh+jx6jDsNI5oJkMI24jWhZp7EyvRUrySt5+FDMI1ByTnNj8xlwZj
         9RJQ==
X-Forwarded-Encrypted: i=1; AJvYcCVXJN62HU6bua5Skd/Gcf5RLeNUQteIZF1ZrBitQ9EASkCpM5KttHSRMr/dYLdeRsxyCdT89hpct/FfofrW@vger.kernel.org
X-Gm-Message-State: AOJu0Yxf5qaPT5/VDiJKG3K2kFE8cxUd30Q2DhMJJi89iHsCDNC1bb/O
	FETZAev2CBliYNCChRPjD8OBbDrIvDv8EIhxsKOOL4DEFoT3x0S9
X-Google-Smtp-Source: AGHT+IHuSd9C2k6X9a/9Nwx6blCSa1qEKMWc5JgQBBog03hyHF22yoyRp+Kc03wFWk0hun7ImK4MUg==
X-Received: by 2002:a05:690c:f81:b0:6cf:8d6f:2bef with SMTP id 00721157ae682-6cf8d6f31a1mr15835007b3.7.1724704388814;
        Mon, 26 Aug 2024 13:33:08 -0700 (PDT)
Received: from localhost (fwdproxy-nha-112.fbsv.net. [2a03:2880:25ff:70::face:b00c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6c399cb541dsm16547927b3.21.2024.08.26.13.33.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 13:33:08 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Cc: josef@toxicpanda.com,
	bernd.schubert@fastmail.fm,
	jefflexu@linux.alibaba.com,
	laoar.shao@gmail.com,
	kernel-team@meta.com
Subject: [PATCH v5 0/2] fuse: add timeout option for requests
Date: Mon, 26 Aug 2024 13:32:32 -0700
Message-ID: <20240826203234.4079338-1-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are situations where fuse servers can become unresponsive or
stuck, for example if the server is in a deadlock. Currently, there's
no good way to detect if a server is stuck and needs to be killed
manually.

This patchset adds a timeout option for requests where if the server does not
reply to the request by the time the timeout elapses, the connection will be
aborted. This patchset also adds two dynamically configurable fuse sysctls
"default_request_timeout" and "max_request_timeout" for controlling/enforcing
timeout behavior system-wide.

Existing fuse servers will not be affected unless they explicitly opt into the
timeout.

v4:
https://lore.kernel.org/linux-fsdevel/20240813232241.2369855-1-joannelkoong@gmail.com/
Changes from v4 -> v5:
- Change timeout behavior from aborting request to aborting connection (Miklos)
- Clarify wording for sysctl documentation (Jingbo)

v3:
https://lore.kernel.org/linux-fsdevel/20240808190110.3188039-1-joannelkoong@gmail.com/
Changes from v3 -> v4:
- Fix wording on some comments to make it more clear
- Use simpler logic for timer (eg remove extra if checks, use mod timer API)
  (Josef)
- Sanity-check should be on FR_FINISHING not FR_FINISHED (Jingbo)
- Fix comment for "processing queue", add req->fpq = NULL safeguard  (Bernd)

v2:
https://lore.kernel.org/linux-fsdevel/20240730002348.3431931-1-joannelkoong@gmail.com/
Changes from v2 -> v3:
- Disarm / rearm timer in dev_do_read to handle race conditions (Bernrd)
- Disarm timer in error handling for fatal interrupt (Yafang)
- Clean up do_fuse_request_end (Jingbo)
- Add timer for notify retrieve requests 
- Fix kernel test robot errors for #define no-op functions

v1:
https://lore.kernel.org/linux-fsdevel/20240717213458.1613347-1-joannelkoong@gmail.com/
Changes from v1 -> v2:
- Add timeout for background requests
- Handle resend race condition
- Add sysctls


Joanne Koong (2):
  fuse: add optional kernel-enforced timeout for requests
  fuse: add default_request_timeout and max_request_timeout sysctls

 Documentation/admin-guide/sysctl/fs.rst | 31 ++++++++++++++++++
 fs/fuse/Makefile                        |  2 +-
 fs/fuse/dev.c                           | 26 ++++++++++++++-
 fs/fuse/fuse_i.h                        | 24 ++++++++++++++
 fs/fuse/inode.c                         | 24 ++++++++++++++
 fs/fuse/sysctl.c                        | 42 +++++++++++++++++++++++++
 6 files changed, 147 insertions(+), 2 deletions(-)
 create mode 100644 fs/fuse/sysctl.c

-- 
2.43.5


