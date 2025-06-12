Return-Path: <linux-fsdevel+bounces-51428-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14AA6AD6C70
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 11:41:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A50977A10D1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 09:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8706D22D4DC;
	Thu, 12 Jun 2025 09:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="E9ofA8JR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A524522B586;
	Thu, 12 Jun 2025 09:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749721280; cv=none; b=AjDEY7laS8LB0hJPTvhePREc5NmGDbVMweq3rDkZ7HcD0Bsd9UYJ4F0/vOHwMnWOAsHDZKFuiW/QviJQ+bH5rs7Qv4G5Aeg38I5rgPGS/voOS35xan2P5TMAsKWf+GjKi15NNhpA+MkX5s/8AadWTc/YGD/avXK1svwt0uxt9Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749721280; c=relaxed/simple;
	bh=dUpITw3A/ZEC+rFRDujN8SxVr2mY8VyFTu5fpg/JjGs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rAb80qKfgDq71R58zk0e1+JTI1zuOP3ycPxtIAy2InqhCra2TFQxPLe0Kc8Cmjamh+sYVb2l0YxlILc/1xRsflWyz3cU0iWD6pfAxDOs2jYu86yXqzVYJJgED0oheu5tAcCw7RLj7Uz+fSBl3BD08lwvbGiJx7sBelBN9egCDXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=E9ofA8JR; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=Upf5cSptm5t+emSSshI89dgsx6mF25prv0yuxSCnn7c=; b=E9ofA8JRGZz9VacKeF349zI3Fs
	NgbmLAPempf+ncfPPCoqX/TvgTJRh3W3yhC967rNDjFVAKVV4d8/Y0Rri6tR2CpN86oA96WHHNFsM
	fcPoMQbvN8kPnh6B+ppHBuVo6zLojmp8gqDkHaeSXJAipL3Nj0/KtPw1oEVOq56zz+nTCDRBZxp5R
	vaZdL0Ov73gUgEIzBQSD/KbtI/iS+c8xZin1rVeyly/fc8dl5SpxGM+zX0LQSf+0cjpwwKeZ4gMFo
	sFhnmhFHpRbisHrhRNKZyE6M6aMp54fL22KHfpESrf2kiQiVaaGCiMYpEI9JIKvM82VZJpAQXkMfl
	8JSNVVcA==;
Received: from bl23-10-177.dsl.telepac.pt ([144.64.10.177] helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1uPeQl-002ZaV-Tx; Thu, 12 Jun 2025 11:41:08 +0200
From: Luis Henriques <luis@igalia.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-dev@igalia.com,
	Luis Henriques <luis@igalia.com>
Subject: [PATCH] fs: drop assert in file_seek_cur_needs_f_lock
Date: Thu, 12 Jun 2025 10:41:01 +0100
Message-ID: <20250612094101.6003-1-luis@igalia.com>
In-Reply-To: <87tt4u4p4h.fsf@igalia.com>
References: <87tt4u4p4h.fsf@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The assert in function file_seek_cur_needs_f_lock() can be triggered very
easily because, as Jan Kara suggested, the file reference may get
incremented after checking it with fdget_pos().

Fixes: da06e3c51794 ("fs: don't needlessly acquire f_lock")
Signed-off-by: Luis Henriques <luis@igalia.com>
---
Hi Christian,

It wasn't clear whether you'd be queueing this fix yourself.  Since I don't
see it on vfs.git, I decided to explicitly send the patch so that it doesn't
slip through the cracks.

Cheers,
-- 
Luis

 fs/file.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/file.c b/fs/file.c
index 3a3146664cf3..075f07bdc977 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -1198,8 +1198,6 @@ bool file_seek_cur_needs_f_lock(struct file *file)
 	if (!(file->f_mode & FMODE_ATOMIC_POS) && !file->f_op->iterate_shared)
 		return false;
 
-	VFS_WARN_ON_ONCE((file_count(file) > 1) &&
-			 !mutex_is_locked(&file->f_pos_lock));
 	return true;
 }
 

