Return-Path: <linux-fsdevel+bounces-66154-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C11FC17E70
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 02:27:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CE151A60DE7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 01:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB2022DA759;
	Wed, 29 Oct 2025 01:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tpC+CKvI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10386254848;
	Wed, 29 Oct 2025 01:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761701077; cv=none; b=VhoZ7TCT44Q9zzu8ou9b5nqQIeT/IOHzyrMJ0oK9/2x2akZGgVQaLdOP3NODGujOzS7AquuXf+4BXcCxf+mp/4+HESWZ/0ulQAPTPWnfTu2tCYlFg8Yc0mJX6SGy8lX/7IwWkaEc5c1a9m/vyMWpwnKMr9t1Xpcx5dVLpYzSIFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761701077; c=relaxed/simple;
	bh=T3ZzVBEitI4wPB8dO4oyx0/l6JmwanvfS2+XYxsOXKI=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S5gQf81VsESq8n/Q3opbTmJQyqwICeWK/QIyloU3HbGZWfFtAXoHN/T+OPTTgj+Cvl8Lcp7MWz570c4CJ1/APa4QdsHtlSXIf/oWzcYTXmneJxfu8fDt5rl2oqrg5LmTW89URwB12rbDGeig95pUXY0UN9OkGcbR7/Ht9U61zCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tpC+CKvI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 833B6C4CEE7;
	Wed, 29 Oct 2025 01:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761701076;
	bh=T3ZzVBEitI4wPB8dO4oyx0/l6JmwanvfS2+XYxsOXKI=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=tpC+CKvIw7p2eNhiBdI1XZZS4ev8I4/w1bGdmtGyv08gvtw8zjPDn0LQwYhIAT6sp
	 4Cp9mUakYAC1rN/4sWMZWogu95Fkru7pKEjAGW4kjcBGKhQPorncrftcZ252mdeFvr
	 Ac9kAdzVkpUqEHQZCLfln6QZwMw9AthrRNaiwupYAt2bph0E5bEMiQegS+ZxfAjkn4
	 UMa1K+EwLemWNv42ugXsHZF6EcIerK09XjSRFX3tRKGFnL+KRybpujLOlH2YtTGZBL
	 eRN2RmO55fM/JHJj2gQBiuwlbzDSyIwaqz8K3f1PsEOqn2r2q7wiU44e0Iypi5vkex
	 d+KZKK6tODoQQ==
Date: Tue, 28 Oct 2025 18:24:36 -0700
Subject: [PATCH 16/33] generic/679: disable for fuse2fs
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, zlang@redhat.com
Cc: neal@gompa.dev, fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, joannelkoong@gmail.com, bernd@bsbernd.com
Message-ID: <176169820277.1433624.12205115266589936859.stgit@frogsfrogsfrogs>
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

fuse2fs' fallocate implementation follows xfs' behavior of failing an
fallocate up front if there isn't enough free space in the filesystem to
allocate @len bytes, even if most of the range is actually already
allocated.  This is an engineering decision on the part of the author
(me) not to support the corner case of preallocating a not very sparse
file because that would just be more code to maintain.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 tests/generic/679 |    2 ++
 1 file changed, 2 insertions(+)


diff --git a/tests/generic/679 b/tests/generic/679
index 741ddf21502f3a..da62cc4a0fe5e3 100755
--- a/tests/generic/679
+++ b/tests/generic/679
@@ -24,6 +24,8 @@ _require_xfs_io_command "fiemap"
 #   https://lore.kernel.org/linux-btrfs/20220315164011.GF8241@magnolia/
 #
 _exclude_fs xfs
+# fuse2fs copies xfs' pattern
+_exclude_fs fuse.ext[234]
 
 rm -f $seqres.full
 


