Return-Path: <linux-fsdevel+bounces-3656-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 437007F6E00
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 09:23:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F05A328157F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 08:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 721BBBA55;
	Fri, 24 Nov 2023 08:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sh9eqW08"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A079464;
	Fri, 24 Nov 2023 08:23:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBF3DC433C7;
	Fri, 24 Nov 2023 08:23:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700814228;
	bh=LrRVKQE2XcERqmhniulq0tphZlP+sJeXmy4fmrLo8uc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Sh9eqW08agl90O9uwi4juCSwfkd+cwWzHLVUECTyJkmVVHK3IRdozH1c2fJVL1Htd
	 tx6pljZPU7egTdFsIxvaxvfHeRFgxxe9ceV/DRRHqvsITdJ5Y/hzcFfivArUlo0KCf
	 lEvSccqFMTGX6g8XtYBF1/tyBiz4Kwv+wdjFPTyBgrwz3wCGS/N2yK7V0N2+evxToJ
	 rYbN0crbznVGC9c4cX3R98kD0XVtDTRM4PTDCyHxnaslLJ9EU9s2XSTtVKeEGeV0zF
	 8JvTb3ybpfwftlFDfX6pJHFNJVTTuN962k26KE056qNyj3iqlbNC6d000CmByDtvM3
	 V01JKKa009O0Q==
From: Christian Brauner <brauner@kernel.org>
To: "Martin K . Petersen" <martin.petersen@oracle.com>,
	Amir Goldstein <amir73il@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Jan Kara <jack@suse.cz>,
	Josef Bacik <josef@toxicpanda.com>,
	David Howells <dhowells@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Al Viro <viro@zeniv.linux.org.uk>,
	linux-fsdevel@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	target-devel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] scsi: target: core: add missing file_{start,end}_write()
Date: Fri, 24 Nov 2023 09:23:31 +0100
Message-ID: <20231124-entsolidarisierung-belag-48fb5c033128@brauner>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231123092000.2665902-1-amir73il@gmail.com>
References: <20231123092000.2665902-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1203; i=brauner@kernel.org; h=from:subject:message-id; bh=LrRVKQE2XcERqmhniulq0tphZlP+sJeXmy4fmrLo8uc=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQmxDZZv33Kue2N/ZnKoOrivAUfVjYzcS+9NEfgU1Tsh +R5Fz597ChlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZiI0QOGfxYnp32Zfv/hh+lr KkNvehxy2z/ZwnCJxjp/TU2ZCtMqoS2MDGdu7g9bXrZE/9aaNJn8dc8WaJROfZA++VL/E9vi6bv 0D7MCAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Thu, 23 Nov 2023 11:20:00 +0200, Amir Goldstein wrote:
> The callers of vfs_iter_write() are required to hold file_start_write().
> file_start_write() is a no-op for the S_ISBLK() case, but it is really
> needed when the backing file is a regular file.
> 
> We are going to move file_{start,end}_write() into vfs_iter_write(), but
> we need to fix this first, so that the fix could be backported to stable
> kernels.
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

[1/1] scsi: target: core: add missing file_{start,end}_write()
      https://git.kernel.org/vfs/vfs/c/c85ff53e59e8

