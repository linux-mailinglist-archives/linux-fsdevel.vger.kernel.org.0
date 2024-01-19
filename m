Return-Path: <linux-fsdevel+bounces-8310-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F97C832B64
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jan 2024 15:36:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2A761C23521
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jan 2024 14:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E98453E05;
	Fri, 19 Jan 2024 14:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MOJbhvWu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 020E736AE0;
	Fri, 19 Jan 2024 14:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705674966; cv=none; b=ehz5+1fW7FRoxhXLjBIK2tErBEnuXFOE0CrpIqvGske1EUHY+fdjMFgCACVIs/6dk3yoU/vSVJurasJggOHFMkbBwqkzn6QAYzewq+KEnKOUXH6LMb3opjXxl4Gm5gfBnp28EST+jpInUNTtWM0acgH/mduF+RLPUw2clOj/r2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705674966; c=relaxed/simple;
	bh=HuF2gjruI61tSBMxn8SeRxIPR2u9R5zRnNfHuaZ41JI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kGH2z2Olejm0wFwIqsdOIM71QaaG8f/VNObuKeKDHwLBbRiXF9EnF3JQa/Z218lVt3xOOYZzcYPnEZq4yx1Lem4QbHgyAULLVvPw71XKH2FYoz8kS9vJql9cBzBMhuJwRLWJd5tc/FCsibWViYTv4qwSYznqgJ2IkP2Z+wBUwG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MOJbhvWu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC27CC433F1;
	Fri, 19 Jan 2024 14:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705674965;
	bh=HuF2gjruI61tSBMxn8SeRxIPR2u9R5zRnNfHuaZ41JI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MOJbhvWueT1hIFiC4nYcb4itt235fxN63XtfNTTC4lbN2GjRSAKzT/BLina1tmPks
	 sIJSNpgU4P4gYqY0/sObsoIK2Lt/Z9c9bQcOUJfzbzsm7s1QwRTFvqw/NwunN4fA0p
	 zSJ7O/+ArAqaJT5oSn2uwrJjTZbJwASzePzxR+wcBOXLjD9D0tA8N3ww+bTBjdMrnX
	 laKnpMQrKvF14kTj4mccdsAIamqlBnuR1PhsVQ2YAKB1uXQKCk5unaLZp5iDMKUKSD
	 q08gw3YCM6E2Qp3ULGf+CstDvAX5loFOnl8RXngd/rKjPaxvZCySBbjQnlzJK2lAaa
	 fowBaLsTtJTJw==
From: Christian Brauner <brauner@kernel.org>
To: Rich Felker <dalias@libc.org>,
	Jens Axboe <axboe@kernel.dk>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	kernel list <linux-kernel@vger.kernel.org>,
	Linux API <linux-api@vger.kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Jann Horn <jannh@google.com>
Subject: Re: [PATCH v2] vfs: add RWF_NOAPPEND flag for pwritev2
Date: Fri, 19 Jan 2024 15:33:32 +0100
Message-ID: <20240119-neuverfilmung-aufregend-54a5bd5929dd@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20200831153207.GO3265@brightrain.aerifal.cx>
References: <20200831153207.GO3265@brightrain.aerifal.cx>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1814; i=brauner@kernel.org; h=from:subject:message-id; bh=HuF2gjruI61tSBMxn8SeRxIPR2u9R5zRnNfHuaZ41JI=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSu6tjpcyOYb3f4fQYn+4IHS0Mb2AMliozXMp3/6ptRm qCZ+HduRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwET6njP8L0pKeLk1sszN54x3 xALHHqtf+5apP/1iZPe2L7v8QPP7Awx/5U/wKahenPX9RkTY9WcqSb9vfJLsCJrA8uBArai8kA4 /LwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Mon, 31 Aug 2020 11:32:08 -0400, Rich Felker wrote:
> The pwrite function, originally defined by POSIX (thus the "p"), is
> defined to ignore O_APPEND and write at the offset passed as its
> argument. However, historically Linux honored O_APPEND if set and
> ignored the offset. This cannot be changed due to stability policy,
> but is documented in the man page as a bug.
> 
> Now that there's a pwritev2 syscall providing a superset of the pwrite
> functionality that has a flags argument, the conforming behavior can
> be offered to userspace via a new flag. Since pwritev2 checks flag
> validity (in kiocb_set_rw_flags) and reports unknown ones with
> EOPNOTSUPP, callers will not get wrong behavior on old kernels that
> don't support the new flag; the error is reported and the caller can
> decide how to handle it.
> 
> [...]

The RWF_* and IOCB_* flags were
aligned so they could be set in one operation. So there was a merge
conflict when applying. I've resolved it. Please take a look and make
sure that it's all correct.

---

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

[1/1] vfs: add RWF_NOAPPEND flag for pwritev2
      https://git.kernel.org/vfs/vfs/c/31081ab305a1

