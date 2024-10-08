Return-Path: <linux-fsdevel+bounces-31333-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BDA38994B6C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2024 14:44:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F33AAB2538C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2024 12:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CF791DF721;
	Tue,  8 Oct 2024 12:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uYcVyzo2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C341DF270;
	Tue,  8 Oct 2024 12:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728391315; cv=none; b=NcB+4ZBLwjSfnFkNloKzjFoLA8vlcDNRulrNWVw8Oovh3w3Xp06rHppjiPZVNAwNUoVORlCju+OCEmcVzWUstU7wRiSNNsrRl1vjwMj87H02bhopJQQ/xvhEWyUikvkvdiLVfdbIrxkRci/tg43mFu3e/2Zw8r8JhxIenyu7TVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728391315; c=relaxed/simple;
	bh=mgjbkBQcEHi1IAqaprg2JeL4DMTxLZk23LIjPeO4E8o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pdzHtNizuHpv6Zqu7BMaE/uoLYJ4876aSlAWDQakVHX5uEnMv+g2poFwl6P/uccsTL8ROfq9JW7wWwsTwkCa5mxwuk1Si95kyRh4+CS0Z573Rh7tbonycFqdPF8Z+9pNL66pkEJhHxKm/FfAtfOUYhDGBrxWeGeRve+1Uehk2HE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uYcVyzo2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13022C4CECC;
	Tue,  8 Oct 2024 12:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728391315;
	bh=mgjbkBQcEHi1IAqaprg2JeL4DMTxLZk23LIjPeO4E8o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uYcVyzo2349FuTgIt316EamauSGvMqZBjJ3Vuh5lkTE2d9OSPoUM8cjp1PLm5llba
	 fTwG2kztOinNipCmLOShmfNCGsyNLK3KRH27GmB0WZyoTzOcupp0E2eyWFxqJnr++5
	 G4d9Of94a7bk3HtbkM1tpD5yBIT00eKvdi2mcTYM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Jeff Layton <jlayton@kernel.org>,
	linux-afs@lists.infradead.org,
	netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.11 034/558] afs: Fix missing wire-up of afs_retry_request()
Date: Tue,  8 Oct 2024 14:01:04 +0200
Message-ID: <20241008115703.565273104@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241008115702.214071228@linuxfoundation.org>
References: <20241008115702.214071228@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.11-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Howells <dhowells@redhat.com>

[ Upstream commit 2cf36327ee1e47733aba96092d7bd082a4056ff5 ]

afs_retry_request() is supposed to be pointed to by the afs_req_ops netfs
operations table, but the pointer got lost somewhere.  The function is used
during writeback to rotate through the authentication keys that were in
force when the file was modified locally.

Fix this by adding the pointer to the function.

Fixes: 1ecb146f7cd8 ("netfs, afs: Use writeback retry to deal with alternate keys")
Reported-by: Dr. David Alan Gilbert <linux@treblig.org>
Signed-off-by: David Howells <dhowells@redhat.com>
Link: https://lore.kernel.org/r/1690847.1726346402@warthog.procyon.org.uk
cc: Marc Dionne <marc.dionne@auristor.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: linux-afs@lists.infradead.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/afs/file.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/afs/file.c b/fs/afs/file.c
index ec1be0091fdb5..290f60460ec75 100644
--- a/fs/afs/file.c
+++ b/fs/afs/file.c
@@ -404,6 +404,7 @@ const struct netfs_request_ops afs_req_ops = {
 	.begin_writeback	= afs_begin_writeback,
 	.prepare_write		= afs_prepare_write,
 	.issue_write		= afs_issue_write,
+	.retry_request		= afs_retry_request,
 };
 
 static void afs_add_open_mmap(struct afs_vnode *vnode)
-- 
2.43.0




