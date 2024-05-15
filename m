Return-Path: <linux-fsdevel+bounces-19544-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 879878C6AD9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 May 2024 18:45:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E001AB21A8C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 May 2024 16:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26B5028E11;
	Wed, 15 May 2024 16:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mlTuY0/q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A79C13AF2;
	Wed, 15 May 2024 16:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715791539; cv=none; b=u830FdK9f9f56MVXJY6VaXZd1bFGBAxDNltNgS3pIIQQO9r4UhOjSA35H1ZQrD5bMzDP/jo+TBX1ZV8iqQVi4MmUwtlSIUqVYMhLNzId8LA5ytdfi9CVPjNKojYDmkqeEYVdhBIZl3zlCW++OwmLZ2GyGHLFjRGlRBHtFZUB+FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715791539; c=relaxed/simple;
	bh=vK6BDh/ZxI93Wj/Q6jEb75a/+f6y+21Ik+iDUEf/6/4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pbJ87nKNWsm3cdVKSs+T95DmBx6opg05PYVYGsedqigVneig3GdUPnkbr70HGaZM4nfboshKwVHAQi7rBcNE9vdsP8bPswA0gy1lUYeflIpqpWx70zTOp0HXyU/r6hKcIq4y391V9RD055wraWBUyFhB7H2KtfQIovrmQX+dDvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mlTuY0/q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B7A8C2BD11;
	Wed, 15 May 2024 16:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715791539;
	bh=vK6BDh/ZxI93Wj/Q6jEb75a/+f6y+21Ik+iDUEf/6/4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mlTuY0/q8WASE+XyxPmUN1U8+itMh/E5KCOiI+kHt0U0+Qji8wnxTTwd4Dw9fmQMY
	 5htov0vO/O2pRA7LlF+E+pwHUGJljkDT8GLSJI19Z08V2qzUk8q7YPYVwEDd3TneeY
	 r3W4t6QHQaCKDDh2NA6Uz+Ca3UNHcejElCNx608hTYxhLK8YjlW8L+wiVWckZVqGR2
	 +Swe6+LSQrXMi/8iNdXpF1Kr1VF6V4X0dF6Z6YleodC70hNdtuG2m2KZMIkDFF8uGQ
	 yIbrRnqV5HEX1zS6S53QfkCnMTu/OiE7k374P7201sgwLIPKo/Qeocyj6uH8e1Uz/Q
	 qbvaUjro9LIqw==
From: Christian Brauner <brauner@kernel.org>
To: Justin Stitt <justinstitt@google.com>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	linux-hardening@vger.kernel.org,
	Kees Cook <keescook@chromium.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Nathan Chancellor <nathan@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH v2] fs: remove accidental overflow during wraparound check
Date: Wed, 15 May 2024 18:44:45 +0200
Message-ID: <20240515-rentier-abwinken-f9c282783235@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240513-b4-sio-vfs_fallocate-v2-1-db415872fb16@google.com>
References: <20240513-b4-sio-vfs_fallocate-v2-1-db415872fb16@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=2300; i=brauner@kernel.org; h=from:subject:message-id; bh=vK6BDh/ZxI93Wj/Q6jEb75a/+f6y+21Ik+iDUEf/6/4=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaS5PFsX9CS2lNF8bmXCqnky74M2aMk0sLXOTnriefCJ0 ULxgoUXO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACbS8Znhf8CWzw/ut4okRjyS rdKSO5xyRiz74c5DNec6I51YYuv3mzP89/3p+/roimIb2VgpUY3QhAc7C5juvhE45Kahel9+47c 4dgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Mon, 13 May 2024 17:50:30 +0000, Justin Stitt wrote:
> Running syzkaller with the newly enabled signed integer overflow
> sanitizer produces this report:
> 
> [  195.401651] ------------[ cut here ]------------
> [  195.404808] UBSAN: signed-integer-overflow in ../fs/open.c:321:15
> [  195.408739] 9223372036854775807 + 562984447377399 cannot be represented in type 'loff_t' (aka 'long long')
> [  195.414683] CPU: 1 PID: 703 Comm: syz-executor.0 Not tainted 6.8.0-rc2-00039-g14de58dbe653-dirty #11
> [  195.420138] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
> [  195.425804] Call Trace:
> [  195.427360]  <TASK>
> [  195.428791]  dump_stack_lvl+0x93/0xd0
> [  195.431150]  handle_overflow+0x171/0x1b0
> [  195.433640]  vfs_fallocate+0x459/0x4f0
> ...
> [  195.490053] ------------[ cut here ]------------
> [  195.493146] UBSAN: signed-integer-overflow in ../fs/open.c:321:61
> [  195.497030] 9223372036854775807 + 562984447377399 cannot be represented in type 'loff_t' (aka 'long long)
> [  195.502940] CPU: 1 PID: 703 Comm: syz-executor.0 Not tainted 6.8.0-rc2-00039-g14de58dbe653-dirty #11
> [  195.508395] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
> [  195.514075] Call Trace:
> [  195.515636]  <TASK>
> [  195.517000]  dump_stack_lvl+0x93/0xd0
> [  195.519255]  handle_overflow+0x171/0x1b0
> [  195.521677]  vfs_fallocate+0x4cb/0x4f0
> [  195.524033]  __x64_sys_fallocate+0xb2/0xf0
> 
> [...]

Applied to the vfs.misc branch of the vfs/vfs.git tree.
Patches in the vfs.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.misc

[1/1] fs: remove accidental overflow during wraparound check
      https://git.kernel.org/vfs/vfs/c/c01a23b6fbd1

