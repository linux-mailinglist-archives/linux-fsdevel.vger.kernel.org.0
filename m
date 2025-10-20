Return-Path: <linux-fsdevel+bounces-64718-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A48FBBF2399
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Oct 2025 17:52:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8B2844EC02E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Oct 2025 15:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6420026738D;
	Mon, 20 Oct 2025 15:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ERHW9lew"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DFD223A58B
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Oct 2025 15:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760975569; cv=none; b=M5HdK0dePAG9q76oqOjAIF5cZvf0HoyL/jX7whms9MmmeOJyC0TZd8Lq8wsAB8mB0HS/cBscFiMjLZZfXDaylKU79zlKn3GR8zCLo6SpTPc/MF1P32YAWSw54C0a/j1lYeEVMHK1euh0EaaExgfjhSSW+UFgkr3k8KG93CzFTaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760975569; c=relaxed/simple;
	bh=cBbmKe+uMRaejJbZw811aciwMt8tWwG5REOIrWKzsQs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V78YsZS6atmVg33WEh98qHMxcRLX3kRdFIX0PgpMF5ZygpIudUCL5CCipgoRspzZeQgYybGvcaCI3lgdtQizd8aAMd5yr2hogN4YIS8O4wqaWxGnRel/RixbJZxzK3wcSIVGAFgBecpdnOSrfqZT6Q+tsq4aUdFeAbh3gHNsiRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ERHW9lew; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b67ae7e76abso3297674a12.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Oct 2025 08:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760975567; x=1761580367; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8/TAOnKpEv75WMe0jsAfaKx3rckeoydUaySkiUqKbnM=;
        b=ERHW9lewHJygB57PRGNVSCJenPsh5yiSBWCbFzeQyoLWVhcuIWK+CsPOS6NlgoDqmZ
         DlbacfErRj8kpcSvIhF+KZsTD3mhTjDGBX3n4IMlRZzEtOcOHqidoiLXLfxbO9cCyy/d
         w3n09yvlY7+u7/8rzOO0ziavpMshCvYEymMPaxQnZF6GYBaix7YW0eq0XbPgMRpaWa6n
         vhA740ivGuaq0HSuqNWyaLMymCMhOFu7+FFXp6qosjCVUn7ILqw+AU0TI5BNTA0SG/GD
         8bpYJJGQzb8ZDjAHnZBMoyfg4jcEkdbVJ3vjJIydSuI+J3HH7ET4rwRq16bKSn64v7su
         rjYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760975567; x=1761580367;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8/TAOnKpEv75WMe0jsAfaKx3rckeoydUaySkiUqKbnM=;
        b=gitkZYwUXcLzwFGlaF9ANRBHiQFu/CQf1lYd6u5aZZbnXA3WGylGkxd/ARWvUa2GOZ
         7EQOq/YijQoIrf+3bMwmR74YyDat6aU0p4veQ6R0fw4TkKfDYihIXYNEMhlmpe6O3yqs
         PRZjGNjy/zB8N5z8ncWfnGoTyzK+KLFUCHNMR3ufScxHai4zP+6XuBGw0a0YYDm+Q32X
         4He8VQJPYP/95gHWViillFANw473c71iuHXtIH9R9q+4H0ZbH9DarFknFAJZ5u4iG3Rv
         jzeZqLLCsD5w/zM4bxcC+NnzewpVnxHvbJCrZn21qa2QB3a7Nf3vSeQ8pbdTv+ulkpyX
         KtRA==
X-Gm-Message-State: AOJu0YyGcbcsgf/fShBfI5n55JEkqPg4dAL6wAxhTv7tzP103iVXZEqR
	Jj2IbjkryTEnhYbpqfpVWpPMhPVrptDMGBoVCVGCiU3DQUSJD71dW2qn+Eg4a4H8Qb0=
