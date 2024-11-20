Return-Path: <linux-fsdevel+bounces-35272-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 966E09D354F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2024 09:24:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28495B2183B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2024 08:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9CE416DC36;
	Wed, 20 Nov 2024 08:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CNR5ONfp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 120661B7F4;
	Wed, 20 Nov 2024 08:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732091079; cv=none; b=WkIQPmI6/zejBy2fdtjaS0/DIOney+qpl7JIw4xlp/CHKE65It3LVNKL7zAixAS7uxClJvzUSFIaTn8I8g/xI3X/FSQTGJJYY52hp+m6nukHoMEQm7Q98EN4AXhRvScjIeyUh+E4T3dG3T06uGx9JZeJoqO+3Qp0TH9ZIY59yUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732091079; c=relaxed/simple;
	bh=Rq9e0l8Mb8VnwWU3I5xtmko6/hmN2+LBvkRMLVX7rEU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CtD2EYwJWPkToaj5crmphUDTWd7+HXzsWws9fKq7dZfh0r4GGXTXexlFBpykIkJGRM8dzGToXbFmXRei2sKT/+Xc3VNaTBxb4CCMghIDEsU/l4L5SoQr/NQG5olkhDFXmG6k49UyNm68PUC+i9SAdLKXNZ/VBBoHFfB4bj3wpxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CNR5ONfp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FD66C4CECD;
	Wed, 20 Nov 2024 08:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732091078;
	bh=Rq9e0l8Mb8VnwWU3I5xtmko6/hmN2+LBvkRMLVX7rEU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CNR5ONfpYPhk1Mb2Jjm1gytuTnN5rsqgHdcr1vJj2xlOnIzvgD+wWOJrSLlMnyi7f
	 LqK4slLl040dXK+V/RdguYCH3LUalOHQPXVC0BeROeOjRy5o6ZFTAm0m1Yt9pGXFxl
	 1Hv2YsmhpYgNoPwi2BTnNJJpx9PNw2vge4podv37BcHThAS1t1f31doHmxKQu8Bu+5
	 IGT+c2muVRy9m5Ht3dsexFHvDEWdagXQeSEXNL+ZMbpXD1cIFsGbb4X+/UK1bT6dZO
	 qZbbEB9nJhzSLPk8agprZR7FQZ9MNHwjHlFMnY6alJdZiThBM+JT2cICUVMjkXPC07
	 WhYI7ea/dafWg==
From: Christian Brauner <brauner@kernel.org>
To: Brian Foster <bfoster@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-xfs@vger.kernel.org,
	hch@infradead.org,
	djwong@kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2] iomap: warn on zero range of a post-eof folio
Date: Wed, 20 Nov 2024 09:24:24 +0100
Message-ID: <20241120-rennleitung-barsch-6e02748e36f2@brauner>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241115145931.535207-1-bfoster@redhat.com>
References: <20241115145931.535207-1-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1390; i=brauner@kernel.org; h=from:subject:message-id; bh=Rq9e0l8Mb8VnwWU3I5xtmko6/hmN2+LBvkRMLVX7rEU=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTbzjkguUDglc0EG7mqSad2KRodKth03q4/eGpy1Yejx Q2OO4596ShlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZiIUjvDf6e+ORt8zcR4703x 92uNlN+qeOdR0WzOMxnTbxtznebmf8bIsNzneasB18Vp9s2FhnyGPI+ZBXlu2aof1Lnw626g0c9 MbgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Fri, 15 Nov 2024 09:59:31 -0500, Brian Foster wrote:
> iomap_zero_range() uses buffered writes for manual zeroing, no
> longer updates i_size for such writes, but is still explicitly
> called for post-eof ranges. The historical use case for this is
> zeroing post-eof speculative preallocation on extending writes from
> XFS. However, XFS also recently changed to convert all post-eof
> delalloc mappings to unwritten in the iomap_begin() handler, which
> means it now never expects manual zeroing of post-eof mappings. In
> other words, all post-eof mappings should be reported as holes or
> unwritten.
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

[1/1] iomap: warn on zero range of a post-eof folio
      https://git.kernel.org/vfs/vfs/c/2eba5b6013a5

