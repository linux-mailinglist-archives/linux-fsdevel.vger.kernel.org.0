Return-Path: <linux-fsdevel+bounces-13639-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E22EB872461
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Mar 2024 17:33:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C868287963
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Mar 2024 16:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42E0E9454;
	Tue,  5 Mar 2024 16:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eiM/+xGV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F89E8BF7;
	Tue,  5 Mar 2024 16:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709656409; cv=none; b=lGKOocaQ364404TdSTOK6kmmcggI0bNC9POx4AU4BPvq4gT+cT+aM0suI24/NaRIYQbLajzxUmiGcSh6dBiH/W4Eoo6BLgq0Mx0O2LJRxqP375Z7zLmvhUAvq1SH3l3Jri9myiumj6NdQeXylXWEfkfM1PH5fjRYigflFgueZ+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709656409; c=relaxed/simple;
	bh=8ZYP/7MwdqiNvcPoMantYVW6jsePrsovyNrL/k8U4FU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=so3PNCuvefNV9swf9RuucAU5GOIi6+UkLaYwBOEJC2WyYnyq76Z0OafFLZ4++WESYaUGUPxyOvZ/FXN9752LuyNlcnYy/p73j0BDzJ1FUNtNsnzNe7BHez8tyS9KSNUO3sTjNZjTRQObz2neHKySP6wWRr+BgPMPUh2Zm/SE7W0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eiM/+xGV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A2A3C433F1;
	Tue,  5 Mar 2024 16:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709656409;
	bh=8ZYP/7MwdqiNvcPoMantYVW6jsePrsovyNrL/k8U4FU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eiM/+xGVUBR7Hm7arb/ZDBR7gbqkbtT9lsm1U66ZKiapEN4GXQhf2UVTTGXKZqO81
	 pK3NYXDZHX2242ccHULVL8YU8YlRMKxp6IPa5jw/u0+O02NB+jfmtBzLp6XTB6M+mp
	 07d/Wg8dvMlVp1bCf7TUXKSW4ru8tZxNscRjAE9lB4ZvAAwjLWlI1klaMxLzni7hDy
	 lI2ZvPw5kT0mvPHR38oWAojTDBWLg+co42OyS7gfIKonVqHudunQAO7RTdJg/9z6/t
	 opjICPCEDIVxjKUwmt2oApPqxbVuoZg8IwvF1KeSbrdbVAf8b6njCjGelECuQfgL7c
	 6ts9SXcUXRE2g==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Tong Tiangen <tongtiangen@huawei.com>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	wangkefeng.wang@huawei.com,
	Guohanjun <guohanjun@huawei.com>,
	David Howells <dhowells@redhat.com>,
	Al Viro <viro@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] coredump: get machine check errors early rather than during iov_iter
Date: Tue,  5 Mar 2024 17:33:20 +0100
Message-ID: <20240305-staatenlos-vergolden-5c67aef6e2bd@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240305133336.3804360-1-tongtiangen@huawei.com>
References: <20240305133336.3804360-1-tongtiangen@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1508; i=brauner@kernel.org; h=from:subject:message-id; bh=8ZYP/7MwdqiNvcPoMantYVW6jsePrsovyNrL/k8U4FU=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQ+9wyUiOiW+7iabV/PY8FJZubV28M0e+o+rprXMdPhX eADHTP5jlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIk05TAyrNLk4WVaVKp/yzCW 2b+/q9t0z42mk28440S3bMosPf4ggZHhS0LbRQObGrMiF66n6onKzsIbqv5lR57JbklmKTH1ncs NAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Tue, 05 Mar 2024 21:33:36 +0800, Tong Tiangen wrote:
> The commit f1982740f5e7 ("iov_iter: Convert iterate*() to inline funcs")
> leads to deadloop in generic_perform_write()[1], due to return value of
> copy_page_from_iter_atomic() changed from non-zero value to zero.
> 
> The code logic of the I/O performance-critical path of the iov_iter is
> mixed with machine check[2], actually, there's no need to complicate it,
> a more appropriate method is to get the error as early as possible in
> the coredump process instead of during the I/O process. In addition,
> the iov_iter performance-critical path can have clean logic.
> 
> [...]

I'll send this together with two other fixes we have pending.

---

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

[1/1] coredump: get machine check errors early rather than during iov_iter
      https://git.kernel.org/vfs/vfs/c/da1085a16551

