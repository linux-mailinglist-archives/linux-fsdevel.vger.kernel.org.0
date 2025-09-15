Return-Path: <linux-fsdevel+bounces-61326-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 850C5B5798E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 13:58:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 137ED18952A4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 11:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E09D302CD8;
	Mon, 15 Sep 2025 11:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K7pAw7IB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720132EA482;
	Mon, 15 Sep 2025 11:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757937504; cv=none; b=YPKN8DxoMp9GxCqXEADR1NCvVabgczRu2uIvFeTiq71pgSAR6gTpr80nxd5WfMku6NXGnnw1/OvEms2GpY0GcT80q2hMczKr8QEVo1hN7y/56XFj+DNn697HzPSYKehkZXHzkNfJoPCaXOnjnMFHt8UVKdmoLedHw/jYP9tHcHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757937504; c=relaxed/simple;
	bh=FgrdD+GLilk1kPbvVdmSLzkJH2OwKn6IzMprtccNcms=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VXpeR5RLgU8YgAK3QrELtvbQeS4qY3f0qY+sRyVGETOAHT4tOANFTbG5h71VeLWBYQ+MApeJwYx0fEKDfdqoibZqDRYltr9pnSzMElVbcjHF0FKN8w4DKN6jDDZnwvNUXMB2xHk8nFLKZMzaYnPmnTJnGKtFES1rUF5qAFe2dME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K7pAw7IB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B4C7C4CEFD;
	Mon, 15 Sep 2025 11:58:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757937504;
	bh=FgrdD+GLilk1kPbvVdmSLzkJH2OwKn6IzMprtccNcms=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K7pAw7IBPK4AsrVYGRHgGXXCY0wluvgK7D1a0x7ZtnrfzducLLCeT08GSwzG9m8BK
	 NtA2r49Ejr8+UlS3hV+dVWbxTAMxboQ0lYQtTzoVof8ws2baySAvfzxmY8VhThDa71
	 nU/VyMLNPmUvQUwqL3x+uLHKIHLu4f2E8R7Mv9la2f1NSdbecmHWNPs87c3iAAbiTt
	 7V0ssIm0DUsEkHb4SOKQ0hOXB8zyE+5kt4596ckT9FwTtIKYpZM2yTfh8l+V1rM1dB
	 B42qWkqSL+MwU3OxkLCMSjKsELNyk699JlBPEUF/ljnN+TTlAszUsuzs5Blsh8/KSK
	 9W3FR9vnVZn8Q==
From: Christian Brauner <brauner@kernel.org>
To: syzbot+b73c7d94a151e2ee1e9b@syzkaller.appspotmail.com,
	Lizhi Xu <lizhi.xu@windriver.com>
Cc: Christian Brauner <brauner@kernel.org>,
	dhowells@redhat.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netfs@lists.linux.dev,
	pc@manguebit.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] netfs: Prevent duplicate unlocking
Date: Mon, 15 Sep 2025 13:58:16 +0200
Message-ID: <20250915-mehrsprachig-koproduktion-bd81338157c0@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250905015925.2269482-1-lizhi.xu@windriver.com>
References: <68b9d0eb.050a0220.192772.000c.GAE@google.com> <20250905015925.2269482-1-lizhi.xu@windriver.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=926; i=brauner@kernel.org; h=from:subject:message-id; bh=FgrdD+GLilk1kPbvVdmSLzkJH2OwKn6IzMprtccNcms=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQc/x95Jmz2V9873xtebTvLeDd6hYvm/WDhvW/1g/cuj Xkwt9LobkcpC4MYF4OsmCKLQ7tJuNxynorNRpkaMHNYmUCGMHBxCsBEHIUY/tmtfX2yO22e+qf7 nwyWPy4X2ume9G+djaaOzMRoCYVncj4M/4sTREW3plyYffilb9dtts4nOU9qDz18s3eV6IOry84 dXMgHAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Fri, 05 Sep 2025 09:59:25 +0800, Lizhi Xu wrote:
> The filio lock has been released here, so there is no need to jump to
> error_folio_unlock to release it again.
> 
> 

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

[1/1] netfs: Prevent duplicate unlocking
      https://git.kernel.org/vfs/vfs/c/66d938e89e94

