Return-Path: <linux-fsdevel+bounces-61557-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93253B589E2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 02:41:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D0CC2A405E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 00:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C1001A9FBD;
	Tue, 16 Sep 2025 00:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H+eu3FWd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E64D528;
	Tue, 16 Sep 2025 00:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757983261; cv=none; b=EIwvGiNXXnMgj/uK/opg/KvL9Yq3sxsH0ry/S5azWuUghrko7Isk7muutQzvuQoXcYHUvUBd+ivXPF6hkKB0ADvbFefHWmoTJxnnAXSCyEr9exCZJgz1E6oj9Hx+gZDeKXD96R06P7h2NoRuw4ebAqpcwB8v8pKIXEVB8I96sy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757983261; c=relaxed/simple;
	bh=OZzvUI/KrZEIJEXQmrvcWMg/KmzqX4lbkBc5Zjp3Dyo=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=feihRzds2RWOzcCCk1wE3ToyXXhi8/DMIGa5g8Td/3N7tpbbIdWMyKuIUPHv4bqifEo7yS8PXqZxF8MwtZJwCSJfMTr5M2dpuJ/i68OjVKNySq8mSWgwVajygbmusETESvCEruW+IqVbwyqkVrkPInA5q7lofjRaoErfaTr5l0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H+eu3FWd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13016C4CEF1;
	Tue, 16 Sep 2025 00:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757983261;
	bh=OZzvUI/KrZEIJEXQmrvcWMg/KmzqX4lbkBc5Zjp3Dyo=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=H+eu3FWdEwzjrNy0ahw+8SIXM53G44ALazBwStpW5ZAnK/Jv4HjVoA5na1/+if+dS
	 yEIKTPWhlNTp7cOwWktmec8jrsEXdUiZLFPctfDa8VAFwMm1cnU/rrQDNBwQkzzUzh
	 4e7zCzYP6TXylSMMLt8xbZg+SvMzEhz78rB1dItYV3xRUQo7b4p+K06vQNsRqSqD0i
	 FWiDKBx7lz8LcGztW62rs7Nn481psdPzNq1aZXq2dueVQtHlUY1R4t84GZWufQRXd6
	 umEKZz5lIcvXB24N7vti5r8YBQxLrZVMQ+1gxS5mYfh+F1+s+jak22iHcXDzNu2m7v
	 HlFqYNimjgXzw==
Date: Mon, 15 Sep 2025 17:41:00 -0700
Subject: [PATCH 10/10] fuse: enable iomap
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: bernd@bsbernd.com, linux-xfs@vger.kernel.org, John@groves.net,
 linux-fsdevel@vger.kernel.org, neal@gompa.dev, joannelkoong@gmail.com
Message-ID: <175798153140.384360.11927932394942426609.stgit@frogsfrogsfrogs>
In-Reply-To: <175798152863.384360.10608991871408828112.stgit@frogsfrogsfrogs>
References: <175798152863.384360.10608991871408828112.stgit@frogsfrogsfrogs>
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
 fs/fuse/file_iomap.c |    3 ---
 1 file changed, 3 deletions(-)


diff --git a/fs/fuse/file_iomap.c b/fs/fuse/file_iomap.c
index c82434674fb52b..261490a322c289 100644
--- a/fs/fuse/file_iomap.c
+++ b/fs/fuse/file_iomap.c
@@ -104,9 +104,6 @@ void fuse_iomap_sysfs_cleanup(struct kobject *fuse_kobj)
 
 bool fuse_iomap_enabled(void)
 {
-	/* Don't let anyone touch iomap until the end of the patchset. */
-	return false;
-
 	/*
 	 * There are fears that a fuse+iomap server could somehow DoS the
 	 * system by doing things like going out to lunch during a writeback


