Return-Path: <linux-fsdevel+bounces-5686-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 85DBF80EDC1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 14:34:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 305CC1F21675
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 13:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8348561FC1;
	Tue, 12 Dec 2023 13:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sB4VLPoo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF41361FAF
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 Dec 2023 13:34:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9D6EC433C7;
	Tue, 12 Dec 2023 13:34:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702388070;
	bh=MiM1v2wn5YpXKPkaWSNRuHapLJpnWBwp9LVe32xOrgI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sB4VLPoob+YMrQfxj3UUG4qq1yt4D33K3N1ktaq3rrs7VxyGiuISLR+dx5w1TtTyk
	 dzZnLsTCxwstwZnLko0xn8DrQ/pRxeWD1hmf+JpztVkngXfyaBvUx1/zGJ53099P7R
	 EkLoDHzPQUGkJkDMJiTbxSd3V3iLVd45yq/yNFHGpqzmaumFsJv9BO3OC+BTvDUuge
	 MNCw3HeCCIYQgVNfDP426ppVTAXVJM76p4WGKX1zXFrSU5uAV0965o5zR8qguwr7rT
	 8nTBwrh4YPwPJwqmjDhxP54SRKMURLsVInALBw5VEkET4RSSJtcN+VoY9bYUOEL0qb
	 NH2OK2FG33eDg==
From: Christian Brauner <brauner@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Jeff Layton <jlayton@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Christoph Hellwig <hch@lst.de>,
	David Howells <dhowells@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Al Viro <viro@zeniv.linux.org.uk>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 0/5] Prepare for fsnotify pre-content permission events
Date: Tue, 12 Dec 2023 14:34:12 +0100
Message-ID: <20231212-heimkehr-yacht-6e82d99905cc@brauner>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231212094440.250945-1-amir73il@gmail.com>
References: <20231212094440.250945-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1712; i=brauner@kernel.org; h=from:subject:message-id; bh=MiM1v2wn5YpXKPkaWSNRuHapLJpnWBwp9LVe32xOrgI=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRWJIbkC9UphqnP7Hdb7cPMlK2v4GzlKLPMQ37OpaVfK ptyEoo7SlkYxLgYZMUUWRzaTcLllvNUbDbK1ICZw8oEMoSBi1MAJrKznpHh58VaZhV34XdHPPlq FnSaXWd+c//f49y6wPOPp0t2C03KZPhf/HzWPU73FGP/sjTfkBOLLtW2nLiV4Ky1QGeC+l+uI73 8AA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Tue, 12 Dec 2023 11:44:35 +0200, Amir Goldstein wrote:
> This v3 of pre-content event prep patches addresses some comments and
> replaces the v1 patches [1] that are currently applied to vfs.rw.
> 
> I started with a new cleanup patch for ssize_t return type that you
> suggested.
> 
> Patch 2 has a fix for a build error reported by kernel tests robot
> (moved MAX_RW_COUNT capping to splice_file_range()), so I did not
> retain Josef's RVB from v1 on this patch.
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

[1/5] splice: return type ssize_t from all helpers
      https://git.kernel.org/vfs/vfs/c/a6d2318cae6e
[2/5] fs: use splice_copy_file_range() inline helper
      https://git.kernel.org/vfs/vfs/c/4a919d911118
[3/5] fsnotify: split fsnotify_perm() into two hooks
      https://git.kernel.org/vfs/vfs/c/3e646f9506aa
[4/5] fsnotify: assert that file_start_write() is not held in permission hooks
      https://git.kernel.org/vfs/vfs/c/8cf3ca861605
[5/5] fsnotify: optionally pass access range in file permission hooks
      https://git.kernel.org/vfs/vfs/c/d140b20ab863

