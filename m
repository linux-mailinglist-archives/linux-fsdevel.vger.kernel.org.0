Return-Path: <linux-fsdevel+bounces-30796-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9243598E532
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 23:32:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB73D1C21081
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 21:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1F68221E2B;
	Wed,  2 Oct 2024 21:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IRUjz9Pt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E87C2216A8;
	Wed,  2 Oct 2024 21:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727904479; cv=none; b=YzqgHD9/qXzZbTQLe+xNiiUVO6nOuJHDAhjg2TEQTyuoYb4MolW5yZ33i1Nfdp/ccrC97x9gLR+SxyX4xM5rXgfl/EO6e9iSfi5QR5mCepju1ujL+Zr8ub8784Y8w+9oKlba8TM4psdauWaXQSDIkWRtf9yRqEyA304nqODArR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727904479; c=relaxed/simple;
	bh=L8jPTqE/MEdr2Fk0QAaUZrk7fJPp2DBX4nFI13DAUpM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=g1Tpfetz7U47DHxJaAP3hZZ077UNKOsf9ehq6Q7M2QvpH8kQB1GAuw0NyA3OBMsCH5AuZE2sBClz2ezLFNuJSqE5daOd5R+36r4ajWQbjtxm4lwhcluU8JCMS8utcqjkxZfq41rgHexoG6/GPXtsYyghXU4bD6YMDlnkKnxJI44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IRUjz9Pt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53ECAC4CED8;
	Wed,  2 Oct 2024 21:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727904478;
	bh=L8jPTqE/MEdr2Fk0QAaUZrk7fJPp2DBX4nFI13DAUpM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=IRUjz9PtfkWUJi0e9T3IPCCoMESom7iKKJ3CLgq48OxKmXWJ5/EJvSKXnIrqyYPEy
	 cXYB9JoxiwOFWnbShCRYw+L9iXqXp5S4zliQGT+jN/yU8thuWASv7U7Bjhvz9EGmmY
	 HZlWksb1N48laxkgzaACcRF3LuZjruytZTUmrSpfwJaq8yY3L45la4hbhUzL5Ah6uF
	 VaXG+vGAJSrI/YGDgGYKh08C3Vw0bA212OWgDbBCgSBD5cH8kPXgryCalNn7Si1cCg
	 Dnf3IyUzLmz1xed8h41cSfmi79GmS28hKsMSkI0kkEbKETd5KxDP/1sMOPF8c1QCAs
	 uVAvAUbwCSgcA==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 02 Oct 2024 17:27:25 -0400
Subject: [PATCH v10 10/12] ext4: switch to multigrain timestamps
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241002-mgtime-v10-10-d1c4717f5284@kernel.org>
References: <20241002-mgtime-v10-0-d1c4717f5284@kernel.org>
In-Reply-To: <20241002-mgtime-v10-0-d1c4717f5284@kernel.org>
To: John Stultz <jstultz@google.com>, Thomas Gleixner <tglx@linutronix.de>, 
 Stephen Boyd <sboyd@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Jonathan Corbet <corbet@lwn.net>, Randy Dunlap <rdunlap@infradead.org>, 
 Chandan Babu R <chandan.babu@oracle.com>, 
 "Darrick J. Wong" <djwong@kernel.org>, Theodore Ts'o <tytso@mit.edu>, 
 Andreas Dilger <adilger.kernel@dilger.ca>, Chris Mason <clm@fb.com>, 
 Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, 
 Hugh Dickins <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
 Chuck Lever <chuck.lever@oracle.com>, 
 Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org, 
 linux-btrfs@vger.kernel.org, linux-nfs@vger.kernel.org, linux-mm@kvack.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1052; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=L8jPTqE/MEdr2Fk0QAaUZrk7fJPp2DBX4nFI13DAUpM=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBm/brAty56j/NgjClfQP+YgB3escq8CktdBFW2L
 wyBzPE0QpeJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZv26wAAKCRAADmhBGVaC
 Fa0aEADUq4geawXWbT0XKiWVNDe5HmCEhbMP2s1/8FXe/A/d6dLhUu7Fit4zb0KvCeOllM/wApx
 olJNRraOJVZhluYwJX2+A/BfzNrIuGKFiuZKLpkGaKHDg7fimaX1ks2NC8uUO6v/H+MdnvezKx9
 gJgvYbPPFJamQt4dC4+RerijvvEQXqyH0HLG49AFR1wty4o8scKEOh9I/tamgS2nUAy46SrtrR6
 B+1XmVEtAcemRl3vx8XR2uOGwnGXjQkvw5q2EZryLqOJWHkdmoKckir5tPLfypMc4K8dGev2LcJ
 gZEhdTe0QOMpFsJ3YrYPySffq9mPRIgNCePbgr4c8Devtb7WMalBfhydHOfRxIzRjC8zz87RNPZ
 7bSv0sZtCIwqdawRdMm6GN7iWgCjikImQMy+DBPfaqKkI730o5c+bLd4PZbDWKhm8gDD8hno5Qc
 WKqliyfZXKshMun31q93qXnviYb3u0Wy6bTHh+yqG/cWD8pi29uSoIx3TJVx0uNeRC+NcgXDse4
 z585K1g2IEydh2r+rO5LBZp1Oi4Efe6rOoVVfceCo+FeYE9wY7u3wO/EaORyxVol55Lkxf/Unqr
 eUknq/qzqTcdoUs+QmZyJeUQIWD/OmqQPzyVVWdMM23OQPgLi9nk1BQB6QzYVf18et5QtWHndAQ
 LsWTMxYdS9V5lYA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Enable multigrain timestamps, which should ensure that there is an
apparent change to the timestamp whenever it has been written after
being actively observed via getattr.

For ext4, we only need to enable the FS_MGTIME flag.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Tested-by: Randy Dunlap <rdunlap@infradead.org> # documentation bits
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ext4/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index e72145c4ae5a071cf4a809d0519a01a8fb84dc2d..a125d9435b8a1c8f7a96a2a0bdd9ce1b4671f8a2 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -7298,7 +7298,7 @@ static struct file_system_type ext4_fs_type = {
 	.init_fs_context	= ext4_init_fs_context,
 	.parameters		= ext4_param_specs,
 	.kill_sb		= ext4_kill_sb,
-	.fs_flags		= FS_REQUIRES_DEV | FS_ALLOW_IDMAP,
+	.fs_flags		= FS_REQUIRES_DEV | FS_ALLOW_IDMAP | FS_MGTIME,
 };
 MODULE_ALIAS_FS("ext4");
 

-- 
2.46.2


