Return-Path: <linux-fsdevel+bounces-66155-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E4F4C17E4F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 02:26:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58FB73B5B3B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 01:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5076F2DBF5B;
	Wed, 29 Oct 2025 01:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nE2j5XNG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C6EB2D738B;
	Wed, 29 Oct 2025 01:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761701093; cv=none; b=Gu8myGEf697JhT3MDBWa5kHcgINLa3bm+PFqYXr4Gsa4461I+uf/jwUkLkZ6XDDW7mwinhUZ522ooTEqqR2DgUvB03i+tsTpPKyr9gxT6jyT+CSUW4ex1+929CneuvGXmny/pYghe8TsYnZmlfaV06jflK/GijzvmJl7eqXRuiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761701093; c=relaxed/simple;
	bh=PSWcrJ5A3ipx2xL02tAE4hnd7U7TY/92KjJmQG5okOE=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TU4d1XvBMil4xzgZr2VrLQ+tvuFGj5Rc9ga6QA1HJDcNdflMCpatcSKkh7NChBvQbIXqp7HkQ9l/1Hk5nOGlzKO6NPR5Iot5tk+nvZZt6CYDgF0PjzAJu/27tsLB/7dFQF5gVxGsEJHGCdcCsRKrI+VKXtI4iOdLSiyH2TwX2Gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nE2j5XNG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23E20C4CEE7;
	Wed, 29 Oct 2025 01:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761701092;
	bh=PSWcrJ5A3ipx2xL02tAE4hnd7U7TY/92KjJmQG5okOE=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=nE2j5XNGTypErO8LGGYO92xtwKEr8cIazqyGjVAkIx/UVxAh8HdK+JFguQT/vkWZ3
	 m90gXxDRpBSlPzyqNN05ab3jW4NcqXrYWcESqJGpgNJQ3xi+jUYIy5LfnXWQd/3O05
	 rMLCzLCSAYX+G9sSnVb+mK66xPqrIAzVrqd8ugwhV29H8XYhPC+Ta3NxIrnUiko7zo
	 IwC0wi2zCFpuWDfVC2oKX3hzG0v4vHClSOuAcuxqYbuzI7ZkSG2DEXlnWeR7or8900
	 OMyH+0stLQ913fNBP41uomJ9KgCOuPRVFyjM1AGJK18krGu6K9D2vTjCxoY1JVj3d3
	 HnJJAq/c8tUJg==
Date: Tue, 28 Oct 2025 18:24:51 -0700
Subject: [PATCH 17/33] ext4/045: don't run the long dirent test on fuse2fs
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, zlang@redhat.com
Cc: neal@gompa.dev, fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, joannelkoong@gmail.com, bernd@bsbernd.com
Message-ID: <176169820296.1433624.772708549799292809.stgit@frogsfrogsfrogs>
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

fuse2fs doesn't create htree indices for directories because libext2fs
doesn't support creating them.  When testing the kernel driver this test
runs in a few seconds, but on fuse2fs it takes ten minutes to create the
small directory with minimally sized names, and three hours more to
create a very large directory with long names.

This is silly for a test that really just wants to make sure that we can
create a directory with a lot of child subdirectories.  Skip the long
test on fuse2fs.  We probably don't even need the long test.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 tests/ext4/045 |   12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)


diff --git a/tests/ext4/045 b/tests/ext4/045
index 15b2541ee342fa..1ccb33dc361682 100755
--- a/tests/ext4/045
+++ b/tests/ext4/045
@@ -84,10 +84,18 @@ workout()
 
 # main
 DIR_NUM=65537
-DIR_LEN=( $SHORT_DIR $LONG_DIR )
+DIR_LEN=( $SHORT_DIR )
+# fuse2fs doesn't actually write htree indices to large directories, which
+# means this test becomes excruciatingly slow when the dirent names are long.
+# Skip the test to reduce the runtime from ~3.5h to about 15 minutes.
+if [[ ! "$FSTYP" =~ fuse* ]]; then
+	DIR_LEN+=( $LONG_DIR )
+fi
 PARENT_DIR="$SCRATCH_MNT/subdir"
 
-for ((i = 0; i < 2; i++)); do
+echo "${DIR_LEN[*]}" >> $seqres.full
+
+for ((i = 0; i < ${#DIR_LEN[@]}; i++)); do
        workout $DIR_NUM ${DIR_LEN[$i]} $PARENT_DIR
 done
 


