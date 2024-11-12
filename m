Return-Path: <linux-fsdevel+bounces-34455-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EE059C596D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 14:45:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04087281D9F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 13:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA1861F7543;
	Tue, 12 Nov 2024 13:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VnTggYnu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 577691F708F
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 Nov 2024 13:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731419114; cv=none; b=eOzjEonPSY76FXaHEKemYQ7xuwvLVJlswmToaXe7lZ88pyLGX6z71iCE6k/OnWYniaRL9jNzN6HebB3g5wbGXBZii54VIFmAJx0Ec5s/rf8v+dGecp/PqrJ22NgcDvrJ8itXAxkmLe73OZTwNd5K873tulZZuTKRPX8XKjm0SGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731419114; c=relaxed/simple;
	bh=hqirPU8dF9XuvNLaVCuW0ykOjdQdJyevrWzaIpl7TZs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eHJGWummTZHrBP4oT+0hRQdOmQztIWVgsvoZlNmgX9QUxdzf+Re9C+te0vLErVb2KlellAB6OpaJNkFNgGEprDlULeqfn+QrEBXuatrLQYt2F3OWgMA61fOkm4uT5XG1PNBtUUjvL05uj0YMXphNXAw2BpV4A9u4T2rMLh/oVZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VnTggYnu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16A72C4CECD;
	Tue, 12 Nov 2024 13:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731419113;
	bh=hqirPU8dF9XuvNLaVCuW0ykOjdQdJyevrWzaIpl7TZs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VnTggYnuO0h4lJ8zGUvEMFgagjozfhDKTVq9qhjMN8JG7xe/1JAPFq26D/YK1Mlxy
	 wG4Zm1SGTLgedqIq9hWARs3dWTuXN3eodbzgTzY00UYhI2amDy6U0XlAUeDlO8iFJF
	 GU0eu4P+fb2a5Iz8SLR9wBkX7pAPRXQ8wfWSdFG4ms1ySI5SqZ7iuztUi27MRK3x7P
	 Frq8ULggIpEZggW+zBEK9KBKUlZs9eMtUHZHeEMQ4Kyi6cQ6Ssgjf5RvVq4CHTGIPX
	 V8QBunSoAd7pSVXTUcu4QJiakBfHLAHCBH5ChGmISgQqhDk8/I8hYQnXAVkMIe37dV
	 Mb8Q37yl7yFiQ==
From: Christian Brauner <brauner@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	Al Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>
Subject: Re: two little writeback cleanups v2
Date: Tue, 12 Nov 2024 14:44:58 +0100
Message-ID: <20241112-frequentieren-farbfernseher-c6f75d2531ef@brauner>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241112054403.1470586-1-hch@lst.de>
References: <20241112054403.1470586-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1235; i=brauner@kernel.org; h=from:subject:message-id; bh=hqirPU8dF9XuvNLaVCuW0ykOjdQdJyevrWzaIpl7TZs=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQbRz8OKoiVehIQZ2DBd5WLoV2m/Yl/0ealex9pC61TP v7w5/k/HaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABO5MYmRYYNYYOVkv5S4tzP1 rn8UU/zza87BgucJD7bxLxRjFVTNi2RkmLbfwmHdPoVJthFZFWcC9i+zW1HLqrn2MNvD4A+B/3e 94wcA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Tue, 12 Nov 2024 06:43:53 +0100, Christoph Hellwig wrote:
> this fixes one (of multiple) sparse warnings in fs-writeback.c, and
> then reshuffles the code a bit that only the proper high level API
> instead of low-level helpers is exported.
> 
> Changes since v1:
>  - mention the correct function in the patch 2 subject
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

[1/2] writeback: add a __releases annoation to wbc_attach_and_unlock_inode
      https://git.kernel.org/vfs/vfs/c/4d7485cff599
[2/2] writeback: wbc_attach_fdatawrite_inode out of line
      https://git.kernel.org/vfs/vfs/c/8182a8b39aa2

