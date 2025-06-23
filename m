Return-Path: <linux-fsdevel+bounces-52522-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1B29AE3D25
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 12:47:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3251716E5BE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 10:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CD2F23D284;
	Mon, 23 Jun 2025 10:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cTUAD/gU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEADF1F3BB0;
	Mon, 23 Jun 2025 10:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750675305; cv=none; b=LC2EqlCOnWeAGclel39QeRe1MujTB/ewDzZQHaipb52DGOBzGpOg9Bc7Zdsx4I7p42v5YhQJhNiGiUnnZdZiujYxnwhKozoZZHPLk7t5JYiNJ8/VRlbrBkEJhN5Mo3Mg/81VpZe1Hs+7hVJydJEAGmBRJis7xRAC7OLSQxNQdIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750675305; c=relaxed/simple;
	bh=TjVPoKfdwA4LC6d6Oiek3FJXnEusgEo0vEnY+quhvUY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cbE3fsYzeK+PwzyNvjy+qIIWgcgUpHpT04126lJ6mXZXmuJSN1lY9vXVWYjcqp982f0Xkp1pSPV9N5vVI+Eoi2moTXQ5LRpqZcfLdiRvNgtPMvJYdyee0ms6jlFZQ3/xQrddpjgyxiQMjlZ2HPbKaowBedOXY+Gvv5ncYKpGhEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cTUAD/gU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8893BC4CEF1;
	Mon, 23 Jun 2025 10:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750675304;
	bh=TjVPoKfdwA4LC6d6Oiek3FJXnEusgEo0vEnY+quhvUY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cTUAD/gUMZOHoJKyYa9WlHoR8tQ+Dl2l5zyAa0WhMxz2xMnLNrJFCZBuZ2deldPUr
	 KYhAyDywxD7UoBZ+C6RHd+qOlwuM8AUmXT/PNbt2XdsfvbZn/xmONwgfMCNi/blkXw
	 eymthVUItsI9Z74j6AyATPLUwHeTNPoqeCkdKR3R5aNVQXGaO+K13TEbPoHENG26Fz
	 uXBLdeG23wCeyZNuneL+aWpGOcN7OlQyKRXbfz/g7iO39vyFuSV2kQ9/WvF1R2djAE
	 JXqgGbppJS+V/DqnR3vHk+kNTFCZeH1/R8d+NSYJ/2dsIaYokAan7FAsDdJymTEqoz
	 1DFPZUbVuYbMg==
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
Subject: Re: [PATCH V2] fs: export anon_inode_make_secure_inode() and fix secretmem LSM bypass
Date: Mon, 23 Jun 2025 12:41:28 +0200
Message-ID: <20250623-abmessungen-vakuum-9c0c03207fcd@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250620070328.803704-3-shivankg@amd.com>
References: <20250620070328.803704-3-shivankg@amd.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1342; i=brauner@kernel.org; h=from:subject:message-id; bh=TjVPoKfdwA4LC6d6Oiek3FJXnEusgEo0vEnY+quhvUY=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRE6sf/n97Pffb45Slvap1Wcy1hlKj5ssXp7D7NOueo7 UrPtmtu6ChlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZiIABfD/zi7I5F/1ydFnnJ7 fuX4njkd1h2/Nz7NOG4eUDNd6XOJaiojQ1Oghci+2dYTX9yqW/COcbPd1oWejCf2X4k2kfs/SWw KJyMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Fri, 20 Jun 2025 07:03:30 +0000, Shivank Garg wrote:
> Export anon_inode_make_secure_inode() to allow KVM guest_memfd to create
> anonymous inodes with proper security context. This replaces the current
> pattern of calling alloc_anon_inode() followed by
> inode_init_security_anon() for creating security context manually.
> 
> This change also fixes a security regression in secretmem where the
> S_PRIVATE flag was not cleared after alloc_anon_inode(), causing
> LSM/SELinux checks to be bypassed for secretmem file descriptors.
> 
> [...]

Applied to the vfs.fixes branch of the vfs/vfs.git tree.
Patches in the vfs.fixes branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.fixes

[1/1] fs: export anon_inode_make_secure_inode() and fix secretmem LSM bypass
      https://git.kernel.org/vfs/vfs/c/cbe4134ea4bc

