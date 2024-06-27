Return-Path: <linux-fsdevel+bounces-22634-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F74091A8E2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 16:15:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90BCDB267E3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 14:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1190198A07;
	Thu, 27 Jun 2024 14:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZlLRrzI2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609C4195B33
	for <linux-fsdevel@vger.kernel.org>; Thu, 27 Jun 2024 14:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719497521; cv=none; b=q738XUWxM/zdoeuXMX/YBKfE9Z7MmKab9fyUnR7QfvsJocDqaTiVPGptPREa0Ct+wpQaPcAPP6Enwodchg4eje6UXn0B1fU1Ab1cz0kDl69hkR77VLJzrS8v+2z3g8/YJy/LJ1xm6IBCc4jDgJwqmSJkj8We9iaupK6Es+tiy4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719497521; c=relaxed/simple;
	bh=R5+PBNxjeTS8Zs34p+Q7gbq9G9p8wRePVEYAraVFMZY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rt8ANtElLsz2WgjaU/aOhCerO8SRbpT1ZMp443bomx+Wplo/0OHSuB2h/7hOx867nzAeNHDErWalTh2wv15fmddQJN2YRMkjL88G45wDLcjDo4cDOlEv4+BMQoZ/cCovMp2+lUI/j7sAk8L28NeE1q7+mW7C+5whdPXJht/E9Es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZlLRrzI2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28D40C32786;
	Thu, 27 Jun 2024 14:11:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719497521;
	bh=R5+PBNxjeTS8Zs34p+Q7gbq9G9p8wRePVEYAraVFMZY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ZlLRrzI2HTKPkblTi4xa9pppIQt46hjNVZ+1/UIMQqEVn2lOBsuXZCE5tXfPQUDKa
	 XfT9oJJiqLoF95lmIbWIuiuWsrrWH8GuQbxf14n3gzKpX6qowpGqN78sMJxlg6KCr9
	 pWBdDPdL2DmQOHbjL80QxMX67P88/Agov7ZIscL1p9/GuTvusKnunxKbGaUmWTdyrF
	 7KQGcaHZmfo7ziolqRegYmtLzWf09vhIWtqz4+F/shHIOht+RbgrMH7CtJ9il6ap1E
	 Vf2+4vKG5iHbDqULaF/mQkuPGrFC2JJkubvXepqEeToVNKUBzOkRd+MF17DDkt58+v
	 Vo6OabRZ8QG+A==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 27 Jun 2024 16:11:40 +0200
Subject: [PATCH RFC 2/4] nsproxy: add a cleanup helper for nsproxy
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240627-work-pidfs-v1-2-7e9ab6cc3bb1@kernel.org>
References: <20240627-work-pidfs-v1-0-7e9ab6cc3bb1@kernel.org>
In-Reply-To: <20240627-work-pidfs-v1-0-7e9ab6cc3bb1@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>, Seth Forshee <sforshee@kernel.org>, 
 Stephane Graber <stgraber@stgraber.org>, Jeff Layton <jlayton@kernel.org>, 
 Aleksa Sarai <cyphar@cyphar.com>, 
 Alexander Mikhalitsyn <alexander@mihalicyn.com>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-13183
X-Developer-Signature: v=1; a=openpgp-sha256; l=545; i=brauner@kernel.org;
 h=from:subject:message-id; bh=R5+PBNxjeTS8Zs34p+Q7gbq9G9p8wRePVEYAraVFMZY=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTVFmt9szp+zErklLLRhl/b/SuvrFns4x5R6bPa9LRe9
 htDE+HAjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgImwHWf4X9m5s/xoZzhbVeNl
 kQ37/6268sjquN5KN97aZ2fkXiv9n8bIcI5pYm598/2l1192Hw5+kPu9cJ3sMkGhvqcdt5nldEt
 NOAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Add a simple cleanup helper for nsproxy.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 include/linux/nsproxy.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/nsproxy.h b/include/linux/nsproxy.h
index 5601d14e2886..e6bec522b139 100644
--- a/include/linux/nsproxy.h
+++ b/include/linux/nsproxy.h
@@ -112,4 +112,6 @@ static inline void get_nsproxy(struct nsproxy *ns)
 	refcount_inc(&ns->count);
 }
 
+DEFINE_FREE(put_nsproxy, struct nsproxy *, if (_T) put_nsproxy(_T))
+
 #endif

-- 
2.43.0


