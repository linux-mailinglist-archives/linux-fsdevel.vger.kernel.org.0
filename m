Return-Path: <linux-fsdevel+bounces-65979-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D76CC1791E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 01:39:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A05651C67C78
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 00:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A33772D0292;
	Wed, 29 Oct 2025 00:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eF5x5XRP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06CAA3A1CD;
	Wed, 29 Oct 2025 00:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761698339; cv=none; b=HZ1rn6TYo8s4ipgT3Lw/BJjALPLd46jjgsAuaRI/trjvYRyyZp73AHQu7vPUrsTybUAjknhReS2dn+xX4KvTR5xsY36iEFCpMGtV1Z+l1ompRmMOkPcsz0mrkc1CzqNwfyyPVCKEvbucNZ0GSJo/tY3sgqRyx/PndaNHbJSH2RU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761698339; c=relaxed/simple;
	bh=4I5hXOs36K19a9LmOPEQFqBNGALqwnBMZ4YoX5qFXuE=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hp6NTIVv+zec87yp5dEbGjVppy0I3WbRplegtgNvNM5uE+QYM/ikPzaRXmRbkc0CEt27tnkKeirod6w0pAZXhBt4+JxbidPOPo+cVfjzORxidaxqLf7tpJFOGvz+9Db64W4EkZMvCymEmOwulTietPDYMOHwlsNXz4dxAF6Z/m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eF5x5XRP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E4C9C4CEE7;
	Wed, 29 Oct 2025 00:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761698338;
	bh=4I5hXOs36K19a9LmOPEQFqBNGALqwnBMZ4YoX5qFXuE=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=eF5x5XRPMcS/lXA4gKHZEsjgF1RvNX/Ol/mq9EEhhKyITfgC6cfifehX2TMyNweZ9
	 Rl6n4DufwfvAcIna18b83jmapaBKxSCfDX4+6htSNmcPjxm2eJvsqfilK/VTeaxwex
	 hxwHYaDhFgHk5jagFYooKiOwWuDOY2mxnDBlIPcLjIrlfZQznxMfHHPt6NBjQPvEUj
	 PbP+QrTwioH73N0vaXsu+9R4tTbyVelXlxqFAiCQM1z8DLPbvYqRm/89c7R0zDctOo
	 Tq03CwPlP2On4JSy7pVuFAm80Tp7crvj1OWDNxsMm8cUd3+z8d04GYg1WctUmjqeSC
	 XiyVigVjpiL+Q==
Date: Tue, 28 Oct 2025 17:38:57 -0700
Subject: [PATCHSET v6 5/8] fuse: allow servers to specify root node id
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: joannelkoong@gmail.com, bernd@bsbernd.com, neal@gompa.dev,
 linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Message-ID: <176169811231.1426070.12996939158894110793.stgit@frogsfrogsfrogs>
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

This series grants fuse servers full control over the entire node id
address space by allowing them to specify the nodeid of the root
directory.  With this new feature, fuse4fs will not have to translate
node ids.

If you're going to start using this code, I strongly recommend pulling
from my git trees, which are linked below.

This has been running on the djcloud for months with no problems.  Enjoy!
Comments and questions are, as always, welcome.

--D

kernel git tree:
https://git.kernel.org/cgit/linux/kernel/git/djwong/xfs-linux.git/log/?h=fuse-root-nodeid
---
Commits in this patchset:
 * fuse: make the root nodeid dynamic
 * fuse_trace: make the root nodeid dynamic
 * fuse: allow setting of root nodeid
---
 fs/fuse/fuse_i.h     |    9 +++++++--
 fs/fuse/fuse_trace.h |    6 ++++--
 fs/fuse/dir.c        |   10 ++++++----
 fs/fuse/inode.c      |   22 ++++++++++++++++++----
 fs/fuse/readdir.c    |   10 +++++-----
 5 files changed, 40 insertions(+), 17 deletions(-)


