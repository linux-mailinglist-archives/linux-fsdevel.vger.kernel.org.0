Return-Path: <linux-fsdevel+bounces-41085-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D31EA2AB54
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 15:31:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7DF816ACAE
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 14:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F2621E5B8C;
	Thu,  6 Feb 2025 14:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fGrWJCAF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F1271E5B82
	for <linux-fsdevel@vger.kernel.org>; Thu,  6 Feb 2025 14:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738852118; cv=none; b=urAmrOJikEgSTyKuelgxRrgcgHDvqTfRFj1VIk0gC6glIfsOdXoUYadlbYyT6XcONhuKndJ8U7B23h3A6WkBHtzqTs7DCzRCFk412V2Q1cfnQYRvb03sDNGlnzNZElDsgcpZ8ISJIO8dDCJrAgj+d6YCldOTleNcxTmky9t/nQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738852118; c=relaxed/simple;
	bh=wTE5RL0IflD2IUMXDukEjVJ/O0nYbhQLo9QHqIguBv0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FJFaJfJh8lMh3PN7C+k9izkFmM49/lpB+3kGwIsR2swSiYV8S3zoKcUEDOaLFsiaXIZ7qvwIeIMHIUo2DQe3tH7w2Q54Lx1/MtxKdPe4opACvF1VeEWN9RuHYxK4xUeQQzEspfe0mAKBCTeNheMOXyKABMKV8/6YVGAVMZV2Y8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fGrWJCAF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4304C4CEDD;
	Thu,  6 Feb 2025 14:28:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738852118;
	bh=wTE5RL0IflD2IUMXDukEjVJ/O0nYbhQLo9QHqIguBv0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fGrWJCAFaNvKZ+SbIz47cXjsexSmNJPfsMGvlf/0qcC/SMlhcDckfmEQ5s0B1hTXv
	 wyCQgAErNLAxoUDI2hQw3q6l4/Nu4SYVq4usphPDgP4m0GYFSLtwwfv5jMu2nv1Rxf
	 JonLEuqzHhcGyJ2Zdqd1BKeur8GEefEftCMorE4B0gRW62b1xZHWkgZ56JNRm9lDyi
	 q144PcUNgwx/lQUwb2GdqvuHjMh6DyXuLj7hGj/yAOniCyJncdfV+41DJtFlDUOh1t
	 HQl3a4O/wlS59qNtzczSU0VxoTA9S0tc8ikAI7a7Vs0Gxqa+45WJzs5mo9ttyLvC50
	 xRmOx2slsKJkw==
From: Christian Brauner <brauner@kernel.org>
To: Eric Sandeen <sandeen@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] sysv: convert sysv to use the new mount api
Date: Thu,  6 Feb 2025 15:27:16 +0100
Message-ID: <20250206-autoteile-getappt-e36e8bf4579d@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <be08b1c1-c6d7-4e82-b457-87116879bdac@redhat.com>
References: <be08b1c1-c6d7-4e82-b457-87116879bdac@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1388; i=brauner@kernel.org; h=from:subject:message-id; bh=wTE5RL0IflD2IUMXDukEjVJ/O0nYbhQLo9QHqIguBv0=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQvOS4wy0HqePdOh3e3b/ZcvKAbOnEOa/Lq7ccyHKXen tX23Cm+sqOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAiGyoY/pfuujMrnMs45J+K 8dOk8lJ/g5tL3tifEXLcFf+s9fIEkxRGhubs4jMFCxyjjmyOdIj4V3z7cWTiR6H7p5l0pL9wTds bzA0A
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Wed, 05 Feb 2025 16:30:09 -0600, Eric Sandeen wrote:
> Convert the sysv filesystem to use the new mount API.
> 
> Tested by mounting some old sysv & v7 images I found in archives;
> there are no mount options, and no remount op, so this conversion
> is trivial.
> 
> 
> [...]

I think it's fine to convert and then drop. It's also fine to drop and
thus not convert. Whatever happens to happen first. If Jan gets around
to the removal during this cycle we can always drop this. If it happens
next it's also fine. If we need to add it back we at least have the work
done already.

---

Applied to the vfs-6.15.mount.api branch of the vfs/vfs.git tree.
Patches in the vfs-6.15.mount.api branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.15.mount.api

[1/1] sysv: convert sysv to use the new mount api
      https://git.kernel.org/vfs/vfs/c/00dac020ca2a

