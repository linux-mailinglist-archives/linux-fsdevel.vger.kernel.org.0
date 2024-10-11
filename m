Return-Path: <linux-fsdevel+bounces-31773-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26E0D99AC7A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 21:14:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66E86B283B6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 19:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0B461CB32E;
	Fri, 11 Oct 2024 19:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l+9KLXoy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 894081C9B87
	for <linux-fsdevel@vger.kernel.org>; Fri, 11 Oct 2024 19:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728674071; cv=none; b=ElJu4gmwrV3IJVe7WWD2/uQnVlzCj6Tu+e72O6aZGbWBUe9PXNMeoB6T2uw+s4J+8odNbS+yGHEeS/IO+FcTNKFa66xpiyadA5rt0kUh7/8QgfIaPYIpnUf8zUPy3EcbBcm5mt1g3dnvSLyJk5KyKrkI4IolknJ2IKrYCGZcuY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728674071; c=relaxed/simple;
	bh=q2IHWgnV9TOdFSHQ2VFD75k39izCRLUeZBBHmvngpkc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FpJz6Ni3tC0O1eY/O5UMCihLLFlvO0z2khsc+E4YSpphUuy38LhdsevcLGIQp2TjhEJyROyFXSl0n4toACq3PnW0c2Y+2equj6vuBvgRXp+jM06MJ2Qilf07FIm1rcvGxXoL7QqQ4R7sbNhJVF+n0ILwZwb0UJKa9et9kzDvcxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l+9KLXoy; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e28fa2807eeso2517478276.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Oct 2024 12:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728674068; x=1729278868; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UYcNk8B+CfLYF4TFEGSnQKMtA0jr+2f/fdCHE88W2Ek=;
        b=l+9KLXoysucICExwyvTHpjKGY1XQoelS31VM7CQ0CJNdMeRmQuFdwn6R7GTCyN/jAl
         i1IxM5tyLkrZm+tnzy839jOhhPYMtL4o1tUR0q5WUr07vVAYE5YiY96tPGFNElULD8Eb
         h1UqfmEtCs0V5P0WwJvEfcLBA8oW/wrN8cg+59ZMHbgJB/JDBdETMmga5TKP+BfABkCD
         tvZ2/xUbAuOveYNaVWw+da4gpjU2AbAwJifhN0FQ3A5nb0klzKy295We84/Q6nzaJz54
         4KbRV3D6xkpHv5k5Cih9OSo4+o+2qYHpYf8x6ZswST4NYmFPDqWkxjcWk8K6B1KSFOGX
         YiCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728674068; x=1729278868;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UYcNk8B+CfLYF4TFEGSnQKMtA0jr+2f/fdCHE88W2Ek=;
        b=epkxD9DasGpHAFa5kLBHQP9ZzNrfKS80Gl8rz5s0SB3+yxDwHPdRlGG2xR4L91io/t
         5rTByGGl9d3/VZuB/uTryOkHcneJrbiifdbt6rHkrZBX3wZ2q5XCod0PO3y+i3hE7Mj8
         ItqYpcP1ILevMo3+3qLSB7BK3bTPeVU4LTX/HcnD0lSddPfbRZSEtgnmnE/XOUMMRi96
         piOalPCB5DiYZ+ZmkAd/ELzvhC3kCS2+9row7bFNBmm/KSczdNeZ8kTSDFH8Bp6FYGzb
         UCFll3j5KGKJxO4FJviCvJLVPfpe/khn8Y1itTZPTkchv1Jy0Fu9d8747w6KF+PLanoK
         T50g==
X-Forwarded-Encrypted: i=1; AJvYcCVG2DHLhL/aAo1ebU58e7cvXL3sUoFVT4IGLgMMt23C2QvrrvaXV4UdMjo+GC4C3HixF3TkJ4nNz+A1kKmB@vger.kernel.org
X-Gm-Message-State: AOJu0YwnvcLyNbSGB+XxExlv4w9o+xUwIPsmlHcLCYp931YtJH6Pu/4S
	66q/Q6UThUiCPetbicgE0PZMYLzpssfho3Blojqs4IBZzs//xrNW
X-Google-Smtp-Source: AGHT+IGLaj27QEZJRVP7j9bAlb43ATtU9C6yH+ushLYAISlwXYptAdpLnTGxyUb3L7owlz7MFZ2Ksg==
X-Received: by 2002:a05:6902:906:b0:e29:dbb:a4cb with SMTP id 3f1490d57ef6-e2919fe664cmr3149455276.43.1728674068373;
        Fri, 11 Oct 2024 12:14:28 -0700 (PDT)
Received: from localhost (fwdproxy-nha-113.fbsv.net. [2a03:2880:25ff:71::face:b00c])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e29284ac988sm348336276.20.2024.10.11.12.14.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 12:14:28 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Cc: josef@toxicpanda.com,
	bernd.schubert@fastmail.fm,
	jefflexu@linux.alibaba.com,
	laoar.shao@gmail.com,
	kernel-team@meta.com
Subject: [PATCH v8 0/3] fuse: add kernel-enforced request timeout option
Date: Fri, 11 Oct 2024 12:13:17 -0700
Message-ID: <20241011191320.91592-1-joannelkoong@gmail.com>
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


