Return-Path: <linux-fsdevel+bounces-70665-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A2966CA3E2E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 04 Dec 2025 14:49:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 76451300B93D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Dec 2025 13:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B410A23ED5B;
	Thu,  4 Dec 2025 13:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dFriqvIl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689AF22D9ED;
	Thu,  4 Dec 2025 13:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764856150; cv=none; b=Qke9+bfEySupUocxVpNxR0dbTMgEV1SZk9I1irDv5N+s3CkmkND3YupD8oNApOQyoydZIFDrqxHL9GCMxyCYfoCq5ZwHwOiwSLVC66G7BMg1cAMNlPnqnwnbA3N0e0RWWdM03RjGvAIUr7zlLyLvHk5JUDx9nlpHzCgUUuLvcqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764856150; c=relaxed/simple;
	bh=qzXzzwZybmPzxaWXTHE6+24TttyW+VePFngRnnDiDhI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=GHAw3koRlw+S+hqh0kSlyfpwI0wpvrbJo5ab7sEQxbMtQY2/DzT/pFXI7BD/UtXmSRYvLp9kg+szJ3us7wALOOdl0HXjCVsMTV8xgGyYlvVWS3IWapJV/fS+Jp8OC3hVgbxoz35pUDHoK2WqDTHiNqej3+SIsozMcPaQ155mlXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dFriqvIl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63A5AC4CEFB;
	Thu,  4 Dec 2025 13:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764856148;
	bh=qzXzzwZybmPzxaWXTHE6+24TttyW+VePFngRnnDiDhI=;
	h=From:Subject:Date:To:Cc:From;
	b=dFriqvIlUZArkL194CTb26In4VCUvsBO/OpaeldoCRt0zNE4dy3l59QrbbP6Z6DDg
	 sUTZMudZz5oq6SnX+2FVWBI+nlgUOXTF1/ewYx7Ha3coeUk4txaEoxOI/eKuYk0N3d
	 MilCUgdwNRwlGnKNwP0i+GyhkEsQ74D16LW1WDQp9spRKfPyMpVEMzZK3mo83vGLLP
	 s4N7sDVzpU5BthTVAHfroDjv18uUV3fW/sIXmn7Nwf/0BU7l7j9K8B3xyRZc8RKDKF
	 wnNECxaWM4Yrz0rkb/HiF3VrUSkaSvkqdslnfzc+GO6iw3sS1GzqAf2jCrv6EExVNb
	 2GQ6aSlEef7gQ==
From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH v2 0/2] filelock: fix conflict detection with userland file
 delegations
Date: Thu, 04 Dec 2025 08:48:31 -0500
Message-Id: <20251204-dir-deleg-ro-v2-0-22d37f92ce2c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3XMyw6CMBCF4Vchs3ZMO3hBV76HYQF0KBMJNVPTa
 Ejf3cre5X+S860QWYUjXKsVlJNECUsJ2lUwTN3iGcWVBjJ0tGQsOlF0PLNHDXiwnT31A1FTN1A
 uT+VR3ht3b0tPEl9BP5ue7G/9AyWLBolrGkZy46U/3x6sC8/7oB7anPMXvg0q4akAAAA=
X-Change-ID: 20251201-dir-deleg-ro-41a16bc22838
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Chuck Lever <chuck.lever@oracle.com>, 
 Alexander Aring <alex.aring@gmail.com>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
 Jonathan Corbet <corbet@lwn.net>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-nfs@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1268; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=qzXzzwZybmPzxaWXTHE6+24TttyW+VePFngRnnDiDhI=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpMZFMFz2NTLDmzFPZJ9o63KB4eTq2J6oWrifC7
 1lDKWZHxj2JAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaTGRTAAKCRAADmhBGVaC
 FTGuD/91F9Ewx20D902aqY1qn43SUz3Mg7IWH2paLj9h53mgdQ18unP7jWolhJ5WOSTdTfkDnrg
 s8Zk1frwlYP+rcXPGwlAj04v3v/DpMgdDdcGJ4LyKNKVl1Z3rk13ZHol6trRdpzTPmPlKHLSDYd
 Ctzmbs+lTPnDrcxDv+dWQwCbLspkl38EkMXsx9ljASezUpqJPdonphHr3lyRcQzAa4YFWvfc6jQ
 Ya2hZ9BljXvi5VBcSaBvLacXCmDUDZ+WyRbnfNOc4ffLM0iN3rFPVQQzjsPWV43mzvlwOghO6bJ
 fBEGK+LEkyX9u3JrLk04B7mCOIIdwf3nZkJxO90qS1J+sDCfqHfFOTRKTOwoQKnDDf3fxStyJ6n
 a35iwtjxgtGR4WKmC4CGD3bt8/NYD5lC9hHF/yysezSmCxdHRTwqcMXTAwpt0uuqHaGWa1BhJH0
 VUT3kz3rDWuxwsnPdRW/HkKELJDLNiZ3id53wKMAW001zOSxQjZ7BCH4bNCslEUQhGdGKiSRhSy
 ZVPRX8u9/5HrFoC3hqtLnoYrxDotCnQSymbPhq2pGt2U1L/yQVTTZSB2LXvu/Ql6Zu2/94wp10P
 cZmMjmDdV765O/Ghml/BV6gz/73YAT2yZY+RCDWZE1Uvv0+dUtPa/BZ25PPHQO/4+28QAf8lN8Q
 p9uUvc4lhfm+hkA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

This patchset fixes the way that conflicts are detected when userland
requests file delegations. The problem is due to a hack that was added
long ago which worked up until userland could request a file delegation.

This fixes the bug and makes things a bit less hacky. Please consider
for v6.19.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
Changes in v2:
- add kerneldoc headers over nfsd's lm_open_conflict operations
- revise changelog on lease_free_list() patch
- whitespace fixes in locking.rst
- Link to v1: https://lore.kernel.org/r/20251201-dir-deleg-ro-v1-0-2e32cf2df9b7@kernel.org

---
Jeff Layton (2):
      filelock: add lease_dispose_list() helper
      filelock: allow lease_managers to dictate what qualifies as a conflict

 Documentation/filesystems/locking.rst |   1 +
 fs/locks.c                            | 119 +++++++++++++++++-----------------
 fs/nfsd/nfs4layouts.c                 |  23 ++++++-
 fs/nfsd/nfs4state.c                   |  19 ++++++
 include/linux/filelock.h              |   1 +
 5 files changed, 103 insertions(+), 60 deletions(-)
---
base-commit: 3f9f0252130e7dd60d41be0802bf58f6471c691d
change-id: 20251201-dir-deleg-ro-41a16bc22838

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


