Return-Path: <linux-fsdevel+bounces-18502-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 578778B9B3D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 May 2024 15:03:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88F411C22073
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 May 2024 13:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14B9E83CD5;
	Thu,  2 May 2024 13:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dGfl1koh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6448182498;
	Thu,  2 May 2024 13:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714654981; cv=none; b=Tj4y7oPGEZGyeIsTUsE31a+CXO0QuyYfWSimmj1QsNZi4R1bXknbdTG8Zp4vx9CQUuoYsaHfYX3gjhj7q+g8d48TxWE9YdpIgU9RhQtE0K+WNV0j/uimHtm+3QLUcYwODF9PUpJGoHliYNTHkzi/ZfDXsZnpewtlS0wZXno36R0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714654981; c=relaxed/simple;
	bh=3owJXZqQKDlXM66fGaGPZa02w52uxImomYF9LMzgu3U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z2VwANajyowWk39A/X3wTtHCt6RRtVMmXyeaY29+vuBDAihjqWA2cwVLdOnhxHEkBhLwiXXsUTKKAHdp6nhAkvssdX5y8P9+/2imyV1348ljgbA4kvW2d6O11WZMpV9boGfytgfSRoLXH2A8rC1/g7Yrv4mDfQ3PFOGrCUGKZ48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dGfl1koh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5EA2C113CC;
	Thu,  2 May 2024 13:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714654981;
	bh=3owJXZqQKDlXM66fGaGPZa02w52uxImomYF9LMzgu3U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dGfl1koh6Y7gdMSVQbhEOifZUKx3KCVuEOMk4QSZwo6EGVpnsvBYbzXNQ3RrhPKHF
	 gTtVKsJ/SBShnz5kt0UynrqEf5oK8gNabqpzKUXbSEoKGWm6sBaAn2eMvNemWyQD49
	 EIuK1xJTQ/aDKXzsqlpJL+B4EB/cjMXoUPWIU0U/pI4YHdGZsXQ0wKYTEH5Pf6T4Gk
	 WMI6VlyjgOF7G/+tA68fLLdapkmJ1LtkPhPsuw8EDSzuUMGPhaRqUqmrHLXtQ23qGh
	 bDjoU4jVQ2GTc3Co5UPzoXZiweLtquwjbbootjM6vNyjpkLy6WVV061JdZUCzBZZhX
	 KeQymeCCKG1aA==
From: Christian Brauner <brauner@kernel.org>
To: Christian Goettsche <cgoettsche@seltendoof.de>
Cc: Christian Brauner <brauner@kernel.org>,
	Christian Goettsche <cgzones@googlemail.com>,
	Jan Kara <jack@suse.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Arnd Bergmann <arnd@arndb.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Kees Cook <keescook@chromium.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Casey Schaufler <casey@schaufler-ca.com>,
	peterz@infradead.org,
	Sohil Mehta <sohil.mehta@intel.com>,
	Miklos Szeredi <mszeredi@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org
Subject: Re: [PATCH] fs/xattr: unify *at syscalls
Date: Thu,  2 May 2024 15:02:32 +0200
Message-ID: <20240502-nagel-geschirr-33c262989d99@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240430151917.30036-1-cgoettsche@seltendoof.de>
References: <20240430151917.30036-1-cgoettsche@seltendoof.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1012; i=brauner@kernel.org; h=from:subject:message-id; bh=3owJXZqQKDlXM66fGaGPZa02w52uxImomYF9LMzgu3U=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQZ9/3+rJRo8l5+5hvv6R9i3GeXzFk4N/pT4gfLzWe8g 1UPSLSydJSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEwkqY7hr2xTsuBW11WaJRoM EWK6z47bf/b77y2o2//qawSv0d7HFowMf7u3XqjUnnEzdfKGX5U7Ei49vvWJMYPx7bPQ2eeT51T fYQUA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Tue, 30 Apr 2024 17:19:14 +0200, Christian Göttsche wrote:
> Use the same parameter ordering for all four newly added *xattrat
> syscalls:
> 
>     dirfd, pathname, at_flags, ...
> 
> Also consistently use unsigned int as the type for at_flags.
> 
> [...]

Applied to the vfs.xattr branch of the vfs/vfs.git tree.
Patches in the vfs.xattr branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.xattr

[1/1] fs/xattr: unify *at syscalls
      https://git.kernel.org/vfs/vfs/c/1d5e73c8c531

