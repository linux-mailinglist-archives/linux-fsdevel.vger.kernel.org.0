Return-Path: <linux-fsdevel+bounces-35698-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7585F9D72F8
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Nov 2024 15:25:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F96D165471
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Nov 2024 14:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D60C720E031;
	Sun, 24 Nov 2024 13:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jhsPSwNR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 319BB20E01C;
	Sun, 24 Nov 2024 13:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732455904; cv=none; b=Wd48R3mOJQ7Ph8d662/58/TcRaEQ3kDQb9X60lt5zWsxHK2fMnT9hhM63tN9TitKMYRYND0Jtnh6C5fF7JI7tiE1PngNL4PD6IwTqH4lOpJCgqiLEk+rBngcXi4hwdimvplVjeqQr/N5lSVMYrgSjeQvBViqefTUfWio+BppABY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732455904; c=relaxed/simple;
	bh=vWgSEUDddBjtaq3jwhrWDE1y09L23Hj1M4WCy2387LM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MaNwjMFx+temJPhY2vjXCUh7djWg7Zma/WCeJ9bxpeUXoEw0wZgiVE4qAx8/r851ersFQ377NHVmU1sQOe9t5BQyHa1JNQQbu7Da9Q1hu80qqzJJw6Cx1MHGRdyYquYbHkbM65N1K0nUj7zgW7OmsH2JZgnbk2v5tY6xGlO7pyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jhsPSwNR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32D34C4CED6;
	Sun, 24 Nov 2024 13:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732455903;
	bh=vWgSEUDddBjtaq3jwhrWDE1y09L23Hj1M4WCy2387LM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jhsPSwNRHi8+Vperw9tTAM/dDLrwyqlBL0HfmF9JefXguZ4M+7/8O97jaMtwqhY51
	 xmgDoUE+HochG1lF8mIdoxTHJ3HGhs/36uhzID13QFg8K/yx9zZ5Xyk7VehMIAQyns
	 z5/GHufgJdd//pUM2JmCV/T/tOhbvuIKsYC2jDg3K6Glhc2grcbFi5+CJA541C7SqY
	 G8S7AvQWT6Wbxq/0dbDEtPQvAr1o2jENC/gZCODpDJsXCCJaxfUWfFu+qxOT0/P5cC
	 aG3gJ/xfKNGFwCU/1oaLsVz3sa3cgrzCUp1xdeYCdl11Cp2YQBTGJryjy4FKTICl3J
	 1aILNjTAtQIhQ==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Miklos Szeredi <miklos@szeredi.hu>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 23/26] acct: avoid pointless reference count bump
Date: Sun, 24 Nov 2024 14:44:09 +0100
Message-ID: <20241124-work-cred-v1-23-f352241c3970@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241124-work-cred-v1-0-f352241c3970@kernel.org>
References: <20241124-work-cred-v1-0-f352241c3970@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.15-dev-355e8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1037; i=brauner@kernel.org; h=from:subject:message-id; bh=vWgSEUDddBjtaq3jwhrWDE1y09L23Hj1M4WCy2387LM=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQ76y5advda3e820UdcTW/Ox2Yef9zUdHPOHOtD688s6 j67r2tiV0cpC4MYF4OsmCKLQ7tJuNxynorNRpkaMHNYmUCGMHBxCsBEarQY/unLhBbPeRrHuSpP 7dff1ZN+b9R96qx7aMLZ0/Y2Hztd60oZGZ7t3/6iW3jTk+NmSks+m/+M73Jd8O28wDzmoujEsyI cc3gA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

No need for the extra reference count bump.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 kernel/acct.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/acct.c b/kernel/acct.c
index ea8c94887b5853b10e7a7e632f7b0bc4d52ab10b..179848ad33e978a557ce695a0d6020aa169177c6 100644
--- a/kernel/acct.c
+++ b/kernel/acct.c
@@ -501,7 +501,7 @@ static void do_acct_process(struct bsd_acct_struct *acct)
 	flim = rlimit(RLIMIT_FSIZE);
 	current->signal->rlim[RLIMIT_FSIZE].rlim_cur = RLIM_INFINITY;
 	/* Perform file operations on behalf of whoever enabled accounting */
-	orig_cred = override_creds(get_new_cred(file->f_cred));
+	orig_cred = override_creds(file->f_cred);
 
 	/*
 	 * First check to see if there is enough free_space to continue
@@ -541,7 +541,7 @@ static void do_acct_process(struct bsd_acct_struct *acct)
 	}
 out:
 	current->signal->rlim[RLIMIT_FSIZE].rlim_cur = flim;
-	put_cred(revert_creds(orig_cred));
+	revert_creds(orig_cred);
 }
 
 /**

-- 
2.45.2


