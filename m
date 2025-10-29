Return-Path: <linux-fsdevel+bounces-66140-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 99E10C17DCB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 02:23:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8CA364F45E5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 01:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE6382DA77E;
	Wed, 29 Oct 2025 01:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AVPVwSNp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2005522D7B5;
	Wed, 29 Oct 2025 01:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761700858; cv=none; b=fhRMuGib4/b0n97u3vbOHX0kxr3KGv1ISwzAj4g7uFZR0/hk5l9f3rYCdVYp/f5N6ikVjD5OtvsTGwZgdPrazncQ42e5B7NAW5e1O8RTpUY56hb4/7/XVYtVfNH69sunonbr4oVQZ8esuheqVRk1JrGD+cphEYlKa3F5vuf3D9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761700858; c=relaxed/simple;
	bh=kIvOkOdNanwokxbLqyw/kq/rWHokdXio7rE34cACWKA=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RnqVzeGh9D6d6GRtnBzgMKT0+jQdPRS/C4QUA62GMBEhc37ajApGNhgt4t8drhvLup3YooMI/ZBTDmqiEImftIZCgtnfX8cPJhS8/2IWhgYT2DH8G/eE+TMcIEz93tIe3s8Ucolo+kgXHBYx7bFSFEy3hpY3k4ns1BSOMT7ZeHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AVPVwSNp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC024C4CEE7;
	Wed, 29 Oct 2025 01:20:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761700857;
	bh=kIvOkOdNanwokxbLqyw/kq/rWHokdXio7rE34cACWKA=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=AVPVwSNpT7OSgtYJZVHxVDLS5OCnBsjcnSqWP4gh+ir3fNDxNbBfPRc+3JxR3MkU4
	 QAADAtVPGoX05Ghw7SOd6z6U3eRNE7QuXQULpm+/y+pjkfffPb5pf1yl328+jo6kqM
	 lLg38K4pVn5xr+5JmspXYLb8lCVT2Nx8lzEIQfC0biQrX2fuIazOdEOJFiyI/zfIHx
	 4vLZtFQbQokIyTz0jV2s2Ab3r39/WdSFdMm0ittxeDZ152e1G89mRCltCxOOsWIhph
	 FceAlby9szWUtxbyf5/mycT7s4tzXXAz1ttQlyxcJdD0nh1tZ8tKXFGtyXN6/hJ6kO
	 RxiQMLXd6IrGA==
Date: Tue, 28 Oct 2025 18:20:57 -0700
Subject: [PATCH 02/33] generic/740: don't run this test for fuse ext*
 implementations
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, zlang@redhat.com
Cc: neal@gompa.dev, fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, joannelkoong@gmail.com, bernd@bsbernd.com
Message-ID: <176169820014.1433624.17059077666167415725.stgit@frogsfrogsfrogs>
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

mke2fs disables foreign filesystem detection no matter what type you
pass in, so we need to block this for both fuse server variants.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 common/rc         |    2 +-
 tests/generic/740 |    1 +
 2 files changed, 2 insertions(+), 1 deletion(-)


diff --git a/common/rc b/common/rc
index 3fe6f53758c05b..18d11e2c5cad3a 100644
--- a/common/rc
+++ b/common/rc
@@ -1889,7 +1889,7 @@ _do()
 #
 _exclude_fs()
 {
-	[ "$1" = "$FSTYP" ] && \
+	[[ $FSTYP =~ $1 ]] && \
 		_notrun "not suitable for this filesystem type: $FSTYP"
 }
 
diff --git a/tests/generic/740 b/tests/generic/740
index 83a16052a8a252..e26ae047127985 100755
--- a/tests/generic/740
+++ b/tests/generic/740
@@ -17,6 +17,7 @@ _begin_fstest mkfs auto quick
 _exclude_fs ext2
 _exclude_fs ext3
 _exclude_fs ext4
+_exclude_fs fuse.ext[234]
 _exclude_fs jfs
 _exclude_fs ocfs2
 _exclude_fs udf


