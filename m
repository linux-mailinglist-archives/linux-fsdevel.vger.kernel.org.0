Return-Path: <linux-fsdevel+bounces-66156-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AF4B0C17E26
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 02:25:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3F8EF501C57
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 01:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C91A62DA759;
	Wed, 29 Oct 2025 01:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eBzq9Tcu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9B91C5F10;
	Wed, 29 Oct 2025 01:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761701108; cv=none; b=UKnlwIf5cbqyj3xBtcpvSI3XXKrFjO+9dnAC5a2XPzHiH+Wj2dYC2vufOFkPnXBTV0aA4eAlwuy7aA+/Oe0KZlzVurRRIUaeqKfZkEobPd0gX5tN/hqide9mnOzCXwDnRZOU6e8MgVQ/lHW5+FTSMMAE05CVq886kfV5MA2xzx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761701108; c=relaxed/simple;
	bh=C/rreA4wbCjadbp0Lt1a+0twJk7qDOlqVSBr+21NEA8=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fgHXL2o74A0RWgJe8FYnR4RMABG+c1405vpinUdFi04Pu4swOTRYt/1dwKI7Fgty4O/Y8XA9FJXrIvFzSj8Yll09OtVd66+L/OS4EET5yjJghAQM1FdGUmTa/a07XorWmdVFzG7tc/YmCySdbDny+7Wf5W6u5+gS7Kf7RL1n3y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eBzq9Tcu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6616C4CEE7;
	Wed, 29 Oct 2025 01:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761701107;
	bh=C/rreA4wbCjadbp0Lt1a+0twJk7qDOlqVSBr+21NEA8=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=eBzq9TcuMyuJVpvzXTmqmeBceb8uEDqxMQpNLLZo+7D3hf9ZtHDBkKfLg/jgHJ7bk
	 V4p4XWv+Rgg9SwFPWAhSFEsszuR5spu6cCcBUkKVh0Vl/ekjygJt2wKmQoWotn+lJQ
	 e+/f9IFcudOMBDU60JBZCDe4hP4NzxNOEoiOO4SFlna8Hw7cY6oXNhW4asJ4ex1M0X
	 1YKqY3DCfpAwhj9VpYLcYp17ZZzQ04zqciOLU6RmCN0AhGNaIaq3trea/V+QvNbYOb
	 rGyFTLi+44OP4Ldq85mkxZ6v5WIk8Rd/beJlwKWWXCEQJV3bVpme9Wd/9uQMRCVCd1
	 55aeAs59jNlUA==
Date: Tue, 28 Oct 2025 18:25:07 -0700
Subject: [PATCH 18/33] generic/338: skip test if we can't mount with
 strictatime
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, zlang@redhat.com
Cc: neal@gompa.dev, fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, joannelkoong@gmail.com, bernd@bsbernd.com
Message-ID: <176169820315.1433624.14341009274441357914.stgit@frogsfrogsfrogs>
In-Reply-To: <176169819804.1433624.11241650941850700038.stgit@frogsfrogsfrogs>
References: <176169819804.1433624.11241650941850700038.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

If we can't mount a filesystem with strictatime, skip this test.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 tests/generic/338 |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)


diff --git a/tests/generic/338 b/tests/generic/338
index d138c023960f8d..450f34889b96ef 100755
--- a/tests/generic/338
+++ b/tests/generic/338
@@ -36,7 +36,7 @@ _dmerror_init
 
 # Use strictatime mount option here to force atime updates, which could help
 # trigger the NULL pointer dereference on ext4 more easily
-_dmerror_mount "-o strictatime"
+_dmerror_mount "-o strictatime" || _notrun "could not mount with strictatime"
 _dmerror_load_error_table
 
 # flush dmerror block device buffers and drop all caches, force reading from


