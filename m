Return-Path: <linux-fsdevel+bounces-52166-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C277EAE004A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 10:46:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46CBE3AD32D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 08:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCB122673BC;
	Thu, 19 Jun 2025 08:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H15O8R4H"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA2C2673AA;
	Thu, 19 Jun 2025 08:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750322743; cv=none; b=jHlGIiqAEqNZq3UXLSlA7cVlQOhokoC6hU0LYH90bsQs3+7cH+DirvorL5+Vmx+OUZHDSly6NpAs/hJiqkux58RoQvGWy9wphGT5MqK5ScARHL7jvKQby9gTk8VdFTO0QIxz62lcFuSZHPNF3JhKQuqwZ7isyyVQywg39FFIlpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750322743; c=relaxed/simple;
	bh=ETZAfHfnmnB7/VJHWpx7jZwUc3d27vyxp4OFrpnTGNY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I7kwOKshBNOZCZdnNqiwwFvOnN40XOQ+7VqOShxICflWGSEaBNYsXu+NTeSCBdDUjF9OCRbQbcO/4Y8lpQdPWcJQWk0ftA+0p5Z4GTX6LMRi52oCz5K0k33oIT5nayCmILjsusxjNztw6RrACliZSTaP9f4SzgPOHn/DjIYyggs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H15O8R4H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04606C4CEEA;
	Thu, 19 Jun 2025 08:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750322742;
	bh=ETZAfHfnmnB7/VJHWpx7jZwUc3d27vyxp4OFrpnTGNY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H15O8R4HsWsWvzkoB8mcKBdWkY/qdSTohtFHiCM8PljYIRIeAXDgaSSYKs2m+ZB+j
	 StXkAxdlDws7yJpjXOEml/YZndgtt89Pu2ZfcwbtQZ058umd3G6i+IQki8Grn0YeWt
	 PgtgBj6zPk4oJDhso3ufO+svvOxiV5OnHdqBl/tlA7oQ7ie8L0TkELhcrX6TfnmCHC
	 hv0CHgRNceqnZ0JWM1+lDtmLwHol2EikLoEDnPTKC6Fl5qAzzHfcAue7CZxcWCaz4m
	 APzdkSeOCrYs0AnojcTCvwMvwVtDhh/LgqnEkySxPbrfv7Kcm41rYLc2ndvtyEg99b
	 8Sl4n1na2QGow==
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
Subject: Re: [PATCH] fs: export anon_inode_make_secure_inode() and fix secretmem LSM bypass
Date: Thu, 19 Jun 2025 10:45:16 +0200
Message-ID: <20250619-zerstochen-lamellen-b158317258e6@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250619073136.506022-2-shivankg@amd.com>
References: <20250619073136.506022-2-shivankg@amd.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1342; i=brauner@kernel.org; h=from:subject:message-id; bh=ETZAfHfnmnB7/VJHWpx7jZwUc3d27vyxp4OFrpnTGNY=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQEn1MTW6W6ZIpV9/31tXHvQuf5/ug5y8eQ7brj/sRl+ wOMqy586yhlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZiIuznDX7Ha3VZdL663Wb3r Fpt8OCWwZqeC3KXIif9P/911OrA/spqRYathwLNXS0VvKOeLfWVemD7j7O5bu40kX2yy2Zn/7QX LCz4A
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Thu, 19 Jun 2025 07:31:37 +0000, Shivank Garg wrote:
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
      https://git.kernel.org/vfs/vfs/c/c696307648ea

