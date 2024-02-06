Return-Path: <linux-fsdevel+bounces-10469-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CA98984B72A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 14:59:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D280B22E95
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 13:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA73E132461;
	Tue,  6 Feb 2024 13:58:54 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F50131E3C;
	Tue,  6 Feb 2024 13:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707227934; cv=none; b=Povl++927djfHhQMTYGzLKfrluOLNCrdTb9EjuqbR8JYD1MeWCOc+l5ihc2/r0aoT56Q/YVAt2PtoQaXImV7BbvREdL4/D5y481dkwMEWWaIqvuHGljm1IIuXo/Qefu6q8+ERv/QIQi0iOn6088Pj1Aou1vxqRTX3SLUyogHbSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707227934; c=relaxed/simple;
	bh=7w4g5UBwRHgkHAi4f5Nyf4WX03bdpAEGYGt62HhSmq0=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=kOXJotpOM313UVbhqxZUJyOFmnWBHbu3aq84GKq5vboitUyG2boL+R1OyFJYyUNEDcBytKvSq1fM+gnSWPHHb0mHLAt1h6lIbRq8VIYo7wgDhZP9ubv8Y+qlBGlr/+ywl+AzfvHT84HL6NNhAXiviSK/Pc1yoRBNAitL3JprCTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav113.sakura.ne.jp (fsav113.sakura.ne.jp [27.133.134.240])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 416DwfNv018766;
	Tue, 6 Feb 2024 22:58:41 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav113.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav113.sakura.ne.jp);
 Tue, 06 Feb 2024 22:58:41 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav113.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 416DwfKN018763
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Tue, 6 Feb 2024 22:58:41 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <72da7003-a115-4162-b235-53cd3da8a90e@I-love.SAKURA.ne.jp>
Date: Tue, 6 Feb 2024 22:58:41 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-security-module <linux-security-module@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [PATCH v3 0/3] fs/exec: remove current->in_execve flag
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

[This is for Linux 6.8-rc4. Please apply directly, for tomoyo's git tree
 in osdn.net is still down. I'm planning to move tomoyo's tree to github
 or sourceforge.net because there seems to be no plan to recover osdn.net.]

This is a follow up series for removing current->in_execve flag.
https://lkml.kernel.org/r/b5a12ecd-468d-4b50-9f8c-17ae2a2560b4@I-love.SAKURA.ne.jp

[PATCH v3 1/3] LSM: add security_execve_abort() hook
[PATCH v3 2/3] tomoyo: replace current->in_execve flag with security_execve_abort() hook
[PATCH v3 3/3] fs/exec: remove current->in_execve flag

 fs/exec.c                     |    4 +---
 include/linux/lsm_hook_defs.h |    1 +
 include/linux/sched.h         |    3 ---
 include/linux/security.h      |    5 +++++
 security/security.c           |   11 +++++++++++
 security/tomoyo/tomoyo.c      |   22 +++++-----------------
 6 files changed, 23 insertions(+), 23 deletions(-)

Changes in v3:

  Removed excess function parameter description, reported by
  kernel test robot <lkp@intel.com>.

  Added Acked-by: from Serge Hallyn.

Changes in v2:

  Replace security_bprm_aborting_creds(const struct linux_binprm *bprm) with
  security_execve_abort(void), suggested by Eric W. Biederman.

