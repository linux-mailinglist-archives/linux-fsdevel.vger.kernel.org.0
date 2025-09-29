Return-Path: <linux-fsdevel+bounces-63009-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB14ABA8B2B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Sep 2025 11:42:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50ACE3B0496
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Sep 2025 09:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4F0B2D6E5A;
	Mon, 29 Sep 2025 09:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IjdRWxta"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E086C2C3250;
	Mon, 29 Sep 2025 09:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759138745; cv=none; b=LYpf8COBsB5qmx6M4i7ZMaDyd+lVNHJ0OzFCyZWVzenL8ClbVvwMZh410ywuXRJIghYbBbtHg9buuuWweNh5fZ3MsYpw32mfoT9lEGv0uCjeN/0rrvurgRfHY6DnxpyvBoRKgF+yz0jO1EpMwYeBXi0J6ExmbNHYD4MBHU8V80o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759138745; c=relaxed/simple;
	bh=oug/PLMLLW7/ZVdQh5G7ABppQ7HlQRSRolzg1A9Qm7s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n1oqvBmLEKdqYyTW0ZJtfIII3lhRdsqRNN+uS4lI5fU2C8qRGIpqR8O6hr4//FJcI3ntVC4sDLPVgZr5tjhymQGetB5qbNlmIFUPyUPg4f4W41QQilCmOZ6NyVdXor5hC8obWcW2UnrbYf43k8TiCkCbAVjeTqyfqITGDZjcABA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IjdRWxta; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1F0EC4CEF4;
	Mon, 29 Sep 2025 09:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759138744;
	bh=oug/PLMLLW7/ZVdQh5G7ABppQ7HlQRSRolzg1A9Qm7s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IjdRWxtaUXAOawilIoA5EK1zaNWzq8SuG/RGnayTEvvTw8zkBFRbc95h1U8UXOXtI
	 o+ChdWCOB1cSxsYTmhEnF4EZvWega7fq9Q5hvzFnoW/4vjE2MrI4IG5yeRG/g18Kp8
	 gvohG7Zo7gpwrczplAyjI1Bsbj7IcC2iEs/HHL3fNdJRECFzrJnxHGS85figtNoTTA
	 G/sSMaqFdX1Ohy+mgONJzGFTPJ6Tj3xM+34a0qPEkFNl8UKzwfbwSK9qeMto4zgEj3
	 57f/S1bg5BHZsmE1HoHkUD56LCkL2l6h69d5wjUgsMUnyn3fypZtpxRVJ1itvbpKr3
	 HiGZLKyS/z25w==
From: Christian Brauner <brauner@kernel.org>
To: miklos@szeredi.hu,
	Joanne Koong <joannelkoong@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	djwong@kernel.org,
	hch@infradead.org,
	linux-block@vger.kernel.org,
	gfs2@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com,
	linux-xfs@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Gao Xiang <xiang@kernel.org>
Subject: Re: [PATCH v5 00/14] fuse: use iomap for buffered reads + readahead
Date: Mon, 29 Sep 2025 11:38:52 +0200
Message-ID: <20250929-salzbergwerk-ungnade-8a16d724415e@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250926002609.1302233-1-joannelkoong@gmail.com>
References: <20250926002609.1302233-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=3113; i=brauner@kernel.org; h=from:subject:message-id; bh=oug/PLMLLW7/ZVdQh5G7ABppQ7HlQRSRolzg1A9Qm7s=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTcCt4U9G+2seCNkLbaHYktsafTZ5w7c6Oz0+SjoPRM9 4sH77rs7ShlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZhIpjLDb/ZKb+HfvbbTPqW+ 7T4i9pm515tNlnXnxUVa0/f1bd5RNZvhn/WbmlifgLUasz7qfTzIrLqL8UR9ReulTOaO2bv3S8m +ZAcA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Thu, 25 Sep 2025 17:25:55 -0700, Joanne Koong wrote:
> This series adds fuse iomap support for buffered reads and readahead.
> This is needed so that granular uptodate tracking can be used in fuse when
> large folios are enabled so that only the non-uptodate portions of the folio
> need to be read in instead of having to read in the entire folio. It also is
> needed in order to turn on large folios for servers that use the writeback
> cache since otherwise there is a race condition that may lead to data
> corruption if there is a partial write, then a read and the read happens
> before the write has undergone writeback, since otherwise the folio will not
> be marked uptodate from the partial write so the read will read in the entire
> folio from disk, which will overwrite the partial write.
> 
> [...]

Applied to the vfs-6.19.iomap branch of the vfs/vfs.git tree.
Patches in the vfs-6.19.iomap branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.19.iomap

[01/14] iomap: move bio read logic into helper function
        https://git.kernel.org/vfs/vfs/c/4b1f54633425
[02/14] iomap: move read/readahead bio submission logic into helper function
        https://git.kernel.org/vfs/vfs/c/22159441469a
[03/14] iomap: store read/readahead bio generically
        https://git.kernel.org/vfs/vfs/c/7c732b99c04f
[04/14] iomap: iterate over folio mapping in iomap_readpage_iter()
        https://git.kernel.org/vfs/vfs/c/3b404627d3e2
[05/14] iomap: rename iomap_readpage_iter() to iomap_read_folio_iter()
        https://git.kernel.org/vfs/vfs/c/bf8b9f4ce6a9
[06/14] iomap: rename iomap_readpage_ctx struct to iomap_read_folio_ctx
        https://git.kernel.org/vfs/vfs/c/abea60c60330
[07/14] iomap: track pending read bytes more optimally
        https://git.kernel.org/vfs/vfs/c/13cc90f6c38e
[08/14] iomap: set accurate iter->pos when reading folio ranges
        https://git.kernel.org/vfs/vfs/c/63adb033604e
[09/14] iomap: add caller-provided callbacks for read and readahead
        https://git.kernel.org/vfs/vfs/c/56b6f5d3792b
[10/14] iomap: move buffered io bio logic into new file
        https://git.kernel.org/vfs/vfs/c/80cd9857c47f
[11/14] iomap: make iomap_read_folio() a void return
        https://git.kernel.org/vfs/vfs/c/434651f1a9b7
[12/14] fuse: use iomap for read_folio
        https://git.kernel.org/vfs/vfs/c/12cae30dc565
[13/14] fuse: use iomap for readahead
        https://git.kernel.org/vfs/vfs/c/0853f58ed0b4
[14/14] fuse: remove fc->blkbits workaround for partial writes
        https://git.kernel.org/vfs/vfs/c/bb944dc82db1

