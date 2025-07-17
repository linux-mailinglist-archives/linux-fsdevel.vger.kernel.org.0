Return-Path: <linux-fsdevel+bounces-55318-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1CF8B097D2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 01:30:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E055F4A0B80
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 23:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B95826059D;
	Thu, 17 Jul 2025 23:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YMmzIcg5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9FEC25229D
	for <linux-fsdevel@vger.kernel.org>; Thu, 17 Jul 2025 23:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752794858; cv=none; b=u9qlThWdD09ABaP+s/6hs+BZBy5scnPCArB+rlOUc6IpMITw0344bCUnlQBmc86UB4WzY2t/lxTCGI37OQ/tXtxz5D3GBqS6LNGFgGGzwhZMQors7SnwF4kOLyDQWrcYFbabkq84wQ4iq6uj0R+xwa1JFWoVZbSKILfQLl+EtLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752794858; c=relaxed/simple;
	bh=AsYfPWQUwnZZ1KLSdFpcjVA1zAC3anaw7L4qrcVNEcA=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k9mq3PCQPE44m9zeSex4e7mWP2G2IdBYCLP/fxuzsM3t9qetMKU8khwBqGnanSB0iHLY+0g0ADl0mz7BlN5v+HAFNjrDP14eW2Z9OHNj/mWUr9wdUWN/mSygXRoKW4SMTKV+7zK43JNvtQwNR9d0K/G69ZYG6pTM9jVCCe7ySpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YMmzIcg5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2F4BC4CEE3;
	Thu, 17 Jul 2025 23:27:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752794858;
	bh=AsYfPWQUwnZZ1KLSdFpcjVA1zAC3anaw7L4qrcVNEcA=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=YMmzIcg5sxh5b4gyMukTaacWMaQ9pk4yEoB/vVdfUA+IG5mSrv+eLxEVERSjlHxWb
	 p9YFuhuvtCJgOSxeB7Vq+OU95PnHseQ8d/2bORI5EJuOWdaGAB9WapEBI8Mw+430RV
	 7FRj+kb942LIxSoIeXTNU1+gNOrS+Xgz7pU2bZ63v4u+QG39/rM6fnAqmowb/cotD6
	 oEzKlZCVwUP7FxL83zkD1YRBR3spJlvKoBUIU9rV+ioXGk0jcp8R0dextz2GBMqS7f
	 lYfe/OVuWQihhXk6bEDRHgiBjIs2aJU9Jm+FjpLjvRdroq5YWDRZQ5fYI3I2DeXFgb
	 7wUolS0k0c7kw==
Date: Thu, 17 Jul 2025 16:27:38 -0700
Subject: [PATCH 5/7] iomap: exit early when iomap_iter is called with zero
 length
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org
Cc: linux-fsdevel@vger.kernel.org, neal@gompa.dev, John@groves.net,
 miklos@szeredi.hu, bernd@bsbernd.com, joannelkoong@gmail.com
Message-ID: <175279449562.710975.7383129818343595377.stgit@frogsfrogsfrogs>
In-Reply-To: <175279449418.710975.17923641852675480305.stgit@frogsfrogsfrogs>
References: <175279449418.710975.17923641852675480305.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

If iomap_iter::len is zero on the first call to iomap_iter(), we should
just return zero instead of calling ->iomap_begin with zero count.  This
obviates the need for ->iomap_begin implementations to handle that
"correctly" by not returning a zero-length mapping.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/iomap/iter.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)


diff --git a/fs/iomap/iter.c b/fs/iomap/iter.c
index 6ffc6a7b9ba502..b86a6a08627126 100644
--- a/fs/iomap/iter.c
+++ b/fs/iomap/iter.c
@@ -66,8 +66,11 @@ int iomap_iter(struct iomap_iter *iter, const struct iomap_ops *ops)
 
 	trace_iomap_iter(iter, ops, _RET_IP_);
 
-	if (!iter->iomap.length)
+	if (!iter->iomap.length) {
+		if (iter->len == 0)
+			return 0;
 		goto begin;
+	}
 
 	/*
 	 * Calculate how far the iter was advanced and the original length bytes


