Return-Path: <linux-fsdevel+bounces-46265-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCFEEA8601A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Apr 2025 16:11:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B6E43AAD27
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Apr 2025 14:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D62EF1F30A4;
	Fri, 11 Apr 2025 14:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B3P8xhnw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3A215A848;
	Fri, 11 Apr 2025 14:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744380517; cv=none; b=nV/j/N764MsN6G2Bqhc6QA0WLSTof6z5AQhPNo32ELg6yB4YMv8+TWEdkiNvEqg2g0Wa4rqNjyNf3s0T3xFUMyZ6B5GyCBhnCYfEHj+JD5mv0Trh4UD+OVus/IvZ0FPoR/7oxQMAKQ1xV5ifGbwvSwP56xb8FwaEzOusJFuxLHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744380517; c=relaxed/simple;
	bh=+6ZoGuxO7lMvb7tocC279TGiDtafYckzm6Ockln5kAY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CFWrvMfzpg3HfPpOVJGcUWrtQeRkOgWK7lX9XuW38fYrhvb9Ug1K2nIG8DUlJUFekn+FBqZVfIpnsGon1xd5rOliydPm2s4WxLRfckUbM6lkRChAEgZ8CDSezkGj5zXSXXtzw3AMeVjbG7p47+FFrnG75msMu3Qz8orJ+9Gd0o8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B3P8xhnw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 201F9C4CEE2;
	Fri, 11 Apr 2025 14:08:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744380516;
	bh=+6ZoGuxO7lMvb7tocC279TGiDtafYckzm6Ockln5kAY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B3P8xhnwvhV5G5jcYQH2Gj4QQfQj9XgSJVmE0DmCAH7orRPQjHgHLyOVSdjNbcN9l
	 LeXaBSvzWQHz0pIG8pRQwHQU6VF6K067DIjB/Z7EYAMh91GlQvil1YGu1+g+vvF5lb
	 AQEcc1rvZMOfiytqqTx2WidR0Ezr6rCXrLosM5dCaHTbX+buCrcIrbWgfDXSP5Lt0B
	 4EdSxBj1L0AZjB5OhD+sYQJRLMIiSKM6MOtHUBA13Vw6y79e13fpugXZlxM1QhqPO2
	 edDt5PajQlGOKn8DqsY4UN5E8yPHBuf7LsolkJaXzVgtYES0OHNUJsnooT/rKLnwEy
	 6yVSwxCAALN0A==
From: Christian Brauner <brauner@kernel.org>
To: linux-fsdevel@vger.kernel.org,
	Jan Stancek <jstancek@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>,
	viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs: use namespace_{lock,unlock} in dissolve_on_fput()
Date: Fri, 11 Apr 2025 16:08:30 +0200
Message-ID: <20250411-computer-wandschmuck-97a26d943a7b@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cad2f042b886bf0ced3d8e3aff120ec5e0125d61.1744297468.git.jstancek@redhat.com>
References: <cad2f042b886bf0ced3d8e3aff120ec5e0125d61.1744297468.git.jstancek@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1993; i=brauner@kernel.org; h=from:subject:message-id; bh=+6ZoGuxO7lMvb7tocC279TGiDtafYckzm6Ockln5kAY=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaT/VIrXtvW+tkvM8FLfraYbFzXn+rRtv+JeqPiwwM2BP 2vLTuPkjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIl0yjEyrOufUMFb/EeSZduc ZayWn+7PiFmz5+QlMaYWrweCCd38Jxn+isSaVIVN47xyZnp4qvR8iyh/aZPm22KeZ521ghpZftZ yAgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Thu, 10 Apr 2025 17:05:42 +0200, Jan Stancek wrote:
> In commit b73ec10a4587 ("fs: add fastpath for dissolve_on_fput()"),
> the namespace_{lock,unlock} has been replaced with scoped_guard
> using the namespace_sem. This however now also skips processing of
> 'unmounted' list in namespace_unlock(), and mount is not (immediately)
> cleaned up.
> 
> For example, this causes LTP move_mount02 fail:
>     ...
>     move_mount02.c:80: TPASS: invalid-from-fd: move_mount() failed as expected: EBADF (9)
>     move_mount02.c:80: TPASS: invalid-from-path: move_mount() failed as expected: ENOENT (2)
>     move_mount02.c:80: TPASS: invalid-to-fd: move_mount() failed as expected: EBADF (9)
>     move_mount02.c:80: TPASS: invalid-to-path: move_mount() failed as expected: ENOENT (2)
>     move_mount02.c:80: TPASS: invalid-flags: move_mount() failed as expected: EINVAL (22)
>     tst_test.c:1833: TINFO: === Testing on ext3 ===
>     tst_test.c:1170: TINFO: Formatting /dev/loop0 with ext3 opts='' extra opts=''
>     mke2fs 1.47.2 (1-Jan-2025)
>     /dev/loop0 is apparently in use by the system; will not make a filesystem here!
>     tst_test.c:1170: TBROK: mkfs.ext3 failed with exit code 1
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

[1/1] fs: use namespace_{lock,unlock} in dissolve_on_fput()
      https://git.kernel.org/vfs/vfs/c/47a742fd977a

