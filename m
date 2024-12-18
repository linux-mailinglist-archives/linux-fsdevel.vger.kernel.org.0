Return-Path: <linux-fsdevel+bounces-37750-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 878B99F6D88
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2024 19:44:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D132B166A5B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2024 18:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E8FB1FBC94;
	Wed, 18 Dec 2024 18:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EBPgIgyc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD2E01F0E21;
	Wed, 18 Dec 2024 18:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734547436; cv=none; b=j7XF+qgaeEsyE67HXgThJ2mRzdCQlLccWKmhm+YkMauGlkDQvNoRwa53/yGXxuzKdrhXrkE3xclrqlmvKvpTqGxiKIZMJYPnZQb95xw11Ed2Hwz1JkkzcqUZsyFmFDyMTTRlorE+S0cN2bLlPCMS2wyvn3M0nuSiNOAnq8PCz4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734547436; c=relaxed/simple;
	bh=G/38zKCX+XRXuN14AmwlS2jsKmtwl0zRI7NBXEZgl2k=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=oGDq8UfEY1Nzu4KiyW7rKr9FyDnm+indaS46dLnEB/9EwIYEdqYanzWbabcFAPg5NX9CCK4Efd8s0go5WwdXEsXZJyitz8QDZMVms7mhbEJ7XYkoEvFszncefbfUZES3815xIMaIjw4qrgRJS4veRWCqiHb2lEyyrh8RmN9gvhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EBPgIgyc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A8D5C4CECD;
	Wed, 18 Dec 2024 18:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734547436;
	bh=G/38zKCX+XRXuN14AmwlS2jsKmtwl0zRI7NBXEZgl2k=;
	h=Date:From:To:Cc:Subject:Reply-To:From;
	b=EBPgIgycLcUumJFDmJ/VWz0AZI8IXdeDB8YkVjvMMkAkEnwII+7BojJZheQNnZcMA
	 91R0SrXOMIRWohd0N3Gt2lEV3+1wDpSYEa/Jq1PdLBRN70Iz5YZrNB+OB+gmABL18E
	 8bGuCIabZ5hJEk2yhc+3nLNbxvToDMNqwDRBOgVqO83QYz2C2UNh+2kkJj9DLKngpe
	 NQpL5h7WqURr5Nvu7WZs6cF6ILiJff0ToZWCswSlK978HRsq7d/2BsMqS82eUP1+P/
	 r+8eExKs4mPmSfmNv0I+XkPdgjkprVC3uz3G+DBWmpElCUvQs6q5R0fMlfWT/Pygio
	 NTunh20ad0ZSA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id C97A5CE079A; Wed, 18 Dec 2024 10:43:55 -0800 (PST)
Date: Wed, 18 Dec 2024 10:43:55 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: dhowells@redhat.com, jlayton@kernel.org
Cc: netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, sfr@canb.auug.org.au,
	linux-next@vger.kernel.org
Subject: [PATCH RFC netfs] Fix uninitialized variable in
 netfs_retry_read_subrequests()
Message-ID: <fb54084d-6d4e-4cda-8941-addc8c8898f5@paulmck-laptop>
Reply-To: paulmck@kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello!

This should actually be considered more of a bug report than a patch.

Clang 18.1.8 (but not GCC 11.5.0) complains that the "subreq" local
variable can be used uninitialized in netfs_retry_read_subrequests(),
just after the abandon_after label.  This function is unusual in having
three instances of this local variable.  The third and last one is clearly
erroneous because there is a branch out of the enclosing do-while loop
to the end of this function, and it looks like the intent is that the
code at the end of this function be using the same value of the "subreq"
local variable as is used within that do-while loop.

Therefore, take the obvious (if potentially quite misguided) approach
of removing the third declaration of "subreq", instead simply setting
it to NULL.

Not-yet-signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: David Howells <dhowells@redhat.com>
Cc: Jeff Layton <jlayton@kernel.org>
Cc: <netfs@lists.linux.dev>
Cc: <linux-fsdevel@vger.kernel.org>

diff --git a/fs/netfs/read_retry.c b/fs/netfs/read_retry.c
index 8ca0558570c14..eba684b408df1 100644
--- a/fs/netfs/read_retry.c
+++ b/fs/netfs/read_retry.c
@@ -72,12 +72,14 @@ static void netfs_retry_read_subrequests(struct netfs_io_request *rreq)
 	next = stream->subrequests.next;
 
 	do {
-		struct netfs_io_subrequest *subreq = NULL, *from, *to, *tmp;
+		struct netfs_io_subrequest *from, *to, *tmp;
 		struct iov_iter source;
 		unsigned long long start, len;
 		size_t part;
 		bool boundary = false;
 
+		subreq = NULL;
+
 		/* Go through the subreqs and find the next span of contiguous
 		 * buffer that we then rejig (cifs, for example, needs the
 		 * rsize renegotiating) and reissue.

