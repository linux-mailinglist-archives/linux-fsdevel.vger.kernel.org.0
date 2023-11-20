Return-Path: <linux-fsdevel+bounces-3208-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC82E7F15D4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Nov 2023 15:37:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B80BB1C21816
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Nov 2023 14:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB9CB1D526;
	Mon, 20 Nov 2023 14:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Itx5yq5l"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1680C1D525
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Nov 2023 14:37:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EC54C433C9;
	Mon, 20 Nov 2023 14:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700491050;
	bh=DLE1c+o1kmmWKQU5FsHxdwyQev10aAv8a+4Bsb27Pn8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Itx5yq5l6xnqscNORqVb5VmwZhXLupoQFckVYMxzef9qAm8tfCAHsX660QBqi66oI
	 ZR1IhfrD7+0KX8AjzjDcFYMbcBE7YbqJEOmoPdZka24/mKfkOd05TGpCSj6oL7vn2b
	 cWJX/pXVdrD4JB3d/f74eoXdBYkoNWv6hJwuPNvwkN0jJM4kamJ3it/FD1ir06jJ7r
	 awGYEb2grK9P4j4ziVsxXqd3RbYn3nrbu5qWOIIVtV0cxvN3Xs3mkqEwN1T2W4S1TH
	 i1Eb+6Md590FynuzxhRQmZDiI8AKtrvlfaEbUQZAT8ladOkALDKE/YOlyh1ov4lOHs
	 imfgJpGfMF3bA==
From: Christian Brauner <brauner@kernel.org>
To: Chuck Lever <cel@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Tavian Barnes <tavianator@tavianator.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	akpm@linux-foundation.org,
	hughd@google.com,
	viro@zeniv.linux.org.uk,
	Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH v4] libfs: getdents() should return 0 after reaching EOD
Date: Mon, 20 Nov 2023 15:37:14 +0100
Message-ID: <20231120-lageplan-grinsen-25b44b4fac10@brauner>
X-Mailer: git-send-email 2.42.0
In-Reply-To:  <170043792492.4628.15646203084646716134.stgit@bazille.1015granger.net>
References:  <170043792492.4628.15646203084646716134.stgit@bazille.1015granger.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1347; i=brauner@kernel.org; h=from:subject:message-id; bh=DLE1c+o1kmmWKQU5FsHxdwyQev10aAv8a+4Bsb27Pn8=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRG50sW8Bcu4VibquLoq7V+jsex9S4hqW+11q5eU7a58 EPZsbbmjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIlsOs/I8Gy3TlZd4s3cRymX K/c43BCLX8/ouvLTXm+LWfXbeafz/2P4KyWxwPr28oitm9eaBLll3KnaJBh46ZR52oIlCvN9ZT7 WcwIA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Sun, 19 Nov 2023 18:56:17 -0500, Chuck Lever wrote:
> The new directory offset helpers don't conform with the convention
> of getdents() returning no more entries once a directory file
> descriptor has reached the current end-of-directory.
> 
> To address this, copy the logic from dcache_readdir() to mark the
> open directory file descriptor once EOD has been reached. Seeking
> resets the mark.
> 
> [...]

Should fix the regression report I also received earlier today. Thanks for the
reviews with LPC and MS I couldn't really do any meaningful review.

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

[1/1] libfs: getdents() should return 0 after reaching EOD
      https://git.kernel.org/vfs/vfs/c/796432efab1e

