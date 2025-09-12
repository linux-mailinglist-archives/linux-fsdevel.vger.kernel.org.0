Return-Path: <linux-fsdevel+bounces-61061-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35B0DB54C23
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 14:02:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71883AA31E8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 11:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2AF2305068;
	Fri, 12 Sep 2025 11:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YsRPtUhy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C4D305078;
	Fri, 12 Sep 2025 11:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757678073; cv=none; b=VuTLFEJbuG9uHfP1ngnCsWCw1r3fUrvcK9Zps3BvQGECxCItwPMNVgvLD5XC/Ef5lHCa/6RsLnA6eNOi3YIhFxUMii2nJpKss0CBS9inM6MieqGmN2DE+Jy6jh5YIuCasMGEQyJH/Vazqc1DUb0qqEIqTM3bWeKpOTjKKyfMjpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757678073; c=relaxed/simple;
	bh=YSCVmGJmUnrKOCdtbwDXFKxlK+chnFp/neISzIy5w8s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kmyW3vaw2asoKzaa4/lRA8qTOlOzq1m8CkgcoyoZDyBwxOQCFz7XSQ2cPUBG8Lqsu43P/P59gW72GUv2T+zTCzzqSk7/lRnAnq+77Fg3HplffwU2BKN22k53uL0WOp2dQ3+78Gt8gmposg0+7MTdR7R1x67uzlC4KmONX59cTac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YsRPtUhy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98481C4CEF1;
	Fri, 12 Sep 2025 11:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757678073;
	bh=YSCVmGJmUnrKOCdtbwDXFKxlK+chnFp/neISzIy5w8s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=YsRPtUhyGoxyPtk8EjZJkH+3lLFw7rRJVqak0Yip+qkpXqGhFPkRaFiWaKlGjnKN1
	 MoxfZ205a0EbRVXfsy+eAznUAsXJt/ZCOmuvGdjb9B5i4+oSqfuTAuHweUIi4L4Mc/
	 5i9An9mCaCRhaloE7C+YUrUhzTb3/T18SVuBeYra7pvKOmDo8Me49BE/BbF/gNi6bT
	 lufdJQ7vPLu8ZmP+Yh1oKaUz/ED9Q2s+Bg8Pj73P/XvCPaqrQ95RUCzyH309hj/v4R
	 bBgx3ItVxRdcw5Zu+mWBWrsgRHUcLz3Tlf2rvs+poiReAK4u2H6YbFLkXy/7gdb2lN
	 8ZS4I6L89VftA==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 12 Sep 2025 13:52:39 +0200
Subject: [PATCH v2 16/33] ns: remove ns_alloc_inum()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250912-work-namespace-v2-16-1a247645cef5@kernel.org>
References: <20250912-work-namespace-v2-0-1a247645cef5@kernel.org>
In-Reply-To: <20250912-work-namespace-v2-0-1a247645cef5@kernel.org>
To: Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>, 
 linux-fsdevel@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>, Jeff Layton <jlayton@kernel.org>, 
 Mike Yuan <me@yhndnzj.com>, 
 =?utf-8?q?Zbigniew_J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, 
 Lennart Poettering <mzxreary@0pointer.de>, 
 Daan De Meyer <daan.j.demeyer@gmail.com>, Aleksa Sarai <cyphar@cyphar.com>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>, 
 Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
 =?utf-8?q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
 netdev@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.14.3-dev-385fa
X-Developer-Signature: v=1; a=openpgp-sha256; l=749; i=brauner@kernel.org;
 h=from:subject:message-id; bh=YSCVmGJmUnrKOCdtbwDXFKxlK+chnFp/neISzIy5w8s=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQc4ZzKwTxv8Ze02xZyylfLXbRU88XOCSfN1dbb7JEw/
 +mH70fSO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACZSvYORoe1O66dNO11zUz82
 Z+y5NUlRY+f+FyV3ckS3sL1skF2nIsfIcPXKjKkzLpaubFivXrNl1ioWjz+nXa++f39l77+QIxk
 H9zIDAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

It's now unused.

Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 include/linux/proc_ns.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/include/linux/proc_ns.h b/include/linux/proc_ns.h
index dbb119bda097..e50d312f9fee 100644
--- a/include/linux/proc_ns.h
+++ b/include/linux/proc_ns.h
@@ -66,12 +66,6 @@ static inline void proc_free_inum(unsigned int inum) {}
 
 #endif /* CONFIG_PROC_FS */
 
-static inline int ns_alloc_inum(struct ns_common *ns)
-{
-	WRITE_ONCE(ns->stashed, NULL);
-	return proc_alloc_inum(&ns->inum);
-}
-
 static inline int ns_common_init(struct ns_common *ns,
 				 const struct proc_ns_operations *ops,
 				 bool alloc_inum)

-- 
2.47.3


