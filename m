Return-Path: <linux-fsdevel+bounces-62620-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81061B9B2E5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 20:07:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3A587B2E6A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 18:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E38A31B108;
	Wed, 24 Sep 2025 18:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jbjx7fqG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF4931AF16;
	Wed, 24 Sep 2025 18:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758737181; cv=none; b=bsK32TxQrfpwvnkx70bJjy0YWy3y+jyTM9brZduuPhS7P34nzhm3zYbpNMqy2Pb8hgDd8Dz8nKOCqaMg3wlMOsPanByd/hD430L0g0c4TnWAaqna5ixbS4B9YDF1uSkkka3L9HC3abpOY6szTfivY8+5r0tegBpsYe1b6P8a6N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758737181; c=relaxed/simple;
	bh=gJ71P2Ndrgc2ekVPFHRBCfWRSuP8jsp0vzmTbzvjAZs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eORKQpf5XL2tHTMrHgKfOtT/XeHBGrFil+UIVchBxSnBFTaYKA50Wgb03euRPkDWArYzf4hRHf6GnOxdXcwMQC4zWSV1egRvAPpSUtfTVyEUiOBEQ0mweT1OfulgBzp87cl+mmSrgulKPJyNRxBv/bRy/3Jb8pj7D1+afixIWrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jbjx7fqG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09CF8C4CEF0;
	Wed, 24 Sep 2025 18:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758737181;
	bh=gJ71P2Ndrgc2ekVPFHRBCfWRSuP8jsp0vzmTbzvjAZs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Jbjx7fqGeSEdmEp+e0Zq2m6RJ7O3uvUmAp9trk4gJvM4ObPV8G8uvBO0rGQiaG7Wk
	 zwAltxUQVemxCHQEPcvYnfdOSAlFxnzGh1oDOXWK3EGwHdg3oCaX3foH6TrQ7p+ZyE
	 eA9U4IqxD6qrtLz+5v8qVDSPAJjhiCS/+npFWsUKfPo+lxAqgW6NiZ6pUgDwZ8tHYa
	 +eSQ240qEQx/IaKKmH+rycWTlB7wsUIstygRdyEXToXQ9KD016WziR8NW2+ROAM0rk
	 fWJAv0bB1UP4lEgafjIWdqLSsC4vTbQtv7qV3gyvbndPHepxFPYV8LtLUZ5vglLkBe
	 E0fUMOQxNBvkQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 24 Sep 2025 14:05:48 -0400
Subject: [PATCH v3 02/38] filelock: add a lm_may_setlease lease_manager
 callback
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250924-dir-deleg-v3-2-9f3af8bc5c40@kernel.org>
References: <20250924-dir-deleg-v3-0-9f3af8bc5c40@kernel.org>
In-Reply-To: <20250924-dir-deleg-v3-0-9f3af8bc5c40@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Chuck Lever <chuck.lever@oracle.com>, 
 Alexander Aring <alex.aring@gmail.com>, 
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Steve French <sfrench@samba.org>, 
 Ronnie Sahlberg <ronniesahlberg@gmail.com>, 
 Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, 
 Bharath SM <bharathsm@microsoft.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Jonathan Corbet <corbet@lwn.net>, Amir Goldstein <amir73il@gmail.com>, 
 Miklos Szeredi <miklos@szeredi.hu>, Paulo Alcantara <pc@manguebit.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 David Howells <dhowells@redhat.com>, Tyler Hicks <code@tyhicks.com>, 
 Namjae Jeon <linkinjeon@kernel.org>, Steve French <smfrench@gmail.com>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 Carlos Maiolino <cem@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Paulo Alcantara <pc@manguebit.org>
Cc: Rick Macklem <rick.macklem@gmail.com>, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org, 
 linux-cifs@vger.kernel.org, samba-technical@lists.samba.org, 
 linux-doc@vger.kernel.org, netfs@lists.linux.dev, ecryptfs@vger.kernel.org, 
 linux-unionfs@vger.kernel.org, linux-xfs@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2064; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=gJ71P2Ndrgc2ekVPFHRBCfWRSuP8jsp0vzmTbzvjAZs=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBo1DMKNZTMW45fstBiavM4W9QXz8s+EZV9PP5jB
 ckP/aQ8zVyJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaNQzCgAKCRAADmhBGVaC
 FXolEAC3VDz9eIgnACWFQDXfgOfJJYQ+1QO5TvMDfYEcNmFXpzctzDceBhBcXuLvvCKg5JUlH9M
 wTqZjLKOmJ1sP9LCJ2Vwf3I+QTHYVC2218G1FsOeKvJaKNa+fwB9SX4ZiNvyrAgtWGSes0/PGOT
 4eSygbDZFclr6WnxP7wsIP5hqUi3Ammvli/6ikprG7ZEs4jDnH3ZDW193yPrBzBgH+NlW7Udkmw
 D88dl9R1FPYj9hSz16bz9eX/XwY9AXu7fTf5J0gA2DQwFEcQGiu6Clm2bM+nDuwiwCoU+8TWxYk
 qZFXU/uIKbXZF8PdseERRyG6UMR9yfeYFz1WUPzYI5y98bPCn50L/CvDcxA34ra3o6SYp+5FjLk
 BHvsVfyHFQ3UQBYdwaP4ZR3EcVBc5c5LGXKGg5ry0WnA2WrefW5l0rQZAsHj7UKl2znnDANJ71p
 1bZu858+8USIT7XdRafZLMkFonJuI17R3EinoSQW7UWSpggJ3MPgENF+TVVTFl+J2QEnsZrz98/
 AwOZp+NYEvh8RgIuc37ODmM+WoaV9TfC5FAKFIH864OQY6nAGPcFX5/Jr3Ck1A8Nv/efKKJboV8
 +36ZlRXJw6aOajGVvoVhS8Y60eEpck66tr0dqPVQ47Gm7Z9NX3CCuNaueB2ShHT4e91so3fXZWd
 MH0LUewZI/vKGmQ==
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
index edf34b9859a16c34dd75ce4d1a6a412dd426c875..8bd0faa384a9bdb0ef0ff40ba7269aed72439739 100644
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


