Return-Path: <linux-fsdevel+bounces-21748-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E432909631
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Jun 2024 07:36:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACA742845E1
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Jun 2024 05:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 234AF15AC4;
	Sat, 15 Jun 2024 05:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pKttWYCN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D9719D8A1;
	Sat, 15 Jun 2024 05:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718429753; cv=none; b=eh5M4ccLuKsFfSc0Iq1MCvfk5xfbzXmExIUzY1X1YHBTBTDTaoum5hD9BN7zmvNlrPRExvvOF1polhNo62VzyguBsqJ3q8NUj4LM8l+QzASBhwlOb5Lxyz637sl6CUN6cZ5EcewtIRUTrgbV1B65r3G7dtQfgD9gP0jR7zmScrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718429753; c=relaxed/simple;
	bh=jxLbk5ssxSIp8RBgGpLgzWuKu/Z2z1NW57KUbzwdFn8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lgcHg0d4fNvodIZqac5n6TZLdkVIFPKyF8jCCK1GSB/+wEhHRJbm/0rP64YN1twdD1h++KjrOsjD1nz/IdRJAskhl57wLVB10ZQAfM8QZkCFbhkY8sB76m0OnA4v0wHQYJ+D63XRjsr4SoKFVgqzoe8VpEwn/Qgblxtx4/ewcwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pKttWYCN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 818CBC116B1;
	Sat, 15 Jun 2024 05:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718429752;
	bh=jxLbk5ssxSIp8RBgGpLgzWuKu/Z2z1NW57KUbzwdFn8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pKttWYCN/pUPUveq/A1j08MIgS3wbfwxlzfOxUxEVLMOxU9ArsfpifapFYgSvrBtr
	 HRpxilA9p2X7UPjn2xHc4YNTFdpu1cXGL9R4paW9ZmjApMSqFspVIsARYQXXGgeFjD
	 1TfKi6mjQ4BBO1N0yuMzNn1ynyvUfYhM1iVMWDIS55aTh9EdinvuV4SOedq7AtMCLO
	 aI+8SM3iDTJl9f4bB/Csv2NzD1SbreI0IyL3tBGOEh6F3m2osFCXA6rsYq551T9d6I
	 /qUSQIBUrrcUujoicn4KTFkde/PDSDC/RFaKX2XpebKCVGpD5Pn9SGZyBjxVwuZ3j/
	 bonNOOCi0t8DA==
From: Christian Brauner <brauner@kernel.org>
To: NeilBrown <neilb@suse.de>
Cc: Christian Brauner <brauner@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	James Clark <james.clark@arm.com>,
	ltp@lists.linux.it,
	linux-nfs@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	linux-fsdevel@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>
Subject: Re: [PATCH v2] VFS: generate FS_CREATE before FS_OPEN when ->atomic_open used.
Date: Sat, 15 Jun 2024 07:35:42 +0200
Message-ID: <20240615-fahrrad-bauordnung-a349bacd8c82@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <171817619547.14261.975798725161704336@noble.neil.brown.name>
References: <171817619547.14261.975798725161704336@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1211; i=brauner@kernel.org; h=from:subject:message-id; bh=jxLbk5ssxSIp8RBgGpLgzWuKu/Z2z1NW57KUbzwdFn8=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTlaui7Z7UWvdDqnn7iRLrEn1dzbBaeiVge9D192wPPy fVzijicO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACYydSrDH9570xOtKlkXiOwL mHbwo05CvMfuWI3PW2YeubAwTSzDnZPhf1r6ll/vNNsKE9673tk2Z9mlrZp11rOebCysPOthWhU cyw4A
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Wed, 12 Jun 2024 17:09:55 +1000, NeilBrown wrote:
> When a file is opened and created with open(..., O_CREAT) we get
> both the CREATE and OPEN fsnotify events and would expect them in that
> order.   For most filesystems we get them in that order because
> open_last_lookups() calls fsnofify_create() and then do_open() (from
> path_openat()) calls vfs_open()->do_dentry_open() which calls
> fsnotify_open().
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

[1/1] VFS: generate FS_CREATE before FS_OPEN when ->atomic_open used.
      https://git.kernel.org/vfs/vfs/c/7536b2f06724

