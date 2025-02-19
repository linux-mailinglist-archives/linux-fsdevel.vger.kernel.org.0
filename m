Return-Path: <linux-fsdevel+bounces-42086-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78043A3C53D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2025 17:41:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 532A7172C72
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2025 16:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2DB11FECAF;
	Wed, 19 Feb 2025 16:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mc+u4Fy5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 403031F8F09
	for <linux-fsdevel@vger.kernel.org>; Wed, 19 Feb 2025 16:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739983234; cv=none; b=KyMv4g7r6+xUfRhyb00vWWh+5yf4HKrXXkNtYi47cvwbvH8fqX/IDd3dPlmj65JGblcb+VQp97ReX+zYruYZSAkyHklBKAamBOeYeaQZNQNX8xbQvBTDFSMUfZwjB7NyfmlZMtUt3T3y39rO+C7ZVsaQZfopGJRSRarA4xNMrlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739983234; c=relaxed/simple;
	bh=s0P8ZhtIPtgkg4FTrsINrklSChJ3ZFLrJa/rfHzPV4E=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=d1pW2dR+Mjx47q8kTqmrK1zhg8usFp9C7HXVadlxFdr0tIWBpA/KMbIR3fktxZFMhe7LqoAyLx/rDeVtqxW8x31RvvXz7vGi4mLfjDYY4RQPS2e99i0Oh26oaS5e2h79mOUzd0a6hsGI+HkNJCZ8UFmxO9gI9tuRt8lru6nGe70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mc+u4Fy5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DA76C4CED1;
	Wed, 19 Feb 2025 16:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739983233;
	bh=s0P8ZhtIPtgkg4FTrsINrklSChJ3ZFLrJa/rfHzPV4E=;
	h=From:Subject:Date:To:Cc:From;
	b=mc+u4Fy5T1ED9H2RR7oOgeOBTDepxM83l3sDzVyr/gjbkQmWUqTaArKU6c3CySKaK
	 mYVE8PaNWHCPeR9CaVJ8NT/aDDf5IAnFBlcylYrhTZ0LZBmt+4jsmFRfoohsxjGgML
	 fJnk42+vix9/6NBT/jwtTH7ZTBgRBvNP9VhKK8ae5Eemylt3MgaFNRc3Ox6hs6uNkb
	 PEqpc5SgXLmo7lMlHtchTgYduah5A64lodzNhFsRvTN1rWFDmF0fG/wmm6Uhan7N9j
	 KRhZCsTuURD3BDEO9MD3B4/pUaq2lgKZ7fPy3ZXl5YfLjbiLS/QSnQUpkD8UTT7ScH
	 HfW9QGDh9eUpg==
From: Christian Brauner <brauner@kernel.org>
Subject: [PATCH 0/2] nsfs: validate ioctls
Date: Wed, 19 Feb 2025 17:40:27 +0100
Message-Id: <20250219-work-nsfs-v1-0-21128d73c5e8@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHsJtmcC/x3M0Q6CMAxA0V8hfbZkm6jgrxgfRlekMQ7SGjQh/
 LvDx5Pc3BWMVdjgWq2gvIjJlAv8oQIaY34wSiqG4MLJBd/hZ9InZhsM6RJS27rU0ZGh9LPyIN/
 /63Yv7qMx9hozjfvhFe3NWi/n2jeo5GHbfohAtCJ+AAAA
X-Change-ID: 20250219-work-nsfs-c72d880d9c3e
To: linux-fsdevel@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>, Jann Horn <jannh@google.com>, 
 Josef Bacik <josef@toxicpanda.com>, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-d23a9
X-Developer-Signature: v=1; a=openpgp-sha256; l=539; i=brauner@kernel.org;
 h=from:subject:message-id; bh=s0P8ZhtIPtgkg4FTrsINrklSChJ3ZFLrJa/rfHzPV4E=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRv42xgNOF8kVpy9cYTb4vQLU+zn3wLOjRj9eKo3MIU4
 RDf5eVLO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACZyLZOR4fnXopvT11k/fHH1
 WXS4e1BrwK/tM0+4GcV+O911mLXjWwgjwwxFe/WKUtbXRz87vvl6dNq/ELmSK8bXUr2ev93l2by
 8gQ8A
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

This series ensures that nsfs protects against ioctl overloading.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
Christian Brauner (2):
      nsfs: validate ioctls
      selftests/nsfs: add ioctl validation tests

 fs/nsfs.c                                          | 32 +++++++++++++++++++++-
 .../selftests/filesystems/nsfs/iterate_mntns.c     | 14 ++++++++++
 2 files changed, 45 insertions(+), 1 deletion(-)
---
base-commit: 2014c95afecee3e76ca4a56956a936e23283f05b
change-id: 20250219-work-nsfs-c72d880d9c3e


