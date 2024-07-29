Return-Path: <linux-fsdevel+bounces-24396-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB1D193EB8C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2024 04:46:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06CAF1C2091E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2024 02:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9015D7F460;
	Mon, 29 Jul 2024 02:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l1LU+YIr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C90A1E49E;
	Mon, 29 Jul 2024 02:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722221149; cv=none; b=VXaWqMZrt4xm/QypMWhEnjfEegclDULEib0iEo/p2rrb4vf0IEWKxfwVYwe3N/ns8pUinjvsVM+tRJ8/pCfZ+55gMty1iCdd5aANOdaiOgrZ811cQnEutIvvbk2/1T/H3SFIruZ7kDKrEso/sxIColKZRi+ZyZop43c6C4heDd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722221149; c=relaxed/simple;
	bh=bu1CYcoPH46NrrB7Vm16hCPiv2fWyMUG+bX0JU8hjFk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gV9c63Sx339scu1zVYwIgsIqNIYl4XBD7QRpKkP2jRTgqrrJeHoKxcrhgC+cbt0YOkmrx7YhNDiJOcVUiQZ+pmibuxzhmtMbGdQzVVlwmQVhAHwney08a47YtbXZB2HzFS+JQPjo1goRhVMYDMiUN2vNZKuV/Fm6MuVDpkAFTaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l1LU+YIr; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2cb5b783c15so2068737a91.2;
        Sun, 28 Jul 2024 19:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722221146; x=1722825946; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K/nz1JHR4z8p+ajw1D912vGA5V6XqUcGmzMFKN4JA2M=;
        b=l1LU+YIrgxQ/w23/lHuZMEnVIIgeqXniqWP1GrVE6Wsu5uaYzKIKP3hZ96c647zyeh
         uMToPH/81S6ya2N/GfZttnPGQt/beMMMARjLY5j26Ic7tn5ayp56/vLneY71YKaj6ZqN
         4hP/th9enb26x7VuTjyJ/tYaAC1U6Ry+wUgUF6mnXY125i7ppJn53hDhL0PDZQmxvAVw
         WppokQIYgiPnWA+yThUwcsFtprqr3OPZbnMWuPnEoM8V76v0RbISYMv6Ams+Q81YiFYl
         UTyCGJ/dmIUpoAUU+CwWdubkTUc3BwjPeT4uo45U45BXLbplPSbFoLJanWHy+M5bEqzc
         NmRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722221146; x=1722825946;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K/nz1JHR4z8p+ajw1D912vGA5V6XqUcGmzMFKN4JA2M=;
        b=oqZAW+BhCzJInWE9akTHzGzMoo8zfpPkIeEAKtN1i1MgYqbNmIphvB4We6p4KlBv4r
         Be9giyEWuHzPDLV/q1ag57C0m7AgdXYUwPU8eW8/rLNlQZ5SfnxRpi+FqGyU/CCNI+tD
         p4mfuujA6122t5of31l1LHqaZCJZ4e9B7HcAv5mSCgdfFtunH5DmR4kBRTBqMqwwljPi
         o6aq4G6XITNkQV9OuHaO9f4T1BS/gVEp4qoPb0TGXkchh8fK07ipA/hAndVgEBzGUFiZ
         aJ5mRzjSwQZUjzO4XORFo47MdCd4lT+GRDbghKzXPWEHjTYTJbFlQut7pIktLi3SOotL
         TNgA==
X-Forwarded-Encrypted: i=1; AJvYcCXPjXRdXAXoIHOyl9LNhWCtKgjUkbL+aTCX5VtT8oKfr37yTssgMimu5FL+O5ktBVuNC/Psh3UlTkzy2lXF/F0ME9N9FvHAluzUYx7i0FKFVe3/DAokHeSYFAHVy8Gi6vbKWbLaOerp9TC4FAmmoWe7O16b6zZODoASOr9tEeiXXwCPgk977dqwe/QRQ2ZRblXhQYMUK5aBKBb5i+xRkyADTNZLrAn1wphOz/hzfVMwUazV1vOO+AXkJiF7WWYhE7XTsRRch4EHon8nCOZZyYaeNnDC3DmBljcPUjvTgGxAozJu/YtSyoUNfisx44xBXN8IoFMjnw==
X-Gm-Message-State: AOJu0YxhsMT5jxTTpqiuSzq4lrTlU15AmvI/6xA1i4JqYRvS9wa4Cmmr
	s8s32CZU44nlDE9ArIzNf70voph6fTf2gRHet2Cjjz/mCCW6yW4s
X-Google-Smtp-Source: AGHT+IENkAKdnpSBtIYs5HSWqyoiT1QcCfPMYBJH+JoZ3TUHyUdae/0TZfvoMrDMQbplggd9XcCiAw==
X-Received: by 2002:a17:90b:4a03:b0:2ca:4fca:2892 with SMTP id 98e67ed59e1d1-2cf7e095c49mr6901128a91.7.1722221145808;
        Sun, 28 Jul 2024 19:45:45 -0700 (PDT)
Received: from localhost.localdomain ([223.104.210.31])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cf28c55a38sm7332247a91.10.2024.07.28.19.44.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Jul 2024 19:45:45 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: akpm@linux-foundation.org
Cc: torvalds@linux-foundation.org,
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
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v4 07/11] mm/kmemleak: Replace strncpy() with __get_task_comm()
Date: Mon, 29 Jul 2024 10:37:15 +0800
Message-Id: <20240729023719.1933-8-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20240729023719.1933-1-laoar.shao@gmail.com>
References: <20240729023719.1933-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since task lock was dropped from __get_task_comm(), it's safe to call it
from kmemleak.

Using __get_task_comm() to read the task comm ensures that the name is
always NUL-terminated, regardless of the source string. This approach also
facilitates future extensions to the task comm.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 mm/kmemleak.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/mm/kmemleak.c b/mm/kmemleak.c
index d5b6fba44fc9..ef29aaab88a0 100644
--- a/mm/kmemleak.c
+++ b/mm/kmemleak.c
@@ -663,13 +663,7 @@ static struct kmemleak_object *__alloc_object(gfp_t gfp)
 		strncpy(object->comm, "softirq", sizeof(object->comm));
 	} else {
 		object->pid = current->pid;
-		/*
-		 * There is a small chance of a race with set_task_comm(),
-		 * however using get_task_comm() here may cause locking
-		 * dependency issues with current->alloc_lock. In the worst
-		 * case, the command line is not correct.
-		 */
-		strncpy(object->comm, current->comm, sizeof(object->comm));
+		__get_task_comm(object->comm, sizeof(object->comm), current);
 	}
 
 	/* kernel backtrace */
-- 
2.43.5


