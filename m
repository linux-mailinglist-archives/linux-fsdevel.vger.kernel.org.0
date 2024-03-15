Return-Path: <linux-fsdevel+bounces-14497-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8353B87D1D4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Mar 2024 17:58:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B59151C21B99
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Mar 2024 16:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D0845A0FC;
	Fri, 15 Mar 2024 16:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q2RtZ7Pr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57AC059B75;
	Fri, 15 Mar 2024 16:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710521616; cv=none; b=HoJWz7RQmDSLX7gWWU7Xfm4RhuNHOOguZk0K0g6gs2vlzGbEJo/nwNzScl1RG7iW5A22RaWg/kuGj6yeZ8lxu+cIbWAbWh854Flkj25m6TYM8XHNguLGoa8ndZ4yt+OWAOlEc/ElzCNJN/ovguyS6+eXmfPfNddLqk32OrnYwAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710521616; c=relaxed/simple;
	bh=WHR8repRSXOg/bX4tw/xWusjAXs7tEvWrqZw+/zetag=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mwFGoQSnxzG70P4L7RrgX+PSLn3cyc/IRRR0kVrPqfH5CZf020qyZCVefv5xl8LWw8XXzwU6hQfbXttgVERLC3DcV+naMIDKPSjTK+1YNsGALhwmjzvqNSmnjgqHJvp/cgGyFC0zVQhvD5K9ND/5PjL9Cl7SNBw0sjVat2+jSFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q2RtZ7Pr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAFF4C43142;
	Fri, 15 Mar 2024 16:53:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710521615;
	bh=WHR8repRSXOg/bX4tw/xWusjAXs7tEvWrqZw+/zetag=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Q2RtZ7Prk5x46NfLwePZ9aGqyTpWzhnebOuRfvTCC1Nk2oq2qEwpTvJEHNcV2Olqh
	 HKgtEUJlgdg+pAlUjDp/jeK/oV5GHIbsboK5j1+IO/uak6O0mH+45mpJbrOQwDVXDp
	 9Z1dbmWimyEisRjGaQu9XcI+C/js7sqHesJU+ReRbFRXShJar1YJx2ofmFbooEd0WZ
	 DFPxB5Ilx83/bFS6LEs6qILgSXc07sn9FIBKEbtA7Ny8q25PqeRo3yAtjDUX7edTDP
	 +6B+uJPMM+x2Cy1yUiSY7pwwSNInRPgZwz4wCNSkkEnFILkoPL7Hd0+SKGaIrGnEW3
	 5w9VjKaywordw==
From: Jeff Layton <jlayton@kernel.org>
Date: Fri, 15 Mar 2024 12:53:00 -0400
Subject: [PATCH RFC 09/24] filelock: lift the ban on directory leases in
 generic_setlease
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240315-dir-deleg-v1-9-a1d6209a3654@kernel.org>
References: <20240315-dir-deleg-v1-0-a1d6209a3654@kernel.org>
In-Reply-To: <20240315-dir-deleg-v1-0-a1d6209a3654@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Chuck Lever <chuck.lever@oracle.com>, 
 Alexander Aring <alex.aring@gmail.com>, 
 Trond Myklebust <trond.myklebust@hammerspace.com>, 
 Anna Schumaker <anna@kernel.org>, Steve French <sfrench@samba.org>, 
 Paulo Alcantara <pc@manguebit.com>, 
 Ronnie Sahlberg <ronniesahlberg@gmail.com>, 
 Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 David Howells <dhowells@redhat.com>, Tyler Hicks <code@tyhicks.com>, 
 Neil Brown <neilb@suse.de>, Olga Kornievskaia <kolga@netapp.com>, 
 Dai Ngo <Dai.Ngo@oracle.com>, Miklos Szeredi <miklos@szeredi.hu>, 
 Amir Goldstein <amir73il@gmail.com>, Namjae Jeon <linkinjeon@kernel.org>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, 
 samba-technical@lists.samba.org, netfs@lists.linux.dev, 
 ecryptfs@vger.kernel.org, linux-unionfs@vger.kernel.org, 
 netdev@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=967; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=WHR8repRSXOg/bX4tw/xWusjAXs7tEvWrqZw+/zetag=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBl9HzthWUpDx8ETW9Fi2Al1/RV3U0tsuiy2ls5f
 mz6cruFq16JAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZfR87QAKCRAADmhBGVaC
 FRqVD/9y35me6HJkny+mAq1uSbH4iLg1wTF7OEDQUz7izYzLDq4+vCIKz9P7ZA4FrR3CyeaHI4Z
 FCK2EOqTo+3bdDJFVyKKpc7yAiuZ3VQoN88Je2aTVJv1Abpyip1Koo0Iq5r6CijI8s9UCmSR3wU
 w7cxBqTBPM2HA04visTag4kLfaNYdwMty7AFZHIo3m8/4dXvMeojFHuorohuWKyLhyJIclJPdk2
 mqwUWptrN64t0cpP+qAy8DQdIcxd3kZNsuHasFk392Jw5kJrtu8hRx7/zGwlhR6sFpn+1Z0G5dr
 UXr9KHoVBdsuhwco4rKKltWANpY/qVwTPc+vOXjdb/LtLFRVqC3AVtbYzJuIrqlxryL/BaOlZFN
 NBO220wtzimaryQEdVInXs2fjNnKqbeCEWDsBAoz2wufknoFSsKM5dsUbuHtFW6jAHqSf+/koqn
 TZkALB5y6OggwTItwKY4pIy9/HoNITIt4OPnXmEfwmwA1bIpWXl2NRYV+FrExxCgKRi9nEVsnhp
 qQIcln7xiClGCxIImqasdwPJKvoR8goLsWdPQypbcwFheoCQ671aPQWnvrXF2nCVv+YwevDCk2N
 WLP3Fr4KOjLbxtAh72fSENFF59r/I9qb0eewGzsq8bnPaQ3t+HAaeyxUnmHmlX21xIfBNjqX6WN
 Oq7PC96G/sM9/lQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

With the addition of the try_break_lease calls in directory changing
operations, allow generic_setlease to hand them out.

Note that this also makes directory leases available to userland via
fcntl(). I don't see a real reason to prevent userland from acquiring
one, but we could reinstate the prohibition if that's preferable.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/locks.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/locks.c b/fs/locks.c
index 415cca8e9565..ba6b6f9ea4c7 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -1930,7 +1930,9 @@ static int generic_delete_lease(struct file *filp, void *owner)
 int generic_setlease(struct file *filp, int arg, struct file_lease **flp,
 			void **priv)
 {
-	if (!S_ISREG(file_inode(filp)->i_mode))
+	struct inode *inode = file_inode(filp);
+
+	if (!S_ISREG(inode->i_mode) && !S_ISDIR(inode->i_mode))
 		return -EINVAL;
 
 	switch (arg) {

-- 
2.44.0