X-Gm-Gg: ASbGncsnWJm2rOIL4il/nmccQN0xUGbMBeN+w2PFowYYrjAaEVmx1ri/v67tahig73I
	fEdqfjKWBncTZY69lbxHzH2kyVzLAUe574uww/Ev+VSq9IJs+15WBpb2ClZrpHHBs0TNzG+Llkb
	DffMdtfMbWkISW/kXCFZa0mtUD4zox+dsr3OhktWlX/FZZ+T17TFrTLpyn/DxUoblQNDfXM0kdd
	rxSTDQl3ckC7cK873MnUHRiuq1jmDdHK/0HImdCkRlfyoEJC6Y/34+UTyxqynWz2UD/seex7cgx
	jGQQxutDPbRH081tp/XL408FPl5uGfwqU34sg11Mz3o4l0Q/tvd6XqKPObo5a/KQ5N4H9x95pqk
	KEtBhTrwg1fmNzt6kDciJv7T2AvXqQMGX3nHS6SHVV9QqKU1vVjAm8drX/41vJ5JK6YRc3vHna7
	JK+LJLbWSaAUY=
X-Google-Smtp-Source: AGHT+IFQ8hZ5tUwpC165bOqaQ92SrE4Fc3ZtbwB/RtHjroe+D4iXpymYDAlQAHdeMjvKVW+0ojPfdA==
X-Received: by 2002:a17:902:ce12:b0:27e:ec72:f62 with SMTP id d9443c01a7336-290c9c89b06mr160035085ad.6.1760975567434;
        Mon, 20 Oct 2025 08:52:47 -0700 (PDT)
Received: from sysxso25 ([154.236.162.170])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-292471fdcccsm83505165ad.78.2025.10.20.08.52.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 08:52:47 -0700 (PDT)
From: abdulrahmannader.123@gmail.com
To: linux-fsdevel@vger.kernel.org
Cc: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz
Subject: RFC: Request for guidance on VFS statistics consolidation
Date: Mon, 20 Oct 2025 18:52:28 +0300
Message-ID: <20251020155228.54769-1-abdulrahmannader.123@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi linux-fsdevel,

I'm a new contributor learning kernel development, and I would like
some guidance before proceeding further.

Background
==========

I've been exploring VFS statistics collection. While doing so, I noticed
that VFS statistics are currently exposed via several separate interfaces:

  - /proc/sys/fs/dentry-state
  - /proc/sys/fs/inode-state
  - /proc/sys/fs/inode-nr
  - /proc/sys/fs/file-nr
  - /proc/sys/fs/file-max

My Questions
============

Before investing more time in implementation, I wanted to understand
the rationale behind the current design and get some feedback:

1. Is the current multi-file approach intentional?
   Are there specific benefits to keeping these statistics separate
   that I might not be aware of?

2. Would a consolidated interface be useful?
   Would there be interest in a single file that aggregates common VFS
   metrics, or is the current approach preferred?

3. What's the recommended way to extend VFS observability?
   If there are gaps in the current monitoring capabilities, which of
   the following approaches is preferred:
     - Extend existing interfaces?
     - Add new specialized interfaces?
     - Enhance debugfs entries?
     - Something else?

4. Are there any existing efforts to improve this area?
   I want to avoid duplicating work that might already be in progress.

Context
=======

I have written a small prototype that collects these stats into a
single sysctl entry (/proc/sys/fs/vfsstats), mainly as a learning
exercise. I understand this might duplicate existing functionality or
not align with established design principles.

Before polishing the code or writing documentation, I wanted to
understand:

  - Whether this direction makes sense at all
  - The right approach if there is room for improvement
  - Common mistakes to avoid as a new contributor

Learning Goals
==============

I'm genuinely interested in:

  - Understanding the design decisions behind the VFS
  - Learning what constitutes a good kernel patch
  - Contributing meaningfully, even if this specific idea is not viable

Any guidance, pointers to documentation, or suggestions for better
approaches would be greatly appreciated. I'm also happy to work on
smaller bug fixes or improvements if that would be more useful.

Thanks for your time and patience with a newcomer,

Abdulrahman Nader
abdulrahmanxso25@outlook.com

P.S. If this is not the right venue for these questions, please
advise where I should ask instead.

