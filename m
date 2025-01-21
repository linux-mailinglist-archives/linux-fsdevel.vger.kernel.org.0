Return-Path: <linux-fsdevel+bounces-39794-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B66AA183CF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jan 2025 19:00:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 087A33AAD98
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jan 2025 17:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 618311F55F5;
	Tue, 21 Jan 2025 17:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mw2GF6yQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C3A1F55FA;
	Tue, 21 Jan 2025 17:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737482373; cv=none; b=Xre4VLuy9+WG+RV3aNkdRJ4vHc5VNEDv3tN2skPo6gdzFNRbNmNzNCEXQVvzCmiSPgq2fjmtzu2Yw1M4QMRIttuxdwxyxJu44xp3bVznmubMh4Jf1zuMaHuw2xfCFCsEDijQpS5LXy7qOTxqGhIIf1l/20PhVljKPmCVoDjYoJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737482373; c=relaxed/simple;
	bh=gdVZ7EZcFCxr50W/oFCdbTk/DmDd/OzTiv9J4k8k9ek=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G4sRTVbsM2yPFGMkXgW/ZWuJFcWPOxy/YiZzYdYgNtvganocUDD6FxWFf6PHdrOXXlGhSRtFsxpQt5DKdoGPIln1qIIdaSaq3k/mcXBiY9bpiKY08LLFsusBc77XKtPiXK1SaKST709XJOydHq5D1R+/s3/0jxNNF2PPLBEGDNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mw2GF6yQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8BF5C4CEDF;
	Tue, 21 Jan 2025 17:59:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1737482373;
	bh=gdVZ7EZcFCxr50W/oFCdbTk/DmDd/OzTiv9J4k8k9ek=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mw2GF6yQmFwwLSYac5bBFg/U3kRbfbd45KtG6AiCqNod7zYJ0WyPbt0qzDW5aoPXM
	 P2JWqgf+KC32Nir/vjsc8mvxQPSutgBQvTDtn3SixoGk5tXxf4Gg6up5jmfn28W/BM
	 7BAprG81+OMAd3xL+EXKmsC8V1maFdH242SuhhfE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Shyam Prasad N <nspmangalore@gmail.com>,
	David Howells <dhowells@redhat.com>,
	Steve French <sfrench@samba.org>,
	Paulo Alcantara <pc@manguebit.com>,
	Jeff Layton <jlayton@kernel.org>,
	linux-cifs@vger.kernel.org,
	netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 054/122] netfs: Fix non-contiguous donation between completed reads
Date: Tue, 21 Jan 2025 18:51:42 +0100
Message-ID: <20250121174535.073498135@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250121174532.991109301@linuxfoundation.org>
References: <20250121174532.991109301@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index e70eb4ea21c03..a44132c986538 100644
--- a/fs/netfs/read_collect.c
+++ b/fs/netfs/read_collect.c
@@ -249,16 +249,17 @@ static bool netfs_consume_read_data(struct netfs_io_subrequest *subreq, bool was
 
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




