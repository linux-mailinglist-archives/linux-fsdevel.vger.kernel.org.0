Return-Path: <linux-fsdevel+bounces-40728-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F50BA27036
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 12:29:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9299165070
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 11:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A045320C477;
	Tue,  4 Feb 2025 11:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="beeX4FBa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B68020C46F
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Feb 2025 11:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738668540; cv=none; b=K0Xs4R1iej1cF2Za5D+QbGLf6FC49vSsvF5M0jpcLtGImsgO/Trfp4ihN/+J+rLsnu1oxnHs40wpDv7D4Aw9K4k/8WWJH6RXNww4/7c4NH04p5ERUy5ov7WIjqa4h8piTX70g3GXZLzO8M5hJR3cQ9kI3A73O9b2UdKFf1lnJr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738668540; c=relaxed/simple;
	bh=vDzcH+jxvipj5mOU7vGgaaam7ebEwSwPJMT1JIlWZV4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hh92IuzzEDoa2sFE+0yjEMpfTbXeaexu5mgXG82KQPOPdghLDcaf2VnUwkgdPGjKcqho1logJHMjeKnOAhKR4XFJw9wM8mwr25iGGrQTA3+97qaJwE8M1jsfgr7WjzSy0YtDhbROa1d+X4Uz5V2rcsYFR+2TA4CaCUFnBzCCN3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=beeX4FBa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 137BAC4CEE4;
	Tue,  4 Feb 2025 11:28:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738668539;
	bh=vDzcH+jxvipj5mOU7vGgaaam7ebEwSwPJMT1JIlWZV4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=beeX4FBarFQVVwdrU3I0bSEiSfzYbNWz9YJA6P79+gzsecPu6SX79dMumbULf8Tqq
	 qqNxa7I1QnrxGiDZXMnO+vMYzIytgBEmHjJu6dkTWOODZ0Nt6d9/MTom+WqTCaqGEK
	 /PVC4TI1GckMQ4VM3UKu/SmWhqK3EJ5Y/y35nAgwzA8626JeaJNGvGoMjA482wMS25
	 09rjW3FCK0X0kXBLyHHL5e8yPuER8VXBiUuoEbp/tiHZFN2HcSjH9B1oxaWWaG3RP7
	 QsowIkjjXhsXfPK2AsIDal8LS5VSdiocbYeY+UDIwQ1AxWHAGRFTkK4ws8O9cYj7BA
	 ajz/JvyOquxeg==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 04 Feb 2025 12:28:48 +0100
Subject: [PATCH v2 3/4] samples/vfs: check whether flag was raised
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250204-work-mnt_idmap-statmount-v2-3-0ef9b19b27c3@kernel.org>
References: <20250204-work-mnt_idmap-statmount-v2-0-0ef9b19b27c3@kernel.org>
In-Reply-To: <20250204-work-mnt_idmap-statmount-v2-0-0ef9b19b27c3@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>, Jeff Layton <jlayton@kernel.org>, 
 Lennart Poettering <lennart@poettering.net>, 
 Daan De Meyer <daan.j.demeyer@gmail.com>, 
 Seth Forshee <sforshee@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-d23a9
X-Developer-Signature: v=1; a=openpgp-sha256; l=1326; i=brauner@kernel.org;
 h=from:subject:message-id; bh=vDzcH+jxvipj5mOU7vGgaaam7ebEwSwPJMT1JIlWZV4=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQv/Pmpfs6itkU5klcyPuSycjybWNARfjFK44SmYN5ak
 bJdWzJUOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACbyfCfDf9f/LDFJgqYXP265
 +aBgQi2vqEC4bcrHC4s2MMlpR/MrszD801p0b/Ljc2ErVq+p1N27MGLho5nfOg1jzrxu2s3VxHl
 5CwsA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

For string options the kernel will raise the corresponding flag only if
the string isn't empty. So check for the flag.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 samples/vfs/test-list-all-mounts.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/samples/vfs/test-list-all-mounts.c b/samples/vfs/test-list-all-mounts.c
index 1a02ea4593e3..ce272ded8a79 100644
--- a/samples/vfs/test-list-all-mounts.c
+++ b/samples/vfs/test-list-all-mounts.c
@@ -138,10 +138,11 @@ int main(int argc, char *argv[])
 			printf("mnt_id:\t\t%" PRIu64 "\nmnt_parent_id:\t%" PRIu64 "\nfs_type:\t%s\nmnt_root:\t%s\nmnt_point:\t%s\nmnt_opts:\t%s\n\n",
 			       (uint64_t)stmnt->mnt_id,
 			       (uint64_t)stmnt->mnt_parent_id,
-			       stmnt->str + stmnt->fs_type,
-			       stmnt->str + stmnt->mnt_root,
-			       stmnt->str + stmnt->mnt_point,
-			       stmnt->str + stmnt->mnt_opts);
+			       (stmnt->mask & STATMOUNT_FS_TYPE)   ? stmnt->str + stmnt->fs_type   : "",
+			       (stmnt->mask & STATMOUNT_MNT_ROOT)  ? stmnt->str + stmnt->mnt_root  : "",
+			       (stmnt->mask & STATMOUNT_MNT_POINT) ? stmnt->str + stmnt->mnt_point : "",
+			       (stmnt->mask & STATMOUNT_MNT_OPTS)  ? stmnt->str + stmnt->mnt_opts  : "");
+
 			free(stmnt);
 		}
 	}

-- 
2.47.2


