Return-Path: <linux-fsdevel+bounces-35271-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC32C9D354D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2024 09:23:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D279B2364D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2024 08:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2802416DC3C;
	Wed, 20 Nov 2024 08:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="slOCr+Hf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87ACD1B7F4;
	Wed, 20 Nov 2024 08:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732091003; cv=none; b=aZpmUFbgM/jXBRErNadSu2qQG/NVvnxM6VYg7GXabZrB7lqMEyZM82tn//tRZLh4VRky5O3akJfAA4eDW30ZVZEwRKmp2MUmkY0ToDvCLtDMViTH2C/eCdW1Z46wYHLP0nDBqN+6uw7uCDs0Uv8Y2mr0Q0W/IMy+Z+JGzGR2Nyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732091003; c=relaxed/simple;
	bh=+uMZF+iLR9ILpXin/S9N3TH/+cH9HM7Qq5uvQYl+uAg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SlN9F9UBEMDKpYKWfXp5wnSh3AaxvI+Of3XP/9p/0HHxgj7sgim3F7pL20avd+W3Htm8ZyiAQxpiH/RNF1p/FLgDLS3fX58c2gcHkOZUMFjKmSmjJzJQbyYNYmZpL7MZrMIB54l5atj2UdR/5PwgGyZJgXvZKwPoIUytzwHm1Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=slOCr+Hf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CF63C4CECD;
	Wed, 20 Nov 2024 08:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732091003;
	bh=+uMZF+iLR9ILpXin/S9N3TH/+cH9HM7Qq5uvQYl+uAg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=slOCr+Hft+RJNYFbChRaAnC9olxaoJ+iOIEDhVSI6cRqWNfpGBSM/xtbLye9neNak
	 QQk2TD+ULw0QE6pw+QWm8NF1rAs/9n/gCnkr8jzcW5S2SE8kHOdJcQi3SC5/mdQTnn
	 qdZNeAC/kDAhbXjVZjiDMcp8dtuRuIrCqLg46uKvpxiNnn1S43fMOPuIhECe52DpPl
	 8vHAieePfBKExXoD5r8XfY23Y+oDXpH3IgNB0gcYVJ4hoNWZps9/VQ02cEzE9/6iWF
	 4JNFrqH0gKobDlUJjWhZdMTb6/jVzi6/AQBq5xNj9m1whXbzVsfJX6up53lHJIhLBv
	 fLbtFRwtaQ93Q==
From: Christian Brauner <brauner@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Ian Kent <raven@themaw.net>,
	David Howells <dhowells@redhat.com>,
	Amir Goldstein <amir73il@gmail.com>,
	Paul Moore <paul@paul-moore.com>,
	Karel Zak <kzak@redhat.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>
Subject: Re: [PATCH v2 0/2] fs: listmount()/statmount() fix and sample program
Date: Wed, 20 Nov 2024 09:23:04 +0100
Message-ID: <20241120-ortet-abkaufen-3ec75715e476@brauner>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241115-statmount-v2-0-cd29aeff9cbb@kernel.org>
References: <20241115-statmount-v2-0-cd29aeff9cbb@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1378; i=brauner@kernel.org; h=from:subject:message-id; bh=+uMZF+iLR9ILpXin/S9N3TH/+cH9HM7Qq5uvQYl+uAg=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTbzikSmzYnVNegbrE/Z83vxuYv+/KadKtXH2zfJi89J Vn6j2lnRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwESWHWdkeBm8Rm3HTr2oy3pV zC5tVsKPAhaEK09ablLlf3GGs7N3DiPDgdme2gZxn5s/vtedZL4qxVL05ezVK2eK5DNnT9FWPfK LGQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Fri, 15 Nov 2024 10:35:51 -0500, Jeff Layton wrote:
> We had some recent queries internally asking how to use the new
> statmount() and listmount() interfaces. I was doing some other work in
> this area, so I whipped up this tool.
> 
> My hope is that this will represent something of a "rosetta stone" for
> how to translate between mountinfo and statmount(), and an example for
> other people looking to use the new interfaces.
> 
> [...]

Applied to the vfs-6.14.misc branch of the vfs/vfs.git tree.
Patches in the vfs-6.14.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.14.misc

[1/2] samples: add a mountinfo program to demonstrate statmount()/listmount()
      https://git.kernel.org/vfs/vfs/c/ec07dced06b6
[2/2] fs: prepend statmount.mnt_opts string with security_sb_mnt_opts()
      https://git.kernel.org/vfs/vfs/c/d2269a2bfe4a

