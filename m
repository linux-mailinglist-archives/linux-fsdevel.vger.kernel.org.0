Return-Path: <linux-fsdevel+bounces-20841-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE7EE8D852F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2024 16:36:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12658B24D0D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2024 14:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0173F12FB2F;
	Mon,  3 Jun 2024 14:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p2B4CV+M"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6417612BF34
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Jun 2024 14:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717425342; cv=none; b=aSRK7lTfTyPGMrEK0lYTm/efvkgPoDlc5XvwpBga4Vusyfu6Em3G+V5P6Yfeim87LyEvSGZGAb28Sw1DQ98aEBlOGxFyUCjTvFOWzbs0EG33Oh4o8i0trK055LZr8YmjqWmwI6Sn5jsE4fbBImgz8+2WZPYfxaGo2AoRjOa6SBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717425342; c=relaxed/simple;
	bh=gXDxGgjsqZPij10gds5fIA4zMBd03zCzjfopUpR6A9A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r7Z6827x7IU2UVr3vPHFQu7z0YexSQ+bDy77MWgA55ZXPxIqX0rrkvcQZU9ACTYGQlT4M07YwfOm9htaOQmG9Sx6oIPbqxTKfwg9zpxzvjB+FL/JSaVi0JpRqC4oKre9w0XhetnkNaOCxP6HGFGiU6LDldZ3V/CdGYEJuvvs3rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p2B4CV+M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7866C32781;
	Mon,  3 Jun 2024 14:35:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717425342;
	bh=gXDxGgjsqZPij10gds5fIA4zMBd03zCzjfopUpR6A9A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p2B4CV+M/UAZb8IY71evyjcLfpRcAydjClLqgG4S5Bh4jlhQUpqeH4eibFp8umofE
	 PEIZUfDFfQwdz9wgNmSSuymFdo9XkP5xTzBdCCPjcU0DkCVADyGMwTKCg3HoleiFW/
	 y9zhlEMOVfHXqlCj7Y3j4Yt886xTjgNa18/Up6VaFpWuKTVBFP9r+Z4XjwDRa+0BDm
	 tHQoI5Wae5FCKm5CbvAUxFFYNZviCPSYgJHdsSXksYQPO3oUi33kHzk5hQPFuEXD9T
	 JC47CEd4IQoVkI0KOIesbnOLH+5IO88+imiNyPJPvC+zv1ZQS1NW+0By9nsxhKX2rw
	 RFkfQI78RhZYw==
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	Hugh Dickins <hughd@google.com>,
	linux-mm@kvack.org,
	Mikulas Patocka <mpatocka@redhat.com>
Subject: Re: [PATCH] tmpfs: don't interrupt fallocate with EINTR
Date: Mon,  3 Jun 2024 16:35:33 +0200
Message-ID: <20240603-fixkosten-ansehen-af907fa0a056@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240515221044.590-1-jack@suse.cz>
References: <20240515221044.590-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1564; i=brauner@kernel.org; h=from:subject:message-id; bh=gXDxGgjsqZPij10gds5fIA4zMBd03zCzjfopUpR6A9A=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTFXtm+9VCbwJRPzV/damfpn2aYb37ulRfDLoHrF8Lj8 za99Zv7qKOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAiJsoM/4ybFawfeLX9e8Cj 3LPgiMbk1Ox1+wqCfe/67mZU8BYXb2Nk+Fq4+ecWgx1GGxKvsxYUb2Q4NMFF7hL/GXErp4oj25X ZmAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Thu, 16 May 2024 00:10:44 +0200, Jan Kara wrote:
> I have a program that sets up a periodic timer with 10ms interval. When
> the program attempts to call fallocate(2) on tmpfs, it goes into an
> infinite loop. fallocate(2) takes longer than 10ms, so it gets
> interrupted by a signal and it returns EINTR. On EINTR, the fallocate
> call is restarted, going into the same loop again.
> 
> Let's change the signal_pending() check in shmem_fallocate() loop to
> fatal_signal_pending(). This solves the problem of shmem_fallocate()
> constantly restarting. Since most other filesystem's fallocate methods
> don't react to signals, it is unlikely userspace really relies on timely
> delivery of non-fatal signals while fallocate is running. Also the
> comment before the signal check:
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

[1/1] tmpfs: don't interrupt fallocate with EINTR
      https://git.kernel.org/vfs/vfs/c/f113ef08b6bd

