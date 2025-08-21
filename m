Return-Path: <linux-fsdevel+bounces-58441-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 747F5B2E9C4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 02:52:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1CBFA064B5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 00:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 561461E5B70;
	Thu, 21 Aug 2025 00:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bcu7Cilc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E7B190685
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Aug 2025 00:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755737550; cv=none; b=Bb8ZSd6tpg4HdYbcRsqPwMqpL7vRCFN3joE0Cm1rlPimzXLwavQmzW8AXDs1B5GP1WeRI9bV9cDae2IBOocRpGvfdjh3hK2JutbLQzehgSj1pLjA4/ZNkoHBY+meozqnbIldgehG+qFCDiObUDgeC5XW/IOgn8gKZxe6h99IGzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755737550; c=relaxed/simple;
	bh=kginxZV7Bargjk0EinS/fZ2aJzCWsGcJp2xAB85IHy0=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iHu4Qhe90f+rBg7+OI6k4XdCza36CD/iKGZUbagssp3XscqxMQoNzQaYiuZ7jOHdHwOvHm60Ded5V4qR6bEwoCOJWmjN6VrFiJpxGpv98xsb7UELxIpNzFiAAyuBLiiTFJqRmltMcgQfbvSSUhVmdDJ1BBrT2OrcVRcpPMPCNVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bcu7Cilc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E4B3C4CEE7;
	Thu, 21 Aug 2025 00:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755737550;
	bh=kginxZV7Bargjk0EinS/fZ2aJzCWsGcJp2xAB85IHy0=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=Bcu7Cilc3TKiWJn6yk2DOcwgt/wdBQWzRS4z+ikmiYiXNzAmzpXH5GrpWiHeWNyAV
	 MaGgZgYO0G0Yr1oLZLbkPB4MbDLQg5Q1+IbPSUoN2xBHYW8MVO6CsJn7tE9G8E5QmS
	 KJ6h2iS3Vim53dmwyUKbiP29h4I1a3XF0sUTL8kKU7O63ubQbHSUmbV+/uQQT/4XEi
	 JFhaCLyZDipzaTzrprE33Z7ANDtqkXCGoZEnhnbcTeDOo99dueGvyWH7Ln7JJSMGg0
	 MXmnDxaMKrE0F3hvLmlynvc0QIB/1md/fJ1MicAVQpdEysuY5LTU8l6weTI7ht4Gx2
	 o0ZkpAytoDIsQ==
Date: Wed, 20 Aug 2025 17:52:29 -0700
Subject: [PATCH 7/7] fuse: enable FUSE_SYNCFS for all servers
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: bernd@bsbernd.com, neal@gompa.dev, John@groves.net,
 linux-fsdevel@vger.kernel.org, joannelkoong@gmail.com
Message-ID: <175573708692.15537.2841393845132319610.stgit@frogsfrogsfrogs>
In-Reply-To: <175573708506.15537.385109193523731230.stgit@frogsfrogsfrogs>
References: <175573708506.15537.385109193523731230.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Turn on syncfs for all fuse servers so that the ones in the know can
flush cached intermediate data and logs to disk.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/inode.c |    1 +
 1 file changed, 1 insertion(+)


diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 463879830ecf34..b05510799f93e1 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1814,6 +1814,7 @@ int fuse_fill_super_common(struct super_block *sb, struct fuse_fs_context *ctx)
 		if (!sb_set_blocksize(sb, ctx->blksize))
 			goto err;
 #endif
+		fc->sync_fs = 1;
 	} else {
 		sb->s_blocksize = PAGE_SIZE;
 		sb->s_blocksize_bits = PAGE_SHIFT;


