Return-Path: <linux-fsdevel+bounces-21576-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2A1C905F9B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2024 02:12:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 758B71F226C4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2024 00:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 001EB811;
	Thu, 13 Jun 2024 00:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nK00puUc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C169D37C;
	Thu, 13 Jun 2024 00:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718237550; cv=none; b=u0u3oo8cLSiGysWGA4vJYHafuz0irw6pVnh7shFzokvkYW0THXk9KITP0+4/Dvjn5Jpk3xNNklkNux1F6X+YuzraDIooJ7JU4wGuU5DsWRDpkpS8sRe0Sum4GQ3aGtH5shjncym8QwRtKiZlkZv4HKvK5blG3zeKS3V7Z8GofZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718237550; c=relaxed/simple;
	bh=tEx+LJNXz9PFrn7vIl6JLnyx3AVFe4T8kkOrSetYXXc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MqSO2PgcniH0PUP1l4DfhxY1rsVW9a4eQ4C67PuWpGkmUPmw8RZLQ4K2OXFyxnkWtlWMtT2fLjLwfIbjm7Zqo8uLCxoxitG1YiM/d1PjoICC3onLdy7ye9/9zgIP82TOzUodc/+Rl2p50vXLkp6hpH8CzoNF2dZ9ZtAX1ELiuXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nK00puUc; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-52c525257feso571242e87.1;
        Wed, 12 Jun 2024 17:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718237547; x=1718842347; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2dC12ioj9GImDlFvCZvgTh+Z1SR27gpojQmyo3A1jbQ=;
        b=nK00puUcEU6sroF0FApwKZBcc6bfyoag3tUcMBWW47He22igVUPuOZX6leIRH9ir1x
         j9OHdg3sryqLPAcq/IFXrH4bSRZF2mWOevqWK8OQxhkNhAihlE0Hje2hl6isDbzGSHzw
         uxezGPZEYAtGSBHFAN03vO38jMRkU+Xu7YFOPs1VfXfIbgMzKdmF7Hv4N6wshumdPigJ
         b+wEu0PKh+3PDjMdpAuhIzrUEbGgdUkAZp78LA7wfuflGo/0nLRJFgX5CcbNXPTXjJfs
         d2vome73Pkoc39b1CUX0umrOLcpM+IFhwGslO+5BWzrTpzbRWPo8KmEI2u6pfq8E3CSM
         UWUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718237547; x=1718842347;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2dC12ioj9GImDlFvCZvgTh+Z1SR27gpojQmyo3A1jbQ=;
        b=Jo/zlnxOkoPHns7BjMBLYapirWnnc4naM7OtV+JSkCFltZzUC8q0nH/MynIFjbEeMd
         Nja+VlH99zelZrHJlPiPVZSUFd3CdWnNFBPqws5DTPI7Gm9yAACRqW5wrNe1n2ej0oNA
         mMYeO0WD8c+nCSeVqA7AYV1PsPUT+EtVK8Qgezh7cBzCkZYAudNNdOk7gc/zsX94isor
         Wx/HssV0oNaTUPJdh2CCOBpxgEV5nQI1y1q4VNFNLGtkfn2imJ7nHD+J/H87VX4ngR4C
         RyGKydI8kjGrTU0qvZyny1W674sSeHYvB1iVP/n3vUqREAt2lLDK6H9bize4f0gPn3e2
         vdBA==
X-Forwarded-Encrypted: i=1; AJvYcCUk4auvh5GhvhXCXY2CR2aWzn2JEsTcnjtsyCbwE3dUOdmSfYCuJDTCQY82Qkjz56GO3IfDfy4NXtCqJylAmrvD7Moubx7UwaXGvHF9WD+3gfxX/bHUKW8IMxyfEqjghUus+jZQQTh8AzTZ2w==
X-Gm-Message-State: AOJu0YydjBLnrNdtZREyQ1t3+Pff3TwRAQI3WvjoMLPfMDSOFEaZNKO2
	z7XahuLw8Hk5LdFISeGj0FywaKqEen/w5AhR16CCNcw0Fq/SKniH
X-Google-Smtp-Source: AGHT+IHm6qNDfQ97rAv3j6FbiuObVnBhMcuQdvorNn8UHNzX1OYdhtdCqDA1heVH5Y2GaGKiGKayvg==
X-Received: by 2002:a05:6512:690:b0:52c:9d99:cd04 with SMTP id 2adb3069b0e04-52c9d99cf20mr1798792e87.51.1718237546568;
        Wed, 12 Jun 2024 17:12:26 -0700 (PDT)
Received: from f.. (cst-prg-65-249.cust.vodafone.cz. [46.135.65.249])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-360750f2489sm145114f8f.69.2024.06.12.17.12.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 17:12:25 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: torvalds@linux-foundation.org
Cc: brauner@kernel.org,
	viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH 0/2] stop lockref from degrading to locked-only ops
Date: Thu, 13 Jun 2024 02:12:13 +0200
Message-ID: <20240613001215.648829-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

... and speed up parallel lookups of the same terminal inode

Hi Linus. It is rather unclear who to mail concerning lockref. Last time
I had issues with it (the cpu_relax removal) you were quite responsive
and the resulting commit is the last one made there, so I figured I'm
going to rope you in.

lockref has a corner case where it can degrade to always taking the spin
lock (triggerable while benchmarking). In the past I sometimes ran into
it and ignored the problem, but it started showing up a lot with my
dentry patch (outlined below). I think it is time to address it.

The dentry thing moves d_lockref out of an area used by rcu lookup.
This provides a significant speed up when doing parallel stat on the
same file (will-it-scale, see [1] for the bench).

Results (see patch 2):
> before: 5038006
> after:  7842883 (+55%)

> One minor remark: the 'after' result is unstable, fluctuating in the
> range ~7.8 mln to ~9 mln during different runs.

The speed up also means the vulnerable code executes more often per
second, making it more likely to spot a transient lock acquire by
something unrelated and decide to lock as well, starting the cascade.

If I leave it running it eventually degrades to locked-only operation,
stats look like this:
> min:417297 max:426249 total:8401766     <-- expected performance
> min:219024 max:221764 total:4398413     <-- some locking started
> min:62855 max:64949 total:1273712       <-- everyone degraded
> min:62472 max:64873 total:1268733
> min:62179 max:63843 total:1256375

Sometimes takes literally few seconds, other times it takes few minutes.

I don't know who transiently takes the d_lock and I don't think it is
particularly relevant. I did find that I can trivially trigger the
problem by merely issuing "ls /tmp" a few times. It does depend on
tmpfs, no problem with ext4 at least.

Bottom line though is that if the d_lockref reordering lands and this
issue is not addressed, the lkp folks (or whoever else benchmarking) may
trigger the bug and report a bogus regression.

Even if the d_lockref patch gets rejected I would argue the problem
should be sorted out, it is going to eventually bite someone.

I wrote the easiest variant of the fix I could think of but I'm not
married to any specific way to solve it.

If the vfs things is accepted it needs to land after the lockref issue
is resolved, thus I'm mailing both in the same patchset.

[1] https://github.com/antonblanchard/will-it-scale/pull/35

Mateusz Guzik (2):
  lockref: speculatively spin waiting for the lock to be released
  vfs: move d_lockref out of the area used by RCU lookup

 include/linux/dcache.h |  7 +++-
 lib/lockref.c          | 85 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 91 insertions(+), 1 deletion(-)

-- 
2.43.0


