Return-Path: <linux-fsdevel+bounces-70378-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 64E68C992C3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 01 Dec 2025 22:29:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 39D244E1C34
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Dec 2025 21:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A233A280A56;
	Mon,  1 Dec 2025 21:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dv/uUnDU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 721F2184524
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Dec 2025 21:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764624553; cv=none; b=eS0es1DHwtndnyRI5awSoyyPu9FjDb6v0neZJ6u9cIs8fIdl0JA2epBHjTFRPx+1H8+6AYaHpEaKNGaVjcLCgonPViNk83unvsGdcezhjP3Hp+WMJ/hFvVOWukq0jxsrm0y+gUKJSND7A2yPW+1m98RwI83UkjziS/OsY7bpbi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764624553; c=relaxed/simple;
	bh=bOtOjd6JjwbAPh2xNBvn8IBjSD+6F7oZsr68VyfvX7w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=csVRoij49UH3sZ8BM0eM+SLKZ0ngzuebrXulpCFjUbOPUrJ5qhPyyUnU14+pAIMJL7o8nAvMq2nsSUOAGtBzUipTVoZRFNET9QcDsiBoU8WoIPDwaoKeiDfIaqs0haA0+g6jSpDJKHJMAr86rIrHCrpbJ6s+Y1LLaC06TJvxWRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dv/uUnDU; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-64075080480so787681a12.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 Dec 2025 13:29:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764624550; x=1765229350; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RnmoayJSvzdqb3DFZ8NRtsHFlDAO/OQzvSg2v1kodIs=;
        b=dv/uUnDUPkMc4FDZ3ZX51EBi9CKwpQov7R9J8AUGpVWEp1MqeuHB4n2MjiSduKrsvu
         igJlFlNASmzg9VEhn5gthEKZ1Cxt/syTh6sZKkUSBekY6htIkUTLn7QcUXbtQpEr4vyS
         /xO/wKrvs6H9ZVAaTR6tX/BvmuQDrgbi+SlfMz+JvFXmCbSyeK9MetHX92kr1aV8EY2q
         thRjjvi/quvaEl/ys9geWp+COeDP9GP13f96+Mfk4Q2bEFCB8GXUCL3sL2tkK09UlFq8
         GfVNSbQogqTAUd2iGhRCds0cf0rBflS/u5cWoMiAgCxxuZ2NicIi3eWKbKNAjcT5uZvB
         FnZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764624550; x=1765229350;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RnmoayJSvzdqb3DFZ8NRtsHFlDAO/OQzvSg2v1kodIs=;
        b=T+EwLDY6n4joTeYejjD7ekZPGfOCv1jvnb3B4nMZMDqZyIMlJKfQyJRiZuh/volyoR
         1fHZ4BldrakGc5PKrKNSte6zuLpnS7+IveILnNEWB/yVEt4kyh1NBmhY8x7QMhv1GWKQ
         YcEATc+Xex0FtRIfnl4dSFyU2kQCPTvCk5eqRD5o0I19AeSy0EmRinwDkdap252fHH2j
         UoDRvFzvlMSY25VDaiK+tM2XfBtCmMxblRVYoT+1P6tWnDqOXIYQiAPDXVbJRv9MlOD8
         LP0jpvZ5YM4JbTlQHf0Y0/0ROHyXMvz6WALt1mUM9IqPuCy+whSeSezsTpnPlMpBFmbv
         w/ag==
X-Gm-Message-State: AOJu0YxDSnOeheMOIdl7ZNjGvrvQo6ZKAahkS1VW+o1Gsjc7+enDbPAa
	hUUslsBpvyL0SYkJAk7+WVTUL+JCujxj2M+G/QtVX987/edt7yep4kG5
X-Gm-Gg: ASbGncuzxWKACvJ3uTTVvxwvRxFhBy8b2WlHLEMBtwUUXAmXA+FzStmV9QivBa2w1Jk
	lPXbpVanxVlpWkBsHUEne5wMiuNqBo4xjGrtSlIYhe2FbdUNtFv1DCALHKjGys0JqogIXE55ILd
	BhTcXwQ05EJmmO8UELfYCzZ6H7bb6NqSYwMeQ61hvLKjVNBTJmRJaF0SXTLIW3tts2oXjhnwBpA
	AryPzvAKE8GYbQ4Ht31FjPUMSSBn2rhpppnFKUdvUQFBaRe5jmq387n4hEIQp6RhijYq1Ve/25z
	hYnsYX66Z5XBJ9mEXOHrMYrcnnhxdrqb+VdEYEtbrOok5DZILlzBwofgDGV1lTSHh3v7IRUlKNi
	ARfiuQSjIIGPpkjxOljLqqDGHNV2SjAvBVFdeXRMfgvZ+HlUUKdokLnFKT0gFlQe09Y8k2SY05x
	yKBj2lNI+8WLYhJA==
X-Google-Smtp-Source: AGHT+IEDyOdG43yuRYaMbez1bnYjIxw/7tPACl84TupPKYcPO52lnJgZpf3YRgT8PjhGfPZVGvJjrQ==
X-Received: by 2002:a05:6402:2106:b0:645:4607:982a with SMTP id 4fb4d7f45d1cf-645546a2544mr20050925a12.8.1764624549492;
        Mon, 01 Dec 2025 13:29:09 -0800 (PST)
Received: from bhk ([165.50.39.229])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6475104fd7asm13519497a12.23.2025.12.01.13.29.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Dec 2025 13:29:09 -0800 (PST)
From: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
To: slava@dubeyko.com,
	glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com,
	jack@suse.cz,
	sandeen@redhat.com,
	brauner@kernel.org,
	Slava.Dubeyko@ibm.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	khalid@kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
Subject: [PATCH v3 0/2] Fix memory leaks in hfs and hfsplus 
Date: Mon,  1 Dec 2025 23:23:05 +0100
Message-ID: <20251201222843.82310-1-mehdi.benhadjkhelifa@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Following series fixes a bug reported by syzbot which is specific to
HFS but this issue is also persistent in other filesystems.For now this
series fixes the bug for HFS and HFS+ Filesystems. Other filesystems
need to be checked for the same issue fixed here.

ChangeLog:

Changes from v2:

-Include hfsplus fix

-Align changes to christian's recommendation.

Link:https://lore.kernel.org/all/20251119073845.18578-1-mehdi.benhadjkhelifa@gmail.com/

Changes from v1:

-Changed the patch direction to focus on hfs changes specifically as 
suggested by al viro

Link:https://lore.kernel.org/all/20251114165255.101361-1-mehdi.benhadjkhelifa@gmail.com/

Mehdi Ben Hadj Khelifa (2):
  hfs: ensure sb->s_fs_info is always cleaned up
  hfsplus: ensure sb->s_fs_info is always cleaned up

 fs/hfs/mdb.c       | 35 ++++++++++++++---------------------
 fs/hfs/super.c     | 10 +++++++++-
 fs/hfsplus/super.c | 13 +++++++++----
 3 files changed, 32 insertions(+), 26 deletions(-)

-- 
2.52.0


