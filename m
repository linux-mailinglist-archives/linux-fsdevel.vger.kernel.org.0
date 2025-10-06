Return-Path: <linux-fsdevel+bounces-63471-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30AEFBBDD2D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 06 Oct 2025 13:01:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 991A63B6462
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Oct 2025 11:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB17E268C55;
	Mon,  6 Oct 2025 11:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tZLeMuzp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB9E212569;
	Mon,  6 Oct 2025 11:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759748500; cv=none; b=VbxDTkZghqv+APuv/Io5AYLK1eeX13WiFkmwJ7zXIKCr7qjvGkZ0c1xBhuJPplAA05pjfDodhfLP/GnT2dbdYCC+E8WyFREd4ogyXLgK8F0FjrtzdlOIUPPFk7ItXwdjX9mMaNvO0Ju+URgXBSX6vDpeQB0ePqEIMPu2u05DY74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759748500; c=relaxed/simple;
	bh=eycDTVfwVxk6grbRt+XeCahztVPOUI91eRKprLsAxls=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CG2uyR5mA/shnhbLJa5anBgGoAWkBDANYuaJo5IAEWAlSrS+GzKBKOeV/9nSzciPlzsldDwTKjgIKYKpl6vhI30ea114bUZmDnr1N6lsJbUZAInmpaQVof2i4fCUR9qMv6Kjo+ctLXqVdEuN75H4DO/w5/t7NnjXcZpya1DlnYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tZLeMuzp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF414C4CEF7;
	Mon,  6 Oct 2025 11:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759748499;
	bh=eycDTVfwVxk6grbRt+XeCahztVPOUI91eRKprLsAxls=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tZLeMuzpLiqjBBU+3IfvpSv8VnWtLtOKEvk4b7jFKxEcfwVRnC8JkFDdByqTrVAJ8
	 b6372Zu908TWTk5DMKxTwSfem4V2A438rqUq2Ts0HjwsNbww6FtuycIqt2QaziJskd
	 K4heISUpTH9nTY8JDIGDSMqe3FJVysP2Cld/IUN3HY52UuQY2bun5gzjt1SzcjSker
	 wrMkO99ko4X8/wuEuoHCOH3sW34H7IvSM7Wk1wJ6LTYvmUG4R9ZTX2oN7RSnkalm7y
	 r8gGdF0YaFQUgatm4wv3s4SmfCNa50ixD1bq+0zN0HrIjmY/5yhJWTtckDu7/yx3lw
	 0RxgflVcXbqVA==
From: Christian Brauner <brauner@kernel.org>
To: linux-fsdevel@vger.kernel.org,
	nvdimm@lists.linux.dev,
	Yuezhang Mo <Yuezhang.Mo@sony.com>
Cc: Christian Brauner <brauner@kernel.org>,
	dan.j.williams@intel.com,
	hch@lst.de,
	Friendy Su <friendy.su@sony.com>,
	Daniel Palmer <daniel.palmer@sony.com>
Subject: Re: [PATCH v1] dax: skip read lock assertion for read-only filesystems
Date: Mon,  6 Oct 2025 13:01:33 +0200
Message-ID: <20251006-kalziumreich-backt-0bf810100070@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250930054256.2461984-2-Yuezhang.Mo@sony.com>
References: <20250930054256.2461984-2-Yuezhang.Mo@sony.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1317; i=brauner@kernel.org; h=from:subject:message-id; bh=eycDTVfwVxk6grbRt+XeCahztVPOUI91eRKprLsAxls=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQ8Xti363/eS7dzMrOnzlw/vflG2KMXQcm/FStWhEbwW 2WdXH0psKOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAiPoKMDPf27mYtUG3uY+Xa FvuiP8O0wlA9Z95G3pTjMZ8r57xdv5yRYYPsG/nM9tsZl16GL1nXEbd8dd+8f+G8gpMm5dzwYt6 gzgEA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Tue, 30 Sep 2025 13:42:57 +0800, Yuezhang Mo wrote:
> The commit 168316db3583("dax: assert that i_rwsem is held
> exclusive for writes") added lock assertions to ensure proper
> locking in DAX operations. However, these assertions trigger
> false-positive lockdep warnings since read lock is unnecessary
> on read-only filesystems(e.g., erofs).
> 
> This patch skips the read lock assertion for read-only filesystems,
> eliminating the spurious warnings while maintaining the integrity
> checks for writable filesystems.
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

[1/1] dax: skip read lock assertion for read-only filesystems
      https://git.kernel.org/vfs/vfs/c/81dd0be374ca

