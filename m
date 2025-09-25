Return-Path: <linux-fsdevel+bounces-62692-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB0C2B9DD67
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Sep 2025 09:20:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6870E19C2D5C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Sep 2025 07:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AB032E7165;
	Thu, 25 Sep 2025 07:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mu1vhX3g"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B5D42A82;
	Thu, 25 Sep 2025 07:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758784808; cv=none; b=UQ+Ajv2lZuNlL+ibSzePUnLwL/QsCjS3RQgLxFBg6+a3s8ih1gdhuOsv8o7GiFdAnJtXI8AxG1soy587bURV9bj+tuYDYgkg56lycsJ3H9MP3aAiWL4ZnssdqADd5cnGoDkL/8d8+EyQ9dDkF+3pAuNa0qrcKMjSLSnHQuDubbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758784808; c=relaxed/simple;
	bh=AjOYm3nQqNOvzkyREoHdzm/xeXnFCrDwZLxVuo59XeM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iCk0a9zoB9aR9TKYFhTe1aKDQM4sUv4G6V+aMYOpLwYkRjsWi9cAN8PmJFFcJQPoFuSrZ/jEP8KaL7OoL8EO71Hbsq94Mn/55/ppwKr7BwW85BGZVHzyEf/mEY00eLFp+mfJdwgd71piYZVBmHKZMJ50CgD3VHzDjW5roG79qSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mu1vhX3g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B57B0C4CEF0;
	Thu, 25 Sep 2025 07:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758784808;
	bh=AjOYm3nQqNOvzkyREoHdzm/xeXnFCrDwZLxVuo59XeM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Mu1vhX3gCIrviONaLNPo7wOEhFxExR7GDfjiR24FeWCeCd/WClLbk0DFopSHYmZBb
	 yY6RIhyXbr225u/SEK46MQK4L8EtWrDQkNnOeLH4pJOx89pTYqtPtnOL0qVlQaCOMv
	 bKeGpbMbUq9VjohTzNrNIi6RzKd9I80X1xyY1X/VmfzLwHgrIclNVuA2SdDniO8Y8/
	 jXbURdVcPujFsT5hTZnzq8atMGjxX9bV1zYW8Znfw17kB7qpZRJAMgnXZZpJ2tn0FX
	 8eHJ7JULJUiQKca9wCIP63OrBbMLzV3Q8BP+fGf86y5SZ1DD0NuJ4+2jViszf5Wd7V
	 6kW/4Ns5ac8Cw==
From: Christian Brauner <brauner@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Marc Dionne <marc.dionne@auristor.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	linux-afs@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] afs: Add support for RENAME_NOREPLACE and RENAME_EXCHANGE
Date: Thu, 25 Sep 2025 09:19:40 +0200
Message-ID: <20250925-zudem-pause-b4275afb1926@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <740476.1758718189@warthog.procyon.org.uk>
References: <740476.1758718189@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1178; i=brauner@kernel.org; h=from:subject:message-id; bh=AjOYm3nQqNOvzkyREoHdzm/xeXnFCrDwZLxVuo59XeM=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRceask82RJyS8/8SDvqgd3+STZv2nkrdn2gvvSJdND/ 3RYL6z17ihlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjImYcM/508N/b9+xyjXKi0 V3U631P5axzLpPIuxT8Q+Pvh35W22faMDN0/zl+8Juny2ONZoteulfvzVt787lomx/J88SzTuAl 5kzkA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Wed, 24 Sep 2025 13:49:49 +0100, David Howells wrote:
> Add support for RENAME_NOREPLACE and RENAME_EXCHANGE, if the server
> supports them.
> 
> The default is translated to YFS.Rename_Replace, falling back to
> YFS.Rename; RENAME_NOREPLACE is translated to YFS.Rename_NoReplace and
> RENAME_EXCHANGE to YFS.Rename_Exchange, both of which fall back to
> reporting EINVAL.
> 
> [...]

Applied to the vfs-6.18.afs branch of the vfs/vfs.git tree.
Patches in the vfs-6.18.afs branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.18.afs

[1/1] afs: Add support for RENAME_NOREPLACE and RENAME_EXCHANGE
      https://git.kernel.org/vfs/vfs/c/a19239ba1452

