Return-Path: <linux-fsdevel+bounces-38383-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D151A01374
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 Jan 2025 09:57:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 349DA1641C4
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 Jan 2025 08:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DE96170A15;
	Sat,  4 Jan 2025 08:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B7C1z/kX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3CD14A605;
	Sat,  4 Jan 2025 08:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735981062; cv=none; b=LgV056R4tu9psMf87ZwCd3KB1JOZF1IRQ1J2LqWBj7vEoCEWgvRhqqEbeMmz6US/OK8u5bwg65o7bUZuz76zz34grmTKAr8DGP+DFutl7tzJYfeczLRZu/QDyLPLl1ccKqhEgsidTxU0aJ2zBXFUJnAosLll/Fr4W2SB9iWgz34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735981062; c=relaxed/simple;
	bh=Ngs7UO8p1JCMfAXuAnuvOR/jRHfGsXotovGZg+ytYMo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EB4SvCxpbkxi3e/+2n/HxJvZkQDvdhhhdbGOoZ5V5qB/CR2QA88fOUBvlCZDkKyNU7dqjgLZkQHAwfWq37lPmn7eAxOMjQIDgbj98bOP6i+ctc5Zryc2ap/sqTDuIvJcsUbttpVg1PAzU3n2zhHmWAKJtl9dVD5eMMOSRR8lI98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B7C1z/kX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3C46C4CED1;
	Sat,  4 Jan 2025 08:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735981060;
	bh=Ngs7UO8p1JCMfAXuAnuvOR/jRHfGsXotovGZg+ytYMo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B7C1z/kXrD5/JGPPk6VBA21VcL6gu8u/TKuRHJ2WWHP3G4w4sAoX4aOd8pKg7R+Yn
	 izKrHpx42+woh6tzmRPoGQdGAz5Y66pqkgdrjjS66F0sEIg4OEscRvlX1mrUqIkHn/
	 1NCnpHNOSg8KXaJzvHBDnXndmdqKENpFxx95ceoKY/ugtCdgHm4iVURq7QhRn4LJ1W
	 spSx8QsPBz/EvPnKBEFhfb4iAtvrJNrau11cd7H0huizNy+zTMlmYi/ij84RevGaor
	 LtowiCz5RvXOxk8GUd6vXNMIpG91R+9p2j+xY2WKkGjLP8tnyLYQLUAXoOzonqtAp/
	 Xvt1utNZbrK3A==
From: Christian Brauner <brauner@kernel.org>
To: Nam Cao <namcao@linutronix.de>
Cc: Christian Brauner <brauner@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Dylan Hatch <dylanbhatch@google.com>,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	John Ogness <john.ogness@linutronix.de>,
	Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 0/2] fix reading ESP during coredump
Date: Sat,  4 Jan 2025 09:57:19 +0100
Message-ID: <20250104-vollversammlung-biomedizin-f4c1164669d6@brauner>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1735805772.git.namcao@linutronix.de>
References: <cover.1735805772.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1359; i=brauner@kernel.org; h=from:subject:message-id; bh=Ngs7UO8p1JCMfAXuAnuvOR/jRHfGsXotovGZg+ytYMo=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRXfP9z1OdcrajPh9j0nXMdL5y3Tkh81l7F63C/I3Cij sWPv0FaHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABNxdWf4p3Uqp8Fh3e9dzc9L VSpq1IvywjYGvZ8juM9m3aPJtd7t7IwM939KrnD7wLbwfBHvrsb2vV99XmjrxsZd3sD2VnTFl5u 2zAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Thu, 02 Jan 2025 09:22:55 +0100, Nam Cao wrote:
> In /proc/PID/stat, there is the kstkesp field which is the stack pointer of
> a thread. While the thread is active, this field reads zero. But during a
> coredump, it should have a valid value.
> 
> However, at the moment, kstkesp is zero even during coredump.
> 
> The first commit fixes this problem, and the second commit adds a selftest
> to detect if this problem appears again in the future.
> 
> [...]

Applied to the vfs-6.14.misc branch of the vfs/vfs.git tree.
Patches in the vfs-6.14.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.14.misc

[1/2] fs/proc: do_task_stat: Fix ESP not readable during coredump
      https://git.kernel.org/vfs/vfs/c/e37bea052952
[2/2] selftests: coredump: Add stackdump test
      https://git.kernel.org/vfs/vfs/c/49db83214002

