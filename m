Return-Path: <linux-fsdevel+bounces-66153-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F38CC17E67
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 02:27:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BA8E1C667AB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 01:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1985F2D9EEA;
	Wed, 29 Oct 2025 01:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E/XbGWnI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E77717B50F;
	Wed, 29 Oct 2025 01:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761701061; cv=none; b=bFNWnhKNX8Q+n5bY96PTY4pw7S8XyV4z+1aGmlRVHdTJwT5OnFPJ+hh0zVdmt57sq190+gLTL170uDeUnEit4rZqYzg+XIfMODbwjTyOOwELuWyebiiMmEIv/iuizdatHmRJungm/1LVoRa6h2f1cqwtO5f1wWQb043pa8pVGQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761701061; c=relaxed/simple;
	bh=s0SV22hxRysCVaRGoIPt7eGqJoOwKZU0ja8VlldLXwg=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u/5bVRdDRsEYEu0AzU+4T4ejGdYEAft+4wELmwc1sUtTwMgZRPs80uhi0XYf9FOjrSr6bUgH8BpR8nwvBxb+SqugaKUMFNed89CPINtCUlLp8R964U9fQYCS7rpj8wX0GT/1Zf9OpqgfpRT0U46JzVDNwdBQucVHJNwm8p+Gpw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E/XbGWnI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA9D0C4CEE7;
	Wed, 29 Oct 2025 01:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761701060;
	bh=s0SV22hxRysCVaRGoIPt7eGqJoOwKZU0ja8VlldLXwg=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=E/XbGWnI0zce/UD6duKjgoNR+SZPoDlhczcHDvfbUpuGV/lIAMU57JDQW0UWBvBfi
	 8i5iz/U8ytSZ1WulXvcI9B0NPlh5IEAby7gXIYg1qoR1j0Fdz+oUGpkh3UxnN0Tn+Z
	 wjXkRAlbY/o2WbxKCc4Ni75GO4GINw4HQJRWZZpyRgC2ZEOibu3CdJpoVtxVDTObRY
	 31WWTSi/4JM45s4Cf3Djh1xLx0BOEqmmCJMF889olkkts62lo7M7jb5eSKrWiAn94S
	 G4PMGj38jhvOv0qBbVo6NOukAD6gUtx2TdPxq5E5Bz4uN0k+ZrkeOPiqy9Giy1Ns92
	 8vjD1PYUATJ7w==
Date: Tue, 28 Oct 2025 18:24:20 -0700
Subject: [PATCH 15/33] ext4/004: disable for fuse2fs
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, zlang@redhat.com
Cc: neal@gompa.dev, fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, joannelkoong@gmail.com, bernd@bsbernd.com
Message-ID: <176169820258.1433624.14728258961127788504.stgit@frogsfrogsfrogs>
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

fuse2fs doesn't support dump and restore, so skip this test.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 tests/ext4/004 |    2 ++
 1 file changed, 2 insertions(+)


diff --git a/tests/ext4/004 b/tests/ext4/004
index 4e6c4a75f60175..1586265d6bebb5 100755
--- a/tests/ext4/004
+++ b/tests/ext4/004
@@ -45,6 +45,8 @@ workout()
 
 _exclude_fs ext2
 _exclude_fs ext3
+# dump/restore not supported by fuse2fs
+_exclude_fs fuse.ext[234]
 
 _require_test
 _require_scratch


