Return-Path: <linux-fsdevel+bounces-9512-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF70384201E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jan 2024 10:51:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A5EC291E5B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jan 2024 09:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 898B4664BB;
	Tue, 30 Jan 2024 09:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XisrWEuS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC1D560BB0;
	Tue, 30 Jan 2024 09:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706608160; cv=none; b=j+ySPIZfshI6WGRSCulujXO4T9sEVUbrbIOucWM9PRfl8JlnASmZ562eG/Chhq23g8EKabTf38c1vYu70sU/E2mmGHe0OtOQH19Taq5shxqtvI1/rrhnV7KYZ4RoNsoFReeODnu+3eABkEhLDhYu02hzJ3BKZda5waBxvYJWp5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706608160; c=relaxed/simple;
	bh=9EEwbvIMGEnEj9No9CAfp/4Tfeu1tehss7c6XJeh6nY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K8tBoNCYSe69GOr2MzP53ILr+FzJCeDLNJvsK/Rm4Xj6QlsoN62sBkADPdZ4m86pi57Uo9N4DQ6bxXVQyKBRYbLL9wcZDuz4ynu+IO436xswxTKOJ/t3iZ8Ixr1lNpyqGKWCwWjuQsVqkXbmVJVnV81qWtB4gvYVBol4jpTyEuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XisrWEuS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90182C433F1;
	Tue, 30 Jan 2024 09:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706608159;
	bh=9EEwbvIMGEnEj9No9CAfp/4Tfeu1tehss7c6XJeh6nY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XisrWEuSi4MvUDAjSC37EjVj1CPda7zNWR9GS72XK5rEmXbjy1u1wrSPe3ub4mS4S
	 AemgWhjfkCTYXNxrionkITzJzlsLClotn6mqhRlB7K7s1zlCPRADTHeUV7ffGSO/Tx
	 Ipc3tFusQuehtq5MjQq8GELpq489dCIhhGg7t4hkGunI5uW3ITuFnKsvsMD70VoB+F
	 d9Ry/R9kyA3wKUehh34DjGmeZR7ku/q3NA0j33uzvJem3LFqIzX30/J/iu2FbUu3TY
	 l6ewkwjpQUdX0ztd0lS+V8eTskENGID2umhDOEWfCYJjXifaA/ZhuH19HwuhorWYoG
	 x6c428R5T1Aag==
From: Christian Brauner <brauner@kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] select: Avoid wrap-around instrumentation in do_sys_poll()
Date: Tue, 30 Jan 2024 10:49:10 +0100
Message-ID: <20240130-galant-messlatte-0a81f7a91b11@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240129184014.work.593-kees@kernel.org>
References: <20240129184014.work.593-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1292; i=brauner@kernel.org; h=from:subject:message-id; bh=9EEwbvIMGEnEj9No9CAfp/4Tfeu1tehss7c6XJeh6nY=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTuOCbx1uDg853yZcJS/Mziaz0mSDf84tN59sfe5vu29 t0zf/jv6ShlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjI5wZGhh3WauwrZTVful/L W/y+c/eUWKO7gpPz276ecI7kWxvzPpeRYWWag8G72q27VhvLPV0/Y4PRDQmtlbu4N97UE9a+dJO 7hgkA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Mon, 29 Jan 2024 10:40:15 -0800, Kees Cook wrote:
> The mix of int, unsigned int, and unsigned long used by struct
> poll_list::len, todo, len, and j meant that the signed overflow
> sanitizer got worried it needed to instrument several places where
> arithmetic happens between these variables. Since all of the variables
> are always positive and bounded by unsigned int, use a single type in
> all places. Additionally expand the zero-test into an explicit range
> check before updating "todo".
> 
> [...]

Applied to the vfs.misc branch of the vfs/vfs.git tree.
Patches in the vfs.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.misc

[1/1] select: Avoid wrap-around instrumentation in do_sys_poll()
      https://git.kernel.org/vfs/vfs/c/ecd1f34f1242

