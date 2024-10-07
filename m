Return-Path: <linux-fsdevel+bounces-31160-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F5609929A8
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 12:59:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61ED9284287
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 10:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD4E71D2F5C;
	Mon,  7 Oct 2024 10:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xo6a7QoP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F386315D5C1;
	Mon,  7 Oct 2024 10:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728298714; cv=none; b=jwJnNg5UFPdwvncNbgOHpU3ge8MnLePNH36mNBmYPLDggaqB9IT8bqjihmIFsdr5KXyjsX0mx4uSFYtFuKLPIlKr1f4AwljXKeq8P3ta/lVcf9uPMSUGDYTmmbJLaqkhOQNejJk0wpQTg4am/SD+QuWHtlXUmDGDo0CY65H3Cn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728298714; c=relaxed/simple;
	bh=2GHIYkn8cRFjuA6UoXjds38baJgePZQPA32Pa4pACIs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lRDly8FY6G9BuBtQstwR5mm4mJtcBabfECSTlYEtxqE1Uv96++qT8p1FEvkiQLz0f7EEMKYB01BCaCk8Kfrrp7ZhTPc74i6jT5TO5ixuf3VGwXTC8Baf7HvZGQXZ/JOqeEWohuJnTZvMnJSNTd/Ia7oAmWxr9aASZNiiBluOXvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xo6a7QoP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69F3CC4CECF;
	Mon,  7 Oct 2024 10:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728298713;
	bh=2GHIYkn8cRFjuA6UoXjds38baJgePZQPA32Pa4pACIs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Xo6a7QoPaAsdhkEDock0VKt30RgKQGDYB55iSjs8d7YTjilKAWw7i3RESilp0cQmJ
	 RkjDVaYeEP4FP9Um0SKIfeDcDl7H+Fi+NhKi0FBYdFB987Lxfsc/g9l1JNp8UGKwMc
	 Fw4+iKLZ4j5+PeS1HlhU82WbFMjMgy9PbJI3nNlnMDRZI+xMrTIf9oliBkKKNKIEUV
	 3iQt4cjUHMHjHCiQn6OAZh2AOaoIPFY3DYE1VAJSG1MGdziqr64pvzgt8d9LGQCH6l
	 6Yp4ik5VqzQOvKusiZPsiQyiGE/GDJ+EKPs8F/8xOnQ5XAM59NbuIRCxgjag482bXQ
	 /nWr7X/hM+SpQ==
From: Christian Brauner <brauner@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>,
	Jeff Layton <jlayton@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	linux-mm@kvack.org,
	John Stultz <jstultz@google.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Randy Dunlap <rdunlap@infradead.org>,
	Chandan Babu R <chandan.babu@oracle.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	Hugh Dickins <hughd@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>
Subject: Re: (subset) [PATCH v10 00/12] timekeeping/fs: multigrain timestamp redux
Date: Mon,  7 Oct 2024 12:58:21 +0200
Message-ID: <20241007-restlaufzeit-birnen-2f412852441e@brauner>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241002-mgtime-v10-0-d1c4717f5284@kernel.org>
References: <20241002-mgtime-v10-0-d1c4717f5284@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=2375; i=brauner@kernel.org; h=from:subject:message-id; bh=2GHIYkn8cRFjuA6UoXjds38baJgePZQPA32Pa4pACIs=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQz7zt3ROG96vKmhmAJRb2iW0lPrWYvcrN65X025sO3H TIF+Vq3O0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACZSuo7hD++GxO7jd4sfeZ2Y e2VOTlbbRvlo2xPWddtPcQQeKVu3dBrDP+O0xuMVC6u2NJnKzzd25XLIvFWufkOs6q/e5LaD4Z3 LWQE=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Wed, 02 Oct 2024 17:27:15 -0400, Jeff Layton wrote:
> This is a replacement for the v6 series sitting in Christian's
> vfs.mgtime branch. The main changes here are to the changelogs,
> documentation and comments. I've also moved the timekeeping patches to
> the front of the series, and done some minor cleanups.
> 
> The pipe1_threads test shows these averages on my test rig with this
> series:
> 
> [...]

I've merged the tag that Thomas provided with the time specific changes and
pulled the remaining patches - excluding 01/12 and 02/12.

---

Applied to the vfs.mgtime branch of the vfs/vfs.git tree.
Patches in the vfs.mgtime branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.mgtime

[03/12] fs: add infrastructure for multigrain timestamps
        https://git.kernel.org/vfs/vfs/c/4e40eff0b573
[04/12] fs: have setattr_copy handle multigrain timestamps appropriately
        https://git.kernel.org/vfs/vfs/c/b82f92d5dd1a
[05/12] fs: handle delegated timestamps in setattr_copy_mgtime
        https://git.kernel.org/vfs/vfs/c/d8d11298e8a1
[06/12] fs: tracepoints around multigrain timestamp events
        https://git.kernel.org/vfs/vfs/c/a80f53809ccc
[07/12] fs: add percpu counters for significant multigrain timestamp events
        https://git.kernel.org/vfs/vfs/c/7b1aba010c47
[08/12] Documentation: add a new file documenting multigrain timestamps
        https://git.kernel.org/vfs/vfs/c/95c6907be544
[09/12] xfs: switch to multigrain timestamps
        https://git.kernel.org/vfs/vfs/c/0f4865448420
[10/12] ext4: switch to multigrain timestamps
        https://git.kernel.org/vfs/vfs/c/e44ab3151adc
[11/12] btrfs: convert to multigrain timestamps
        https://git.kernel.org/vfs/vfs/c/0d4f9f7ad685
[12/12] tmpfs: add support for multigrain timestamps
        https://git.kernel.org/vfs/vfs/c/cba2a92eff80

