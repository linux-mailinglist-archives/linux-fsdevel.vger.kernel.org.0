Return-Path: <linux-fsdevel+bounces-10495-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D632184BA80
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 17:02:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14EF71C21712
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 16:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99714134CC2;
	Tue,  6 Feb 2024 16:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fCpEMbDi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF9B4134740;
	Tue,  6 Feb 2024 16:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707235344; cv=none; b=GvjGe9ULYeceHgdzC/LDMnVV1paNKRbcVEVoG+AB9F7vCgHOo0LmIhhwsHzFc8UYKpZN0tPEmcFg79TzOT6I0aR/QjbpVTl1biBeoc0jeKFBTQwuNeoI6fkiGuY/Qu94oTXKyg5PqLIOBS3DL0Gq0bLH/9JwXmsqnK4nVS/kwEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707235344; c=relaxed/simple;
	bh=QLHhOtWgAs579ZjWty91yurB52/jlSKpmA4+KsrgH7c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iYSawIAeItCPo5Uz8gWdHI0RfciBHejFaWOf2XBTlqN3V3JtWYeiuwFq2c1zIAhv0b74KpUCjjNBGXqyJBJ0mmtfXj3WCM7CRz/bL5KcCKeJzmqKti/0s0MhERzyzmCm61H9PeqoVET6TmcPOmu9iVE4ZsHBen7CT9RQs8YIKZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fCpEMbDi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B7C9C433C7;
	Tue,  6 Feb 2024 16:02:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707235343;
	bh=QLHhOtWgAs579ZjWty91yurB52/jlSKpmA4+KsrgH7c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fCpEMbDiqUEoieJHOkanavtdpm8qSoyxYmkDuFyaUpA12UdmVu8N+mkwilHDCohuq
	 hYaLRLC03ghQNSsDT57MgO54zqXYI4PAyrSx2LPRLr55iFqs/7vNquE9Gf6zA78tQ9
	 xb30GPsuobAHW97cg9y8KYAWNGA2RLXk8ER9UiTW/e9MOJ+5oatK9CIoye0IyZtLb4
	 E82PjBfk7MNECRU7fdcwyYv2ZfOouyniZdbCmEEqmz9bV7m0UyC8XLz7zWJZVkos7S
	 wvkKyaQQIC1z80GTaI/EmhC8Vjzf+EIr8zrzetFPpPHAGkETBIewUHnu+iJXfoS3pC
	 ZR85u0JPQ357g==
From: Christian Brauner <brauner@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Stefan Berger <stefanb@linux.ibm.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	linux-unionfs@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/2] Decomplicate file_dentry()
Date: Tue,  6 Feb 2024 17:02:15 +0100
Message-ID: <20240206-drehmoment-halbjahr-2dfba68b41e6@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240202110132.1584111-1-amir73il@gmail.com>
References: <20240202110132.1584111-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1338; i=brauner@kernel.org; h=from:subject:message-id; bh=QLHhOtWgAs579ZjWty91yurB52/jlSKpmA4+KsrgH7c=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQeiuB42vCdRY/FLSPv/WXRbXVbTmyevP/cRY4Vr38cf HDouJGvVEcpC4MYF4OsmCKLQ7tJuNxynorNRpkaMHNYmUCGMHBxCsBEJvAzMtx67t25U7NcSHPe PDfHLRoCB3odmOY2btBMOWTBzWmtpsXI8PgAFxPzs3L/oOMzcyQ8cj53tTyTv3DYfGtGz9dIQeF ABgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Fri, 02 Feb 2024 13:01:30 +0200, Amir Goldstein wrote:
> Miklos,
> 
> When posting the patches for file_user_path(), I wrote [1]:
> 
> "This change already makes file_dentry() moot, but for now we did not
>  change this helper just added a WARN_ON() in ovl_d_real() to catch if we
>  have made any wrong assumptions.
> 
> [...]

Applied. Let me know in case this needs to go somewhere else.
Added the enum change as discussed. Please double check ofc.

---

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

[1/2] fs: make file_dentry() a simple accessor
      https://git.kernel.org/vfs/vfs/c/c6c14f926fbe
[2/2] fs: remove the inode argument to ->d_real() method
      https://git.kernel.org/vfs/vfs/c/2109cc619e73

