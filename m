Return-Path: <linux-fsdevel+bounces-55727-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0161AB0E428
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 21:28:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D300A3B2C70
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 19:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F23F927FD48;
	Tue, 22 Jul 2025 19:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cdcNymqP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53AA1283CB1;
	Tue, 22 Jul 2025 19:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753212475; cv=none; b=ClxrnrFy1vmlJRETYk3OFCaopPn8ieLY62UDrAb/q/BBesd+mWz6BR+6AiJTadONqswYMH7A2aHxO/luVy9sxSp/1ozVUJAqbIap4xeX+vfqRxGJouxfnMwaUT7hpriwfQu8tre64s5Qe+f8s8z0knK+ApQDGedIK3HctRynNU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753212475; c=relaxed/simple;
	bh=wkiebM2g4HmLhGT682z1Q3Hx1rL8+v40GTcIusAIl3o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MnB0AzFYIwp2+3vfChZjeIfzmbBi8z+9+P/GIue+rO/ASBB66mEtcrpXzAJmxwZI01aWxRbHp0NQTrQuObhO4SOk7rTQh54C9Ow+xKaj7nWScqnCU+HscusH3Ike7ZOf08IxsUkTxv43bYGVUSY2lU/ov5WYes3UQMpqnpuUgTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cdcNymqP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5642CC4CEF8;
	Tue, 22 Jul 2025 19:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753212475;
	bh=wkiebM2g4HmLhGT682z1Q3Hx1rL8+v40GTcIusAIl3o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cdcNymqPX+coe9Gccz4yksCCKn6S/Y42tJEynnLawDlxkpV9iKPlaZn438w6kBRQ7
	 A2TnEpU4GAjapGkngO9BzBYOsZBnysYLVmlQWWLCe+3lEIu1kxVbl8jjswx7+9Nc4+
	 NbEP6OSPyBdmAPdHtyiDFkYHOvXPZVKXO9T0bfUXRamEXZvGhDQIYDhO/5f5nKPZ1H
	 KmZKJB/TISY8igTVL8us5wFKPlfC3W6X+RUHAeLTyerBX3t/aEsIS43sobzwZo1Iay
	 aV3n597b03dblFEMJxeDXUcHI4w1Bl8Imyq5xzloBUg7rdqSHe5KKbtSYvM9ssrAcc
	 W7NjF/J8ZfuTA==
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
Subject: [PATCH v3 01/13] fs: add fscrypt offset
Date: Tue, 22 Jul 2025 21:27:19 +0200
Message-ID: <20250722-work-inode-fscrypt-v3-1-bdc1033420a0@kernel.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250722-work-inode-fscrypt-v3-0-bdc1033420a0@kernel.org>
References: <20250722-work-inode-fscrypt-v3-0-bdc1033420a0@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.15-dev-a9b2a
X-Developer-Signature: v=1; a=openpgp-sha256; l=799; i=brauner@kernel.org; h=from:subject:message-id; bh=wkiebM2g4HmLhGT682z1Q3Hx1rL8+v40GTcIusAIl3o=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTUP5O5e8KB3f/eFZt1V50KY2V/hlkwnXr+6ojEfZE81 UI9Y757HaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABPZncHwv9Q+4rmK6wFNHZml FWzcL7Tt3h5hEPb++cXozQcXlavLLzP8z/GYvpZxiZVU3zx7uamJf82Ff30Q9fTLljG8MyFmyTU dHgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Store the offset of the fscrypt data pointer from struct inode in struct
super_operations. Both are embedded in the filesystem's private inode.

This will allow us to drop the fscrypt data pointer from struct inode
itself and move it into the filesystem's inode.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 include/linux/fs.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 96c7925a6551..991089969e71 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2332,6 +2332,7 @@ enum freeze_holder {
 };
 
 struct super_operations {
+	ptrdiff_t i_fscrypt;
    	struct inode *(*alloc_inode)(struct super_block *sb);
 	void (*destroy_inode)(struct inode *);
 	void (*free_inode)(struct inode *);

-- 
2.47.2


