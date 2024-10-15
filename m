Return-Path: <linux-fsdevel+bounces-31996-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E16999EE80
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2024 15:59:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A18C1C20A59
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2024 13:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCA361AF0C7;
	Tue, 15 Oct 2024 13:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dD99J5HE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E541FC7D1
	for <linux-fsdevel@vger.kernel.org>; Tue, 15 Oct 2024 13:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729000773; cv=none; b=SICPgJD6KFcfCmMoPzK5u+rMskYR+hQ5h3gTw9YT+PRdBcAObg37U/FWxcoZLOCWlt5LW48dx0OXA4pIs5ghAXMXDVLfIJCLFTzksqBgtrXcwEv5MSGt8iJCD8cwxmU0fAh0B+/q7EzeR2K6yV+GWSdAF15z4gzh8mgJdhuN1sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729000773; c=relaxed/simple;
	bh=9xGHMicw48Bm2hrafS8cGqp/5zcB1mgChWuAO2zp4TY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vma626n/LX77/tIlvU2r4pJSjQzSiMbkhnmbAO9jJm41Jn90UC6NU6sRZK18Y4VIY3J26nBhyYL3S1OxSSWv/GaDlGexL+kHjT7CPo6Z4TFn3d0GezR/ne2k2WM/6u1eRVQYVq8kCB0wn7IneQZGG1d6JTx9TpkUcg5o2cNb8vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dD99J5HE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5D55C4CEC6;
	Tue, 15 Oct 2024 13:59:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729000772;
	bh=9xGHMicw48Bm2hrafS8cGqp/5zcB1mgChWuAO2zp4TY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dD99J5HEfk4wDXHqDTboCJ/PQi/xu1ES+cz4FDkQ5VELGcyCy5z710fOmrQG0hxIH
	 LNcpbS7MBnFgL2qeNGcOY0m56hs3Wx5rXkwDpjIhHVH4HdTS6Wic5tLgXNO2r3LE1J
	 eoFmpdb0CTwQB01cQmf+VlzjtUbTnZorqk3bFuEQ17zwppNXVaTLoP8o6de8CGcisJ
	 Kfv4PNzINd7T+ZnEtYygmDVyU8a3EdAKtEXEjfn4rbCl331+CMBv/sO6gAXv/d5oNt
	 Umpf9rvOtiu4QeAxEtaskJkvR19RLchYbbYf3X4NJQh9XdIVLVKc9yy81NLpj2K1HL
	 eXucUlHFGmwow==
From: Christian Brauner <brauner@kernel.org>
To: linux-fsdevel@vger.kernel.org,
	Bill O'Donnell <bodonnel@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>,
	sandeen@redhat.com
Subject: Re: [PATCH] efs: fix the efs new mount api implementation
Date: Tue, 15 Oct 2024 15:59:27 +0200
Message-ID: <20241015-vorabend-tapeziert-53327ea1b391@brauner>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241014190241.4093825-1-bodonnel@redhat.com>
References: <20241014190241.4093825-1-bodonnel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1123; i=brauner@kernel.org; h=from:subject:message-id; bh=9xGHMicw48Bm2hrafS8cGqp/5zcB1mgChWuAO2zp4TY=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTzldqLWim6JCVqbUj12HQ6RPDyolhGR0/nuU0rZRYYB FUZzpjRUcrCIMbFICumyOLQbhIut5ynYrNRpgbMHFYmkCEMXJwCMJH1hYwMR9TlAsOmnyneqSka LThJbG01N9fdu119avzxfCWnS498YPgrV2AYkqSjEhArkNGuM/n+KhPGContiUZiB+5uVw4yFmc AAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Mon, 14 Oct 2024 14:02:41 -0500, Bill O'Donnell wrote:
> Commit 39a6c668e4 (efs: convert efs to use the new mount api)
> did not include anything from v2 and v3 that were also submitted.
> Fix this by bringing in those changes that were proposed in v2 and
> v3.
> 
> Fixes: 39a6c668e4 efs: convert efs to use the new mount api.
> 
> [...]

Applied to the vfs.mount.api branch of the vfs/vfs.git tree.
Patches in the vfs.mount.api branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.mount.api

[1/1] efs: fix the efs new mount api implementation
      https://git.kernel.org/vfs/vfs/c/51ceeb1a8142

