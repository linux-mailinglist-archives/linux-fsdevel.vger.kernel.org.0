Return-Path: <linux-fsdevel+bounces-41395-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D6F3A2ECE9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 13:53:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF6783A7C66
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 12:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C71A5225384;
	Mon, 10 Feb 2025 12:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ar9YbKxs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FCDF22489B;
	Mon, 10 Feb 2025 12:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739191976; cv=none; b=K5C0qrdrr2LbbFlZqB1RQDw/drlxpN6HovlS0Z9Rv4CxMt2r60LQZE0y+25HfHROAYnHX3rjFHWxBN1jfdhz2Z0JrQ7zEo7z+BJmQTXtUGkCCYMkPNiTHeUDeDAqjq4D55ExfGH34meSAAdIjx4NblJp2bV0fHWUjSjTm/aK44w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739191976; c=relaxed/simple;
	bh=ZC5nhsoii6SlSeT3VZ6+rinFj3qNAQbm4oYFU9a2f4Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zo9QBbgJ2xOVfEgTM1QNz8YUDrhMscvWyfWbp7dQVobovzZEmaWBL3vL1FEKv+ibw967BZt2Se38Fad6OMP4qhnyZTQJxc15vo+jbKgguUau2pDMuAuYSbjn5inbNZnbyHZ9iVVxwRBd2V4heXpAdXdtZ4URAH04++9IOVdpMis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ar9YbKxs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4175DC4CED1;
	Mon, 10 Feb 2025 12:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739191972;
	bh=ZC5nhsoii6SlSeT3VZ6+rinFj3qNAQbm4oYFU9a2f4Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ar9YbKxsGraERWgFZlpbkKf8oF1fedHVI1IursPBtH8wnBlV/qViMPJlFym70723A
	 7EMC7OF28+SQhMsOKNkZMnS6fHVw2BN9ZhdmVmiCNV6ibf/Lf4ZQGF0t1hJ+00u/K4
	 k8bG2DNyt+6EwkaAuUHDkFnN9ys5iNSjXtznl8akYq2g0ZlaKgQ5aC18qdlQhE7UnL
	 qHmsIHNZoTe2KSHx8EZsfyWQFALZplkqhRIYcvp9lsgRDr6zgAr21qanfiz+4Qjwdq
	 A+lbt7Qhi66bzr+CtwSu3WMtJ2TgIwFQxehi/4l6VefnP0kL8UWkFeabOWb3PNwmW1
	 YdwIfZkwnDk5g==
From: Christian Brauner <brauner@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>,
	David Howells <dhowells@redhat.com>,
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Mateusz Guzik <mjguzik@gmail.com>,
	Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>,
	Oliver Sang <oliver.sang@intel.com>,
	Swapnil Sapkal <swapnil.sapkal@amd.com>,
	WangYuli <wangyuli@uniontech.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jeff Layton <jlayton@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 0/2] pipe: change pipe_write() to never add a zero-sized buffer
Date: Mon, 10 Feb 2025 13:52:33 +0100
Message-ID: <20250210-podest-bankdaten-fe88240abf98@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250209150718.GA17013@redhat.com>
References: <20250209150718.GA17013@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1205; i=brauner@kernel.org; h=from:subject:message-id; bh=ZC5nhsoii6SlSeT3VZ6+rinFj3qNAQbm4oYFU9a2f4Q=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSv/DZX77uY7VKe2YcPHj103UDOTX+uzIYr3BGzuEx1I /+LTjHz7ShlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjIj0eMDN++7/ULT1aQMsj6 dvb4GpcVz2bfqki63RQlJ8U1hy9utgEjwzGe/wsmneLOZ8r+HHIqKWHRZXmTmWuiDmZMnVfkvX7 qPiYA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Sun, 09 Feb 2025 16:07:18 +0100, Oleg Nesterov wrote:
> Please review.
> 
> pipe_write() can insert the empty buffer and this looks very confusing
> to me. Because it looks obviously unnecessary and complicates the code.
> 
> In fact this logic doesn't even look strictly correct. For example,
> eat_empty_buffer() simply updates pipe->tail but (unlike pipe_read) it
> doesn't wake the writers.
> 
> [...]

Applied to the vfs-6.15.misc branch of the vfs/vfs.git tree.
Patches in the vfs-6.15.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.15.misc

[1/1] pipe: change pipe_write() to never add a zero-sized buffer
      https://git.kernel.org/vfs/vfs/c/af69e27b3c82

