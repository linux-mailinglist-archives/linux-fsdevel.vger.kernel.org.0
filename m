Return-Path: <linux-fsdevel+bounces-18278-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C878E8B68F8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 05:36:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D769B22664
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 03:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4F8810A36;
	Tue, 30 Apr 2024 03:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="euaWjvs4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3038D10A0C;
	Tue, 30 Apr 2024 03:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714448198; cv=none; b=ZmEiL4TG63h9TDge9S2wvbyil8OyCIRhe0X28rYdYmBh1SaZMjWX3RLOfD+iq3Qk5gfM4k7iv3nA/lmSbsv3cPC2fBFbYxFMZq/44G1mNb6rsCgXng9Fpyfg0ovOR+gLKa8dLBGNO8/heI2wT81mSvqGO+eDHSwcZOe+ybtYLV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714448198; c=relaxed/simple;
	bh=t26IICXALiXcmvK7j1Laox7Qylprz8fe4CVcci+Nzjw=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h03nDsm4+Qfp+qMBsSyoEfblB9fRwvk7ND3C6bRSlhNld5qow2uSeWUZWDiuz0FE6pypHxRhf0QHoNoR++98uXMnZKrwLYErercEB8uHtRwfjv6dxNhkuUA0Uz6QW59Mh8BSNc1oKsWQI505SdVTAM/PfapfEcoVa1U/Unb77mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=euaWjvs4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 038F6C116B1;
	Tue, 30 Apr 2024 03:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714448198;
	bh=t26IICXALiXcmvK7j1Laox7Qylprz8fe4CVcci+Nzjw=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=euaWjvs4+2whTEW4+wGqGe1Lrn1KVoP/lEPyQ96tm97GYa4B+0Q9ii0PKIaNgfFwy
	 ekW0dnJnLCcLIIq8U9AsflE6Eq+UlrsphdiGsfJ/3bZcCjJElZ66o1iZN83lwx9T6t
	 sGLPhMWLxSkRKIYXSutfUOCq0xmVRV9Pgt56N5TeePg/N9c2MxkgT3DC0hGUQh8AbG
	 Z7CWddAGdMcuDdXGqLISctVvuDBaeGh9WoENBiPY1zB6j+C8cO65ikNSORDzoCWd1Z
	 IBXahNxW6T3U+iP2XAXgi6YGes/axfclirXRDYHbjyfs6xwrR/FGCCWJbxmguZ2cS6
	 lPw8MC4AqUOMA==
Date: Mon, 29 Apr 2024 20:36:37 -0700
Subject: [PATCH 22/38] xfs_db: dump verity features and metadata
From: "Darrick J. Wong" <djwong@kernel.org>
To: aalbersh@redhat.com, ebiggers@kernel.org, cem@kernel.org,
 djwong@kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
 fsverity@lists.linux.dev
Message-ID: <171444683449.960383.8331991050586758696.stgit@frogsfrogsfrogs>
In-Reply-To: <171444683053.960383.12871831441554683674.stgit@frogsfrogsfrogs>
References: <171444683053.960383.12871831441554683674.stgit@frogsfrogsfrogs>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Teach the debugger how to decode the merkle tree block number in the
attr name, and to display the fact that this is a verity filesystem.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 db/sb.c |    2 ++
 1 file changed, 2 insertions(+)


diff --git a/db/sb.c b/db/sb.c
index cf5251cd728f..e4ca8f72ae97 100644
--- a/db/sb.c
+++ b/db/sb.c
@@ -857,6 +857,8 @@ version_string(
 		strcat(s, ",METADIR");
 	if (xfs_has_rtgroups(mp))
 		strcat(s, ",RTGROUPS");
+	if (xfs_has_verity(mp))
+		strcat(s, ",VERITY");
 	return s;
 }
 


