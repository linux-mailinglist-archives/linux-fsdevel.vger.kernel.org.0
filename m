Return-Path: <linux-fsdevel+bounces-73207-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 44621D11A7A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 10:58:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BE63530024F7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 09:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C42AC277CBF;
	Mon, 12 Jan 2026 09:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rBhmQSNm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A37E26A088;
	Mon, 12 Jan 2026 09:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768211899; cv=none; b=NS3NGfi5PQzLQ5G8O+Y/u/iZSd0472mTiKmJ4JYaChhfAyu4DRPZF4+VdlF0/ss8mMCha7cqUz33g9zwqso3VPH6x3nb9mn9ycrPbGkGTNPlXMpb4ptP7Tgty7jtb+cAzi/hxie63Me096mENWKgDlXfWwRSP5GLBezMMz9Bxkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768211899; c=relaxed/simple;
	bh=5n5GuH+MxuRBT0mkOvhFt3RZ1H+0aOuOjjNMlHl7qsM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ABwGfLUgtwuHirE/egiB04dhGvmPvAUq479xpj4XJKlRXnFbpFEhNGbLxaCF1ZF0V7dU+p23bntMULElxg/6q1FlKzPlRmrGu/qDnQ/lGVKGskDDy0GfvW+F8ngceM41867jcpYdfRkP0+DX10MvKO7tRtPBk+nMCy1mDQyrA90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rBhmQSNm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 348B7C116D0;
	Mon, 12 Jan 2026 09:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768211898;
	bh=5n5GuH+MxuRBT0mkOvhFt3RZ1H+0aOuOjjNMlHl7qsM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rBhmQSNmSLxXOx1kJRNHlokjr18yZOLstHJeVk4n2bnIoJI2AHL7NPJqjhYHy4BP+
	 fERQ2rP8lrvXGcyMHJtInAxK4pkBkf2QQ3/9Pg+8t9NAkzex4LFseG4V1XzsvD+i+i
	 Gu2toBNAWz9ept9Ejj/PL3ZfhxG4MxmmL9mFvgdrQF+QGdaF5V8/HFnr1nSlaLsDGF
	 tK7do25Qh/oPoS/AZEqpoi/HJm+2NJ0wdXiP/G51UKCBywTSsao9bHBXIt0X4uOsKe
	 CE+Safh9aHVAO9qck5T1PGqjpXOqN2wFQmiDtvfvgrkOSgGAyVQ6Dvr1gyKc86SHhJ
	 bHX4JqakrPpdg==
From: Christian Brauner <brauner@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Al Viro <viro@zeniv.linux.org.uk>,
	linux-fsdevel@vger.kernel.org,
	linux-unionfs@vger.kernel.org,
	Chunsheng Luo <luochunsheng@ustc.edu>
Subject: Re: [PATCH v2] readdir: require opt-in for d_type flags
Date: Mon, 12 Jan 2026 10:58:13 +0100
Message-ID: <20260112-antworten-moment-fd4b39fc7a20@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260108074522.3400998-1-amir73il@gmail.com>
References: <20260108074522.3400998-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1343; i=brauner@kernel.org; h=from:subject:message-id; bh=5n5GuH+MxuRBT0mkOvhFt3RZ1H+0aOuOjjNMlHl7qsM=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSmHN2mse7D82t3HA9KFkecZTgivKquv0SpeW6K2ewJl nfWGz7Y21HKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRLV8Z/kq+2WcmL1iR+eLi tUORSyyzlM98Xt2f8YalXKplxpXnlrEMf+V55kkG/VwSP1tw+cFJ9/aIFQrp1a3cEu1/9N/UjMu b5NkA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Thu, 08 Jan 2026 08:45:22 +0100, Amir Goldstein wrote:
> Commit c31f91c6af96 ("fuse: don't allow signals to interrupt getdents
> copying") introduced the use of high bits in d_type as flags. However,
> overlayfs was not adapted to handle this change.
> 
> In ovl_cache_entry_new(), the code checks if d_type == DT_CHR to
> determine if an entry might be a whiteout. When fuse is used as the
> lower layer and sets high bits in d_type, this comparison fails,
> causing whiteout files to not be recognized properly and resulting in
> incorrect overlayfs behavior.
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

[1/1] readdir: require opt-in for d_type flags
      https://git.kernel.org/vfs/vfs/c/c644bce62b9c

