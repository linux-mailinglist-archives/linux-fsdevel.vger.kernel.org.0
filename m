Return-Path: <linux-fsdevel+bounces-3440-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EAF2F7F499E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Nov 2023 16:04:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 800C8B21064
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Nov 2023 15:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96E464E1BA;
	Wed, 22 Nov 2023 15:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QicsN6xa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2464C3C7
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Nov 2023 15:04:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FF2DC433C8;
	Wed, 22 Nov 2023 15:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700665481;
	bh=R8l/800C1t4aeVBv808obaihkNgtc2OcSDWhmOQIVs4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QicsN6xaV/J0EboMHe/oyVshptt+RDyn3ZHegvST+aCdKef7yhpE7km402Hcd9Dc9
	 ZwSVO9GUqlNAg3W3SFImgwlQFzcaeRjXGsZ+2Qvhe2mpR+1F/DoPytn29X4dYd0ctv
	 vNQl8MFK3TKzyVDZQimLuRvL1uRJ9vJVnjYOc1NC81BlXUFEXe7OFlCZTIBhovHFx/
	 cUIS2MqZck/BTcdzM5ssmy9A9/36SRhDUbY8YHfou/97C8LEe8uCE+PPJO+RgfeTMz
	 BY02t//Rw3NI4LVn3ytOyJFMqbp0NIpl7l+pdc/7kk3hqDdnZPA7sHDzYzvWUiayIM
	 Fj5sj5G/IsfPw==
From: Christian Brauner <brauner@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Josef Bacik <josef@toxicpanda.com>,
	David Howells <dhowells@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Al Viro <viro@zeniv.linux.org.uk>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 00/16] Tidy up file permission hooks
Date: Wed, 22 Nov 2023 16:04:27 +0100
Message-ID: <20231122-gelingen-lasten-d8d28a056638@brauner>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231122122715.2561213-1-amir73il@gmail.com>
References: <20231122122715.2561213-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=2934; i=brauner@kernel.org; h=from:subject:message-id; bh=R8l/800C1t4aeVBv808obaihkNgtc2OcSDWhmOQIVs4=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTGSVTNW39Fs6C99HF9S4ETR6mDsJDaZOd/O7Yc5vkRf tB7zzbWjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgInUxzP8r7GZt23VMp57Ej/4 mYXeSs0xYZj/8XBHh8rk4B3i15MreBn+SrovevLpgpXV9gXSOVyPRSTY7+zd+e64oUmWhM18nQ1 9vAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Wed, 22 Nov 2023 14:26:59 +0200, Amir Goldstein wrote:
> During my work on fanotify "pre content" events [1], Jan and I noticed
> some inconsistencies in the call sites of security_file_permission()
> hooks inside rw_verify_area() and remap_verify_area().
> 
> The majority of call sites are before file_start_write(), which is how
> we want them to be for fanotify "pre content" events.
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

[01/16] ovl: add permission hooks outside of do_splice_direct()
        https://git.kernel.org/vfs/vfs/c/52009acbab21
[02/16] splice: remove permission hook from do_splice_direct()
        https://git.kernel.org/vfs/vfs/c/095b2d7c4b93
[03/16] splice: move permission hook out of splice_direct_to_actor()
        https://git.kernel.org/vfs/vfs/c/ead0aac245dd
[04/16] splice: move permission hook out of splice_file_to_pipe()
        https://git.kernel.org/vfs/vfs/c/74a66b648378
[05/16] splice: remove permission hook from iter_file_splice_write()
        https://git.kernel.org/vfs/vfs/c/e341582fdb7c
[06/16] remap_range: move permission hooks out of do_clone_file_range()
        https://git.kernel.org/vfs/vfs/c/6ddfddac4922
[07/16] remap_range: move file_start_write() to after permission hook
        https://git.kernel.org/vfs/vfs/c/a1fffabd504c
[08/16] btrfs: move file_start_write() to after permission hook
        https://git.kernel.org/vfs/vfs/c/ca267f48c8e9
[09/16] coda: change locking order in coda_file_write_iter()
        https://git.kernel.org/vfs/vfs/c/aee32ff62e8b
[10/16] fs: move file_start_write() into vfs_iter_write()
        https://git.kernel.org/vfs/vfs/c/f02abb810579
[11/16] fs: move permission hook out of do_iter_write()
        https://git.kernel.org/vfs/vfs/c/11dc9bc73318
[12/16] fs: move permission hook out of do_iter_read()
        https://git.kernel.org/vfs/vfs/c/c8b86e93b6e2
[13/16] fs: move kiocb_start_write() into vfs_iocb_iter_write()
        https://git.kernel.org/vfs/vfs/c/a4e6c478189e
[14/16] fs: create __sb_write_started() helper
        https://git.kernel.org/vfs/vfs/c/2a7b49f698d0
[15/16] fs: create file_write_started() helper
        https://git.kernel.org/vfs/vfs/c/0d3b7690bd1f
[16/16] fs: create {sb,file}_write_not_started() helpers
        https://git.kernel.org/vfs/vfs/c/c88b5e392b2e

