Return-Path: <linux-fsdevel+bounces-27354-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E12496082B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 13:09:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28BE0B21689
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 11:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4DCF19EEBF;
	Tue, 27 Aug 2024 11:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rJjteGJ4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19367155CBD;
	Tue, 27 Aug 2024 11:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724756930; cv=none; b=iRo+uiTBhaCMyrBOHEePJMcZGAcrZH82wLokZ/Ekp5ZfVYXx4KZh3SAAGsOqmVkS7ds7jFFWJuhwiS4HbVNYs6qnFh8k2bk+dILwZl9qKYufdEiFC0HPCDLrwYkR3Aj9+gwn+HthGVSutnlcKUttSXaQxMto8rfwbRKPqlTqo2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724756930; c=relaxed/simple;
	bh=0jqwgqPIXNN1LmGJDYYxJ3TQrTr4aXoEwYHIdHuw+8o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MY3ZykzO+j3Ja4x7ZykIzAd6El6/5sBU+EiMeKiLZ+T5c65cgDNuKJp09kbp4YgWCvld9fwk9iXYJi13z39YfYEpzqz0uR7mi8m8Ja1HY8pYB29aC5bydBxgr5SURFLSyas9M8e0GazRbUMTotZbm2ye33nBAb2nIdDJk8L1oiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rJjteGJ4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1CD8C8B7A0;
	Tue, 27 Aug 2024 11:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724756929;
	bh=0jqwgqPIXNN1LmGJDYYxJ3TQrTr4aXoEwYHIdHuw+8o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rJjteGJ4vHkow673wpU3uvzb0qWFO4R5Vbi/MOwUpeey0EppkCDijPpJJaEIZGPEh
	 4i7Ty9XwKiVVaj6QVVZrUg9df128mUjSjB+3tgJwmmGlVwj1h+ZiVwRaddPKD6PdUx
	 gB/b44o9dKnbygwJD/8Az3pTdfE345zu1ytwhL0YIkmdvkp3HLud6xVim2n8Y/g4oJ
	 HidNpm9+B49ogWM4b+AzTsGWiXbwiBa6dPqcADEbZxXZvD/a8U2W/VKFkKVtYNo/k+
	 J0KH/4u4u13sv6ID/ctAy59+HCSF/D6GokVxOVFywqceUVvxzLTFMhIS/C504OPL22
	 K1JXRWIsFc8Wg==
From: Christian Brauner <brauner@kernel.org>
To: linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	gfs2@lists.linux.dev,
	linux-block@vger.kernel.org,
	dlemoal@kernel.org,
	djwong@kernel.org,
	Josef Bacik <josef@toxicpanda.com>
Cc: Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH][RFC] iomap: add a private argument for iomap_file_buffered_write
Date: Tue, 27 Aug 2024 13:07:43 +0200
Message-ID: <20240827-inmitten-gletscher-db68c1048145@brauner>
X-Mailer: git-send-email 2.45.2
In-Reply-To:  <7f55c7c32275004ba00cddf862d970e6e633f750.1724755651.git.josef@toxicpanda.com>
References:  <7f55c7c32275004ba00cddf862d970e6e633f750.1724755651.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1546; i=brauner@kernel.org; h=from:subject:message-id; bh=0jqwgqPIXNN1LmGJDYYxJ3TQrTr4aXoEwYHIdHuw+8o=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSd3bxrx17z38m3G2c83XVI9N7mnb9WXXU56tY+/amk7 aYDe0SSwztKWRjEuBhkxRRZHNpNwuWW81RsNsrUgJnDygQyhIGLUwAmUqfC8D99+eQNHRfZLWbE iujOfnJR5OGSpTd7qy8ufPBlqlthpeRcRoYn9w9EKBy67XJYs76qxkWmRMNJd8a7Iu9F6/o8Xl6 Y9pYfAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Tue, 27 Aug 2024 06:51:36 -0400, Josef Bacik wrote:
> In order to switch fuse over to using iomap for buffered writes we need
> to be able to have the struct file for the original write, in case we
> have to read in the page to make it uptodate.  Handle this by using the
> existing private field in the iomap_iter, and add the argument to
> iomap_file_buffered_write.  This will allow us to pass the file in
> through the iomap buffered write path, and is flexible for any other
> file systems needs.
> 
> [...]

It's in vfs.blocksize because there's other work that touches iomap in there.
But I'll likely rename the branch to something that's more generic such as
vfs.iomap at some point soon now that we have other stuff coming in.

---

Applied to the vfs.blocksize branch of the vfs/vfs.git tree.
Patches in the vfs.blocksize branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.blocksize

[1/1] iomap: add a private argument for iomap_file_buffered_write
      https://git.kernel.org/vfs/vfs/c/f143d1a48d6e

