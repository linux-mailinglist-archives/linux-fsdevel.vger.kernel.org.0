Return-Path: <linux-fsdevel+bounces-28748-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6B2696DCE3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 16:59:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92E6C28965C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 14:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 805ED1773A;
	Thu,  5 Sep 2024 14:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="1APLUSii"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C23819FA9F;
	Thu,  5 Sep 2024 14:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725548259; cv=none; b=lbfhIb3iFLCj3ymXjBTMavgyWszW9FhFjstGIRLTNV9VNrMRdvZ81JulcybIp/KANGmlw3o6tnuxF5R3m/u3//YzNgF3NDMOf8Ml2id8qrN/SvvXpxKxPuKn5f+MZBIoM8M0dw/OMsiB3p4o6fVtNDH/5khmY38waYHWSrvEx8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725548259; c=relaxed/simple;
	bh=c4dE2X3D8jNW7VIHknDX4GKLOebCJIX98K1SweWgq9g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PT70VYE4QltR/VtpP6CSQzJokjYSHbEm3gZ5tUZasj8og4YE414R8uD0cgDhWCCZ5ja6UC7GPq+KnyoydLXuwrxJteE0bKS0QeLjhkRG/54mvMXguQpMjTYpWzkNR+SEVK2BiLW/RX1A5S/dbildSO2h+21BXgmdfYvulgJ3efc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=1APLUSii; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4X02XG3Mk0z9sFb;
	Thu,  5 Sep 2024 16:57:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1725548254;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YeczAUMJPFpgcChSC2NOpYh4duarO6U/B6665/OuVEY=;
	b=1APLUSiiNnoQ4talzWKkqnujLD2aR3XzevHzztypI+OPLTuF0cwE8pAsyi2lDnhIRrUTbd
	mo+yDzMwyCzX5T7EccrmDVs0o9QIr1mYRuzL8A7ShQLU+g6v2F+V7wI33oKYlMpnoUxJyG
	9V0b1Xd96NGpeCBxI8qNF4uPO6wLAB6WjXRP0QIY7KglbLQHc5jMkkNQOGb6csRLgo4XRc
	YkY3PahRRodtLKgGSfKoW6d56jkqft9zJ9pi+5Q6yx/AoVSmOLONkVbeVHH4K4poAU592n
	6AKHxSkBcsiLyiuSeybuXYqncGaXCV+6JaAv/wAY2iaPEB1TGSC3aIeLtPi4hw==
From: Aleksa Sarai <cyphar@cyphar.com>
Date: Fri, 06 Sep 2024 00:56:35 +1000
Subject: [PATCH RFC v2 03/10] openat2: explicitly return -E2BIG for (usize
 > PAGE_SIZE)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240906-extensible-structs-check_fields-v2-3-0f46d2de9bad@cyphar.com>
References: <20240906-extensible-structs-check_fields-v2-0-0f46d2de9bad@cyphar.com>
In-Reply-To: <20240906-extensible-structs-check_fields-v2-0-0f46d2de9bad@cyphar.com>
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
 Juri Lelli <juri.lelli@redhat.com>, 
 Vincent Guittot <vincent.guittot@linaro.org>, 
 Dietmar Eggemann <dietmar.eggemann@arm.com>, 
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, 
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Arnd Bergmann <arnd@arndb.de>, Shuah Khan <shuah@kernel.org>
Cc: Kees Cook <kees@kernel.org>, Florian Weimer <fweimer@redhat.com>, 
 Arnd Bergmann <arnd@arndb.de>, Mark Rutland <mark.rutland@arm.com>, 
 linux-kernel@vger.kernel.org, linux-api@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>, 
 stable@vger.kernel.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=891; i=cyphar@cyphar.com;
 h=from:subject:message-id; bh=c4dE2X3D8jNW7VIHknDX4GKLOebCJIX98K1SweWgq9g=;
 b=owGbwMvMwCWmMf3Xpe0vXfIZT6slMaTdPLb5Uuwxl4NWleL9dttyrX9V5eVd5W+es+HB79mS5
 nOKbRhXd5SyMIhxMciKKbJs8/MM3TR/8ZXkTyvZYOawMoEMYeDiFICJ1Hsw/OG53fk+QyqnT7Tu
 mPm/idOOum2fcPPBconnNv4pTOrlS1MYGT7zst2W+fxVZMaRry9y5Xcs7r9X8VNRs2SSy87GtHU
 cyewA
X-Developer-Key: i=cyphar@cyphar.com; a=openpgp;
 fpr=C9C370B246B09F6DBCFC744C34401015D1D2D386
X-Rspamd-Queue-Id: 4X02XG3Mk0z9sFb

While we do currently return -EFAULT in this case, it seems prudent to
follow the behaviour of other syscalls like clone3. It seems quite
unlikely that anyone depends on this error code being EFAULT, but we can
always revert this if it turns out to be an issue.

Cc: <stable@vger.kernel.org> # v5.6+
Fixes: fddb5d430ad9 ("open: introduce openat2(2) syscall")
Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
---
 fs/open.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/open.c b/fs/open.c
index 22adbef7ecc2..30bfcddd505d 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -1458,6 +1458,8 @@ SYSCALL_DEFINE4(openat2, int, dfd, const char __user *, filename,
 
 	if (unlikely(usize < OPEN_HOW_SIZE_VER0))
 		return -EINVAL;
+	if (unlikely(usize > PAGE_SIZE))
+		return -E2BIG;
 
 	err = copy_struct_from_user(&tmp, sizeof(tmp), how, usize);
 	if (err)

-- 
2.46.0


