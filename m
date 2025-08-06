Return-Path: <linux-fsdevel+bounces-56818-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94509B1C042
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 08:07:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F5A1189EA3C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 06:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C90E221146C;
	Wed,  6 Aug 2025 06:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="uM+u1iw7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D0E6209F2E;
	Wed,  6 Aug 2025 06:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754460442; cv=none; b=fqcwd48E26o2ilCXNjo7jmBWhu/DJO9KF5XpDOWZ/bOBeDi3LThdWeCfpStERDEWWndhPzsbpnG2aJsaqULhGJO18AtdW/5Jp1GGRwaszTzmSapUwtlM9EbE4Wuc7iIHANZm5MM/FpTrwB1XmsIRHIawUrSpHoeL0D1MUcV1NRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754460442; c=relaxed/simple;
	bh=1SWOvSmF9t5iBCFM09/ljudRbepC+1mWy8OVlhlsRRU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=j3Ts+G1pqjSzZh+FbQ0WCdOChLJCP7nthfqzkB1xlCiWJDphDZpWaDbuCK6Z91fLP8VuX9X/qzZpOM8EDzJaD92WkI3rOltQdNxbuYW+GrfvvsymCU9Cv8PN0fbQafA9j409JFrwd90EIEdEnNHIgu149txSFehjg+e4YdhBA1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=uM+u1iw7; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4bxfvm10FHz9tpB;
	Wed,  6 Aug 2025 08:07:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1754460436;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=lOpBzxs8R6x3VAfE9nprblu7AYuKarjAlaIgk5NpQk8=;
	b=uM+u1iw7gmSkemANSoyG8Qni0lLm72uHBd3d6nfBQhLpVmz5Bi9PibAKG5MZ2lfpla0/i0
	j95tN7Gg1AV0D4zIo/gGviPpgRKo4802fqUmaWBYM+FhqrhvFMKLXExfmoNyuWN/i9DHrQ
	k1969hK28YTblHT7MzTW+BXMREyU9D7EgMfzyXY/gBgR/++nJc7NHQAFDILHWTk0Hs/3mu
	3P2U72MSRwGlPXQKShYVFtYp1tjOzuW2IYjBzzxpciwKgObfs4zt/KJgqWRe087o1ymrf1
	oebx7uwaSOzk0zyZdkBOfLkJxJxOUx4wjn8uMFKHYaR3M6XRUaim9nOVrAVQBg==
From: Aleksa Sarai <cyphar@cyphar.com>
Subject: [PATCH v2 0/2] vfs: output mount_too_revealing() errors to
 fscontext
Date: Wed, 06 Aug 2025 16:07:04 +1000
Message-Id: <20250806-errorfc-mount-too-revealing-v2-0-534b9b4d45bb@cyphar.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAjxkmgC/33NwQ6CMAzG8VchO1tT0A715HsYDnNssERX0iGRE
 N7dSeLV4/9L+uuikpPgkroUixI3hRQ45qh2hbK9iZ2D0OZWFVaEJyRwIizewpNfcYSRGfKZM48
 QO6D27HWNd1PXqLIwiPPhvem3Jncf0sgyb8+m8rv+XP3XnUpAoIOmI3oqSePVzkNvZG/5qZp1X
 T+GedeAxwAAAA==
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: David Howells <dhowells@redhat.com>, linux-api@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Aleksa Sarai <cyphar@cyphar.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1354; i=cyphar@cyphar.com;
 h=from:subject:message-id; bh=1SWOvSmF9t5iBCFM09/ljudRbepC+1mWy8OVlhlsRRU=;
 b=owGbwMvMwCWmMf3Xpe0vXfIZT6slMWRM+sgnW5ZWLW2i94vlQvanKfsFlu19ILtDPfGqSc2Sc
 zwT587s7ShlYRDjYpAVU2TZ5ucZumn+4ivJn1aywcxhZQIZwsDFKQATqeli+J8s8miuU4zR7L3c
 G64bV3CtuVpt+EvlTOm5PLkTHdc2LH3FyLDumkXrH45fL55eevLv9V3f9EfcnJ/WfCqa9+DJ9x2
 qr2sYAA==
X-Developer-Key: i=cyphar@cyphar.com; a=openpgp;
 fpr=C9C370B246B09F6DBCFC744C34401015D1D2D386

It makes little sense for fsmount() to output the warning message when
mount_too_revealing() is violated to kmsg. Instead, the warning should
be output (with a "VFS" prefix) to the fscontext log. In addition,
include the same log message for mount_too_revealing() when doing a
regular mount for consistency.

With the newest fsopen()-based mount(8) from util-linux, the error
messages now look like

  # mount -t proc proc /tmp
  mount: /tmp: fsmount() failed: VFS: Mount too revealing.
	 dmesg(1) may have more information after failed mount system call.

which could finally result in mount_too_revealing() errors being easier
for users to detect and understand.

Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
---
Changes in v2:
- Log before setting retval. [Al Viro]
- v1: <https://lore.kernel.org/r/20250806-errorfc-mount-too-revealing-v1-0-536540f51560@cyphar.com>

---
Aleksa Sarai (2):
      fscontext: add custom-prefix log helpers
      vfs: output mount_too_revealing() errors to fscontext

 fs/namespace.c             |  6 ++++--
 include/linux/fs_context.h | 18 ++++++++++++++----
 2 files changed, 18 insertions(+), 6 deletions(-)
---
base-commit: 66639db858112bf6b0f76677f7517643d586e575
change-id: 20250805-errorfc-mount-too-revealing-5d9f670ba770

Best regards,
-- 
Aleksa Sarai <cyphar@cyphar.com>


