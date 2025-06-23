Return-Path: <linux-fsdevel+bounces-52529-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE6EAAE3D9C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 13:04:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6274818895AD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 11:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6555723D28B;
	Mon, 23 Jun 2025 11:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sPkM7kW6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B823C182D2;
	Mon, 23 Jun 2025 11:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750676632; cv=none; b=EvTsuLOG3zE0ZNxvmoHQXIoRoW5yFy3gLDPJ2VERxiTIMcuOcDfZcj6ZwABY1aeQ6vy+3aazaFBkmHEfBhggx6C/T9wjsI49pjWzXDf5ut4+miR6v3OXcuBGo0B2NsJFkOu0muUdGCygj8ASH19oBK+Z3GW8QMgIZuLPLMpodnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750676632; c=relaxed/simple;
	bh=21smDvP5Tb5dB+EW7EZRkIvGK7NLN7oX7RKnAaZeUUc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RUPTuXQostWICFFRU0HaPuGx9AvRgBXXxXSUCcdQQJwvDMNCVy0n/rnAvaLGYVuEbxQgxb+AbMpe6dzOLeMD29N7e8uQj41FTltLrxDAZvEobRdlntNO3UD0Jn53qg8jFNgeY3HlKHtm2BMIAk4JMbOawcYdDwxs9PpefVUWjVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sPkM7kW6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1349BC4CEF1;
	Mon, 23 Jun 2025 11:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750676632;
	bh=21smDvP5Tb5dB+EW7EZRkIvGK7NLN7oX7RKnAaZeUUc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sPkM7kW6RGrImFy4retADz8t+GdHqqKsxHHgKwTWXDGsQDDnzvOhdlnWWDf3vYyin
	 WXBGPLlYBeEQM3HKRxHMyatg8D7d2b7tGe+ORCrieFvWcvXnvZ9IoS0Oy+h/1SnDiS
	 z8LFpdON2a8hlvSXKs3oxx72CthgJWiE6uiYkdX3Svut5axsWXHcGk20/N8uSLIRVC
	 SNUgK5fb0corWQ7I8k2kxvURjaai3T3veCyQ06s7vN2qasHg+YgW0ShKH6GoPnoARO
	 bN8d62PvTc2Y3ACPqS77nFOJv7jiegTXZh09BbEdVyEegnyKbHv/+Xk1tyVIaH6W6C
	 yIhmWyM20aEDQ==
From: Christian Brauner <brauner@kernel.org>
To: Song Liu <song@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	kernel-team@meta.com,
	andrii@kernel.org,
	eddyz87@gmail.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	viro@zeniv.linux.org.uk,
	jack@suse.cz,
	kpsingh@kernel.org,
	mattbobrowski@google.com,
	amir73il@gmail.com,
	gregkh@linuxfoundation.org,
	tj@kernel.org,
	daan.j.demeyer@gmail.com,
	bpf@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH v3 bpf-next 0/4] Introduce bpf_cgroup_read_xattr
Date: Mon, 23 Jun 2025 13:03:22 +0200
Message-ID: <20250623-rebel-verlust-8fcd4cdd9122@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250623063854.1896364-1-song@kernel.org>
References: <20250623063854.1896364-1-song@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1306; i=brauner@kernel.org; h=from:subject:message-id; bh=21smDvP5Tb5dB+EW7EZRkIvGK7NLN7oX7RKnAaZeUUc=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWREmvQxxkmWnyiY9b4jkN35i/uWIpeicHWmWex96+5JF 9YafDDsKGVhEONikBVTZHFoNwmXW85TsdkoUwNmDisTyBAGLk4BmIh1GyPDowk9n9dHRU9IrLZ0 rp9+zKBUn7/Terd+fuJpbaXy+wEyDP/snW/sa9WpmOUTMm9P8Cmno1zhJZoq86JX+DoUMp0IZGU AAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Sun, 22 Jun 2025 23:38:50 -0700, Song Liu wrote:
> Introduce a new kfunc bpf_cgroup_read_xattr, which can read xattr from
> cgroupfs nodes. The primary users are LSMs, cgroup programs, and sched_ext.
> 

Applied to the vfs-6.17.bpf branch of the vfs/vfs.git tree.
Patches in the vfs-6.17.bpf branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.17.bpf

[1/4] kernfs: remove iattr_mutex
      https://git.kernel.org/vfs/vfs/c/d1f4e9026007
[2/4] bpf: Introduce bpf_cgroup_read_xattr to read xattr of cgroup's node
      https://git.kernel.org/vfs/vfs/c/535b070f4a80
[3/4] bpf: Mark cgroup_subsys_state->cgroup RCU safe
      https://git.kernel.org/vfs/vfs/c/1504d8c7c702
[4/4] selftests/bpf: Add tests for bpf_cgroup_read_xattr
      https://git.kernel.org/vfs/vfs/c/f4fba2d6d282

