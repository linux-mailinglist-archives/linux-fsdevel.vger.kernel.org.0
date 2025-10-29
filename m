Return-Path: <linux-fsdevel+bounces-66151-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A3759C17E5E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 02:27:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B74851880541
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 01:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61E1C2D7DDF;
	Wed, 29 Oct 2025 01:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eukyjwYa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B833B275860;
	Wed, 29 Oct 2025 01:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761701029; cv=none; b=bFYCNTQOaYRuURnjiTzQbzhDNjvrOD8Wrr4VkWaTvC9sKA4HPMIoc9N5o7LUzZJH1g/af+Jslbs4GGuhQPr9Bhw8C7Kggylu4ExB8d1D8R+dX73o0n481Cl5Rzl5kLwXQRzXsltS92vYhIJzcD6C+fPxQd/x+gc2IgZpv7+x6z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761701029; c=relaxed/simple;
	bh=hax4QP2eXrJkUbKJOKeQqEuKJLOyButCQqH1du74J5Y=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m0fAzeQNYZ2Tz4rbp4B7aessNv7Ub5DYjAi9pq5wTbZXlosKHHaKPi2V8zZNUnmVngaq9V8eo6FRcsUSfQJ85+yWuSUa3t+h87dbxqVJYwaqvbtdqbZCelG/z7A44IeFSr0O4sWva/+e2IH1Nu0dYnxm1DGeMIq/zaeoyr4+GXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eukyjwYa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F322C4CEE7;
	Wed, 29 Oct 2025 01:23:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761701029;
	bh=hax4QP2eXrJkUbKJOKeQqEuKJLOyButCQqH1du74J5Y=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=eukyjwYaR3eDbLZeeV6mvocoYLM8HPgQ3RkLNhByvJAW9wMIUmDIEHNGYxWDtUqMi
	 3TdyFol1yKzfJzGM+YOq8r8jb/h/4gOupKiiKxvybY/UVsMXkjPlJvIC3yVLfWghx6
	 VIikDDbaFROqx3W8Ic6NfVN3oN1dutzihbPqS0j1LrF9uNaEQKuQPyDnWfqN7ppeFa
	 2VnPTgngMW5wn3O+fDwilCaLu6CbELCgEvUkHv5xBtyFoZ8dcpHWBAroBdT9lYR3kM
	 YX59P08VxII+BI+ZUp0hkpBxs4JmmjKOS3gOqbfGg2sF4m27hOhFFMK09FZJ3Zr0Nx
	 rndNSZynFDThg==
Date: Tue, 28 Oct 2025 18:23:49 -0700
Subject: [PATCH 13/33] defrag: fix ext4 defrag ioctl test
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, zlang@redhat.com
Cc: neal@gompa.dev, fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, joannelkoong@gmail.com, bernd@bsbernd.com
Message-ID: <176169820221.1433624.1369544788981212640.stgit@frogsfrogsfrogs>
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

ioctl() can return ENOTTY if the ioctl number isn't recognized at all.
Change _require_defrag to _notrun the test if the ext4 defrag ioctl
isn't recognised at all.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 common/defrag |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)


diff --git a/common/defrag b/common/defrag
index c054e62bde6f4d..43ec07ddd4ac2a 100644
--- a/common/defrag
+++ b/common/defrag
@@ -19,7 +19,7 @@ _require_defrag()
 	$XFS_IO_PROG -f -c "pwrite -b $bsize 0 $bsize" $testfile > /dev/null
 	cp $testfile $donorfile
 	echo $testfile | $here/src/e4compact -v -f $donorfile | \
-		grep -q "err:95"
+		grep -q -E "err:(95|25)"
 	if [ $? -eq 0 ]; then
 		rm -f $testfile $donorfile 2>&1 > /dev/null
 		_notrun "$FSTYP test filesystem doesn't support online defrag"


