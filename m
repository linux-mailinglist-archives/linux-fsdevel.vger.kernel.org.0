Return-Path: <linux-fsdevel+bounces-39679-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 825C8A16ED5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2025 15:52:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32488188190F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2025 14:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B335B1E98E6;
	Mon, 20 Jan 2025 14:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bT4QUioT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A3FF1E8841;
	Mon, 20 Jan 2025 14:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737384687; cv=none; b=ii4JEbOI/1V9WH86LhqDLBGb8TfO8TCQvIciTeQcEHKnZGqTltIQt4x6eAx0g/I9+0WRh/eqQBRBDzo1JOxF4CHRHjvY+VSVX0SE3LpiPGL20YHUkESrEYab352IwhKHGtI9nYf28EPdkbRJ2Gi/ZmL2Z7wwnJyVtefZ+v/zOEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737384687; c=relaxed/simple;
	bh=kXveLa76z/4LC7xZq/+gX3pqLdFejmJGWqWhQczZNrg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fjGtx3bliMnfnS+AZQAkhVmzj2TAAb0i4X1hzKmXBvBb4DKaESm9JDGFRMQ5QpDr5XFwE0O8BwNJLpGMREieansIYV/nSNDdsiNPp73/b2F66J/WX8hIvre6EMkQV5TA63xdMh5+Z8nebdV1xjVsGJM0xJqak3RJfzTM3Q0uzsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bT4QUioT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B518C4CEE5;
	Mon, 20 Jan 2025 14:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737384686;
	bh=kXveLa76z/4LC7xZq/+gX3pqLdFejmJGWqWhQczZNrg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bT4QUioTDP72vZZdzqwyLTZBnHJH4Tg/T7PX9xgGBWYjW9OVZAclnsWCx8AG2buLV
	 nB3gJr6ceVCx6jDUCQiuvEBiNHhmerKizMXaW1e8ogakRTG338G1s6e3Q5fvyeNf+u
	 fipYsjTEknR07ulhAJz9zwWI5Q2nEbEoko4ipvNAmywL87xv96CUSOs22rn+3Uld96
	 Ribf7uyDFNheHzgQMEnBJyy53Zi8KycN65nqdItpYGBPOyUsUE+hRuGpbRE83mAhw9
	 sOmOhZbpfFR/yy4R4HN6tUXAbRE8bQfSI6g3BD4fj9yRBbdWIzSLkMUeVKKuk4yy35
	 cL/HJHypNyR/Q==
From: Christian Brauner <brauner@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	tavianator@tavianator.com,
	linux-mm@kvack.org,
	akpm@linux-foundation.org
Subject: Re: [RESEND PATCH] fs: avoid mmap sem relocks when coredumping with many missing pages
Date: Mon, 20 Jan 2025 15:51:15 +0100
Message-ID: <20250120-knabbern-aufwiegen-82ec233f99dd@brauner>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250119103205.2172432-1-mjguzik@gmail.com>
References: <20250119103205.2172432-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1280; i=brauner@kernel.org; h=from:subject:message-id; bh=kXveLa76z/4LC7xZq/+gX3pqLdFejmJGWqWhQczZNrg=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaT3JT1/95drgdWdY7M93+/2a5l2UmXGAe9VmxbnLz6fv btYulDuTEcpC4MYF4OsmCKLQ7tJuNxynorNRpkaMHNYmUCGMHBxCsBEtrxkZOjxyJ4SJ6dx91p4 E6vrRsWZSU1fbqS7nVmzXZexe5rWbBeGv2Kyvtrhdyf+Wu4kuti197pjiNS05C9h+5budAySWin xlAkA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Sun, 19 Jan 2025 11:32:05 +0100, Mateusz Guzik wrote:
> Dumping processes with large allocated and mostly not-faulted areas is
> very slow.
> 
> Borrowing a test case from Tavian Barnes:
> 
> int main(void) {
>     char *mem = mmap(NULL, 1ULL << 40, PROT_READ | PROT_WRITE,
>             MAP_ANONYMOUS | MAP_NORESERVE | MAP_PRIVATE, -1, 0);
>     printf("%p %m\n", mem);
>     if (mem != MAP_FAILED) {
>             mem[0] = 1;
>     }
>     abort();
> }
> 
> [...]

Applied to the vfs-6.15.misc branch of the vfs/vfs.git tree.
Patches in the vfs-6.15.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.15.misc

[1/1] fs: avoid mmap sem relocks when coredumping with many missing pages
      https://git.kernel.org/vfs/vfs/c/dbdd2935ed48

