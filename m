Return-Path: <linux-fsdevel+bounces-29009-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 609F4972FCC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Sep 2024 11:55:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1CA9B28353
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Sep 2024 09:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8B0418C021;
	Tue, 10 Sep 2024 09:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tG1S8I0G"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B97813AD09;
	Tue, 10 Sep 2024 09:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725962070; cv=none; b=EfVcXsc92pNYm9F5mtYoTNhC6GkXXNJb4LDdIJ/ZOcKE4o6NKls2I5zbMCPv0iKRQ1Ep4lBStorRckHDm4Rh+ZYG1thziyq8tLWEnPWPhfOaLnTTomSH2w30BpeExoENp2kj/Y9zP5XO4bJTBLnWGdG56VyoVIkQNlRrWzs9r9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725962070; c=relaxed/simple;
	bh=275ct4EYOnTW30H/G/Z5IJpK46v7KMEYsYtplV0pPWw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kAy7ACgDNOaB7OmecD8PdDp++2RKZo5KWSuCZmXJXUAKSwDzG8e1Xd0NYgRNePB2jGGREnDScQN7X1Qa54rn98odpRQZJgA9NRbQU38W//CtD7Ks4BYSAzLDZ3eKR253Nz87fFV4ZbYBKkxPu6jcceV3gbMzKu7O9Kg3iLIPZY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tG1S8I0G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30532C4CEC3;
	Tue, 10 Sep 2024 09:54:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725962069;
	bh=275ct4EYOnTW30H/G/Z5IJpK46v7KMEYsYtplV0pPWw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tG1S8I0GNZUycaJkKjwSytfvbd/MzgkSDdtgUHGthn2LuVQ3dPa9aTtLePy0BGQkW
	 Yi8PUjkkaNRR17WO58SDSJpc06NqpyAp5SY19O4iKSEz2MbmShKQGQA7Ub1ttdtcoK
	 btgFJSuPP20qkTTm1GptfOgG5tORNzzt54HR9CXs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	David Howells <dhowells@redhat.com>,
	Jeff Layton <jlayton@kernel.org>,
	netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.10 257/375] cachefiles: Set the max subreq size for cache writes to MAX_RW_COUNT
Date: Tue, 10 Sep 2024 11:30:54 +0200
Message-ID: <20240910092631.194962558@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240910092622.245959861@linuxfoundation.org>
References: <20240910092622.245959861@linuxfoundation.org>
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

[ Upstream commit 51d37982bbac3ea0ca21b2797a9cb0044272b3aa ]

Set the maximum size of a subrequest that writes to cachefiles to be
MAX_RW_COUNT so that we don't overrun the maximum write we can make to the
backing filesystem.

Signed-off-by: David Howells <dhowells@redhat.com>
Link: https://lore.kernel.org/r/1599005.1721398742@warthog.procyon.org.uk
cc: Jeff Layton <jlayton@kernel.org>
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/cachefiles/io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/cachefiles/io.c b/fs/cachefiles/io.c
index e667dbcd20e8..a91acd03ee12 100644
--- a/fs/cachefiles/io.c
+++ b/fs/cachefiles/io.c
@@ -630,7 +630,7 @@ static void cachefiles_prepare_write_subreq(struct netfs_io_subrequest *subreq)
 
 	_enter("W=%x[%x] %llx", wreq->debug_id, subreq->debug_index, subreq->start);
 
-	subreq->max_len = ULONG_MAX;
+	subreq->max_len = MAX_RW_COUNT;
 	subreq->max_nr_segs = BIO_MAX_VECS;
 
 	if (!cachefiles_cres_file(cres)) {
-- 
2.43.0




