Return-Path: <linux-fsdevel+bounces-46900-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DB28A96017
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 09:55:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84E0D168236
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 07:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B95751EEA4B;
	Tue, 22 Apr 2025 07:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bj1l5Hov"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F6E2126C13;
	Tue, 22 Apr 2025 07:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745308502; cv=none; b=g7/FnKDAJO8bA3r2um5Alzelu1wlcyAOE4LOvBu8jMoxDRuXp5F2ZzsxOmVhDcFZCvTKjf6l7u6ohKFsXwG5XmQCBuMRRwWUbU0XAitsiM6ckw3Mj9nKYH2LbimvoK7vEXhl2OVuMQlTgYBhgc494fZ3jGqKr5U1OCGUjf0V1Wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745308502; c=relaxed/simple;
	bh=chyqnlDWW0dRr2gowZEpFJkOEAZmSNAc2Ixe6na7bUw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YrcbS2S9IhY9OXn0frF3I/Y3mn93jz/LYwy9ERt3pTCpmhyFtRD9aYB6nkYMzmP64q2x9eYzoR4wAyqwK+myhOl4DJfKCtdRNzr0IhazXQHwds3XBI9exmA/+2ypXqAjZwvXTnH1uoyxrXGsLRMfn5c0KxhFmgh30Ccj6yR6x2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bj1l5Hov; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAC7CC4CEE9;
	Tue, 22 Apr 2025 07:54:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745308501;
	bh=chyqnlDWW0dRr2gowZEpFJkOEAZmSNAc2Ixe6na7bUw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Bj1l5HovBawMUnBvNIJLr3BB/t4xT+DZ0x0YqT693ddDK3XxtcKCI1HILzcL9hIYR
	 yyfHE2fkqL1SBXxzE1kJmYHODf0P3XWXjeGLziJDTer+m8y4SV2oGPFV62WXDQKDNi
	 keyowYxNpksk5IjjaFTKV1ecWPZK/FYKIDgWAWUvMabCHSqNvVmn0H6l7mKNKP936E
	 Xa4ShGpk+jZptiPa4WZWJttbYci3VidAvKCG3J4P01s9mMNlgs/K2kq6Kd/mcI/+nk
	 pojjeU9HOBKZE4KSdh57CQx0+E0uASU3+Y74LnozjVHpmsL3+FktUj7ismzFbyz8/J
	 mdJHQVXwn7ShQ==
From: Christian Brauner <brauner@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	kernel test robot <oliver.sang@intel.com>
Subject: Re: [PATCH v2] fs: fall back to file_ref_put() for non-last reference
Date: Tue, 22 Apr 2025 09:54:53 +0200
Message-ID: <20250422-gaspedal-rabiat-d4ef5f41b2b1@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250418125756.59677-1-mjguzik@gmail.com>
References: <20250418125756.59677-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=957; i=brauner@kernel.org; h=from:subject:message-id; bh=chyqnlDWW0dRr2gowZEpFJkOEAZmSNAc2Ixe6na7bUw=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSwe/s7eKsvPTJfjetB4AWdiAntap13GzVdRSden/Jri 42uIoNQRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwEQKpRkZTh0NPh48Zbf58r1z JnZuvnv3Gm/bfYuXE5rEHWuZExm8bzAyfFAR0i87tvPQlFRnYR29HR9YNoUbWhtyaXUx/lD9dfI KOwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Fri, 18 Apr 2025 14:57:56 +0200, Mateusz Guzik wrote:
> This reduces the slowdown in face of multiple callers issuing close on
> what turns out to not be the last reference.
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

[1/1] fs: fall back to file_ref_put() for non-last reference
      https://git.kernel.org/vfs/vfs/c/ca38ac96d96b

