Return-Path: <linux-fsdevel+bounces-19894-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53C798CB032
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 May 2024 16:17:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44C201C218FE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 May 2024 14:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E63F7FBC1;
	Tue, 21 May 2024 14:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Khodptqa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 611217FBA3;
	Tue, 21 May 2024 14:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716301019; cv=none; b=gAvxK68xXzOnZ08IKcycQCqhyFI1iaHhee2lDSRHFKvlT5WIwU0JXmS4o81sqGWocH8CE713Bg7AQebSeRMThHo4oD6L4xWSbXDA8A8EEF0Ng/10LHdUwOSlwG4ZiLUlan7obbG75ewKXvwzwyjEXiRTTKBkYYR+fQAOGYpWISI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716301019; c=relaxed/simple;
	bh=k7c5PdzZkjCSd2BhGuu+0h3gB9EZl1yGGRc5tKw1BSg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cftBAMYj35InjfjXf8W+j+yy5i3JEfVrTzc8+UnmwANNql2Npf7KmHBKYtBMJxdf79xjy3l1/iOdHHE9Ej4IWwEAcxZ8Qq9BNEG2dYNsPaROelhD++X/gM5gR8lvpsImbNyXtYmIxWumMS82IL1a43ssf3tONRRuVqGf7ovVKl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Khodptqa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73D29C32789;
	Tue, 21 May 2024 14:16:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716301018;
	bh=k7c5PdzZkjCSd2BhGuu+0h3gB9EZl1yGGRc5tKw1BSg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Khodptqap/WzDPfedXz/DwKuzyeN4v7AV1fI2Aa//uMXtUEGFr5QUU8A88tzXyI2s
	 M0Sx00YkT70Tbmy7bIx8pIb+FBUplpjaz+VxhV3KZqzM4nB0slseiCL18aStpSd6/j
	 rtG4A+JCKwTkVpTyTpdHtN3g7DolldIq43KA9Ou6xAU0Wzv4dvHox1Gr5sGCqYpW1k
	 HYodR3O5QUuZDzJVlKv5hzrkLO8XFSgpmjdgKt7o8Va5pg1/Z5cFvbBp8eX1Riu8x5
	 elXbEaL83L7qy2fh20lkataIdnGrav+9oLV88T236sPo9RKDTPY3zWu35nAwhONlL8
	 9QPtiEIUjwnVQ==
From: Christian Brauner <brauner@kernel.org>
To: Steve French <stfrench@microsoft.com>,
	David Howells <dhowells@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Enzo Matsumiya <ematsumiya@suse.de>,
	netfs@lists.linux.dev,
	v9fs@lists.linux.dev,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] netfs: Fix AIO error handling when doing write-through
Date: Tue, 21 May 2024 16:16:49 +0200
Message-ID: <20240521-handel-landbrot-e013a2c4560d@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <295052.1716298587@warthog.procyon.org.uk>
References: <295052.1716298587@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1381; i=brauner@kernel.org; h=from:subject:message-id; bh=k7c5PdzZkjCSd2BhGuu+0h3gB9EZl1yGGRc5tKw1BSg=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaT5rLn0rVQ1jjF39fu9z16/XlIhx1Nl41OR9F1K63uRF Gf+prW1HaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABNJiWP4Z3ksVLKaj8H8k5ON xg3nD/cuH2xcLGA/8b7FqwmP2Zl6JzP8j/jVEfFwJpvGt9dTb6wUXyBvMZnxo33KYx4buQ3K289 EMgEA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Tue, 21 May 2024 14:36:27 +0100, David Howells wrote:
> If an error occurs whilst we're doing an AIO write in write-through mode,
> we may end up calling ->ki_complete() *and* returning an error from
> ->write_iter().  This can result in either a UAF (the ->ki_complete() func
> pointer may get overwritten, for example) or a refcount underflow in
> io_submit() as ->ki_complete is called twice.
> 
> Fix this by making netfs_end_writethrough() - and thus
> netfs_perform_write() - unconditionally return -EIOCBQUEUED if we're doing
> an AIO write and wait for completion if we're not.
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

[1/1] netfs: Fix AIO error handling when doing write-through
      https://git.kernel.org/vfs/vfs/c/eb5239732070

