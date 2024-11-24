Return-Path: <linux-fsdevel+bounces-35682-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E898E9D72CB
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Nov 2024 15:19:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADE8C2870CF
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Nov 2024 14:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB2D520898A;
	Sun, 24 Nov 2024 13:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UQ8KkMn3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05856208978;
	Sun, 24 Nov 2024 13:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732455871; cv=none; b=HkeIM9SX0cXXjdgLC113WnaKwT6BQySFRfLK/KGPMuaN9J4zB30eJOI7PeeIGuknW3WM2J6i5MqGL9755mh9KNdkck6Df0yNcB81vlHwYunika3jQahmVsmiCwiZwBzerJuTPnGKXx6uIZ1Ia/wPg/AMg+ispcQU8/rnh4sSaDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732455871; c=relaxed/simple;
	bh=UUdOyTarqKECdM6Rypy0inbWwzf+pM4wFf89gzXG8RQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GFZZyRwTTX+xGE4tjXjn9ND/v0HnoGYDnVR4N2oN64EBsRv6cicMM8GVsGK3hTu/WaKBGYIUDaou8lgeT5iKl2Jl+BNpXMmGdEyKqeIW06Jd29cFHOz44Gc0nKL4mCszq0BvY0jTwDcVPUQeABFXvrig9XrQzvinVONXjFL4JrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UQ8KkMn3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA843C4CED3;
	Sun, 24 Nov 2024 13:44:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732455870;
	bh=UUdOyTarqKECdM6Rypy0inbWwzf+pM4wFf89gzXG8RQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UQ8KkMn33IsQgvYN6dnMcwj/tJCyubObq0f9Gt3w7cd+mXiw39GRq8vZBOY4IRAY9
	 aOUubBDRWuJ7rC0SGie7kNppD6QznREwI3N1FcxzzWi5j1sLLT/2mmpWqZ16IY+QKG
	 WsdCFw545wkH8IoJEpPcJhxMO20gyjNVkkSV4lAi7oXu1g9BatO8s3KcUFJOY/fVT3
	 fAnMykyxB3EdbO6WrBClLQQM06obKEbZRLNB+6Wp50SpqCOVujj6UhHhHoS7faj97m
	 BiPc8XAwhxzld/h7dOXkZBzrtI6NfMVs+ZSsrJDoREmWmyHX6XHdiPgB/3nnlSjzeL
	 y0YkIn5/942NA==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Miklos Szeredi <miklos@szeredi.hu>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 07/26] firmware: avoid pointless reference count bump
Date: Sun, 24 Nov 2024 14:43:53 +0100
Message-ID: <20241124-work-cred-v1-7-f352241c3970@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241124-work-cred-v1-0-f352241c3970@kernel.org>
References: <20241124-work-cred-v1-0-f352241c3970@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.15-dev-355e8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1050; i=brauner@kernel.org; h=from:subject:message-id; bh=UUdOyTarqKECdM6Rypy0inbWwzf+pM4wFf89gzXG8RQ=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQ7685iinO9UnDfL+9KYvo5z6fXPj0xLtrFEOdQtkRB0 +PoIgPvjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIlYKDAyPFlhMHFz0kGuA++T Xr1VTs3K+ODQ9e3Lmj5jbuXzh0t5dzD8FTW6wvhc82jhzM7T8hnST/ZUxpZ9eOraYsbfWOhasvE UNwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

The creds are allocated via prepare_kernel_cred() which has already
taken a reference.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 drivers/base/firmware_loader/main.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/base/firmware_loader/main.c b/drivers/base/firmware_loader/main.c
index 96a2c3011ca82148b4ba547764a1f92e252dbf5f..740ef6223a62ca37e776d1558f840f09c7c46c95 100644
--- a/drivers/base/firmware_loader/main.c
+++ b/drivers/base/firmware_loader/main.c
@@ -912,7 +912,7 @@ _request_firmware(const struct firmware **firmware_p, const char *name,
 		ret = -ENOMEM;
 		goto out;
 	}
-	old_cred = override_creds(get_new_cred(kern_cred));
+	old_cred = override_creds(kern_cred);
 
 	ret = fw_get_filesystem_firmware(device, fw->priv, "", NULL);
 
@@ -945,7 +945,6 @@ _request_firmware(const struct firmware **firmware_p, const char *name,
 		ret = assign_fw(fw, device);
 
 	put_cred(revert_creds(old_cred));
-	put_cred(kern_cred);
 
 out:
 	if (ret < 0) {

-- 
2.45.2


