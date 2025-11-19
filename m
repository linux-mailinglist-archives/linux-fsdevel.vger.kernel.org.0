Return-Path: <linux-fsdevel+bounces-69078-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 05F83C6DF54
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 11:23:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0EBFD4FA6A5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 10:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFBB5349AF6;
	Wed, 19 Nov 2025 10:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QlBs3+g7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143C8305050;
	Wed, 19 Nov 2025 10:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763547293; cv=none; b=Os8waE5yhjtFd6hU9A/lgEoU+jSEVYh+AL+Jd0Szveu2MYX35glMBlsWCWnOhXVc8U0C4zvNDnwavcY+WeOJ1xVAnpPCFtRsCiFTNjk0NjvLguuqhivll5UbOk2BMPx/7OTAbl0TtkdouFG8xVJY76GuUVT3g7Fmc7qnOrplH0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763547293; c=relaxed/simple;
	bh=WG2RY+Qw3l3daD4GjVofV9d+zCdH3Ii+SDA+xhe7iAo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YPVhDM2xCEgFzUXZh9b+jI9/82l9ZZU9bphVNX5/c9JVHDOOqaalZovL0LSI+45xAGDSSPnZzob4qGPsQB8BjCdJk1ZfWe8pxOfb1uYVmHf9iHw2n1Ix2YAIlq1evpU87VOrlcLZCAMAexVwVHivTpFZgj7okCvezrOmnLetKIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QlBs3+g7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0289C2BC86;
	Wed, 19 Nov 2025 10:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763547291;
	bh=WG2RY+Qw3l3daD4GjVofV9d+zCdH3Ii+SDA+xhe7iAo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QlBs3+g7AdGlIh1ltpn8hDeNqvTXTrEwuB/+883kWBRkLXcpvF4BBSSz8okp2rbCI
	 9EmBICSQosHC6KI34ZdxM3p/fLRi5UpGrc+RsUuwrbEAANn0TfFFwPtqe31KH+Y4ad
	 YwbTsPyyXjJpJpQMnDFPL+oqcA76PYb2Mk73Bt79zH9OH6uyVK+OOrgBnPJnhDNkw2
	 FGqSvKbVJj4uv78XjzqphnPUFarXjTkpjAUPNoyfGLMp5W7FNbuP7muEOsbeTt7+wF
	 l5Wl6BFY3ppp4eR/NfD1NwLq7wjzlH++NT3nif0xC5nlMoy6ftLly+kBOdV66DnJQy
	 WmaIE+IWUzNrw==
From: Christian Brauner <brauner@kernel.org>
To: Ian Kent <raven@themaw.net>
Cc: Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@ZenIV.linux.org.uk>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>,
	autofs mailing list <autofs@vger.kernel.org>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 1/1] autofs: dont trigger mount if it cant succeed
Date: Wed, 19 Nov 2025 11:14:34 +0100
Message-ID: <20251119-neuzeit-glotz-f690ff656d19@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251118024631.10854-2-raven@themaw.net>
References: <20251118024631.10854-2-raven@themaw.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1349; i=brauner@kernel.org; h=from:subject:message-id; bh=WG2RY+Qw3l3daD4GjVofV9d+zCdH3Ii+SDA+xhe7iAo=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTKzph6b3VYQOQ/v0NnYkt/OdhzNt7NOTpz2qfXulG6n 1gOMyyN6ChlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZhIpzwjQ/djwc+3di0RTDt6 80lUB/fMrzY6p5tuCX7TuHFmWqqjEBMjw4pd2Wxh39/xXJh5cKn77a/+DMsNboYmrWF/tiz2uhc zCy8A
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Tue, 18 Nov 2025 10:46:31 +0800, Ian Kent wrote:
> If a mount namespace contains autofs mounts, and they are propagation
> private, and there is no namespace specific automount daemon to handle
> possible automounting then attempted path resolution will loop until
> MAXSYMLINKS is reached before failing causing quite a bit of noise in
> the log.
> 
> Add a check for this in autofs ->d_automount() so that the VFS can
> immediately return an error in this case. Since the mount is propagation
> private an EPERM return seems most appropriate.
> 
> [...]

Applied to the vfs-6.19.autofs branch of the vfs/vfs.git tree.
Patches in the vfs-6.19.autofs branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.19.autofs

[1/1] autofs: dont trigger mount if it cant succeed
      https://git.kernel.org/vfs/vfs/c/922a6f34c175

