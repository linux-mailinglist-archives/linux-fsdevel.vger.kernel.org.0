Return-Path: <linux-fsdevel+bounces-44591-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D30D4A6A839
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 15:18:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EE398A4E96
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 14:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C56E322333B;
	Thu, 20 Mar 2025 14:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c+24EFHJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B00F22157F;
	Thu, 20 Mar 2025 14:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742480226; cv=none; b=HUABtOvAG3bCLBUcVqaoZSYJb7cRWxuHsgXErcVnoqoHZU9du5Z44UggikmoxNRMl+9lg0JCp3Sx4xa6HIpJxdcjgk2M8RFNLawdBNOy1WRovMRAlCvGkqF/NUlCmA7yGII9+lI4DNfT3yMRdSS0eVz8eDySVZq01+UAXmROrRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742480226; c=relaxed/simple;
	bh=EjjKERzL9oRudkewhdPf4Dc/ASPKyLKPzJYZKd4P92U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Dak1c+QyFhmXs+xoe/WF3LvtW4bui9iFYagyX2LiFM4uNEumxyLGAW5nw/2p6G7piZDxNML2bEkH5KXXZbCnpuxOdGWVNKqedCxi4FJRWS/44dTlDDDAEY671C1EQQ0xgZIs1rK7hVxvtVa0hSQ3jqKUEbttP9tb0udY4AKIlgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c+24EFHJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C873C4CEDD;
	Thu, 20 Mar 2025 14:17:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742480225;
	bh=EjjKERzL9oRudkewhdPf4Dc/ASPKyLKPzJYZKd4P92U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c+24EFHJ04X18330vNb0qvQVQclTR51gvmZhx6dCiNEg2GMog2RB+E9oFoujVqvrZ
	 LeYq+0Hy8UGCA2CRXtXx+CybrELjaI3qHoOE6hphTeSrwfxJ0NarRajZEro1L6FTKA
	 OEN79OzpDUc+76vZk/mI+iPCzl44CWK4GKuJfQLc92NqZPPCBF/PhU2kfa8LBQnlFf
	 vOKWPwW5p6feTiikS9vP8LT6DNznx+tH4tXIxqHMGgSRqbgUG8j6Yrj7r7m4e/r5zG
	 x3R/XZxd4JHCXUidFVPs76J8QxPfyAMDZQsR2at66r4ah7VACODMTzqdTvzgmhGRhG
	 Y+uxgO2DH8zmQ==
From: Christian Brauner <brauner@kernel.org>
To: djwong@kernel.org,
	hch@lst.de,
	John Garry <john.g.garry@oracle.com>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	dchinner@redhat.com,
	linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ojaswin@linux.ibm.com,
	ritesh.list@gmail.com,
	martin.petersen@oracle.com,
	tytso@mit.edu,
	linux-ext4@vger.kernel.org
Subject: Re: [PATCH 0/3] further iomap large atomic writes changes
Date: Thu, 20 Mar 2025 15:16:57 +0100
Message-ID: <20250320-unliebsam-uninteressant-341618121b90@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250320120250.4087011-1-john.g.garry@oracle.com>
References: <20250320120250.4087011-1-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1552; i=brauner@kernel.org; h=from:subject:message-id; bh=EjjKERzL9oRudkewhdPf4Dc/ASPKyLKPzJYZKd4P92U=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTfUY42ZJ0Uqvq22KudT+TgNBGXPrb+6WtOPX11wHrtP /E9ly/ldpSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEwk7jgjw90g3VKXcqWbGtIW x0Kz2Y1eGXAs2d92TYsv+uDCTO3FOxn+mW+eumPi5kP380yfX7a8IGMnc2PzsqvF91gMn8VyPwi 1YAAA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Thu, 20 Mar 2025 12:02:47 +0000, John Garry wrote:
> These iomap changes are spun-off the XFS large atomic writes series at
> https://lore.kernel.org/linux-xfs/86a64256-497a-453b-bbba-a5ac6b4cb056@oracle.com/T/#ma99c763221de9d49ea2ccfca9ff9b8d71c8b2677
> 
> The XFS parts there are not ready yet, but it is worth having the iomap
> changes queued in advance.
> 
> Some much earlier changes from that same series were already queued in the
> vfs tree, and these patches rework those changes - specifically the
> first patch in this series does.
> 
> [...]

Applied to the vfs-6.15.iomap branch of the vfs/vfs.git tree.
Patches in the vfs-6.15.iomap branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.15.iomap

[1/3] iomap: inline iomap_dio_bio_opflags()
      https://git.kernel.org/vfs/vfs/c/d279c80e0bac
[2/3] iomap: comment on atomic write checks in iomap_dio_bio_iter()
      https://git.kernel.org/vfs/vfs/c/aacd436e40b0
[3/3] iomap: rework IOMAP atomic flags
      https://git.kernel.org/vfs/vfs/c/370a6de7651b

