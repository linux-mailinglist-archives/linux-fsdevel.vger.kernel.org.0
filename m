Return-Path: <linux-fsdevel+bounces-57010-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62C0AB1DCB2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Aug 2025 19:55:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE0A01AA003C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Aug 2025 17:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46D1D20296E;
	Thu,  7 Aug 2025 17:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="h4n7VQwP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C253D1F4192;
	Thu,  7 Aug 2025 17:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754589325; cv=none; b=qt4pSiqlQSlZpuiTtNWTLwWc5vPmsC7qJfp7bsb0CILjNstZoPeMTjZksMEyc86YNMtouUIR0I61oBsK9kL8W5N+K1d6ldWQp1Zh5thMVudTI3e1OyHe5OwEgh9IiEwC235ltN7/L3ioJVB1x1E/S9Hvvb66x6u7MFRrZgXDRH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754589325; c=relaxed/simple;
	bh=UQBjd7oTQ++xKM4gsFbaCmOR0brFLzErTPP56dbXe5Y=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=EQMiSIDzBAI9uA8hxpOGAOE4NDUpbd/RpEHGNN0Y4c0yGsKj1zZvEqlsjKF24+0D49YcAyej1jjlfl1fTAJG76c/2N3R3NJRtOa4cro6pFGQ97AidvELdXtoLfHUMV2Rcwx2nmLMLBWfGBJ1LHiIo80iyuPF+h8yAWa0/+orXOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=h4n7VQwP; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4byZZJ0x87z9sTR;
	Thu,  7 Aug 2025 19:55:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1754589320;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=YsPsa0bzvSKbHR6viJA+n9YQMrDTXPcEJKFy94H+8uI=;
	b=h4n7VQwPjju8fULKvEP82k60PP97PW3gHg9m9K4dRgB5aOHPjkE494qT6B2NCcNxt6kk1B
	Xb08jIeaMgwFh3xYGjziex+Ll3QbA7znWMkpSuEcNa0lWgBDGaBp5pKLBZj+qcv9DEJ4ie
	KBRAk5Tp21mX6jD9FIjA7Vt0+hgWegP+zQJ72BXgpvQPTo6W5mES6uSiGGRvyrKEUlVYDW
	1RCV16Le/OKExNqQk9sXQJbbHwDaZiV8jCu2+XrMe8xwAhu6dgVmr3uvV7d+bkZFClxs/L
	J3D/B6w2g3Np4vUBc1CZflgNXRKRAvfP4XuIpAjVRgzgZ8mpBn9jQG+ucBX40g==
From: Aleksa Sarai <cyphar@cyphar.com>
Subject: [PATCH 0/2] open_tree_attr: do not allow id-mapping changes
 without OPEN_TREE_CLONE
Date: Fri, 08 Aug 2025 03:55:04 +1000
Message-Id: <20250808-open_tree_attr-bugfix-idmap-v1-0-0ec7bc05646c@cyphar.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHnolGgC/x2MSQqAMAwAvyI5W2jFDb8iIq1GzcFa0iqC+HeDx
 2GGeSAiE0bosgcYL4p0eAGTZzBt1q+oaBaGQheVbnWrjoB+TIw42pRYuXNd6JZot0E515TG1PU
 86RLkEBhF/vd+eN8PC5d7Dm0AAAA=
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 "Seth Forshee (DigitalOcean)" <sforshee@kernel.org>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>, 
 stable@vger.kernel.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=1702; i=cyphar@cyphar.com;
 h=from:subject:message-id; bh=UQBjd7oTQ++xKM4gsFbaCmOR0brFLzErTPP56dbXe5Y=;
 b=owGbwMvMwCWmMf3Xpe0vXfIZT6slMWRMedHA2ttmuj4wgvv3beEorXfLul7Ep5hxKDjv/R/6L
 t92uXttRykLgxgXg6yYIss2P8/QTfMXX0n+tJINZg4rE8gQBi5OAZjINwOG/6URf4tL5/tceui3
 jGd3kcJ3vgrRXYE/ZS76aQn/ebHx0hdGhne84W3v3i3LrpW+HtW+/7jzzjJ+k3iPm0ket6QerEu
 rYgAA
X-Developer-Key: i=cyphar@cyphar.com; a=openpgp;
 fpr=C9C370B246B09F6DBCFC744C34401015D1D2D386

As described in commit 7a54947e727b ('Merge patch series "fs: allow
changing idmappings"'), open_tree_attr(2) was necessary in order to
allow for a detached mount to be created and have its idmappings changed
without the risk of any racing threads operating on it. For this reason,
mount_setattr(2) still does not allow for id-mappings to be changed.

However, there was a bug in commit 2462651ffa76 ("fs: allow changing
idmappings") which allowed users to bypass this restriction by calling
open_tree_attr(2) *without* OPEN_TREE_CLONE.

can_idmap_mount() prevented this bug from allowing an attached
mountpoint's id-mapping from being modified (thanks to an is_anon_ns()
check), but this still allows for detached (but visible) mounts to have
their be id-mapping changed. This risks the same UAF and locking issues
as described in the merge commit, and was likely unintentional.

For what it's worth, I found this while working on the open_tree_attr(2)
man page, and was trying to figure out what open_tree_attr(2)'s
behaviour was in the (slightly fruity) ~OPEN_TREE_CLONE case.

Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
---
Aleksa Sarai (2):
      open_tree_attr: do not allow id-mapping changes without OPEN_TREE_CLONE
      selftests/mount_setattr: add smoke tests for open_tree_attr(2) bug

 fs/namespace.c                                     |  3 +-
 .../selftests/mount_setattr/mount_setattr_test.c   | 77 ++++++++++++++++++----
 2 files changed, 66 insertions(+), 14 deletions(-)
---
base-commit: 66639db858112bf6b0f76677f7517643d586e575
change-id: 20250808-open_tree_attr-bugfix-idmap-bb741166dc04

Best regards,
-- 
Aleksa Sarai <cyphar@cyphar.com>


