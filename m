Return-Path: <linux-fsdevel+bounces-58020-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B598EB2810F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Aug 2025 15:59:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 484E6AE85C4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Aug 2025 13:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF7E83019DB;
	Fri, 15 Aug 2025 13:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qWhnDZk3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0724D319876;
	Fri, 15 Aug 2025 13:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755266246; cv=none; b=PwH8Vp9Itw8hSQ6wiISmGPqJchOpdCgiLZ1Yn8jrErIT/bukR9ul8WtPlpOXf8tI3mmom9c3VExji08p7lD8UXAViLbFFNoK2vYZefaAN1sYCkKkCH8V/yPLHDduV/o9lhd5WVXJ+uRoZLsJZAsHPC+A4gEwZtYK4Tr4cow3fc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755266246; c=relaxed/simple;
	bh=4qznQcuodMDR8UxP8t1F4Kt5zqkLltVV1eg/6EKCeTk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aZApRVRzp3XBPfLnSiJWaezQD7RTvfMVz+3HoXq9QRAzLPyeOLy3/KJvq/1ZSVSU0M5QOKxAovkjvrLJnfNmizl1bQh/0ISajzNZDPUnxbz4vYjF3BknnkZuKoIgfUcFLWPteYD2O93FD8WTnGEg3eqsrKU+UuTcydWZvZzGOss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qWhnDZk3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30412C4CEEB;
	Fri, 15 Aug 2025 13:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755266245;
	bh=4qznQcuodMDR8UxP8t1F4Kt5zqkLltVV1eg/6EKCeTk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qWhnDZk3tXS0Wbgw4bHyEbWlgmHi1yObAJr36OoyruYaEIAlf4mMD3Iik+aBOd8FZ
	 VNj+iUBlJxQ67YlHq3Fi9CjKLHMGuYz1evn9vTSi23NWbwKNOOBlrob4AAStgoMkEJ
	 vwpFJIgrTljeo/zUXU8znUXywT8c2SRZ3FeS5QvRLH68qdH7S8oIoLe83PzuF4qeQ9
	 EYXMrWzxGz7LFbZip0yJlX9gWifE4ci9TObT8lq2/TC1BgUEmlGWuT3njIx+7NRfY8
	 PYXHr4ROb0HtbGb7p4hjj5ypTiHJupa/jvw7NgFFmEVk95AfozbUQ9HEqUpSP6JXij
	 Bh5aDvDLcvVIA==
From: Christian Brauner <brauner@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Xiaoli Feng <fengxiaoli0714@gmail.com>,
	Shyam Prasad N <sprasad@microsoft.com>,
	netfs@lists.linux.dev,
	linux-cifs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Paulo Alcantara <pc@manguebit.org>,
	Steve French <sfrench@samba.org>
Subject: Re: [PATCH] netfs: Fix unbuffered write error handling
Date: Fri, 15 Aug 2025 15:57:06 +0200
Message-ID: <20250815-erhoben-gesurft-4de96f87d6d5@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <915443.1755207950@warthog.procyon.org.uk>
References: <915443.1755207950@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1415; i=brauner@kernel.org; h=from:subject:message-id; bh=4qznQcuodMDR8UxP8t1F4Kt5zqkLltVV1eg/6EKCeTk=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTMt9n/6/mnd1uVbxz6WeK3Lybf/4vWpakZ61+6fGlX8 rT8lj/xWEcpC4MYF4OsmCKLQ7tJuNxynorNRpkaMHNYmUCGMHBxCsBEjtgyMiz45p0jufTG/aAn 3c797/fX5UyaZ1tpKntQX2rh1xLOxdUM/yw2Lb3dzJ3x/590TueepYn+fCLVj5K2syj7J01vTA/ exgYA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Thu, 14 Aug 2025 22:45:50 +0100, David Howells wrote:
> If all the subrequests in an unbuffered write stream fail, the subrequest
> collector doesn't update the stream->transferred value and it retains its
> initial LONG_MAX value.  Unfortunately, if all active streams fail, then we
> take the smallest value of { LONG_MAX, LONG_MAX, ... } as the value to set
> in wreq->transferred - which is then returned from ->write_iter().
> 
> LONG_MAX was chosen as the initial value so that all the streams can be
> quickly assessed by taking the smallest value of all stream->transferred -
> but this only works if we've set any of them.
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

[1/1] netfs: Fix unbuffered write error handling
      https://git.kernel.org/vfs/vfs/c/a3de58b12ce0

