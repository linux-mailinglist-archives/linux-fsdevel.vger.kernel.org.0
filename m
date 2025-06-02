Return-Path: <linux-fsdevel+bounces-50332-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D4500ACB08F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Jun 2025 16:07:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7ED29481A7B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Jun 2025 14:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 356A41E3772;
	Mon,  2 Jun 2025 14:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rinaoyqr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81546221734;
	Mon,  2 Jun 2025 14:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748872946; cv=none; b=rBQd3Nc+lVn/dQK9sAqEpxIg/QklUHhHdh8VyGNCiBG3lPp1kTa3hSt+zUceXgkQvj0ucA/HvHXeY8Qj6xnP42seH6JfnzILsZCnafOBI0u8YZjRsq5CSJQjRs7YVIV6LcdQAGV6LXT6eJ1S3tn/4FO6TiHQmDspDCtZpl+xTfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748872946; c=relaxed/simple;
	bh=wKewAHiWEOFgW1QoZgyrA6fB86FGLbmTYq4l0Dsqejg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hML5CqhT74deZF352JZ9wr7Up9tBJdQJD8HA3NzU+R7N8OhbkarXZX3hMnvhu3285aqt6Ky9+RvI7A0d/JPayELL0eYeI6LgFBvIzM8OCBfDQsm4b0CBgJ+bYJ5iHTZq4JnSpUIQHkqP8MzBiU/MorXRjnpwXpLd9q1jQZEuFpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rinaoyqr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B600C4CEEB;
	Mon,  2 Jun 2025 14:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748872946;
	bh=wKewAHiWEOFgW1QoZgyrA6fB86FGLbmTYq4l0Dsqejg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Rinaoyqr8dFUIHU+2oX/+zGLFrjFCxSPXPRpA0opXWxf8xD19TnKgfawdWspMbWVJ
	 BiiZaeFd5Q1bg9qv9lSizor7M+SPMmB28dt2j11gElaTZvJweT9Njhgmmd8qXSBaPD
	 x/7JK1TpYdzffDtuUU0iZAZ4QDMIM5pLLNbFfBUZE7iLba7rOKHXBNtmrlE+9CjXcO
	 UaPzLbh5TNF2FEklEEhZIKzzW7ybmf6cBM7skYIypi7Szh0iSIvqrAyrRSSw00G/Qg
	 Qnt8bnwYHTlJnrie08MT0wYaQwxY5S0gZ4dr4r77cieFar25Qwo/AIxE5/Coii5Zmg
	 /mvYe8Jk0+y7A==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 02 Jun 2025 10:01:45 -0400
Subject: [PATCH RFC v2 02/28] filelock: add a lm_may_setlease lease_manager
 callback
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250602-dir-deleg-v2-2-a7919700de86@kernel.org>
References: <20250602-dir-deleg-v2-0-a7919700de86@kernel.org>
In-Reply-To: <20250602-dir-deleg-v2-0-a7919700de86@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Chuck Lever <chuck.lever@oracle.com>, 
 Alexander Aring <alex.aring@gmail.com>, 
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Steve French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.com>, 
 Ronnie Sahlberg <ronniesahlberg@gmail.com>, 
 Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, 
 Bharath SM <bharathsm@microsoft.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Jonathan Corbet <corbet@lwn.net>, Amir Goldstein <amir73il@gmail.com>, 
 Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, 
 samba-technical@lists.samba.org, linux-doc@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2064; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=wKewAHiWEOFgW1QoZgyrA6fB86FGLbmTYq4l0Dsqejg=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBoPa7kN5gi6pOdlRySs6JiHUrX2MqFH9UXBVhMR
 ohl4xsXruaJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaD2u5AAKCRAADmhBGVaC
 FbSxD/sExPaSZIy1Y7QararXr9H5CHtdKGclmI8nbRacdoCige095AhYGj+5qnQdgKtUm9n+TFw
 sT84eYzC5Y9J2olo5RGVR54QmUGiOFNcHp8pfCbuCCCTKpFc3xl0tpf6BzTaEvy+hFF2EauiSNM
 dP0iKMcTCuNWMzKl3pfLlBLHfHHWHFTeflKlTSlBi2OXpx8ljgldHWsjzUCqel+Ia/kp0PT+fIX
 SteUln8fh9gDv2apF0+cQTv6UuqLrOXUCEpcgI+YWAOXqShD0luQspQhP8J6arEBQ5tweddRVw/
 JY72OYSuEYPnh3FxE4uNuZrsRdfs4uk6kwg2HX5XUUIdRXZR3zLVXz4rC3H+3zWYdPxENGHan0t
 E7o0OCzpqkysBnB5P5eWNYJ/me9zIc9tL6zakv3EA6TxCK+CuDn0bfoogDOplSzRapYQTt5M9EN
 djzgaDxBbHauKCpLBHa0wMgjsne9kbRpJmpYHiM3b96aPQeV+4tbyHRdUgCvOqfrE7ClGf5TApt
 FC86i8vomhc+388xTyYshqczJrRz26bGo1s7lplVVYXZt1vZg3iuT5OgA168Lj0tceXDjp/jvIX
 u3VjwYEXuq16cbRt+kn8fly4oS8+/dQR/Z9T8EwbYZ2ADZrOzD9yUcu2mjwd5RtEJp70By0qCo7
 2O4KwH3SpRDLl/Q==
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
index a35d033dcaf0b604b73395260562af08f7711c12..1985f38d326d938f58009e0880b45e588af6a422 100644
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
index c412ded9171ed781ebe9e8d2e0426dcd10793292..60c76c8fb4dfdcaaa2cfa3f41f0f26ffcb3db29f 100644
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
2.49.0


