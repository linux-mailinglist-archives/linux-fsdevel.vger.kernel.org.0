Return-Path: <linux-fsdevel+bounces-64953-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 3184ABF75C1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 17:29:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AC138354B69
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 15:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B87453446BE;
	Tue, 21 Oct 2025 15:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="naoi75RH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D2334B419;
	Tue, 21 Oct 2025 15:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761060394; cv=none; b=k8Zcda55mpqCASaVrO3TOidY5N/7tB8JlI1N3hvg97R6eqIyKAW7So2IQBZpqNdzohaEZeRmxd06gpq/DSW5nA3gUFVfRwGoOHUEziMDYYBDUdzTRjDw2CykHFaTi1h+QpzISx4Ef5kBU1aINRcELBAhARz73JTjZJenrW2WSEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761060394; c=relaxed/simple;
	bh=3GlmIIbZmCr2QXgLwOVC+XsC0uT6drDrTKI/nBIEra8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TJlEi2UVN+bb2k9lPn84dX447w/bNk7L5PyOVQqY82JZFVZBjMHj6TR+SSAfl4XbzCSSV9EZRe+ynH/v/UeZ4TrhU2m06GwuARX5fqHizEWPrMX+qIvX39r3gJKGejI6iNLZuZo2WA9aCAWMTOCVd4Z1hU0QGWkn8mSSbgf29NI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=naoi75RH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5CFDC4CEF7;
	Tue, 21 Oct 2025 15:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761060392;
	bh=3GlmIIbZmCr2QXgLwOVC+XsC0uT6drDrTKI/nBIEra8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=naoi75RHkgNlTBKNN5hIFaDJDFFxqjQlXThRuRnIhe1jqLaC0g+83Tv7TyzU5wiRs
	 a11Pp5BRjOpQ8taTdhUOzbLRlhLebAQp5maVh4qGEjwqHwLFEkmOkeAENGiD3xYAmv
	 K2R8cTC8Td+voGi5qo1+1JvgepiRmNPbDwpS+nWW0HUgxLVynac5W6GAqBn4PkH/j0
	 HS0P390mcbl4VZYfk4IAOuBRJsLoTvBnWSBZ7Cpfi4yUdfSHn12wIDoB0+ssVu9emg
	 wM0geWPEAu0IkAzBTPIwCO6SQuYIBINoJ9lIQL5flbjhNfcW4UHKOBn1avbMhMAYLw
	 feH6F1hJwAHzw==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 21 Oct 2025 11:25:44 -0400
Subject: [PATCH v3 09/13] filelock: lift the ban on directory leases in
 generic_setlease
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251021-dir-deleg-ro-v3-9-a08b1cde9f4c@kernel.org>
References: <20251021-dir-deleg-ro-v3-0-a08b1cde9f4c@kernel.org>
In-Reply-To: <20251021-dir-deleg-ro-v3-0-a08b1cde9f4c@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1734; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=3GlmIIbZmCr2QXgLwOVC+XsC0uT6drDrTKI/nBIEra8=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBo96YFi4ys3PSq6TzdA5h4gvGtFYvqrbeEjvAAX
 lO4WmxTs2qJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaPemBQAKCRAADmhBGVaC
 FfoGD/4jaLSV8pLlgxtph3T3BATGjXMM9NbI6+Fgah+/VwDhhgYa21Y0g3UD1QfOfNGqCPRTUdi
 URMcGC+o4GTclMTHNX5CRquhW0c5eNEpv8drFyzotaX8phzHJiy0qG8rTYzggYBRbZRfXv38edg
 CffpzDE66YB9Uc2dnkrkBkWDUUmsFVw7k+Bzc0chpG0UuT9OpfdbEPfpWjtix/kidgAegdAXHFO
 JG1biEH4waBHBaz4VD/GnO1JAsy0BFNZT6dbfM1kRpTC3PvOjmaO1aimOMsiNYzjeiOxWVPa2sW
 AlP0LcLSpyoTu5rl6BO5zKMrrPtQ3AEU9EkAUhWh+T6iu7L0T7KbXHX7WFJx2nD0KidE49NSctc
 FSXSDFEUZ7W6RsNNB9qyOmRpPknswwJvu9agRM1hGH3jTQ9CF0rfxicLUXeI8Oyz6poJt1d/wCd
 ivsR4ugJeVY/s575prtQ9b/cpOK36DYDePkqRHM7EvBAAXZhiSc/CEjrXVdtxZLW4Fci3h4p774
 QFHhoA3lJhrQ13aH6JlneEYjnYEFIV5wzXkbTu6T9I9aetAcJYjpJomFycfpfsvevozeEuftzGX
 J4YztguQCH4FdahFPa6CN6YoJmwLwS/S7JdwU4rW/WyaFOpz06Bi7JH10ISNLGHSioRSUacyCWz
 ULQN5cZM6cwaQ9A==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

With the addition of the try_break_lease calls in directory changing
operations, allow generic_setlease to hand them out. Write leases on
directories are never allowed however, so continue to reject them.

For now, there is no API for requesting delegations from userland, so
ensure that userland is prevented from acquiring a lease on a directory.

Reviewed-by: NeilBrown <neil@brown.name>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/locks.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/fs/locks.c b/fs/locks.c
index 0b16921fb52e602ea2e0c3de39d9d772af98ba7d..b47552106769ec5a189babfe12518e34aa59c759 100644
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
@@ -2065,6 +2070,9 @@ static int do_fcntl_add_lease(unsigned int fd, struct file *filp, int arg)
  */
 int fcntl_setlease(unsigned int fd, struct file *filp, int arg)
 {
+	if (S_ISDIR(file_inode(filp)->i_mode))
+		return -EINVAL;
+
 	if (arg == F_UNLCK)
 		return vfs_setlease(filp, F_UNLCK, NULL, (void **)&filp);
 	return do_fcntl_add_lease(fd, filp, arg);

-- 
2.51.0


