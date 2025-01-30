Return-Path: <linux-fsdevel+bounces-40396-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E0D0A230C5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2025 16:05:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87CF51888E70
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2025 15:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DE8C1E9B23;
	Thu, 30 Jan 2025 15:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mT5YyaRH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B771513FEE;
	Thu, 30 Jan 2025 15:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738249525; cv=none; b=Yww+uuL7R0EkvZwwymB5io4Uc9G58bjtnwjuA+Ec8+kJrRAHGnlu1YXJIIMyrUScI3zZ8njbXnd+9TT8tN1OliwmNqAvuUoj788knNnxdQbfJTENQyb2aSl3BYpzqeUm/4258/knDfhjYLwGmSrqBSeh7Rfy4Nuq94+SdIt9haw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738249525; c=relaxed/simple;
	bh=W6TKfvND7EqWTCe8ancliVKFScotTosqQ5uAmvm2iy4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YoPvuHUbErCYf0MugbjDd/uQ71LsOOvMJCOhVmjLXVUcBAQfPaq2rWjt9RCBe7/u/PkZV+J5e3OgvStA6sX6lCtlFAc+QObvI4Kk8Uqekkoue9oj4r6z0s7uJ41Mq9nDWFArxe/9pesb78owyd1FO122MH49c7t9Ob6Uzt1Vggs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mT5YyaRH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5456AC4CED2;
	Thu, 30 Jan 2025 15:05:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738249525;
	bh=W6TKfvND7EqWTCe8ancliVKFScotTosqQ5uAmvm2iy4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mT5YyaRHIcU9nsvJsfCMPsuynIjPN1WFyUDPIUMBtmSv6YfwDQs6vKzYXWD84OVnP
	 EYqyDjilZydCt3O5YDyES0NskENt1BiL1gvUb3JJDD+RdDAcPlXWFThleieQXxQyzm
	 QorJ4Wmve58eGF49SnoFthHu1OpeMn92rYbG6Pq0BBq2iVtQNbUQwgg+KnD/T/b4G3
	 ydaaQGKas34UBxGaRpEMq9xaaEnfeTTwd11vrbFuG2l8Rb9Qypl531wqiVTCE1TDct
	 zlbbPExlpBrhmx6cO6nRV/GVHEdeSVJkR+7XdfipJvjTh6/v3XE06lTwfqx3K7jnur
	 mWzbTKkjW0h0Q==
From: Christian Brauner <brauner@kernel.org>
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	gfs2@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] further lockref cleanups
Date: Thu, 30 Jan 2025 16:05:18 +0100
Message-ID: <20250130-breitengrad-bergregion-ab2caff08b56@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250130135624.1899988-1-agruenba@redhat.com>
References: <20250130135624.1899988-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1197; i=brauner@kernel.org; h=from:subject:message-id; bh=W6TKfvND7EqWTCe8ancliVKFScotTosqQ5uAmvm2iy4=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTPnqr/8XSLwo/gR3tElzE9zlbb/HXPUhvV1zecT2/WP Jkp79m7uKOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAiIfYM/72885RncP0UblN/ Isyc+Vm042zJ7ao7t6bOlt6Xyyg9TZCR4dzVz7lfGb44O6c+Xh2k5ZOaLXLxZsXs/ZrmM4zeL26 axQUA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Thu, 30 Jan 2025 14:56:20 +0100, Andreas Gruenbacher wrote:
> Here's an updated version with:
> 
> * An additional comment saying that lockref_init() initializes
>   count to 1.
> 
> * Reviewed-by tags from Christoph.
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

[1/3] gfs2: use lockref_init for gl_lockref
      https://git.kernel.org/vfs/vfs/c/6c789b8e0913
[2/3] gfs2: switch to lockref_init(..., 1)
      https://git.kernel.org/vfs/vfs/c/69469b7ad4a4
[3/3] lockref: remove count argument of lockref_init
      https://git.kernel.org/vfs/vfs/c/24239add174c

