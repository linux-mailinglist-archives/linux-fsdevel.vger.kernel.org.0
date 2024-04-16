Return-Path: <linux-fsdevel+bounces-17003-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C3D98A5F38
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Apr 2024 02:28:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE6721C21187
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Apr 2024 00:28:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB73F185E;
	Tue, 16 Apr 2024 00:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tpIWV5N7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34495139B;
	Tue, 16 Apr 2024 00:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713227275; cv=none; b=rhr5NbvO8NZosLs1GDURzpPe/4iX711eqL+Z+3YpiXh2+Q5hyPLy8lTAXUwZhAwnd4MxRzJNGzc/tmMe7BoJJVYL1uNhpK8wiXMSTgysFsIFEfoubQtmQPqlxrIkZodncWK4OtSyfguPgi6Gh688s5LuUsB2jSDUszxHPmrurXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713227275; c=relaxed/simple;
	bh=JsGovd84dzNuvr/iFsWDFrNkIQJpQKso3yNf3gRJyJA=;
	h=Date:Subject:From:To:Cc:Message-ID:MIME-Version:In-Reply-To:
	 References:Content-Type; b=hUJvDhSH6JKgrgi4GvnU5+ET5J/PdNvv+hTYoqNx0P5/a8O4pv5onkfB7aTZohWPY4e3SmDB5nqU5esHl+cSzl0WXy+H3uBsCubGC3r074XJu1u12zRde8Q0BgtUz8STH+yDCHSiGglEG/1HxEhrsnqVzM4QqgtlpkGBqsML9KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tpIWV5N7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB60FC113CC;
	Tue, 16 Apr 2024 00:27:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713227274;
	bh=JsGovd84dzNuvr/iFsWDFrNkIQJpQKso3yNf3gRJyJA=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=tpIWV5N7qmaSfHaixfc1wYrrceI6sCngKRa79Xg7p0uzrUn9gxu+BliHybc61nieH
	 m9sO+x+CdRLzzI0PbAxwiRTpCKK+HQKYHCi1Xl3FiCCPCMfTAm9eQYRrOp5RkwmSwE
	 4hrSNvr7loVss6vXnzr0x+qL81IAAulVkdTVpygXJM3CXxUPLMCioSB5JRY9qEPTGl
	 gnFMcFrFlMCkkXqKd9481cjr2WH5rUSIpbj00e0+SiLaSA0pU11BrQMGmM3btb8bA8
	 ypkYJhbAa5VxWMnAJ52nBs7R+OXfv5pouj4XhDRZuwCD3VnkSIfP+HJ84TGLJQUEhF
	 v2kMxCb3qhipA==
Date: Mon, 15 Apr 2024 17:27:54 -0700
Subject: [GIT PULL 02/16] xfs: refactorings for atomic file content exchanges
From: "Darrick J. Wong" <djwong@kernel.org>
To: chandanbabu@kernel.org, djwong@kernel.org
Cc: hch@lst.de, linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Message-ID: <171322715380.141687.16917611087971237386.stg-ugh@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240416002427.GB11972@frogsfrogsfrogs>
References: <20240416002427.GB11972@frogsfrogsfrogs>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Hi Chandan,

Please pull this branch with changes for xfs for 6.10-rc1.

As usual, I did a test-merge with the main upstream branch as of a few
minutes ago, and didn't see any conflicts.  Please let me know if you
encounter any problems.

--D

The following changes since commit 5302a5c8beb21d01b7b8d92cc73b6871bc27d7bf:

xfs: only clear log incompat flags at clean unmount (2024-04-15 14:54:06 -0700)

are available in the Git repository at:

https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git tags/file-exchange-refactorings-6.10_2024-04-15

for you to fetch changes up to 15f78aa3eb07645e7bef15a53b4ae1c757907d2c:

xfs: constify xfs_bmap_is_written_extent (2024-04-15 14:54:12 -0700)

----------------------------------------------------------------
xfs: refactorings for atomic file content exchanges [v30.3 02/16]

This series applies various cleanups and refactorings to file IO
handling code ahead of the main series to implement atomic file content
exchanges.

This has been running on the djcloud for months with no problems.  Enjoy!

Signed-off-by: Darrick J. Wong <djwong@kernel.org>

----------------------------------------------------------------
Darrick J. Wong (7):
xfs: move inode lease breaking functions to xfs_inode.c
xfs: move xfs_iops.c declarations out of xfs_inode.h
xfs: declare xfs_file.c symbols in xfs_file.h
xfs: create a new helper to return a file's allocation unit
xfs: hoist multi-fsb allocation unit detection to a helper
xfs: refactor non-power-of-two alignment checks
xfs: constify xfs_bmap_is_written_extent

fs/xfs/libxfs/xfs_bmap.h |  2 +-
fs/xfs/xfs_bmap_util.c   |  4 +--
fs/xfs/xfs_file.c        | 88 ++++--------------------------------------------
fs/xfs/xfs_file.h        | 15 +++++++++
fs/xfs/xfs_inode.c       | 75 +++++++++++++++++++++++++++++++++++++++++
fs/xfs/xfs_inode.h       | 16 +++++----
fs/xfs/xfs_ioctl.c       |  1 +
fs/xfs/xfs_iops.c        |  1 +
fs/xfs/xfs_iops.h        |  7 ++--
fs/xfs/xfs_linux.h       |  5 +++
10 files changed, 121 insertions(+), 93 deletions(-)
create mode 100644 fs/xfs/xfs_file.h


