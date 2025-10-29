Return-Path: <linux-fsdevel+bounces-66159-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99533C17E76
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 02:27:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E23E3BF1BD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 01:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 883822D3A96;
	Wed, 29 Oct 2025 01:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TARMES09"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA47D22097;
	Wed, 29 Oct 2025 01:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761701155; cv=none; b=mrBHafgHLqpbHVWXVSJO04OR/NoaknLpEi5YetBcnVm+9hdoV1MZVNfDGcL1SHNrJKBD2sYMe4hEYj9lMhcKFxrktPBwWVQenxwxnZfJBk9OYnDjBqqeYsS8F0Fl5mA905aGaCXkd5iJsk78bvTtks+fCVzCJEp7TbcOwf1Poxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761701155; c=relaxed/simple;
	bh=W3qHOb6bxQfl6RwpNnCmyR8oJ2btf0ZiQgjo9qUtdWY=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SFGifnmwrigjbUdRJo4hTJw34ixs/3BVuSgOKPdcctdmwAycun4xejRbCtfXRwuUNlM6DHxqjpHyJaVSQDOHXOF3qb8nWPR0f0RHzsO5U/mEvjXx6v/JU3cxyi5CTOoYfg/SJAc/vtGhaanIBqmOYs4i+UeC3jRwt8v5UtDBuNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TARMES09; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76CD1C4CEE7;
	Wed, 29 Oct 2025 01:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761701154;
	bh=W3qHOb6bxQfl6RwpNnCmyR8oJ2btf0ZiQgjo9qUtdWY=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=TARMES09CcXqFTgzucntd6/t6AoLoSYhMT4m+3jPBd5KemA/0T9PH3SNJbUj9i27a
	 RDO7LBJssDk+E+Xg6C2aW75aNtOvnpg4auB111PSBXjt/jzGdgl7d/K8DD0q5XH+wg
	 F9iYUXlMPRWqZhzd5zeAQeLCa39w/btM7XQVhI/nrUZJi5/HdkvCi+UOAfZEvTTdsc
	 RclZGJq6bgZCIKluDZ2VlWP7u/yfJWwf1O6K31qgZuX5l67IhbH1QBFvhPiWC2kCfO
	 jaVYPz05vZFuloA7AWukc0ohVThH19LpLNBhOISvzKzAFKhqVReRyGVGJix9RT1sa+
	 LhDaw2dR5S/YA==
Date: Tue, 28 Oct 2025 18:25:54 -0700
Subject: [PATCH 21/33] ext4/046: don't run this test if dioread_nolock not
 supported
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, zlang@redhat.com
Cc: neal@gompa.dev, fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, joannelkoong@gmail.com, bernd@bsbernd.com
Message-ID: <176169820371.1433624.14663347479683854110.stgit@frogsfrogsfrogs>
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

This test checks that directio reads still work ok if nolock is enabled.
Therefore, if the filesystem driver won't mount with dioread_nolock,
skip the test because its preconditions are not satisfied.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 tests/ext4/046 |    8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)


diff --git a/tests/ext4/046 b/tests/ext4/046
index 60d33550e3db59..2e770830ab0c5e 100755
--- a/tests/ext4/046
+++ b/tests/ext4/046
@@ -24,13 +24,7 @@ _require_scratch_size $((6 * 1024 * 1024)) #kB
 
 _scratch_mkfs >> $seqres.full 2>&1
 if ! _try_scratch_mount "-o dioread_nolock" >> $seqres.full 2>&1; then
-	err_str="can't mount with dioread_nolock if block size != PAGE_SIZE"
-	_check_dmesg_for ${err_str}
-	if [ $? -eq 0 ]; then
-		_notrun "mount failed, ext4 doesn't support bs < ps with dioread_nolock"
-	else
-		_fail "mount failed with dioread_nolock"
-	fi
+	_notrun "mount failed, ext4 doesn't support dioread_nolock"
 fi
 
 # Get blksz


