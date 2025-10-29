Return-Path: <linux-fsdevel+bounces-66163-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DBF5C17EAC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 02:30:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A2791890C21
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 01:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8C561B983F;
	Wed, 29 Oct 2025 01:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nUV47oh5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6022D7D2F;
	Wed, 29 Oct 2025 01:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761701217; cv=none; b=eIsarq+Vhwsj/bP15UWBs8YafQrv/cDxw9Gc3vIQoeAiE0T2uDoAgYD7TUqLaBZsIFXpHU9p8ngXQwvnb2PFGty/Q2rlGHy1BuxzALkX57YWIvBxUz7BdtB1YDMZLOomdrCoWxkUhS4EJxNSV2D/V6BedftTjD3RVGE/5BTB7IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761701217; c=relaxed/simple;
	bh=sF/WMkmxIjUjxjyEM06cGd64xKHP7iIsYRCFiudwWtY=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GeLluGwVayc04JFSDGFqAcSgRkepIRE9KUb5A/crJU93vbI0pFRpeYc3fL32jLDIoyREjypBBwTNbs8iOzpGxjbcov9Yq7Rd6Z0tcYazNG7PL69qvriXX3h12xzS9GtAAdzaJXLHKy1NvRhssy82366SH6V4JMhOOod+V75QHwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nUV47oh5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB5AEC4CEE7;
	Wed, 29 Oct 2025 01:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761701216;
	bh=sF/WMkmxIjUjxjyEM06cGd64xKHP7iIsYRCFiudwWtY=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=nUV47oh5TK+bjnLWfY22OoArEnsanZXT/f2ZXTC4ZpXaOpVEZDQD7lhmHaHKfsoHg
	 u1vBbsba2CSUr7JvgkIf7UaLs1D35XJ8+xfOeDt1pT82C9PncYsD/0uCFVWA0enyH8
	 XuQudM9jMXfCdxBKNZqkECve05JxDi/tFaREwH6TwNKD+icgAc7vvPgwrpZR1P7bk5
	 GKqVaswbVlwYl8hf9jLZ5ihyMdkOkRxAt6qEGjE39ukCdjpukfoimKOZmOCHClm0WD
	 +WwEfmMkuHzMSDE9dWKoq+5ILjhAE+wGPsDnEIBTJznFWiDv8v9VyawSQZQASeX1Ku
	 i49oU902LMXVQ==
Date: Tue, 28 Oct 2025 18:26:56 -0700
Subject: [PATCH 25/33] ext4/001: check for fiemap support
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, zlang@redhat.com
Cc: neal@gompa.dev, fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, joannelkoong@gmail.com, bernd@bsbernd.com
Message-ID: <176169820443.1433624.1207652848964687224.stgit@frogsfrogsfrogs>
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

fuse2fs only supports fiemap in iomap mode, so disable this test when
it's present.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 tests/ext4/001 |    1 +
 1 file changed, 1 insertion(+)


diff --git a/tests/ext4/001 b/tests/ext4/001
index 1990746aa58764..1ec35a76ea8721 100755
--- a/tests/ext4/001
+++ b/tests/ext4/001
@@ -19,6 +19,7 @@ _exclude_fs ext3
 
 _require_xfs_io_command "falloc"
 _require_xfs_io_command "fzero"
+_require_xfs_io_command "fiemap"
 _require_test
 
 # Select appropriate golden output based on mount options


