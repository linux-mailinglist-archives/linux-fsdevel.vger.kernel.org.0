Return-Path: <linux-fsdevel+bounces-49611-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C7330AC00EE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 May 2025 02:03:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 202481BC3D6E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 May 2025 00:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A415E9443;
	Thu, 22 May 2025 00:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zr8cbluX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ADC57464;
	Thu, 22 May 2025 00:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747872225; cv=none; b=a6Pu8LyaQ4Od9ZtN/iLZuNCrqpyz6BFN328jkD6UcSS/0TKrXk4Y7owvsRG26MhJaVNV6SGtiW5v3dv2HqN7Bio0C5ENomfGTJuaqQvSmcnl/65Tqxh0z+NqtKNUpfTPbaPrOHJnDBjAFfR+CpwSidckcwm9k2zy7KudMTEZJlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747872225; c=relaxed/simple;
	bh=rxbzJ1NM7O2neAgzLftNsleg2TO06SMEPkQkAyhhi2Q=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k5t3x2UfnjomHTj/tYZQ81qr1/RTRpPIKlQzlvblkcwXHBANoAvi7wbO5pt0oDpbtqQ72YuHKLKl5N+5AiYrrY6dtfZyRCOebebUQ+iOJsmyJ1G0dAONCY6rbwKnxfl3wGSlUr5QQm6eJ5yZhUAneEstXpl3ujD5+/3e8YqIBZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zr8cbluX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7108C4CEE4;
	Thu, 22 May 2025 00:03:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747872224;
	bh=rxbzJ1NM7O2neAgzLftNsleg2TO06SMEPkQkAyhhi2Q=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=Zr8cbluXd43GA270JoN4FerCmrCGh/axjrNR+8AZtubX1mSiea7+Uamep7cayqRAJ
	 /QW4kHb7YmUYRnMKBVqtCr0DF1tF62JDT6r5UeqtT5RXN3jc1fU2pQ8GV2giNmEP9N
	 9M/1+wy9Jq5/bvcXNZwoycKh4lTeEB+hQjJRoxIRIWtzOazhJ1uJqvn49In3BPezou
	 KRXFGaIMh81pAOmpVFIAV7aPR/jx008Q2+wmSlQneCxzWBH6HOfEpiMW9e2gAcRHiX
	 L6nuLFUtaKsKOU7VxLytjTSWWcvDr8neWzK5XW2vY6FpqGdGXX91XJEH/p8NjedINV
	 +b5aX+1QTaqZw==
Date: Wed, 21 May 2025 17:03:44 -0700
Subject: [PATCH 05/11] fuse: send FUSE_DESTROY to userspace when tearing down
 an iomap connection
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org
Cc: linux-fsdevel@vger.kernel.org, miklos@szeredi.hu, joannelkoong@gmail.com,
 linux-xfs@vger.kernel.org, bernd@bsbernd.com, John@groves.net
Message-ID: <174787195673.1483178.12232870222896240975.stgit@frogsfrogsfrogs>
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

When we're destroying a fuse connection, send a FUSE_DESTROY command to
userspace so that it has time to react (closing block devices, reporting
latent errors, etc) before the mount actually goes away.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/inode.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)


diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 84b7cd5ffe843b..224fb9e7610cc5 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -2056,7 +2056,7 @@ void fuse_conn_destroy(struct fuse_mount *fm)
 {
 	struct fuse_conn *fc = fm->fc;
 
-	if (fc->destroy)
+	if (fc->destroy || fc->iomap)
 		fuse_send_destroy(fm);
 
 	fuse_abort_conn(fc);


