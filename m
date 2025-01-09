Return-Path: <linux-fsdevel+bounces-38753-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D15DBA07D4E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jan 2025 17:20:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B69E87A013F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jan 2025 16:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D7EA221D9B;
	Thu,  9 Jan 2025 16:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WWoBNtx0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E8D7FD;
	Thu,  9 Jan 2025 16:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736439589; cv=none; b=sRh8IA86ZM/9dIGnzwF4cuNRXwgQU9DcBXK4auTm9PCOy4CHtghf+AKw3ShIUcfyxgvrEROnFknPhfaKlN9zryC+NSXp0KvgGGPwXHtmpRKEVLsmubhtg+6sS+coB4elrHi8lz7nBtRf6FHxWaLeMlIpWmpQz4sfJW5YnBKbZGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736439589; c=relaxed/simple;
	bh=dT2Di/AJfEvLQNlMs2IJ4b62sJt2FtdY0tvJXjcTzpM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IblMENjdTg+aQZ9wrH4NVWgj05LrQKpksABITx5+2pdIIH9z60zj70Iv49wpvPrCGGyz7qNwNhpkQw8RSS8D54T7xvZBPy/ta8YjEiRs411hQ5HE5y9z3/mES4MQZxDhuq7leqwSCibJFFMaLqNMjKRlzxPD2/DyAXK+EQWz+OA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WWoBNtx0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1954C4CED2;
	Thu,  9 Jan 2025 16:19:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736439588;
	bh=dT2Di/AJfEvLQNlMs2IJ4b62sJt2FtdY0tvJXjcTzpM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WWoBNtx0ooMX7M0lUJyRfruK6zWbtIC8NBuWD+EFbRx6YcS9Yv6vhH0mielNoQ1cW
	 xBCYFuD6GCtvOKvbewdBGxSsL6oTj/ARcEtm5epGXEi4mSzhpkAotAlS7LvUO1pCQn
	 fulgpu3D0KueKJsUrYWHCjhZNJTgK2kFHN8gDwPr620Q1kRGd6MKvOtqNSJYou93z1
	 tYPFCCHuri2Ou8pnbPyEYh+XXyPKiRB5XNCeGGJjhwdiQHdxkHa9SzhHc9wT/6vy4P
	 k2SzAJAoKWgTmeUMwMGqsA3lRhouayhlgF4Bo4//0k1tdhDuLiVLXikll1MX+7XNVa
	 ZbtAHmLueSUGw==
From: Christian Brauner <brauner@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Nicolas Baranger <nicolas.baranger@3xo.fr>,
	Paulo Alcantara <pc@manguebit.com>,
	Steve French <smfrench@gmail.com>,
	Jeff Layton <jlayton@kernel.org>,
	netfs@lists.linux.dev,
	linux-cifs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] netfs: Fix kernel async DIO
Date: Thu,  9 Jan 2025 17:19:39 +0100
Message-ID: <20250109-sonntag-surfen-6f60a9399120@brauner>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <608725.1736275167@warthog.procyon.org.uk>
References: <608725.1736275167@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1208; i=brauner@kernel.org; h=from:subject:message-id; bh=dT2Di/AJfEvLQNlMs2IJ4b62sJt2FtdY0tvJXjcTzpM=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTXf5ctCSlN+6xpPn/Crt1C939Y3zHcYufTVj1zaT9n2 65blptndJSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzkuS4jQ9+f21XxHQVWZ5Ol D5fPndo1WXaRjJGVyuJbocuE5e63RjAy7Fq8bmaoq1JxlvZu/yTnVf7bfb9sf7tn+7wPBtlNkbJ X2QE=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Tue, 07 Jan 2025 18:39:27 +0000, David Howells wrote:
> Netfslib needs to be able to handle kernel-initiated asynchronous DIO that
> is supplied with a bio_vec[] array.  Currently, because of the async flag,
> this gets passed to netfs_extract_user_iter() which throws a warning and
> fails because it only handles IOVEC and UBUF iterators.  This can be
> triggered through a combination of cifs and a loopback blockdev with
> something like:
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

[1/1] netfs: Fix kernel async DIO
      https://git.kernel.org/vfs/vfs/c/3f6bc9e3ab9b

