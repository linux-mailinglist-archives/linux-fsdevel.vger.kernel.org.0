Return-Path: <linux-fsdevel+bounces-63974-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 568EABD3C54
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 16:58:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7F5C94F6899
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 14:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E69030B536;
	Mon, 13 Oct 2025 14:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aALhBCMl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EBB4277814;
	Mon, 13 Oct 2025 14:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760366903; cv=none; b=aAOe9YJYbzPPrC88jKyCB++fqeCPpWSv2vu2NW+xwYziwl6mwFm0YnxBoN7X1w4DCELL4f3g/w0izPTi9G4//TVlHOAWoOZdClBGTJa/ttKNwe8grp6wI9HYUtKOwjtTtYsGZAB5d7cY55FhADozpmjvH1PsVtU0AOO5oRSA8LM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760366903; c=relaxed/simple;
	bh=L1cRKq/J9sZ0cHXdekt5M9BmYyPxtAAJ9huQwBAlljg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TxlMwL5cpyYe2FkJkvRbKnP2GBWjXftsv3WoE84PSV8IDSoRTwb7IVwlbeKxwhifQZ+AbSbpZE9eiOqB3yqbjngshdAlXgz5hobW5+lw5tsUoQn4VqvJu1t6Gx8cARRb1bOY+uKYNNVHvbaL17z4kAvwKiAwBnVg7U8FFC4V8y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aALhBCMl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7125C16AAE;
	Mon, 13 Oct 2025 14:48:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760366903;
	bh=L1cRKq/J9sZ0cHXdekt5M9BmYyPxtAAJ9huQwBAlljg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=aALhBCMlQeXPYHet4p+jeb95LLHKeZPo28uRVsfMa/EhyV/mGoP4xCDIx0IVe7YBq
	 r9xDmlplt5ucXnF8yNdjyYA14uBBuJLDggsAU6EUe/FhzHQ/Qeoonb1BOnQ/rpkz+k
	 oqWhLLEUWM3MDE6V96ldARilozhdZV3NB1k/y7EptDzoAouUn1DBQNf+GBdEaFU97B
	 CkfyDIi57uKCXV6F1nd8El0EhZBinw6XeNwUrQx8TgAXpYSseDifogjaVNMJ3d4EzU
	 GBZbk5J1AIpPmV8GO8hIBPInpJEV7BkJsq0qBFyaWHIJhR7di0zeam184S9cRFqp45
	 EysbA08YNArOA==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 13 Oct 2025 10:48:00 -0400
Subject: [PATCH 02/13] filelock: add a lm_may_setlease lease_manager
 callback
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251013-dir-deleg-ro-v1-2-406780a70e5e@kernel.org>
References: <20251013-dir-deleg-ro-v1-0-406780a70e5e@kernel.org>
In-Reply-To: <20251013-dir-deleg-ro-v1-0-406780a70e5e@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2064; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=L1cRKq/J9sZ0cHXdekt5M9BmYyPxtAAJ9huQwBAlljg=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBo7REqXJ08OU3We/ayZDYk00ILSS/LnyQxvwsph
 gh59BEZ3quJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaO0RKgAKCRAADmhBGVaC
 FZenEADMnVlzNqtp8ZFzEmImAHdpCTxML8l4s7ZVfvrqGrIXdyBDHvGcQrfTT/EVA7NWqyYrawY
 6pZTm/N1JEGewWTHt8ZSvHo5yCQKAVUC5NQURhZEkP9xyRiRU/UQIXRtA/PqIOYUwEtuSt8PzgS
 L4ntpb5GLZbgNsN7UODui4vg8vBoOpNYAacYULYiL5V32vNiCtNhav32EQ1M0aImIUaADrh5S52
 hoy6TPBDYzOYewZKh8OwNCPJEUs73oKOkLaEiZNraRm/4KXFE/vJwHs5OnAER4Jy94te7xcfuUG
 O29By832KUnDq40pzhwbexXFugjKykM9tCJiE6YK14GZ6UtUd1YGqzlKy/GDaPBKFvpt6Z4DLNV
 Aaw2HXKS2+A4ju85+Hz6jQeYFxKSLBwvWPG5zQnU1SlmEdCQ50aNiTY2lpGaz+jzAksHrwAL0XD
 IahcMWqxAeFdSGAo7D8HEWktdH/oWU8cB11SQ+LrBKQyDF04reU+9MrSjCy+Fa5C9ZEEJjBVCGQ
 pw2qGW6SR69ToXJnnj2/5l+euT0vR8nkeU3MGi9awn/Jb68UcDqGhprmPB5Aw+Qx2r+DP2EMRvF
 IFNEwZ6DzAOzKvwiU3VJ/tQpVmsOz/KcaJceMjEjPIMmur849Rde2ldsvdw7vxbAxcsl3By0lSi
 MfbBWmvJHSFYXuQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

The NFSv4.1 protocol adds support for directory delegations, but it
specifies that if you already have a delegation and try to request a new
one on the same filehandle, the server must reply that the delegation is
unavailable.

Add a new lease manager callback to allow the lease manager (nfsd in
this case) to impose this extra check when performing a setlease.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/locks.c               |  5 +++++
 include/linux/filelock.h | 14 ++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/fs/locks.c b/fs/locks.c
index 0b16921fb52e602ea2e0c3de39d9d772af98ba7d..9e366b13674538dbf482ffdeee92fc717733ee20 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -1826,6 +1826,11 @@ generic_add_lease(struct file *filp, int arg, struct file_lease **flp, void **pr
 			continue;
 		}
 
+		/* Allow the lease manager to veto the setlease */
+		if (lease->fl_lmops->lm_may_setlease &&
+		    !lease->fl_lmops->lm_may_setlease(lease, fl))
+			goto out;
+
 		/*
 		 * No exclusive leases if someone else has a lease on
 		 * this file:
diff --git a/include/linux/filelock.h b/include/linux/filelock.h
index c2ce8ba05d068b451ecf8f513b7e532819a29944..70079beddf61aa32ef01f1114cf0cb3ffaf2131a 100644
--- a/include/linux/filelock.h
+++ b/include/linux/filelock.h
@@ -49,6 +49,20 @@ struct lease_manager_operations {
 	int (*lm_change)(struct file_lease *, int, struct list_head *);
 	void (*lm_setup)(struct file_lease *, void **);
 	bool (*lm_breaker_owns_lease)(struct file_lease *);
+
+	/**
+	 * lm_may_setlease - extra conditions for setlease
+	 * @new: new file_lease being set
+	 * @old: old (extant) file_lease
+	 *
+	 * This allows the lease manager to add extra conditions when
+	 * setting a lease, based on the presence of an existing lease.
+	 *
+	 * Return values:
+	 *   %false: @new and @old conflict
+	 *   %true: No conflict detected
+	 */
+	bool (*lm_may_setlease)(struct file_lease *new, struct file_lease *old);
 };
 
 struct lock_manager {

-- 
2.51.0


