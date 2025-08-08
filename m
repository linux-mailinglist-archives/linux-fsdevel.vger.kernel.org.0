Return-Path: <linux-fsdevel+bounces-57075-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 68CFFB1E8ED
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 15:09:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2D9314E1549
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 13:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 279E427B500;
	Fri,  8 Aug 2025 13:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="se4c6TmU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D65B27603F;
	Fri,  8 Aug 2025 13:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754658553; cv=none; b=mo3M5yf9ZjaZje9wZe6y45H1wvqspO9l0kcC4at8McnuHAcRQddOaIoL+JPzxy9cp0C/oqz91vK5qNYi2Kqm4eKEshevfaW4e9IKraX2yeFe+umvnb0G4WFWtGRUwb6U/9MqK9NAFZU0ZA3SKe33gosbB8I7BMRu9ytyu1xSlQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754658553; c=relaxed/simple;
	bh=YOUfFxIay4gAI/yW/+JWV4fx/HDYohbN9iogANpShf0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b02kWdmgk9D3F+e6v49l6+/TU2pAcdSjKd2mHJwymHmPiYSQX9lfdsNFTVXAFuKofKBn+FNJmBJYFJLm29N0Nc6AhhY+1xlgOYxfUFspfUX1XjXYJUutnami1jQszJrI4C3FdHCGPyn/OvBjXT/qY4WBA6UsvLtbWQZE3fMRt5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=se4c6TmU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57FC3C4CEED;
	Fri,  8 Aug 2025 13:09:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754658553;
	bh=YOUfFxIay4gAI/yW/+JWV4fx/HDYohbN9iogANpShf0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=se4c6TmUs1TOXVCpZttvjHqi1ZTe3toFddiGPUOJIwIgiaJO6wqCudc52Gnc+tFF0
	 1kV4yHZUz1VqSpZQ/86wnpZEsdi5Nd7JCTp2F+frsWb2FX9c/0T0q7DEdZgr7aQPoC
	 17mPVMoL7J7jQCEMcA88rZo5BQ5ZHKS8UCK3CWrMP57F0Z8O66FbkQhGvOU2RFT6IQ
	 vvTcknWIdhQbx/izyTxE6xPaI9Q/nKiZTbHJwi5UgmF1cLxwG2NNuJ79LnTsgrCp/M
	 QiCwaVcSSuRdDfnXGdgf5Jcw5+eCwK0TJzg3lVxphxfNA5vTRR//6WxmCl8fuLMJI1
	 +EQt6cM/w/jBA==
From: Christian Brauner <brauner@kernel.org>
To: Xichao Zhao <zhao.xichao@vivo.com>
Cc: Christian Brauner <brauner@kernel.org>,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	viro@zeniv.linux.org.uk
Subject: Re: [PATCH v2] fs: fix "writen"->"written"
Date: Fri,  8 Aug 2025 15:09:02 +0200
Message-ID: <20250808-samthandschuhen-gekannt-9cbd952fa5f2@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250808083758.229563-1-zhao.xichao@vivo.com>
References: <20250808083758.229563-1-zhao.xichao@vivo.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=870; i=brauner@kernel.org; h=from:subject:message-id; bh=YOUfFxIay4gAI/yW/+JWV4fx/HDYohbN9iogANpShf0=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRM/fblksVSR6OPn1ZUHeQNvjH3cY7pm7pnvmH9G3UXl nVyfdKz6ShlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZiIyWeGfzrBv7jY32etcDp8 zI1J/Nk+2S3MfSdEo22Wcp3KWnLn6SSG/7k7vrBYdpgnzHvRd8Fx+lvnuhuN5z9kZayL2y17N/P nOVYA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Fri, 08 Aug 2025 16:37:58 +0800, Xichao Zhao wrote:
> Trivial fix to spelling mistake in comment text.
> 
> 

Applied to the vfs-6.18.misc branch of the vfs/vfs.git tree.
Patches in the vfs-6.18.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.18.misc

[1/1] fs: fix "writen"->"written"
      https://git.kernel.org/vfs/vfs/c/fe31a1c4d266

