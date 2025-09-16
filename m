Return-Path: <linux-fsdevel+bounces-61659-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA68BB58ACD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 03:08:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70CC61B23142
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 01:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEE631D31B9;
	Tue, 16 Sep 2025 01:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P9LUoWSU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 272862A1AA;
	Tue, 16 Sep 2025 01:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757984889; cv=none; b=URvaqesY2V1g5mvCIWmG4cmOCdXXHp611PCTDN1Ui/mjqvbBmnvILmFotC7CtSlmDbgYo2Q7mo+ntt5Fr49Blb9NRsuacxaHL+xdabfZ1mtOeXDPD6MfkjrizOAtvuw+2VTPIK7QZXhx/vTHig6bGJ8Ny/OpSVVchg+AJNwfqiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757984889; c=relaxed/simple;
	bh=4QvZWb1bZfoOWu+UEi/3xeuPMv18aDdmQairmdZbGbk=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=poFXFZu0jpPBhEd2yUtyTPIDqLpBc6OZq1h8/2v7uxSTqwqc+1GP2XiBEfVdHL355ezc/iTxrMOJS/phIwVgpRTye31+a3hsdvIDOewtsM27ZYTFHdqQIGLJHzBkbzik1eqG0NxSLvbYEjD7wXgHLhSmlwTAhk3RD73mzHhJdQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P9LUoWSU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5043C4CEF1;
	Tue, 16 Sep 2025 01:08:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757984888;
	bh=4QvZWb1bZfoOWu+UEi/3xeuPMv18aDdmQairmdZbGbk=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=P9LUoWSUCmRSuVDrelP2UPmgoaWvaIK+R+VS0EqgKe9LnFx6TGja8Rv6YiPVb8fly
	 1m9w5aXqz0QkPywdFf21gsJIC56dWxu6risJP2j7pqjCju2brL1ALo9aitqDN1wIL1
	 hmG7EMMg1dFfBYnLFjm0VOKgUS0y06QmKtU28t7VwxInty0w85AgDcpuIC8u0vTnjL
	 yntiVtM+T0QhI0pRomYXJAqCPhot+KHzHzFOeU2yjPcZyCYBYY6g7Eo7h4rM+rBTLo
	 rYp5JmCFfOzkIToj1753E1zvrFOWG1wzCdndxRdSjnfN5yhlytpeHn2kbmDVKoCPR3
	 7F1icuB50cylQ==
Date: Mon, 15 Sep 2025 18:08:08 -0700
Subject: [PATCH 5/6] fuse2fs: increase inode cache size
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: miklos@szeredi.hu, neal@gompa.dev, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, John@groves.net, bernd@bsbernd.com,
 joannelkoong@gmail.com
Message-ID: <175798162942.391868.14831839113447753735.stgit@frogsfrogsfrogs>
In-Reply-To: <175798162827.391868.5088762964182041258.stgit@frogsfrogsfrogs>
References: <175798162827.391868.5088762964182041258.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Increase the internal inode cache size.  Does this improve performance
any?

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fuse4fs/fuse4fs.c |    4 ++++
 misc/fuse2fs.c    |    4 ++++
 2 files changed, 8 insertions(+)


diff --git a/fuse4fs/fuse4fs.c b/fuse4fs/fuse4fs.c
index 2dd7c0f6759de5..3e8822fac08630 100644
--- a/fuse4fs/fuse4fs.c
+++ b/fuse4fs/fuse4fs.c
@@ -1311,6 +1311,10 @@ static errcode_t fuse4fs_open(struct fuse4fs *ff, int libext2_flags)
 	if (err)
 		return translate_error(ff->fs, 0, err);
 
+	err = ext2fs_create_inode_cache(ff->fs, 1024);
+	if (err)
+		return translate_error(ff->fs, 0, err);
+
 	ff->fs->priv_data = ff;
 	ff->blocklog = u_log2(ff->fs->blocksize);
 	ff->blockmask = ff->fs->blocksize - 1;
diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index 8bd7cedc9f1ca8..83a3ed3ac3450e 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -1139,6 +1139,10 @@ static errcode_t fuse2fs_open(struct fuse2fs *ff, int libext2_flags)
 		return err;
 	}
 
+	err = ext2fs_create_inode_cache(ff->fs, 1024);
+	if (err)
+		return translate_error(ff->fs, 0, err);
+
 	ff->fs->priv_data = ff;
 	ff->blocklog = u_log2(ff->fs->blocksize);
 	ff->blockmask = ff->fs->blocksize - 1;


