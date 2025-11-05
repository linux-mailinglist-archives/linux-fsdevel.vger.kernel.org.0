Return-Path: <linux-fsdevel+bounces-67023-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4239FC33825
	for <lists+linux-fsdevel@lfdr.de>; Wed, 05 Nov 2025 01:48:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 63C9A4F0BFD
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Nov 2025 00:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D575523BF9B;
	Wed,  5 Nov 2025 00:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FgTuy1si"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385BE23958A;
	Wed,  5 Nov 2025 00:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762303706; cv=none; b=Hf5AsAzFnm/J27aS5MXosiiLbyebp+8fc2O82WxZNXk74y+RfbeMfK3z24WtOT4btZEiX+2AqbH+B0vDbi3Zr4vaReCs4TWes14gJCxbI4Ica2h8wrtv15PE1I1TDHTDgQN3E0ZdUu5RKwuBOP7V1KrTFeSFLzFE3vR8yfoY2vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762303706; c=relaxed/simple;
	bh=0xwPKS+cmgFDnbYdGsksZe/jcnpqFfmv+N2wUOyi1zc=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NXtPuAnsNEfzBDI0Gvx9x4/B2/t0ootguNEpTOLSHWuUKzPI5G+uItZ60H1b1k9Zkx0v8v7+HI4ul/L+42v3eibSnOVxmxw/J7ohxKTjVfWBnLkjSZZ6icf2+KgZxNeZhZa8s9TRgy7H67JTaZXBDgDHkkeooMPytIb2uzW4JsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FgTuy1si; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A96DDC4CEF7;
	Wed,  5 Nov 2025 00:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762303705;
	bh=0xwPKS+cmgFDnbYdGsksZe/jcnpqFfmv+N2wUOyi1zc=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=FgTuy1sicQUkw8HrYof79W+eRIx/YlCFDpZelDyL2OQF+3hGHao1B0Az9O9VekVKu
	 PrHP/QcakxOwiIYJ+IaogwCvNo7jF1hRns+0smYUn1lUoTdui+cjT68lFT+w+DPSOI
	 7U6/lHSutbTfFJmSRiAsOib7R9Z54dWign47htN06F2Tr3LCnhYspd/QxPmJYgvMRQ
	 V6r0NravjvLY3AYiKmJPDIwoxX4foElYSA44WU+1hIM0ULjMG3dPKVHooYnJUnwgyT
	 l/sKxLS4pLNy49VKCgAfjC1884j4xgykq1EmkZ0VqulEotSgGtEHk81dTxphMaRn6Q
	 Oxac0im1iWdbg==
Date: Tue, 04 Nov 2025 16:48:25 -0800
Subject: [PATCHSET V3 2/2] iomap: generic file IO error reporting
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, cem@kernel.org
Cc: hch@lst.de, linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
 hch@lst.de, amir73il@gmail.com, jack@suse.cz, gabriel@krisman.be
Message-ID: <176230366393.1647991.7608961849841103569.stgit@frogsfrogsfrogs>
In-Reply-To: <20251105004649.GA196370@frogsfrogsfrogs>
References: <20251105004649.GA196370@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Hi all,

Refactor the iomap file I/O error handling code so that failures are
reported in a generic way to fsnotify.  Then connect the XFS health
reporting to the same fsnotify, and now XFS can fsnotify userspace of
all manner of problems.

This series is much more experimental than the main healer patchset,
and I'd rather it not become a blocker for the main patchset.  I
wouldn't mind rebasing if they went in at the same time though.

If you're going to start using this code, I strongly recommend pulling
from my git trees, which are linked below.

This has been running on the djcloud for months with no problems.  Enjoy!
Comments and questions are, as always, welcome.

--D

kernel git tree:
https://git.kernel.org/cgit/linux/kernel/git/djwong/xfs-linux.git/log/?h=iomap-ioerr-reporting
---
Commits in this patchset:
 * iomap: report file IO errors to fsnotify
 * xfs: switch healthmon to use the iomap I/O error reporting
 * xfs: port notify-failure to use the new vfs io error reporting
 * xfs: remove file I/O error hooks
 * iomap: remove I/O error hooks
 * xfs: report fs metadata errors via fsnotify
---
 fs/xfs/xfs_file.h                 |   37 --------
 fs/xfs/xfs_mount.h                |    3 -
 fs/xfs/xfs_trace.h                |   35 ++++---
 include/linux/fs.h                |   68 ++++++++++++++
 include/linux/iomap.h             |    2 
 Documentation/filesystems/vfs.rst |    7 -
 fs/iomap/buffered-io.c            |    8 +-
 fs/iomap/direct-io.c              |    9 +-
 fs/super.c                        |   53 +++++++++++
 fs/xfs/xfs_aops.c                 |    2 
 fs/xfs/xfs_file.c                 |  174 -------------------------------------
 fs/xfs/xfs_health.c               |   12 ++-
 fs/xfs/xfs_healthmon.c            |   51 ++++++-----
 fs/xfs/xfs_notify_failure.c       |    9 +-
 fs/xfs/xfs_super.c                |    1 
 15 files changed, 190 insertions(+), 281 deletions(-)


