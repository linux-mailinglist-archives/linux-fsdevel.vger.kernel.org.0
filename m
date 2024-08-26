Return-Path: <linux-fsdevel+bounces-27168-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 94AA595F1F8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 14:51:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C735B1C215D7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 12:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E14C198E96;
	Mon, 26 Aug 2024 12:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vJLtM6BS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B87198E6D;
	Mon, 26 Aug 2024 12:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724676406; cv=none; b=hAdUwelPMUnq/dVQBUNaBCWOcN5Zv4KPwjzeb3DZuXSVWdZeF3rlSPAzBZRaFRnWcfIixxWIqgSq0JUjpBlHrRoQlSztCw1Y8OquUZgUaDW+7/luYnqTTLpSJMOVGS2sExKLJfMyqxFUVOMr00MUq/DzlzpAlnjl61jDEnci2gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724676406; c=relaxed/simple;
	bh=PSgvoG/VeBHlNw/xybnGmp2VjTgkoJJ22Of1xt8QDDI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N5rOb85OVnx7uAsA6JQvJMrqvd15m5hLPpFiRciH2JnciyPsbWdEesd6AyQaKDAOYMNsP7xL1gvhi6iraoHfyV9+oB6Mjs0b3a9hgloP0KCaMtboNosNFY2PU+0Gv7HsaQhLzTu644JAObvUKX9l18OjSx7KYdKbybwlmwfxcjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vJLtM6BS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E6D6C58282;
	Mon, 26 Aug 2024 12:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724676405;
	bh=PSgvoG/VeBHlNw/xybnGmp2VjTgkoJJ22Of1xt8QDDI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=vJLtM6BSBsNCn020oOq8TSo8GFLvfaEQje9ZWWH76s3srFqLSu6w64Q+F+/r5aNuP
	 3tBpK3GUXt2xcD6EPn8fXDMOgkpE4h6mbjV9WopISOtc5iICVtzvvqqmnKjy7/MZHV
	 zVP3D3NfKQgppfS7sdQgi+sHK6uRXUBZU6H/GgOP1p/Cl4q/2NpJBO5IoFV40r4Gjs
	 iBIssJHdlqK6RHa7mJqPvQUED+YTphTqU0hVYyWmWHGzFQw3qYNSApV6A10WcNNVGX
	 /Xm9n707OJBYqADZQdFMthFMb2eB7v7r0I3gEDi2snqtuxKaPp3jdpCgSXyvLblSWb
	 fwKqlD1VLD59Q==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 26 Aug 2024 08:46:15 -0400
Subject: [PATCH v2 5/7] fs: add an ATTR_CTIME_DLG flag
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240826-delstid-v2-5-e8ab5c0e39cc@kernel.org>
References: <20240826-delstid-v2-0-e8ab5c0e39cc@kernel.org>
In-Reply-To: <20240826-delstid-v2-0-e8ab5c0e39cc@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, 
 Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>, Olga Kornievskaia <okorniev@redhat.com>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: Tom Haynes <loghyr@gmail.com>, linux-kernel@vger.kernel.org, 
 linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-doc@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2163; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=PSgvoG/VeBHlNw/xybnGmp2VjTgkoJJ22Of1xt8QDDI=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBmzHkrdyhy3gi+oajGUxNAMQ0Q6Svd6kHWNGjQR
 3Smswpvt4mJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZsx5KwAKCRAADmhBGVaC
 FY4sEACv7DYAfyiucP/hI8/ZRylosazMVKdyQmg0KjRjpVgiqshJ+2sew4NQcCvv1oAFKpobhP6
 pACEowXVpY60WS2Mpvja/G2yO0uGFe62WTLP26a7+hMjDxlhYMh+PeTn6RW8YWCGzP0t5VhVW3j
 4iu23WO6yOJ3EaDqv7sCNlhcfKUwGkmeap0h0e9n/XXPRhO5KoUb9KukYEwARucPIPrNondwmZP
 SE4NE1y8vUWHCaj/iLRDTH1+EA52J9mYFlB3I5vZdntPrX83XhdPg/aEzRT2xQr+ftZT+pMh8zT
 gGddT1orKMKq5iJKR6UNcQG7IdYJoSeentoun5CA/IWQWR6SqJVBO8KemI7cXOQhA4nvqghXoYR
 K2WPPCaoNhKdJtz2COnwLZV033amZAt7hhXtuUQGYfk99Sox3PMHQ/9wABxbN+3rJChbEsD7OYQ
 w/gT2zjrsXxn7uOjlN6krpt1bq7w2BUj9rv/pgfHwdjlNHx6gH4vyJxEMExE8HCbcbeMcJfozKU
 0arZWgvWmSVjjcc6gqRY61aHHViX1s7HHf4C1D6YEaR7pPgAvwsNyvZH20OUBLAxYM9mF9BxH6Y
 qSw3SwKv1thdenCTgS4XHEhJvZPet2U5kXNCgdq91Q/2+2C20B78Wf7D1gfqBxSEVKGdjdtvFPI
 VBt+0lPmjTlN7kw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

When updating the ctime on an inode for a setattr with a multigrain
filesystem, we usually want to take the latest time we can get for the
ctime. The exception to this rule is when there is a nfsd write
delegation and the server is proxying timestamps from the client.

When nfsd gets a CB_GETATTR response, we want to update the timestamp
value in the inode to the values that the client is tracking. The client
doesn't send a ctime value (since that's always determined by the
exported filesystem), but it does send a mtime value. In the case where
it does, then we may also need to update the ctime to a value
commensurate with that.

Add a ATTR_CTIME_DELEG flag, which tells the underlying setattr
machinery to respect that value and not to set it to the current time.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/attr.c          | 10 +++++++++-
 include/linux/fs.h |  1 +
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/fs/attr.c b/fs/attr.c
index 7144b207e715..0eb7b228b94d 100644
--- a/fs/attr.c
+++ b/fs/attr.c
@@ -295,7 +295,15 @@ static void setattr_copy_mgtime(struct inode *inode, const struct iattr *attr)
 		return;
 	}
 
-	now = inode_set_ctime_current(inode);
+	/*
+	 * In the case of an update for a write delegation, we must respect
+	 * the value in ia_ctime and not use the current time.
+	 */
+	if (ia_valid & ATTR_CTIME_DLG)
+		inode_set_ctime_to_ts(inode, attr->ia_ctime);
+	else
+		now = inode_set_ctime_current(inode);
+
 	if (ia_valid & ATTR_ATIME_SET)
 		inode_set_atime_to_ts(inode, attr->ia_atime);
 	else if (ia_valid & ATTR_ATIME)
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 7c1da3c687bd..43a802b2cb0d 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -211,6 +211,7 @@ typedef int (dio_iodone_t)(struct kiocb *iocb, loff_t offset,
 #define ATTR_TIMES_SET	(1 << 16)
 #define ATTR_TOUCH	(1 << 17)
 #define ATTR_DELEG	(1 << 18) /* Delegated attrs (don't break) */
+#define ATTR_CTIME_DLG	(1 << 19) /* Delegation in effect */
 
 /*
  * Whiteout is represented by a char device.  The following constants define the

-- 
2.46.0


