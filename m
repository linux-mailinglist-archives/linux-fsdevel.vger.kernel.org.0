Return-Path: <linux-fsdevel+bounces-19982-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C52078CBBC7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 May 2024 09:14:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE8E11C2173A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 May 2024 07:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CCE07C6D4;
	Wed, 22 May 2024 07:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KxUDh4A7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD47D7BAF7;
	Wed, 22 May 2024 07:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716362072; cv=none; b=OtynCIumofW9ft4nVC+2Zv8t+gBnAsSErWvhhP4Z1Wk39znpjNAhfYbMw0uJUFo8/tHvOSajaFzFde3Bp4qxJAdjquI1qK+2mHbL4TRXjSnbgYyd76jw+f9CXqKXiHWIyUCmXixjowAaLX/UjF/jWcmThd4TiB68BlCu9VjdU6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716362072; c=relaxed/simple;
	bh=o7FelwEYe06bUj5gigSKOWEN1hyHxbXUGTMgm7PhL9Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h1O/f4ypO85NuEnv9Q6up9NtvMkJ1HkNgqo+WbDIBHyo7FoU1u6QnN9XGupjfsdi3UXw4537iE9SEn6LRxUfMIe4i1F5TDQlcNhHLU7jeHRJKMhsctgtyRYMfEUEVMrbWYoS7HQdA89hm3YT9OMPoiRK/jlDOAju4G8/WJyEf9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KxUDh4A7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8693DC2BD11;
	Wed, 22 May 2024 07:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716362071;
	bh=o7FelwEYe06bUj5gigSKOWEN1hyHxbXUGTMgm7PhL9Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KxUDh4A73NHTC6Uo8h5Ypzmu20FS3YX6acckvMWdiTXlPRBjHCRk0EBbJl9S64aw7
	 fvi2zjqqoHjbD8jQyI1RMGX+yQx0yPJAEnWSLlpK9yTT0aatU/SRonCaKuyKmVGbNH
	 3HqrddQuCxvyfWafJoMknIMWKMebVIPmr5pz3n4sa9urXda/xmbnk9J8jWy3L7ypdD
	 V1UvaZyoATvDw+yBeJObfOx70Af9oi6mTC5NVQw+byDXa4FRe2gG5/Hu+oF/RQiMBr
	 aYar/GPGVKNDfbmSkaX4NWa83bKOiAMWu4xVSJI4C1GotroqgvH+ILaWPJpAEHlyM1
	 es738P4O+j5QQ==
From: Christian Brauner <brauner@kernel.org>
To: Steve French <stfrench@microsoft.com>,
	David Howells <dhowells@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Enzo Matsumiya <ematsumiya@suse.de>,
	Jens Axboe <axboe@kernel.dk>,
	Matthew Wilcox <willy@infradead.org>,
	netfs@lists.linux.dev,
	v9fs@lists.linux.dev,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] netfs: Fix setting of BDP_ASYNC from iocb flags
Date: Wed, 22 May 2024 09:14:20 +0200
Message-ID: <20240522-weltmeere-rammt-70f03e24b8b4@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <316306.1716306586@warthog.procyon.org.uk>
References: <316306.1716306586@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1256; i=brauner@kernel.org; h=from:subject:message-id; bh=o7FelwEYe06bUj5gigSKOWEN1hyHxbXUGTMgm7PhL9Q=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaT5zvZ/VJrSsYxv51y3TfmcQte5fa4UZafWckj9j9mw2 PJaYfO/jlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIlUrWD4n5pi88L397Z6Xbv2 O1r3t/Z9dXA+H9T4a6/78o9nxIPZgxkZWj89LFFMex2/tuIsx+tL+ZE/tl/mFI60cZxvEvT/lTY 7AwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Tue, 21 May 2024 16:49:46 +0100, David Howells wrote:
> Fix netfs_perform_write() to set BDP_ASYNC if IOCB_NOWAIT is set rather
> than if IOCB_SYNC is not set.  It reflects asynchronicity in the sense of
> not waiting rather than synchronicity in the sense of not returning until
> the op is complete.
> 
> Without this, generic/590 fails on cifs in strict caching mode with a
> complaint that one of the writes fails with EAGAIN.  The test can be
> distilled down to:
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

[1/1] netfs: Fix setting of BDP_ASYNC from iocb flags
      https://git.kernel.org/vfs/vfs/c/33c9d7477ef1

