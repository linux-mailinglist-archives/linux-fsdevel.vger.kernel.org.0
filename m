Return-Path: <linux-fsdevel+bounces-20903-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 967708FAAC9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 08:30:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B58A28B5DB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 06:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD385140E38;
	Tue,  4 Jun 2024 06:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Janm6h/L"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0509613DDAB;
	Tue,  4 Jun 2024 06:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717482600; cv=none; b=sxB6uXA6goj0qgCzhQ1dUb8auWjwgbfmzcG7zdpxAYb6fJ4naRSUz+fRyMd9E8rxeU5ol7b8D7+KUJQgxDLabfDiIGVsQy2tns8geEYFoYEfm+/AHgLpM004xQhrGzu4mAQEbRwcdrCYQzg42fQ7e+Omke9XCVIgq/ezen21/ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717482600; c=relaxed/simple;
	bh=vlte7/jFt4SHMLHwVPqBFv0PbVs5A4Gx+169UcJVYx4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=B3NWpO0lKUHNRMMKwErf2lGzqBI2KFRiXkolMeVsnWDSsB01lbwd1hef1R0Snsa2m2mLGTmkLge3tmz9y6WG4ET4PFhLJkHQIRWPnK1Iqgh39KE08NV6jmfsOwv5lBsLT9cKon4WlvvVRL6Qc5ATSBiY1Df8aWRDViCptGsHhu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Janm6h/L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9D302C4AF07;
	Tue,  4 Jun 2024 06:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717482599;
	bh=vlte7/jFt4SHMLHwVPqBFv0PbVs5A4Gx+169UcJVYx4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Janm6h/LdugNk9//EITCAQZDYPDw1vSnkgIxHRJuajbB1uhJNb70fHHifyUdgIwcd
	 Mg/HAMdxAw36cEdgsIlgBSdWy4Hc1od48ze7wM/QiaaAiTJzgstk8udBt6Zdg8/iOG
	 f8VuGNUzWuQKpYFFGRqCGi2qBuVHvmp/E7SYChkdTKQTlffnCQs8/lsca4Kg0BegZL
	 IM1CNUrig4EYtykD2DZQb1tjvma1ZoZXSYPE3wH1aCO3p6Z2ja0uG2BkYSqWU3Y4yB
	 6bsIl/ubhru7xQrDX8TdX9KSM4vlh1VmOObgZh71649aGA8FYEifSv59esu8EEoPN4
	 xSTPH1D/d4gTQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8419BC27C52;
	Tue,  4 Jun 2024 06:29:59 +0000 (UTC)
From: Joel Granados via B4 Relay <devnull+j.granados.samsung.com@kernel.org>
Date: Tue, 04 Jun 2024 08:29:19 +0200
Subject: [PATCH 1/8] locking: Remove superfluous sentinel element from
 kern_lockdep_table
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240604-jag-sysctl_remset-v1-1-2df7ecdba0bd@samsung.com>
References: <20240604-jag-sysctl_remset-v1-0-2df7ecdba0bd@samsung.com>
In-Reply-To: <20240604-jag-sysctl_remset-v1-0-2df7ecdba0bd@samsung.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Suren Baghdasaryan <surenb@google.com>, 
 Kent Overstreet <kent.overstreet@linux.dev>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Luis Chamberlain <mcgrof@kernel.org>, Kees Cook <keescook@chromium.org>, 
 Joel Granados <j.granados@samsung.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
 linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=860;
 i=j.granados@samsung.com; h=from:subject:message-id;
 bh=14739GNIvIP1jcOFEalMBBReb5ieHSFF2clMwb/AQoM=;
 b=owJ4nAHtARL+kA0DAAoBupfNUreWQU8ByyZiAGZetGJabxTBGOF4nHQDP1wm5ErY55X5yT1ko
 moGhHsQTVtxBIkBswQAAQoAHRYhBK5HCVcl5jElzssnkLqXzVK3lkFPBQJmXrRiAAoJELqXzVK3
 lkFPreYMAIXr/sxZeeYa1hpzMSQR+LDo1okDOTVaAB6RI94p35Ph0NodstJFVE8/a/F7z8yznfT
 zRGB5mwTfERvnAHoLRa4cRPV7deYGX2Lfl4gRBxx38VVMXVNXGHuX412vQ/HGw8IG9A/McpDk0u
 Z2K9H7mdffgtNOrik+M5doL2wo8aIl3n/ntCbrFS6KMi5BjMA6JTGcCKPQc09MMFN8iWCyUlpHv
 PO0MOmlqI+ydfIGKM3grwe0ygIghPE7rXbC+RmQ/CFoPVTtuysPBixbT389HdPi2kwZfc3yMdiG
 JqIDpGDgEfx6eBoHqPi9f6UjsZsRZ8uQjA3cPhNf2r57I/Ous7iFkFzWnm9lsT7juRvP2yBLdve
 Fsb5u3LI21rJQdi9hKHm+Qy0a7lF7daS5ISDeA9YiPhRmI4qFElN50yOxuLkzeWdOmUek/m7eVe
 mIrjNatEmaWnNaLmtaw3exq+Eoi54Rdh5QCBMA0GRO+dVR2JtZ85j6nhTdGkijeKFOoJQ/Vz+O5
 Xc=
X-Developer-Key: i=j.granados@samsung.com; a=openpgp;
 fpr=F1F8E46D30F0F6C4A45FF4465895FAAC338C6E77
X-Endpoint-Received: by B4 Relay for j.granados@samsung.com/default with
 auth_id=70
X-Original-From: Joel Granados <j.granados@samsung.com>
Reply-To: j.granados@samsung.com

From: Joel Granados <j.granados@samsung.com>

This commit is part of a greater effort to remove all
empty elements at the end of the ctl_table arrays (sentinels) which will
reduce the overall build time size of the kernel and run time memory
bloat by ~64 bytes per sentinel (further information Link :
https://lore.kernel.org/all/ZO5Yx5JFogGi%2FcBo@bombadil.infradead.org/)

Signed-off-by: Joel Granados <j.granados@samsung.com>
---
 kernel/locking/lockdep.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 151bd3de5936..726b22ce7d0b 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -97,7 +97,6 @@ static struct ctl_table kern_lockdep_table[] = {
 		.proc_handler   = proc_dointvec,
 	},
 #endif /* CONFIG_LOCK_STAT */
-	{ }
 };
 
 static __init int kernel_lockdep_sysctls_init(void)

-- 
2.43.0



