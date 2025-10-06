Return-Path: <linux-fsdevel+bounces-63467-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 87481BBDBD4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 06 Oct 2025 12:44:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F92A18958E3
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Oct 2025 10:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62A782459F8;
	Mon,  6 Oct 2025 10:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PSzT/o6c"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC75F2517AC
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Oct 2025 10:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759747455; cv=none; b=Pm3YV4iLmPpis8J/6EoeNAP/34rTQWezh7i20TzTpFD3gWgNoGxKKwKvOuFB3fVmC35vgsDIloNDd5XWik+dcieiDJACj4q3d28Dt8rNY6F/NdaDBoxzff1U8KoRUo4mGTX9MY7RjHzV8LAva5Hq13Kqjoolzhf/nGZGt6A4xoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759747455; c=relaxed/simple;
	bh=S297+zaMfz2WA0awZ1DhgpPgagtghFf1xtRKo/hqXlM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JD4zkJJKEONPAqOJSkESIyXBh3mWL6Ag1Vg/QlFSP05LkZ+myHtsvWESQqfcx+KeyQJqZyMJ8FBurokvXQHZnuA+JJTqAnLqdxElLvjOf/MN9wMnaVIfxydph4VpxZ94gSJX3LFUX3Fm13t+cBR5LC8Bo+GjDm1PGYHU47UJtY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PSzT/o6c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAB30C4CEF5;
	Mon,  6 Oct 2025 10:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759747455;
	bh=S297+zaMfz2WA0awZ1DhgpPgagtghFf1xtRKo/hqXlM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PSzT/o6cO1Lr4+XX5Ax5nDAzLxkqZBEQtE7WQk/CKw/br7DnlGdfU2+KxNaXGM0AL
	 iwshn1tRIQ1o07KSFHd3uLshZDQuCw5jVErh+68g85oAn+h2VtV7LAa/vmcpD1e+gA
	 zvG6u79ruyXwnssMb2PDU52DU+5rYoz9BrizWP8Ac2w7CXo0ubD06HAJdiB5q7cc7l
	 8C9LHXOu6sahgQP8jgetat392JA4xhod8RlLEdKfTr0I0Tepj3r+YTs//Q9iaalYu7
	 acuyEv4W1bGG0ipjpIMG3emdJWvvUCLzDGbIpNLq9+rVFME2CuaXiRA5SyIClvsuiJ
	 dxtcDqsMtvOnA==
From: Christian Brauner <brauner@kernel.org>
To: linux-fsdevel@vger.kernel.org,
	Julian Sun <sunjunchao@bytedance.com>
Cc: Christian Brauner <brauner@kernel.org>,
	viro@zeniv.linux.org.uk,
	jack@suse.cz
Subject: Re: (subset) [PATCH v3 1/2] writeback: Wake up waiting tasks when finishing the writeback of a chunk.
Date: Mon,  6 Oct 2025 12:44:05 +0200
Message-ID: <20251006-zenit-ozonwerte-32bf073c7a02@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250930065637.1876707-1-sunjunchao@bytedance.com>
References: <20250930065637.1876707-1-sunjunchao@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1412; i=brauner@kernel.org; h=from:subject:message-id; bh=S297+zaMfz2WA0awZ1DhgpPgagtghFf1xtRKo/hqXlM=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQ8nltpUcTLenRW8UQdrVth67b1rOEqVGrOv21uXRGz7 OzzzTyzOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACYytZjhv4uRg/r1inUGu6e9 /mwx6/0Z7YppwZ7KC9dauNi8/i4zz5CR4XTTmiN9/KVqy6NLWR+v+BNTP0lr995dOtceJubOXBI yhwkA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Tue, 30 Sep 2025 14:56:36 +0800, Julian Sun wrote:
> Writing back a large number of pages can take a lots of time.
> This issue is exacerbated when the underlying device is slow or
> subject to block layer rate limiting, which in turn triggers
> unexpected hung task warnings.
> 
> We can trigger a wake-up once a chunk has been written back and the
> waiting time for writeback exceeds half of
> sysctl_hung_task_timeout_secs.
> This action allows the hung task detector to be aware of the writeback
> progress, thereby eliminating these unexpected hung task warnings.
> 
> [...]

Applied to the vfs-6.19.writeback branch of the vfs/vfs.git tree.
Patches in the vfs-6.19.writeback branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.19.writeback

[1/2] writeback: Wake up waiting tasks when finishing the writeback of a chunk.
      https://git.kernel.org/vfs/vfs/c/334b83b3ed81

