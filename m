Return-Path: <linux-fsdevel+bounces-38387-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59984A0138A
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 Jan 2025 10:16:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21D203A22EF
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 Jan 2025 09:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A368156C62;
	Sat,  4 Jan 2025 09:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EjVY+DK4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28604188915
	for <linux-fsdevel@vger.kernel.org>; Sat,  4 Jan 2025 09:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735982207; cv=none; b=QldPcZC73iRtKqmdJn/jyNAjm44pqJdB0vmNpviB01s5zsJHrMKGx9Dea4PSwU1gkzFOXVyoF4E+kNIs2LhVR6tHjvA69oVZ2oUOXyCHOz1yB861Qo+s7ZC8/871uJ1SglZnOifdp69vxl22J6ojdwGsGnm+hOPua0Z3UHWiIPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735982207; c=relaxed/simple;
	bh=ofL2o7bfU0OacdOcc1oEH3vFK9i1tP3iwLSJzDk4M/4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e0y4BKua13oLdWBgQnQaZdrKRC1JP3bQiNqXSxyItOqp/cFKtAphUiR+V2I4pWboPInLf3eVZeK6LftEFop25OxRa5E1PmbzeDIIH3bVZTMPyNexgmZtrCKmIExw2xG9/77xQbKGgMxBYCxh0SbE5I0uvgcya2zIhtiz0Jleu9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EjVY+DK4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB691C4CEDE;
	Sat,  4 Jan 2025 09:16:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735982206;
	bh=ofL2o7bfU0OacdOcc1oEH3vFK9i1tP3iwLSJzDk4M/4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EjVY+DK48OJiQvrb4TJThz5i9CG74SJjx2J02h/VW0/nd0T7EHAz0hr1Hyq6OMYJ5
	 RLyq31PG0nhuLOaxX7aXqaLOdWpHTkRa0UdpM1B40XL3rn882D/ZG5c1c6hf1H5aIq
	 fP7tP1BjP+kwdfZ+p1/URIMuCOiH3aYJ679ErtQBkcJINJuiz9ZKGw2XaR5LAqzzSN
	 hhr7r0f044IELBfhA9lvBrp9aGwJVY7LX+qolsb0Yq1EBCHt/HGlshTERkn6MA1WsG
	 jLKLsD45KcZ93C//1zpderC5WMkQdtFU6Pf+9VIpuuKpyG9XLs4ZgyAecY5eV7Eq/S
	 nBAPJZGOi9GIg==
From: Christian Brauner <brauner@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	yukuai3@huawei.com,
	yangerkun@huaweicloud.com,
	Liam.Howlett@oracle.com,
	Hugh Dickins <hughd@google.com>,
	Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v7 0/5] Improve simple directory offset wrap behavior
Date: Sat,  4 Jan 2025 10:16:30 +0100
Message-ID: <20250104-notprogramm-flanieren-23c8907c2cbc@brauner>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241228175522.1854234-1-cel@kernel.org>
References: <20241228175522.1854234-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1596; i=brauner@kernel.org; h=from:subject:message-id; bh=ofL2o7bfU0OacdOcc1oEH3vFK9i1tP3iwLSJzDk4M/4=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRX/Cmv2BDHNadm+bIp+wrEFU9/unP5XoGi9zMV2b9vD p+RjPUw7ChlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZiIdj/DPy3zGrv4D5e1DN8r liZOyzM6feCSXvwn3orqv4/Fz6qqBjD8z37hGTD3eP+txP2HF7c9OrFXsNUw6ZWx37U1Gh8k5Q6 EsQIA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Sat, 28 Dec 2024 12:55:16 -0500, cel@kernel.org wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> The purpose of this series is to construct a set of upstream fixes
> that can be backported to v6.6 to address CVE-2024-46701.
> 
> In response to a reported failure of libhugetlbfs-test.32bit.gethugepagesizes:
> 
> [...]

Applied to the vfs-6.14.libfs branch of the vfs/vfs.git tree.
Patches in the vfs-6.14.libfs branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.14.libfs

[1/5] libfs: Return ENOSPC when the directory offset range is exhausted
      https://git.kernel.org/vfs/vfs/c/903dc9c43a15
[2/5] Revert "libfs: Add simple_offset_empty()"
      https://git.kernel.org/vfs/vfs/c/d7bde4f27cee
[3/5] Revert "libfs: fix infinite directory reads for offset dir"
      https://git.kernel.org/vfs/vfs/c/b662d858131d
[4/5] libfs: Replace simple_offset end-of-directory detection
      https://git.kernel.org/vfs/vfs/c/68a3a6500314
[5/5] libfs: Use d_children list to iterate simple_offset directories
      https://git.kernel.org/vfs/vfs/c/b9b588f22a0c

