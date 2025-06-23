Return-Path: <linux-fsdevel+bounces-52502-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BBDCAE3952
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 11:03:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6F0916630D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 09:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC2612376E1;
	Mon, 23 Jun 2025 09:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U7t5K9K/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2293A2356CF;
	Mon, 23 Jun 2025 09:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750669310; cv=none; b=HP+pw2+NzhatAUs1Q+ZsifduQ0qUVhtSTLU5j4Qg9vkWB1/9F7s0YAqpRzoFawSKKYNOvtejmwp3o2pn8OebYWDfK1MQGjaFBXKQJmzRG+iDF+6AkmT33L24nD9cqn8vnTLhOKY2uR6oyPPM7cdxnnTECQouVrCvSz0EfxqEudg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750669310; c=relaxed/simple;
	bh=lgKch+PPjVSRIzE+iyyjC8pNlU4nLj3kIFtFGl1mwQE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=o4VL7wSKIqz9GwxM+EfkvS4yjNPMVfsvtfnO6ENjYHAixgc0DEfg789/ZIQI7oq4bKV30LONuWxSbFIDOEPFFFnmkxHunUPNUvV7BbjjUGUnJbbl41qo5vXLKyoZqocwM/26cQoHrjYyQbpks13fvoGgjKPYMU2npyin+Ee545s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U7t5K9K/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6CF8C4CEEA;
	Mon, 23 Jun 2025 09:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750669310;
	bh=lgKch+PPjVSRIzE+iyyjC8pNlU4nLj3kIFtFGl1mwQE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=U7t5K9K/wesYhZHAAjP0gWUudoXw/+mfd2swnTEsehAsAsvw6/bs2zu7Kd0Jz5ZEi
	 c/20WPG2ewMUpLQHawnPqFhqHN/9ghoaRHc02qC/2o2eJmnJkWQEqZITIGh+QhENmP
	 3nnjH5BAsiyK4gTcGz40Nc9w8hJXrIq4KJ3msS90co79rqxBsRFlXojDcWkEleamak
	 5aFEZKRWn2iNUr3EycwRL6jcvX6ycgIAcNZcdmT7kGFGDsyESCrffC+wDdF9FD9wcD
	 WLH9MgbYcHSD3IQCh74vPEFj7Fh7ydGmOc8kzuE8P2PUw3w5funtqnHbIr5jLe1cw2
	 szkEPGR9tkD3Q==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 23 Jun 2025 11:01:28 +0200
Subject: [PATCH 6/9] exportfs: add FILEID_PIDFS
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250623-work-pidfs-fhandle-v1-6-75899d67555f@kernel.org>
References: <20250623-work-pidfs-fhandle-v1-0-75899d67555f@kernel.org>
In-Reply-To: <20250623-work-pidfs-fhandle-v1-0-75899d67555f@kernel.org>
To: Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
 Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-262a7
X-Developer-Signature: v=1; a=openpgp-sha256; l=874; i=brauner@kernel.org;
 h=from:subject:message-id; bh=lgKch+PPjVSRIzE+iyyjC8pNlU4nLj3kIFtFGl1mwQE=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWREir82fzd58ZXVTfcuTy5Zm3/hipGJ1sMzJT6XGbJ7W
 e2YXqz41VHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjARPyGGf+anlJofbsvQMDa1
 XPDmCV+P0tff5udW+Rd/Fsz4sDqZcTMjw/85Jy2Deg23mq9r1qwtbPhw9ElMzmrV0gOCd4y/r27
 dzAwA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Introduce new pidfs file handle values.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 include/linux/exportfs.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/linux/exportfs.h b/include/linux/exportfs.h
index 25c4a5afbd44..45b38a29643f 100644
--- a/include/linux/exportfs.h
+++ b/include/linux/exportfs.h
@@ -99,6 +99,11 @@ enum fid_type {
 	 */
 	FILEID_FAT_WITH_PARENT = 0x72,
 
+	/*
+	 * 64 bit inode number.
+	 */
+	FILEID_INO64 = 0x80,
+
 	/*
 	 * 64 bit inode number, 32 bit generation number.
 	 */
@@ -131,6 +136,12 @@ enum fid_type {
 	 * Filesystems must not use 0xff file ID.
 	 */
 	FILEID_INVALID = 0xff,
+
+	/* Internal kernel fid types */
+
+	/* pidfs fid types */
+	FILEID_PIDFS_FSTYPE = 0x100,
+	FILEID_PIDFS = FILEID_PIDFS_FSTYPE | FILEID_INO64,
 };
 
 struct fid {

-- 
2.47.2


