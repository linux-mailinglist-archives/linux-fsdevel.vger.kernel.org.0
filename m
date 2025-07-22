Return-Path: <linux-fsdevel+bounces-55678-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FA9DB0DA43
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 14:58:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63B99AA2D07
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 12:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D05E82E9ECA;
	Tue, 22 Jul 2025 12:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hSV2YjHl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 352702DC34C;
	Tue, 22 Jul 2025 12:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753189092; cv=none; b=gdCyh09wt0qIuxxP4TcmFPFKzo+1cSY21rSXAwWFr9oRpEdRPM8QLYirRUfmpmtvf1baLduSDlpkEuykWyZDPSiTatE660q3gOc7+IRplbvQoZNgKYFgsq72XbRfDCyuX5YPECTsoBp1uA0b/4zaZH2r4+j+i/dnaOt+3BhztKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753189092; c=relaxed/simple;
	bh=WhY7GMn4QVjRvHNxM9MXvVlJfq5fXNkE/cxik2z62H0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ps9QcOoPr30bLS1EE+Q/olzUqz+hTXZNrA8rAyecVf9InlQNOVqvA4SoYe9InpId/uobHsjE2i8xHGFrgEXA4m62DgEUfhndA2fQ+B9fO0mz8KzWr1b57kcitQkmjLCyEtedSESyooCO7nUvsMNrSRzEiTC/2Y+HEmX0wLmLg/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hSV2YjHl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 454B2C4CEF1;
	Tue, 22 Jul 2025 12:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753189090;
	bh=WhY7GMn4QVjRvHNxM9MXvVlJfq5fXNkE/cxik2z62H0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hSV2YjHlVCMYeT0mFVG0noj5AfOZqpMJhTlgCgKNej3hNMVek1Ysh2f0HHLemtJ1o
	 iMgQEZq2oxABC74wCS4fWAbzqmboHwxqPRDg9JRtj6zjP9+PrODWQrJHKTcQeO1Kfs
	 9dLMvZoAEI3pkQD/J176rVW/wPzKN0IHN79PY/V7JJ/CpqKA4xM7HHGyr57z6bo1+k
	 d++tjCXJNUW57wUK2LQJ6vUm4NlfML5JVGSb5Sg9OfBNgRIFaoDMc5Nx59w49Io2Ey
	 Jt/OePbReeloB/zkgIU7TPQSqdxEK+Ghy3DRxocIepf5MqD1Q3Chq4dYD34xfAkPUZ
	 bsMcrAX4jia5A==
From: Christian Brauner <brauner@kernel.org>
To: Jeff Layton <jlayton@kernel.org>,
	Jan Kara <jack@suse.com>,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	Josef Bacik <josef@toxicpanda.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Eric Biggers <ebiggers@kernel.org>,
	"Theodore Y. Ts'o" <tytso@mit.edu>,
	linux-fsdevel@vger.kernel.org,
	linux-fscrypt@vger.kernel.org,
	fsverity@lists.linux.dev
Subject: [PATCH RFC DRAFT v2 08/13] fs: add fsverity offset
Date: Tue, 22 Jul 2025 14:57:14 +0200
Message-ID: <20250722-work-inode-fscrypt-v2-8-782f1fdeaeba@kernel.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250722-work-inode-fscrypt-v2-0-782f1fdeaeba@kernel.org>
References: <20250722-work-inode-fscrypt-v2-0-782f1fdeaeba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.15-dev-a9b2a
X-Developer-Signature: v=1; a=openpgp-sha256; l=952; i=brauner@kernel.org; h=from:subject:message-id; bh=WhY7GMn4QVjRvHNxM9MXvVlJfq5fXNkE/cxik2z62H0=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTUd23iYK314JloU7z/6CznHmVt1ua7mx4lpGx4tenmw yDJYxlrOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACay3YrhfybzZqY3byd9sDi/ d+M8AbbJN1Xm8e8N3h6/2N/E7cifqA8Mf4ULrjM77z9dF7MiZLX35G0vTgQxFDteyDBn/7ZVdsI lAQYA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Store the offset of the fsverity data pointer from struct inode in
struct inode_operations. Both are embedded in the filesystem's private
inode.

This will allow us to drop the fsverity data pointer from struct inode
itself and move it into the filesystem's inode.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 include/linux/fs.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index ea5d3d3356c9..b933b8d75f50 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2214,6 +2214,7 @@ int wrap_directory_iterator(struct file *, struct dir_context *,
 
 struct inode_operations {
 	ptrdiff_t i_fscrypt;
+	ptrdiff_t i_fsverity;
 	struct dentry * (*lookup) (struct inode *,struct dentry *, unsigned int);
 	const char * (*get_link) (struct dentry *, struct inode *, struct delayed_call *);
 	int (*permission) (struct mnt_idmap *, struct inode *, int);

-- 
2.47.2


