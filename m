Return-Path: <linux-fsdevel+bounces-14634-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8796787DEDF
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Mar 2024 17:38:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B50A01C210DD
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Mar 2024 16:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 110301CA96;
	Sun, 17 Mar 2024 16:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qGeAM0mx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA1D1367;
	Sun, 17 Mar 2024 16:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710693496; cv=none; b=ZevMIkkobyTwvHPBPENnpCLsT1sDmHpJWU5SdkNX1DdoQA8GtH9bv1jJDbxHxrweltaY4fDrDRho7V2QuJ0w340la31vgoYra85tAqtL08Pu7iyP5CvDTgSysHcdsT3HpfZYmylSyo9QW2lwEPNF2FiNOg7/PkLXKzKBjDrSueM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710693496; c=relaxed/simple;
	bh=m9uYBM+z6JIsaUdVOrWiTr2xD3YQa0/L8E420J4/JOQ=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kLeCZbF8Y64QERhWX+z8dumV7deCTCK3JRQY7FH5cC/v+TAMYGHnMKbEQFUJNRwBh5b1F7cnBnlf3oG1HccneNQ3nCLCJnsv0bONV1BJ+LP6CLkb8lsQlbAqSAOSIeFsIv4zKKj2Z176ardnngTbHfknQY6Y1T0xJQLQswYHYNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qGeAM0mx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 087CAC433C7;
	Sun, 17 Mar 2024 16:38:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710693496;
	bh=m9uYBM+z6JIsaUdVOrWiTr2xD3YQa0/L8E420J4/JOQ=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=qGeAM0mxMr/bEzuQRrrlYWMe7I3vH70Wd1FNEJ802I9CCAlPuhzHyyRPrIBBa6jJJ
	 CWugOXJ5jsYkqUuCq0SCd+JU154QPpahuLSR7R+B3KBTqI+pIz7XCeYAbeogdf8Pny
	 R7pXvFOLX/LvatnrbU1nJGYC020OfA4FOPsOCHaZOS7NLT+4BgjSV24r8/IWmgv2ks
	 zb7SPqCEXJ8j3v6pPA5LX9NL9cKDqRjz7ZJ3HxSWSj5OUXYyupEsrGtYOa9huDob7t
	 H5BfHmfARygRPIu0fl1ziIFXFq9Zmxt6alI5M6V1VEp8SCDqyWpl7ODH4MDDeHbXL/
	 gL+YQYfG7S4Qg==
Date: Sun, 17 Mar 2024 09:38:15 -0700
Subject: [PATCH 17/20] xfs_db: dump verity features and metadata
From: "Darrick J. Wong" <djwong@kernel.org>
To: aalbersh@redhat.com, djwong@kernel.org, cem@kernel.org,
 ebiggers@kernel.org
Cc: fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org,
 linux-xfs@vger.kernel.org
Message-ID: <171069247910.2685643.16760656404093565318.stgit@frogsfrogsfrogs>
In-Reply-To: <171069247657.2685643.11583844772215446491.stgit@frogsfrogsfrogs>
References: <171069247657.2685643.11583844772215446491.stgit@frogsfrogsfrogs>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Teach the debugger how to decode the merkle tree block number in the
attr name, and to display the fact that this is a verity filesystem.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 db/sb.c |    2 ++
 1 file changed, 2 insertions(+)


diff --git a/db/sb.c b/db/sb.c
index b48767f4..cd51f748 100644
--- a/db/sb.c
+++ b/db/sb.c
@@ -706,6 +706,8 @@ version_string(
 		strcat(s, ",NEEDSREPAIR");
 	if (xfs_has_large_extent_counts(mp))
 		strcat(s, ",NREXT64");
+	if (xfs_has_verity(mp))
+		strcat(s, ",VERITY");
 	return s;
 }
 


