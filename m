Return-Path: <linux-fsdevel+bounces-41071-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 805D5A2A8F5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 14:04:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C29A23A6BA7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 13:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 405E522DFAB;
	Thu,  6 Feb 2025 13:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HsFwrOzY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB3E21CFF7;
	Thu,  6 Feb 2025 13:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738847060; cv=none; b=QL9B06mXwAckTuybc1ZOj4SYTBFNsh091NSLB010uWvQ23GbSb2iiN0WMU5kNGK+F+PEAjVLBLdYcJ6tURY1o7o6gLRboCOZoxiXceTklxGRTn8L6H5DiIserp0NdegDxhX7L62Tfyw/rrg+a61k/b5iirKoepLCQo6aqMku4Sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738847060; c=relaxed/simple;
	bh=p1nNCuYFj9r9j3dWp/INmxuk//LD1Iwa+vyoBcH7iis=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V8WYZQiUM8rhPkxAPCVvrb4oA5XdIfwdsoMl5vCSEuP868In0DSpYAmJGlaHBk8qhA4rJYFPXPZk5R5IwqzHKw+/K6kxhNN3TPoAFFr+O6jQltfuyYOK9DkAFlLOZfQsdCM/3oVFNOHPC9lG0p51EU5t9hL9DYhwfv3BANHgl58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HsFwrOzY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B93FC4CEDD;
	Thu,  6 Feb 2025 13:04:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738847059;
	bh=p1nNCuYFj9r9j3dWp/INmxuk//LD1Iwa+vyoBcH7iis=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HsFwrOzY1Xw3Xcv9QgUPq6KnvIFPIeYTAlR7dTah0elITrmBJG229w4X8yic2ace2
	 gW1IIZZtLxzYZ2f3puwAIzX6uJcuedI8Cd+3TBM0/qaG+eIe+A/ZnyKAqiF7d1wE7S
	 CPr5I/NZmybN68Hc+zvtKbbqqaiMSD+skf2wCe6j+ZQcLo5CtPzdej2XHa7ySUd/Fg
	 +ziMoL/0yJG+NN3WkYNaI/UkJv5e4xW6YC/x4Xkn1De9ujSUyL1slLf6eJMvE/e3Ew
	 ZUtq8YmgzkDKtResGS+ErYN2kiNs0G2tgw6odYgr42unKvKWfqubM8CL35iEdAVKhX
	 7c3jNQtKzW/IA==
From: Christian Brauner <brauner@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>
Subject: Re: [PATCH v2] statmount: add a new supported_mask field
Date: Thu,  6 Feb 2025 14:04:05 +0100
Message-ID: <20250206-unstimmigkeiten-hinauf-5b5193488a02@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250206-statmount-v2-1-6ae70a21c2ab@kernel.org>
References: <20250206-statmount-v2-1-6ae70a21c2ab@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1449; i=brauner@kernel.org; h=from:subject:message-id; bh=p1nNCuYFj9r9j3dWp/INmxuk//LD1Iwa+vyoBcH7iis=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQv2ex7mStvqXOk7o6d7yw4+aVCu688i+dWdU3/x7Wgt WTVR8kjHSUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABNJsmRkaDUrzWXs5RCM7bt6 Kq4/5dW5lMW67Wy7WBomqW3Z6mN1n+HHEdtvdzK5tq8IsjGcFLU+wtTs8+RMlULeG1e2W6nbenM AAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Thu, 06 Feb 2025 07:51:52 -0500, Jeff Layton wrote:
> Some of the fields in the statmount() reply can be optional. If the
> kernel has nothing to emit in that field, then it doesn't set the flag
> in the reply. This presents a problem: There is currently no way to
> know what mask flags the kernel supports since you can't always count on
> them being in the reply.
> 
> Add a new STATMOUNT_SUPPORTED_MASK flag and field that the kernel can
> set in the reply. Userland can use this to determine if the fields it
> requires from the kernel are supported. This also gives us a way to
> deprecate fields in the future, if that should become necessary.
> 
> [...]

Applied to the vfs-6.15.mount branch of the vfs/vfs.git tree.
Patches in the vfs-6.15.mount branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.15.mount

[1/1] statmount: add a new supported_mask field
      https://git.kernel.org/vfs/vfs/c/f0445f381ab4

