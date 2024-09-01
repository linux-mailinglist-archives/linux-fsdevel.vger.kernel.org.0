Return-Path: <linux-fsdevel+bounces-28178-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D613A967894
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Sep 2024 18:33:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1369F1C21123
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Sep 2024 16:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4445817F389;
	Sun,  1 Sep 2024 16:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JyfZ53OU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A057217E46E;
	Sun,  1 Sep 2024 16:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725208392; cv=none; b=KyFsSZylVDiWF5z6MqvDZfMZd6fz3+24LNfNhCtJMOmYeM44x73EA4IKS0kt51r3Lao9EQX8o8fYD37TAGDTUIXUytuTx9nDC/bW3fpKBu0GVhedCJ2mBT68oxPq1d+SNuxZipwS3D0iLsb6554enrE837+MMLW0W5CzkZZv0XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725208392; c=relaxed/simple;
	bh=v4Ur4u1Bj8s/ckHrunGoQMCP28DvkrdDH3ttcxoBy74=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c9WcjKsIQe8gsAOemQHsytDNMZRNA1+L3OyUq5JHvr99QyRoiOrNnkB4Fv6YiepHtIYU6FecNuyIwFYNmXL6G2STrOt5yU0fMnfwWZSaZzy5VDSazcEsmDunTi9heKV06IksDANsB7FbSJlDMZE17kJy0UH5FtFaqmT4P5+0u8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JyfZ53OU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 126E5C4CEC3;
	Sun,  1 Sep 2024 16:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725208392;
	bh=v4Ur4u1Bj8s/ckHrunGoQMCP28DvkrdDH3ttcxoBy74=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JyfZ53OUvOIBY7zEvF63nqKPHdR0JzJ5zEt/GWzcYShPvQmAklLDBLfjgyEiicUWD
	 6sSLuniyg40s/6J0++fa47lCKorA0M25eRqQNHlZVAUjuoQOvllrhePAQdBDIjUekM
	 n/RbuQfA+Xe3jUOHGhK80yj8jMCuqdw392GLzdnc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	David Howells <dhowells@redhat.com>,
	Steve French <sfrench@samba.org>,
	Paulo Alcantara <pc@manguebit.com>,
	Jeff Layton <jlayton@kernel.org>,
	linux-cifs@vger.kernel.org,
	netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.10 069/149] netfs: Fix missing iterator reset on retry of short read
Date: Sun,  1 Sep 2024 18:16:20 +0200
Message-ID: <20240901160820.061147257@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240901160817.461957599@linuxfoundation.org>
References: <20240901160817.461957599@linuxfoundation.org>
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

6.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Howells <dhowells@redhat.com>

[ Upstream commit 950b03d0f664a54389a555d79215348ed413161f ]

Fix netfs_rreq_perform_resubmissions() to reset before retrying a short
read, otherwise the wrong part of the output buffer will be used.

Fixes: 92b6cc5d1e7c ("netfs: Add iov_iters to (sub)requests to describe various buffers")
Signed-off-by: David Howells <dhowells@redhat.com>
Link: https://lore.kernel.org/r/20240823200819.532106-6-dhowells@redhat.com
cc: Steve French <sfrench@samba.org>
cc: Paulo Alcantara <pc@manguebit.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: linux-cifs@vger.kernel.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/netfs/io.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/netfs/io.c b/fs/netfs/io.c
index f3abc5dfdbc0c..c96431d3da6d8 100644
--- a/fs/netfs/io.c
+++ b/fs/netfs/io.c
@@ -313,6 +313,7 @@ static bool netfs_rreq_perform_resubmissions(struct netfs_io_request *rreq)
 			netfs_reset_subreq_iter(rreq, subreq);
 			netfs_read_from_server(rreq, subreq);
 		} else if (test_bit(NETFS_SREQ_SHORT_IO, &subreq->flags)) {
+			netfs_reset_subreq_iter(rreq, subreq);
 			netfs_rreq_short_read(rreq, subreq);
 		}
 	}
-- 
2.43.0




