Return-Path: <linux-fsdevel+bounces-31520-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B63E2998047
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2024 10:41:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C81141C242F8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2024 08:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1E4A1C9B9D;
	Thu, 10 Oct 2024 08:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nZWgqpS0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ABAB186607;
	Thu, 10 Oct 2024 08:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728548514; cv=none; b=mAZ1PZrNZhZV35AJBQVJ0+bKs7pqu/oQF2RrK0RiK7r0scp3bVXJ5DsK/ikoKpFCoc20IJIN1um5tEkU4HttvuWqP8cr/N3ZTFMqqAufWlsveMlke9sgZ5oqphyhNr+4GKSMaEHsvrisAOU+8b0+nz1YnwNtvr4LMpB4VzD+k64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728548514; c=relaxed/simple;
	bh=1oaEs6+CcYEJ2QZldN4x/tFdRT65xBFSu9IDkB7uPT0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hboVOXxiKf5xtoRnsRoH6K6pvAvvLE7PH3xJitpaGjZk3G/4Z62i9hx/3bNj/TDsT9idFCmV8dUnbG3SJxnicn9BZN2OuSDQpzjTBETOB+ovmktAechMbCoC9zNBrV8M/nIEkmTec79vVhNugukOsr5F3ZL3lNi/H8giLxL+gE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nZWgqpS0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56360C4CEC5;
	Thu, 10 Oct 2024 08:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728548513;
	bh=1oaEs6+CcYEJ2QZldN4x/tFdRT65xBFSu9IDkB7uPT0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nZWgqpS0l8KPZLm+XHq8TrzWpQ/p+ucVolrXNn0HhOsNHp6xAvPiLPXcsOYgvPKnv
	 JIVlKbKpmMFDgL+JVwjUzhoo5eqSY47Cnp985RAimp85YTZXvQeEMDasvdP9UJWYm3
	 3suSyKYNrK5PH0F4mQGkHQtydwRLgePNCO12n5aEXHpgHoJiERwVbEfHvCbP2aOGT5
	 3S/+6lqFUrR8u+uBIoKDX/eTjbXfqy4mU6cl0FQOosOg9XiksooueT8awRmoQrlshE
	 SezAbCi2QCngkUTV0cF28key5jjoE6LxFo5cN7CcR5Kjk2kpQXmxncwZuHja1SsTQ3
	 XDhU8XOcCaFyQ==
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>,
	Jeff Layton <jlayton@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] fs: grab current_time() in setattr_copy_mgtime() when ATTR_CTIME is unset
Date: Thu, 10 Oct 2024 10:21:24 +0200
Message-ID: <20241010-nashorn-talstation-cd95475f889c@brauner>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241009-mgtime-v1-1-383b9e0481b5@kernel.org>
References: <20241009-mgtime-v1-1-383b9e0481b5@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1071; i=brauner@kernel.org; h=from:subject:message-id; bh=1oaEs6+CcYEJ2QZldN4x/tFdRT65xBFSu9IDkB7uPT0=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSz981m/JVjOJ95Z6rtUt6wOSf7tyv4VhQF/baQmNJmf GqBxtnyjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIksyGRkmHnDxZk3m33Cm4Le 3TK95awc5xdILA2ZfvfqT1aLKzlZvxn+5+azue++b+voohORfCpYinXzLTYb69seNdncUrsXZ4d xAQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Wed, 09 Oct 2024 12:26:32 -0400, Jeff Layton wrote:
> With support of delegated timestamps, nfsd can issue a setattr that sets
> the atime, but not the ctime. Ensure that when the ctime isn't set that
> "now" is set to the current coarse-grained time.
> 
> 

Folded into the original patch.

---

Applied to the vfs.mgtime branch of the vfs/vfs.git tree.
Patches in the vfs.mgtime branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.mgtime

[1/1] fs: grab current_time() in setattr_copy_mgtime() when ATTR_CTIME is unset
      (no commit info)

