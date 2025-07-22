Return-Path: <linux-fsdevel+bounces-55734-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD726B0E437
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 21:28:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7CB817C808
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 19:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA186285061;
	Tue, 22 Jul 2025 19:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RWz9DgfT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 565BA288D2;
	Tue, 22 Jul 2025 19:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753212496; cv=none; b=X0rYEctu6GIgc3flWjqE4NXX0JblIeBIltqjvL+fO69upgQahRd9AHXOwMlTCoxFLaAc5U4lfUTMe7pRFJFfayvyI4G03Ay1HUjN2MMrcg/lHqu9QATQNukc0G9DqSOkxShWAG6s3PhMQCglb1N3H7iFs0ivW7KVplKASbDwnCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753212496; c=relaxed/simple;
	bh=qXyNOwLL5xuGWxOIL2tH4bo1X/Fu14TZdovVfx63X9U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O3BXCoExdJwE7LKXOflSEeTZxIlyMfB+hDMZQ3WS0I9bH7/PREEwoCoc958VRB82dseNXG5PG+ALr5fRx0JQUC/8k7rKqNPmbjyphGcd06gSjw7yYztGjC7+vbfZG3j7fUFrmwEOwoyaT56uziSmwKg/1hAopQWSG5TNZ/uh+Fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RWz9DgfT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE73BC4CEF7;
	Tue, 22 Jul 2025 19:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753212496;
	bh=qXyNOwLL5xuGWxOIL2tH4bo1X/Fu14TZdovVfx63X9U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RWz9DgfTyvfloEigKgVrwhhtUYBUJYKMQwRqX8RCUPyszTfNSc+gIRI63b2uKxBhQ
	 7VeliXby2lU2sxUF5PiiDWsRBiuywu92kFvI+fBB+J7hRfC6S779dcVEfi11Xp3IQ9
	 WEId82TG1zHtshvTxcqFteBeNhthpSlUNnMazcEOFGFL9iH3RDG36L2hkMmz7fGjgE
	 +LpKcAvyAh0DMT7sasX/04jX54UuBMIYUI/v8sagsFHqOH6R3AjkBzZptHoNI4RYE2
	 AvzTrecv6CQsYeg2AvG+QKqLHk/Q3NF/u85b7r2ySABaTeVVqLB2rGzmX767lGbkXH
	 fdsvjiIw7skPQ==
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
Subject: [PATCH v3 08/13] fs: add fsverity offset
Date: Tue, 22 Jul 2025 21:27:26 +0200
Message-ID: <20250722-work-inode-fscrypt-v3-8-bdc1033420a0@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=822; i=brauner@kernel.org; h=from:subject:message-id; bh=qXyNOwLL5xuGWxOIL2tH4bo1X/Fu14TZdovVfx63X9U=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTUP5OblD+R7cA5hr5gBeF9mzY/SpiRfbc9jyl+j5v4J p4HKqeed5SyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzkxTlGhvsfuHtnfvxqcmzZ 3IWhtmqK3vrnVh2TDmOc9kvxaOXjuDyGfwpH08qltzgnfixabqEXUxpp+euu5YS9bfvm7diflr7 zBiMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Store the offset of the fsverity data pointer from struct inode in
struct super_operations. Both are embedded in the filesystem's private
inode.

This will allow us to drop the fsverity data pointer from struct inode
itself and move it into the filesystem's inode.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 include/linux/fs.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index a2bf23b51bb9..f7acf17550f1 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2329,6 +2329,7 @@ enum freeze_holder {
 
 struct super_operations {
 	ptrdiff_t i_fscrypt;
+	ptrdiff_t i_fsverity;
    	struct inode *(*alloc_inode)(struct super_block *sb);
 	void (*destroy_inode)(struct inode *);
 	void (*free_inode)(struct inode *);

-- 
2.47.2


