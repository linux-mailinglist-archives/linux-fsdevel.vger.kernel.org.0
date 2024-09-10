Return-Path: <linux-fsdevel+bounces-29004-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11DA4972D64
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Sep 2024 11:22:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4472B1C24580
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Sep 2024 09:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C34A188A10;
	Tue, 10 Sep 2024 09:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HQfZ+7fC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF9313AD09;
	Tue, 10 Sep 2024 09:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725960147; cv=none; b=O/smHgUPwcY7uWhsKCcZ4RvsuDzrTLLm79Dp5sPzb+cMv4RdGtuorQRbdXx08dhUuNckziXcdR6Rfr+mEqdIUX4sLHOM77F/wqwhFs6D9rqEwapNcyoR7AoNrfOGApWbTXadZoYZ0gx0TSU7I7ccCNtIYQ/7+NSla5VjTDzWSh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725960147; c=relaxed/simple;
	bh=WjeYyW6noFtC/bFpHRDIx1hKKO/gppZdKQhU2y+wnoU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nxB4U0vZeRo4tg3C+et3KN/P3GXwXnLjrCfBv8EeyG3WRmA7mPD8gdJTVcgp9kgib+MR1LjyqucMBkAVf5slWiDKf6IAvZ9phNQds0QB+KuBwGTLatVv9RmlWzDX+XcqU9Ye5a28ocFx+XOhOk4R6eGt4GvrQlG4HPUmxuSbBj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HQfZ+7fC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E1CCC4CEC3;
	Tue, 10 Sep 2024 09:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725960146;
	bh=WjeYyW6noFtC/bFpHRDIx1hKKO/gppZdKQhU2y+wnoU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HQfZ+7fCxMtxZQKEkTADlIJYWNfpdEtdQTwzr58Y6npglr7O0Hi7/e4J+T12X6o2t
	 n7HLzG6bFS2PsEF4TQDecMvoXgZ4JLIFsy7e/l+9qEDcn3hHN/MjcW7M2tjtqQaLd2
	 jeBcGXIv7IQ+1VoQsCBIt9DtWz41PWyN1Ydmcl6BNCGuS55V24RL04gJgRC7/23HpU
	 v1+qGDAslYV3kDmx+c+hGpTBAxHgPXQzn93D9IkiOvDl/OalQDqUg+tj7KjOnYWd7h
	 FlXogca5B3Ut+bkiDGXYpBRLYs8jT7/U0CTaei1Wr+0hedPOMMmNZCgFZLeC8I4L/8
	 YiWJEI99PvfWw==
From: Christian Brauner <brauner@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Chandan Babu R <chandan.babu@oracle.com>,
	"Darrick J. Wong" <djwong@kernel.org>
Subject: Re: (subset) fix stale delalloc punching for COW I/O v2
Date: Tue, 10 Sep 2024 11:22:20 +0200
Message-ID: <20240910-parallel-abtropfen-b166de2c9058@brauner>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240910043949.3481298-1-hch@lst.de>
References: <20240910043949.3481298-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1902; i=brauner@kernel.org; h=from:subject:message-id; bh=WjeYyW6noFtC/bFpHRDIx1hKKO/gppZdKQhU2y+wnoU=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQ94D+r+q1f583ZLJ3la1VdWJLin+WvKGaazZYm3zdDQ W2tmZhLRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwEQuLGP4ny/LzCfLcf1aHK9D e+bewruGy162MW+c/vO+afSq4tzmHIb/9X16n2q5OHv/Seg9u6Nz7Xler/oLnbxtPYqJotcVGv3 4AA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Tue, 10 Sep 2024 07:39:02 +0300, Christoph Hellwig wrote:
> this is another fallout from the zoned XFS work, which stresses the XFS
> COW I/O path very heavily.  It affects normal I/O to reflinked files as
> well, but is very hard to hit there.
> 
> The main problem here is that we only punch out delalloc reservations
> from the data fork, but COW I/O places delalloc extents into the COW
> fork, which means that it won't get punched out forshort writes.
> 
> [...]

Christoph, could you double-check that things look good to you? I had to
resolve a minor merge conflict.

---

Applied to the vfs.blocksize branch of the vfs/vfs.git tree.
Patches in the vfs.blocksize branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.blocksize

[01/12] iomap: handle a post-direct I/O invalidate race in iomap_write_delalloc_release
        https://git.kernel.org/vfs/vfs/c/7a9d43eace88
[02/12] iomap: improve shared block detection in iomap_unshare_iter
        https://git.kernel.org/vfs/vfs/c/b53fdb215d13
[03/12] iomap: pass flags to iomap_file_buffered_write_punch_delalloc
        https://git.kernel.org/vfs/vfs/c/11596dc3dfae
[04/12] iomap: pass the iomap to the punch callback
        https://git.kernel.org/vfs/vfs/c/492f53758fad
[05/12] iomap: remove the iomap_file_buffered_write_punch_delalloc return value
        https://git.kernel.org/vfs/vfs/c/4bceb9ba05ac

