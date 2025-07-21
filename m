Return-Path: <linux-fsdevel+bounces-55577-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E291BB0BF9D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Jul 2025 11:05:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FB293B19CD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Jul 2025 09:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25BC928934C;
	Mon, 21 Jul 2025 09:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Uou7x8jZ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IG7I1MF0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 231981D63E8;
	Mon, 21 Jul 2025 09:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753088708; cv=none; b=byOCNzoHlkjTtV6/Sbdv4HcBwn4aHsKXbgWktu+3lDryvLzdtBjkO8CjCEDKLUmT4WbPPIfWCyPV16qHiuylSDe+EYb56s6YGH+LkuHpMMVr7hs9EEfDJovmw/h3tvDFhifGO/NTdWUKQjgr914+Wwj45XcBdqGTUBu1X6nsK9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753088708; c=relaxed/simple;
	bh=iKNC0pMt5usZxRe6KBIzfvsmbzB6g1SVSgc5lPdZWJI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=co0DClv2+QLbKphc5UBeyHufa9cvbMpGwx90Fqriz6VuQ5L80u/HY2eQXAHFztgZKMQpNJNn4xjtMFpBRAttAG2R/EJnXbnu0y1ycqfqEc16Jc+iMM7TfGVVjj8/lKNKwvvx6xfebyaZH30O4ZsMWiR9SYWxfRPX75fGoOudO8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Uou7x8jZ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IG7I1MF0; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753088705;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OvYWtNTJ1OIPBDLhxhB6E6BqwU6ZzvJB6F2cYA5R1+A=;
	b=Uou7x8jZtGkuAav+e0SdWwcRQlU8uhery1SvojD+tcgYLJEBMnTUDOKD6haVF+Q+d4SsLo
	7zWIJGjEmZIwkykQD7lslDMhBN09hMKpmT2OhBc+nspKG0XvyDGUiv6QujJ1UKvtdFKln7
	AhgRl8vj3ugbtBSW8B2k045p+OSdWb1RJFuhqMjsxNkfMJ4FY2dTKJYd493Nsqe8KGGNLo
	f5iPilO30paoKZ7SzvO39aVYOoXjZn4qXTX2FWFnfRpmTl0LGYV2p5Uq42CUhyzgk9b9XQ
	uS8GEIL3Qxp4q60VOSv7UTDCS76E7cmJcKEDe3GsL3zbrSQjBnaEHtidw6fSZg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753088705;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OvYWtNTJ1OIPBDLhxhB6E6BqwU6ZzvJB6F2cYA5R1+A=;
	b=IG7I1MF0cuSXfcjR/awJQ6uicAJdLFd0G8HGF9dxVfITk5/A6ZcyxrrExGX1c7Ns9W5X4k
	TvmQCH5QXvX3AHDw==
Date: Mon, 21 Jul 2025 11:04:41 +0200
Subject: [PATCH bpf-next 1/2] bpf/preload: Don't select USERMODE_DRIVER
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250721-remove-usermode-driver-v1-1-0d0083334382@linutronix.de>
References: <20250721-remove-usermode-driver-v1-0-0d0083334382@linutronix.de>
In-Reply-To: <20250721-remove-usermode-driver-v1-0-0d0083334382@linutronix.de>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, 
 Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org, 
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753088703; l=914;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=iKNC0pMt5usZxRe6KBIzfvsmbzB6g1SVSgc5lPdZWJI=;
 b=ucBfsz9QWoa3+fEyYxrGe3jaFJ5u3zac2sOjgAX9glb+dOeg7x655T6OlsNUGcns/JLLH6Q/C
 EUvVwqBMRdOCEAOPZLrsI7/LSuxU9uEc5ZAK4DSefp0NNNQb7tBEqYT
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

The usermode driver framework is not used anymore by the BPF preload code.

Fixes: cb80ddc67152 ("bpf: Convert bpf_preload.ko to use light skeleton.")
Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 kernel/bpf/preload/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/bpf/preload/Kconfig b/kernel/bpf/preload/Kconfig
index c9d45c9d6918d1402dab634e280b56c5c929a858..f9b11d01c3b50d4e98a33c686b55015766d17902 100644
--- a/kernel/bpf/preload/Kconfig
+++ b/kernel/bpf/preload/Kconfig
@@ -10,7 +10,6 @@ menuconfig BPF_PRELOAD
 	# The dependency on !COMPILE_TEST prevents it from being enabled
 	# in allmodconfig or allyesconfig configurations
 	depends on !COMPILE_TEST
-	select USERMODE_DRIVER
 	help
 	  This builds kernel module with several embedded BPF programs that are
 	  pinned into BPF FS mount point as human readable files that are

-- 
2.50.1


