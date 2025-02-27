Return-Path: <linux-fsdevel+bounces-42746-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7784FA4778F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Feb 2025 09:18:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21DF718913D4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Feb 2025 08:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BCC4226170;
	Thu, 27 Feb 2025 08:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l1Hs4c7e"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB7C225792;
	Thu, 27 Feb 2025 08:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740644187; cv=none; b=icxvSRZtHtxClEhdzz5OiZu97o0ZNzUHfhk06XTDb3nAPn1D+TboKOHr0PQTqX60vBA2m4HYdvOn9ftJzbG1u8/o1rILgGhb6W4CGvAIsusemgaHgIqni4RY8MXsaeYvsNGYjXnUeVSnb74DRqldLkAzkhOpxZ3lRuQkdJTBP6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740644187; c=relaxed/simple;
	bh=LFvmFgpPTUMO2psCWfl8Ssp0LGI9GUet4LQidw6SJtw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A/+HufWUG+6MwY7Kw1L8lbMAKUCJjg+URm311H2Po/7aIT8Vl77CR8vbqTOl0FI2QcFclVKMVsyFcN765aStb8tPw2tFahvCbatHHddcXr0Fmm1Vyew0vFH92uinLlgatKwqtGcY6oYHuVqr0xiyPIKPJq8+YmweVeuJyies+NU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l1Hs4c7e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A091C2BCB1;
	Thu, 27 Feb 2025 08:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740644187;
	bh=LFvmFgpPTUMO2psCWfl8Ssp0LGI9GUet4LQidw6SJtw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l1Hs4c7ecDP5u6cqgSRtYER7oSYRr3gKUp4j6IVcbcL0dO8+2jJwKCzZpHw9N3dRX
	 Cpw6LXgirfbCeSEHVLmFNErOHFlsZjVqhz/kzpGK9h87Nw2ggL5CK/MfYhmqUaLSse
	 YRS8nsIdQboTTiw9T5sASAtPSCVBXi6xgc5S1dWRadThXMDHgqvHvUr3LFrhQ5GGOD
	 LkLzmbfet1kosRaXXBoTMIlNNhN6PPtSKdxOhka0gkoHttiGnqvBWb1Xdgpiyxs6ln
	 HhxpzEPdE4c0i0wQP8UXDPkstAqUw/rxkzruB3OEBfU7oM/1ruE634Gma8chE7QYEl
	 i92cQ3ePvBhMg==
From: Christian Brauner <brauner@kernel.org>
To: selinux@vger.kernel.org,
	Miklos Szeredi <mszeredi@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	Paul Moore <paul@paul-moore.com>
Subject: Re: [PATCH] selinux: add FILE__WATCH_MOUNTNS
Date: Thu, 27 Feb 2025 09:16:20 +0100
Message-ID: <20250227-ergrauen-plazieren-0e9f5a81cc05@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250224154836.958915-1-mszeredi@redhat.com>
References: <20250224154836.958915-1-mszeredi@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1134; i=brauner@kernel.org; h=from:subject:message-id; bh=LFvmFgpPTUMO2psCWfl8Ssp0LGI9GUet4LQidw6SJtw=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQfkA+NXPpS5secd5OFZ83yvZDOFKPhs4YnmKn/dJfUn mnqc7fndJSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzkrTojw/9gp6CWaSu33Tp7 9czy1+cfrP/3NMnyTo/KM70Z/gldNzMYGe5sbJURf8IgMCOzNjNbqudFd4S5cW/Yve3nX72eEc7 Nwg4A
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Mon, 24 Feb 2025 16:48:36 +0100, Miklos Szeredi wrote:
> Watching mount namespaces for changes (mount, umount, move mount) was added
> by previous patches.
> 
> This patch adds the file/watch_mountns permission that can be applied to
> nsfs files (/proc/$$/ns/mnt), making it possible to allow or deny watching
> a particular namespace for changes.
> 
> [...]

Applied to the vfs-6.15.mount branch of the vfs/vfs.git tree.
Patches in the vfs-6.15.mount branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.15.mount

[1/1] selinux: add FILE__WATCH_MOUNTNS
      https://git.kernel.org/vfs/vfs/c/7d90fb525319

