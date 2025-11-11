Return-Path: <linux-fsdevel+bounces-67919-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 23B56C4D937
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 13:06:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 78F2134FD42
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 12:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35EFA3570AB;
	Tue, 11 Nov 2025 12:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BBkaD78x"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DDEA248F78;
	Tue, 11 Nov 2025 12:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762862756; cv=none; b=NvxG4qd+Ux+5jr/LSi4jCsXWDb9gTaKytBpwnV6PIC4C+bYyBEJMXmYQAl6nXWdgYiKaCZxu1OwUnVRHMHKTj1H4wQB9wilHH9qAOcPR+aH5JAW+gEtFmbr6tf5MJLLUIWmKTXzCRheCiDX16qMVZ7WvJQ54D70gqpZM2jrfT0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762862756; c=relaxed/simple;
	bh=VRGcAN2yTGan9iucsJQd7KhaDHf/oFMbWEQdpOAsvMM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Yvj916gIWEyNMP3CVKHluzE4R2ZcNY824zTGePt7uf2Yp9Qgq56LE/rorqqOdLBlfL9unhI+YU1paiGEmkvUgEARC+Rs5IFIYyA6QMwDQ2Nv6kQ0fK5/Vhn0E3UfEdbj2tsSZOY1kP4XNYYcO5HPE1ifOtOhY+YNDyH9/Wt+jVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BBkaD78x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89DDCC4CEFB;
	Tue, 11 Nov 2025 12:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762862756;
	bh=VRGcAN2yTGan9iucsJQd7KhaDHf/oFMbWEQdpOAsvMM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BBkaD78xZB2M2FqoTBASK5HU+V+uR/G8wS0lTNNTGtaskHHJgzou32mKxXgRetCOF
	 VsN/AyORBEug0eaBi1ov27cyevAnzJyyqtnR6JGPOLaVC76ugBSeG6ybg5RBnjrZ5r
	 UaDKBtuYNACP8hhvxXWejn9C+BnUfQr+FdCOZsPJj2zO5tx+Z3YQJ8vTJ35jbSLneo
	 vx5NcuUaUr0mLttM1AC/lXfU0y8ALB8/bKxUD9Gg7ZTCWNV6eonkrbL6oHREz0Dyta
	 51FKsW43zWntQu1mZC3onEZsCNyRYdmEawF9wWaNYR6jzYtry9XR8e9f1FdVw8jF0R
	 HzZkMsdJ17uIw==
From: Christian Brauner <brauner@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: hide dentry_cache behind runtime const machinery
Date: Tue, 11 Nov 2025 13:05:51 +0100
Message-ID: <20251111-lobpreisen-nebel-8c71952ada8b@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251105153622.758836-1-mjguzik@gmail.com>
References: <20251105153622.758836-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=843; i=brauner@kernel.org; h=from:subject:message-id; bh=VRGcAN2yTGan9iucsJQd7KhaDHf/oFMbWEQdpOAsvMM=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQKq83/84DNQEZnwuW8OKYpk399OSjpa9QmGeHFfrD9h ESydMSljlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgInotjEy7DCwO/w91Du3f+as bIugQtFkJo1NWmneC08qyGTJvtI5ysjQ2vp6yZzVGzzfL2FIfz7nD+OSQ07TeDZYVjws4GyN/z2 RDwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Wed, 05 Nov 2025 16:36:22 +0100, Mateusz Guzik wrote:
> 


Applied to the vfs-6.19.misc branch of the vfs/vfs.git tree.
Patches in the vfs-6.19.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.19.misc

[1/1] fs: hide dentry_cache behind runtime const machinery
      https://git.kernel.org/vfs/vfs/c/15e78f24ccf0

