Return-Path: <linux-fsdevel+bounces-40403-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EAE8A23181
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2025 17:08:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F2DF3A705B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2025 16:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 299641EBFF7;
	Thu, 30 Jan 2025 16:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uz5VSJvT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C011EB9FA;
	Thu, 30 Jan 2025 16:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738253276; cv=none; b=ZlEbAhW4hv8scFu/YOskk1dmSn2GqxDe9hIy9vd+R9GvS+ft8PIIlM0o1cfJNhZdSxXw7Vll6OWSWiLtPk6uhL2zx8d0L4GA+EeWfd+jkXKbk4wVklUr88/QzBMYBluSmZB2SHHfrt7Nd3VPDkU1pz8xIp/5lmb2rnV2chvvelQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738253276; c=relaxed/simple;
	bh=iyf9rrIaJTr6PgY3x9SidMmy2ZlE/B1b6A1DN19QU1Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jRwp/Om3ccrBzwL0aBocdOwF6I7cHA0cYF6/q26Fq4ahZ9E+fN3zVFcHD/9PKs90OZI/9DQ8ZxAsfkClrPof4QH0WuuvgyqKrGG1Y7WQSRsegkfO0SlBK59WmiNFxCGk9bAGW/DrW/KjlJLOuWLr0cTzaD9gc/vhJGpbSo5tl3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uz5VSJvT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CA99C4CED2;
	Thu, 30 Jan 2025 16:07:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738253273;
	bh=iyf9rrIaJTr6PgY3x9SidMmy2ZlE/B1b6A1DN19QU1Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uz5VSJvTda2caWKZe1upMY6/31seNJBnPKXqOSb/PocUB5RpYocw4xYjC8zS6BB4N
	 WSc4a8khlN1c/LVgCNo8Lwp3ZxSJb4fkCRSYrBJDdzKGn9tpWPgGbIBu9RWnB8mwhd
	 NlxZmjYFLSIZ4xbFUwAXhrQ/hhsFSmYutoVRdnMA3G1yxTQ66xrsf0yewIX4c1tEkJ
	 JX2J47syH2T6yeu0WnI5rQP8GTooLFqA7F+XVpodv1Bqi+IfOnJhVG1k5X3rHQriib
	 k4Jnv6HiptEm3PyTd3IJdznR/rG5EhirQG/sIJR7qhaY0FKhY+wy+hOEyNCmeoC9ul
	 Sl+JIIKC8sgpw==
From: Christian Brauner <brauner@kernel.org>
To: linux-fsdevel@vger.kernel.org,
	Miklos Szeredi <mszeredi@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Amir Goldstein <amir73il@gmail.com>,
	Karel Zak <kzak@redhat.com>,
	Lennart Poettering <lennart@poettering.net>,
	Ian Kent <raven@themaw.net>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Paul Moore <paul@paul-moore.com>,
	selinux@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	selinux-refpolicy@vger.kernel.org
Subject: Re: [PATCH v5 0/3] mount notification
Date: Thu, 30 Jan 2025 17:07:41 +0100
Message-ID: <20250130-heulen-erdarbeiten-8f0c40609021@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250129165803.72138-1-mszeredi@redhat.com>
References: <20250129165803.72138-1-mszeredi@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1320; i=brauner@kernel.org; h=from:subject:message-id; bh=iyf9rrIaJTr6PgY3x9SidMmy2ZlE/B1b6A1DN19QU1Q=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTPXnzhQOtFpqz4hfei3132bPOfuofDMYRlivva1vsP0 po3b2Fd2VHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCR7g2MDGesV/G3H1icHREf /9TkAGN9srLuf+Wda3/21uc+mp2ySpXhJ6MDr3G5783uGCWFTTeXRBuf/vt21ybRS/etrx0KPOT hzgIA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Wed, 29 Jan 2025 17:57:58 +0100, Miklos Szeredi wrote:
> This should be ready for adding to the v6.15 queue.  I don't see the
> SELinux discussion converging, so I took the simpler version out of the two
> that were suggested.
> 
> Will work on adding selftests.
> 
> Thanks to everyone for the reviews!
> 
> [...]

Applied to the vfs-6.15.mount branch of the vfs/vfs.git tree.
Patches in the vfs-6.15.mount branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.15.mount

[1/3] fsnotify: add mount notification infrastructure
      https://git.kernel.org/vfs/vfs/c/3b02618006ea
[2/3] fanotify: notify on mount attach and detach
      https://git.kernel.org/vfs/vfs/c/681803d6e3e1
[3/3] vfs: add notifications for mount attach and detach
      https://git.kernel.org/vfs/vfs/c/48d9da32719f

