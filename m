Return-Path: <linux-fsdevel+bounces-34547-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0E289C6287
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 21:27:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E587284B8F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 20:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D62E421A715;
	Tue, 12 Nov 2024 20:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="f7A0grTP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4003821A6ED
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 Nov 2024 20:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731443177; cv=none; b=OMgXgVGc3DBR5t7Hj6bD0HHOXiglFjUwk3C/Uf3Q13MWNvjzXO/WOEz9zXiI30ml6RjZTwdfb3RjP63ZkFZI/if+vRmBoClFcWN6cwadmIRXUAqnNCwIaUpmifyuhfJk4ezo7EniNCSgw6H9Jla0H9m8QYi3Y2JYbzIIiRfypTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731443177; c=relaxed/simple;
	bh=d2624VP+ywx7aipu3azEcZrx5rNuDSsnLqE/FtB7nYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UHgvo4h76FprFAdloUyU7YsxMYbMQb2fVo5CqYI4IRu3Ad3RUsQc9DtLLb62sSfci1321eNgYQtXxzHi7pTcWmnObeGsEPofxXGDNQqgbBiQgF/YteuKSFWeSMPDlAKk2tnch6StzC0oz+cF0bkLgGBaQQzne2LwWP9iV4ZEX+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=f7A0grTP; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=dD3C7cqJbiEbgx0ZXFHOgSog1NfLueNrI1Gl4rNE99s=; b=f7A0grTPGGMMkClxq89mJAzyET
	F5R1qT04IG42vGu3Icc2sWtZd/fUj4nWdtduawjBsj97RLPGXtcD8/aqy3mLWDGdcYYMuqIf/csbA
	u5Z4hhgKty7ud7nQsWm9+lFxcbZxFFqdAJjIDp8cJSEpLcmSzuvs54yGf9jdLtuPXpEJ4SBeApGIq
	E6VNtMpznC5fVNNu+taV76IwWrUtQDfwu9SsrAINjXTdePvx4kthwdijGRVyXfqdRlRsnQUev5DEM
	h1naDAyYjyxut+V5WJe4RqAP3iokrWr8z+9nPT48bTTtsDXSEr5SLOBJCseDSoUc+hM85GbKsSgHu
	K8kNSllA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tAxSn-0000000EEsp-1zOB;
	Tue, 12 Nov 2024 20:26:13 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: viro@zeniv.linux.org.uk,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 1/5] io_statx_prep(): use getname_uflags()
Date: Tue, 12 Nov 2024 20:25:48 +0000
Message-ID: <20241112202552.3393751-1-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241112202118.GA3387508@ZenIV>
References: <20241112202118.GA3387508@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

the only thing in flags getname_flags() ever cares about is
LOOKUP_EMPTY; anything else is none of its damn business.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 io_uring/statx.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/io_uring/statx.c b/io_uring/statx.c
index f7f9b202eec0..6bc4651700a2 100644
--- a/io_uring/statx.c
+++ b/io_uring/statx.c
@@ -36,8 +36,7 @@ int io_statx_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 	sx->buffer = u64_to_user_ptr(READ_ONCE(sqe->addr2));
 	sx->flags = READ_ONCE(sqe->statx_flags);
 
-	sx->filename = getname_flags(path,
-				     getname_statx_lookup_flags(sx->flags));
+	sx->filename = getname_uflags(path, sx->flags);
 
 	if (IS_ERR(sx->filename)) {
 		int ret = PTR_ERR(sx->filename);
-- 
2.39.5


