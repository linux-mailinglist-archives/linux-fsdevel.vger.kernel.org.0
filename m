Return-Path: <linux-fsdevel+bounces-58377-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 67E86B2DAB7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Aug 2025 13:19:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4483E5C1341
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Aug 2025 11:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A1612E3AF0;
	Wed, 20 Aug 2025 11:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="UfDho3dH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB582E2EFD
	for <linux-fsdevel@vger.kernel.org>; Wed, 20 Aug 2025 11:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755688786; cv=none; b=KqIc4KIowN+JwcUQZFoSmLJ0h2pCs9jiDAni8A85fEWoj42AZFdNZC5NaCt4FDZ0ectyRR6HZBK+e5JOALs4cteBYjS+VxDdN8/QtkguWeicCzHU4Lr6z+BUYNTFzEognegvFRtEYfMCvLzHjperyiIynqAqIduyZwyejM8ZD1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755688786; c=relaxed/simple;
	bh=KaQ9auFfWLXLrFtqqYpe03HYn25VyYsifWwwgHBKCp8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=qEmLEZ77geMAbF82vAE603gR42YBT7u9T5XSAi49Cg1DfEJ8LYKWNKOC2IW+zfnxQlmwa3ZKslRHrgRiPjbTAlUyRyZU4yvWXcte3xn7pVXg+r20xN4RzcRPXUhGEBuEJUSaWvOWqYe1pSksq5PRGwaD59BsEEp+eiJavw9heBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=UfDho3dH; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-32326e66dbaso4424258a91.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Aug 2025 04:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1755688784; x=1756293584; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8nzxfwrJ7tgF8TbO628wBC8gRICp1yIHaSa6RvJ5d0k=;
        b=UfDho3dHMzWdBeHwChSE0YocxX7s6yZI5Wdhkm8/WjswyBVLemq1HFdDssybUNzdq4
         dxcCsPDcPlkFIStr0pCQQqP1w99pGT8Tza7jQZjKD5qbBvSr1jquhePABzGAT6Frjomc
         3lCIkxZ2nsH9Jm0vB0LrGmVE5Ehed08KKUJ7jhXKMziGpkKiL7+EKbe+t3c4avNNQuBj
         NsAhH3SIRUpLF9G9eHp08uEtkIo1yxlbfs4dPDiiWQPOyeN4GfQKjp6+lV9VU7xhwcEX
         SQHgC8A0PBn0hjrLXdzUmRUYjpV5duYhn7Pa12fZGvDj6gQ1cwpSSR6suDuaGH022KJz
         DcXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755688784; x=1756293584;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8nzxfwrJ7tgF8TbO628wBC8gRICp1yIHaSa6RvJ5d0k=;
        b=In+N+Yhutl5/4A87gYq4a4TqoMERx0jIDQWJ81FhYpyXfxkfEFT9VwCN4tA+9MoYVU
         FUgKDkJUuWLXGSvNqCLyrs/NbZlmPR66uQdRXwm/1x0DJcOEk3hiPoTfn9FmTF2UQwR3
         IuV8mOY/zO+38Oesl4YD6tDZyR3wLuj8amGFys9hmPjzKl/GytU9Wpu6roxatGuRSM/y
         DLEHlwJZJNzlUTblctMEKxgKiZf0kAtK9CWUMfsdWfR/psqt7xk86yht40RB6LELzS4e
         5HQlJXEXOy0hLSA2pKWlP+O95KZNF7bp+5jmEWyftnkSlgJpt6Z0pvPrQwF7UvFxUfRM
         8eNg==
X-Gm-Message-State: AOJu0YzydYl44IraqteKljtcQ7XrSaCBVEKKmH5Bl+yUY7yORJrqTp62
	Ed7AWSF08xbmN1zitQhFKrMAOGmsu1P08kjRKA4aJrn8INZJ9gQVWapym4TvYcJKfrR+biA+hxT
	MGyJWYNk=
X-Gm-Gg: ASbGnctgzzjsoOKhykk00E4FA0OPAKXTMWqUpVzWvx1Dm2BsW0U27Xj6q9n1XYpyY77
	aYWA6hDlDg/EfeZVfrQGo1aZYOajqxN7AvQR5txDCtdcDFAhtAkYtSCkw9/FXfl4VcpPhoq1Kik
	ZJ9UVxHhbf/VzTdrkqZV6U8IBtEpsCulJv4APUXHAMLS+uE5DnUB9/nswVdcaf7IYMai8ZZ5vSg
	IJNnr4xLuucdq55msebd6GjcKp9RA593+D5gM2gpvsNnNgQEySnV5bvPZiL4VXn6ejJ4DMBm0zK
	SEJTBoY2kiZL698MEEFW8cYVSiUTedEScV5cb+96sSk74ByElh97bzw82WjmlTEIsqVaggbIOt8
	OAagnCgEbbMje/Z068JZ001NAFkB8QMdbE0PRLRkYDA==
X-Google-Smtp-Source: AGHT+IFDp+oQlv/0Q/A7/4baOQAwYfujcstAPbmMtif5cwe4FhwyrJsEGhnc01bdJasIBQ+A45Febw==
X-Received: by 2002:a17:90b:5187:b0:323:7e80:881a with SMTP id 98e67ed59e1d1-324e1489895mr3679710a91.37.1755688783865;
        Wed, 20 Aug 2025 04:19:43 -0700 (PDT)
Received: from localhost ([106.38.226.108])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-324422a8bb2sm2827379a91.0.2025.08.20.04.19.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 04:19:43 -0700 (PDT)
From: Julian Sun <sunjunchao@bytedance.com>
To: linux-fsdevel@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org
Cc: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	hannes@cmpxchg.org,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev,
	axboe@kernel.dk,
	tj@kernel.org
Subject: [PATCH 0/3] memcg, writeback: Don't wait writeback completion
Date: Wed, 20 Aug 2025 19:19:37 +0800
Message-Id: <20250820111940.4105766-1-sunjunchao@bytedance.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patch series aims to eliminate task hangs in mem_cgroup_css_free() 
caused by calling wb_wait_for_completion(). 
This is because there may be a large number of writeback tasks in the 
foreign memcg, involving millions of pages, and the situation is 
exacerbated by WBT rate limiting—potentially leading to task hangs 
lasting several hours.

Patch 1 is preparatory work and involves no functional changes.
Patch 2 implements the automatic release of wb_completion.
Patch 3 removes wb_wait_for_completion() from mem_cgroup_css_free().


Julian Sun (3):
  writeback: Rename wb_writeback_work->auto_free to free_work.
  writeback: Add wb_writeback_work->free_done
  memcg: Don't wait writeback completion when release memcg.

 fs/fs-writeback.c                | 22 ++++++++++++++--------
 include/linux/backing-dev-defs.h |  6 ++++++
 include/linux/memcontrol.h       |  2 +-
 mm/memcontrol.c                  | 29 ++++++++++++++++++++---------
 4 files changed, 41 insertions(+), 18 deletions(-)

-- 
2.20.1


