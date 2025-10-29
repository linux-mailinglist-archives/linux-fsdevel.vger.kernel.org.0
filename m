Return-Path: <linux-fsdevel+bounces-65985-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D611C1794B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 01:40:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CBF2C354A23
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 00:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11D252D0600;
	Wed, 29 Oct 2025 00:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uZdFs8UE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B70822F74E;
	Wed, 29 Oct 2025 00:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761698432; cv=none; b=PW7Q9pr6QvDvfQYqsEd8PzLhSlzIUtL7LGH6lgPYd5fhQar41ACI4nL9cOKxwUxZiHmaR8xuz0nWZcHMt7GHhvakWVqEq2gS58ked3lcJihoS94ieb1XNB7EF5cDsFJgnHJh21rbIsgWY/zjtBt7ewB1wHs0Q4Rm1HAnwlCH1Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761698432; c=relaxed/simple;
	bh=tRqAK5bXKdmDGiowwKsbLkkU6jZVWZX1YeZ3PdQ0ayU=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TAk9Yhz75QeaUZNW7qSEPZUzEORVUAIlS1yj8yUkructIk8gQ9EsU2wxs9yPntbzlopdwha0ENOvDRmHNcrWYci9Tx1ehmzt/8LOsKCmbbkT6wIYScP9W7Iu+j0O/4o82MoKK2Z237JZPci214HZS6Gg87SwZUP+Mpzoqw1lVtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uZdFs8UE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45EEFC4CEE7;
	Wed, 29 Oct 2025 00:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761698432;
	bh=tRqAK5bXKdmDGiowwKsbLkkU6jZVWZX1YeZ3PdQ0ayU=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=uZdFs8UEficYDuUOS5CHSIf/P1fz5uZq8yq9iK0jcMuyPdFGvhofc4IAzbrNci4SW
	 3ZL9zI1tFICEE5YXDQs//aWRZofvdaYhUxFoCZAOU+HC5q3zN1bAfVqMPtlI/NjocQ
	 5nhdONW32MHKbJ2NDYDD1U9l4I9LSZGSE4F7J2dwtvt/SmGepmenZoVGRr9jpFubjE
	 R+Alwhz3KB7fES4L8YNLEfyPMX6czp7JPbCp7MzijmkGddhcnIhaN8CDPmNmh5Q2B+
	 H/G3QARtTmSQK3R4fGfE9FkOaNN9rYwqMOoM7sfl4+T1i1J3jubop4uYdd3Xh0pZNk
	 5GTXL+RR9XPOw==
Date: Tue, 28 Oct 2025 17:40:31 -0700
Subject: [PATCHSET v6 3/5] libfuse: implement syncfs
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bschubert@ddn.com
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 bernd@bsbernd.com, miklos@szeredi.hu, joannelkoong@gmail.com, neal@gompa.dev
Message-ID: <176169814307.1428390.11550104537543281678.stgit@frogsfrogsfrogs>
In-Reply-To: <20251029002755.GK6174@frogsfrogsfrogs>
References: <20251029002755.GK6174@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Hi all,

Implement syncfs in libfuse so that iomap-compatible fuse servers can
receive syncfs commands, and enable fuse servers to transmit inode
flags to the kernel so that it can enforce sync, immutable, and append.
Also enable some of the timestamp update mount options.

If you're going to start using this code, I strongly recommend pulling
from my git trees, which are linked below.

With a bit of luck, this should all go splendidly.
Comments and questions are, as always, welcome.

--D

kernel git tree:
https://git.kernel.org/cgit/linux/kernel/git/djwong/xfs-linux.git/log/?h=fuse-iomap-attrs
---
Commits in this patchset:
 * libfuse: add strictatime/lazytime mount options
 * libfuse: set sync, immutable, and append when loading files
 * libfuse: wire up FUSE_SYNCFS to the low level library
 * libfuse: add syncfs support to the upper library
---
 include/fuse.h          |    5 +++++
 include/fuse_common.h   |    6 ++++++
 include/fuse_kernel.h   |    8 ++++++++
 include/fuse_lowlevel.h |   16 ++++++++++++++++
 lib/fuse.c              |   31 +++++++++++++++++++++++++++++++
 lib/fuse_lowlevel.c     |   25 +++++++++++++++++++++++++
 lib/mount.c             |   18 ++++++++++++++++--
 7 files changed, 107 insertions(+), 2 deletions(-)


