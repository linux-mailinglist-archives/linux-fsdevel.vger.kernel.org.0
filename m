Return-Path: <linux-fsdevel+bounces-14490-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CC4E87D19A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Mar 2024 17:54:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EE361C21D0D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Mar 2024 16:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91470524B1;
	Fri, 15 Mar 2024 16:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XEY+uGi+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E6050A60;
	Fri, 15 Mar 2024 16:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710521594; cv=none; b=WAK0p5056l7mOMei4iJMHxXLikWw1SkPDX3wQdD/OiPbwFWahqsY92FgkD9p1LnODhDwDk6RtXk8fmkVnGRdfMx7IzS8wo0FIHFvgv7W85G95wi6IYL/+279BPktkfYLXb1Sq2ZnbOyndC+4FA/e8cOQDLuY9N2m6mwwMWWT/Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710521594; c=relaxed/simple;
	bh=yoiNJ2WMy08Z/jmvwgFEmuwGurlE5zLX34Ydm7pIfCE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XjA6w0lbfsfCd44dASjqWF6unHW4GneHnPO/5doV+PJapFFZjTQuwOjh1N0+Ni5C5o/Lu3BrfGiJSh8wLzV7cr/Hw5FmyaEvI93O5WB+3EfQg0TofXjkhGE++5jPhrrj+P24cAo9IwZ1R8Mt0uyewGjhOHHPivcMfX4mXG1XhT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XEY+uGi+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75A6CC433A6;
	Fri, 15 Mar 2024 16:53:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710521593;
	bh=yoiNJ2WMy08Z/jmvwgFEmuwGurlE5zLX34Ydm7pIfCE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=XEY+uGi+XMfNO7Nb9q1mLl4Bfrs/QaMERD5P8XHgsE2J6AyHsA6licbS7dt+lLy2t
	 KM0eaSgrJ59Koop917ozXPgeF6uTMZEP918pHrzQLXSL03vEFVh51sClvgH6k0vOUR
	 2PeS5U7F2I05DTJA54hYL5sGQzW7yYX2yJ/tSVUNWroH4kRN0WOQqVTnxr9T6awvoe
	 nFgi9nhNxa+3XTCLMBpVJhoehe1rMjgiebXSozDVnZgwPQY6cCIct+aH7NlPcY6Upl
	 H7w6YxbygBaPaVf5PIgvj96wnZDBzV0HptW2ZGvonXw+4R4lbEEKC70h33YvkH5tM8
	 9/Fa/diGIy0lA==
From: Jeff Layton <jlayton@kernel.org>
Date: Fri, 15 Mar 2024 12:52:53 -0400
Subject: [PATCH RFC 02/24] filelock: add a lm_set_conflict lease_manager
 callback
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240315-dir-deleg-v1-2-a1d6209a3654@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1797; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=yoiNJ2WMy08Z/jmvwgFEmuwGurlE5zLX34Ydm7pIfCE=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBl9Hzs2+8zYCAzKB5/98GTlmhyG+aP5LQ4QlhAD
 oFPU5y3oqqJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZfR87AAKCRAADmhBGVaC
 FZYbD/9PgexRfP/oZyLnzXj1LQWbdWuafLMR1PrMfcQdA8nLyj3/XcZVj2tQW5hRtHbc1/GScMU
 yYZdODfDWam9emdF6YJ/+OhumYMhsUydbjCmkDn8q0AaXNW355kf+uqC5F+k+1fQlSMMykC1K2Z
 QEQnObzc18vZmuUlY4UeMotErRi+UVV2ZAZT+YAnIoK0o/r7sXEbwUdlzlz0BBV1wxCBEv5wGQX
 h/aNQk9ECgurxf0qnWemYcGZA4kbJenOXPHG3mpleUBOO/tMcKUyUWKZVfdd8khpEQFd5cdWqDk
 xX1W5Ez+Hg6MJhufoEvl0ulX62KFJIexDpJIh1ZpqgNe+RzEoXXx1DaZ2dRJ+fD4RFiSw8RDGzh
 7P02ZSdU95bgAICsLfo7ojqsfatE2cN40aDVw4/nui8+h+60jsLjYKirmVGJ60gI9WRw/I1VDMs
 9Hbv0fCP36t1OpGXXG//745DiBd8rrv0fmBSwFuy4/f1DBDywPZudFYUCaU9rl5FlDw4NFxEM3/
 2arcncljpxeoVmWuGp3VUg/B+82OWTDnbaxZfRQH7Sn4f4yzgTwvqIW8bk+lSmYcvdcvbbF9PDa
 i60bc0vUKjfjiCDeGSP8ou4pL/07m1Dyhlc6e/t4O4Kk/NrnxGN71aEYWCgqeU8EmnCYTCDjmrM
 XfcREeDkf4rMEBA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

The NFSv4.1 protocol adds support for directory delegations, but it
specifies that if you already have a delegation and try to request a new
one on the same filehandle, the server must reply that the delegation is
unavailable.

Add a new lease_manager callback to allow the lease manager (nfsd in
this case) to impose extra checks when performing a setlease.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/locks.c               |  5 +++++
 include/linux/filelock.h | 10 ++++++++++
 2 files changed, 15 insertions(+)

diff --git a/fs/locks.c b/fs/locks.c
index cb4b35d26162..415cca8e9565 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -1822,6 +1822,11 @@ generic_add_lease(struct file *filp, int arg, struct file_lease **flp, void **pr
 			continue;
 		}
 
+		/* Allow the lease manager to veto the setlease */
+		if (lease->fl_lmops->lm_set_conflict &&
+		    lease->fl_lmops->lm_set_conflict(lease, fl))
+			goto out;
+
 		/*
 		 * No exclusive leases if someone else has a lease on
 		 * this file:
diff --git a/include/linux/filelock.h b/include/linux/filelock.h
index daee999d05f3..c5fc768087df 100644
--- a/include/linux/filelock.h
+++ b/include/linux/filelock.h
@@ -49,6 +49,16 @@ struct lease_manager_operations {
 	int (*lm_change)(struct file_lease *, int, struct list_head *);
 	void (*lm_setup)(struct file_lease *, void **);
 	bool (*lm_breaker_owns_lease)(struct file_lease *);
+
+	/**
+	 * lm_set_conflict - extra conditions for setlease
+	 * @new: new file_lease being set
+	 * @old: old (extant) file_lease
+	 *
+	 * This allows the lease manager to add extra conditions when
+	 * setting a lease.
+	 */
+	bool (*lm_set_conflict)(struct file_lease *new, struct file_lease *old);
 };
 
 struct lock_manager {

-- 
2.44.0


