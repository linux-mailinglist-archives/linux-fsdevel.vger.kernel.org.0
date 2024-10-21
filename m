Return-Path: <linux-fsdevel+bounces-32493-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 802C69A6D2D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Oct 2024 16:53:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29AAF1F21EB1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Oct 2024 14:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E75101FAEE4;
	Mon, 21 Oct 2024 14:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TE2vDYBh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115971FA25D;
	Mon, 21 Oct 2024 14:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729522360; cv=none; b=R4LkhKSAxP5/+MjjBFX7CpUUA0lJYCa5fxupoJWsbOvp2pwkNX9ogbU52AhYrMso1mGhwt9lQMDFwbSXUtiBKF9p2U14Wm6nsDUNxT06QTTotyPPjvhlN1lel4knn5EDn4K40hg1NsC3GYUlLPyQ90uZCBpJu3B/jPrzUh469qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729522360; c=relaxed/simple;
	bh=dlWGS/l4ijCOGac8jIK107VrQI+1RI8UERuuB2oajJE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hDGerendu52NRLGSEPZ+rPAaXa67jj0zAQ9EEknhPoa7m5qdXH0CRDGz9mYkhh91/gecfh6nXcJnL9nbIIk5lfHLrPU9yahCu2INt3RsQ2RzIldft/pfN+IqubRiuM7yUcJGAEUfwjHVd6fw1zuqLjTB+0//h0e4cY1dTds2FCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TE2vDYBh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4C0CC4CEE6;
	Mon, 21 Oct 2024 14:52:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729522359;
	bh=dlWGS/l4ijCOGac8jIK107VrQI+1RI8UERuuB2oajJE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TE2vDYBhb7mKSE49g1O1JrRTkH+haqmC6CjGkUMfx/NS5mL2aW3udk3wL9gUNgImP
	 lw5uhWPxmWnn055BzlW8D3d4PJLrCI2Mc6TTBrY15owrVx4SFgKredCEEn/wqA+/De
	 5phEeg9ijWs+UwuKH6Vw/FPgPgBVMA0Q3PGN87Cr8wBsoyzf7w1T97B41O6ZkPipoh
	 g4X2y2ZyA2/unPvyF6YAj9Ll8sDI5HOmR/4GoSJOjp1LwmDTiSq63J91XJiphb9PLG
	 GX/RPoLKgNFfPGGPtQ6RxHZU1UMZwLvNgKkkUk+YvNv9/e72gF7xqPWdRD5lQRjyhu
	 k5ysD7Q/BvrNw==
From: Christian Brauner <brauner@kernel.org>
To: Aleksa Sarai <cyphar@cyphar.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Florian Weimer <fweimer@redhat.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	stable@vger.kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Shuah Khan <shuah@kernel.org>
Subject: Re: (subset) [PATCH RFC v3 00/10] extensible syscalls: CHECK_FIELDS to allow for easier feature detection
Date: Mon, 21 Oct 2024 16:51:51 +0200
Message-ID: <20241021-kraut-fundgrube-cf1648e59df4@brauner>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241010-extensible-structs-check_fields-v3-0-d2833dfe6edd@cyphar.com>
References: <20241010-extensible-structs-check_fields-v3-0-d2833dfe6edd@cyphar.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1779; i=brauner@kernel.org; h=from:subject:message-id; bh=dlWGS/l4ijCOGac8jIK107VrQI+1RI8UERuuB2oajJE=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSLZa29GrT7ZpV74rL3y8Ijstc/P7tdxYBRchtjj8Umw 0JXGZ8vHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABOpj2f4X33A1Nfrxe052925 gvPv/S+69SaCQZXp45K3TXnHQj0mCzMyfPqyRJ9NYJ5kq/Clhd+W3ix5fGt6n9uW5+rR3003zXn Cxg8A
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Thu, 10 Oct 2024 07:40:33 +1100, Aleksa Sarai wrote:
> This is something that I've been thinking about for a while. We had a
> discussion at LPC 2020 about this[1] but the proposals suggested there
> never materialised.
> 
> In short, it is quite difficult for userspace to detect the feature
> capability of syscalls at runtime. This is something a lot of programs
> want to do, but they are forced to create elaborate scenarios to try to
> figure out if a feature is supported without causing damage to the
> system. For the vast majority of cases, each individual feature also
> needs to be tested individually (because syscall results are
> all-or-nothing), so testing even a single syscall's feature set can
> easily inflate the startup time of programs.
> 
> [...]

I think the copy_struct_to_user() is useful especially now that we'll gain
another user with pidfd_info.

---

Applied to the vfs.usercopy branch of the vfs/vfs.git tree.
Patches in the vfs.usercopy branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.usercopy

[01/10] uaccess: add copy_struct_to_user helper
        https://git.kernel.org/vfs/vfs/c/424a55a4a908
[02/10] sched_getattr: port to copy_struct_to_user
        https://git.kernel.org/vfs/vfs/c/112cca098a70

