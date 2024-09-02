Return-Path: <linux-fsdevel+bounces-28259-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE9089689A7
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2024 16:16:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 678AA1F23B2F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2024 14:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA1DE19E980;
	Mon,  2 Sep 2024 14:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R9ii7mo0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E356AEC4;
	Mon,  2 Sep 2024 14:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725286605; cv=none; b=Um5/ZWmJoY2actpYkUp0lbNubhtDbht+ej3eJFZyRCeIt8uCrJVFs3MeIItui/3deRBqUJWyMVg/pzAPSH2qxSxKFvObFrRuS1omij9Km8K9B0uzUBYd9r4sqoFcdKqsBYocJAdiRnyFv58v6WQHusxbwMgDng50LvmXOS8Q3HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725286605; c=relaxed/simple;
	bh=pZJKuEon2kw+wY+aGvN7XrGtdhq0gfM6kzmz3gvUazs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZPWgDSDgKgHBDtT4QgVuDeaUhMjYxbQh1Tpy/qSKBPpneE6deDpqlZkXU4bZQ9InM5G76I7lVfOfAKGYWXwNqJdorl/RH9o512G0TZjd0HCy1wz3Iv85esGmNLJVEvM2E1jy4Gc2wLOvrS4GZqI3AMBnCiLxvj7qonDhbGxndyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R9ii7mo0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08D79C4CEC2;
	Mon,  2 Sep 2024 14:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725286604;
	bh=pZJKuEon2kw+wY+aGvN7XrGtdhq0gfM6kzmz3gvUazs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R9ii7mo0bwkh9Tff/Ayvgd4ezPg4AdPdHFqzl5k/LyQX+7xGG9YC/4HzH5Yka6hh8
	 zfwmEjNt6bCuxfsTEj/SpPmpCoPNM5MR24kKyejKV3x5ibhjireFoqEWPg3/ICePwG
	 1mH2Ckn8PzplJvzqgmsKTGpCzQuxqqFxzzlj5x9KGTzH2yUwqw+XcA7NwDrrc/Va74
	 HCBImnOz0lIgGyvL2YuHgPwFEySUg27jZNBrf9EngUpvAMD+i4iV7xwxj4r0MkI+3j
	 PrD+qUjpPInBSqhj9EsCBnFA5r6aeLKvY0S745jGoY8YEGAOogZtBXGcGAChfcn8Qs
	 beJjOa2d/rGnQ==
From: Christian Brauner <brauner@kernel.org>
To: Aleksa Sarai <cyphar@cyphar.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	Josef Bacik <josef@toxicpanda.com>,
	linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Alexander Aring <alex.aring@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH RESEND v3 0/2] fhandle: expose u64 mount id to name_to_handle_at(2)
Date: Mon,  2 Sep 2024 16:16:31 +0200
Message-ID: <20240902-klargemacht-hellt-2afa8847aed6@brauner>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240828-exportfs-u64-mount-id-v3-0-10c2c4c16708@cyphar.com>
References: <20240828-exportfs-u64-mount-id-v3-0-10c2c4c16708@cyphar.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1692; i=brauner@kernel.org; h=from:subject:message-id; bh=pZJKuEon2kw+wY+aGvN7XrGtdhq0gfM6kzmz3gvUazs=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRdPXFgQtSmpg2qx3b9dLtXr+Zk8GnWfmcrqS3Sfil+r Wd1wlOudJSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAExk7XaG/0mrl3DkrU3d+yPs R4nwPc7U1fF7OybmvzPx6e1geHN+ojHD/8j4+2mGtkd7r6t0vOzfOkXdY2ZopV5DSCnbsuiASHl HJgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Wed, 28 Aug 2024 20:19:41 +1000, Aleksa Sarai wrote:
> Now that we provide a unique 64-bit mount ID interface in statx(2), we
> can now provide a race-free way for name_to_handle_at(2) to provide a
> file handle and corresponding mount without needing to worry about
> racing with /proc/mountinfo parsing or having to open a file just to do
> statx(2).
> 
> While this is not necessary if you are using AT_EMPTY_PATH and don't
> care about an extra statx(2) call, users that pass full paths into
> name_to_handle_at(2) need to know which mount the file handle comes from
> (to make sure they don't try to open_by_handle_at a file handle from a
> different filesystem) and switching to AT_EMPTY_PATH would require
> allocating a file for every name_to_handle_at(2) call, turning
> 
> [...]

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

[1/2] uapi: explain how per-syscall AT_* flags should be allocated
      https://git.kernel.org/vfs/vfs/c/34cf40849654
[2/2] fhandle: expose u64 mount id to name_to_handle_at(2)
      https://git.kernel.org/vfs/vfs/c/9cde4ebc6f4f

