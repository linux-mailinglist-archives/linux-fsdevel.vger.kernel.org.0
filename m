Return-Path: <linux-fsdevel+bounces-34203-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA24B9C3ABB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 10:18:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 177081C218DA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 09:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65BB3172BD5;
	Mon, 11 Nov 2024 09:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RZrRpMmS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5BE81714D3;
	Mon, 11 Nov 2024 09:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731316695; cv=none; b=BwBP7hXjlezfovgscZVU335xscxlYy1EZYOQbWwgiP/eo2CzdkAA4nV0r0MdR+ecZDBc7lBBZl1duXbRczjq/+kxY/J27TjHea/+nKq28bUo+G99oUoY97nB5q/CSBdF2qKvk1qkDJkk8sET8iEfrnD3gjjd0UaxboZ97OCGVM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731316695; c=relaxed/simple;
	bh=CjWPjlsrG6f0aJgbWTLsSXlIywGkUpFxlCdUEkC7EmQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YA7CFT7E3bB5CJG55sE6sRZyXsBnpj+6kuYW/L+VefWMeP2cZ2E+Gc5JkXJzPk8KNPocHXdhWFsJg9nvmbLjp30k1YRhmYCt3bAomPbGLgA20n/RLA0YpnWCjztdVmTDFS99aCECqOOcxMippIs2EP94j8unSkuDfETqAbRvBoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RZrRpMmS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3B1CC4CED4;
	Mon, 11 Nov 2024 09:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731316695;
	bh=CjWPjlsrG6f0aJgbWTLsSXlIywGkUpFxlCdUEkC7EmQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RZrRpMmSnTS7BlJI4hWwTif2Otv09ws03qQCnfrt7pwK7kfLfKVlDjfP/RpElx8Fw
	 MruEncw6mgtoTUan3dYISV3auLpeRFko6VW/DGZPw3P7StEVx4XFEkZXMNnPkQdHh5
	 aBGaBCbEzKPACdXWpwXRFtCQ5rGNlSlQAkg6zc1i6AWE2tGQhU4GxxNdQp0RV6sYEz
	 S86K1wnIT3nXmby1IMyOF4XY25NhYbKSsm7U8K3BQlFtC/6DKf5bEGjYElHlj0oPzH
	 +rtPx90jeD7Yx7UAn9yjjgrUEf8fU9WilbtvYb3AUTwZvfaWNrrySQY434mr+bgG58
	 1FLp0tHTc6xYQ==
From: Christian Brauner <brauner@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Ian Kent <raven@themaw.net>,
	Josef Bacik <josef@toxicpanda.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>
Subject: Re: [PATCH v3 0/2] fs: allow statmount to fetch the subtype and devname
Date: Mon, 11 Nov 2024 10:17:20 +0100
Message-ID: <20241111-ruhezeit-renovieren-d78a10af973f@brauner>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241107-statmount-v3-0-da5b9744c121@kernel.org>
References: <20241107-statmount-v3-0-da5b9744c121@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1359; i=brauner@kernel.org; h=from:subject:message-id; bh=CjWPjlsrG6f0aJgbWTLsSXlIywGkUpFxlCdUEkC7EmQ=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQbnj7bova2JInv0W8xuZmfeaYqlz9ZJ/lEb+eT7vbAO cxdj1dO6yhlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZiIwm+GfybXTIyYzu3dvSrg dqqfVLdw81bls0c6g8s3zDdeH8ya8Ibhn7rqj75KYdbV0jYKr1/P3PTiek5e5763Rb4bP2q3cgZ b8AIA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Thu, 07 Nov 2024 16:00:05 -0500, Jeff Layton wrote:
> Meta has some internal logging that scrapes /proc/self/mountinfo today.
> I'd like to convert it to use listmount()/statmount(), so we can do a
> better job of monitoring with containers. We're missing some fields
> though. This patchset adds them.
> 
> 

I know Karel has been wanting this for libmount as well. Thanks for
doing this! It would be nice if you could also add some selftests!

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

[1/2] fs: add the ability for statmount() to report the fs_subtype
      https://git.kernel.org/vfs/vfs/c/ddfdeccd46bd
[2/2] fs: add the ability for statmount() to report the mnt_devname
      https://git.kernel.org/vfs/vfs/c/6fb42b3c00cd

