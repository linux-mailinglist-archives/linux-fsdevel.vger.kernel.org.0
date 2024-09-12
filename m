Return-Path: <linux-fsdevel+bounces-29165-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F98B976949
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2024 14:41:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A48A8B227A3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2024 12:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65AF01A4E89;
	Thu, 12 Sep 2024 12:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DJGNzah0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3841A3023;
	Thu, 12 Sep 2024 12:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726144868; cv=none; b=W6f14yKGHx2HjsbfTvgn1wioUGNy2ogYbKUbOy0f9P9Du9n7HyB0dJVGoLkRUczZKkZhQJ9LXTQw61lVYvMI3vo+sQopzPQFc6f9BZ6wKXMhD35W16xpLwKNJjSQJYz0jyQMaXugYWp3BHKtDB9LVKeBcdrszDEQ6Pc6sj8xlnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726144868; c=relaxed/simple;
	bh=9UdpE9bRfyPWA9Gi9O6F8t+KWQsbhnFofcxVtiy2dPc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GwYTlVV36qmKfCDSTbnMxgZhVpJTY0SVhQDf7/L/9klXIy+Y8HFblKRq2FMG2R0vBfjC0aYGGVKxqL7csWnnnbGujKR21N0SNtqen9Szsbhfjfu/Eaz9j7agvshaaxHFdi+IWjCXkHLTyKQ4lAHiEtT9MKDU93Gh/9qHlmgRxGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DJGNzah0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36FCDC4CEC4;
	Thu, 12 Sep 2024 12:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726144868;
	bh=9UdpE9bRfyPWA9Gi9O6F8t+KWQsbhnFofcxVtiy2dPc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DJGNzah0uVKXY92tI4a9y87wFUcXK6fVhmQI27KD99z5aaqseFMQmb9d9+rTj+1tE
	 iaDKjNxcIjhHhb3npGMZdwc+80pxB+rACcIGfvgfgFNCnT/iUWQjW7kGpNBzo7iL8P
	 XfdHVnh4U2Qt/bdV83VjRz8v2MBL8xyD+UpXH9ONhWflWC8PttBguN5VsZuvu4K7KY
	 Oo8I3r1TkxaAWeA3NXfLt99wA9OGSO8lv4xrTeI9RR3AY9ntm/4vmGFbeZxMVFxIo/
	 FW3FV3hk1KRAMUWVzULfYkBC7T8hbMb2xaJxVprxufhTN8jcMhRgJWQsM0bIPzG1gK
	 ANwdMUzRT6rlg==
From: Christian Brauner <brauner@kernel.org>
To: Benjamin Coddington <bcodding@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	gfs2@lists.linux.dev,
	ocfs2-devel@lists.linux.dev,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Neil Brown <neilb@suse.de>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Andreas Gruenbacher <agruenba@redhat.com>,
	Mark Fasheh <mark@fasheh.com>,
	Joel Becker <jlbec@evilplan.org>,
	Joseph Qi <joseph.qi@linux.alibaba.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Alexander Ahring Oder Aring <aahringo@redhat.com>
Subject: Re: [PATCH v1 0/4] Fixup NLM and kNFSD file lock callbacks
Date: Thu, 12 Sep 2024 14:40:47 +0200
Message-ID: <20240912-jogginganzug-frucht-136525bde80c@brauner>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1726083391.git.bcodding@redhat.com>
References: <cover.1726083391.git.bcodding@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1773; i=brauner@kernel.org; h=from:subject:message-id; bh=9UdpE9bRfyPWA9Gi9O6F8t+KWQsbhnFofcxVtiy2dPc=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQ9ehhZ+3BTqo5chplhfAPnxe/XhO/y6dzUEXQ5MKl0t dF2E4P6jlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIkcvM3IME/nwhqln5dFd3/6 VV+XdOzU3X8s+z2uWZ6NT5VSfSon18rI0CUwb/uF+v157H8FNxZIiGdfivPYt1eNXbRCd7G1PZs iBwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Wed, 11 Sep 2024 15:42:56 -0400, Benjamin Coddington wrote:
> Last year both GFS2 and OCFS2 had some work done to make their locking more
> robust when exported over NFS.  Unfortunately, part of that work caused both
> NLM (for NFS v3 exports) and kNFSD (for NFSv4.1+ exports) to no longer send
> lock notifications to clients.
> 
> This in itself is not a huge problem because most NFS clients will still
> poll the server in order to acquire a conflicted lock, but now that I've
> noticed it I can't help but try to fix it because there are big advantages
> for setups that might depend on timely lock notifications, and we've
> supported that as a feature for a long time.
> 
> [...]

Applied to the vfs.misc.v6.13 branch of the vfs/vfs.git tree.
Patches in the vfs.misc.v6.13 branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.misc.v6.13

[1/4] fs: Introduce FOP_ASYNC_LOCK
      https://git.kernel.org/vfs/vfs/c/8cf9a01edc21
[2/4] gfs2/ocfs2: set FOP_ASYNC_LOCK
      https://git.kernel.org/vfs/vfs/c/2253ab99f2e9
[3/4] NLM/NFSD: Fix lock notifications for async-capable filesystems
      https://git.kernel.org/vfs/vfs/c/81be05940ccc
[4/4] exportfs: Remove EXPORT_OP_ASYNC_LOCK
      https://git.kernel.org/vfs/vfs/c/bb06326008c3

