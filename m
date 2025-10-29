Return-Path: <linux-fsdevel+bounces-66087-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AC04C17C2C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 02:08:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EF6D1AA441C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 01:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FF412D8365;
	Wed, 29 Oct 2025 01:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dFsHpNG3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA2B2261B60;
	Wed, 29 Oct 2025 01:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761700029; cv=none; b=uctYEA58XbCFTYsUygvqikB6FQtcV+dkxLwQKjpPZEvyfZ2b7KlmXJcBQeTjKHthKTdFzBVDLcVXF6YZjR3iz4s7MQiIqM2qCCs2QseNbzfYPB/XGECEXImwlcM02pK+9bgpI/YNjIrl0yPlf0+4fiI7+696qB7lfCjkL51HUxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761700029; c=relaxed/simple;
	bh=8mIyBNUJXw/imiF8CLIAoabHwffb1ugz+ZwQNBNXts0=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X5iTlhuKG+0OjPDM7vNnQsnmTWMWZ98izVot/iEDUKudi1eBbezbI6xV6cUo8GYDSPxgrHV2xnd//kJ2hXaPELVTZeaSQQgBU1IP6Jua4SSUzMd+RFO0oJMPwKL4Yv9BFZbaZPi0veU/NobG4eGaP5O3zA0CTAHu4dFzQrOgEgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dFsHpNG3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10C76C4CEE7;
	Wed, 29 Oct 2025 01:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761700028;
	bh=8mIyBNUJXw/imiF8CLIAoabHwffb1ugz+ZwQNBNXts0=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=dFsHpNG3hYLgt/sK8Y3UMT8erDJ+isUMXLs4AUJ/ST2JYWOlMMUbAwE3Lat1oEp9H
	 uO6KU2RCaM3jzU3ls4VlcYrJ25IgPcoxQDL/zsXl3Sc5GObcIPCNSyyfIR5FIIUtTZ
	 MJoQ2+ZAH4lIk7H/w1eBXAnuXqx3tdCYiPulUZyr/TA3q/nfP6s7bjgJxxmdKfoRnT
	 jLTj/xeGcDa5ffkKp4QTZLGDR+sHaLlatqE9Yz57UsoW1VcpuOAviXkPZuRnyxEb2p
	 a+78i38PNzIgb3iaBfd5mvgUgFRAs9v52y6ywVAjVfA2yygxipAryos6iPCb+bKWSZ
	 Amd3poVqxAxmQ==
Date: Tue, 28 Oct 2025 18:07:07 -0700
Subject: [PATCH 3/3] libfuse: enable iomap
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bschubert@ddn.com
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 bernd@bsbernd.com, miklos@szeredi.hu, joannelkoong@gmail.com, neal@gompa.dev
Message-ID: <176169814634.1428599.1511993801717365415.stgit@frogsfrogsfrogs>
In-Reply-To: <176169814570.1428599.1070273812934230095.stgit@frogsfrogsfrogs>
References: <176169814570.1428599.1070273812934230095.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Remove the guard that we used to avoid bisection problems.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 lib/fuse_lowlevel.c |    2 --
 1 file changed, 2 deletions(-)


diff --git a/lib/fuse_lowlevel.c b/lib/fuse_lowlevel.c
index 00f8f1b6035df4..7eaa8e51f50129 100644
--- a/lib/fuse_lowlevel.c
+++ b/lib/fuse_lowlevel.c
@@ -3111,8 +3111,6 @@ _do_init(fuse_req_t req, const fuse_ino_t nodeid, const void *op_in,
 			se->conn.capable_ext |= FUSE_CAP_OVER_IO_URING;
 		if (inargflags & FUSE_IOMAP)
 			se->conn.capable_ext |= FUSE_CAP_IOMAP;
-		/* Don't let anyone touch iomap until the end of the patchset. */
-		se->conn.capable_ext &= ~FUSE_CAP_IOMAP;
 	} else {
 		se->conn.max_readahead = 0;
 	}


