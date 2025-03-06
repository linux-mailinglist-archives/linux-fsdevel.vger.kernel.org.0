Return-Path: <linux-fsdevel+bounces-43330-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 94468A5476B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Mar 2025 11:13:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB93A16DD7D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Mar 2025 10:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B2011FFC73;
	Thu,  6 Mar 2025 10:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K4uA7Gb5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 081E741C92;
	Thu,  6 Mar 2025 10:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741256024; cv=none; b=P8OPMqLLnkCz5nmro/4USD6mz/yz3cf9BpTdMFqB1FD7tXmuaNb5ltrEO29TQSaawys90a3xO4o/2uYYgvp2+fCMsNFQdbvJATy51xryw1kTIOno4eNKYmjOgLd+B+kuFnhNNM8ayp39vXaa377XYpDibaWGPGWQfil4yKHkNLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741256024; c=relaxed/simple;
	bh=lDR+NcZh6r7M5vLbNyksGzmR5l3ZCpRBHAlvAU3OEqk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=b2vL/Qq99vZS+9V6S/rjpmH22MET4jG6QpK3p30Qchn1y5N6nfrO2cTHdIjqabYklClBWkL8MpVbLxRwhMm+02+P7WPV/PwQe27B9BgLdDgA0qMkN0xXfukJWin7kdXxTM94vPskML6bS89wuIukMm4FLHudsjJgYwnXKtYH91E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K4uA7Gb5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4350AC4CEE0;
	Thu,  6 Mar 2025 10:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741256023;
	bh=lDR+NcZh6r7M5vLbNyksGzmR5l3ZCpRBHAlvAU3OEqk=;
	h=From:To:Cc:Subject:Date:From;
	b=K4uA7Gb5jmsZ4S3BOsidaEosFt2citthca0bmi5U2y9l5jmEct49VE89iA4w061a1
	 1E8yZ+SAo4+l9WXpzoUJ8TS6rMkgVOGFZVqsWPhcWqsXeXtczXfKsD21ynaGOCZjq1
	 iKzxUU5D4CoNLpgVIxfcOgb7HroWc/0CaaGs+no67t1vnKKd/B4A0y+mi7chiGSA58
	 2h5FC/bAiJVn/6fVW8hU5+sBTgw4Bl+VZr6e7t0vVPyvo7Lz/SFlQ2guSXiw/CGPdw
	 yMKULPf9Nqixy1UG9py1vwY7FYGF4SasqsqbdEV6fuYKvIJbC/D0Tx/dlt4J2MOj5/
	 sfoq8Xbg2WFJA==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] vfs fixes
Date: Thu,  6 Mar 2025 11:13:28 +0100
Message-ID: <20250306-vfs-fixes-290b2e462d9c@brauner>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1699; i=brauner@kernel.org; h=from:subject:message-id; bh=lDR+NcZh6r7M5vLbNyksGzmR5l3ZCpRBHAlvAU3OEqk=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSfLA1wnuOT8H6+Y8obs16Jq3GV21nmdRhemeLHd/SVb mDSBzH9jlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIkc+8vwT+9vzK6LGgvCWd3e mumkFweGBujzBOtcOHj5fcSjs6ucpzMyfH5lcOfjQaUg1/8m0j9iNBQqDQrO+jkFWldGd+qpHwz kBQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

/* Summary */

This contains various fixes for this cycle:

- Fix spelling mistakes in idmappings.rst.

- Fix RCU warnings in override_creds()/revert_creds().

- Create new pid namespaces with default limit now that pid_max is namespaced.

/* Testing */

gcc version (Debian 14.2.0-8) 14.2.0
Debian clang version 19.1.4 (1)

No build failures or warnings were observed.

/* Conflicts */

Merge conflicts with mainline
=============================

No known conflicts.

Merge conflicts with other trees
================================

No known conflicts.


The following changes since commit d082ecbc71e9e0bf49883ee4afd435a77a5101b6:

  Linux 6.14-rc4 (2025-02-23 12:32:57 -0800)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.14-rc6.fixes

for you to fetch changes up to d385c8bceb14665e935419334aa3d3fac2f10456:

  pid: Do not set pid_max in new pid namespaces (2025-03-06 10:18:36 +0100)

Please consider pulling these changes from the signed vfs-6.14-rc6.fixes tag.

Thanks!
Christian

----------------------------------------------------------------
vfs-6.14-rc6.fixes

----------------------------------------------------------------
Aiden Ma (1):
      doc: correcting two prefix errors in idmappings.rst

Herbert Xu (1):
      cred: Fix RCU warnings in override/revert_creds

Michal Koutný (1):
      pid: Do not set pid_max in new pid namespaces

 Documentation/filesystems/idmappings.rst |  4 ++--
 include/linux/cred.h                     | 10 ++--------
 kernel/pid_namespace.c                   |  2 +-
 3 files changed, 5 insertions(+), 11 deletions(-)

