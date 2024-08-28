Return-Path: <linux-fsdevel+bounces-27565-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6DCA962670
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 13:56:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A57D32835BF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 11:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC26217166E;
	Wed, 28 Aug 2024 11:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="in6SYVIE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 369C414A4D6;
	Wed, 28 Aug 2024 11:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724846200; cv=none; b=RntI+fogDOGxtTVEZc4gzMkR7G8tS4p6Q/2Fc2TOYp4OtdMQOMhcsY0jx4XVdCDwccs/xhIbJsb5haDm28bf5PpUWCbhosgJYK//3sC0146YS1kkXnr2v6h2Iyl3UwxlfHAhRZqqzRJaPF5DH9laMu1gAufnHi8uDCAqzEcCZzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724846200; c=relaxed/simple;
	bh=o/x43QyAFuBKLjQeSbCZYiPg/EBcEZ7K3ni3oeBZtcc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Li+B5g6cwVMhwpy1XKevikWthVo8d8Cg2hJasweu6SPlR0AjRAkSizkQP1jpAzbh5nShfE68VEMINDi9J+Er/JOXrlKukgsChtdIcqTceCtvF3xjlVlMynmBYELZlfPOFYXkNbK93/zhVwmHn1EomNqRZMbGDnSNhLE80sFA8Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=in6SYVIE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9042CC98EC4;
	Wed, 28 Aug 2024 11:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724846199;
	bh=o/x43QyAFuBKLjQeSbCZYiPg/EBcEZ7K3ni3oeBZtcc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=in6SYVIE3hOp/7QxRmJc4ZpvUl6UF78kWEKVR99dLnKXqKLvoaADn4i0t/CHfzWfx
	 Kgzr48j09UmCNI0NFmgnHwoEHT40bWttNznGrayzLodjQQD5vCjK+ya5RQp5uc/rWh
	 zLrsFV1uptGpxVVzEnOvfQRxP/ZBdYm3kx5AfjFgIRCe5p8LxwXbVdNEZub1evpg0j
	 x5efZNNJGrSPMdYNbOSIwgq0OgN9XcfXPyk2BpHQXC+jsFEb9xzjnKAielbE9rYbg1
	 ORJ+4C3izqfC54VJLWMiozqw9p4Oj8MBYxjh442XWFuaO+UOqSOVYne3fypK8B+P30
	 kB4c9CPl030Yw==
From: Christian Brauner <brauner@kernel.org>
To: Yu Jiaoliang <yujiaoliang@vivo.com>
Cc: Christian Brauner <brauner@kernel.org>,
	opensource.kernel@vivo.com,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Seth Forshee <sforshee@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mnt_idmapping: Use kmemdup_array instead of kmemdup for multiple allocation
Date: Wed, 28 Aug 2024 13:56:23 +0200
Message-ID: <20240828-heizung-august-f14076473669@brauner>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240823015542.3006262-1-yujiaoliang@vivo.com>
References: <20240823015542.3006262-1-yujiaoliang@vivo.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=990; i=brauner@kernel.org; h=from:subject:message-id; bh=o/x43QyAFuBKLjQeSbCZYiPg/EBcEZ7K3ni3oeBZtcc=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSdFyiYnOP5pKyCJdxDLimRpfam156K/KDC7Tt/aK1Qf pj+202jo5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCKL6xn+WSufvXP7deSth2Gf WG1Z7Wc8sWDcvqlCZrXghP/nX5r+OM3IsLrhmkyPu1zZY/XA54FyQe+nXxE5Z1t5WUEi0oM3wdi cAQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Fri, 23 Aug 2024 09:55:41 +0800, Yu Jiaoliang wrote:
> Let the kememdup_array() take care about multiplication and possible
> overflows.
> 
> v2:Add a new modification for reverse array.
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

[1/1] mnt_idmapping: Use kmemdup_array instead of kmemdup for multiple allocation
      https://git.kernel.org/vfs/vfs/c/639639c8ce66

