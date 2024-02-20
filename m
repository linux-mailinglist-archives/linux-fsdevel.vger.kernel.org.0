Return-Path: <linux-fsdevel+bounces-12085-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72DD385B23A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Feb 2024 06:24:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB2C9B2245E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Feb 2024 05:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A77F756B8A;
	Tue, 20 Feb 2024 05:24:41 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.nfschina.com (unknown [42.101.60.195])
	by smtp.subspace.kernel.org (Postfix) with SMTP id CC6B64437C;
	Tue, 20 Feb 2024 05:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=42.101.60.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708406681; cv=none; b=gmL1uFTgTFWVSgrikkYpnX8KkYNbKvlrZyIwV/hoSkcQpQ0qPbDbopzrftkCj3Zfxa+6RzST3Kbcm5WeLX3Kb+xg2itojxim7vICQM/mGH1WCeLWytk/wWHL+EiNvvk+hm1K+CCs4bWId64jaEBIuSQCNjSR41m9Ue2MeuoDrB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708406681; c=relaxed/simple;
	bh=a5OnPmoIxcMAgsvJWu6bEk2PslH7RK1XO/2kMFPZSD0=;
	h=From:To:Cc:Subject:Date:Message-Id; b=Ac0aAtqtHK9SQE4RWtQ+2iI+KRByM3GK5EC13i3/E0O/C6xvxURUH4a4lHUwcrqBXJxPW/3ZOdY7iroy1/hrYeqypksrmhBGR3K/7Yb8bKl/fhXot6DEiUKrGWsNsBkzcigdwm65Fr+iqFbOkOKFQiOHuRPO89S0I372NYzCeIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com; spf=pass smtp.mailfrom=nfschina.com; arc=none smtp.client-ip=42.101.60.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nfschina.com
Received: from localhost.localdomain (unknown [219.141.250.2])
	by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPA id 1D4A7602610D4;
	Tue, 20 Feb 2024 13:24:33 +0800 (CST)
X-MD-Sfrom: kunyu@nfschina.com
X-MD-SrcIP: 219.141.250.2
From: Li kunyu <kunyu@nfschina.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	ebiederm@xmission.com,
	keescook@chromium.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Li kunyu <kunyu@nfschina.com>
Subject: [PATCH] exec: Delete unnecessary statements in remove_arg_zero()
Date: Tue, 20 Feb 2024 13:24:26 +0800
Message-Id: <20240220052426.62018-1-kunyu@nfschina.com>
X-Mailer: git-send-email 2.18.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

'ret=0; ' In actual operation, the ret was not modified, so this
sentence can be removed.

Signed-off-by: Li kunyu <kunyu@nfschina.com>
---
 fs/exec.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/exec.c b/fs/exec.c
index 7be0527f5ff25..10309a93d9c52 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1747,7 +1747,6 @@ int remove_arg_zero(struct linux_binprm *bprm)
 
 	bprm->p++;
 	bprm->argc--;
-	ret = 0;
 
 out:
 	return ret;
-- 
2.18.2


