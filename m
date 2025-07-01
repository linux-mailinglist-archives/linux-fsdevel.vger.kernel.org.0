Return-Path: <linux-fsdevel+bounces-53441-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75F04AEF13A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 10:34:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C53C73BC31A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 08:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 401D626A0EB;
	Tue,  1 Jul 2025 08:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="clyt4tg2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E2F172602;
	Tue,  1 Jul 2025 08:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751358819; cv=none; b=tZg/GP4ZEAtxU2hktoP669y/sfK9MVh24K6qRu0jzWi9CAHEVMpO70cuXks8dGrxcs2DbuEYpB91A5Cj/ckYkqKMibpq0gcPLp+oA2KLtWNfewaxBKjCGHCctC8bB7ZH3JZAQByttcxlGlf+xPMz3gtkr208XMqAjW0MjhW1t0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751358819; c=relaxed/simple;
	bh=TwVj/zN+QrMTevzg4950xW7dqK4GoQ4YRfxr5UmUR3I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L6muRnRbRzQX7lI+l0ypBE7QPM5/SCBXj7oVL6hJzmuegQrA0Dmw8sI7UGm8QNDx/eRhl1k63/3E0ZqUdZgfEKfjzVTk7GCWGe1hCWrxOmRUfKRqKyqcfT1o81TUsW6v3u526QE99J3b2H1OGtiuBnYNV7tj9EURoyDUVkcPRF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=clyt4tg2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF7B0C4CEEB;
	Tue,  1 Jul 2025 08:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751358819;
	bh=TwVj/zN+QrMTevzg4950xW7dqK4GoQ4YRfxr5UmUR3I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=clyt4tg2JL9W3oAXwQtEPB0sIRKcq2cLZWvoPT3ehMRudf5w4bJghFW59PlQUVIa5
	 pBHCd8bZoDxdFy1EvArtcgUmF8pBYGbXh6d9sV5/H4xNTe88pQRLQawAgt1ZZ7g4ui
	 VZ67mMY+MhkySqiNj/u065RMcy8gCwm1cVVOpfXoX80HH5Usns3wWsdGNzCD+qJqSn
	 DhyrbHL+x+8YWtK5nttaXF9Ybm5AHZX/B4yxsFJovS2+Kl6zuauIGkfnHQL0ViLG+z
	 bOx4qN1Csd+Ci+a+tY9TzKvJ+pQFJsEBNyDO9W2nOLKpeUVPOjS0VYCnp2AWGZng9q
	 IcWthVVyhn57g==
From: Christian Brauner <brauner@kernel.org>
To: Shivank Garg <shivankg@amd.com>
Cc: Christian Brauner <brauner@kernel.org>,
	seanjc@google.com,
	vbabka@suse.cz,
	willy@infradead.org,
	pbonzini@redhat.com,
	tabba@google.com,
	afranji@google.com,
	ackerleytng@google.com,
	jack@suse.cz,
	hch@infradead.org,
	cgzones@googlemail.com,
	ira.weiny@intel.com,
	roypat@amazon.co.uk,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	david@redhat.com,
	akpm@linux-foundation.org,
	paul@paul-moore.com,
	rppt@kernel.org,
	viro@zeniv.linux.org.uk
Subject: Re: [PATCH V3] fs: generalize anon_inode_make_secure_inode() and fix secretmem LSM bypass
Date: Tue,  1 Jul 2025 10:33:25 +0200
Message-ID: <20250701-liberal-geklebt-4c929903fc02@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250626191425.9645-5-shivankg@amd.com>
References: <20250626191425.9645-5-shivankg@amd.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1243; i=brauner@kernel.org; h=from:subject:message-id; bh=TwVj/zN+QrMTevzg4950xW7dqK4GoQ4YRfxr5UmUR3I=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQkz4369uyfx9MFk40U1jtLFLQGXDktILn382QexrUt+ 6Z8fHXeraOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAi0/sZ/vB9eqQQbS76p7Hh 2OF7aXq72v9busjsjbgRf37LZf7ghV6MDLc2H53dIzkz6VTth6A7O9quq2T9vSLe2cGg1n7ctTp gCh8A
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Thu, 26 Jun 2025 19:14:29 +0000, Shivank Garg wrote:
> Extend anon_inode_make_secure_inode() to take superblock parameter and
> make it available via fs.h. This allows other subsystems to create
> anonymous inodes with proper security context.
> 
> Use this function in secretmem to fix a security regression, where
> S_PRIVATE flag wasn't cleared after alloc_anon_inode(), causing
> LSM/SELinux checks to be skipped.
> 
> [...]

Applied to the vfs-6.17.misc branch of the vfs/vfs.git tree.
Patches in the vfs-6.17.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.17.misc

[1/1] fs: generalize anon_inode_make_secure_inode() and fix secretmem LSM bypass
      https://git.kernel.org/vfs/vfs/c/4dc65f072c2b

