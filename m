Return-Path: <linux-fsdevel+bounces-46060-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 251DFA821E9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Apr 2025 12:20:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3081D884A81
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Apr 2025 10:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89C5025D8E3;
	Wed,  9 Apr 2025 10:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j0q63EE1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD35025C70E;
	Wed,  9 Apr 2025 10:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744193998; cv=none; b=Vb8Q5B7Wc6hz7xbcxTNHFk2z7GUIZbj88pGwKJk4fw7DxqDde1ZhBp5b60JHDvViFmH9Dm8jY2qIob/KPPwOTBMGJhF7D7WRwHPmvAbfgALtzCs5iXtiMa/2bafA55xonxMpX94d5QcPZ+RikOwfwSq1HjA46p3rcLgoP4TDnBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744193998; c=relaxed/simple;
	bh=iq3vmiiwSRfTnowwoY5VuZG9sUlU1DiW11sE0Xx00Ag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Os0wFdkXHiTUAuZVIK9uRhLxA+ZIzMnu0zHtK+iCYb4lC0yhO9wnFyY/wsAZmofuwBlH7jAxpVUJ9o8zIJZlWU5f69il8PGu79IncwH9NzCqy1jrt8GznGBUjoJPuCTOfE5BWtBUqHrHAlCRFmSVAEEjkAFFxJBVRkGt5Xwi/fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j0q63EE1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23D61C4CEE3;
	Wed,  9 Apr 2025 10:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744193998;
	bh=iq3vmiiwSRfTnowwoY5VuZG9sUlU1DiW11sE0Xx00Ag=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j0q63EE1tFX7NStRIp585iZrR33JQ3xzvoNOTeIGVVKvtm2He5wLHnFQUfXh4/CaR
	 yFDtr/hbafa1ez9TnCrakzHJ2Nn9H95UlxuGKdJwnwOIlRsgpP2AALgWyJMQvr3dpG
	 KVzlLF9zknZb+yxviUiW1SFFJEPhaUVeNy0TIkkdxqID1FNtjNxOX2fljHDJqqAYSO
	 eCP9Otbhk1axDn0/cMbiYPZHNJt2qV01kZRD0z28m6pTpH9QnMIa6e45eTjg7HxHln
	 vY2THpGlDcbCmOCYLhbYwmE6Qx6sxBwkhuDbWr/sUqkhaoRO6v8ATo2FK49iRk16lJ
	 kn1zWz6jW4hAg==
From: Christian Brauner <brauner@kernel.org>
To: linux-fsdevel@vger.kernel.org,
	Omar Sandoval <osandov@osandov.com>
Cc: Christian Brauner <brauner@kernel.org>,
	NeilBrown <neilb@suse.de>,
	linux-debuggers@vger.kernel.org,
	kernel-team@fb.com
Subject: Re: [PATCH] dcache: convert dentry flag macros to enum
Date: Wed,  9 Apr 2025 12:19:25 +0200
Message-ID: <20250409-sinkflug-fettgehalt-addc48830fbf@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <177665a082f048cf536b9cd6af467b3be6b6e6ed.1744141838.git.osandov@fb.com>
References: <177665a082f048cf536b9cd6af467b3be6b6e6ed.1744141838.git.osandov@fb.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1356; i=brauner@kernel.org; h=from:subject:message-id; bh=iq3vmiiwSRfTnowwoY5VuZG9sUlU1DiW11sE0Xx00Ag=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaR/8zx58lvt+sDTj5bN7HAt+Bezcuan6bOaj9kuOPhtb sz9JFONNx2lLAxiXAyyYoosDu0m4XLLeSo2G2VqwMxhZQIZwsDFKQATsT3AyHAvP22Si75Dwvcb NjeL1qhsL/C1mbuk+VViYOpcjxOL//1m+F/lt+5ogqLSpBmWxr9y+OZNWXt1nYno7IBn3zUUxYX an/IDAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Tue, 08 Apr 2025 13:00:53 -0700, Omar Sandoval wrote:
> Commit 9748cb2dc393 ("VFS: repack DENTRY_ flags.") changed the value of
> DCACHE_MOUNTED, which broke drgn's path_lookup() helper. drgn is forced
> to hard-code it because it's a macro, and macros aren't preserved in
> debugging information by default.
> 
> Enums, on the other hand, are included in debugging information. Convert
> the DCACHE_* flag macros to an enum so that debugging tools like drgn
> and bpftrace can make use of them.
> 
> [...]

This seems good to me and helps drgn. I've reflowed the enum a bit.

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

[1/1] dcache: convert dentry flag macros to enum
      https://git.kernel.org/vfs/vfs/c/63690b75feb1

