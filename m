Return-Path: <linux-fsdevel+bounces-48186-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 53DBDAABDA3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 10:46:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40B653AC313
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 08:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2A5E264615;
	Tue,  6 May 2025 08:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WqnKrX+X"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F1921474B8;
	Tue,  6 May 2025 08:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746521200; cv=none; b=Mc2lWIf9SdiX56ISIMchLHWlrY0EEIPzewlVcGJCS0whxoNzld4xqGdJzNsS59x3ditmvGsDvXVSdv78BGDYroQSBRV4YDRi8/OkeEF0MNdYCeWa8HMy5fTQNjb1QHItAsd71lTQraw0ECyn94MkbGVWjtK1F38A95xVpTMmgBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746521200; c=relaxed/simple;
	bh=Svp1gGWoj56zLwyS0SJUtmNVww63jXI6aUMrNNeQCKg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CKcHsvSQglRli2A9xfwn5jcvssSFIDaswFkROsAwv9DQQlPFJlT3xzEpB3VfGvxwiSINTj9k52WNJEyBx+CKZ5uTOej+xoe1RGuuBj+8cGfnNwPcAoXlXelb31m3TH+IHGp6XzWj9+6cwQe53cRVaSkA/hI4grtIHTUL2SG75fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WqnKrX+X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A500C4CEE4;
	Tue,  6 May 2025 08:46:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746521199;
	bh=Svp1gGWoj56zLwyS0SJUtmNVww63jXI6aUMrNNeQCKg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WqnKrX+X+EixCsx1UABJTha3c3YHZshxJ+tIsq7FcbtmiFPHXnCPNfbVbWPfTjW6+
	 ys4OkBQEU1pMIXu48UCEnLjEdATXTPQW8XQqhbsrWYyQOOqk6I5HFDfcWxXcnedf2I
	 RgGBjYCPpWFik6JHOUz7Is+Wr7/HmijjP1TmxndPfwcoY+XgjHgFF1EXY8+oKo0w3+
	 dWsjlrL/A/PbAvrDMW/MO9PQBL0U8NNuPSLfYxnZlpIN82R3IwHLKM/eq0uRp0sPCY
	 xBdtugiQYe4Rdl44wwg4chvsmnSjYRjtL78xhdZm3DpvZbko+3ALxlFYvXIvgXQFq0
	 1pexwcy76Ah5w==
From: Christian Brauner <brauner@kernel.org>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	akpm@linux-foundation.org,
	linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-mm@kvack.org,
	gost.dev@samsung.com,
	p.raghav@samsung.com,
	da.gomez@samsung.com
Subject: Re: [PATCH v2] swapfile: disable swapon for bs > ps devices
Date: Tue,  6 May 2025 10:46:32 +0200
Message-ID: <20250506-versuchen-probt-90de33b4cd73@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <aBkS926thy9zvdZb@bombadil.infradead.org>
References: <20250502231309.766016-1-mcgrof@kernel.org> <20250505-schildern-wolfsrudel-6d867c48f9db@brauner> <aBkS926thy9zvdZb@bombadil.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1207; i=brauner@kernel.org; h=from:subject:message-id; bh=Svp1gGWoj56zLwyS0SJUtmNVww63jXI6aUMrNNeQCKg=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRInskUt5tv//iOVa3oE8Nuh+1PWMJ27eab47jgoa3u1 D1/Xm/+3lHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRZW4M/8ti2C8cl7o1e+KN WYL6C9tfXijVPaSfwpAmkbmf20PN2Yrhf3Vc6KIoBtVNhX63a49E86Ty+3EJfpGI6ot6z3AgZiE HNwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Mon, 05 May 2025 12:35:19 -0700, Luis Chamberlain wrote:
> Devices which have a requirement for bs > ps cannot be supported for
> swap as swap still needs work. Now that the block device cache sets the
> min order for block devices we need this stop gap otherwise all
> swap operations are rejected.
> 
> Without this you'll end up with errors on these devices as the swap
> code still needs much love to support min order.
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

[1/1] swapfile: disable swapon for bs > ps devices
      https://git.kernel.org/vfs/vfs/c/6ba0982c3235

