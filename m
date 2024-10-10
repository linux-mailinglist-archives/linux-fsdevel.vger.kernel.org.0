Return-Path: <linux-fsdevel+bounces-31531-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C649399833D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2024 12:10:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66941283DCC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2024 10:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB1B81C242E;
	Thu, 10 Oct 2024 10:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TuLhCxS/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A191BF300;
	Thu, 10 Oct 2024 10:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728554986; cv=none; b=rqE5vvcK1E0UYrSYKbxvHjZxaLQGRjcIV3NopUHG/D1dena7adKykfmeRtsuSUg6Pjl85Qs8x63MfQFqtVeuhkqTWEkPH3o91nsvxUusuZrv2JvOCW1FQtksDBulMVPyiB6YBX9XbyY0mxwSvLZ1H9vgRMoCl6zvzbb4YeRwYoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728554986; c=relaxed/simple;
	bh=vCTqIl7jShZpEr0sVmMbfnvFvzmbv2n1ITL19Rj+AWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tNPXgGwsclvxdA2mNiBQxhqw3cDS9KeIr44T6nPMEgbTX4kQcFamBjwqKQIrOcUji9UH5Dj9uYxT7a+0q5aXWkVvR1CryhfCa560poHlrRIxq7q6pMLydESbx8mVWGiXDcPWwmbhX+KzP5/v1LHSK8RhFil4PT+p08f/1FUa0kQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TuLhCxS/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85CBDC4CECC;
	Thu, 10 Oct 2024 10:09:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728554985;
	bh=vCTqIl7jShZpEr0sVmMbfnvFvzmbv2n1ITL19Rj+AWQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TuLhCxS/kum3UUxI2LxetVqLBebi9ov//MNFTqAdCuXEOE2k5dBBp3lBbyLXKK1UD
	 +JnBouAShZSx0FpbD1wRXccZwC6S5evYkUqXkmc3pb7TwrRkNF7XTFMW+9jA1xhz6g
	 BEVS/dNs7+Th8yU89mXKH4GwQV8YO2J+M+WF1DMgtm8X1SWYEWhYQc4lKKF6iKH7JL
	 Q3vQcsttS3UHj3CZ29aCP1vYw+sX2AYnz93OehQpgxoxdgBDmK3DxHAjkCMHCl6dNS
	 elj6E5VT44QVNzgeYiHWSZQ2IAZpulbv1bkoWqGkYStFVgf0vu/R9VZZAjmsUtGr9O
	 egsFyXIZheGog==
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
Subject: Re: (subset) [PATCH RFC v3 03/10] openat2: explicitly return -E2BIG for (usize > PAGE_SIZE)
Date: Thu, 10 Oct 2024 12:09:35 +0200
Message-ID: <20241010-pikant-neuer-4dbf48940683@brauner>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241010-extensible-structs-check_fields-v3-3-d2833dfe6edd@cyphar.com>
References: <20241010-extensible-structs-check_fields-v3-0-d2833dfe6edd@cyphar.com> <20241010-extensible-structs-check_fields-v3-3-d2833dfe6edd@cyphar.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1115; i=brauner@kernel.org; h=from:subject:message-id; bh=vCTqIl7jShZpEr0sVmMbfnvFvzmbv2n1ITL19Rj+AWQ=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSzL3/gcn99iY5JAhOL4eyvLi/V4x5oM8gLr39yhtl0e 47m5MrMjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgImI32X4K5d4O//zV+UpEjpp /sHnas908812W3pp/pJJfp53gmsuCTP84TN9cNBg4oRf+UorZZVbtjcUbzs4L+1Zj1eBQeMCj9y 3bAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Thu, 10 Oct 2024 07:40:36 +1100, Aleksa Sarai wrote:
> While we do currently return -EFAULT in this case, it seems prudent to
> follow the behaviour of other syscalls like clone3. It seems quite
> unlikely that anyone depends on this error code being EFAULT, but we can
> always revert this if it turns out to be an issue.
> 
> 

Applied to the vfs.fixes branch of the vfs/vfs.git tree.
Patches in the vfs.fixes branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.fixes

[03/10] openat2: explicitly return -E2BIG for (usize > PAGE_SIZE)
        https://git.kernel.org/vfs/vfs/c/f92f0a1b0569

