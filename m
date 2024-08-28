Return-Path: <linux-fsdevel+bounces-27496-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5B38961C99
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 05:04:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A21C7285347
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 03:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9437643AB9;
	Wed, 28 Aug 2024 03:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HhcW4YYu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43EE13BACB;
	Wed, 28 Aug 2024 03:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724814248; cv=none; b=gP5K8t4SG5uMz8LXIJQZcqlgo/P1t0Ql+c6UoKe8mfbT7glKV2Y8Q/UIClK9glsPwUq7bSA9urVryaJYtjzxdnJ2lsR/EuTujJq2yvSEF4unoGz7rE9zeofju/6FbL2+xhIM+zoJQw1kdkucqKc0Af8ukSVmUYyVxLi6TI7fSSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724814248; c=relaxed/simple;
	bh=56ESQtaoBbBqZU/saKgTljkr5U/isylgWUhSQpUUDZM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gheBdwoXtHVfkoNUJFP6S1/tjNt/MMKZrk+6X8u0wIC8GN3RIkpIu7XlKJrj9DMybfClhHM4xNNewRq/ufvKkIb+vpVMp6NxbH7qdjWt81EWeQUXB08nkvVGvfcXY2UtkibEMhzH6Z8yeN3Tkqk3ejEBQEGYyMHJ1tX4PPAavw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HhcW4YYu; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2d3b595c18dso130048a91.0;
        Tue, 27 Aug 2024 20:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724814246; x=1725419046; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QQdkC9XISn7BWPlTE5/iE7aUj/L2jeLonKoaBsbNpS0=;
        b=HhcW4YYu8/USBGyVJ+zTZSsOoWr2MhH1FufFaiuA1Fb0VP2O+I4aEhMaB8r0hdNPto
         KhHV/jCBPDPX0S/0+ARkH4n6xNOAkbL/LdCgijK3kEfTNh3o6TCDmRLrFGnb54YOQABF
         vlrAAY1b0kFKkyZHW4nEmHytFwlGf4+0fzElecIdwZ/1FYIxP4zXmkzTALtqIrO/5Q5t
         y1+0h8ivUfZMZAigr+6BDg55DlSnlvuoUMEzKFL4bWrlSNfhj4YBYDxZM5F4UOtXJkUT
         oKkl4RrYE4rn5KpgB0F+r/gzrWGEPzMC2CzveyqpNz3AamiBaYnIsx/yCZf9hq9FF6X/
         earw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724814246; x=1725419046;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QQdkC9XISn7BWPlTE5/iE7aUj/L2jeLonKoaBsbNpS0=;
        b=uvDvkDX2Vuuutl8DgfKNcuL+oR7aQBzSQIuPanniUDEWu1P/GVb+AzCHw9QjvM5K0h
         v/kiUPPKKwmuKtaYIeRKLv+B4qhPLk1Mo1vWY5AwfwmxjKW8RKS2nJ7h/LmH63RXloj/
         GChwwVo7J4zWoVI2+0FqeaJKLYC0UMSUD5LMmBhIjPlitMJuNVYAUMSVdyZ12pg1xj37
         6T+z3fY1H0Hge0KV+VGHE5taAKSH/q2UvivRErat18pNPqzgNy9u3c+RYExF4SAr+HuE
         A4whVKxGrZ9l/5fKVZmIdrq8Jd9Ke6tzJneX34In3FUhmhHTfBvpMepHktk2LSZb5Bfz
         3U7g==
