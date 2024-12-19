Return-Path: <linux-fsdevel+bounces-37832-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F6679F80E8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2024 18:02:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1619616B953
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2024 17:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 794321993B7;
	Thu, 19 Dec 2024 17:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HiJIFom1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7D9915442C
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Dec 2024 17:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734627706; cv=none; b=O8fAivdFeFjsiXN03r+P8IZ+hmwn5has6IgLaw4eK6xPeHmlgc062QLni9RBy+sp2phVA2NkWdl2xR90Fe4Fm+fk8L9XzlYsbEvLdBtJqJSJNwpY5LLwWPC/q/oaFF9GrI9CgBsEJciVLk3h4z8ahbaE42pJb1O7NOoaQeB/SBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734627706; c=relaxed/simple;
	bh=aFuZgy56hnHu/Df2Ml3J76z0ntZ6iBehYLyCBziSrF4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Y/nAH6RdrVT1DpJZuEKpcaAkQcJI9/y0l2SVf6R+He8W+le5fNqfTV6ixT264l+wKrQVUmBfthmKo6gRGPKkGtxxKeXPR9gWO/DOR8Uud9Nl6u6WTgHlIaKo5qy6FJ6zdw2GlQCYLPj7/8kExpN+ndVJsjDGuKSeTIa36BN3I9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HiJIFom1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EAB4C4CECE;
	Thu, 19 Dec 2024 17:01:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734627706;
	bh=aFuZgy56hnHu/Df2Ml3J76z0ntZ6iBehYLyCBziSrF4=;
	h=From:Subject:Date:To:Cc:From;
	b=HiJIFom1Zh0VjYZZbCneBV0L6orWZFg/laPYHChIbeiF+Of3oGhLiv1ZcHc7iC63D
	 9BcX0HLbNQ/GQl+1eeZmoBc3+VL4kUWUuk4ZYRRHVFKwMS+xlPr8MPC2QYVp1O+bEp
	 pWCqFZCqy3f8y3zrZU98qe9vR+awsgm/KltGqZqLNu1hAZ2hSz1BJIV4N1ZzvEHfnO
	 Kk3PzxFs4WKu3V+aErYCdDjrOhpu8bNAo+swJRjlkWL6pef1O6j/bwJFCTNREEnuXh
	 4UTyIG5wWBujc7zUgKVAOFCWveqsALVshzR7IFCaPEbNqTa2f6u7JG2t8ZilK7Syyy
	 zGSQvTGRZgRTw==
From: Christian Brauner <brauner@kernel.org>
Subject: [PATCH RFC 0/2] pidfs: support bind-mounts
Date: Thu, 19 Dec 2024 18:01:31 +0100
Message-Id: <20241219-work-pidfs-mount-v1-0-dbc56198b839@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGtRZGcC/x2MQQrCMBAAv1L27JYmFjFehT7Aa/GQJhu7iElJb
 BVK/+7a4wzMrFAoMxW4VCtkWrhwigLqUIEbbXwQshcG3ehWaWXwk/ITJ/ah4CvN8Y3m2ARzNsY
 q50GyKVPg777s4dZd4S5ysIVwyDa68X9bpD7Vqq33EWzbD3nHH72IAAAA
X-Change-ID: 20241219-work-pidfs-mount-930f9899a1cd
To: linux-fsdevel@vger.kernel.org
Cc: Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>, 
 Miklos Szeredi <miklos@szeredi.hu>, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-355e8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1055; i=brauner@kernel.org;
 h=from:subject:message-id; bh=aFuZgy56hnHu/Df2Ml3J76z0ntZ6iBehYLyCBziSrF4=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSnBFZoi5iHCHXKxYpqSE+uWKj9YZNap88ip63GRvw8z
 5MtXHg7SlkYxLgYZMUUWRzaTcLllvNUbDbK1ICZw8oEMoSBi1MAJiKSzPC/8IVECtu+JTHfu61S
 VHdt2VhpcvnAt/tRMu80Jy5k0tz9jZHh2imv5PC0B54lXs2iWuZmc97o8B1eq/J8voLBih/6fMc
 4AA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Allow bind-mounting pidfds. Similar to nsfs let's allow bind-mounts for
pidfds. This allows pidfds to be safely recovered and checked for
process recycling.

Instead of checking d_ops for both nsfs and pidfs we could in a
follow-up patch add a flag argument to struct dentry_operations that
functions similar to file_operations->fop_flags.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
Christian Brauner (2):
      pidfs: allow bind-mounts
      selftests: add pidfd bind-mount tests

 fs/namespace.c                                   |  10 +-
 fs/pidfs.c                                       |   2 +-
 include/linux/pidfs.h                            |   1 +
 tools/testing/selftests/pidfd/.gitignore         |   1 +
 tools/testing/selftests/pidfd/Makefile           |   2 +-
 tools/testing/selftests/pidfd/pidfd_bind_mount.c | 188 +++++++++++++++++++++++
 6 files changed, 200 insertions(+), 4 deletions(-)
---
base-commit: 16ecd47cb0cd895c7c2f5dd5db50f6c005c51639
change-id: 20241219-work-pidfs-mount-930f9899a1cd


