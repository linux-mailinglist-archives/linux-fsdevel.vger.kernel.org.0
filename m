Return-Path: <linux-fsdevel+bounces-52521-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71E9AAE3D11
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 12:45:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3BB23A47B3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 10:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C71CA24FBFF;
	Mon, 23 Jun 2025 10:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LWDUxkui"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2148C23F424;
	Mon, 23 Jun 2025 10:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750675202; cv=none; b=EuOM5rcj9ybEX2xgFVV4jHqOvSGJPMT7IsuHyhD9Ik7flwQtqQctRsjmP1zr3BzY6+4boASiwP6ee00lPwM5UA/8xlShmdBMEqzghTTgJItFPX05EhGg2wD8L6NSga7ZKVhmkLlSFOG0Zf4MEtT/HiozTxPLziQZg+I7H8/8bBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750675202; c=relaxed/simple;
	bh=q0IbJe5Acyv2o2iG7qQqBmB32b5yE1J/4NdxJvABi38=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cnrCwGVovcgcZmwQMs6eO8NKtMMgmU7MBEveMGrAD3ram59rAvRptuRZ1mDVIgMEt+9WkfPUfKwrknmZ0YJNPX2DPodpWvnjlBuHb62XKP0ceZ7wRfSJd6vRu3u6m5FpKzkOBOy0N/KAZ9o//wgADtpEFknzQtiMj2fFu5km4l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LWDUxkui; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BE66C4CEF3;
	Mon, 23 Jun 2025 10:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750675201;
	bh=q0IbJe5Acyv2o2iG7qQqBmB32b5yE1J/4NdxJvABi38=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LWDUxkuigNvEYP+j1pGAphQRreHDT+ztMamwMaryiOX7mhGgDBmjPAFTCQk/n4FIQ
	 MhHAGMmwz38Vcrtkh2mn7b9TnWDIRqd8381kadT/bIGHVLrOzX1GSc1jXvICf6Fp4o
	 bLzuYi4jr7uc5Rfeek7ZzRpjzfWvrQRoZqDZATwtCRU3Um/eg82cuJ99vcjTs3zyby
	 GOxeSjNZzKHRC3iGcdBM3rj8YAG4+WeDYqW3wYMv8kiNlREK+SlnIK26wbvmAj07ic
	 Mr3FvuTPwDaoyQpuZUsCdPaF3allFZrzzOGQ4u3qsL0gaVjqqxgPD0MSV1vBnMlrtR
	 Nab3ScIDagwRg==
From: Christian Brauner <brauner@kernel.org>
To: Nam Cao <namcao@linutronix.de>
Cc: Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Shuah Khan <shuah@kernel.org>,
	Luca Boccassi <luca.boccassi@gmail.com>,
	Alexander Mikhalitsyn <alexander@mihalicyn.com>,
	linux-kselftest@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/coredump: Fix "socket_detect_userspace_client" test failure
Date: Mon, 23 Jun 2025 12:39:41 +0200
Message-ID: <20250623-zoologie-tumult-df3f34426b71@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250620110252.1640391-1-namcao@linutronix.de>
References: <20250620110252.1640391-1-namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1280; i=brauner@kernel.org; h=from:subject:message-id; bh=q0IbJe5Acyv2o2iG7qQqBmB32b5yE1J/4NdxJvABi38=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRE6v26I3Kt9Jb+9+kF7jMaFTv48ydbOP2OyP9497gr/ xeJ0Hz1jlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIl4iTMyrAxY8/at6g+7hoV7 zjXVM/zc+eDEL4aJxmX6k78H5DgmtTAyzE82Dlu6a7133L7vhdELGW4u3hofafWlW2hL0yHNiUc uswEA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Fri, 20 Jun 2025 13:02:52 +0200, Nam Cao wrote:
> The coredump.socket_detect_userspace_client test occasionally fails:
>     #  RUN           coredump.socket_detect_userspace_client ...
>     # stackdump_test.c:500:socket_detect_userspace_client:Expected 0 (0) != WIFEXITED(status) (0)
>     # socket_detect_userspace_client: Test terminated by assertion
>     #          FAIL  coredump.socket_detect_userspace_client
>     not ok 3 coredump.socket_detect_userspace_client
> 
> [...]

Applied to the vfs.fixes branch of the vfs/vfs.git tree.
Patches in the vfs.fixes branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.fixes

[1/1] selftests/coredump: Fix "socket_detect_userspace_client" test failure
      https://git.kernel.org/vfs/vfs/c/ce9bb9487ef0

