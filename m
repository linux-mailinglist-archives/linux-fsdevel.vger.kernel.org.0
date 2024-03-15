Return-Path: <linux-fsdevel+bounces-14424-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA86587C81D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Mar 2024 04:53:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 767C428337C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Mar 2024 03:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA337DDD8;
	Fri, 15 Mar 2024 03:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FQLrQSM+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2552D529
	for <linux-fsdevel@vger.kernel.org>; Fri, 15 Mar 2024 03:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710474802; cv=none; b=brsNHftx3sVToIWOsEhRrRdN64IrpvjMDdoQgdri86d/6ngsDAn7qiAqIYIaf1mXJGCueUhEA4SekpuNZF3gJztl2NPDwJLxfB9k1mVrvLrpEDIBf3l0d8jOSuKwM3Ip3LsHzP6C/R7oa+XxzGcsIUesJidI3NPzz7pPBMLrJ94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710474802; c=relaxed/simple;
	bh=xlL+bgQJx8OBUNtkcIYhKbYNUoJ8zSpMLkHUXCintC4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q3YiXhJQdjNUGESrJhJUeoGzo08mZI+1f89Xgl+h+BuXrwer23GtmmOzcNWRpEO95DCoNWMuLtHENPSvqwf3tBS7uLZt+LgYIvYIlSHhfnrjhxTl/tbvgqaKRFoYfu6hGRe+PQbC8kEGJMLy/ozlU2KR5V1A3zvwE/5Mev8kNBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FQLrQSM+; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1710474798;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=TThg8vKvUGeuptSZ4yh+09nHmN7uKj6B3GA2KWY2EzA=;
	b=FQLrQSM+1kl2FzEMqMRBOVKB9kloAt6lxjkdv+geR6rCn/HMW9QM7nVezlPsBC+JUVasky
	nUcYmVMm/IOXNMx/8Mj3QEncQ4cvxLuGUeax8ECNP0XGeam0FMzvDtSm+ieyJM+5MyJRZd
	ktdVeo9hk2LcJwGYY9h0jJRm31qYv3U=
From: Kent Overstreet <kent.overstreet@linux.dev>
To: torvalds@linux-foundation.org
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>
Subject: [PATCH 0/3] bit more FS_IOC_GETFSUUID, FS_IOC_GETFSSYSFSPATH
Date: Thu, 14 Mar 2024 23:52:59 -0400
Message-ID: <20240315035308.3563511-1-kent.overstreet@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

implement FS_IOC_GETFSUUID, FS_IOC_GETFSSYSFSPATH a bit more

also: https://evilpiepirate.org/git/bcachefs.git/commit/?h=bcachefs-sysfs-ioctls

Kent Overstreet (3):
  bcachefs: Switch to uuid_to_fsid()
  bcachefs: Initialize super_block->s_uuid
  ext4: Add support for FS_IOC_GETFSSYSFSPATH

 fs/bcachefs/fs.c | 9 ++++-----
 fs/ext4/super.c  | 1 +
 2 files changed, 5 insertions(+), 5 deletions(-)

-- 
2.43.0


