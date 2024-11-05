Return-Path: <linux-fsdevel+bounces-33706-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93E4F9BD9ED
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Nov 2024 00:51:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 593EC282C86
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Nov 2024 23:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDC38216A25;
	Tue,  5 Nov 2024 23:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S1RUsryb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C28149C53;
	Tue,  5 Nov 2024 23:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730850682; cv=none; b=aArzNX27jFYZT2sf9MqB6jZMcVsXJJb+ze/TzjAH3JlX7fOEy1BwN44eQWJGXL+5NpGmtNrA6HtPAkWuu7RhtRp7MFy34GEjsdgPSJNMzU2OEk4f81l+/nJA4cf36cMiyU6a1/NtU8STf4PhsiwYMX7EyNxP5PM7c+eJOK5YIds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730850682; c=relaxed/simple;
	bh=9S/OXKxDElD8GDOo9yWkcKMxYL74jEBz2evuABLzlc0=;
	h=Date:Subject:From:To:Cc:Message-ID:MIME-Version:In-Reply-To:
	 References:Content-Type; b=roGyHKFZLyFP2mUgqz2a2AjVJ+l3jG6/yu3k0aMijYWMvfW34ENBgr+8dnNH7MeNPdQQEcJIUNC5LwM+/5maQNYGNm6FAAxPXFEIsoD7XuBzUtjTSpIlR/+3eCLhz+V+y5FsjFpI5ALNubEF2hio/rlrwEXCbqzluyBTeQUpvHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S1RUsryb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBEABC4CECF;
	Tue,  5 Nov 2024 23:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730850681;
	bh=9S/OXKxDElD8GDOo9yWkcKMxYL74jEBz2evuABLzlc0=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=S1RUsrybDE43/DCX+dhcFnbAWJhIpQtptukBr23zZZBo7ldfViEaDMySXOqCZKaR0
	 OEQ6ygjp2VPaYYGd0cMXaotsgmpoFve21M8QHXMHTcaGlsxngk6+YntwB/XQxlZa0P
	 CRgcar/WRjmpPECkpo86kTvwOAJzZePcZnnTiCcuXs3Xs7PU0bUhuSqBKBOdn2/W+0
	 nUYKhooT5bh5TypuwwCOhAjvprXv+hfBCuFaomrcgIhst6dqiRxRO2Kb/Q+noQgZqq
	 ULpD7+2566p9hDBDW2qZbmKsqr0tcnChJJ+Y1gOu+CS8EHJLCeINitYo5k/PqslD35
	 JPVXWKTK8C36g==
Date: Tue, 05 Nov 2024 15:51:21 -0800
Subject: [GIT PULL 05/10] xfs: preparation for realtime allocation groups
From: "Darrick J. Wong" <djwong@kernel.org>
To: cem@kernel.org, djwong@kernel.org
Cc: hch@lst.de, linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Message-ID: <173085054289.1980968.4851664328873752187.stg-ugh@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20241105234839.GL2386201@frogsfrogsfrogs>
References: <20241105234839.GL2386201@frogsfrogsfrogs>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Hi Carlos,

Please pull this branch with changes for xfs for 6.13-rc1.

As usual, I did a test-merge with the main upstream branch as of a few
minutes ago, and didn't see any conflicts.  Please let me know if you
encounter any problems.

--D

The following changes since commit f220f6da5f4ad7da538c39075cf57e829d5202f7:

xfs: make RT extent numbers relative to the rtgroup (2024-11-05 13:38:38 -0800)

are available in the Git repository at:

https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git tags/rtgroups-prep-6.13_2024-11-05

for you to fetch changes up to 64c58d7c99343a910edf995e15d8037e19ec5777:

iomap: add a merge boundary flag (2024-11-05 13:38:39 -0800)

----------------------------------------------------------------
xfs: preparation for realtime allocation groups [v5.5 05/10]

Prepare for realtime groups by adding a few bug fixes and generic code
that will be necessary.

With a bit of luck, this should all go splendidly.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>

----------------------------------------------------------------
Christoph Hellwig (1):
iomap: add a merge boundary flag

Darrick J. Wong (1):
xfs: fix rt device offset calculations for FITRIM

fs/iomap/buffered-io.c |  6 ++++++
fs/xfs/xfs_discard.c   | 19 +++++++++++--------
include/linux/iomap.h  |  4 ++++
3 files changed, 21 insertions(+), 8 deletions(-)


