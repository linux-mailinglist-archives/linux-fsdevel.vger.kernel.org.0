Return-Path: <linux-fsdevel+bounces-732-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18A6C7CF4B8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Oct 2023 12:09:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E6B61C20E71
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Oct 2023 10:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20543179AD;
	Thu, 19 Oct 2023 10:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bw11o5+I"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 427371798C
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Oct 2023 10:09:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD16AC433C8;
	Thu, 19 Oct 2023 10:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697710142;
	bh=96LKDRMrRpLCVaVRlRGnvTj5m9adaIRHeaHEEEyRJ08=;
	h=From:To:Cc:Subject:Date:From;
	b=bw11o5+I3+JgbuMc86sGALFuZS98+e+bGbUS8JrPwOxU3Q0ubZK2zl+9zdkOTHPbl
	 wKz5mENFYv86mcaut0k3L6WbS7H4zVjxWymnyj6zy8qP3oFTR6oe8QtNOhSMve7JFG
	 fFyza1W6Fcl52wiOaKODHGfHqazlRitBwfKjJ26tMkLCmptavmALEHLgKofwXXDnlX
	 z0UA0YxLh7k4znCV7/pV5Oq6cUMsjh5X2px2wx9W9gSFC385JS9rl1dcYLlzoaIQIi
	 9F3szJfxBqg3TGb+C4XwjCgStcuppwk7GoJY++OY8nmbR8qWwMfCDNcLb/P8uzxyn7
	 T+d8nJh9yI68Q==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] vfs fixes
Date: Thu, 19 Oct 2023 12:07:08 +0200
Message-Id: <20231019-kampfsport-metapher-e5211d7be247@brauner>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1973; i=brauner@kernel.org; h=from:subject:message-id; bh=96LKDRMrRpLCVaVRlRGnvTj5m9adaIRHeaHEEEyRJ08=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQa/F/fd/vBj5BZmU0bllctWrzpRppozLYdMXIuN39+c513 8dqbaR2lLAxiXAyyYoosDu0m4XLLeSo2G2VqwMxhZQIZwsDFKQATeZfJ8N/lr4zrjkC5/WcirmQlHr ksNb204onEr+lb53Np3+cWFzjByPBol8mfCy/+Z2Zd/5vrzJmjxZd1a8O8uGfrzi7pOMh+bTY3AA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */
An openat() call from io_uring triggering an audit call can apparently
cause the refcount of struct filename to be incremented from multiple
threads concurrently during async execution, triggering a refcount
underflow and hitting a BUG_ON(). That bug has been lurking around since
at least v5.16 apparently.

Switch to an atomic counter to fix that. The underflow check is
downgraded from a BUG_ON() to a WARN_ON_ONCE() but we could easily
remove that check altogether tbh and not waste an additional atomic. So
if you feel that extra check isn't needed you could just remove in case
you're pulling.

/* Testing */
clang: Ubuntu clang version 15.0.7
gcc: (Ubuntu 12.2.0-3ubuntu1) 12.2.0

All patches are based on v6.6-rc6 and have been sitting in linux-next.
No build failures or warnings were observed.

/* Conflicts */
At the time of creating this PR no merge conflicts were reported from
linux-next and no merge conflicts showed up doing a test-merge with
current mainline.

The following changes since commit 94f6f0550c625fab1f373bb86a6669b45e9748b3:

  Linux 6.6-rc5 (2023-10-08 13:49:43 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/v6.6-rc7.vfs.fixes

for you to fetch changes up to 03adc61edad49e1bbecfb53f7ea5d78f398fe368:

  audit,io_uring: io_uring openat triggers audit reference count underflow (2023-10-13 18:34:46 +0200)

Please consider pulling these changes from the signed v6.6-rc7.vfs.fixes tag.

Thanks!
Christian

----------------------------------------------------------------
v6.6-rc7.vfs.fixes

----------------------------------------------------------------
Dan Clash (1):
      audit,io_uring: io_uring openat triggers audit reference count underflow

 fs/namei.c         | 9 +++++----
 include/linux/fs.h | 2 +-
 kernel/auditsc.c   | 8 ++++----
 3 files changed, 10 insertions(+), 9 deletions(-)

