Return-Path: <linux-fsdevel+bounces-12114-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3313A85B611
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Feb 2024 09:55:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF6EBB25B2D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Feb 2024 08:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DC4E604DD;
	Tue, 20 Feb 2024 08:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qw5uSkdd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF6360248;
	Tue, 20 Feb 2024 08:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708419158; cv=none; b=eZd8P7iTSRhTzKb9YHl83FMgx/5vkShWybPRBJyr98XHYm5tP51eiPHHFYO1l/DJqMYP43tH1mUalNAKmU4PcQUAiT9mWrchZct9f5o1AH4PVn/tyiUQqo7UvJu7FqBLJ6D8it/TcIK6cNmGxTpek6N6PaWJDKDCBdqZAb5SxRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708419158; c=relaxed/simple;
	bh=QLdKpqnQtaw4bNC6ST5UoKxOOL2ZodRO76dCPvxflkU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rfAfPnAiufodwpMV5pjm67tc049piq8Q6PWF/eFweFcY0ET5R/LE/nAGCsZ4LRVCXNPZlPF5Nhp/osX47EKOMGpXXVZ989ATLUHy+uG6e5TjGtslwjN12r9skcMDR2DNu+2jHgXEqiAYgu+2erjumqLnwSXyhKDohKj/ABE9tCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qw5uSkdd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3982CC433F1;
	Tue, 20 Feb 2024 08:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708419158;
	bh=QLdKpqnQtaw4bNC6ST5UoKxOOL2ZodRO76dCPvxflkU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qw5uSkddgFp7ii7BtDxjrnnCjlyvoMR1vfTxD/hsRnIseDduzv1HdQ3uprAlGCMos
	 BMkRahvb5jv4gvOV36YCXTiTfX4PhTVXE1dq97ChOHpz82Inc9y7AYBZSU6aY4wp04
	 IXHq9Z1Wt+63ijonOPYoVJywduuvbpplQLHHYFV8WpvAm9Ul8UXcfq2JN59z8lh8xu
	 b8Saw32dvles3IfxyaZdd6pCUwGBJ0zknWfKQ0xo+qId598ReU5RXScy9zyGNSOJob
	 a/eDCVBj7x6JVwmpwPY9ABD/G47G7NoiRtfiCpHzB+KkvNzadSp1KpavqCixPCLWsv
	 /4ZHG9jKI2byA==
From: Christian Brauner <brauner@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Markus Suvanto <markus.suvanto@gmail.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Daniil Dulov <d.dulov@aladdin.ru>,
	linux-afs@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] afs: Miscellaneous fixes
Date: Tue, 20 Feb 2024 09:51:55 +0100
Message-ID: <20240220-mietfrei-kopfnicken-bec5325cc06e@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240219143906.138346-1-dhowells@redhat.com>
References: <20240219143906.138346-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1360; i=brauner@kernel.org; h=from:subject:message-id; bh=QLdKpqnQtaw4bNC6ST5UoKxOOL2ZodRO76dCPvxflkU=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaReyQjo0Gnh7t3BvklFY3681RJ1t/Nq4oHzG/zV9rGp7 F5eVPCuo5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCLuPYwM21098kzE7TwDO2YU /1/CpOCacGYGC0emY/Sk7xUsaRdSGRkO+PNMr3P6eoU3a+XJj/u9/n2bmSMUKm1YWhXjuvz6fDY uAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Mon, 19 Feb 2024 14:39:01 +0000, David Howells wrote:
> Here are some fixes for afs, if you could take them?
> 
>  (1) Fix searching for the AFS fileserver record for an incoming callback
>      in a mixed IPv4/IPv6 environment.
> 
>  (2) Fix the size of a buffer in afs_update_volume_status() to avoid
>      overrunning it and use snprintf() as well.
> 
> [...]

vfs.fixes means that these things will go in this week. Let me know if
this is not what you intended! :)

---

Applied to the vfs.fixes branch of the vfs/vfs.git tree.
Patches in the vfs.fixes branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.fixes

[1/2] afs: Fix ignored callbacks over ipv4
      https://git.kernel.org/vfs/vfs/c/bfacaf71a148
[2/2] afs: Increase buffer size in afs_update_volume_status()
      https://git.kernel.org/vfs/vfs/c/6ea38e2aeb72

