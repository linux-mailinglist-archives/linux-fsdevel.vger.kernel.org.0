Return-Path: <linux-fsdevel+bounces-16433-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9DBB89D701
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Apr 2024 12:30:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EEBB1F22438
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Apr 2024 10:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19AAE83CB2;
	Tue,  9 Apr 2024 10:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EwVyzQC3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D076FE35;
	Tue,  9 Apr 2024 10:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712658624; cv=none; b=Voghjr7whVy/xA+qZyD+PMQd/ijw3KUWjcBWhyOyuDMD8iHY56kb6LYcSHOEiu6rWqF1VxWZqzgPDvpyVW9w3sJXRjURb6HXCbyulv7yhuxd8HH2t56dCB9l16urG4b+9KMUMHRJdvIh6Nec8hynlUq52sT+/doQFkD8wOPxs68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712658624; c=relaxed/simple;
	bh=+WsfLWPMvINV1p5eV2N/9XA7OTihbOmV8wGOocCa5qc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=spRXrWQ7rDGQeGw1kSzvRKm+dzE5xsskerB/62LZ099Unn9gJ3J06GEvqXj0XsOw+g9ZNndcm4QLKLztvLu5PaB90JxOxZYTiaP+FoI5mq8lROX2sejLa1U2vo8cxc34a8nzborpW8I1wi+cR6Rbi57ukbcrSCdG7vf7unwiP3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EwVyzQC3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5851C433F1;
	Tue,  9 Apr 2024 10:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712658624;
	bh=+WsfLWPMvINV1p5eV2N/9XA7OTihbOmV8wGOocCa5qc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EwVyzQC3uVh2JUZgsRjblcZ/RBS8aK/vY7BvQAYVeyh7l7oCX+CaHaUZGe5mA4qnh
	 jiaQkT7zcpBQ+hnvdV4d73JhgjdOQnRySSUcyJqGbrOz2yVpExKMzq4KtY2rPgzHxu
	 oa0Bowy3uG1lJM+HWWsgouCU8ECkpr+LVeUWxTmoDbDUdQIFoYWqJXtSfdotaZHlmu
	 MuifkwOP+2KHokArRICAgMAYRiBvIaEwtJWGFCgUPnIImi72xD2F3PHgMXuWDIVBuo
	 mdcs3WIg8wm/tw3y/sN79SgysczfXvkHu4Y0cwcDl4YYH/k33J2da5lV76vmNwW0Ya
	 8Cr4LvLjrZHLQ==
From: Christian Brauner <brauner@kernel.org>
To: linke li <lilinke99@qq.com>
Cc: Christian Brauner <brauner@kernel.org>,
	xujianhao01@gmail.com,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs/dcache: Re-use value stored to dentry->d_flags instead of re-reading
Date: Tue,  9 Apr 2024 12:29:22 +0200
Message-ID: <20240409-gattung-vorsehen-0187be2ab894@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <tencent_5E187BD0A61BA28605E85405F15228254D0A@qq.com>
References: <tencent_5E187BD0A61BA28605E85405F15228254D0A@qq.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1211; i=brauner@kernel.org; h=from:subject:message-id; bh=+WsfLWPMvINV1p5eV2N/9XA7OTihbOmV8wGOocCa5qc=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSJSixTuvd5wwWt4sJlh7/t2NXmezOX7f+n53Mqrpxbc qijz/tzYEcpC4MYF4OsmCKLQ7tJuNxynorNRpkaMHNYmUCGMHBxCsBE1LcyMvTLbUubGrfFVPu1 9+oDD/YW3tgz58OKS5Iay5w7Wd6rLGVj+Gf4Z273AebUedYL9sfEaW7rumww63mm8/WTE0MaTa1 nz2QHAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Wed, 03 Apr 2024 10:10:08 +0800, linke li wrote:
> Currently, the __d_clear_type_and_inode() writes the value flags to
> dentry->d_flags, then immediately re-reads it in order to use it in a if
> statement. This re-read is useless because no other update to
> dentry->d_flags can occur at this point.
> 
> This commit therefore re-use flags in the if statement instead of
> re-reading dentry->d_flags.
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

[1/1] fs/dcache: Re-use value stored to dentry->d_flags instead of re-reading
      https://git.kernel.org/vfs/vfs/c/8bfb40be31dd

