Return-Path: <linux-fsdevel+bounces-72055-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CCC8CDC46E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Dec 2025 13:50:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 75F0830136EF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Dec 2025 12:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AFEE326922;
	Wed, 24 Dec 2025 12:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N3RydRJn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B658C3128C2;
	Wed, 24 Dec 2025 12:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766580598; cv=none; b=YbErSEqOvRGliuEfGR4zyYtcLEr2W1Hn4CrfzoSdS7mlbyLMY7TJVvMzADyQPm9MldAPIKnAe7MzVFvzNiSv5YMGxtfWwtrG1QFendgTEjj7CTlv5AFVGCpJ71eBeRGlsoVzcNKeVK6HzUjtUv05iXZEo+7ZBcN1bRTCL2JnyE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766580598; c=relaxed/simple;
	bh=WTZwqMscj1m81ezIC442OoCvwHxFGU02XGIgQJBHXcE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qio8IzEnjemZ3inZKXw2NwlZ7noQFjrPrlSJyx3gAyhAzixsRj+tOE5H1yKOkwXyopSJygavFt1FtxKFLjdMUV6yiLeLX0s5WGNsLtFmgdxGhZd6Wb3NfvCdaEuBgv5WDmI8k8XX4seXeKgAv/RfbhQRD3mXXKi3BzTJzWP056M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N3RydRJn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4A3DC4CEFB;
	Wed, 24 Dec 2025 12:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766580598;
	bh=WTZwqMscj1m81ezIC442OoCvwHxFGU02XGIgQJBHXcE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N3RydRJn891AIU3PBvZUQwFImJXXwFhDYDMM9Zs8eP1KDovht2ekVXyPFrBIKELFS
	 u+vk3Y0q4noUiatbDhzoVceNK03qKdGa5cF8MmpYPpbHJUe8rO8jdJtnh0ZGHzQERk
	 CSOJxj1GzU6obp2e7+E+eGXzTDxJ1kxYPB88rKh1TOPl3X42xbDsd1IgrrAIVb2SZ3
	 hlLAH+gJ7jEUabCs5u1RxwIZOnhB+7HHvk05Om/dQ/cCVnplZ0RcD7zSJmWdX8PZcD
	 Hhkd5uGEULx4P1MoQG+Ejq92Z0sIVp58BgBu0hBvsRUz1APqjnDxzI1IUWQF35FENw
	 A8nQ7cP6q5Rxw==
From: Christian Brauner <brauner@kernel.org>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] dcache: Replace simple_strtoul with kstrtoul in set_dhash_entries
Date: Wed, 24 Dec 2025 13:49:48 +0100
Message-ID: <20251224-joghurt-hauen-459014aae177@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251216145236.44520-2-thorsten.blum@linux.dev>
References: <20251216145236.44520-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1180; i=brauner@kernel.org; h=from:subject:message-id; bh=WTZwqMscj1m81ezIC442OoCvwHxFGU02XGIgQJBHXcE=; b=kA0DAAoWkcYbwGV43KIByyZiAGlL4XGi6r81uzCYZE1BS5Y/HMInySe8UUNGoziur0r2HQXBG Ih1BAAWCgAdFiEEQIc0Vx6nDHizMmkokcYbwGV43KIFAmlL4XEACgkQkcYbwGV43KI58QD/UYU+ Iw6gwJ28mXsFmJt86V7wzJescdsGPL3aRFgaS3AA/02tlI4/EhzoHEUmqAG3vmSIoJhu4YcloaQ XusDblg0I
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Tue, 16 Dec 2025 15:52:37 +0100, Thorsten Blum wrote:
> Replace simple_strtoul() with the recommended kstrtoul() for parsing the
> 'dhash_entries=' boot parameter.
> 
> Check the return value of kstrtoul() and reject invalid values. This
> adds error handling while preserving behavior for existing values, and
> removes use of the deprecated simple_strtoul() helper.
> 
> [...]

Applied to the vfs-7.0.misc branch of the vfs/vfs.git tree.
Patches in the vfs-7.0.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-7.0.misc

[1/1] dcache: Replace simple_strtoul with kstrtoul in set_dhash_entries
      https://git.kernel.org/vfs/vfs/c/b29a0a37f46b

