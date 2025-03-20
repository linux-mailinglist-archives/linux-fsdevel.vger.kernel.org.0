Return-Path: <linux-fsdevel+bounces-44523-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 41F38A6A1B6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 09:47:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B40CD175F3E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 08:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC9EA214A71;
	Thu, 20 Mar 2025 08:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O16ZdTXp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F3B130A73;
	Thu, 20 Mar 2025 08:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742460441; cv=none; b=r5BAehfF2qd/mjyHhNh7zb0+TeZsVTCowWJLKosM1+dtREd5Kgc9EadEEEmlH4pFANxK8IFiOsqpAIQ4zZJ6DPSDkg77anbOCRpAEKJ98IfwVFO6+gf6ghPW1zTXdslCwZTc4p3zFpTng949+EpslANCF4QSbEAztbm1m3kU+Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742460441; c=relaxed/simple;
	bh=BQgKg/UHXUX63rCe50g4jbACRENoJAwo9SzEhm2tF/k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RdCHfQkkT9gEKaLdTHNuxhS91TecVLu3HzYW3dAxSAn3PzuhJ2cxjyIp2VoIzh+Z73Ocd9nGBGN3XouUJRrRDPkBiAVxlUbMepeJA+sS+vLgxSzXMJz5GnBNv5J5HdM0DLW2fdMSHz0dI90lHd8nb3FPLCqbsVWHaLCfm5fFxtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O16ZdTXp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FB2FC4CEDD;
	Thu, 20 Mar 2025 08:47:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742460440;
	bh=BQgKg/UHXUX63rCe50g4jbACRENoJAwo9SzEhm2tF/k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O16ZdTXps2Nw+QREbbStFhrmYYr0Md8tWOlq7+f43aebVd9DzVPsf4TabMSrdVPsX
	 nTVpMAwjSsJXJEOHsnMI32sDM2TlyyO8qtRwjHcbkJ5Wg6PJWW1OOsAzJ+PZrkHn9H
	 OMcJYKuE24hPVYaxHworUYfjWUovC5ioyF0y04CJ3gJ/qDfVzEo0h8+qeY6j9Pnybv
	 2NbmJeZDk/eHA9OyJ10R5SY9wY4rqZvPgzvAbfoqrJxDRKAuGIIn1lzzPsGbyMKjq7
	 xdX0PGNVdE9RMR2Mj2gYA1cfcr+yx+Px3A4dEoDgyNIr6dYLmwpymm46O48OO6Mzaj
	 XgUrKz+OKBvdw==
From: Christian Brauner <brauner@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2] fs: reduce work in fdget_pos()
Date: Thu, 20 Mar 2025 09:47:11 +0100
Message-ID: <20250320-mehrfach-erneuerbar-5ed797872973@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250319215801.1870660-1-mjguzik@gmail.com>
References: <20250319215801.1870660-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1208; i=brauner@kernel.org; h=from:subject:message-id; bh=BQgKg/UHXUX63rCe50g4jbACRENoJAwo9SzEhm2tF/k=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTfviZYvvYRt070mufGHgciHJQmvn246E+Rh0wx26pSa Ql9jmr3jlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIlsu8bwT2u+UEhQeH1K3vZp s+PlV0h3zU8K1fR9+f0OT7SRmoPsZUaGo4y3u/04VzHO6AjXnJAw8yzz6/zPjtut0o5PfqnH/V2 PEwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Wed, 19 Mar 2025 22:58:01 +0100, Mateusz Guzik wrote:
> 1. predict the file was found
> 2. explicitly compare the ref to "one", ignoring the dead zone
> 
> The latter arguably improves the behavior to begin with. Suppose the
> count turned bad -- the previously used ref routine is going to check
> for it and return 0, indicating the count does not necessitate taking
> ->f_pos_lock. But there very well may be several users.
> 
> [...]

Applied to the vfs-6.15.file branch of the vfs/vfs.git tree.
Patches in the vfs-6.15.file branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.15.file

[1/1] fs: reduce work in fdget_pos()
      https://git.kernel.org/vfs/vfs/c/5370b43e4bcf

