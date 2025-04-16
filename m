Return-Path: <linux-fsdevel+bounces-46563-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ABA2A90575
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Apr 2025 16:07:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4EDE7AE606
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Apr 2025 14:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60580218AA2;
	Wed, 16 Apr 2025 13:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NRsSG0aD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A68F1F8676;
	Wed, 16 Apr 2025 13:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744811868; cv=none; b=ixGzfkA4N2VV5W45VpUjDYdi8aCvxmeaNfo6bLACPV8Yza4T8wyHg+sbrWCZCAor1Uw3jYNgZsML9f4Kj7uKMnPmBDCwNeR9kG0UgDFO7oBkXqBhEx/6Ug0G4NUEhtZjIi6nCUuWlJ9mxcyc2UiNplqb43TlEibBkMWaDyKnfck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744811868; c=relaxed/simple;
	bh=wb1pgTkDhh561dN6uYHfGumqPzKkLa6WfQktifFPInY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M+0+a1QWqUOEAAIXkQvtdpIO4EXL2V+Vw5sChFjSwseCkSwMoVhVp51asx2l9GLp40XFt5v4O2eVWsShAQVecfGoAW0UYBsRJfJrdXkG6EheCvVtV+yIKhP9CW0lPlwQe5Y99L03GS5RVdVWBuToShsUutaS+/Puff1dW4qaqBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NRsSG0aD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4764C4CEE2;
	Wed, 16 Apr 2025 13:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744811868;
	bh=wb1pgTkDhh561dN6uYHfGumqPzKkLa6WfQktifFPInY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NRsSG0aDffiWafluzFCTEoXtb0DPDlUIgPNFqWB58FyDCOQLDm2O3yq/bVxWpprra
	 b3yMAzmtDebpx6Huj9ZYqfZub3BgZBNddr5xqnQjDTWhtfAJuUY/58wCSx0iqTMDcl
	 mfCipBtS5/2i1Gx/2lfpdLeJsCxpo9cjTvhmS3EUlLmznel9QT4KMbRUUMj7mQJuI/
	 x/yATlmOBgOa63kfNFYaw00L7a2xQSjKrrlWD0RMVzJObBFVD0TEDPhTfygHxjK9lB
	 ka24ix4GTxJGpkhDsT5aFBqs4tCtEpN/xqqj/tLbQM68kJ8U2wHRe0Zhd6331lp9aE
	 L0IRSQleUgifg==
From: Christian Brauner <brauner@kernel.org>
To: Zijun Hu <zijun_hu@icloud.com>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Zijun Hu <quic_zijuhu@quicinc.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>
Subject: Re: [PATCH v4] fs/fs_parse: Remove unused and problematic validate_constant_table()
Date: Wed, 16 Apr 2025 15:57:31 +0200
Message-ID: <20250416-rotkohl-braut-dfc64e8453af@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250415-fix_fs-v4-1-5d575124a3ff@quicinc.com>
References: <20250415-fix_fs-v4-1-5d575124a3ff@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1142; i=brauner@kernel.org; h=from:subject:message-id; bh=wb1pgTkDhh561dN6uYHfGumqPzKkLa6WfQktifFPInY=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaT/3x6244bq6SouZqY3t9fbvD25JSTr8aQiv4tL3+9+o 1Q8Zfpq445SFgYxLgZZMUUWh3aTcLnlPBWbjTI1YOawMoEMYeDiFICJ/BNnZJjvLz3jvqjkk84E b+36Mm5956u7nd70BNuxORlphjs/z2JkaKhgPah+YO8LmY+ZYjIfpggENP/4dfGV2dLFbrecLvz cyQEA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Tue, 15 Apr 2025 20:25:00 +0800, Zijun Hu wrote:
> Remove validate_constant_table() since:
> 
> - It has no caller.
> 
> - It has below 3 bugs for good constant table array array[] which must
>   end with a empty entry, and take below invocation for explaination:
>   validate_constant_table(array, ARRAY_SIZE(array), ...)
> 
> [...]

Applied to the vfs-6.16.misc branch of the vfs/vfs.git tree.
Patches in the vfs-6.16.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.16.misc

[1/1] fs/fs_parse: Remove unused and problematic validate_constant_table()
      https://git.kernel.org/vfs/vfs/c/02c827b74082

