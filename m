Return-Path: <linux-fsdevel+bounces-1374-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A4E67D9B81
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Oct 2023 16:34:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AB331C210AD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Oct 2023 14:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2699374C6;
	Fri, 27 Oct 2023 14:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W59Cui+s"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E30374C8
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Oct 2023 14:33:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65408C433C8;
	Fri, 27 Oct 2023 14:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698417229;
	bh=XtwBVpxwOzBBFzwktednvY+wvC5tqsoHYE/dsTsZi+A=;
	h=From:To:Cc:Subject:Date:From;
	b=W59Cui+silA+bkCqaB4LVXiUAULBbO1iAcfW8qlFqqhJGjHiAKo0GwhKzuN6p4M5k
	 NDfN3LhTY3ujwji06lqQo7grfiKJpX2wWjT22ehh9Luvicuf/Smq65Vx7J+3gi61W2
	 Q7cXHQcDQ3S5MR5vS3QkdFRKQsuiK4PmsBIYIRS6snhyO6diMEMQ0hI43tT3cRYocF
	 I5yFInjExXNrVR4NKFEzpIVL9JRC7JtXEDE1L44mrqfMSHf7uXxud4oltGRqVWek/C
	 Pynkt+EZ0kMq57jhntIVGFOoDG2mPTgZRxt4OYMbjt04cxMX0fq+mmbM/Fk8gPGHIP
	 K0Uo+jLgcwVdA==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL for v6.7] autofs updates
Date: Fri, 27 Oct 2023 16:33:41 +0200
Message-Id: <20231027-vfs-autofs-018bbf11ed67@brauner>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2388; i=brauner@kernel.org; h=from:subject:message-id; bh=XtwBVpxwOzBBFzwktednvY+wvC5tqsoHYE/dsTsZi+A=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRan9Lufb7oz+pFD46+TH/VYntfbq/bzBO/bkrVRk+ccuYj z4q/TB2lLAxiXAyyYoosDu0m4XLLeSo2G2VqwMxhZQIZwsDFKQAT0brByPDo+tLomTkn7x/nV55R6c pw3vr8PamvOxs9zt3aunhnhJcTI8PVV4+EDiXoJFZaL45rq36yZ8aEt6vqai54Pv5z7eYja11eAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */
This ports autofs to the new mount api. The patchset has existed for
quite a while but never made it upstream. Ian picked it back up.

This also fixes a bug where fs_param_is_fd() was passed a garbage
param->dirfd but it expected it to be set to the fd that was used to set
param->file otherwise result->uint_32 contains nonsense. So make sure
it's set.

One less filesystem using the old mount api. We're getting there, albeit
rather slow. The last remaining major filesystem that hasn't converted
is btrfs. Patches exist - I even wrote them - but so far they haven't
made it upstream.

/* Testing */
clang: Debian clang version 16.0.6 (16)
gcc: gcc (Debian 13.2.0-5) 13.2.0

All patches are based on v6.6-rc2 and have been sitting in linux-next.
No build failures or warnings were observed.

/* Conflicts */
At the time of creating this PR no merge conflicts were reported from
linux-next and no merge conflicts showed up doing a test-merge with
current mainline.

The following changes since commit ce9ecca0238b140b88f43859b211c9fdfd8e5b70:

  Linux 6.6-rc2 (2023-09-17 14:40:24 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.7.autofs

for you to fetch changes up to d3c50061765d4b5616dc97f5804fc18122598a9b:

  autofs: fix add autofs_parse_fd() (2023-10-24 11:04:45 +0200)

Please consider pulling these changes from the signed vfs-6.7.autofs tag.

Thanks!
Christian

----------------------------------------------------------------
vfs-6.7.autofs

----------------------------------------------------------------
Christian Brauner (1):
      fsconfig: ensure that dirfd is set to aux

Ian Kent (9):
      autofs: refactor autofs_prepare_pipe()
      autofs: add autofs_parse_fd()
      autofs: refactor super block info init
      autofs: reformat 0pt enum declaration
      autofs: refactor parse_options()
      autofs: validate protocol version
      autofs: convert autofs to use the new mount api
      autofs: fix protocol sub version setting
      autofs: fix add autofs_parse_fd()

 fs/autofs/autofs_i.h |  20 ++-
 fs/autofs/init.c     |   9 +-
 fs/autofs/inode.c    | 435 +++++++++++++++++++++++++++++++--------------------
 fs/fsopen.c          |   1 +
 4 files changed, 283 insertions(+), 182 deletions(-)

