Return-Path: <linux-fsdevel+bounces-28021-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 298B7966214
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2024 14:55:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA15B1F24824
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2024 12:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77DD31A4AB5;
	Fri, 30 Aug 2024 12:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hIeMmxxq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB8DB1A2875;
	Fri, 30 Aug 2024 12:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725022477; cv=none; b=VShyVC9tEcxTlOgdAR1BYGbMFtAtCG/reGCwRfR4rJX7fjk6hCWQrAruWojA4n1F+/tgDFIJ4C/YUt2lArRMApZ8BmkcJQi2G9+iqAc/L1mGydyMDPru92Y/Emht34OhOfhSegZ+YlJWmlTQ/0mGTHSZUb28AH+ohCprJZfCkfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725022477; c=relaxed/simple;
	bh=9T+skl/L5u4QCrgwI5h6ynbwGcoPG2oX+d7o+h8AmtU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lOHFRuwXR5ayX/xMA9qR93U6LEGTo9+w8QON5NtPEsZiXuQjqlOufAouOEmGhQuqi07XWmjXBtKFVN80+yq5bTJhaTrFDslrNKT+E/0OSqOKjP8QGzzW0CfAuoljl1n3A/IpeIeMvyNSAXgpf7F1eyUGp9rzNC4TAIKZNzKfFRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hIeMmxxq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46760C4CEC2;
	Fri, 30 Aug 2024 12:54:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725022477;
	bh=9T+skl/L5u4QCrgwI5h6ynbwGcoPG2oX+d7o+h8AmtU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hIeMmxxq/vvqs++vMgG3Q6VUuLnm6K6nAFgf2H6UCOkDPyi5YJ6Ipqqi1Nome1Fxy
	 9ML2Pk/9vz7v/ATTgCy6gSTpTOLPpFH2RqyJem8swaL/jf/P/+p50g7jh4PGu74x1M
	 +ITtux91CXuGd0s65ayIC5Vido73f6m1vl7RNkW1QEsyXJU8keC9Yay+DIJKI04sB9
	 URzJVOBTR67Y6LEsrIyM4Kxp94YFIoN3d3UfZIDxKjS0dB1J/aqFcsi0RJlwyRW1AP
	 igCnVjSUpjZtZD66jxHeyE2jK/jp6oa9Bveiv4XErwCMJt4ZbGtWs2etoYn7Sb1Zfl
	 Xnc1Ix1aejDyQ==
From: Christian Brauner <brauner@kernel.org>
To: Michal Hocko <mhocko@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-kernel@vger.kernel.org,
	Song Liu <song@kernel.org>,
	Yu Kuai <yukuai3@huawei.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Michal Hocko <mhocko@suse.com>,
	linux-fsdevel@vger.kernel.org,
	linux-raid@vger.kernel.org
Subject: Re: [PATCH] fs: drop GFP_NOFAIL mode from alloc_page_buffers
Date: Fri, 30 Aug 2024 14:54:19 +0200
Message-ID: <20240830-gingen-muskel-2806fc44736e@brauner>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240829130640.1397970-1-mhocko@kernel.org>
References: <20240829130640.1397970-1-mhocko@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=944; i=brauner@kernel.org; h=from:subject:message-id; bh=9T+skl/L5u4QCrgwI5h6ynbwGcoPG2oX+d7o+h8AmtU=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRdPMjk+qZDnCXmqTP/nPPGT3fMmmsr/ip5+7Un+jxr9 ia859xk2VHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRV3MY/tev+T+xtXh1uAjj Ip9elaXb/0vw7JEXtvpyIG/B5+tGux4zMlzUYO3lTK5TNnTS7epu4zq9Zd/+ti3Xq/1WJzQJH/6 jwQIA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Thu, 29 Aug 2024 15:06:40 +0200, Michal Hocko wrote:
> There is only one called of alloc_page_buffers and it doesn't require
> __GFP_NOFAIL so drop this allocation mode.
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

[1/1] fs: drop GFP_NOFAIL mode from alloc_page_buffers
      https://git.kernel.org/vfs/vfs/c/bf72320f8348

