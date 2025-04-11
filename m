Return-Path: <linux-fsdevel+bounces-46261-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 07ABFA85FDA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Apr 2025 16:01:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FC501783A4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Apr 2025 14:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 420281F1909;
	Fri, 11 Apr 2025 14:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YjOTStuo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C48A198845;
	Fri, 11 Apr 2025 14:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744380062; cv=none; b=e3npR/gpp9SK+Un3/vz5rxn3hIGkK0Cxmo2y4dTpo1ik2C/6G92A8Dod9C5YjUC+5E76/037JGNPl/g6/NqFpymUQX3REBkcTufKobXhc4tHVlm4vyhn/SsXV7j0qRl0wDp0wE/kZ5tICo7wi4lxFtFWsIW0pW9/ziKfNp3M2oQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744380062; c=relaxed/simple;
	bh=7f8FYLo69ndVxvN+7drkLi5nDw1zMVObS8E6TwJKQ54=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bElp25qs0OcD9ePW1K06jjeDqBGXnuMie3cEjQfR6ZPKN6jfaSpqR+YScrRIrwsLmWNOfwIFgdVOBl6LEA1Di8/0r3jfRREFd6DZCSzyYTJKS7HuK1HVHGXni33iqlXvsNlSKNkVbzrCMcuKKHMpEn7Ij2cWh7uisrf/PskNXIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YjOTStuo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F599C4CEE2;
	Fri, 11 Apr 2025 14:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744380062;
	bh=7f8FYLo69ndVxvN+7drkLi5nDw1zMVObS8E6TwJKQ54=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YjOTStuoSBRao9000Y9a+NBaI23xy+zjUoH35q3WBhxlTC2PUrJMtfugNCIFzRS7t
	 c12e5evJb4D7MOA4FUb5whfSeYAKs6/z34T953OWztvzbdwJ3i8qHFAsQ9x95JqHEi
	 18ruz9q2jBRxZkoKd8jPH2FIEafDSU4+87tgbV87xgaJVnlkv6FVTzC63bH2iy39JV
	 HEsVZwoxCIhkBKvh6TfRdyaj7JMLGbCTNKwPHEB0hPaOfckA/ONq2XqMJI25aWofwC
	 UKO2fgbHf58I24Qio2QCfaT/qaB5rooDI+0srVNaUVHcHRcEyvR0F1gce+1inVdRzv
	 GZj/Tw2m5RQ0A==
From: Christian Brauner <brauner@kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Song Liu <song@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	viro@zeniv.linux.org.uk,
	jack@suse.cz,
	kernel-team@meta.com,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: Re: [PATCH] fs: Fix filename init after recent refactoring
Date: Fri, 11 Apr 2025 16:00:55 +0200
Message-ID: <20250411-eisen-mitsingen-5885da4bce28@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250409220534.3635801-1-song@kernel.org>
References: <20250409220534.3635801-1-song@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1023; i=brauner@kernel.org; h=from:subject:message-id; bh=7f8FYLo69ndVxvN+7drkLi5nDw1zMVObS8E6TwJKQ54=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaT/VJjRtWvBncvlZkGctizLErrcndujj11frHOw0flSV E9+p1RxRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwETcbzH8lfh+1Te/8VPo6ocf K9dPuqWlMadse1rh1w7XeCWzGTXPHjMy/OCpFFyRXr/WdtPVqrQXrIcMvK8/ZomZ1ubCeHNXSkU hAwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Wed, 09 Apr 2025 15:05:34 -0700, Song Liu wrote:
> getname_flags() should save __user pointer "filename" in filename->uptr.
> However, this logic is broken by a recent refactoring. Fix it by passing
> __user pointer filename to helper initname().
> 
> 

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

[1/1] fs: Fix filename init after recent refactoring
      https://git.kernel.org/vfs/vfs/c/b463d7fd118b

