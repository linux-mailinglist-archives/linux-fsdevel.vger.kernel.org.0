Return-Path: <linux-fsdevel+bounces-66162-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EE04C17E8E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 02:28:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F3234257A6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 01:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CB392DA759;
	Wed, 29 Oct 2025 01:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UE8Yl7fv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDEB826B77D;
	Wed, 29 Oct 2025 01:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761701201; cv=none; b=giA3OwyWLiyjFN+Bg6dhZYqCP18unhq4Ih98iefpfzNkuAsZ+EhRNfvGJ03ie+yXaQu+6zUjSTjnrmkPcTA4ZxUdBv55h5VTlFkbB7jzjNmGq+iIr/CpB/iIjfOWNZYQ8ROP/l0VJ0+G+vrSgO7rbzY7xbQnjqW0VZ06KOtpnlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761701201; c=relaxed/simple;
	bh=aE9jqgG6QiwaL4Vw3TUjBfxJTRtQagwkGNGXQsZnC7k=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SK8pTnduigUwUuupFZrRXkiVs0HFWZsMxGdEWFi8+XM1Ym1txNTku4k6fl+4Dw9uEyp58uXCTcmcXiTgUBGowEqSGFivtBw/GXqiN7Vx83MeZ0UYPh1udx+cGzFiJh37b5t84FgLmi8ppTkY00I/k/jKI53cIe/mshhi7ukNIpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UE8Yl7fv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45CB2C4CEE7;
	Wed, 29 Oct 2025 01:26:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761701201;
	bh=aE9jqgG6QiwaL4Vw3TUjBfxJTRtQagwkGNGXQsZnC7k=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=UE8Yl7fvZV+J8zk0cN27W2frimUiBbqSY+th0CPc2INUxGNTW7esmWdClfoUPk8BU
	 8ItB/pToIuIInqAs5/UrrVgLzk53RwQvishTfs0dG6qBCa3gww+H0K1cReI9j27Xph
	 qLGCKmq5UCPWqb3vv3yPqbv/juWKwnPkhN6s8opPqw9pFiVY45WgFQbCJ4cXLV4Fzn
	 zFxtjqxW7hafCTjEeHxDb4E6E9gI039nTQtNn1/3QJOg2VmC40pSXOyxOoE69g/R5v
	 JTcavIDOdvphrLsNnIwsNGx4pcIVp8I0mzVE2N/wthmA9WVSmcxlw/stAoWJWkYxKv
	 mpbUtsPs6JD8Q==
Date: Tue, 28 Oct 2025 18:26:40 -0700
Subject: [PATCH 24/33] generic: add _require_hardlinks to tests that require
 hardlinks
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, zlang@redhat.com
Cc: neal@gompa.dev, fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, joannelkoong@gmail.com, bernd@bsbernd.com
Message-ID: <176169820424.1433624.17178747435800564523.stgit@frogsfrogsfrogs>
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

These three tests require hardlink support, so add _require_hardlinks.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 tests/generic/079 |    1 +
 tests/generic/423 |    1 +
 tests/generic/597 |    1 +
 3 files changed, 3 insertions(+)


diff --git a/tests/generic/079 b/tests/generic/079
index df9ae52cdd5914..dda85aa1de5fc1 100755
--- a/tests/generic/079
+++ b/tests/generic/079
@@ -29,6 +29,7 @@ _require_user_exists "nobody"
 _require_user_exists "daemon"
 _require_test_program "t_immutable"
 _require_scratch
+_require_hardlinks
 
 _scratch_mkfs >/dev/null 2>&1 || _fail "mkfs failed"
 _scratch_mount
diff --git a/tests/generic/423 b/tests/generic/423
index 9d41f7a8fa8e62..af2d3451196d11 100755
--- a/tests/generic/423
+++ b/tests/generic/423
@@ -28,6 +28,7 @@ _require_test_program "af_unix"
 _require_statx
 _require_symlinks
 _require_mknod
+_require_hardlinks
 
 function check_stat () {
 	$here/src/stat_test $* || echo stat_test failed
diff --git a/tests/generic/597 b/tests/generic/597
index b97265fb896f09..985136323d3abe 100755
--- a/tests/generic/597
+++ b/tests/generic/597
@@ -35,6 +35,7 @@ _require_group fsgqa2
 _require_user fsgqa
 _require_group fsgqa
 _require_symlinks
+_require_hardlinks
 
 OWNER=fsgqa2
 OTHER=fsgqa


