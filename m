Return-Path: <linux-fsdevel+bounces-58026-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 668AAB28177
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Aug 2025 16:18:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6DADB6772C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Aug 2025 14:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 901802222AA;
	Fri, 15 Aug 2025 14:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AU2V+XxE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC1E2199931;
	Fri, 15 Aug 2025 14:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755267407; cv=none; b=Ob/zBpo24ihjs1FFiLGMkoiuemDN/Ej2Ct/Enh6otWi3AiupwVXzdtDbbcu4lic1ajRkvflk2LPIdudYb6unL7FGJcXQeuD6WedFjdSFKnv5L9OG6cI3TBSLbl624axjJxn1AA3U4bPJhmlYJAQ9Cokww4dOFhNgmfGMKB4BkdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755267407; c=relaxed/simple;
	bh=K6/EXttm+nt5thkhDaytjTLjS99tqYgEMzqbiugO36Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KqZT0cLp3krr0v0pvfGUbLmhCsIjHmEHfC0WgJU8p6zHq6ycpQUOqNSeTSlNsIh3DxqeEY/oaDO7hGIp4r6fJdXGzTgKTAStnD52crYTfZAgkJoe9SEuuMTGmUQgQ5r8s0xRG7BLiRAxsftIprKQU7i2K0hC5whSH8wcJ/S7yf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AU2V+XxE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 749DDC4CEEB;
	Fri, 15 Aug 2025 14:16:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755267405;
	bh=K6/EXttm+nt5thkhDaytjTLjS99tqYgEMzqbiugO36Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AU2V+XxEIr27cYyPkH1gImqw5YNEsoNJ0csnCLhPGI3e0N1gJ8u62kqjmTJr1cXnp
	 22lqwG68kCxlmI1UtZAl4P0/UtUpfu79YIflNT/dhnTyo2idRdXyS4E2JibRRpnASk
	 KKOsWuJD/S/z+bs1Ypp1MhjG6OSJNls2EsCQWVM7m7ob/mHPU7taLvsvhcvizHTsox
	 bOr4LjpXFeXFYO8v9IcTMkQJCHJEiV8DF3plcXCGy/JoHUmQ+xfMTEcAcm1BKRIgZe
	 pXM0P4Lxz1Nsui5Ozk/YhMGFYoBkR5+4FIZl2neB9HpuosiLbYzRjKAqc8OcfWL66g
	 gufiYxSa11BJw==
From: Christian Brauner <brauner@kernel.org>
To: Dominique Martinet <asmadeus@codewreck.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Maximilian Bosch <maximilian@mbosch.me>,
	Ryan Lahfa <ryan@lahfa.xyz>,
	Christian Theune <ct@flyingcircus.io>,
	Arnout Engelen <arnout@bzzt.net>,
	linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	stable@vger.kernel.org,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	David Howells <dhowells@redhat.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v3 0/2] iterate_folioq bug when offset==size (Was: [REGRESSION] 9pfs issues on 6.12-rc1)
Date: Fri, 15 Aug 2025 16:16:33 +0200
Message-ID: <20250815-scheckig-depesche-5de55f7855d1@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250813-iot_iter_folio-v3-0-a0ffad2b665a@codewreck.org>
References: <20250813-iot_iter_folio-v3-0-a0ffad2b665a@codewreck.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1360; i=brauner@kernel.org; h=from:subject:message-id; bh=K6/EXttm+nt5thkhDaytjTLjS99tqYgEMzqbiugO36Q=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTMd3Qv5kjp+24nyTv92sUpX3X9y/qj5H03Md6dZGa6c 9bBOYbtHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABP5EMHwP/F8UGqLavwV7wy/ yz+jrqydMmdZ9dxHf3l+N61w91t4t5ORobVu+oa5Ddv+Ots6sx46eS3rt0R1iuFBifehXi+v3xF v5QEA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Wed, 13 Aug 2025 15:04:54 +0900, Dominique Martinet wrote:
> So we've had this regression in 9p for.. almost a year, which is way too
> long, but there was no "easy" reproducer until yesterday (thank you
> again!!)
> 
> It turned out to be a bug with iov_iter on folios,
> iov_iter_get_pages_alloc2() would advance the iov_iter correctly up to
> the end edge of a folio and the later copy_to_iter() fails on the
> iterate_folioq() bug.
> 
> [...]

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

[1/2] iov_iter: iterate_folioq: fix handling of offset >= folio size
      https://git.kernel.org/vfs/vfs/c/546a40359fd2
[2/2] iov_iter: iov_folioq_get_pages: don't leave empty slot behind
      https://git.kernel.org/vfs/vfs/c/334430b2d585

