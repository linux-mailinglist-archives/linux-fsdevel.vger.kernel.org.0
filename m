Return-Path: <linux-fsdevel+bounces-34446-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 54F099C58B3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 14:14:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DE2B1F2251D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 13:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5EBE70830;
	Tue, 12 Nov 2024 13:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NSEglA3B"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2A5433C0;
	Tue, 12 Nov 2024 13:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731417231; cv=none; b=Enj8IMDEtGGZv3R3b+4O2pI1MBr2XJfQsU5DdmcKoGw7QF00+IRTJ0eZnfTmW4FTvjYZOeMz/+NV4l0+JsfIUHf5BfyY6D7uNaFGArue2J8mstbc+74RVASwpwEsCkZSd72mTTxhWZw+5Vf50CkelU9pXS2OGEF3vcC0TUulLQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731417231; c=relaxed/simple;
	bh=MeBBvy90U/UVGE9TEeR16NKENnT4xKX2C/U++xYC8gk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AvExsr2mKBWiBJLjh5+p8NvD1E4LhTFzMHRuKBAlC1JNuS6e6FhiraMkdL3lvynABPq+/Jpd8K2xAfI14JJUb+IXdK8414fuxU5NRKw0Norn8swDiSkjGZYzCt/zFirIqhp3y88TT1Y8RwigFsXoIg76fXTJaKU6dYS32hlMPiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NSEglA3B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ED85C4CECD;
	Tue, 12 Nov 2024 13:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731417230;
	bh=MeBBvy90U/UVGE9TEeR16NKENnT4xKX2C/U++xYC8gk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NSEglA3BC0UVFL/G+J9yVw2FYKs1Wd2eAxbGr1qHKMCOppCsbdN3z7DVzdRFnPPlM
	 TgVn05WjdY0Vk4yWaVrF4F6cQGJUsgogJ8TwLfikF0efMrYIfEaKhR/VhCLVuOF7XM
	 qoJiph6LnK556RHCvNRSvTiTq5NE0DQlD4o9zyvs1noqdwZhItn5oiLQq2MnF0CSDC
	 PAl0RPYYTRHZqhv+L50AZU+PW9aC7Z4FN+q0NhFTywu3TV+XTFEdtQP10vcnqfZKM/
	 feVkQ32xvFRKoGQFA8SAYxBxHcw4h86TmyZOV55YckIOngZE0SRX0+JYRzoHsf13Y/
	 3/h3bCY7fRypQ==
From: Christian Brauner <brauner@kernel.org>
To: Mohammed Anees <pvmohammedanees2003@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-aio@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jmoyer@redhat.com,
	bcrl@kvack.org,
	jack@suse.cz,
	viro@zeniv.linux.org.uk,
	willy@infradead.org
Subject: Re: [PATCH] fs:aio: Remove TODO comment suggesting hash or array usage in io_cancel()
Date: Tue, 12 Nov 2024 14:13:39 +0100
Message-ID: <20241112-begierde-skepsis-34f013abaa1f@brauner>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241112113906.15825-1-pvmohammedanees2003@gmail.com>
References: <20241112113906.15825-1-pvmohammedanees2003@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1406; i=brauner@kernel.org; h=from:subject:message-id; bh=MeBBvy90U/UVGE9TEeR16NKENnT4xKX2C/U++xYC8gk=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQbh7RM8/L5a8q+8mdHbWnMquv7q4yW1E9bb7P6R0Cs9 MyXr9Zu6ihlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjIdFlGhhUn1ZPYt0RHi6cH hG9/WtuR/0PY1s38zN0Ws13BnVcXFzMy/Kibs/jvgR2ck3muiKQk+733Kzzq8N/jVxSTytlZh2b t4QMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Tue, 12 Nov 2024 17:08:34 +0530, Mohammed Anees wrote:
> The comment suggests a hash or array approach to
> store the active requests. Currently it iterates
> through all the active requests and when found
> deletes the requested request, in the linked list.
> However io_cancel() isn’t a frequently used operation,
> and optimizing it wouldn’t bring a substantial benefit
> to real users and the increased complexity of maintaining
> a hashtable for this would be significant and will slow
> down other operation. Therefore remove this TODO
> to avoid people spending time improving this.
> 
> [...]

Applied to the vfs.misc branch of the vfs/vfs.git tree.
Patches in the vfs.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.misc

[1/1] fs:aio: Remove TODO comment suggesting hash or array usage in io_cancel()
      https://git.kernel.org/vfs/vfs/c/27e4f4fa65c2

