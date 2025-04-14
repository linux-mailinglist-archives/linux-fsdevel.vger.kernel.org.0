Return-Path: <linux-fsdevel+bounces-46351-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B920CA87D0C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Apr 2025 12:09:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56875172D01
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Apr 2025 10:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91C33269D01;
	Mon, 14 Apr 2025 10:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hBF44R4a"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7565257AC8;
	Mon, 14 Apr 2025 10:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744625270; cv=none; b=CAzzdH/+kG3hnDiMZ0xNoa9derpCJ02wO4zJisD4Ac+AaCgYp8qEM/yvNspgoPe7Zlf5vnZPfqnrVUiwGAaTTVkdsD+Vy5S6TSyrUij8k8evPiPBA7vqTaspGftStIFTkgS0FjkHAnmOeB5FX+T05C2vNrBhyKzwXOQHW8rksoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744625270; c=relaxed/simple;
	bh=VI4j0sXgmnuEw8vbl2viydu5eF3Lvl/q1kcrbNaE+ZM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oGubABmPMDlW6e/qTzrblyKp5l4wpW+XrQaSu9xhOdjaHpUrglsi8SEyPIiOg1b/6hYeVqYqwUAyvTv+rdZJ1fvPqxqy7X7SCahU+Jkj/46vwequJjoBF+/zWRY02Wni/Trafttgi4ReZjEVRk+ZGXfUj4HcxJGXW+S0U6mf/FA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hBF44R4a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0270C4CEE2;
	Mon, 14 Apr 2025 10:07:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744625269;
	bh=VI4j0sXgmnuEw8vbl2viydu5eF3Lvl/q1kcrbNaE+ZM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hBF44R4aYCzaeHVJSnPnFfmJ3aUEnLW7FUBwrz/F3xVp/nTp63RDGYi5CnlHPf68I
	 WtTdzndSKupMu831w8mRUhfWx1rXXb8DrBdgQVfFhPBIUxr3sd1i7qEk4CAYRbBkdd
	 0EjYg2wSMQxYfoP2gLYRMsNG0UECvZWWO/mKVft1zwzKQyS5uC4mgj1opvcYmWQVIZ
	 xBhnKs30O9h+5WK6WmD5PQBwDukVbgtdoz4vNjfhf2FzLIvOP1mf+8HBXk32gGWFcd
	 wJm2pHCTHq7glK2gE25LGTaRlWBDXozJBQhIvYpMmBwPLKIdE+9Ts2P01HSFQPaW5Z
	 Os2+dDEc39bAg==
From: Christian Brauner <brauner@kernel.org>
To: lirongqing <lirongqing@baidu.com>
Cc: Christian Brauner <brauner@kernel.org>,
	viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH] fs: Make file-nr output the total allocated file handles
Date: Mon, 14 Apr 2025 12:07:33 +0200
Message-ID: <20250414-teuflisch-nahezu-396209d549ba@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250410112117.2851-1-lirongqing@baidu.com>
References: <20250410112117.2851-1-lirongqing@baidu.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=971; i=brauner@kernel.org; h=from:subject:message-id; bh=VI4j0sXgmnuEw8vbl2viydu5eF3Lvl/q1kcrbNaE+ZM=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaT/uVdwjCeFy7gjvIxbQDrjnIwvq+murlcBj89GaTbPC XjEs5+ho5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCKHQhkZNlxP3W202OHyy7Q1 Vz5nr62/buz8vFV82y6ONT+3Rmr43Wb4X376vee9T1vtJzStMLZ+oWq36njGD7mV31qqY3bsL92 pyAQA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Thu, 10 Apr 2025 19:21:17 +0800, lirongqing wrote:
> Make file-nr output the total allocated file handles, not per-cpu
> cache number, it's more precise, and not in hot path
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

[1/1] fs: Make file-nr output the total allocated file handles
      https://git.kernel.org/vfs/vfs/c/66319519f89d

