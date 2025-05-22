Return-Path: <linux-fsdevel+bounces-49608-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CBCDAC00E8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 May 2025 02:03:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9E271BC3C8D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 May 2025 00:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC06F17D2;
	Thu, 22 May 2025 00:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MVH9YSmf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5456218D;
	Thu, 22 May 2025 00:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747872179; cv=none; b=lY3BGRYhKaDSHAbV/2iCfnU79f+Q4h2jKTk5KkZwWOBhfmhaiyiJYRiPe+nIgUZ2MJagOwjJsu5iNZFVDHX9SD7JVW+i2WrkAqEDspKAJ4/CekyhcN5tYaNdmMrUNqzsHfpMaPuOTwgj7FWIW8hhdd/lYC6G3ulwUM99iByePXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747872179; c=relaxed/simple;
	bh=AsYfPWQUwnZZ1KLSdFpcjVA1zAC3anaw7L4qrcVNEcA=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n2Qo+7QF5dTV+qBAeks8EU0Jr4Dxmy8qzyhLUwohFCHY2ccAUlfLhKU2fFI9bxY9v1vbjqD6e9EfGmY0dgKiSBtmZDLujz8A3zodZAZyozX73/PqykuLad45i7FuDORlMYygjn2xl0HP0GSm+X6InVHC71NsnuM/Dq7b5VW3COE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MVH9YSmf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1DC4C4CEE4;
	Thu, 22 May 2025 00:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747872177;
	bh=AsYfPWQUwnZZ1KLSdFpcjVA1zAC3anaw7L4qrcVNEcA=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=MVH9YSmfqf05UBAvH7Zh6JUsZKzf6H3Fmz5TM4PSMNnzXW9GllfdyPVaBkoBGvbxE
	 JGmP02Zy751FAcCB39pogjtDCuzySjM5IEjOUlykAU/Fpypbq0H7YTwadYqRN6tXC4
	 2Mf8IQhUanKJf5867clwpxCFn1VTcUOEAWev/bICd0lYWgwA827O7dSnSBiYrsq3wM
	 9u1FFBd8n/LSvb5OB8sxus9AIthjd0A0siuO3/Tx/9/UGHvyzNBuB+1nH+W62LRn2E
	 dB3Xi8mnSYQtoRaSlG6RtmbyG62+wXaxmt4Xy5dAHJtzlz7nVpGUrbY7D2MZ+mxznz
	 9qp40NZf4u/lQ==
Date: Wed, 21 May 2025 17:02:56 -0700
Subject: [PATCH 02/11] iomap: exit early when iomap_iter is called with zero
 length
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org
Cc: linux-fsdevel@vger.kernel.org, miklos@szeredi.hu, joannelkoong@gmail.com,
 linux-xfs@vger.kernel.org, bernd@bsbernd.com, John@groves.net
Message-ID: <174787195609.1483178.4642408796944443344.stgit@frogsfrogsfrogs>
In-Reply-To: <174787195502.1483178.17485675069927796174.stgit@frogsfrogsfrogs>
References: <174787195502.1483178.17485675069927796174.stgit@frogsfrogsfrogs>
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


