Return-Path: <linux-fsdevel+bounces-5361-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9706980AC45
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 19:40:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDDE01C20A28
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 18:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2868937161
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 18:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bbkhse/A"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9CB73C68F
	for <linux-fsdevel@vger.kernel.org>; Fri,  8 Dec 2023 17:56:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BA6DC433C9;
	Fri,  8 Dec 2023 17:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702058211;
	bh=7Cm03JDUfzMBiJY70ZWcE2ed62mODc4a3RkEOgQjNrE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Bbkhse/ARuPKy5cQhiEDwiq/4GEpmRYA3CjfE7Ebql4ylH/U7jBA7sjtQ6tnDd37f
	 JEUmk0dslgcFFThvNeUbPIDdkloKUf9X43vKuCNW6xLinA5cQHRIIBlYo0KeuA4ii1
	 iNs08jezlYtMlYBjRTwCY5j+ZtAQoN3+x6D/Z0ZEVC1XxOOquo7r76NvZ2Q0Vd6fch
	 wWdoL0wrtskpjjBjFJXmCU4qA0HYvPiqG+K5Zek01rpWc8BsFiQOtK75Kf4/Ktb6Cx
	 8Z8bNAva3X3072XkBKlsERe81JTQq4sCPNLjCGS/zhlMPkZeUiKaNAfdDNM3+fA+px
	 3Bh5qp0FIgp5A==
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>,
	Amir Goldstein <amir73il@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Christoph Hellwig <hch@lst.de>,
	David Howells <dhowells@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Al Viro <viro@zeniv.linux.org.uk>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/4] Prepare for fsnotify pre-content permission events
Date: Fri,  8 Dec 2023 18:54:56 +0100
Message-ID: <20231208-jahrbuch-flexibel-de04d9d2e163@brauner>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231207123825.4011620-1-amir73il@gmail.com>
References: <20231207123825.4011620-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1511; i=brauner@kernel.org; h=from:subject:message-id; bh=Zj3asIPK4xEssQLQO+iPCxliaNkvf8cdVGDgQXO+7EA=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQWR+R3WgtP77IoefKirWRnk5L3sl0priw+nNbBvQIaZ bV26XIdpSwMYlwMsmKKLA7tJuFyy3kqNhtlasDMYWUCGcLAxSkAE/n9gJFhi/b8p96NW47qyL1s bSi5EpJjz2zzP5MlLE3dYGO99uRbDP9db234z+EhoVb9vLL25c7Fk9pZV7JPPLrq1L2Orv6+vR4 sAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Thu, 07 Dec 2023 14:38:21 +0200, Amir Goldstein wrote:
> I am not planning to post the fanotify pre-content event patches [1]
> for 6.8.  Not because they are not ready, but because the usersapce
> example is not ready.
> 
> Also, I think it is a good idea to let the large permission hooks
> cleanup work to mature over the 6.8 cycle, before we introduce the
> pre-content events.
> 
> [...]

Picking this up to get it into -next rather sooner than later. But @Jan,
I'll wait for your Acks.

---

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

[1/4] fs: use splice_copy_file_range() inline helper
      https://git.kernel.org/vfs/vfs/c/4955c918c9e5
[2/4] fsnotify: split fsnotify_perm() into two hooks
      https://git.kernel.org/vfs/vfs/c/d2fc40363ab1
[3/4] fsnotify: assert that file_start_write() is not held in permission hooks
      https://git.kernel.org/vfs/vfs/c/24065342b941
[4/4] fsnotify: pass access range in file permission hooks
      https://git.kernel.org/vfs/vfs/c/e5c56a33657b

