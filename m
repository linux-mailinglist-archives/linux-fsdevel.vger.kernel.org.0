Return-Path: <linux-fsdevel+bounces-63470-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57515BBDCFB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 06 Oct 2025 12:56:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A6763B387F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Oct 2025 10:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B96D5261B71;
	Mon,  6 Oct 2025 10:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HrdX/ZK0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BD18247DE1;
	Mon,  6 Oct 2025 10:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759748197; cv=none; b=faL/b6ikUDIKx229dlK9TLSnVGaU9jMYwDOnzjloFxIj5Ht7hMgPU4OB7JI54Z+nWbUVmfLtUMeX8MuE0ilGdVMsQs0dv99afuzdG+r1zNKWb8lI2cRDW2lVfidoPJ75ZYuoh03/CgyEvt23TmuObsVydw8aO2S1t6ztHkGbb+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759748197; c=relaxed/simple;
	bh=UAythQDaYi2XxgVjAL308Lv+v+AkGlInraSgKbq0OrQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qnHlnzRWKYWiKgNE8hnEu0L/VdcUgf5ROQxjQ7rEHie1Rni38SP5inV7KilG3TUPeuY3R5034OBoHuE8J0nw/6KnSo50F5QIf4VNg6rbjNu6kgjNDsniDu59plrkel5SX/y4GKf+B/4+/N+JAb1ctDgbKbou8nGFJPtq/cx9Szw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HrdX/ZK0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D78C2C4CEF5;
	Mon,  6 Oct 2025 10:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759748196;
	bh=UAythQDaYi2XxgVjAL308Lv+v+AkGlInraSgKbq0OrQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HrdX/ZK0YPUePeTD7KR3YeVMhi7OGKDi55b/GODf7zBrXWMr/yWv81nNi10qVB6V+
	 DCnNvBwgKwregzjBuLkrEH5ApiZQ0ydT0TXoKQNBfzxdipA6veax0UgXPuOa37FIRZ
	 gLRoyudwZy2VKiv6+q1GOGHMQ473pKzihVo1I0LmI4U8fpwwhWd8FXlUqIwh41A2OY
	 oRqlC3CUb5y9PJbgfAJ72oVYMekHxHOh/FO7E6edCBq9w5TVN9n42SrvE2n/fsheTo
	 qsb+JHGJJXuFKFLClGvKTLUC2Bf8mT2WkIs7v7JHmAteJZLeAY0HqGIdsNCci6mee1
	 +21k+9hxeBpoA==
From: Christian Brauner <brauner@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: assert ->i_lock held in __iget()
Date: Mon,  6 Oct 2025 12:56:30 +0200
Message-ID: <20251006-viermal-sorgsam-9c931bef2f1a@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250930235314.88372-1-mjguzik@gmail.com>
References: <20250930235314.88372-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=874; i=brauner@kernel.org; h=from:subject:message-id; bh=UAythQDaYi2XxgVjAL308Lv+v+AkGlInraSgKbq0OrQ=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQ8XhDHv2vVo59TOO2fvpY6Jb0k7cznKKXARxJPCvlnP eF36w491FHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRulyG/wUvkitfSShLRh0V KHS24WrmDXsaFjhDcOVmo0mhzW//BjL8s1//XSaJb23NXTf57e2/rE8emPgx4F+x9csFLbes5so F8QEA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Wed, 01 Oct 2025 01:53:14 +0200, Mateusz Guzik wrote:
> Also remove the now redundant comment.
> 
> 

Applied to the vfs-6.19.inode branch of the vfs/vfs.git tree.
Patches in the vfs-6.19.inode branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.19.inode

[1/1] fs: assert ->i_lock held in __iget()
      https://git.kernel.org/vfs/vfs/c/0cb93842ce06

