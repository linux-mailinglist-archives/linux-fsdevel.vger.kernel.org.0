Return-Path: <linux-fsdevel+bounces-45432-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE4ACA77917
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Apr 2025 12:49:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 138123A8596
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Apr 2025 10:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 042051F0E4D;
	Tue,  1 Apr 2025 10:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IYYoHwoz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6257FDF60;
	Tue,  1 Apr 2025 10:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743504565; cv=none; b=coenBfdHBhw6vqLbN7m2V31Mv1kMDv7/7l21XT0S93mxGT5EinlGoNYgvKJPDRmdAT9RTkUQcEuF/oaaF+stk9YMLgqrW3Ed8FYcZ9fH8vlIhIjaiwRmahcDPakRn6l04y0kVyh7bDS2zrdoeRzC5wWvoyfGCNYnNlOKVOmObcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743504565; c=relaxed/simple;
	bh=idAFVdRv15S2l+Gf9IPpP1vqK50EZTjfBbjPVEty6x4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XJDEBLam+aHXew1kQW3k6v0a+SGHPC1M36giFOdKsEMLb7YhmcTnXsu3XosKAe7J8+T91HfI4Esg+pChXs3TNucJ++S91OITG7BqEm/Z9umXi4LuX8Hva3/FhtF9Lbmt/N36JjUqRV0Erxzq5w7UNpELMzF3pklWiL1+4hPOXwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IYYoHwoz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B65BDC4CEE4;
	Tue,  1 Apr 2025 10:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743504564;
	bh=idAFVdRv15S2l+Gf9IPpP1vqK50EZTjfBbjPVEty6x4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IYYoHwozWzEl/mlr70Bvxb5eDb4SbwCTy3RgMpqDPO/0M/UT1Cw6Ypj4MPuoXebaP
	 +Z58bT45OW6i4gZvHGosqVwykgPxE1Nonc7KwWYv10BeO71qpUw3cb2yOb5VrgUDbr
	 ZHLIjn5uILXNFfLZX2w1Mb0OwMuu74l/tFmtg7pRQJChNQOyQq6nA7Zo9d2OBV3qBT
	 4M7vHovx1BicJ/7687t9G6p/6mgW19puthE63qvH08XG1/XSytxIdrWkmt6z7mQZd9
	 nCPspLNCHjKHROSMlNcYbNdh9+ioiJHOhcnHNFabGcQgStE3OoVk3fHRI6Yo6RmMYT
	 7JyFhqFf8jmmw==
From: Christian Brauner <brauner@kernel.org>
To: linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs: remove stale log entries from fs/namei.c
Date: Tue,  1 Apr 2025 12:49:09 +0200
Message-ID: <20250401-erwehren-zornig-bc18d8f139e6@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250401050847.1071675-1-mjguzik@gmail.com>
References: <20250401050847.1071675-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=990; i=brauner@kernel.org; h=from:subject:message-id; bh=idAFVdRv15S2l+Gf9IPpP1vqK50EZTjfBbjPVEty6x4=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaS/PrJ+jtvmu+v99knKLZfv0V6/s+jBYp89UzWWz12/Q s6jJu2+YUcpC4MYF4OsmCKLQ7tJuNxynorNRpkaMHNYmUCGMHBxCsBEzIQZ/hnMfRk7oZVbi/nK 7CmuuyVLr81xO5QVl5Ywz2lGeqG7QC/DP/2y81UreSclJW9UN4nn+v669MOlDZGuy5YtPzlNyON YGhsA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Tue, 01 Apr 2025 07:08:46 +0200, Mateusz Guzik wrote:
> 

I have zero attachment to these comments so I'm inclined to agree and
remove them. Please anyone who really really thinks we need them speak
up!

---

Applied to the vfs-6.16.misc branch of the vfs/vfs.git tree.
Patches in the vfs-6.16.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.16.misc

[1/1] fs: remove stale log entries from fs/namei.c
      https://git.kernel.org/vfs/vfs/c/3dddecbd2b47

