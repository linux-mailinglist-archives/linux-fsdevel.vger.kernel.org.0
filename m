Return-Path: <linux-fsdevel+bounces-59639-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85B81B3B803
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 12:01:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C49817C7B73
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 10:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06C623081B8;
	Fri, 29 Aug 2025 10:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MegpgKDB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D6DA3081A3;
	Fri, 29 Aug 2025 10:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756461686; cv=none; b=T3kmtxTuNg4uUG/I21eG+FhyTts6sGs0hWPIhcDaYavzeBhfveUQ9ZkJs65o6bwFW/bIEbR98I17C/mp9wWOhuovnIauYmCFys6X3yg0+oj55508rmYvHl8NtGKVLnCFVZDzZbvjTUPFJ8CVlB/BRrsrn6HMadk9U8qMZgNHhDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756461686; c=relaxed/simple;
	bh=92fN0UR0hrt8PjaauCManqwbTnRkMOX7oJ/IaHyEcJc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fPX+uzrlqqqeFf/u7vXMR/R89tEBIW/d9YfXqhYzUlvQV6/Piu72xZ0Uf6ucPN8LEA5DoG5kWjgxq1B/FlpY9GAQz18tI470J2kZARsE/baML9UG4aC5oJhpNomkq3Q6J9EBuKH1y4FRII101o5KrhSZii2TrJUM2u0YaCwR1p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MegpgKDB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6E04C4CEF0;
	Fri, 29 Aug 2025 10:01:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756461685;
	bh=92fN0UR0hrt8PjaauCManqwbTnRkMOX7oJ/IaHyEcJc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MegpgKDBL6rvhcZYq1rVot1SopMcYG4xeBVWoAFOWPYTtAYIoB5Z78bPJBzQv/X1k
	 BJs+xv++sPeVKCdxxhdVMVcHfBAaHCfKnfiFeQKeecfas4mQpvXie0337o0mUuOz0R
	 P+31cezhZ8piF0AXt2/u/J51Sa2tITAsFCoOD8/ar7BL+4UWtMBjaoapZDXBJdCE7C
	 bQzK1dckl7yEf2B5XEoow3SNAypJY3MiXwwu2dMs944K34eT7Eor1B4CbAeC21pDbG
	 y/xfprJvO9EKye9SlPld4IhSTK/h3HqfxRCbICtzcqN3lzBkjz1//joduyAAaNIb/U
	 h1Lr6gfhFoJ2Q==
From: Christian Brauner <brauner@kernel.org>
To: Xichao Zhao <zhao.xichao@vivo.com>
Cc: Christian Brauner <brauner@kernel.org>,
	jack@suse.cz,
	gnoack@google.com,
	linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	viro@zeniv.linux.org.uk,
	mic@digikod.net
Subject: Re: [PATCH] fs: Replace offsetof() with struct_size() in ioctl_file_dedupe_range()
Date: Fri, 29 Aug 2025 12:01:20 +0200
Message-ID: <20250829-passierbar-losen-cd47a4b68c3d@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250829091510.597858-1-zhao.xichao@vivo.com>
References: <20250829091510.597858-1-zhao.xichao@vivo.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1077; i=brauner@kernel.org; h=from:subject:message-id; bh=92fN0UR0hrt8PjaauCManqwbTnRkMOX7oJ/IaHyEcJc=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRsrCq8feC67/xd6Yc7QzrsijYd/8syadc9mfirXNHcf gXOcy5f7ihlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjIEmVGhlmR0zJPBix0qJnb 8nOFkaBSx517n5h+LNdr3BB6xzf1VDUjw7K1y9XvZah9tuL6kmHLXcfBoWWWHRzFOFfjq0JiUmQ hMwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Fri, 29 Aug 2025 17:15:10 +0800, Xichao Zhao wrote:
> When dealing with structures containing flexible arrays, struct_size()
> provides additional compile-time checks compared to offsetof(). This
> enhances code robustness and reduces the risk of potential errors.
> 
> 

Applied to the vfs-6.18.misc branch of the vfs/vfs.git tree.
Patches in the vfs-6.18.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.18.misc

[1/1] fs: Replace offsetof() with struct_size() in ioctl_file_dedupe_range()
      https://git.kernel.org/vfs/vfs/c/38d1227fa71d

