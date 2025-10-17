Return-Path: <linux-fsdevel+bounces-64485-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 29E12BE863A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Oct 2025 13:36:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8163A1AA149A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Oct 2025 11:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D46F132ABEB;
	Fri, 17 Oct 2025 11:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tWYRf1xd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C0432ABCC;
	Fri, 17 Oct 2025 11:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760700770; cv=none; b=DYBXmqjtu+9doA7p7VTKatp4wK1PPAQo4lLEttgHgRjSluXvfHdicRK3ZlnKUBUBPFq6XPQwtQlrpcY4QXrnB/Pdp/jojDsoVzmj2u+Axr83c+QnIXku2qBEllvtDXcc0cb79r5OGX324shVB4gkWIehsjQj546BVx7BYFV0PBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760700770; c=relaxed/simple;
	bh=7ouSDOosTIdDvDzwqKZGyunTEJL8TukNeDPruKgCx+g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SWK6uxm/brIBOWwWjqkniNGmqVDi+xnWnaNFZDjVzLjFrXNtycH3suNw0MLYBx0xTaYgYfB0s9B5C3BQAxo6re1krEfesCdXH36atO/d8oQEvVL6ANjNoXVQWJjfktBovyCTisghW1viN99MhTGdgqeHS+9SGm2M78V7fd8udMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tWYRf1xd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71D38C4CEFE;
	Fri, 17 Oct 2025 11:32:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760700769;
	bh=7ouSDOosTIdDvDzwqKZGyunTEJL8TukNeDPruKgCx+g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=tWYRf1xdniS2aZLqjrez6EYb1OUyyNOXtY98XbbPsKnUkloym5jiNW0RV76J2PtyA
	 Z9sJJ9M5n85E/yRx7jmUFYSOGC1LFBSk9BJYEzW7gYHyxPLFUM6X7kQhYwuX3hFKXY
	 fgKrRA69Y7ZLz9WgJAY/iAgrKzncmsarzaqvq0bALu9eHcj32NIN5sKY8UIeUNrluX
	 QKRNLQGIvUSn7ZtVueIwiy8chGWWmvhbGJSVVWZRwm/jPjesSphoUXMx+lBpL5maeq
	 1mBGw+wtgMEdaQKI4RLNY0tY3/GODnEL1MyAHc5GqUuFN/iYGF9hXQmC2MBHNOaU+j
	 CDW/+o8Hij+ug==
From: Jeff Layton <jlayton@kernel.org>
Date: Fri, 17 Oct 2025 07:32:00 -0400
Subject: [PATCH v2 08/11] filelock: lift the ban on directory leases in
 generic_setlease
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251017-dir-deleg-ro-v2-8-8c8f6dd23c8b@kernel.org>
References: <20251017-dir-deleg-ro-v2-0-8c8f6dd23c8b@kernel.org>
In-Reply-To: <20251017-dir-deleg-ro-v2-0-8c8f6dd23c8b@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Chuck Lever <chuck.lever@oracle.com>, 
 Alexander Aring <alex.aring@gmail.com>, 
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Steve French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.org>, 
 Ronnie Sahlberg <ronniesahlberg@gmail.com>, 
 Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, 
 Bharath SM <bharathsm@microsoft.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 David Howells <dhowells@redhat.com>, Tyler Hicks <code@tyhicks.com>, 
 NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>, 
 Dai Ngo <Dai.Ngo@oracle.com>, Amir Goldstein <amir73il@gmail.com>, 
 Namjae Jeon <linkinjeon@kernel.org>, Steve French <smfrench@gmail.com>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 Carlos Maiolino <cem@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, 
 samba-technical@lists.samba.org, netfs@lists.linux.dev, 
 ecryptfs@vger.kernel.org, linux-unionfs@vger.kernel.org, 
 linux-xfs@vger.kernel.org, netdev@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1169; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=7ouSDOosTIdDvDzwqKZGyunTEJL8TukNeDPruKgCx+g=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBo8ilC1nPcpTFPrRykGurmQp1c5BdVoOQ/LEtdf
 IZqVTJd7uiJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaPIpQgAKCRAADmhBGVaC
 Fdy5EACFvOjaDYYLSW+mtYsRPdC2EituaEEglgW74FPY7LgX+IgiwJZO3w3M6ljAdyoEZcbXMSr
 Sid7RI9EI65JUhL1TEyYX6L38fzLVY2c/uDSqMHl0TxyULZGSOpX35nkZ/J7FagdxE6HallPMQ6
 VVxdHBb/GS/qKBwpbj4+9fH3rGPXZkrezb2rTANQPibi7g7594Q3DPrkZn0JH4DsBPNSW7pC4PR
 PQvXi+pRLyx4CuFQrQMOfNG+2YlmhZmx+vaVVcbgxgGEqPUIxKKoQeHBRTn+exmystrLt7XhNal
 Fgman+ubmN45Otd4Tjiki+0PU45XDXcifcRmzMdkxcqHsqpx/khxYT5bYZGsyYILCrDsYgHTOSH
 wPGNIp5IzgvV1Bqhx9mIUoDr+xV8B+L5o0osOc5WOEg0Wv4VLuv67GGx6SUu7DKbeISCzmi1PHa
 EFvU8KW1WVdR4iSqXGadIIV1bpzXbRQU+PqwTjQyfR+6TSMo+HqOlS7XW6vlQqfsFfe7GRpm0Ax
 TQNBvSi8jGhKJW8ge9Dh6qARYbfjGCIiGBvkNqYUIZflWdw7voeQCCnkLObO/jtOgvdTCHH0B7+
 ccqRW9gg/2phfPDcHD7RyU1Oe1Ip1XAhVp5ILxf8kNBX1I5MMHmXVfRjswsVhN2jQU8IRHns2JW
 jvFcVJoU6mpE0uw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

With the addition of the try_break_lease calls in directory changing
operations, allow generic_setlease to hand them out.

Note that this also makes directory leases available to userland via
fcntl().

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/locks.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/locks.c b/fs/locks.c
index 0b16921fb52e602ea2e0c3de39d9d772af98ba7d..b137cab18d362130cda5d1f0cdf50ba7e9aa2e12 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -1929,14 +1929,19 @@ static int generic_delete_lease(struct file *filp, void *owner)
 int generic_setlease(struct file *filp, int arg, struct file_lease **flp,
 			void **priv)
 {
-	if (!S_ISREG(file_inode(filp)->i_mode))
+	struct inode *inode = file_inode(filp);
+
+	if (!S_ISREG(inode->i_mode) && !S_ISDIR(inode->i_mode))
 		return -EINVAL;
 
 	switch (arg) {
 	case F_UNLCK:
 		return generic_delete_lease(filp, *priv);
-	case F_RDLCK:
 	case F_WRLCK:
+		if (S_ISDIR(inode->i_mode))
+			return -EINVAL;
+		fallthrough;
+	case F_RDLCK:
 		if (!(*flp)->fl_lmops->lm_break) {
 			WARN_ON_ONCE(1);
 			return -ENOLCK;

-- 
2.51.0


