Return-Path: <linux-fsdevel+bounces-73394-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 05A4CD176FB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 09:59:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D57463038F02
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 08:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1DD8363C57;
	Tue, 13 Jan 2026 08:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TaduiMnp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C6C43128AE;
	Tue, 13 Jan 2026 08:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768294716; cv=none; b=XYvUXGcTiK554oAO4lxW8zE5gk5gHszykjmrrLj/B0I+Hy1+2FZgEWxwZA/yqLScbrRp7IIJbNNw0iJV9qYY+nIIZJNH0qdlhRuwvehaqDJMuOd85zkcDIRF6ObN4NTESvEOWiaVThINaTW/cVvV87Qta8v+g0dHv4MFrlQv9Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768294716; c=relaxed/simple;
	bh=V0lPzn6kjF9luU67P+V3gLXM71Kj7taU4Pd0q0Ba/8I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uTEdH5CrOZvBwQopxqU4sABt4ycG4qBvrIAM4/4ctUIImU+eyPz44BZGD/ba4P6bEKy/alRbEeN7emm2Xfr33TdbOclKW2I8ObsVPhJC2peiKWtaGTYtZQW1qY5YMSg+0V1gZer/ogAsCFHnAW2Zi7T1nednegEYQE90zrSrSkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TaduiMnp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8991EC116C6;
	Tue, 13 Jan 2026 08:58:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768294716;
	bh=V0lPzn6kjF9luU67P+V3gLXM71Kj7taU4Pd0q0Ba/8I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TaduiMnpFkWny3b2YLxjW57cFvY/g5OFjPzd5BvaUiWiy3q9NLnPZAnpXG+4Gi3jZ
	 z93uc0PXEBR4Mv8avBvc1N1/Fiut2tLXYdldycU+Qz02qTET9eQk/ItO+bDLH+Y05R
	 ZeXx0H8fmloCFtVYEaxRXdGy38hxyFA0mLIFRFLPtA+hzmU5n3rWuzsh6ceJDW6lAw
	 EmmdULq0l54SPUEkdhA4Lnin6iGw+ThAg+ggcxGvpiOm0Q40lqubbO+O+G/Cnu8vaC
	 Ld67n0NDELTF+iWk+mkX9bq1wkkfGmzyuZtOgntzONxIh55dGOPnGa/SD9wBAIN1m8
	 qfbt+3Q3R1mQw==
From: Christian Brauner <brauner@kernel.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-api@vger.kernel.org,
	jack@suse.cz,
	hch@lst.de,
	linux-xfs@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	gabriel@krisman.be,
	amir73il@gmail.com,
	Gao Xiang <xiang@kernel.org>
Subject: Re: [PATCHSET v5] fs: generic file IO error reporting
Date: Tue, 13 Jan 2026 09:58:29 +0100
Message-ID: <20260113-ortsbegehung-erklettern-a8cde9472f0d@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <176826402528.3490369.2415315475116356277.stgit@frogsfrogsfrogs>
References: <176826402528.3490369.2415315475116356277.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1787; i=brauner@kernel.org; h=from:subject:message-id; bh=V0lPzn6kjF9luU67P+V3gLXM71Kj7taU4Pd0q0Ba/8I=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSmcZo1vI/9eP5ArLrUz/d6tyUbLVZVL1Na7R8T+G3H9 jV1nG/YOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACbi1c/wP21NrubuU3JbRMU9 p4WrlRpHXzI66qec98StoJvxlZ18KsNfsaOvns/bYPE+w5LdqvqmfNf6sqR3rzOPC908tuXhtHO ynAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Mon, 12 Jan 2026 16:31:03 -0800, Darrick J. Wong wrote:
> This patchset adds some generic helpers so that filesystems can report
> errors to fsnotify in a standard way.  Then it adapts iomap to use the
> generic helpers so that any iomap-enabled filesystem can report I/O
> errors through this mechanism as well.  Finally, it makes XFS report
> metadata errors through this mechanism in much the same way that ext4
> does now.
> 
> [...]

Applied to the vfs-7.0.fserror branch of the vfs/vfs.git tree.
Patches in the vfs-7.0.fserror branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-7.0.fserror

[1/6] uapi: promote EFSCORRUPTED and EUCLEAN to errno.h
      https://git.kernel.org/vfs/vfs/c/602544773763
[2/6] fs: report filesystem and file I/O errors to fsnotify
      https://git.kernel.org/vfs/vfs/c/21945e6cb516
[3/6] iomap: report file I/O errors to the VFS
      https://git.kernel.org/vfs/vfs/c/a9d573ee88af
[4/6] xfs: report fs metadata errors via fsnotify
      https://git.kernel.org/vfs/vfs/c/efd87a100729
[5/6] xfs: translate fsdax media errors into file "data lost" errors when convenient
      https://git.kernel.org/vfs/vfs/c/94503211d2fd
[6/6] ext4: convert to new fserror helpers
      https://git.kernel.org/vfs/vfs/c/81d2e13a57c9

