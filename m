Return-Path: <linux-fsdevel+bounces-61385-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6728B57BE7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 14:53:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC9F6482E05
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 12:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5607330DEC8;
	Mon, 15 Sep 2025 12:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ES42hSfD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38B830CD98;
	Mon, 15 Sep 2025 12:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757940786; cv=none; b=pxmTk/UMpJoqreKq0e7K60E+SvAQKV1+Gqxpv1+Ri0GHmAaLgJhYdb2ZAgNQWvaoQu3LVVUeZHvbBJRgZnBrb67Abn22dnHmdYcthI/ILzKr5r3XT82QmieoehWhENQXfcEVFvVJ/3SClIswWo79TC9rcYmHnnZQrvVOEvR8YRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757940786; c=relaxed/simple;
	bh=03DhFL7q+iJs+tw1V8FCzhxFTVFAy+z5zOi2iUsMbb0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HBp6LviXgS/t1+nZzLbT1MS3iYtGlCRT/l+xphR0UuUtaRZbYw+ejzft/kkEZ0u8FZz9cGnvCOpc7njkAVjH9szxnfUaQXY6nv8MitGxOewaD84HNc7hTESzalbjMwnf4171hbXlQxcv78amTQ3zg/k/7fCLBZrzQIL9FVPb0LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ES42hSfD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CCB0C4CEF5;
	Mon, 15 Sep 2025 12:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757940786;
	bh=03DhFL7q+iJs+tw1V8FCzhxFTVFAy+z5zOi2iUsMbb0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ES42hSfDVs1XrJgDE2Z5T1p/EnJl72XU31PJtu7V5kjr8H9/YpYvSKWi8snZS4TDY
	 aAujIDy9Y+WpmPdUou92n8w0CG1eY2kFY9DOqyMchuVxqG+TZxpxQA/EK4Acr3evuF
	 q0wlO4Ptd6b7Mo5K+LpxacNXx94JNt1xEyrAiDCgGm/oBdLwO+kP5VBT1gLtxYwa8P
	 vkjTd6V98jGRbxHcdmFv5bjF91WlaEfBoVIwa/2wPuT2IrcltwgjSeP+oqVtGik9Du
	 pvRq1VIh/2BI/NWl9AocPZHiJl7MwwKEWcte91FT+wDYP5VjFPeLRhvLbGCt9V/1s0
	 vh5egvK6HBSiQ==
From: Christian Brauner <brauner@kernel.org>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-hardening@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] initramfs: Replace strcpy() with strscpy() in find_link()
Date: Mon, 15 Sep 2025 14:52:50 +0200
Message-ID: <20250915-hinstellen-golfclub-0f4565b7b561@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250912064724.1485947-1-thorsten.blum@linux.dev>
References: <20250912064724.1485947-1-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=900; i=brauner@kernel.org; h=from:subject:message-id; bh=03DhFL7q+iJs+tw1V8FCzhxFTVFAy+z5zOi2iUsMbb0=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSc4NFZcbGLedIjEWt3T73GsqZT395oCby8Okl56qMNa xY87jM/3VHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjAR4c2MDF3lU6PmXJCwqjLf N/H9snsl574IT2zz/uK/avr7yG6XhNkMf0XWsJrvvuD58l7vpsRimXsTFFn+f/b/nJgZpWHibH6 zgQ8A
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Fri, 12 Sep 2025 08:47:24 +0200, Thorsten Blum wrote:
> strcpy() is deprecated; use strscpy() instead.
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

[1/1] initramfs: Replace strcpy() with strscpy() in find_link()
      https://git.kernel.org/vfs/vfs/c/afd77d2050c3

