Return-Path: <linux-fsdevel+bounces-41374-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF28CA2E661
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 09:26:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A32C31883DD7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 08:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D6971BFE05;
	Mon, 10 Feb 2025 08:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YxErLAi/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A270B1B85D6;
	Mon, 10 Feb 2025 08:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739175981; cv=none; b=It3ywH37lYbJu2+5TaVRStxoLiqWRQ8bBe+NNkgh9JfYzQQX/woYyi61kOQyAI/LZljv+DF5d0bI/c0mwlj6Psvbrjz4++59cXOuiMqc5yA2pCkTBCP7L3t3riYgodzxBCYQ75/9YC0m1yRR7DxAnTEuO82Bwhteb/7SZbea8+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739175981; c=relaxed/simple;
	bh=5urbR4rIwHqeAiOUkrF6k1054cNQnB2RdKLoeznPyLE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cpdrXng0Bx9vIcqXKIcFbqB1o4l/UyYW30vL9mGNsHyQEaJ/pirbsuiSxA2Uh+L01mzvttl8IB9We1V5zAfkp0k+9x9rlwY7xwSCqrxLLmBv7JARzLixRj1AUnXQPvpb8nKft7cYTT8371bhbtfDLKykJqhKj2/doZzYBAJI4R4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YxErLAi/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2CA8C4CEE4;
	Mon, 10 Feb 2025 08:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739175981;
	bh=5urbR4rIwHqeAiOUkrF6k1054cNQnB2RdKLoeznPyLE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YxErLAi/Oyz8lGrKaeA+EkAtWjfBdKb0UG4u60ZNg1PLu6GNe9O9+BvTbVwX0Vgxu
	 cJs6FBxt+9UvPbr5n8USCm10DQanNA8dq9ixHkYX77Vc/BwcWtIJwMy7FJKxMcne7t
	 MK9oVKi/2rABCiBFm9L3o37uAxON0El0xrMsjGlW5E2eYYoUmzm8Eukx7AuPtz77Kg
	 VRndGw3RCp/x3yg5vmQsHvSPKmfcjoTl7rrDWkXFY8n1nYRpdWPDUE8+SiMzH/Z9bs
	 Y2Ut/w6TF7ChbJJ3qzoloNNKoXs4Z18JG2dWMOscGiZD8lQn5YVlw+gKuorq9Nn2me
	 LWgBxqSDe5cKA==
From: Christian Brauner <brauner@kernel.org>
To: NeilBrown <neilb@suse.de>
Cc: Christian Brauner <brauner@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <sfrench@samba.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Tom Talpey <tom@talpey.com>,
	Paul Moore <paul@paul-moore.com>,
	Eric Paris <eparis@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-bcachefs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	linux-cifs@vger.kernel.org,
	audit@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>
Subject: Re: [PATCH 0/2] VFS: minor improvements to a couple of interfaces
Date: Mon, 10 Feb 2025 09:25:26 +0100
Message-ID: <20250210-enten-aufkochen-ffecc8b4d829@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250207034040.3402438-1-neilb@suse.de>
References: <20250207034040.3402438-1-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1428; i=brauner@kernel.org; h=from:subject:message-id; bh=5urbR4rIwHqeAiOUkrF6k1054cNQnB2RdKLoeznPyLE=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSv3KEQEC01YfKub6Y5H/erlyVXHp+wRHOb7dFXgb+u6 MQfu2y7u6OUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAij54w/K8+INgr8++dbeqq TIaJbE9EDcw8l6jXCuUkKvUu4L9edZSR4e2jaD+PG9VXbLLfez3csq/jTsahVULObdKre59mX0+ MZwEA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Fri, 07 Feb 2025 14:36:46 +1100, NeilBrown wrote:
>  I found these opportunities for simplification as part of my work to
>  enhance filesystem directory operations to not require an exclusive
>  lock on the directory.
>  There are quite a collection of users of these interfaces incluing NFS,
>  smb/server, bcachefs, devtmpfs, and audit.  Hence the long Cc line.
> 
> NeilBrown
> 
> [...]

I've taken your first cleanup. Thanks for splitting those out of the
other series.

---

Applied to the vfs-6.15.misc branch of the vfs/vfs.git tree.
Patches in the vfs-6.15.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.15.misc

[1/2] VFS: change kern_path_locked() and user_path_locked_at() to never return negative dentry
      https://git.kernel.org/vfs/vfs/c/2ebf0c6b48d8
[2/2] VFS: add common error checks to lookup_one_qstr_excl()
      https://git.kernel.org/vfs/vfs/c/4b3c043c69bc

