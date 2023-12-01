Return-Path: <linux-fsdevel+bounces-4574-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A655800D47
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 15:36:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1D1AB20D08
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 14:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C48C3E470
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 14:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V8FvqvOH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A5F52554A
	for <linux-fsdevel@vger.kernel.org>; Fri,  1 Dec 2023 13:24:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6747C433C9;
	Fri,  1 Dec 2023 13:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701437068;
	bh=uRgAR/56w9wrRlY/QzWRUlSjwWNjO57UA/xB9q2FvXk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V8FvqvOHrV4E3XjCky27ISWNl2E5UoeN529yLfTLkTCBb6IIAc9wKSQZdiY0oicFN
	 g5HqP2f+T5KXow5iTJ7a7uJ9gPFg+v+6OHfkIcgsh7mnY/cpkMbMIISwCOFRcjU455
	 22MwNMGLxx7hBXfY2/zrSU4pEXcm2HOlLcqbSxPsHwxnd7ruop+XlLPgtTk7pbvt+K
	 K/EOqA8cviBvWgYNqUBxbeZwZ1X/RV9Vxgv8heRSjkP9/ihTbDTSQEsh0K6jvY2hV+
	 n1R7niDHxQmBPap+q4FpTv+77LMFB3+DvUhWkMSyLnspkWoLZi/+RqaHzHeJiu8zi/
	 42fnCM4PY+a3w==
From: Christian Brauner <brauner@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.com>,
	Jens Axboe <axboe@kernel.dk>,
	Carlos Llamas <cmllamas@google.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH RFC 0/5] file: minor fixes
Date: Fri,  1 Dec 2023 14:23:58 +0100
Message-ID: <20231201-aufzeichnen-ratsam-e353e76e0527@brauner>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231130-vfs-files-fixes-v1-0-e73ca6f4ea83@kernel.org>
References: <20231130-vfs-files-fixes-v1-0-e73ca6f4ea83@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1431; i=brauner@kernel.org; h=from:subject:message-id; bh=uRgAR/56w9wrRlY/QzWRUlSjwWNjO57UA/xB9q2FvXk=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRm3stdzBDUHbHLmHnC3S2T8z9HODVntnHYTzq4mcfjW pSJov+hjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIkYejL8r4v9as8zZ6K5tGNn 0L1VH1I6X8ewi86bpXe8xaJk2832QIZ/6pOufNDOc3LK+VZw5aCyrP3dKdnKkqvcdke1dMZt13v ICwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Thu, 30 Nov 2023 13:49:06 +0100, Christian Brauner wrote:
> * reduce number of helpers
> * rename close_fd_get_file() helprs to reflect the fact that they don't
>   take a refcount
> * rename rcu_head struct back to callback_head now that we only use it
>   for task work and not rcu anymore
> 

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

[1/5] file: s/close_fd_get_file()/file_close_fd()/g
      https://git.kernel.org/vfs/vfs/c/3c66314bc279
[2/5] file: remove pointless wrapper
      https://git.kernel.org/vfs/vfs/c/316e9855e905
[3/5] fs: replace f_rcuhead with f_tw
      https://git.kernel.org/vfs/vfs/c/a057c426045d
[4/5] file: stop exposing receive_fd_user()
      https://git.kernel.org/vfs/vfs/c/64d002ef7cbf
[5/5] file: remove __receive_fd()
      https://git.kernel.org/vfs/vfs/c/e333c8549ed7

