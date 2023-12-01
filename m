Return-Path: <linux-fsdevel+bounces-4559-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54336800B04
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 13:36:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FC252814BC
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 12:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC69025545
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 12:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rOhVodka"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B179C20B19
	for <linux-fsdevel@vger.kernel.org>; Fri,  1 Dec 2023 10:40:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92BB6C433C7;
	Fri,  1 Dec 2023 10:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701427258;
	bh=hsiXjL1q22KG/8lezoBUxiDSackrjxfbiBwC/fzDDf4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rOhVodkai4pvzID2fRwIEs+uil/lLSX+bXXP6EnKBowo43dP6EasGzq1Am9+AOyft
	 41DGVnF16jrPzogmTxyzD7pfAQ684FiRqhW2xmj0zLQ0VBoVvEzauKsrJr3Sv827VS
	 eGcgGUT+BqlJjK4PpM8+gvpWRkEG7HyhIvBAIca2ba+R5T2C1EOmONlXV6vILeyrIl
	 PXRGwu771MuYj1Mq7ySWJHCyeIxqbAsDaoEMTMbffbLqrcBURHZIoWCa153c0a2sfw
	 go5yJRwxelpi67ibWTWiNKh/v4Wylk/katHXF4cGEIcE9Y0iBf+5vEKk3nHS02gHfe
	 ay7/1jc6qAKww==
From: Christian Brauner <brauner@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Christoph Hellwig <hch@lst.de>,
	Jan Kara <jack@suse.cz>,
	David Howells <dhowells@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Al Viro <viro@zeniv.linux.org.uk>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] Avert possible deadlock with splice() and fanotify
Date: Fri,  1 Dec 2023 11:40:43 +0100
Message-ID: <20231201-gebahnt-gnade-3c6659c5d486@brauner>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231130141624.3338942-1-amir73il@gmail.com>
References: <20231130141624.3338942-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1446; i=brauner@kernel.org; h=from:subject:message-id; bh=hsiXjL1q22KG/8lezoBUxiDSackrjxfbiBwC/fzDDf4=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRm7tC689U96MQ3ty8KyyZlmwT+mSlo8cqv+fyCyz+8N Oe5bWfT6yhhYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZiItDbD//COsx88z1k52byV n3Bn9w1p+2X7q7mueNuxFS3Yv+LaLRaGH+2+z02WqnX+/DlZsrLzI5NzetdMrYkcCixLc6f/Ob+ ECwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Thu, 30 Nov 2023 16:16:21 +0200, Amir Goldstein wrote:
> Christian,
> 
> Josef has helped me see the light and figure out how to avoid the
> possible deadlock, which involves:
> - splice() from source file in a loop mounted fs to dest file in
>   a host fs, where the loop image file is
> - fsfreeze on host fs
> - write to host fs in context of fanotify permission event handler
>   (FAN_ACCESS_PERM) on the splice source file
> 
> [...]

Applied to the vfs.rw branch of the vfs/vfs.git tree.
Patches in the vfs.rw branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.rw

[1/3] fs: fork splice_file_range() from do_splice_direct()
      https://git.kernel.org/vfs/vfs/c/42a29fdc3202
[2/3] fs: move file_start_write() into direct_splice_actor()
      https://git.kernel.org/vfs/vfs/c/8b524ba13575
[3/3] fs: use do_splice_direct() for nfsd/ksmbd server-side-copy
      https://git.kernel.org/vfs/vfs/c/05ee2d85cd4a

