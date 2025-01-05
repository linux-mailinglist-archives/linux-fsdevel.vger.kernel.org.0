Return-Path: <linux-fsdevel+bounces-38400-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 60040A01A8F
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 Jan 2025 17:26:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93249188666F
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 Jan 2025 16:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DC1E1494B3;
	Sun,  5 Jan 2025 16:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HQYZTpvI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1449F146D45
	for <linux-fsdevel@vger.kernel.org>; Sun,  5 Jan 2025 16:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736094252; cv=none; b=gxGT/fDRb5uscYvUmufyrBbwdM6/EBqsEnuFxFzwuaT0XDmaxRs4a6Hjolit+Pbu0nsT3LL6o8zWlXbz5bL3SZ88ZAuhh/dL9O87DnudliS2iQSOyvKyb0TNqT4SSFwEaTkm+PeAS5WBw8su9M7fnko/sB75ialQr/5PXDRfGj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736094252; c=relaxed/simple;
	bh=keb+apRto4pLv0HdXfSxko+cZCtc6ILJAPwJfITYPjY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bNwthS9Hgk05VbFDeS8oXOoybct/18MYbs53W/PkgJUYPcvAyVQ1e1vDOrBcohUp35WWYgaKxo4u03q25kOLkE0SCfn0Y/J1nqrHWTRlbe0EYhZLsfh6SrkASe9UlJl3kyZi6GhtmAyl7FaeknRWj7SRsELO4I+xfuh8mCu5Bp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HQYZTpvI; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-436281c8a38so97451025e9.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 05 Jan 2025 08:24:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736094249; x=1736699049; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LMThCSYNtmpYmGYAou3VOrD3n/4TT1zo6KF8TS4nHrc=;
        b=HQYZTpvIhZoKK2af9jkbQz6kc1/WzJkSEfI5QXP5YH1XDaB/WPIwawnbbFT9ppSY+a
         iFqVYei3DYDUFmApqunoodVn5OgBdA4qMhj7xdnq7A3376OVjCdx0JYqFnwcJ/GGPzph
         o4pqKA9Ci5HPez7ygmUdwSwPY1ZtzO+ViomUSB5AB9v0ViZYnTRB/QE+k1FlnBh/wyYE
         FSCQkDQkr6d37VIKeFK+B8PqsuAVdmLRcb3/IAjtW+miy97igL7qZxRvZ90I+rxwK5hQ
         KZV4wyr4UTVkhKMBx9iBnfVhZx4tqbf40w9HTUT+8nxQe0Tm1PC84IaxIwYE6nYJi/th
         T3zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736094249; x=1736699049;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LMThCSYNtmpYmGYAou3VOrD3n/4TT1zo6KF8TS4nHrc=;
        b=tD2hr8WtatEm9kuJzaI6dtjpJPZuvegUvBz6yaXDyBGM9xheuYpTu+P4WnKo9yefQR
         0h/YGkabgnAiJY8Mk7szwAuqYPVYT+8PVPmsShPzkBeM/tRht+82RP4ZFPKqXMKORLYC
         eioBY1AKkOvyPmdmm2Tn7gIPyqb4o/3hGVAQpYkdNFgGM/RBCjMiy3k7Ktkj1DDAUK0d
         78J+jCVLZFpTItEYWBmTysNNjNfXCZkZx5yioyf3eRjhbImbVbEA/T7hZpEMjXgUVRqU
         XPd2WOSxxsv7Ej0hWUxMIWD8d2ZsyfAu3mUSA8Fggg9TL/w6MPnk1Jd8oDqi47+XZwwV
         8fyw==
X-Forwarded-Encrypted: i=1; AJvYcCWbxH0KSCZuTIK6TMHNkwPzy08xn/LNuNXFXxw9nNp1FJrKDXtxWrXOpk83yjOs6dxI5hd0kel7hMqMpTY1@vger.kernel.org
X-Gm-Message-State: AOJu0Ywkj1Vs1dlui/5MqbSC03X2O1HKONSUxzcecdZydSmLFdbLAKg7
	IJGffWJAiKvOsWkuN7V8dqHdPXkK3p4ifKpU/D7HtZNtlp2/9OBv
X-Gm-Gg: ASbGnctCthu5MfwXPuB7FaE6lChXyw0hBnUMBaXurbwUDkxbEVOwAyciYXUTTYZjFky
	mk5WNnGautyUJi55JjuVRHka+EqaSE1hFX7y/XlC3Bfwh7L+KAtRGMdqD0l9kgm3v+2EDxYW9/u
	nBf5BQmcCv0mRAZlGTq3iNt0GZzPAO0NdjPOzSxhyFyN6EtqVD4MdVVMSWOasxBT7uDAB91s4ou
	O6TiVN/C0QvnLCtQxPfcx5v+jrYEb/8GeIOslOTrWhQYwp7pJHKXlsSFSDQuLx7rNoDb88kArvX
	Cuz/7CLNE+HJeoYaLfQuQXn6tva0GH7Nb6MFYc0WtgjSr810YmA9qQ==
X-Google-Smtp-Source: AGHT+IHZ+14eVchAo2WlX5vbJdsfBDL2RCKnxwIN+AuEaQp6zgFHkOBe9ltU6Lt39f223BKGJBgVvg==
X-Received: by 2002:adf:ae42:0:b0:38a:418e:1177 with SMTP id ffacd0b85a97d-38a418e1435mr27331423f8f.11.1736094249008;
        Sun, 05 Jan 2025 08:24:09 -0800 (PST)
Received: from amir-ThinkPad-T480.arnhem.chello.nl (92-109-99-123.cable.dynamic.v4.ziggo.nl. [92.109.99.123])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436612008b1sm538372765e9.15.2025.01.05.08.24.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jan 2025 08:24:08 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	Miklos Szeredi <miklos@szeredi.hu>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 0/2] Fix encoding overlayfs fid for fanotify delete events
Date: Sun,  5 Jan 2025 17:24:02 +0100
Message-Id: <20250105162404.357058-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Christian,

This is a followup fix to the reported regression [1] that was
introduced by overlayfs non-decodable file handles support in v6.6.

The first fix posted two weeks ago [2] was a quick band aid which is
justified on its own and is still queued on your vfs.fixes branch.

This followup fix fixes the root cause of overlayfs file handle encoding
failure and it also solves a bug with fanotify FAN_DELETE_SELF events on
overlayfs, that was discovered from analysis of the first report.

The fix to fanotify delete events was verified with a new LTP test [3].

Thanks,
Amir.

[1] https://lore.kernel.org/linux-fsdevel/CAOQ4uxiie81voLZZi2zXS1BziXZCM24nXqPAxbu8kxXCUWdwOg@mail.gmail.com/
[2] https://lore.kernel.org/linux-fsdevel/20241219115301.465396-1-amir73il@gmail.com/
[3] https://github.com/amir73il/ltp/commits/ovl_encode_fid/

Amir Goldstein (2):
  ovl: pass realinode to ovl_encode_real_fh() instead of realdentry
  ovl: support encoding fid from inode with no alias

 fs/overlayfs/copy_up.c   | 11 +++++----
 fs/overlayfs/export.c    | 49 ++++++++++++++++++++++------------------
 fs/overlayfs/namei.c     |  4 ++--
 fs/overlayfs/overlayfs.h |  2 +-
 4 files changed, 36 insertions(+), 30 deletions(-)

-- 
2.34.1


