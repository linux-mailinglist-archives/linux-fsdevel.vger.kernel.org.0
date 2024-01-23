Return-Path: <linux-fsdevel+bounces-8606-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2626D8393DE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 16:56:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D16CA28698A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 15:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E93A2612DC;
	Tue, 23 Jan 2024 15:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sK2s7w+E"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F9760DD3;
	Tue, 23 Jan 2024 15:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706025342; cv=none; b=NL1vBYHN/jrh0SycgAyeRHrnUCV7bGTpQIXTagvxJDl/rpcTiOjdPd2H1eZ5/Rk0O7Ln9dDnqwuJxbkBaZo5O2L1WP/jU1qrnGmkOxj5Y+NHnhkXJNbDGWTfO6g7eeGBq/tEPamJHadztQsKMRdttvo9AmnXxt8uljGJrcODugA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706025342; c=relaxed/simple;
	bh=NFLNtcapmW/YVQ3O4S5u5bbAiQc4MNdaz8if2KZaVwM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LgYNyc7MIk/au7IxqT0iJFJJQgZvEdOsrKVIN4iLIpWFWzYBEC8kN7LWSYcIV3aPpijmaE//k+Hux5KbUNKA9SE+sViZQB1uuRqlvNvxxRg4a0999S1+HWXufMEFHGdikKJD5Arf7QCS+pgQbPMGqDruQKmyi4C4nAzM4kvpy88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sK2s7w+E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5A7DC433F1;
	Tue, 23 Jan 2024 15:55:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706025341;
	bh=NFLNtcapmW/YVQ3O4S5u5bbAiQc4MNdaz8if2KZaVwM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sK2s7w+EVEFCJsL3VumftRDWeQGdrwQUfSDayXZdGOCCTlSCOS4md24HO6CeU/0xa
	 kQWVD2LLuxkgm7wL68DMt5zyxeeC8qsn9Uv0P7jTztJqSQtGI1g0jyquSWkvW987hR
	 jQE8negp8TP6ywxmMdwppo78rMpOQ2CF+Q2maIn6odhrQK+5klr4ICevPGYI+I0elB
	 YjvGnk5CxvcMwejATzDn5aG+ii6BlwfhWw5AqnKjPArzBBs561dSLfzW/cjy8ida+S
	 YOzSgX405HbIagbXVoislBDtM7xW0zfU2NPh4w2B1Lgm9IPuiw7dZm1PShRCYOKr4k
	 H+NrlTwdT6ryA==
From: Christian Brauner <brauner@kernel.org>
To: wenyang.linux@foxmail.com
Cc: Christian Brauner <brauner@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Dylan Yudaken <dylany@fb.com>,
	David Woodhouse <dwmw@amazon.co.uk>,
	Matthew Wilcox <willy@infradead.org>,
	Eric Biggers <ebiggers@google.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>,
	Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v3] eventfd: move 'eventfd-count' printing out of spinlock
Date: Tue, 23 Jan 2024 16:55:15 +0100
Message-ID: <20240123-rinnsal-entbunden-bfdb1dedb29d@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <tencent_B0B3D2BD9861FD009E03AB18A81783322709@qq.com>
References: <tencent_B0B3D2BD9861FD009E03AB18A81783322709@qq.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1129; i=brauner@kernel.org; h=from:subject:message-id; bh=NFLNtcapmW/YVQ3O4S5u5bbAiQc4MNdaz8if2KZaVwM=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSuf1i6WPLBb9k7u5ZdzFuqVeK14sjVTzN3BO26ePXcw 9T+O/v/GHWUsjCIcTHIiimyOLSbhMst56nYbJSpATOHlQlkCAMXpwBMJKyekWGHD1eP+IF++bPe D73upeusfbVjTbPNVWfZxb9e7278epGXkeF4xuMLFz3vfLqwXXnZd+8cpsPJsTO+/9x0LdRdbxL rDEEWAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Mon, 15 Jan 2024 23:27:00 +0800, wenyang.linux@foxmail.com wrote:
> When printing eventfd->count, interrupts will be disabled and a spinlock
> will be obtained, competing with eventfd_write(). By moving the
> "eventfd-count" print out of the spinlock and merging multiple
> seq_printf() into one, it could improve a bit, just like timerfd_show().
> 
> 

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

[1/1] eventfd: move 'eventfd-count' printing out of spinlock
      https://git.kernel.org/vfs/vfs/c/294a229020f1

