Return-Path: <linux-fsdevel+bounces-18715-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D823A8BBA51
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 May 2024 11:43:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85B95281E62
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 May 2024 09:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EEED17996;
	Sat,  4 May 2024 09:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FZZ/ZUUW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680955234;
	Sat,  4 May 2024 09:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714815821; cv=none; b=pZhIARzpnuK3M44yA+JI9zBBsl/uzgccCRf7nOisT+H13payMOl6Mhllh50CsBgU+Ejcm80eEuVlTjF7xCuw1/acwsB64AAorkmFdcFBaeLPRzLqIev1YeUwtuUJcqin94GsqmpF0u1VIXYFvqide0h2M9gXRAIbiZxkMb/A9iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714815821; c=relaxed/simple;
	bh=ZCpQBWEVkdN3kA167HpH494pjla/nVIxS8umjqDss8A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MdAg6mmYj3altVFozaMIGFbLOIXWAURDnWRcwrWjrWH1ZVhj+tAq5bur5DG+nh2k+DXWuN+m8lI5m6ymWcoWTvko+xUY2uckkfjjNxiHWROTP+CkH9Gbc8ATXv9taTanGrdcBRlA3fYp6puhqB8yn4X8PJNeGZOxYPAuo8h6jcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FZZ/ZUUW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DDECC072AA;
	Sat,  4 May 2024 09:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714815821;
	bh=ZCpQBWEVkdN3kA167HpH494pjla/nVIxS8umjqDss8A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FZZ/ZUUWgQb3Wkr0+yC1HJyycrN5yQqKhRuwh1xm6GLfChUXw1PRedSdlfhh531Mw
	 9+T+YO5nGVagD4zM7nftEw7/qpuwdGGx5Svs/eqF0KnZC9pHa6e/CwLeftRrC/Mytt
	 iyk5ySA0416azIV6ZhYSok4fCZGRmXNoVEE1o2ycfqcogEIfLMm9I1P7VCEOLCZqdb
	 jLzEuSM4tY93UbqRqXCY+korpa3gQCit+bQJ38ZdIb5eVD/rLRX8UFLUwUUFtYFHj1
	 iaJlkY4kWMYgmSBwuNnf5qwieGqFa8b0ZJ/p73ld7Rqrm4iUkvlrh6HmZ+nGMdxw2o
	 OOTeu1lVqQbgQ==
From: Christian Brauner <brauner@kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jens Axboe <axboe@kernel.dk>,
	Jann Horn <jannh@google.com>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] fs: WARN when f_count resurrection is attempted
Date: Sat,  4 May 2024 11:43:32 +0200
Message-ID: <20240504-redlich-amtlich-b381220dfabb@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240503201620.work.651-kees@kernel.org>
References: <20240503201620.work.651-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1236; i=brauner@kernel.org; h=from:subject:message-id; bh=ZCpQBWEVkdN3kA167HpH494pjla/nVIxS8umjqDss8A=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSZMbve9H7jOzty2Q5/9wM+HzpsrJfnOmbbzxWNn5iks N5e1mB2RykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwEQM3zD8s57yuPmD/+a1fQ0z 618Xf16z6bFV/ufE/6vXL3+1uXnGo+sMf7gbX6hy7tNst9hV0XCIj+/iv8AnbC93Pv8fot3e/lJ Xhx0A
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Fri, 03 May 2024 13:16:25 -0700, Kees Cook wrote:
> It should never happen that get_file() is called on a file with
> f_count equal to zero. If this happens, a use-after-free condition
> has happened[1], and we need to attempt a best-effort reporting of
> the situation to help find the root cause more easily. Additionally,
> this serves as a data corruption indicator that system owners using
> warn_limit or panic_on_warn would like to have detected.
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

[1/1] fs: WARN when f_count resurrection is attempted
      https://git.kernel.org/vfs/vfs/c/f6bdc7865ef4

