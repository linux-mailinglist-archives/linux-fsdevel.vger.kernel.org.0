Return-Path: <linux-fsdevel+bounces-45279-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 97E9BA757B2
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Mar 2025 20:28:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 742397A4F1E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Mar 2025 19:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E9721DEFEC;
	Sat, 29 Mar 2025 19:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YnPpQCr9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75FC818A92D;
	Sat, 29 Mar 2025 19:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743276517; cv=none; b=KhiLpFiDc3ObJhR3AWYEHL9YtvNODHiINveKbeGZYNZcKD9+/BWkoYcdkaPvTD4FVxhSWaVk9atgH6zdmkvj2pQbFOe6N2WVGFlYBojLeWqJAhegIthhCdeNmIdSAZe7wVW11F/0XyQra0KzJSRnLoI82Vnlo92ms1jrs/XPLsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743276517; c=relaxed/simple;
	bh=VBxTOwdgsbLAEMe0yBrECAsaUE5a211eSTAURJyDEnI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ok3wt/i7CqmFMvyxeDWe2LQnoLE0eBF7shrPypsFXnDzv6VKjqFy3HNHMfrxraQDjwJxV7bIglz1WIIKr5/FR9q4hzcilD3dEzwIqhJiSA7nZtKRrOC2BDtO8pncusvFY/8gENqneqzPqX0k9ZC+P26jTyENeoYqcrQcTzgboDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YnPpQCr9; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-39c0dfba946so971234f8f.3;
        Sat, 29 Mar 2025 12:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743276514; x=1743881314; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CqyetzmYSLVQu+1Nzeos/IdzclQtfVZ0cqopKcxfgZE=;
        b=YnPpQCr9wLqzVN5FwjMUrzWDIqPj67cMNdKQLjPVFNFs/Q6h1bRji4XYFNmVLKDPNY
         IHB2jUjUrFIDcEkVIjRLRoANktZ3PU0mpTkLAfLZ5OBR9g67yfpJGjFiOj4CO8xBUcHr
         Pcc8UmwDmKFCoXiehsiivaUNph8Slf+mvQWpHObtSqlpOMxXA/Uk3vAn0JHBcViif+Xn
         K4NUwJeYPufVyekxwtA3eUTiU+JT/1zbF/r8BoPi+/eWelLZEhtf4TGiGU8BHiH+Z027
         uMEQyoLxbIcDPKjnvJddUTDVUidXFH47aAFwIO10MKq2y5VZbfnkM9O45BEkmNPkNnkW
         wHNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743276514; x=1743881314;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CqyetzmYSLVQu+1Nzeos/IdzclQtfVZ0cqopKcxfgZE=;
        b=MsnAD7q0HzkS53TdhCkeqvfMXk3pUMTH5BMLFZKo8Un8SMyntHQxcBwp/yIRGTWLpw
         Em5LGXmixZz/OFRrHvrut3ZWLa8Fn01fubEztlJ5EEevSSiLio/bEo8ecG+oNWnSTYB1
         XTtKbrJo/3glq/pLRFwpgVvpXuPrb9+2tkSc12EtOTz5ktJYsvXkKDN8spmG1Q4pdFQF
         E6kYtMA4AzDwiVpt0JJU9B/P6F3eJVgnt+6lLeCbHk/Q6Oh3rYlNXb5iAWW55VOH8l1t
         zFoN985TVKx5e0d2hjaAkzy6bzQdSkwUgtlqizqV8BE7ruo++2/7PnQTuz7ilIMokTb5
         aw8w==
X-Forwarded-Encrypted: i=1; AJvYcCWK/VioVxLhAfcA0GX9OCR3vw4hm66snjAobdY/1K01fV79oHxBTH3s7O0J3fvtqH0pcKLOFMPDVQoCf6Ae@vger.kernel.org, AJvYcCWYmVZgym/3RYMLdxR+hKFpNTziKpMl4sytlvouEag4VakW9vjuoFDXJJE0HLUavTIpn+9x/JhVfvgpb6it@vger.kernel.org
X-Gm-Message-State: AOJu0Yxe6GIY7NsGhJJISzgvQVe7QMpZH6Zt5HUbkW6NMSYlbH0U7Ufh
	Lt0XYMbn5HDgKC/6dPiCRl+bky9XK3UEHEHi97UWRkheinMumWnm
X-Gm-Gg: ASbGncu4XMmNIvqVSPs0Nlhlh1MDpp9uZNx8BOanJZRWTCtMyG//2q4JNMZz8ocDCzJ
	bAH2jO0TBj7Je8sEz05IDHqiTYSdBfoxWFUoEfVy3KQP8lDMR7ym0Uq+NII2CG4zCcb5sopWt4F
	+C/irr38w5Wf+Ea7pbQs7o11uLAegM7kMKtnTu6TBnDUcgoGJTi6YQ1343cODP0GGtYhyHAqRvQ
	oEQhMnQ9jVD0ahkaCwPnGyNmk+47ht8XPp860qremhL+D4zgRgjBIyZvqpwywKJJMI0a0d/GM1s
	7eR41p9PUvjlAeU+W56j0SJxIDnQNbYNoG252xSFpcRk1N+qn4RpDLRfsRmQ
X-Google-Smtp-Source: AGHT+IEwlWb42TaSLEgVmfv3XSvypZjyltLF+/xDzNYgYT3xxJB1bmR+70zqU+wtR3894w0uHTSWNg==
X-Received: by 2002:a05:6000:402a:b0:390:f9d0:5e4 with SMTP id ffacd0b85a97d-39c120de3f8mr2409143f8f.21.1743276513518;
        Sat, 29 Mar 2025 12:28:33 -0700 (PDT)
Received: from f.. (cst-prg-15-56.cust.vodafone.cz. [46.135.15.56])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c0b79e141sm6553400f8f.77.2025.03.29.12.28.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Mar 2025 12:28:32 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH 0/2] speed up /proc/filesystems
Date: Sat, 29 Mar 2025 20:28:19 +0100
Message-ID: <20250329192821.822253-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I accidentally found out it is used a lot *and* is incredibly slow.

Part of it is procfs protecting the file from going away on each op,
other part is content generatin being dog slow.

Turns out procfs did not provide an interface to mark files as
permanent. I added easiest hack I could think of to remedy the problem,
I am not going to argue how to do it.

Mateusz Guzik (2):
  proc: add a helper for marking files as permanent by external
    consumers
  fs: cache the string generated by reading /proc/filesystems

 fs/filesystems.c        | 148 +++++++++++++++++++++++++++++++++++++---
 fs/proc/generic.c       |   6 ++
 include/linux/proc_fs.h |   1 +
 3 files changed, 147 insertions(+), 8 deletions(-)

-- 
2.43.0


