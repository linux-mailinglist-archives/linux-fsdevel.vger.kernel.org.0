Return-Path: <linux-fsdevel+bounces-61047-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37C65B54BAA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 13:54:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEC943AD55C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 11:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFE49304BA4;
	Fri, 12 Sep 2025 11:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H6954NFM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4CD4301017;
	Fri, 12 Sep 2025 11:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757677993; cv=none; b=BwFQCY/mrQ6YAG2NNcTnQ54SE7Tx9KAb615MYRC6vWUI4G3xzLbRaAfPrBVh16cJjR9iMqLfgDOfy7S1FxYFlnLuMrYJ7dlX4m0Bh7GZL6lo5JUhrJAWfK4njmnLxnkg6f/bmN2i+Rh3GPBfEFbGBrjA4k6YTcrj9J4bdgGlIBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757677993; c=relaxed/simple;
	bh=dB8JeqgZlxeqdfwSvyMCLjmPJU8EjTQ2GX3xZAtJY+Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EMmQNggyj5/v3qQ6+9UNv3b5gXsQtBmp5/fijT3y/I/A5c3g+DFewoLVoGERDGLr4EYvHNt8pZ9xON/vedwZJzpDXXcKHAETjO/sv+mWXZES089J7WEduin5xmA40KTn4T8BFruA24P8VO6gqK6bWv9eO/66+5JEnXuS1hjO3DE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H6954NFM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED30CC4CEF1;
	Fri, 12 Sep 2025 11:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757677991;
	bh=dB8JeqgZlxeqdfwSvyMCLjmPJU8EjTQ2GX3xZAtJY+Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=H6954NFMTPTrDgYqc7arNoeM2+enH75CEOBfvn19ZnwQdAdvOmz6qG07JJ8ElbMfk
	 PWknE2Qe0+SkRgYTLM0765TEIyZ2YKleMzyNFs+F8ELvGCO+k843/QPmi1EQkwhiyk
	 GQxZJkEsCAaz0vcU0qKqSW2WeShn6oAc2TLG2n+40p5reL4vFwNCNXRnFKOhJlF47Z
	 n+0X0z/vseZsusct+BRcOEXvffKcEp75iwsaBmNFOejHB9y/cPNA4oai/gB/CStYsz
	 6OaxegRSkTJX7KuEKvzAK304AAkFFIjLrIyzJugy372Py4ziCSoLeudqaKol1tWJck
	 w0fFC918N7Y8A==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 12 Sep 2025 13:52:25 +0200
Subject: [PATCH v2 02/33] nsfs: drop tautological ioctl() check
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250912-work-namespace-v2-2-1a247645cef5@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=593; i=brauner@kernel.org;
 h=from:subject:message-id; bh=dB8JeqgZlxeqdfwSvyMCLjmPJU8EjTQ2GX3xZAtJY+Q=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQc4ZzCYh0hcL/0+1NumcLpB6+LpHR1u7w4FpZ1jG2i6
 Gy7Tar+HaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABPJe87wV/Sl5MWJR1pvLsrP
 z16yUSeRYSa79s7Tf6pPT7DmKlwXUczwP+Z8dK1dBNvDAzpH4rgtoyd8WTex9tFE7QiJWyt+2Qc
 vYQAA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

This check does absolutely nothing. So drop it.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/nsfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nsfs.c b/fs/nsfs.c
index 59aa801347a7..ce51041bb624 100644
--- a/fs/nsfs.c
+++ b/fs/nsfs.c
@@ -163,7 +163,7 @@ static bool nsfs_ioctl_valid(unsigned int cmd)
 	case NS_GET_TGID_FROM_PIDNS:
 	case NS_GET_PID_IN_PIDNS:
 	case NS_GET_TGID_IN_PIDNS:
-		return (_IOC_TYPE(cmd) == _IOC_TYPE(cmd));
+		return true;
 	}
 
 	/* Extensible ioctls require some extra handling. */

-- 
2.47.3


