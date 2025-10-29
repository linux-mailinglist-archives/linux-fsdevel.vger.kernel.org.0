Return-Path: <linux-fsdevel+bounces-66144-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 71988C17E1F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 02:25:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1DFC188B702
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 01:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DE612DA74C;
	Wed, 29 Oct 2025 01:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tgRaCzZ8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82BDA2C1583;
	Wed, 29 Oct 2025 01:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761700920; cv=none; b=tB5GXGPchCKCakLa88eGklYZ5z76ggQ4CpBHeO+zX6R/hj3491x7VJbQVr6MJX1vZXATWx0LFf/pRE50MEuQgfnUjC701H41GvWoemq9/GkqFUBTbs2Ek6Byb/uDiWg+CPqlAjjX4tE+gTTlL1yUGck89mw2x3H6nMZOl+1jWSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761700920; c=relaxed/simple;
	bh=POwHJMH4vbWnUVyq+ZO49NylqjGlzFf0i/Ve0Lr/+XU=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rKX5PJhaQLf5HgjJPuPosfFGVGvSKF3v6TrrH0PcIQz3W29is53M05NUkdy9oYj1cWdSfrf0zg/w6LMmVfslCDeSk7VxI2h3YSZAxaw4UpR4PXW4Kmi5EMLSdxMmp977s9HDKfReQjadZlOCp/Ue6B/NCl4nBYofLea5HUU8axg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tgRaCzZ8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B71CC4CEE7;
	Wed, 29 Oct 2025 01:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761700920;
	bh=POwHJMH4vbWnUVyq+ZO49NylqjGlzFf0i/Ve0Lr/+XU=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=tgRaCzZ85BGUlYJhGy/2jGFaEm0bOVLFEBtFfEHeuaGUE+CceDoN7xaz/dc8Y/qg7
	 wWHVCHKaJ9aShfwTce2h4tgnF0QCf4/1GMH6PgzM3TiQTo48Cmewg4qz5NrqrADl7t
	 a222o4oBcj3k3SdTCkOzHMU9ofxw1WJW58LHZoHrq8QNtwusbjsIeBRM7JMFUjNFTc
	 uboeSYTy0aEQpJnQ6HGuaWbZtz0kPHU2s3BFElF4VltK+l5u0pTZsi6KLoYPaIsWZ1
	 pDcJHhjJPRAyHzR08KRrkMuaK/3zBM67CmtCOVtV+PR4ZjicryAKwJMkTaPmW5U9d0
	 pgqqKVjqecRPg==
Date: Tue, 28 Oct 2025 18:21:59 -0700
Subject: [PATCH 06/33] ext/039: require metadata journalling
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, zlang@redhat.com
Cc: neal@gompa.dev, fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, joannelkoong@gmail.com, bernd@bsbernd.com
Message-ID: <176169820088.1433624.4290433487550917700.stgit@frogsfrogsfrogs>
In-Reply-To: <176169819804.1433624.11241650941850700038.stgit@frogsfrogsfrogs>
References: <176169819804.1433624.11241650941850700038.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Skip this test in nojournal mode.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 tests/ext4/039 |    1 +
 1 file changed, 1 insertion(+)


diff --git a/tests/ext4/039 b/tests/ext4/039
index 2e99c8ff9ffd03..9d46bea8da1956 100755
--- a/tests/ext4/039
+++ b/tests/ext4/039
@@ -60,6 +60,7 @@ _exclude_fs ext2
 
 _require_scratch
 _exclude_scratch_mount_option dax
+_require_metadata_journaling $SCRATCH_DEV
 
 _scratch_mkfs_sized $((64 * 1024 * 1024)) >> $seqres.full 2>&1
 _scratch_mount


