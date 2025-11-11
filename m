Return-Path: <linux-fsdevel+bounces-67882-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63D74C4CC22
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 10:48:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4058E1885576
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 09:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67F882F60C0;
	Tue, 11 Nov 2025 09:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZtVRGfxm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBCA72F1FF5;
	Tue, 11 Nov 2025 09:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762854439; cv=none; b=fpSaeyayTVEVBruSQ9psde1abma+1Z/OusdLe6rhWYpaTQXy5/YT5h9bSZPuM5UcZzbpZisY4A3CoXXiZZaanwpmnFCqDiOOTpMTiBPKVTllh1x+vnsEZuegxnFHC4svTuN1hdxSFVjaDL+hHD+22XEBgHlvBcinjJKJ1XxAb6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762854439; c=relaxed/simple;
	bh=WWAIdiG5iy2SUq8TzM5SeSLosiElj8klfLietx78N50=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rF9BbmAmNN42aRiZLWIyBzMfs92BEXfmBvKVdMemR+jHBjc2y0uiogNbOJPVeEj+RNRbT6BQUoAXn8SO2+JHFB46WRjO8acxB0qgvKzFFZN4lBjjolsoqsWY5xVPHT31WE4iBNQBOXLh2cUg58xM1dnXakpgWzkjgCjr9mnofA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZtVRGfxm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC106C116B1;
	Tue, 11 Nov 2025 09:47:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762854439;
	bh=WWAIdiG5iy2SUq8TzM5SeSLosiElj8klfLietx78N50=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZtVRGfxmOp+Om5zScyNa/ouk098yfBqc01hS6q48xsDQY83+3HhupskpeFLKh1beJ
	 N80caFkH5JDQ5MQ0iouZS03KsAy97aZBkrChs2VpRusDg6qXkmwTQe4Y9rDaw6hOX3
	 /1ulBIJZ2gc8YZwNDmDPHvgqlOnuAxXAnSKTvf2Qryd6ClKNNqHHRzJI0YBcWQaCQh
	 twZPIosJCz5ryZwbnMMK41sakh44f6j6Xo9bPAXJhJzBWt0X9674Zk/rqKcieIeb48
	 f/eXtpagUgiGPTAKOwa8yDZ5GF+dhQp/QTin7W+XuALsRS4VS1+g08t6UWN5bXwmte
	 t6f9ZF5DVd+sw==
From: Christian Brauner <brauner@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	viro@zeniv.linux.org.uk
Subject: Re: [PATCH v2] fs: avoid calls to legitimize_links() if possible
Date: Tue, 11 Nov 2025 10:47:08 +0100
Message-ID: <20251111-entkriminalisierung-chatbot-feeb7455fc74@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251110100503.1434167-1-mjguzik@gmail.com>
References: <20251110100503.1434167-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1175; i=brauner@kernel.org; h=from:subject:message-id; bh=WWAIdiG5iy2SUq8TzM5SeSLosiElj8klfLietx78N50=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQKsynFNU7hWy9X3fV85fTt0zOM3XKi59/bMHkvk8Ekw Ruvap5ldJSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEwkNZKR4VfpjmNVB99Om5PN LNG17fO/qf03MpXWJe91mspTFcLVJsnw39Hj6M2vSsW6U2o5MhyvBpuyKjUkiIjUhbEUbl1yfNd OFgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Mon, 10 Nov 2025 11:05:03 +0100, Mateusz Guzik wrote:
> The routine is always called towards the end of lookup.
> 
> According to bpftrace on my boxen and boxen of people I asked, the depth
> count is almost always 0, thus the call can be avoided in the common case.
> 
> one-liner:
> bpftrace -e 'kprobe:legitimize_links { @[((struct nameidata *)arg0)->depth] = count(); }'
> 
> [...]

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

[1/1] fs: avoid calls to legitimize_links() if possible
      https://git.kernel.org/vfs/vfs/c/ab328bc1eb61

