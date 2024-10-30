Return-Path: <linux-fsdevel+bounces-33303-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD6259B6FA7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Oct 2024 23:07:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31DF7B22132
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Oct 2024 22:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D2A21DF739;
	Wed, 30 Oct 2024 22:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g1qbTiMP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 972731991DF
	for <linux-fsdevel@vger.kernel.org>; Wed, 30 Oct 2024 22:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730326048; cv=none; b=Cwn8z+c/7yB1h88NMJtikJ/HnI/Uy7WBukQQJzXZCPL1Egt9GPQqseRfyuKCwTktjYpA8Krqw5EA6PqDQfJhuQ3FHv3gLl4ebd46QJiBb7Gkl1RPOZix1X0NLqeoo1XrduexgYS3U7A8JV4Cu1qO51YDX9AkIKufu64OKMjeslI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730326048; c=relaxed/simple;
	bh=x7S0HFCi1iuOisBV6LIOasXWVmBn3hpsnW8+RI4qWuw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fDl5iAtEyfapC47ybV/L3eCz0ZyXPs+cGvcCG4C0WB/YLaWvvyIxY5KJXau5g1g6GjJ9wyb/i1z4AmuYQNDr4hqc4AreITuUAornkjOy4D4dgHl1roPaFNPn5b81qTxDQOUgF8AeEts2JvBa8mLMofkbuSu09nGvsL3vX5dk2aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g1qbTiMP; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e0875f1e9edso403868276.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Oct 2024 15:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730326045; x=1730930845; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ni7DEz0FU2l21f+b9yRi6GWWwaOmzg2F74dnsHL8nFk=;
        b=g1qbTiMPVIOqGM9g9XbXc7U24KyxsxXjiON6LHl+TI1Y5q93nG7fsV4iTfy00PY/6M
         P7aJdgBIQX8Hf8To4pVI5WNbafN2H9D8JPYil8XIpyNMPgvEJihgzMpbXvreC/gG+d8A
         6VjLe0PxOr9NXKMyP/MGdwLL2RKLIgxPrFr4LDl05ysVF3ZdMeEFQMgMAcr+IF6wi0Fn
         2ilQu+tOqjQ/vwTdZKtgLvTa6oHT2YgUOoGpPO6eT5WeZiwQD8GrS6fXOYDILvPWMA70
         DZt1sef165gf3k6329uKVdBWA0MPUwpZgMgd6J6/vHPQZYMVI5YIHyVXTUnA/p0vgBi8
         i95Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730326045; x=1730930845;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ni7DEz0FU2l21f+b9yRi6GWWwaOmzg2F74dnsHL8nFk=;
        b=J1N+r7RDzoPWofc7avXUXXmsF/5q45ezmv5we3YzgZqZhbZg/6afE+RAc05C3U5WJW
         jqh4c/ekHh41zQmYnPhnPa7qMXrwX9NoK8sPNWAH1rmgibA72fiZDamwtzl1uiZFPAa1
         xn3sA5Qa33ONCHrtoWjqZPYpZOXzzNQ+OqxOdhH2q+clR3E3y4EMBSAWQM2yOHw6LXT5
         +sJKhmL0if2cx+pSEbNWwL9mCLOe+kmXhb0Yuhdkjpkfkeov8HpBPY79qj5mWwWpBo9q
         GRtLOUy8JTT+mrc8whn6UHnlMfijuywHeeIIXeGRjb7/2z3iorQT+mhWRXAn7dACwz32
         YFHg==
X-Forwarded-Encrypted: i=1; AJvYcCVWtvZxI7stBWWwWnsUTb/b012I7YXte6mdyv+f6So4zoeAzJBVi4uErOF40Shi0UUyTQb9W4XtURYUaWhy@vger.kernel.org
X-Gm-Message-State: AOJu0YyF+fBs9OgzebIhWxmtSFoNhXl45yybVfxj1AG7f0YByhpJsEHF
	hvbgCcqnlpiSBqlAP4/GfBhYw1sNbcYigBnbPGF289EJX4X9hebAaNXY+Q==
X-Google-Smtp-Source: AGHT+IHf4IAMxe628LNosr1x/7NX1m8r7qNOmLVcyffoRdnDeDb/6pll1jHpXF04O6cRJSfza+OR7g==
X-Received: by 2002:a05:690c:3506:b0:6dd:b7e0:65b2 with SMTP id 00721157ae682-6e9d8a6f784mr189071867b3.24.1730326045454;
        Wed, 30 Oct 2024 15:07:25 -0700 (PDT)
Received: from localhost (fwdproxy-nha-116.fbsv.net. [2a03:2880:25ff:74::face:b00c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6ea55b5c458sm274727b3.68.2024.10.30.15.07.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 15:07:25 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Cc: josef@toxicpanda.com,
	bernd.schubert@fastmail.fm,
	jefflexu@linux.alibaba.com,
	laoar.shao@gmail.com,
	kernel-team@meta.com
Subject: [PATCH v9 0/3] fuse: add kernel-enforced request timeout option
Date: Wed, 30 Oct 2024 15:05:59 -0700
Message-ID: <20241030220559.643853-1-joannelkoong@gmail.com>
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

This patchset adds a timeout option where if the server does not reply to a
request by the time the timeout elapses, the connection will be aborted.
This patchset also adds two dynamically configurable fuse sysctls
"default_request_timeout" and "max_request_timeout" for controlling/enforcing
timeout behavior system-wide.

Existing systems running fuse servers will not be affected unless they
explicitly opt into the timeout.

v8:
https://lore.kernel.org/linux-fsdevel/20241011191320.91592-1-joannelkoong@gmail.com/
Changes from v8 -> v9:
* Fix comment for u16 fs_parse_result, ULONG_MAX instead of U32_MAX, fix
  spacing (Bernd)

v7:
https://lore.kernel.org/linux-fsdevel/20241007184258.2837492-1-joannelkoong@gmail.com/
Changes from v7 -> v8:
* Use existing lists for checking expirations (Miklos)

v6:
https://lore.kernel.org/linux-fsdevel/20240830162649.3849586-1-joannelkoong@gmail.com/
Changes from v6 -> v7:
- Make timer per-connection instead of per-request (Miklos)
- Make default granularity of time minutes instead of seconds
- Removed the reviewed-bys since the interface of this has changed (now
  minutes, instead of seconds)

v5:
https://lore.kernel.org/linux-fsdevel/20240826203234.4079338-1-joannelkoong@gmail.com/
Changes from v5 -> v6:
- Gate sysctl.o behind CONFIG_SYSCTL in makefile (kernel test robot)
- Reword/clarify last sentence in cover letter (Miklos)

v4:
https://lore.kernel.org/linux-fsdevel/20240813232241.2369855-1-joannelkoong@gmail.com/
Changes from v4 -> v5:
- Change timeout behavior from aborting request to aborting connection
  (Miklos)
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

Joanne Koong (3):
  fs_parser: add fsparam_u16 helper
  fuse: add optional kernel-enforced timeout for requests
  fuse: add default_request_timeout and max_request_timeout sysctls

 Documentation/admin-guide/sysctl/fs.rst | 27 +++++++++
 fs/fs_parser.c                          | 14 +++++
 fs/fuse/dev.c                           | 80 +++++++++++++++++++++++++
 fs/fuse/fuse_i.h                        | 31 ++++++++++
 fs/fuse/inode.c                         | 33 ++++++++++
 fs/fuse/sysctl.c                        | 20 +++++++
 include/linux/fs_parser.h               |  9 ++-
 7 files changed, 211 insertions(+), 3 deletions(-)

-- 
2.43.5


