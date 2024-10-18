Return-Path: <linux-fsdevel+bounces-32341-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C39709A3CCC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Oct 2024 13:09:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F1A11F26DC8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Oct 2024 11:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E19D82038A0;
	Fri, 18 Oct 2024 11:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BhHz9vD2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 403F22010E6;
	Fri, 18 Oct 2024 11:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729249401; cv=none; b=u+rO3EZwjw+Y6R9uuTlOHtXo8+6XoTT3Gqe5iI/1G3P7YN7yrOJhFKCSVcQIv78m09l8pNsZWh2el9nASEF2N1nzlk0EAkC+IwqeBgksYiVRTaZVjvs8R/hSwRmCIqt8Q+sRdnsmfitibMulzaweSpK9cx03+oIZOla6xnohyps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729249401; c=relaxed/simple;
	bh=CLn7iZAaQy/gzrcoCg6aXb/xKmwS/dcifC9LXkkmEbc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z2l9mnhR0zjh99TDSppNfYkQeKwf+eQB5dH/bOHGNaASlE0pj6gRBl3anoYyUfVScvhat9LZ+m1oTNT3OPbRasBbt3ESEismFpLzHc/ErNSw/pm4ADefMnbuEJO8gzWuUXEXJHXy6Bw7CsJy40UmLHPyhQXnqKHPC1cw7WDSIxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BhHz9vD2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31E6EC4CEC3;
	Fri, 18 Oct 2024 11:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729249400;
	bh=CLn7iZAaQy/gzrcoCg6aXb/xKmwS/dcifC9LXkkmEbc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BhHz9vD2RpXdDX5Soc0XVhkKBqR9QOPIR9mbZx+Ut+MZOXDEdsKmIH/cvr9SivJAt
	 LDqA2TReKYOx8rvw3GscgOYsc54e7SaTK3cLG4uVKOEPSDgRVuE6VbI7EXuPJLt7AT
	 2XwT8sdn/wxBMA0hc967jbQT36r7GHFc87jAdBxMDYjqFhKCL+qFyyelTbx1JL9KGy
	 /dzuty+EtIerG7QIagnROSRUUy1UbPRvLwgVROIaVRyiPR2umHE7fmUJsmGhHnHCmq
	 y1aH9AOClIdO39rOJCi37v9Q+tU6t6OL0Rq+H0L0+zLsNeMG3u4/h8gbuVCALfMHCf
	 xUxX8up9QsmUg==
From: Christian Brauner <brauner@kernel.org>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Josef Bacik <josef@toxicpanda.com>,
	"Tyler Hicks (Microsoft)" <code@tyhicks.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Yan Zhen <yanzhen@vivo.com>
Subject: Re: [PATCH] proc: Fix W=1 build kernel-doc warning
Date: Fri, 18 Oct 2024 13:03:04 +0200
Message-ID: <20241018-soviel-ambitioniert-fc21fe4b9e9c@brauner>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241018102705.92237-2-thorsten.blum@linux.dev>
References: <20241018102705.92237-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1088; i=brauner@kernel.org; h=from:subject:message-id; bh=CLn7iZAaQy/gzrcoCg6aXb/xKmwS/dcifC9LXkkmEbc=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQLORRk3LlySOmjvHzFK70d6xfvC7P0OHLnLyNTY/vty wn7s1ce7ShlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjIPGOGf1ahd/Qv8/UxXEos CH0Q6d21e7PBcqXzefm7pl7Q8Jt5dyHDP/3NnPs/pV76E/NM8m/T9ovCm717dZZuyfVfvFU5ult TgQMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Fri, 18 Oct 2024 12:27:03 +0200, Thorsten Blum wrote:
> Building the kernel with W=1 generates the following warning:
> 
>   fs/proc/fd.c:81: warning: This comment starts with '/**',
>                    but isn't a kernel-doc comment.
> 
> Use a normal comment for the helper function proc_fdinfo_permission().
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

[1/1] proc: Fix W=1 build kernel-doc warning
      https://git.kernel.org/vfs/vfs/c/197231da7f6a

