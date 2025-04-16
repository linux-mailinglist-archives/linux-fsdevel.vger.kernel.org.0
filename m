Return-Path: <linux-fsdevel+bounces-46565-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 85D90A905CF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Apr 2025 16:14:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3E02447ECA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Apr 2025 14:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FB471AC42B;
	Wed, 16 Apr 2025 14:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EAHbu7VO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA4212C544;
	Wed, 16 Apr 2025 14:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744812436; cv=none; b=qcEeb8c5klaoQ3N8cQJzVOXergQo7PlYHef9vdpqV0oslqx9HgSR4NjqawaFSwq8X8MmWvEPq57mxfIUCLq+Xqwjfe6bzauqkqQTes3RuDD/x8YB4JFwt4kOqp2/ACMwcGsGpiPxYk2DEoCRiPZHgGA0WHtyWVQ5UJ3vaGdkp0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744812436; c=relaxed/simple;
	bh=7EHO8TK2D+GydiySIp/ie/wT/PsvzUr2Ehnna1ftPaQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jhz9dThpeIcApckL/rzFa8j/ozeH1cULcoHJp6xM0uAWfbgGJUmVap3TmwJh6MzAtxuL1tzAeWcscLVY7YeogUFv4Ux5hN9wqYNHDWMB7hNz5CeT+ymfZLqIKz6VA+sQlV9UvI02aG7C6azWv27EKfyeTlh5JcD9Z/0fyiI5sag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EAHbu7VO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E03DC4CEE2;
	Wed, 16 Apr 2025 14:07:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744812436;
	bh=7EHO8TK2D+GydiySIp/ie/wT/PsvzUr2Ehnna1ftPaQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EAHbu7VOj1OObD7UuHRS9W53PoNckQ/L14bNwooRZw2sdRNJV0k09C43GlS7Pp6UH
	 fajUSpiw6+J/Bc9YagXDgG8hQNduc00Ej/L46GTPDFxdN8B0hcitN0DNkDe7aNv9x7
	 mHdamS1/SrXWDmGNiUMZeS/CdupD0YM1+Ipi8ZjPpt4kJG/5WtBUpRCax48hxBViWh
	 K4jIpqdVIg1KSDvAeBXjqnPsCc4JDPw0hZ2HbF9UCrCT1TWsHirkPuZgN2uKKVj6N2
	 Qunhug1l4a0/dlJMp4matccgZB5xfoId32lmGX66BfEAFA8l2cnqjWh1oxq9mNPqxC
	 7oAKFlNu2YMyQ==
From: Christian Brauner <brauner@kernel.org>
To: linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] fs: remove uselib() system call
Date: Wed, 16 Apr 2025 16:07:09 +0200
Message-ID: <20250416-sinkt-kreieren-c5cb3bb6f7de@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250415-kanufahren-besten-02ac00e6becd@brauner>
References: <20250415-kanufahren-besten-02ac00e6becd@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=946; i=brauner@kernel.org; h=from:subject:message-id; bh=7EHO8TK2D+GydiySIp/ie/wT/PsvzUr2Ehnna1ftPaQ=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaT/39m/SVnzZgbT3dLdf5dsb5lWu+/l4U1Z+v7cpn/jw 4vfO19831HKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRNR8ZGXZZJprYCWtbZ7xO P/DZ9m84J/P6rnu1a8W3l6b8Ph779xzD/9S9OyLeLH1x1yzv56+GispbOXdrZueEttU2Sa7bfUL zJisA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Tue, 15 Apr 2025 10:27:50 +0200, Christian Brauner wrote:
> This system call has been deprecated for quite a while now.
> Let's try and remove it from the kernel completely.
> 
> 

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

[1/1] fs: remove uselib() system call
      https://git.kernel.org/vfs/vfs/c/2a6ca7a03bc9

