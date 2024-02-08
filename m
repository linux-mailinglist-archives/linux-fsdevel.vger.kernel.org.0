Return-Path: <linux-fsdevel+bounces-10767-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 046D484DE23
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 11:23:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 653E4B2B0C6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 10:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E6DF6EB4F;
	Thu,  8 Feb 2024 10:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FoNBiHfO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7445A6E2C9;
	Thu,  8 Feb 2024 10:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707387695; cv=none; b=p9rjPDYmvBrlsXnLgv0MHKSs8P3bPG4hI0kmYDdQaAKaKAzxEVWhWUDCrCuILtpoSG/GqyuNm6sLbGum3nJtPtYXxdwa6loN0BYe/tMmyhqkEM21scvck+vbiro88CXcj9GbOYqSrPSu1uKyA5GtZ38s3rwrtISlTBeYwvk/QSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707387695; c=relaxed/simple;
	bh=WymTy0WHsJ7+lOXasaABlWFAYcpSaUy8/JPROfoXSsE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pqtSJ0RuHhrp7Z2RNGkPocLSurwiUSIA++7er2jvFQbxk9pEvEoJSRqgeBkyJYn4ys6TcT/luKLhQSS6tmUfllIR1oe6tgvWMPXe25DstiP6qVW/NSLTIMHdXxGebbypBOhtYyLRfhF0VOUkRDD2ulmXq1mUYx6co8FCRGB9SZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FoNBiHfO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76EABC433F1;
	Thu,  8 Feb 2024 10:21:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707387694;
	bh=WymTy0WHsJ7+lOXasaABlWFAYcpSaUy8/JPROfoXSsE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FoNBiHfOC6y/JmFHCrYHdSKv37cN3eEEHypYr8eIRunxjDQizf2LVPBTPGDgOkCJ9
	 QRDD8SGXkNgmgV0oEGF+RVXtkSAD3BcHckyzzDAg8ThbRLO0cpEAzKgNOwx7znf7cU
	 91Cp3G/dPgTTc3oUNWit+xUbw13qRwATpTGECpjNfFsT52jiY7ea962lidGsoVa3+L
	 wJ+5/xfhTO8At5Nc8AVsQ8UKgNmncQiWpG1CYewlsM63ED96IQWQjvaeySPgW4ji3C
	 J/wM20hrHuMb7ADZmnKYPUkX5zpYtB/b8rTt1j9khvTyh0S/e10Ce4GEm+QBpdegSK
	 EHTduQFL5fKZQ==
From: Christian Brauner <brauner@kernel.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-btrfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 0/7] filesystem visibililty ioctls
Date: Thu,  8 Feb 2024 11:20:45 +0100
Message-ID: <20240208-wecken-nutzen-3df1102a39b2@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207025624.1019754-1-kent.overstreet@linux.dev>
References: <20240207025624.1019754-1-kent.overstreet@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1950; i=brauner@kernel.org; h=from:subject:message-id; bh=WymTy0WHsJ7+lOXasaABlWFAYcpSaUy8/JPROfoXSsE=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQeWa206fW6cja3/OTmqv69C9TWPavW8LW7bbmS5dmiC X/23upO7ShlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjIgzSG/2GPtsVM8FhiG3n0 /Y1LngIXdjkvjFjdcrjxTEDL7piWNycZ/lmHV3gGXjCS6vTVyPu2p3TK49XGZwKa7DwnHjzgJCH 1iQEA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Tue, 06 Feb 2024 21:56:14 -0500, Kent Overstreet wrote:
> ok, any further bikeshedding better be along the lines of "this will
> cause a gaping security hole unless addressed" ;)
> 
> changes since v2:
>  - now using nak (0x15) ioctl range; documentation updated
>  - new helpers for setting the sysfs name
>  - sysfs name uuid now has a length field
> 
> [...]

I've merged that series and put it onto vfs.uuid. I think we should
really see some more ACKs from other filesystems maintainers for the
FS_IOC_GETFSSYSFSPATH bits. Once we have that we can declare that branch
stable.

Note, I dropped the bcachefs changes because they're not upstream yet.
But once this is a stable branch you can just pull in vfs.uuid and rely
on that.

---

Applied to the vfs.uuid branch of the vfs/vfs.git tree.
Patches in the vfs.uuid branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.uuid

[1/6] fs: super_set_uuid()
      https://git.kernel.org/vfs/vfs/c/4d451351605f
[2/6] overlayfs: Convert to super_set_uuid()
      https://git.kernel.org/vfs/vfs/c/5ad6ddd9c998
[3/6] fs: FS_IOC_GETUUID
      https://git.kernel.org/vfs/vfs/c/51ee9232f372
[4/6] fat: Hook up sb->s_uuid
      https://git.kernel.org/vfs/vfs/c/05dc73e146be
[5/6] fs: add FS_IOC_GETFSSYSFSPATH
      https://git.kernel.org/vfs/vfs/c/3dad731c7a45
[6/6] xfs: add support for FS_IOC_GETFSSYSFSPATH
      https://git.kernel.org/vfs/vfs/c/aa4386d4df60

