Return-Path: <linux-fsdevel+bounces-11848-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8A85857C73
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Feb 2024 13:21:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4EECB23BB0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Feb 2024 12:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6660478B46;
	Fri, 16 Feb 2024 12:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MRZM3/AD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70662CCB4
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 Feb 2024 12:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708086069; cv=none; b=QxyUPdJ+G9QCJVjpVf9Amhe8E2eIvleuVpcpyh9vXiDoD5M9r/qI/Y2PeLUdHDGLOa+YSvuAbBS/cZT3IOtJKWKZyY6DWtomdGdA1PWxRbWcM2V61nfVH5aPMxodyC9XgttuQZjVZYANSGRVm8cYmQZeERORt0v8PSFePi+SmE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708086069; c=relaxed/simple;
	bh=ebbMrhSfT5llU7LPbtghLvjsFm9Pe7wCK4cf1a+w8P4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SdC71g8Nhqcmc/lpSDJdu3i6Q8lxKjO+heO/HSpsWOUoK260utq1jnyQGPFeDtZoJWvbwORqD1sBFSShRxwuo79Pbd7HIsCnf9fv4IM2GySX3EkiEONNgImulQafsaO8SzECNzSRCPcAD5kJ7QnmBuVfTCCgunHFBF5GDyGhvw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MRZM3/AD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA5A7C433C7;
	Fri, 16 Feb 2024 12:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708086069;
	bh=ebbMrhSfT5llU7LPbtghLvjsFm9Pe7wCK4cf1a+w8P4=;
	h=From:To:Cc:Subject:Date:From;
	b=MRZM3/ADh+vMyCKbmLsehHB4hLGFWB+Df825iXM1TCKbQ5t0rkj4Unz8qM7GeAsCx
	 Ee4sDi7BCNs7VhVTqvoOPH4KGWgX/z8joUgxYdGNIDmSgYYggHqgOzAS4lmi7aOnZ5
	 10JTIid0vArXvzYovCqyXYG9Pd4NdHh8OJOrVWstGv5IW9mor8wNlzbMcAbSyabegn
	 d7kD01UhW0PpGyCLno/EoYw0KpoMU8ev6kk7rB8AoGURM414iUhWG/KBllPJPsUfLD
	 3ZXt0urRstYl06sIpVx18C9XFj4By6zJQ6dOVzjAh8EOpHaowvBT6SeCXSkWOqKgpl
	 fMZ9COQ8JRFSQ==
From: Damien Le Moal <dlemoal@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] zonefs fixes for 6.8-rc5
Date: Fri, 16 Feb 2024 21:21:07 +0900
Message-ID: <20240216122107.3914026-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Damien Le Moal <damien.lemoal@opensource.wdc.com>

Linus,

The following changes since commit 841c35169323cd833294798e58b9bf63fa4fa1de:

  Linux 6.8-rc4 (2024-02-11 12:18:13 -0800)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/zonefs tags/zonefs-6.8-rc5

for you to fetch changes up to 14db5f64a971fce3d8ea35de4dfc7f443a3efb92:

  zonefs: Improve error handling (2024-02-16 10:20:35 +0900)

----------------------------------------------------------------
zonefs fixes for 6.8.0-rc5

 - Fix direct write error handling to avoid a race between failed IO
   completion and the submission path itself which can result in an
   invalid file size exposed to the user after the failed IO.

----------------------------------------------------------------
Damien Le Moal (1):
      zonefs: Improve error handling

 fs/zonefs/file.c  | 42 ++++++++++++++++++++++-------------
 fs/zonefs/super.c | 66 ++++++++++++++++++++++++++++++++-----------------------
 2 files changed, 65 insertions(+), 43 deletions(-)

