Return-Path: <linux-fsdevel+bounces-9378-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E2B5840782
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 14:54:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF2DE2886AA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 13:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB064657D9;
	Mon, 29 Jan 2024 13:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dyd1SJm/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A054657AD;
	Mon, 29 Jan 2024 13:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706536443; cv=none; b=a2J8VqtI3Pw0L9i2tVu8F8WftHNlNua1K71xkd/kANSN8KKaLNxJpv7mirTyR9Pr/jm24uAIgaD76r+zAcmGRQD0WPX2/J/i6BokX3ANyh4hKumneWHi6KpBjj5oKV0ErnA8q1W155GzBhGMHxdzWmFY3oUx7Dn2NzzaIYjfqbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706536443; c=relaxed/simple;
	bh=oxnQVHjK16c3SXNOAjdh150De7InleBILFnsJkuVb2I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SyfOTvJiPSUUPF1FonLytpPq8j73SvECMQiy3hbP19ewcpM8NUVTsJthajV4qloOigMd7GjUOl3S6f0urOZq+VIGuQUz3mcDsG2VVzceLU2OU0uNxIlDbVQCbf0YoeeckfZfSJGBD88iXJiBQdq6a1V2jKWzfO4BVOfO0YpbNn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dyd1SJm/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9078C433C7;
	Mon, 29 Jan 2024 13:53:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706536442;
	bh=oxnQVHjK16c3SXNOAjdh150De7InleBILFnsJkuVb2I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Dyd1SJm/k5kdkc6EEeyiavgicku+98LjoK4Bq483kWInYTN9cx40JwhTkLVAgaYP2
	 it+C/nBcfpr3NRzOTgOWBWkIM13Yek41pmj5bH773MkKRsrN/NwOSOyi9J/t8yYO25
	 i/SQ1Yi7STfs8DutbEAX5joK9MGXOj1Jr122hEa1ZA8Ud6h2f0jOeRoW//73dkNuVi
	 H2EZQZf5OPmvyzK9fwrBZkIgOF05TdjGf10I2yJ/yq6VBycQJ3qF48QJRUePqyToC9
	 PCGX6rur5i6MdaWmVjP2Q1uysyuDBBo8TA4ydzdvlzUi/7jAXsG/LejmP7K1YLj8/q
	 u7jG606WZF6jA==
From: Christian Brauner <brauner@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Jeff Layton <jlayton@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	netfs@lists.linux.dev,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-erofs@lists.ozlabs.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] netfs: Miscellaneous fixes
Date: Mon, 29 Jan 2024 14:53:39 +0100
Message-ID: <20240129-kleeblatt-rosig-a28c8042fb2a@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240129094924.1221977-1-dhowells@redhat.com>
References: <20240129094924.1221977-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1172; i=brauner@kernel.org; h=from:subject:message-id; bh=oxnQVHjK16c3SXNOAjdh150De7InleBILFnsJkuVb2I=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRuX/vRz8V965um1m91CsbZ9wV2fJ18fZNu8T3XE+d8D xR7/fw5v6OUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAiKosY/pd1JPw3fzjxoP/G tS3fF8337FxYV/7w+G4zxcllZzuPveNl+MM788oSjU/qfNop+4+JHuhOX9S+rLtf7cDSszOc1zR +PMkMAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Mon, 29 Jan 2024 09:49:17 +0000, David Howells wrote:
> Here are a couple of fixes for netfslib:
> 
>  (1) Fix an i_dio_count leak on a DIO read starting beyond EOF.
> 
>  (2) Fix a missing zero-length check in an unbuffered write causing 9p to
>      indicate EIO.
> 
> [...]

Applied to the vfs.netfs branch of the vfs/vfs.git tree.
Patches in the vfs.netfs branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.netfs

[1/2] netfs: Fix i_dio_count leak on DIO read past i_size
      https://git.kernel.org/vfs/vfs/c/a4bb694db189
[2/2] netfs: Fix missing zero-length check in unbuffered write
      https://git.kernel.org/vfs/vfs/c/2d6e065e2431

