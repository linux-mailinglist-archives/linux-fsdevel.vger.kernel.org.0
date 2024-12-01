Return-Path: <linux-fsdevel+bounces-36199-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC5E59DF5B2
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Dec 2024 14:12:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29038B211BE
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Dec 2024 13:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B25381CB514;
	Sun,  1 Dec 2024 13:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sdmDYbjf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 182541CB32A;
	Sun,  1 Dec 2024 13:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733058765; cv=none; b=UC6W5Cn1Eo8yS8eyUa2UdjfFUbUKVgASprBZhS4vQrKE83LE42ACerlQrOmn1UzDkuM2o0YAbuyn3EBy+clOoUzSoq1ihQu2qD6QAE4WxoV+eH9d/PL4dqLIcXeR5pDyuq3aQhX5dOtSoII+61KDYUToKsssHQpx1cY9XY0rvqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733058765; c=relaxed/simple;
	bh=5eOrIGq9ctcyy6UeIx1pTVhZJ9bmnz+/IJY5Z6k2n3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Sh/eskcL67I+2O8N4bEl/zwxGAQVX3Y2wOMIGHT7m0q1n9cfrFo9msu7UDpvm9QTe0ak90Wp2XWxtX1gikd3RVaxzerXplXs6XR1X/zoaMfHst/iAoApHub5KiiDWga3Fno/Lm0W5kmakdwGNxN2Nilu28YNIXSM5BWhIxE2hGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sdmDYbjf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB17AC4CECF;
	Sun,  1 Dec 2024 13:12:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733058765;
	bh=5eOrIGq9ctcyy6UeIx1pTVhZJ9bmnz+/IJY5Z6k2n3Y=;
	h=From:To:Cc:Subject:Date:From;
	b=sdmDYbjfV0iU0Nh5EcXAt8m5nXKS2ZAAIjK8x65ceIw5fKloEViKgwhoziQitj23N
	 xaJI/Wf3WwHMH64GCfb9uFjlCgwamoWvspfrcXZZ1x+HXIT25ju2DFXMPFB691spxi
	 L8yVvUrsYeHOWb6oVlJ0sb1IWP/sdR74/k2/IlDGcT2cVcgB3h51fJwASbMGZrmWB7
	 ndtISIAuBVufacUy9DsbX/6FKnyB0xzEtU750QbCB0fyFrhXe0IkBpm9bik9mZOU76
	 PVZP3NB5+muDBJykgurHCh7EnvPTKehz7PP0ISw/mxr7yZ+gt21XuM8551haRW55rA
	 ZQUhBI3rnhHVQ==
From: Christian Brauner <brauner@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Erin Shepherd <erin.shepherd@e43.eu>,
	Chuck Lever <chuck.lever@oracle.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	stable <stable@kernel.org>
Subject: [PATCH 0/4] exportfs: add flag to allow marking export operations as only supporting file handles
Date: Sun,  1 Dec 2024 14:12:24 +0100
Message-ID: <20241201-work-exportfs-v1-0-b850dda4502a@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Change-ID: 20241201-work-exportfs-cd49bee773c5
X-Mailer: b4 0.15-dev-355e8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1384; i=brauner@kernel.org; h=from:subject:message-id; bh=5eOrIGq9ctcyy6UeIx1pTVhZJ9bmnz+/IJY5Z6k2n3Y=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaT7JOwVPcnL1LPltdu3tXkSXlYnnuZf4PkvxXojwua+j zzr8jUJHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABN5HsfwV/D/M2WR5rzlx/mU dcLtVvMtOeLZUafwaZ6A8L/p30+fjmb4w5UwXen8Ym7NXkWVYuunUe0brr5e06y7JJhblIGlKca ZFQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey,

Some filesystems like kernfs and pidfs support file handles as a
convenience to enable the use of name_to_handle_at(2) and
open_by_handle_at(2) but don't want to and cannot be reliably exported.
Add a flag that allows them to mark their export operations accordingly
and make NFS check for its presence.

@Amir, I'll reorder the patches such that this series comes prior to the
pidfs file handle series. Doing it that way will mean that there's never
a state where pidfs supports file handles while also being exportable.
It's probably not a big deal but it's definitely cleaner. It also means
the last patch in this series to mark pidfs as non-exportable can be
dropped. Instead pidfs export operations will be marked as
non-exportable in the patch that they are added in.

Thanks!
Christian

---
Christian Brauner (4):
      exportfs: add flag to indicate local file handles
      kernfs: restrict to local file handles
      ovl: restrict to exportable file handles
      pidfs: restrict to local file handles

 fs/kernfs/mount.c        | 1 +
 fs/nfsd/export.c         | 8 +++++++-
 fs/overlayfs/util.c      | 7 ++++++-
 fs/pidfs.c               | 1 +
 include/linux/exportfs.h | 1 +
 5 files changed, 16 insertions(+), 2 deletions(-)
---
base-commit: 74e20c5946ab3f8ad959ea34f63f21e157d3ebae
change-id: 20241201-work-exportfs-cd49bee773c5


