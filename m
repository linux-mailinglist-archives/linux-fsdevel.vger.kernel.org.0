Return-Path: <linux-fsdevel+bounces-45607-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 56197A79DCC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 10:16:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17B78174791
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 08:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD7962417D6;
	Thu,  3 Apr 2025 08:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dcUBWP23"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44782A933;
	Thu,  3 Apr 2025 08:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743668166; cv=none; b=gii8N0ed5fqPWh21dwxOVW7Emh0l5xtEx0wmehi+CHdeQsE8I66gEi1e6KPNgiNk+K+Gh0QUvNRZdDRgnOIPVP4wB5t0YYiHVj1bpbYmN2sT7ZeDD6yuzClKJS70CqZfEwUTcAGgAo5hmLMeJyDjAJgeeXFFubN64U+Jb5o1Q9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743668166; c=relaxed/simple;
	bh=Equ+n0o7mz4ZUtWr8X1gY23v8eqEfCjzqlow5EbiF2E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uj/rOpccO4d7r7vuUlIOsqd6rGbpfpBBCx79gKWM8Owv4lVLYkenRTxxtAIgmpPGs2giisYWdt2SOuivtc+PV0u1VgKGqb3rYvtXJhq+uA/GgscWRcwN7+mC8IJoZVBRBpbLIpIPiYAF6P8IcA2hbEP3ZCB1pouQIxoeEC4YMxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dcUBWP23; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1B4CC4CEE8;
	Thu,  3 Apr 2025 08:16:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743668165;
	bh=Equ+n0o7mz4ZUtWr8X1gY23v8eqEfCjzqlow5EbiF2E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dcUBWP23dWFLMOPTsRHSi06WoW4JMhgpg0IbLA9LUnTnjrON98dH6jegUFITulAVt
	 ZyOpL2KmcoXXdu+Ylyk4zxmES2FVsLZ+TmNQQmxX0G5dnvh1DBNaqvaqIC+Wqx8KYT
	 HZE5U1p23n6x8ZCWMTXzfvuVaHK/7fFndc3hp6KrngeJ1DikjozIFdDNimaW/1JXfP
	 5lAPtRGW5bks7kTd7YNco0SLb3ULcKWyh6mrrY6YdG1mDBmO4YR3oOwtOxs0yZ3XHV
	 J9mLv0g7qGF7fN2ssVz2UC+SdeHrVV82Hf/l9CKug1UHdU7EZF2mQ0Yhp2SbCcQUGs
	 ki0zNA33RoThQ==
From: Christian Brauner <brauner@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Giuseppe Scrivano <gscrivan@redhat.com>,
	Debarshi Ray <dray@redhat.com>,
	Eric Sandeen <sandeen@redhat.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] devpts: Fix type for uid and gid params
Date: Thu,  3 Apr 2025 10:15:54 +0200
Message-ID: <20250403-voneinander-doktor-3d1f475cb8ae@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <759134.1743596274@warthog.procyon.org.uk>
References: <759134.1743596274@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=959; i=brauner@kernel.org; h=from:subject:message-id; bh=Equ+n0o7mz4ZUtWr8X1gY23v8eqEfCjzqlow5EbiF2E=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaS/c943/a2vumz1m+qvO6Ovfzz54WNYn2/QFoFN0atdl Xa23WbJ7yhlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjIRX2Gf5oqIUkvVXfdqlhz V2yyxwSlmgPZ57+ZzXZr7bihmv9GI5aR4cCWZTsuhJ4PWbS7wzp4ct3sG3sM8rvcM8OucH7hCs7 PZwcA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Wed, 02 Apr 2025 13:17:54 +0100, David Howells wrote:
> 
> Fix devpts to parse uid and gid params using the correct type so that they
> get interpreted in the context of the user namespace.
> 
> 

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

[1/1] devpts: Fix type for uid and gid params
      https://git.kernel.org/vfs/vfs/c/b478f56b7866

