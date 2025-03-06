Return-Path: <linux-fsdevel+bounces-43318-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83D76A5436D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Mar 2025 08:15:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C6E17A92BD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Mar 2025 07:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03D1D1C8614;
	Thu,  6 Mar 2025 07:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cub8HJYt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 608971B4234;
	Thu,  6 Mar 2025 07:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741245242; cv=none; b=HsjpRJXBPe2Cma/Ey+YX7UXyyAiG73VQlToxzAJyRZ/t0gnZ57iaeAq9pbn5LhtefBCP3h2GmpKhIM3ncD7sctjSTQZ1byTDN75IgAHojSxKFYG9kicbZlGgtfbtZrrfWzgNGQZ1q088XC04zt6mHb1mBPzAtaQgGyKLML8SX7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741245242; c=relaxed/simple;
	bh=yDUsXU1iuR+Iruf45BeS8vYPFTr2B42zbUKkpU1dRMk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZBO97LPKZ/Lgr//Te5CDHZMi5E7IsAKG/5dMdfKl2MFffA2ZYnETu1oj0v9TAD9z21Tc1dcL9W6HfOsuBLbvHYwNBHWuzu7CmFR/JvlsYu2jVFH7OQs33CF741PsHmFYiAF8iwGg2v0yFf5Kk4Q42scfZHO9wid8glbBwtoSMqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cub8HJYt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E570C4CEE4;
	Thu,  6 Mar 2025 07:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741245241;
	bh=yDUsXU1iuR+Iruf45BeS8vYPFTr2B42zbUKkpU1dRMk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cub8HJYtB0n+5+jJrToWJZjk3U3nfX7GfByMKXl77EJvK1EmA2tQreaU7UZlPRjRG
	 jBZHncELS2h6qBDUp17XIOIhGODzPQrnn45gS175zFQgVyaChx4OKzH7cXf07BDKA6
	 rOMLtba4JwZl3e5uZcX1qsXcfqItgZjvknm3kuft/d6fHECvrVoDLLCQqFkbFxUkGw
	 tDdNRMpMSCYgLAflYarH6r+1mucBZ5GDuuPAHxIc7xu5ETNSVZdGREFmel2dL6oWTx
	 dqcQyx5R92a2fu170rMW13YiPVSTFqWf8yCvhgJg5RfJxTnXQmUrrv3IkEjjP9nlws
	 RiIU1/NH+TRwA==
From: Christian Brauner <brauner@kernel.org>
To: David Disseldorp <ddiss@suse.de>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kernel test robot <lkp@intel.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] initramfs_test: flag kunit_case __refdata to suppress warning
Date: Thu,  6 Mar 2025 08:13:45 +0100
Message-ID: <20250306-dickicht-kopfzerbrechen-87959b0c717a@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250305130955.24658-2-ddiss@suse.de>
References: <20250304-anfingen-kondor-c7f9cc352472@brauner> <20250305130955.24658-2-ddiss@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1032; i=brauner@kernel.org; h=from:subject:message-id; bh=yDUsXU1iuR+Iruf45BeS8vYPFTr2B42zbUKkpU1dRMk=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSf9DaJjvn0z7VgtsGXFvmJFhbaCUJz5AxmiT/J/dS90 fb8tL2iHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABM5dI3hf6gPy+npbB9i+5sM Lpk51x77IKyp9eXzAU7m4Lv6R7bsz2f4X1ptwXd1g1Ck0pPiiInRR7/VMcXM/5nN0rwseOo+lTe zeAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Thu, 06 Mar 2025 00:09:56 +1100, David Disseldorp wrote:
> We already have a comment regarding why .data -> .init references are
> present for initramfs_test_cases[]. This allows us to suppress the
> modpost warning.
> 
> 

Folded, thanks!

---

Applied to the vfs-6.15.initramfs branch of the vfs/vfs.git tree.
Patches in the vfs-6.15.initramfs branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.15.initramfs

[1/1] initramfs_test: flag kunit_case __refdata to suppress warning
      (no commit info)

