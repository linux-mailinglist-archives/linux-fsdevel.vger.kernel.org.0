Return-Path: <linux-fsdevel+bounces-72053-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B964CDC3A9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Dec 2025 13:37:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4B2EF3013C15
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Dec 2025 12:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B09731A802;
	Wed, 24 Dec 2025 12:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hcff7Lq0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F022BE02D;
	Wed, 24 Dec 2025 12:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766579826; cv=none; b=B6c0hZ+bgZJlqqllo5gDcJKy/7UyvpnnJn3cbucG3KP0KF61CR0HIP9PpCdDRFWzlREE1nHqxNEPC+sqp42C4Ar8XOigMY8JoBFD383BEoti6pc8WDKezdsOPDBkfglS9wbOZgcwMvnWKzwlYWYr54g+QS7Gp1hhG1BK9b2PJf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766579826; c=relaxed/simple;
	bh=7BdLPeoO5l5ol1lZ4eIkKGMr05fZfF3RpACuY3vcuHE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MV14qCA89XuXIVXOaaeQGkwsFV/HjHKFnwSqa+js/6GTFDnivX81lA9aVDjhZG5W506fhDQ/HhnYFpWr9/a8p+eFVlOz452H/gGuVM4yrcEAu5tOmbR3XbXkKLfWcNbbMu47DflpmNbN9d6ufsZeRpnZbgVKojsN3iqvaebae/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hcff7Lq0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8C8AC4CEFB;
	Wed, 24 Dec 2025 12:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766579824;
	bh=7BdLPeoO5l5ol1lZ4eIkKGMr05fZfF3RpACuY3vcuHE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hcff7Lq0kWLcxY5R3jKuSdoZuabquE2td3JhP+vVW5csL3PH3qbju/cijDkSsnEKl
	 RcZiyInsYwRC+ppuFzspgkvKbiaEPTAvrGP8gZdznZL025Q4gMQZLbxOIbSCVjinkO
	 FoqKh1nzs8ewJXuPjARpWU3txWhTKJEa9+5JDAhnsNPz/fG+/rPZ0bC5wse7kgeYTl
	 e6uupqY1mtRP1d/Pfq7ca2NXdFZZdEoARcivtCcBFO2xqlF1xvX0043QIDeSCirRBp
	 UHoHLRnvpTdh6hDmpqa7DmHIh3m99dE5Wau/XTxHmZEKPy+JdGV11l0gvOtRA34kqX
	 8IiYDFBCkmFmA==
From: Christian Brauner <brauner@kernel.org>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] fs: Replace simple_strtoul with kstrtoul in set_ihash_entries
Date: Wed, 24 Dec 2025 13:36:54 +0100
Message-ID: <20251224-klarkommen-herum-94f3576f235f@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251218112144.225301-2-thorsten.blum@linux.dev>
References: <20251218112144.225301-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1182; i=brauner@kernel.org; h=from:subject:message-id; bh=7BdLPeoO5l5ol1lZ4eIkKGMr05fZfF3RpACuY3vcuHE=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWR638sWL3euMKnXFP6zcsXhhvrjzO0z525p8cgqsDl4d 13+26yKjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIn0XGNkmPnRgHvbvL+5GsIH o33EFTQS390q3H1r7oxQr/1v2S4ynGJk+Nvd4319TtREy577ja+qHEQ/T+Znez+XQUP0fo7BZe7 1/AA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Thu, 18 Dec 2025 12:21:45 +0100, Thorsten Blum wrote:
> Replace simple_strtoul() with the recommended kstrtoul() for parsing the
> 'ihash_entries=' boot parameter.
> 
> Check the return value of kstrtoul() and reject invalid values. This
> adds error handling while preserving behavior for existing valid values,
> and removes use of the deprecated simple_strtoul() helper.
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

[1/1] fs: Replace simple_strtoul with kstrtoul in set_ihash_entries
      https://git.kernel.org/vfs/vfs/c/63ad216fbfe2

