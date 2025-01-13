Return-Path: <linux-fsdevel+bounces-39071-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F184AA0BFFA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2025 19:36:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A29CF7A24C9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2025 18:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC74E1D31A2;
	Mon, 13 Jan 2025 18:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i2lnj6Pw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C6E31CF5EE;
	Mon, 13 Jan 2025 18:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736793284; cv=none; b=PjtjmIteCfiqZMGKn2PkpcuhKCdaB0TQWmNe97P/9aRzwkSrSWY0hYeBey11+Tx/bZueiQAZfGplWOIJI3fDPkKg+C0L+jbmRCnXJr23w476VnikJ4T7wtnKglceaHe1WQXCrxW/QxjRHuob+3V9zFuH44VXO2y3xYqHZxx7/+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736793284; c=relaxed/simple;
	bh=ma1f0ZEWo2M41Ot4ZwjiyYJf7GdNuqfbTmHT6Gn1vRs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eoBzvqv7Lif8je+m7IWRNyDBkhNbmrNqu2c+ZDmDRp//WLvDnLHTV/RO5CXI02kIkf0ZU48qPb6m4QQ/dAbIaTPdUxOXrpnV31vtcug8Y7QjL+nP4SFd1/Eekd21tvnWgd5vVGaW2n9u/TlciUq+Wfuxk5d5A2nwAhfVSaX4Tr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i2lnj6Pw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 698B7C4CED6;
	Mon, 13 Jan 2025 18:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736793283;
	bh=ma1f0ZEWo2M41Ot4ZwjiyYJf7GdNuqfbTmHT6Gn1vRs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i2lnj6Pw5ZXJUZv2rx5hIlXL43KX4qDW9XdJsEu6s4cYmq0JAerPOsKMgGFpM2IVw
	 4ZokhoG5iE1DEj1UbWAYBQ/Ox7e0i5+SZCeo638vJJkypCw0JiK9XNX8Esa7jAtocB
	 j0QHDw/0eOXFTHiFDRI6VWKs0gMGAXaeutYgsWzFYgDngZSLyViCHIoBNTh8r95ozr
	 mmrH6AnG6cytVWLvCic43hx9PXGPUNQ6Kj580F/VKuxTyddnCCh6rWQEWW36WxGGP/
	 0miMqExK66veveJ0yF/sYl279oYJOy/CM3Deia05Sh3UPdEG64CQD7ei0uvqsYrbpI
	 mZjAnt4hpzrjw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>,
	Shyam Prasad N <nspmangalore@gmail.com>,
	Steve French <sfrench@samba.org>,
	Paulo Alcantara <pc@manguebit.com>,
	Jeff Layton <jlayton@kernel.org>,
	linux-cifs@vger.kernel.org,
	netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 6.12 07/20] netfs: Fix non-contiguous donation between completed reads
Date: Mon, 13 Jan 2025 13:34:12 -0500
Message-Id: <20250113183425.1783715-7-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250113183425.1783715-1-sashal@kernel.org>
References: <20250113183425.1783715-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.9
Content-Transfer-Encoding: 8bit

From: David Howells <dhowells@redhat.com>

[ Upstream commit c8b90d40d5bba8e6fba457b8a7c10d3c0d467e37 ]

When a read subrequest finishes, if it doesn't have sufficient coverage to
complete the folio(s) covering either side of it, it will donate the excess
coverage to the adjacent subrequests on either side, offloading
responsibility for unlocking the folio(s) covered to them.

Now, preference is given to donating down to a lower file offset over
donating up because that check is done first - but there's no check that
the lower subreq is actually contiguous, and so we can end up donating
incorrectly.

The scenario seen[1] is that an 8MiB readahead request spanning four 2MiB
folios is split into eight 1MiB subreqs (numbered 1 through 8).  These
terminate in the order 1,6,2,5,3,7,4,8.  What happens is:

	- 1 donates to 2
	- 6 donates to 5
	- 2 completes, unlocking the first folio (with 1).
	- 5 completes, unlocking the third folio (with 6).
	- 3 donates to 4
	- 7 donates to 4 incorrectly
	- 4 completes, unlocking the second folio (with 3), but can't use
	  the excess from 7.
	- 8 donates to 4, also incorrectly.

Fix this by preventing downward donation if the subreqs are not contiguous
(in the example above, 7 donates to 4 across the gap left by 5 and 6).

Reported-by: Shyam Prasad N <nspmangalore@gmail.com>
Closes: https://lore.kernel.org/r/CANT5p=qBwjBm-D8soFVVtswGEfmMtQXVW83=TNfUtvyHeFQZBA@mail.gmail.com/
Signed-off-by: David Howells <dhowells@redhat.com>
Link: https://lore.kernel.org/r/526707.1733224486@warthog.procyon.org.uk/ [1]
Link: https://lore.kernel.org/r/20241213135013.2964079-3-dhowells@redhat.com
cc: Steve French <sfrench@samba.org>
cc: Paulo Alcantara <pc@manguebit.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: linux-cifs@vger.kernel.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/netfs/read_collect.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/netfs/read_collect.c b/fs/netfs/read_collect.c
index 3cbb289535a8..b415e3972336 100644
--- a/fs/netfs/read_collect.c
+++ b/fs/netfs/read_collect.c
@@ -247,16 +247,17 @@ static bool netfs_consume_read_data(struct netfs_io_subrequest *subreq, bool was
 
 	/* Deal with the trickiest case: that this subreq is in the middle of a
 	 * folio, not touching either edge, but finishes first.  In such a
-	 * case, we donate to the previous subreq, if there is one, so that the
-	 * donation is only handled when that completes - and remove this
-	 * subreq from the list.
+	 * case, we donate to the previous subreq, if there is one and if it is
+	 * contiguous, so that the donation is only handled when that completes
+	 * - and remove this subreq from the list.
 	 *
 	 * If the previous subreq finished first, we will have acquired their
 	 * donation and should be able to unlock folios and/or donate nextwards.
 	 */
 	if (!subreq->consumed &&
 	    !prev_donated &&
-	    !list_is_first(&subreq->rreq_link, &rreq->subrequests)) {
+	    !list_is_first(&subreq->rreq_link, &rreq->subrequests) &&
+	    subreq->start == prev->start + prev->len) {
 		prev = list_prev_entry(subreq, rreq_link);
 		WRITE_ONCE(prev->next_donated, prev->next_donated + subreq->len);
 		subreq->start += subreq->len;
-- 
2.39.5


