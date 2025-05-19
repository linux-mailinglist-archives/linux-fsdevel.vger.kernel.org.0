Return-Path: <linux-fsdevel+bounces-49390-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29F3FABBAA1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 12:07:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B36853ADD4F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 10:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AABD269D0A;
	Mon, 19 May 2025 10:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uwU+Y8rP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9262A94F;
	Mon, 19 May 2025 10:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747649222; cv=none; b=VCDFnz3bnccxKOD7HOhofnwZHrVIMcxpOZg8uehMr6O7UrCQtpjpPCTNcQrpOaEXOYo9HpOA2SwZi0R615bXOcRnTNCa80bRI5lK6Z7eInCOINM5NEEeqwImYD8deGJnQxKRTgdgqiFgIO5FoRxZNFjUmrFoGrMAFpxr0ajI+NM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747649222; c=relaxed/simple;
	bh=akfpDKLkt7E1tvdRhNNlmeoQGdEkgtVnox9Ttq4P3Ss=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Erb1zafHvNwL8J4/Q00GLTr/v81BcqdfFg1NKuV9IRZRDQw9kzyFW+daP+rnyTukwSYGtihSOBYmnzwN7oZN1qKthuUaXx2EYTe0mxumgu2JviV5xfQxRPPG5KTDZxcBGCeECx9U6WsJBH5xtZfMLJUdHtTI2x1ljPXIXSYOsw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uwU+Y8rP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A9D2C4CEE4;
	Mon, 19 May 2025 10:07:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747649222;
	bh=akfpDKLkt7E1tvdRhNNlmeoQGdEkgtVnox9Ttq4P3Ss=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uwU+Y8rPlahd06WIF+I8lGsAfVgut4nyzDjCy2CEcgJjqOxu1kVdRGzN/IlxesAyv
	 YJZ+DlT2pjD963wUzfeWL2+w0lhxYT1fUro716Ioq8E4pKkJ24v3rwdIyXzIcFStMr
	 r8Zp62jAKPWSQ7dizzCVAgW+Am4Py65W5B/oGOOwW28MDy320lwGXgoRFNzHuUWBbP
	 OFCS6H7NQV+24hrarzfIkiId7z08jgs9frNuNvN5WJZLCymMVre8WHRWAURkNebrZ4
	 jAZHfUP0ZqjzxoMwN45Num+L77zENxTQKrlrB+fhKbjYITzTzrfvOSlw907cFNv3zo
	 xQTR3BRujQljw==
From: Christian Brauner <brauner@kernel.org>
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: Christian Brauner <brauner@kernel.org>,
	jack@suse.cz,
	viro@zeniv.linux.org.uk,
	mcgrof@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next 0/4] fs/buffer: misc optimizations
Date: Mon, 19 May 2025 12:06:56 +0200
Message-ID: <20250519-jemand-sehnen-ee7f86956d13@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250515173925.147823-1-dave@stgolabs.net>
References: <20250515173925.147823-1-dave@stgolabs.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1464; i=brauner@kernel.org; h=from:subject:message-id; bh=akfpDKLkt7E1tvdRhNNlmeoQGdEkgtVnox9Ttq4P3Ss=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRoMx28FqG45+l/kyCLxYeL7y3kCPbo1bTjfMm5KIl30 cH31kuWdJSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzkzwJGht2qciZfXismvhJg X81ZW8tzJaJmql5DvU95/ekTBjPkNjH8j7H7GHn4ultyhMhJTnWfT+ZdWx8Em0zee0HQ9EpC+JF obgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Thu, 15 May 2025 10:39:21 -0700, Davidlohr Bueso wrote:
> Four small patches - the first could be sent to Linus for v6.15 considering
> it is a missing nonblocking lookup conversion in the getblk slowpath I
> had missed. The other two patches are small optimizations found while reading
> the code, and one rocket science cleanup patch.
> 
> Thanks!
> 
> [...]

Applied to the vfs-6.16.misc branch of the vfs/vfs.git tree.
Patches in the vfs-6.16.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.16.misc

[1/4] fs/buffer: use sleeping lookup in __getblk_slowpath()
      https://git.kernel.org/vfs/vfs/c/f13865bcff54
[2/4] fs/buffer: avoid redundant lookup in getblk slowpath
      https://git.kernel.org/vfs/vfs/c/545f109630fc
[3/4] fs/buffer: remove superfluous statements
      https://git.kernel.org/vfs/vfs/c/fd7bedc81a2e
[4/4] fs/buffer: optimize discard_buffer()
      https://git.kernel.org/vfs/vfs/c/a09d25918f3d

