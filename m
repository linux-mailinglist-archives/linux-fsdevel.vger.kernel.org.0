Return-Path: <linux-fsdevel+bounces-72060-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 669D0CDC4B7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Dec 2025 14:00:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 50046300E443
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Dec 2025 13:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 266EE3168EF;
	Wed, 24 Dec 2025 13:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cNsPU40X"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 813F030276A;
	Wed, 24 Dec 2025 13:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766581203; cv=none; b=Iu3UEKTkz6DKK2tRkJprk7KmgU/8DtJG/qyo/6PbRfQICCLNdThj6ajpzv2Knu8ibTHCv9xyIqlacgJbQuagC2sO7mnDRld9nk4IBIEiePq9ehc2BGfobFsfavrXXQIApUvkuNyp5e7FgbwTNGzFlwwGWTbOWV1amHC13T34brg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766581203; c=relaxed/simple;
	bh=LJkOaYDqSg6V9Mo2360wq7JEiGTtKBliRjR4JWgcFxk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nJYRIM4QfQEJSDiBiDioSdbDjzmjnN3q/ttp8m75UrBb+fsW4kJOeKaeSHQ25Cfz8XO8D/+Qjs4D21lqZKETtjR4tak0P3a5hlIui4IPeQg3Q6MUZ6b7Lbejf8jv1ZXpgN3DQTPAYy16LrXqGBp8xKSOcPe7tpAjPtA+/O2jpHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cNsPU40X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ADB0C4CEFB;
	Wed, 24 Dec 2025 13:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766581203;
	bh=LJkOaYDqSg6V9Mo2360wq7JEiGTtKBliRjR4JWgcFxk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cNsPU40XAphgi+eBuEm4bTS3GEmC8wRZKrn1P8uhxlZq2ZD5DMiu6+S2F/JmkCb+K
	 T7YvVZM5I5bLoFWL8iUsiMCD+aYFJ5oNH5LU+qxQlLHWYcH/XVhjMuHwHNjAgmiB+0
	 BwAADryqFcazX8DeVAeiQajFPq5uLpJE/UYLeR4pc8ZyJW/pkjmAJ+EWNV9poSgQL5
	 JMaGc2lHAPdobspMjk0QurxQtQ7Zm0mUlZXGSEkYGiPQAw/ozn73aMw4T2QSNnViXC
	 GeU91UeuMGwJUQepkoO7+SimjZGKPkYwFlh4gcXW2m3E1Qulnc2KXLQn3CbcfqMvHA
	 1iUK0ZiV4fQFA==
From: Christian Brauner <brauner@kernel.org>
To: Matteo Croce <technoboy85@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] fs: fix overflow check in rw_verify_area()
Date: Wed, 24 Dec 2025 13:59:51 +0100
Message-ID: <20251224-hinspiel-filzstift-d659293ee101@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251219125250.65245-1-teknoraver@meta.com>
References: <20251219125250.65245-1-teknoraver@meta.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1182; i=brauner@kernel.org; h=from:subject:message-id; bh=LJkOaYDqSg6V9Mo2360wq7JEiGTtKBliRjR4JWgcFxk=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWR6Pz5n/kra0WXSrkcfddep3Dl0Ys6KvdGMvuHWPkH3J 0xqf7PEoaOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAizccYGRa0/pmx8OlXrxsa 3/R4hMqyBVquPJ+rLjtljczXY58Nqh4z/C95tkLXeZPYSbFFqzeLTsouu7nOt57Z5/8Njd7TDKd v13ABAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Fri, 19 Dec 2025 13:52:50 +0100, Matteo Croce wrote:
> The overflow check in rw_verify_area() can itself overflow when
> pos + count > LLONG_MAX, causing the sum to wrap to a negative value
> and incorrectly return -EINVAL.
> 
> This can be reproduced easily by creating a 20 MB file and reading it
> via splice() and a size of 0x7FFFFFFFFF000000. The syscall fails
> when the file pos reaches 16 MB.
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

[1/1] fs: fix overflow check in rw_verify_area()
      https://git.kernel.org/vfs/vfs/c/d77e4d49e5f0

