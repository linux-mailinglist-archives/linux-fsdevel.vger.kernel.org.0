Return-Path: <linux-fsdevel+bounces-52517-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0127AE3C44
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 12:27:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 897901734E1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 10:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAB0B23AB81;
	Mon, 23 Jun 2025 10:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nxoAKtBU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 150A82367AE;
	Mon, 23 Jun 2025 10:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750674459; cv=none; b=aaaMMZ0UiLjHEFtMIYwYW6VJfdDWScu2TVlDnSJa/d3hVLj4F+yARslWAzaYObBw9E6ikR4rCaNfyn5lDDtW4JHrZfLkDwpyaIzLIe/cKjWja0vtgkVPglqBW5dJlY5LTtXXhfdzG3q6ZTMT2cGVNlB+IpRicdb6Uy6ipKhi+7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750674459; c=relaxed/simple;
	bh=Z/1T3Cq5W9neeL9twcz8H6Rpg1JwQhFOAlQbl6Uyd2E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EOsKVhdtRxNKhsAMFSrancC5GUdm6giLeWpuMJxbc+RwYMoBgrcCIFlp1s3gPOoKCH29JkkaR38AoHEVptcX2HSlGabK6MHt9hLxvN7f8ezT/XgXYAaZKd6A9shbedPlgdcvHDvrSnec2fy/CpobyCBoMmslk2icm0NApqAbRhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nxoAKtBU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B016C4CEF0;
	Mon, 23 Jun 2025 10:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750674458;
	bh=Z/1T3Cq5W9neeL9twcz8H6Rpg1JwQhFOAlQbl6Uyd2E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nxoAKtBUtXjE/b0jI6I7f+C0i82c4FW12Z3k/sUoQ4snmKLNd7EnNM6QHuuqHOuvY
	 Z9Yl+xFnD3SuHFQ95Ym4TAEtPNVbBT4O/jJdf7CZDZNpiop9COVGyeZUcLCCcfanTU
	 DJSWUm8Hxd0tG16zwtLh+VQUs2/JSUz+IdrAF4Gzv7F57eFfYQwRa3KGVOPhMg278I
	 JOj22d9L4kIcyV+QaXH0KU6ku0g3S0g7ycxlraGrV76yXvlQEsTY8/tE6PxYNlqn5s
	 bWpHk3W5F/Nv3JqUDbtBo5dV1CoDGWvVPT+odm+rwgejhVLH3jwWUIzJnlMbpIWdR7
	 nTyniqgj8X/pw==
From: Christian Brauner <brauner@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-unionfs@vger.kernel.org,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: [PATCH v3] ovl: support layers on case-folding capable filesystems
Date: Mon, 23 Jun 2025 12:27:25 +0200
Message-ID: <20250623-zuversicht-rasten-22993cf67abd@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250602171702.1941891-1-amir73il@gmail.com>
References: <20250602171702.1941891-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1193; i=brauner@kernel.org; h=from:subject:message-id; bh=Z/1T3Cq5W9neeL9twcz8H6Rpg1JwQhFOAlQbl6Uyd2E=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRE6gj/NDt8XaTpuatQcfSxotre+4Z1URn52ncrvj2wK pA/12PVUcrCIMbFICumyOLQbhIut5ynYrNRpgbMHFYmkCEMXJwCMJEpvAz/LCzWa/+2Tjj8wSf/ 0smmk7Xs7vW7RQ9wOP1w9sxh4LtryfA/+6WmrtDTFxErDhqkJm5rypi7SWfNDg2HhSo9AjtrbSL ZAQ==
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Mon, 02 Jun 2025 19:17:02 +0200, Amir Goldstein wrote:
> Case folding is often applied to subtrees and not on an entire
> filesystem.
> 
> Disallowing layers from filesystems that support case folding is over
> limiting.
> 
> Replace the rule that case-folding capable are not allowed as layers
> with a rule that case folded directories are not allowed in a merged
> directory stack.
> 
> [...]

Applied to the vfs-6.17.file branch of the vfs/vfs.git tree.
Patches in the vfs-6.17.file branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.17.file

[1/1] ovl: support layers on case-folding capable filesystems
      https://git.kernel.org/vfs/vfs/c/5810e7558fda

