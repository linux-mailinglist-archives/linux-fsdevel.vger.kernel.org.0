Return-Path: <linux-fsdevel+bounces-30229-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6D64988009
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Sep 2024 10:08:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9953D282BCA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Sep 2024 08:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55411189900;
	Fri, 27 Sep 2024 08:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Outd2lB0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E20188CB7;
	Fri, 27 Sep 2024 08:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727424494; cv=none; b=Px+BW4IHy/7b8vy2AYidIiT2gS9szfsk8SCOkLHr9YqBu/RtmNH2feZ2FrQ+fflUGULxdLYjPzzBxHRtxxoaEmHwBHTpDE07AF4158lqUzeTd5idVjW5NRH33q/MVzXJw/OEHe90olKideTM+L1s4k6fpCHW90hDmnYVEVEjiOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727424494; c=relaxed/simple;
	bh=qrr8F6mhp37/8goTelXVcSv72h5Emk8kpcyLOVTI7nQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A0fgcehOzCbX08qFwbCZgqOR6hShXMABfS6r2jjw1WQ5SJUh4na295JbGoH4piX/OB5u9dQhzCqamOzeGXw8g1A6UFGieziwtQYiwZlqOZUzncG7YbegeS9AP3T5/48+edaDAiS9GMoPwyqgjxmQxyxP4ILiWdN6BrGet/NVCPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Outd2lB0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1C4DC4CEC4;
	Fri, 27 Sep 2024 08:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727424494;
	bh=qrr8F6mhp37/8goTelXVcSv72h5Emk8kpcyLOVTI7nQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Outd2lB01VOTLYDOGeswQwueKzlm+EOifqdxlQ4wB/8MrqP6mZtqn6n+rKIoTqc1e
	 kiisilHVnZCIEJvalKnA3qR2YHOkwk+HzZxQYLedHYLRTpBSFEheAsUMMOVVXFYRgj
	 oZNhoNHLcUvthQxoFMAThjmuiGgHXqnMfBJJboyDD3j6cY2fyYQxHOwaNlAfY9ESKo
	 grEtBzrVEHlyEpt136/mYVhFyRdz36/t+JDZSXA5Mge9d5fwWXYM2cDL4KIrNMeMd8
	 WUGeJbN6K897pM3Cb8O2g8BA94c0wF4P33q9OSZrB7Mfqe5Ls744JoZHQWmwTx2/kE
	 UOLO55iVty1Fw==
From: Christian Brauner <brauner@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Paulo Alcantara <pc@manguebit.com>,
	Jeff Layton <jlayton@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	netfs@lists.linux.dev,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-erofs@lists.ozlabs.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Steve French <sfrench@samba.org>,
	Marc Dionne <marc.dionne@auristor.com>
Subject: Re: (subset) [PATCH 6/8] afs: Fix the setting of the server responding flag
Date: Fri, 27 Sep 2024 10:07:59 +0200
Message-ID: <20240927-inklusive-erfunden-8a9df201244e@brauner>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240923150756.902363-7-dhowells@redhat.com>
References: <20240923150756.902363-1-dhowells@redhat.com> <20240923150756.902363-7-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1300; i=brauner@kernel.org; h=from:subject:message-id; bh=qrr8F6mhp37/8goTelXVcSv72h5Emk8kpcyLOVTI7nQ=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaR9S3928A/vY47APBNFzaQswV4+Pw8Hlu3a9bd+cD9uO Frlc/JtRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwETyLzMyTNTnfr5xfcZix1xr Tj7JEPepAnKn+FvmbAnf0rfRyop5DsP/gIP2Vf3Nm3a29nDoVNhIl9UaHjpdV197f2eb0M+i678 5AQ==
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Mon, 23 Sep 2024 16:07:50 +0100, David Howells wrote:
> In afs_wait_for_operation(), we set transcribe the call responded flag to
> the server record that we used after doing the fileserver iteration loop -
> but it's possible to exit the loop having had a response from the server
> that we've discarded (e.g. it returned an abort or we started receiving
> data, but the call didn't complete).
> 
> This means that op->server might be NULL, but we don't check that before
> attempting to set the server flag.
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

[6/8] afs: Fix the setting of the server responding flag
      https://git.kernel.org/vfs/vfs/c/830c1b2c1c28

