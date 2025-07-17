Return-Path: <linux-fsdevel+bounces-55330-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C907CB09806
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 01:32:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2138C1768E9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 23:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5823248F60;
	Thu, 17 Jul 2025 23:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T8HW6PC9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F9A246764
	for <linux-fsdevel@vger.kernel.org>; Thu, 17 Jul 2025 23:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752795031; cv=none; b=UtbG5lybvoYn2wB22oXQ6u6d3QhwMRvnH3uh/ht+9YdAxbuXse4F3UBjCWqMqll+HcUlvW/aN/UmFNCOx394o9sJSUs1h0g+OPz+N6llBQxU9d9cYPziNeBSfBm611kNWvb8kzKUXaUq6g+vcaLGQCNBNa3GZvN+56c1j8YahDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752795031; c=relaxed/simple;
	bh=dqfjcPKgurRkJ1+Rph5ilNZp4Ln7FNXfw1vPQSgz2xg=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i6E8PWNOWFttKZ6fF0oa3v1jZHJ3DqMQBCbKMq2Qc8DKfltGD9DOwctNRBBmGG0S8ZQson1a/B+jyRW5mAx/M2Ovyg4OTUT2Q2Hqjgw048f3xpNzNc3lgo+gCworJfoQu7Y6kRkNlMXT5rTJtN9HVlLltXJnvqSnvpQPs6tWxCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T8HW6PC9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB88CC4CEE3;
	Thu, 17 Jul 2025 23:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752795030;
	bh=dqfjcPKgurRkJ1+Rph5ilNZp4Ln7FNXfw1vPQSgz2xg=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=T8HW6PC9Qqy3YUSie0P5eI7j8wM8+tObHRx82Em+BP24f3TN/Y0QbXFDwWNZZGHRv
	 Z8E1veLGy8DQsyuepxqbKCKZMfwr6lLv3Jb/m6AsxBW8Rlxz1FTdHOM6cdStKldstI
	 AiPbT6pESEmYTkhYzWqimqGKEJECxqUx5Qo2/A194nCv8tIcDgAVfPdW1qwXBHsJrt
	 qTOG5TOxWbMfEcx/0LONWuenl5OUuCwy2M/aJVSFALMXVfGayY/gMbx8Eu/LaH8ZpD
	 yGcEdFXjh6BDM8V4+blv1rvfUorMef8IUlubB1GXlgWEGPJ2T3OtTF6hV5qhw/PQlh
	 b4ZS/ijvCQtOw==
Date: Thu, 17 Jul 2025 16:30:30 -0700
Subject: [PATCH 09/13] fuse: use an unrestricted backing device with iomap
 pagecache io
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org
Cc: linux-fsdevel@vger.kernel.org, neal@gompa.dev, John@groves.net,
 miklos@szeredi.hu, bernd@bsbernd.com, joannelkoong@gmail.com
Message-ID: <175279450131.711291.3528188967011384170.stgit@frogsfrogsfrogs>
In-Reply-To: <175279449855.711291.17231562727952977187.stgit@frogsfrogsfrogs>
References: <175279449855.711291.17231562727952977187.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

With iomap support turned on for the pagecache, the kernel issues
writeback to directly to block devices and we no longer have to push all
those pages through the fuse device to userspace.  Therefore, we don't
need the tight dirty limits (~1M) that are used for regular fuse.  This
dramatically increases the performance of fuse's pagecache IO.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/file_iomap.c |   23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)


diff --git a/fs/fuse/file_iomap.c b/fs/fuse/file_iomap.c
index 0983eabe58ffef..6ecca237196ac4 100644
--- a/fs/fuse/file_iomap.c
+++ b/fs/fuse/file_iomap.c
@@ -606,6 +606,29 @@ bool fuse_iomap_fill_super(struct fuse_mount *fm)
 		}
 	}
 
+	if (fc->iomap_fileio) {
+		struct backing_dev_info *old_bdi = sb->s_bdi;
+		char *suffix = sb->s_bdev ? "-fuseblk" : "-fuse";
+		int err;
+
+		/*
+		 * sb->s_bdi points to the initial private bdi.  However, we
+		 * want to redirect it to a new private bdi with default dirty
+		 * and readahead settings because iomap writeback won't be
+		 * pushing a ton of dirty data through the fuse device.  If
+		 * this fails we fall back to the initial fuse bdi.
+		 */
+		sb->s_bdi = &noop_backing_dev_info;
+		err = super_setup_bdi_name(sb, "%u:%u%s.iomap", MAJOR(fc->dev),
+					   MINOR(fc->dev), suffix);
+		if (err) {
+			sb->s_bdi = old_bdi;
+		} else {
+			bdi_unregister(old_bdi);
+			bdi_put(old_bdi);
+		}
+	}
+
 	/*
 	 * Enable syncfs for iomap fuse servers so that we can send a final
 	 * flush at unmount time.  This also means that we can support


