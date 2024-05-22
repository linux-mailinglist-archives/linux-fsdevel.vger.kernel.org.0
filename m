Return-Path: <linux-fsdevel+bounces-19981-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0DEE8CBBBF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 May 2024 09:11:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4EF1BB21553
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 May 2024 07:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62FB87BB06;
	Wed, 22 May 2024 07:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O46AmvwO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C280744374
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 May 2024 07:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716361887; cv=none; b=VLZY3VQjfrIvE/78ogppJ6AQDkLTUnVDOUZS2LDAxlrTuhOAiUwlGdeWnW2cEQzeparex+dVUZ89jns5fUKGj4q2u8x9Pc1wmsiJeRq0NyRHZoT3fXtDkr7qk79Vf7yyPpwTA4kgeZfQkDgKttt4yGiNaDnvlJajbPXWKcXkQsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716361887; c=relaxed/simple;
	bh=xdawbpg2LgFDbMYj0NtCp/3z5avmxrZmM/Ba7JyeZTQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YkiVhuX94/dws5mAhefYefCb0IK9ny5yFwwKu/0881zNz+vm7nU3ZnLmTjZ16xUUyFuyhWgr8DJrx77CSAEZ0fwd3vGiE2PKR1pjqLBCV7hZ7tGKxlnYE7y8pzTRsD1rL9oPMx3/XcZzps/Bj8bfkgwcbhUjDDB075ZfpNScNa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O46AmvwO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7F96C2BD11;
	Wed, 22 May 2024 07:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716361887;
	bh=xdawbpg2LgFDbMYj0NtCp/3z5avmxrZmM/Ba7JyeZTQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O46AmvwOqFxVJWt1U9OZwPBuTChiKZnmP/YWcJQZ8iR0BaO+fUhvhZ2JLnW9TOG1U
	 uhyVHIxio/qXo2wFCX1gr+H+n7beBqpx7HwERViYe0Q46LbY13lOZl4uYnwj7j58F9
	 X8Fi2BTbvokOwlFF61GK/TJgMnsQnH1+52PXtxobArq6hjCIwixCZWsTBWDIQSZoHA
	 0xILrV4QP5LwyZ6PilM2Gn/U3QZjw0vOHsP+cRjbk4+BL4v0zdg4tz+WC50RjJgeZ6
	 6D1n8z9qk09JV8ExrgEauFs+dtcGZoGnWhuExEQGkSdL9Nvu9FbD6uqErLnqfH/+fv
	 KYUB1ieSRcZ/A==
From: Christian Brauner <brauner@kernel.org>
To: Hongbo Li <lihongbo22@huawei.com>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	viro@zeniv.linux.org.uk,
	jack@suse.cz
Subject: Re: [PATCH v2] fs: fsconfig: intercept non-new mount API in advance for FSCONFIG_CMD_CREATE_EXCL command
Date: Wed, 22 May 2024 09:11:07 +0200
Message-ID: <20240522-vitamine-blaskapelle-28b1218951c5@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240522030422.315892-1-lihongbo22@huawei.com>
References: <20240522030422.315892-1-lihongbo22@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1015; i=brauner@kernel.org; h=from:subject:message-id; bh=xdawbpg2LgFDbMYj0NtCp/3z5avmxrZmM/Ba7JyeZTQ=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaT5zpoeuiJZNi0jLraYJ4+RZaLyMv2idPaoNSrp1TE5r xadulTTUcrCIMbFICumyOLQbhIut5ynYrNRpgbMHFYmkCEMXJwCMJHm1YwM3fHXDqlyrGkX2fr6 e4RNIU/HzYaZH6/HvapXEzsWz82ryMiwhp059L+TvG9rkuD7V+//PK9s97zyyGmuqa4fi2dbcQk TAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Wed, 22 May 2024 11:04:22 +0800, Hongbo Li wrote:
> fsconfig with FSCONFIG_CMD_CREATE_EXCL command requires the new mount api,
> here we should return -EOPNOTSUPP in advance to avoid extra procedure.
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

[1/1] fs: fsconfig: intercept non-new mount API in advance for FSCONFIG_CMD_CREATE_EXCL command
      https://git.kernel.org/vfs/vfs/c/5c8216e98fc4

