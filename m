Return-Path: <linux-fsdevel+bounces-61359-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 32D3CB57A46
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 14:19:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDB541677D0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 12:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72B8A304BD3;
	Mon, 15 Sep 2025 12:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="On55TMfC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E2024A044;
	Mon, 15 Sep 2025 12:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757938751; cv=none; b=H2ZiIllfmGdo1/cc6kVwUGTBZaCpt0yhVmpyPajxWGKVTAJJ6LDcvxLDBo3aOzgtti7ubhNFR9LfCDyXAAeHN+sLnS6V2aISNaPOkY7t+6a5bOHMBkZlYmy+CYNWi3QnvSBgOQtP6WfIBRpLqC+qieaQIWCOIZIn6Nt2KzkDwpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757938751; c=relaxed/simple;
	bh=Mp0zU8WbYQ7r07HLeddx7mG0Lyzxx6ZI8Wz6NpkA01A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Io8DXsofxGf5UGNJVkYuENzbddQQzLNU0ZhGM5n9Z/e12ZBsNBO50sUmG6grm4BC5VTqNWQVl0EYggW/Li3pLsWXPEBpO1YIvfUasD+Fc7s4YQPUGqZ5SxpNAXQgxyuaGRn2xxcTlJRxlx1tjblngrDBsfMbjd0B/G//nibbKN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=On55TMfC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB051C4CEF1;
	Mon, 15 Sep 2025 12:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757938751;
	bh=Mp0zU8WbYQ7r07HLeddx7mG0Lyzxx6ZI8Wz6NpkA01A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=On55TMfCI2DD5nSQddzQKftNnxm6C+HkZeHiP1WAYjVNBz6I0QRi7J0uYdlpPdufM
	 sqEDk85/C4r6B3e6iCc9gKOubpIlKF3AKa5Fro3YI2IwZNWj29VHxdWU0hyWqQHwsx
	 vGqtli1Mb3fiAuB7sw6k545UD+BDk5zdnYvRe8ggPuVVrSgvIV5InBGp7IfEsB57O0
	 Xo7bIHMYBVgOP8eOk054S7hjydJocyMBE4fvb17T2mKX5bzdRbwB2IOKrfbmsEwv7O
	 bb0CkRtKOInOR9Y10FyRS2KZk67QJCaYpKGmw5AsCmnrn+4YvkzLovvGhHKAzWkGAX
	 0zEaBn6t4QJTw==
From: Christian Brauner <brauner@kernel.org>
To: Max Kellermann <max.kellermann@ionos.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Mateusz Guzik <mjguzik@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs/proc/namespaces: make ns_entries const
Date: Mon, 15 Sep 2025 14:18:44 +0200
Message-ID: <20250915-infrage-heimisch-ffdb2870c6ac@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250909075509.810329-1-max.kellermann@ionos.com>
References: <20250909075509.810329-1-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1118; i=brauner@kernel.org; h=from:subject:message-id; bh=Mp0zU8WbYQ7r07HLeddx7mG0Lyzxx6ZI8Wz6NpkA01A=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWScYLEUf3eZy71fbO1qhvlzj7JKzl+/beX+iTs7H10I7 6mX1jkv3lHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRiV8Z/pfHpHyMP7h2o3KN 9JLjtV+n5ulO7FWfu7FHput1uNe74o2MDOc/8x8JjE6LYTtXyn7nxcc/f9J+Cs6XXTVF2veETAb bOX4A
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Tue, 09 Sep 2025 09:55:06 +0200, Max Kellermann wrote:
> Global variables that are never modified should be "const" so so that
> they live in the .rodata section instead of the .data section of the
> kernel, gaining the protection of the kernel's strict memory
> permissions as described in Documentation/security/self-protection.rst
> 
> 

Applied to the vfs-6.18.misc branch of the vfs/vfs.git tree.
Patches in the vfs-6.18.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.18.misc

[1/1] fs/proc/namespaces: make ns_entries const
      https://git.kernel.org/vfs/vfs/c/91beadc05329

