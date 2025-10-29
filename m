Return-Path: <linux-fsdevel+bounces-66164-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 76AC7C17E64
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 02:27:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 672794E9B59
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 01:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1C492DA75C;
	Wed, 29 Oct 2025 01:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F7dV5Lpd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 020C926B77D;
	Wed, 29 Oct 2025 01:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761701233; cv=none; b=ILLEeYXdm6aF+wefdxJE5gfeEGj0kwVpX78sen6x809PXYE7YhfqHfD9AWqyAzxjZSvmBDDFVIUg4E2VoGWh9FYM8Apl927Y6I3PZfgGOxr0cWvgIJdMI9veleeTs891rROfq3sVpEq0Rm1ZBf6rZ/WEGCnD6c8k9BlAWgs4hMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761701233; c=relaxed/simple;
	bh=fgS8DdeOIPEtBO8mbTuzeWkNUjC8RXn7GH0I8jIGHL4=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FuGtx79BrMAszE2ExswROjpfvZEtwXcKeF4tv2XD/GzEWKzNCFh5Di7C2P8ke1VkRWuMxfFThgt7vbP/tADN6LsXDUl/QbHi9opYwWS/5ThFfqvEj7ipEvYzcXfSZyJubouc9w0T1BBV/TbcQng8OhDb1/vjbcYlDhZivGq0r0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F7dV5Lpd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75F8FC4CEE7;
	Wed, 29 Oct 2025 01:27:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761701232;
	bh=fgS8DdeOIPEtBO8mbTuzeWkNUjC8RXn7GH0I8jIGHL4=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=F7dV5LpdiSAfsVT/eZcBQ/t92yiXXmSyh4Rrm0hRzFx5iI7b66/v6jFczQEEIqpP2
	 qiU6PDFVjE6K4D0FC3VGnUIvB58P5BkamqzZ31Q6BHil5tUThT0GXGhrPOP+cCt4c0
	 eFMFkWhy2AJ4y6hVQFbfOgtCdjlLAzZfsNptC3Ymm2nCjOKdi0gJH60IkRdWiYprPm
	 X+5sLf1IX0PB3P3IVs9/5NGKNyb8dyNubkfaI1Wlbl1IuubbMc4NaVzwMFGkkdZGlF
	 L7vA/A+sqGM+HqPusmkayO/ZVG+aFY9eXvLKAQX/mNFz6yMHjYoN0xMbIF7TMQ0dXu
	 UnbqDGV1h5dlA==
Date: Tue, 28 Oct 2025 18:27:12 -0700
Subject: [PATCH 26/33] generic/622: check that strictatime/lazytime actually
 work
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, zlang@redhat.com
Cc: neal@gompa.dev, fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, joannelkoong@gmail.com, bernd@bsbernd.com
Message-ID: <176169820461.1433624.4704430685173473309.stgit@frogsfrogsfrogs>
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

Make sure that we can mount with these options before testing their
behaviors.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 tests/generic/622 |    4 ++++
 1 file changed, 4 insertions(+)


diff --git a/tests/generic/622 b/tests/generic/622
index a67931ad877fde..559943d5403805 100755
--- a/tests/generic/622
+++ b/tests/generic/622
@@ -88,6 +88,10 @@ _require_xfs_io_command "syncfs"
 # test that timestamp updates aren't persisted when they shouldn't be.
 
 _scratch_mkfs &>> $seqres.full
+_try_scratch_mount -o strictatime || _notrun "strictatime not supported"
+_scratch_unmount
+_try_scratch_mount -o lazytime || _notrun "lazytime not supported"
+_scratch_unmount
 _scratch_mount
 
 # Create the test file for which we'll update and check the timestamps.


