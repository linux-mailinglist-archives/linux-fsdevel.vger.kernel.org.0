Return-Path: <linux-fsdevel+bounces-31167-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D61F6992A95
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 13:47:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F8EEB22E60
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 11:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 307EA18A6AD;
	Mon,  7 Oct 2024 11:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A5qDUREi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD511D223C;
	Mon,  7 Oct 2024 11:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728301617; cv=none; b=UkJMkVMm47fupvt2mT9jY+6J7xkwFy0LIaV1Qow21qyCCvRzfrXIWmZJm1+I/pNyg9cJSTS24nqUBsvLjDNnQRAK4RWXIE547aMnSBQC0DAbJRLXoIeRfdSHCbi1PhMRa4UdNmUNVrxwX0FRlwsk22S/a0cd54vo4g1dfKHRP1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728301617; c=relaxed/simple;
	bh=WgWOgEBlXECC+JH7yf0UhYcuKfxt9AuJWYeRYHj5ljY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SIPdgNlFL55JiF3caTnsPZE452u3Dbvk0H2YxZfEDjHVult7HbGurQSSVamQA5QcE/hbcG4AbnBslQyVrabo7Jva32FEOkeI6dMrCkKqPeBb7IBaxRyB0aW3ISAyHsgv1KISL1RSeNiVlyp6y+N1DJDAWEQ4xUsg5a7RvwsbowY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A5qDUREi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1747C4CECC;
	Mon,  7 Oct 2024 11:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728301617;
	bh=WgWOgEBlXECC+JH7yf0UhYcuKfxt9AuJWYeRYHj5ljY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A5qDUREilkfpDR+D++KbU2zOkyG/hFV/cluOS+YmuhHWIg7gCEdN66OkSOSot2iQ1
	 mEhqm1CBxd8tYgMitCWzyf1e2Ipxe8JUgeCU8+1giMD3lc12e5Qi/8aBd9ooqMk3YL
	 uee4kPpXckRZH/msjRz5R+Ueg8IDNHY8vnbefvgJ/7gxDcXEICWj1u6104hNUksDZC
	 Hw2HcaSIPgA99HiHel4ur2rUuk1IDwiQLunxVqNStmebHLOad+eQ/wAjduQ2ptdgKA
	 4Rv76zMtuQrX1g6DOGmHOJeVwcTxkXvMmwkLf5zxu8PWjkjsS604uPr5HP0A6geaj2
	 pYWIoWKgOFrUA==
From: Christian Brauner <brauner@kernel.org>
To: David Howells <dhowells@redhat.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Christian Brauner <brauner@kernel.org>,
	netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/3] Random netfs folio fixes
Date: Mon,  7 Oct 2024 13:46:50 +0200
Message-ID: <20241007-morgen-ahnen-26fe34f1f7e1@brauner>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241005182307.3190401-1-willy@infradead.org>
References: <20241005182307.3190401-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1282; i=brauner@kernel.org; h=from:subject:message-id; bh=WgWOgEBlXECC+JH7yf0UhYcuKfxt9AuJWYeRYHj5ljY=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQzn9Je/q57Y1YQ9+nHBbpFaf+Ud/0we/+j+cP+2YrWB 03Dj0340VHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRQ6cY/orOuSP2cLPoA8GQ qd76a8SWTv+eeOqcv48fWyyLwZvQW2cY/tle+tqwaGXEpw1eQtlRbFqlixMzpVoUQjyTfWZZ/97 ykgEA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Sat, 05 Oct 2024 19:23:02 +0100, Matthew Wilcox (Oracle) wrote:
> A few minor fixes; nothing earth-shattering.
> 
> Matthew Wilcox (Oracle) (3):
>   netfs: Remove call to folio_index()
>   netfs: Fix a few minor bugs in netfs_page_mkwrite()
>   netfs: Remove unnecessary references to pages
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

[1/3] netfs: Remove call to folio_index()
      https://git.kernel.org/vfs/vfs/c/fcd4904e2f69
[2/3] netfs: Fix a few minor bugs in netfs_page_mkwrite()
      https://git.kernel.org/vfs/vfs/c/c6a90fe7f080
[3/3] netfs: Remove unnecessary references to pages
      https://git.kernel.org/vfs/vfs/c/e995e8b60026

