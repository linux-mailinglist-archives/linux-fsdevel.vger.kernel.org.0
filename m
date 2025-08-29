Return-Path: <linux-fsdevel+bounces-59650-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10CB6B3BBEF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 15:09:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCBB916E015
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 13:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E07F231A070;
	Fri, 29 Aug 2025 13:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LPlN497K"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FFBF201269;
	Fri, 29 Aug 2025 13:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756472933; cv=none; b=tWFFnj7Qk6oalRlElyw64qlLahegEJvEfJNlneI6r1+Kx2MFuzPdoYZJKEg2LUFG2VQC67YiFo981X7fpl706Lw1TNfX6z/y/jTcX5jdSEr2TgYRo7kfwmwDSz+1xh/0Ja6avjWFL4a4wqhdcdREFablsTaJWT+wIRq6wiCrFgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756472933; c=relaxed/simple;
	bh=HNhElk6O6yr8fnJ6k+gUmmX+WPm8sA7imTwzzWeNjrw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=APHr23+SQjhaQA959BI/iPtgEvJijM6XwanwVm2TdRf3Q2hXi/WNhnv1TlaGwEK1CAEm3iMkzWPH1WzJMWYdNpYTg7JdJfb4eeVF73TrESArRlU4UMAcYsGbj0vIWQUyaH5DHE3AEhNDEdWWwPiJfVt5VoaUrXrqioDJelf64Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LPlN497K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 987A8C4CEF0;
	Fri, 29 Aug 2025 13:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756472932;
	bh=HNhElk6O6yr8fnJ6k+gUmmX+WPm8sA7imTwzzWeNjrw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LPlN497Koi+SRT1XI93/Zw5F/2EInzp+QOzoLsNZgf+6/vUpdI0YXkL9MzKJaBAsM
	 IANaKDIiUX+kdCAtSr9mfM/LyyQK3+7V6uIWRk5bhPKpahT02Vo7n4tf1dLJDhwAwS
	 W7Oz0rMNWK7HL4qGdCrgYjCP8KkGccXpxUhhaY6WcGJ4hoAloTgrtp6OtmXPTpW3J8
	 xwDXJyMMsC4gPIu7xP0V/0bBzSq2W8bUwU4iH0H45h6VPWrR+mZDvxEa/gvMmT0ALa
	 FqLfiLehpRvDCbp38J3uOCVkOfck4nqXTVtOJxYcU8lTI+8jNXgrrWOS4jpvrLP+NM
	 6absynvy86www==
From: Christian Brauner <brauner@kernel.org>
To: Lauri Vasama <git@vasama.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Jan Kara <jack@suse.cz>,
	Simon Horman <horms@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Eric Dumazet <edumazet@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH] Add RWF_NOSIGNAL flag for pwritev2
Date: Fri, 29 Aug 2025 15:08:38 +0200
Message-ID: <20250829-laufpass-zahmen-3dd1924da2ad@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250827133901.1820771-1-git@vasama.org>
References: <20250827133901.1820771-1-git@vasama.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1630; i=brauner@kernel.org; h=from:subject:message-id; bh=HNhElk6O6yr8fnJ6k+gUmmX+WPm8sA7imTwzzWeNjrw=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRsXBa3LVp0ZrhXQOKSe8f3KO1O898fk7P1kfDpmOfKb Wf+F0bHdZSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzk6EtGhpM6tv4rbspoWewI Xrv+j3rD/KXzDr1KYZXP3tft7Rc9h4nhD8+K1+IvPc5r8MVtPBQlzre4munRrbpljMucHHl2M/y 7wgoA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Wed, 27 Aug 2025 16:39:00 +0300, Lauri Vasama wrote:
> For a user mode library to avoid generating SIGPIPE signals (e.g.
> because this behaviour is not portable across operating systems) is
> cumbersome. It is generally bad form to change the process-wide signal
> mask in a library, so a local solution is needed instead.
> 
> For I/O performed directly using system calls (synchronous or readiness
> based asynchronous) this currently involves applying a thread-specific
> signal mask before the operation and reverting it afterwards. This can be
> avoided when it is known that the file descriptor refers to neither a
> pipe nor a socket, but a conservative implementation must always apply
> the mask. This incurs the cost of two additional system calls. In the
> case of sockets, the existing MSG_NOSIGNAL flag can be used with send.
> 
> [...]

Applied to the vfs-6.18.misc branch of the vfs/vfs.git tree.
Patches in the vfs-6.18.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.18.misc

[1/1] Add RWF_NOSIGNAL flag for pwritev2
      https://git.kernel.org/vfs/vfs/c/db2ab24a341c

