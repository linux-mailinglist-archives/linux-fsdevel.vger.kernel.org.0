Return-Path: <linux-fsdevel+bounces-40723-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 28C99A27031
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 12:28:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D35A61887A46
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 11:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0418620C02E;
	Tue,  4 Feb 2025 11:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nWUeuuUw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63815206F1B
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Feb 2025 11:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738668491; cv=none; b=Yoq5AP5bBmHe3ywVoJ7A/PElMx5DsBOWjiMHkQHvfKJqdeVgIQkmqXNeVuxeLdQwfTwGZjZysN1DfAqnSsHtpr9ZR1HEKrewZA1QlI98qUI+4bwEV4UfBlZOKgvnynFpeLducV7g/wYGzHHEWQnLNkxKGVaDOAxqBhOD42eTWfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738668491; c=relaxed/simple;
	bh=vDzcH+jxvipj5mOU7vGgaaam7ebEwSwPJMT1JIlWZV4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=t5vte0RGSkuYrPingTG1gJmSMMA49pwAaam0VYOL9KpGKI9TO3s/4ws1lEQPbKGPgpIyg20RRPMGvfCjyojxG2qHtqIVluEreb3DiJw81xS5eTpmLoa+S4gKsiwQNymVxNBnxw6bV6N8DhMGDaxL3lpDyrhzsfRhqF+BNaQJ8so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nWUeuuUw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03CC7C4CEE4;
	Tue,  4 Feb 2025 11:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738668490;
	bh=vDzcH+jxvipj5mOU7vGgaaam7ebEwSwPJMT1JIlWZV4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=nWUeuuUwwvDnZV3/1Z00UY1H03T+oZvgCLoiHiPn3y1KxTdx5sdGCAcLhsjeFXHBk
	 5BMY4fJAXe3JGlgsDwxaaAeZfZc3LtreYsn+1IhmKz6KKc1YA3W42tXMFPVRU2KW+d
	 AsxqFCaWmNDaxfeOU+aMIMZQaqtUTEI0MRV/l4LlJEpy7wP0CmIZpFJIrLGv+mTAyg
	 Nea8YXd30DUveZix2fcekeTKtm6TcoclyDab/Vy9l2EdxXsiRSdhdC/xEFfGsvtVGf
	 wAABN/SBz7LU+cpgZS3eU+GdnSMIzK8yOg2Ee7GmoqKG94+RqqO6k6uPzy+s5o+lyp
	 6OkCSzT3iEYcA==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 04 Feb 2025 12:27:48 +0100
Subject: [PATCH v2 3/4] samples/vfs: check whether flag was raised
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250204-work-mnt_idmap-statmount-v2-3-007720f39f2e@kernel.org>
References: <20250204-work-mnt_idmap-statmount-v2-0-007720f39f2e@kernel.org>
In-Reply-To: <20250204-work-mnt_idmap-statmount-v2-0-007720f39f2e@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>, Jeff Layton <jlayton@kernel.org>, 
 Lennart Poettering <lennart@poettering.net>, 
 Daan De Meyer <daan.j.demeyer@gmail.com>, 
 Seth Forshee <sforshee@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-d23a9
X-Developer-Signature: v=1; a=openpgp-sha256; l=1326; i=brauner@kernel.org;
 h=from:subject:message-id; bh=vDzcH+jxvipj5mOU7vGgaaam7ebEwSwPJMT1JIlWZV4=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQv/Hlgwt0zoeqcG2fGHFX4Kbj1YlCzzUy+1O2fXTsaW
 HVOXtnS1FHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjARHRtGhs992dPvHttfWhL7
 6/PFazkWf91/3g9cpXWX7z5nf6nOVGFGhs6LG40nzviwu0o6OGW79h4rBrH4znIfqa9ML6w/v/C
 5zQgA
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


