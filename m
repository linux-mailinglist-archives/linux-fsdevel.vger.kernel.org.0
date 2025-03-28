Return-Path: <linux-fsdevel+bounces-45193-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43D1BA74698
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Mar 2025 10:45:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BCB11B613DD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Mar 2025 09:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5479F21507F;
	Fri, 28 Mar 2025 09:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IpyCf1cZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52BA213E85;
	Fri, 28 Mar 2025 09:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743155119; cv=none; b=J733eFYZya3LjiMyA2EavCx6YaA5hGq4Fljn75a1uIgXMptdd+WO3jb+Z+7Ez2dE+Cyeu4m/v9K3t3vqIUiip80I/Bgq6X7+wNxR8xKzJJna6Obj5WQn/k1oEY0UPQ2bNM4usC3c2GFRZ3ou+zSZpvkfl0VRuWmpd/qQvInKKzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743155119; c=relaxed/simple;
	bh=DK0wTI8D+HjMd06/tmmJOKhjTUGmV2awrz+O+2kKua8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TqCIhzHDu+q1QP5ebEhjQb+s/hNzMd3CW0GO9oPYjeVILeeqP6sx5qoxDz3nz2WaTigy1FB2wDEWgZRtC8GL73DyTP2BckSNYzhti2kfDY3JeHCloAbRRC+1xy7WAdwz07DEwD+VlHWvME9NDLsoqQwGUHjyditNLu5Sbi9Mne8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IpyCf1cZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEB91C4CEE4;
	Fri, 28 Mar 2025 09:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743155119;
	bh=DK0wTI8D+HjMd06/tmmJOKhjTUGmV2awrz+O+2kKua8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IpyCf1cZ0fGnPYF0LWDEfFIB2lyXzRdVJn2Vi5ufPj4kala8n0qxxBY8bpvPhRxa9
	 SCQNCriU2X9b47wy9XIlZDiHpSuAR0Xf/A9mnyJQyeCN1RK0tnzyYPXmUWWmpRtv5U
	 pwXpKNKE9NKWs9uKd2Gs+7UNcXdkEfvkXdJukft+dsOPYQ/9VRMHWdpRofMT6qMLZu
	 IuUEvIipcCmTghOM8i7ZbDruIZJXihOSsG5PUIwsunfBUAst/qUWrwwlwi6I9UtEzl
	 k/hTfGejsoCqLDWxRkuDkEm3KcdZrgcTQM0Y0kCOCiMSUVLDvpYIIKNyLXHSUvk0P/
	 66Sw2lDDEuXMw==
From: Christian Brauner <brauner@kernel.org>
To: linux-xfs@vger.kernel.org,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	John Garry <john.g.garry@oracle.com>,
	djwong@kernel.org,
	dchinner@redhat.com,
	linux-kernel@vger.kernel.org,
	ojaswin@linux.ibm.com,
	linux-ext4@vger.kernel.org
Subject: Re: [PATCH] iomap: Fix conflicting values of iomap flags
Date: Fri, 28 Mar 2025 10:45:13 +0100
Message-ID: <20250328-antlitz-abruf-386fa2b7fc23@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250327170119.61045-1-ritesh.list@gmail.com>
References: <20250327170119.61045-1-ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1241; i=brauner@kernel.org; h=from:subject:message-id; bh=DK0wTI8D+HjMd06/tmmJOKhjTUGmV2awrz+O+2kKua8=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQ/y1/1vEZbefurwr0La1+4BaboMjJ5WH3W4Tle+44h9 N65aWXvOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACbydz4jw0QGi+R37DWfGDTf P1LP2ZzBufjzrMPO6e/Y37YWVFfbRDH8d1HOjf7kcnIdx8Hv08r9/HfMuzHPOuTk9kM+fVGuf1W 0eAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Fri, 28 Mar 2025 01:01:19 +0800, Ritesh Harjani (IBM) wrote:
> IOMAP_F_ATOMIC_BIO mistakenly took the same value as of IOMAP_F_SIZE_CHANGED
> in patch '370a6de7651b ("iomap: rework IOMAP atomic flags")'.
> Let's fix this and let's also create some more space for filesystem reported
> flags to avoid this in future. This patch makes the core iomap flags to start
> from bit 15, moving downwards. Note that "flags" member within struct iomap
> is of type u16.
> 
> [...]

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

[1/1] iomap: Fix conflicting values of iomap flags
      https://git.kernel.org/vfs/vfs/c/923936efeb74

