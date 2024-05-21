Return-Path: <linux-fsdevel+bounces-19897-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7EFF8CB05A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 May 2024 16:24:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73433284D2D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 May 2024 14:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C98C81304BF;
	Tue, 21 May 2024 14:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ulH9wtsf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 304E012FF91;
	Tue, 21 May 2024 14:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716301448; cv=none; b=euVJnpAG8zWrdxHS/A+rSGVf4GvIs9dRH7hNeJxxlT70PQo39EKv0bAgB86lx+5FTtLKietGEK6dmCEnJKwtowc5+rLVERx5n/mJV9Hkpbl2/jUjEVmM6ReSPsy4AkfLtVJjFL1K72KrqeVHr4ydbCew/wTYeZXkkfrfCn3AsRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716301448; c=relaxed/simple;
	bh=UYG+Mo/SlKwLkAr3mfG47g2wcUb2YUUolbRO3KgUlg8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E6QTijuvwBACO10MAzH3JQfzusSdOYW+2KkK5dBByTOc9aG/ABk4eWLNFre83yXVx+9U8nXW/q/oWQWn0T0HHYDwnTzAvDseObHafOIwceseq/wLYN/5h0mixndbJ79kI6rtNi+l6DwyjS/6lYaFcwooBmOQgsTcf+OajgaO2Ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ulH9wtsf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8599C32786;
	Tue, 21 May 2024 14:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716301448;
	bh=UYG+Mo/SlKwLkAr3mfG47g2wcUb2YUUolbRO3KgUlg8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ulH9wtsfTkUy1lUxilIe3+S9Uje8kA0uChlBdcDylLyjHjD02MfrFXVijDoePdXn1
	 w7IHqLCCVMEVsY/ykz1Zk2cZ7SYg5fObUzOyOTf7oCcffNK7UhblCyfjnzZ4LaloLH
	 nHTCTS3I0Qnpav3BXPvEkfUz0OynBJOyUP6oexUk0JIu8qK8D7Js/b1dS/4sBihO/7
	 uStjCW70e5lsYI2jwxGO/G6vEqVtLxDB7Wn9F9phb4fxuj0Jqll/AMonMUsOvjCJXG
	 SsI0uwznFuueAX4Hjn0B7fxpuBL59hueZ6FKv5bDGtodYw+JDGTdroba1AD9DjnsnR
	 xPtXlNaotxbPw==
From: Christian Brauner <brauner@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	Fedor Pchelkin <pchelkin@ispras.ru>
Cc: Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexey Khoroshilov <khoroshilov@ispras.ru>,
	lvc-project@linuxtesting.org
Subject: Re: [PATCH 1/2] signalfd: fix error return code
Date: Tue, 21 May 2024 16:23:58 +0200
Message-ID: <20240521-hausarbeit-angekauft-974dea89dcce@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240520090819.76342-1-pchelkin@ispras.ru>
References: <20240520090819.76342-1-pchelkin@ispras.ru>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1143; i=brauner@kernel.org; h=from:subject:message-id; bh=UYG+Mo/SlKwLkAr3mfG47g2wcUb2YUUolbRO3KgUlg8=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaT5rGuMO/KM9SNPdPuj9W5uvYG93BqWt6Xfilx5r2zZ/ +6K041tHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABM52cvI0L9ognbLrqNLNqp9 2Td9n9XWlEef7eMefjEJepVs5aRvcJSRoePWigXv1IN2/dff5Ht5E9uahu2Kecpim5z07uhKNtl nsAAA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Mon, 20 May 2024 12:08:18 +0300, Fedor Pchelkin wrote:
> If anon_inode_getfile() fails, return appropriate error code. This looks
> like a single typo: the similar code changes in timerfd and userfaultfd
> are okay.
> 
> Found by Linux Verification Center (linuxtesting.org).
> 
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

[1/2] signalfd: fix error return code
      https://git.kernel.org/vfs/vfs/c/e8df0c67191f
[2/2] signalfd: drop an obsolete comment
      https://git.kernel.org/vfs/vfs/c/0dda1466f355