X-Forwarded-Encrypted: i=1; AJvYcCU89CKuWWu9iqSQdTrXna7Krzsg1cLMkgo/h0m/AL3I3Ry+/rf0e97R05xKJVivgFbfju1q@vger.kernel.org, AJvYcCUObRj4d5UegTrTvn/9fhM6ttjqL56ZDHn4fnibIs2QaOiAIS+4e0R5at8RvtgmDlzq09q9DQ==@vger.kernel.org, AJvYcCV3keT07imD6RxVPjOBmImFicLxBApt8VV363sIlGzFBXV0Ren4s5rs213MkFyFO+dxEfL1HTaepQYffMnMFg==@vger.kernel.org, AJvYcCVJdXVpxKiNUJrrDXCncqQpYomASD8Vd9JZ+TMvdi0a0JI50nyCdYPtdlnOM9p1AvO2uBYeWjq6@vger.kernel.org, AJvYcCVSsIkyff4UMq+QmwVs6+pyFgeSzJHrZO9Zl504ZGOzd+S0z9UWMG0nG9J+lnu0SCVGVo35KGl0fB2UI40gdgNJ9lMV@vger.kernel.org, AJvYcCVuPfJtHIXUMIGWc+fvAW93mkMZ7QXjUmbzwmuqskodZCIy9qnNoYmb82cyv4OlGG+yM5pkXn/HH5QUmFBGCZYbGGgUntiv@vger.kernel.org, AJvYcCXV4oW5CXp+TkeOo4DIDpBRi85iRpvX1TG6iqcktSZfJ7YDltviznSvFp4SbdMmHRfZBavlBmOIrg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxDnq+/AQXrIMmWRsPhAiLrYIcCQQiEwLrenxYmoyJMgNoekl2j
	027ov+7E8TzNWgyH6L4BbfEbQsdgCh5dpI3LyYHZIpJwCzR8jVoq
X-Google-Smtp-Source: AGHT+IHxaydVqwv10Tfh2ak5vjo3hT38eMV2JYlayqlM6cQqHxMPAOmu6Mb/QjPRAxpmFPgYrqTvlA==
X-Received: by 2002:a17:90a:304b:b0:2cf:f860:f13b with SMTP id 98e67ed59e1d1-2d843da1884mr1305336a91.17.1724814245904;
        Tue, 27 Aug 2024 20:04:05 -0700 (PDT)
Received: from localhost.localdomain ([39.144.104.43])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d8445db8f6sm317977a91.1.2024.08.27.20.04.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Aug 2024 20:04:05 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: akpm@linux-foundation.org
Cc: torvalds@linux-foundation.org,
	alx@kernel.org,
	justinstitt@google.com,
	ebiederm@xmission.com,
	alexei.starovoitov@gmail.com,
	rostedt@goodmis.org,
	catalin.marinas@arm.com,
	penguin-kernel@i-love.sakura.ne.jp,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	audit@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	selinux@vger.kernel.org,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	Yafang Shao <laoar.shao@gmail.com>,
	Quentin Monnet <qmo@kernel.org>
Subject: [PATCH v8 4/8] bpftool: Ensure task comm is always NUL-terminated
Date: Wed, 28 Aug 2024 11:03:17 +0800
Message-Id: <20240828030321.20688-5-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20240828030321.20688-1-laoar.shao@gmail.com>
References: <20240828030321.20688-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Let's explicitly ensure the destination string is NUL-terminated. This way,
it won't be affected by changes to the source string.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Reviewed-by: Quentin Monnet <qmo@kernel.org>
---
 tools/bpf/bpftool/pids.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/bpf/bpftool/pids.c b/tools/bpf/bpftool/pids.c
index 9b898571b49e..23f488cf1740 100644
--- a/tools/bpf/bpftool/pids.c
+++ b/tools/bpf/bpftool/pids.c
@@ -54,6 +54,7 @@ static void add_ref(struct hashmap *map, struct pid_iter_entry *e)
 		ref = &refs->refs[refs->ref_cnt];
 		ref->pid = e->pid;
 		memcpy(ref->comm, e->comm, sizeof(ref->comm));
+		ref->comm[sizeof(ref->comm) - 1] = '\0';
 		refs->ref_cnt++;
 
 		return;
@@ -77,6 +78,7 @@ static void add_ref(struct hashmap *map, struct pid_iter_entry *e)
 	ref = &refs->refs[0];
 	ref->pid = e->pid;
 	memcpy(ref->comm, e->comm, sizeof(ref->comm));
+	ref->comm[sizeof(ref->comm) - 1] = '\0';
 	refs->ref_cnt = 1;
 	refs->has_bpf_cookie = e->has_bpf_cookie;
 	refs->bpf_cookie = e->bpf_cookie;
-- 
2.43.5


