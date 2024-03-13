Return-Path: <linux-fsdevel+bounces-14350-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0A5F87B0B4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Mar 2024 19:59:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D340E1C23043
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Mar 2024 18:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E34CB5B200;
	Wed, 13 Mar 2024 17:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DJiS9H3s"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C47D5A784;
	Wed, 13 Mar 2024 17:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710352793; cv=none; b=M9RxFycrOTcmCGouzIWelarSVUE1cLvbAiGQDpntzlx6DIYh0VANJR5IbT0bGLJtJFKoLG/eYJGkndmAgd4y4XK3NoY9cmCEvqJ797DHL+2V73tE2Y/U94ziuCqejBB0tUU0DCeT54VAIhRv17+ET7hJJmMYl/GqHJm/fQsyfM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710352793; c=relaxed/simple;
	bh=K25MtlZeHCUYvDWQdXo11USD++UAUl09pmm3BMqm2Cg=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UcYu816v2FiYbSKhvShRcdSY6CgASiyOs4NgqAKlQY+AKj7KXTBbhu8A+AcU1Dr1tIQsowhEaUjhcRlOisjs8qR2n/C6dH1Q5dT1Exxn6Vj2WGZEwxGAXUSzSkIpjImcFKpWmwp9M7oYky0rvh0iwhtL2j0PoCDayzj6zGnxM0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DJiS9H3s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C79DAC433C7;
	Wed, 13 Mar 2024 17:59:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710352792;
	bh=K25MtlZeHCUYvDWQdXo11USD++UAUl09pmm3BMqm2Cg=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=DJiS9H3sj/24lE4B1J1XLpKU18ZAaZTar2LC3Fa2VNwbzm8vKYwEMyuum5/NVrvZL
	 8kjQl4lOHz6nwcOG8oZOmy0Tm0evKGrDRBL/5F6X8nLEOoe3GuPHt6+Kz0YCmz2dGt
	 LxocLY8NFrNZnHO3PMeW5u7jcqTSIokPP/G2+BmTcUxXXcbUHVZAP0UALAgzJvindX
	 JwvnJfSXjXgXo7TRS+xZXViQJ8jBO9S8/Y1mVG4Fg12UZfxlHf88GG09XmAk8Qbj1k
	 dWFNsbDgfx72bMaNutNGuCfWszeythhRBEeXlF0ev0yt157m/67FjTQiSoj5pjNaYQ
	 lJ5hYqIzLVlug==
Date: Wed, 13 Mar 2024 10:59:52 -0700
Subject: [PATCH 28/29] xfs: add fs-verity ioctls
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, aalbersh@redhat.com, ebiggers@kernel.org
Cc: linux-fsdevel@vger.kernel.org, fsverity@lists.linux.dev,
 linux-xfs@vger.kernel.org
Message-ID: <171035223804.2613863.13648555925178352663.stgit@frogsfrogsfrogs>
In-Reply-To: <171035223299.2613863.12196197862413309469.stgit@frogsfrogsfrogs>
References: <171035223299.2613863.12196197862413309469.stgit@frogsfrogsfrogs>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Andrey Albershteyn <aalbersh@redhat.com>

Add fs-verity ioctls to enable, dump metadata (descriptor and Merkle
tree pages) and obtain file's digest.

Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
[djwong: remove unnecessary casting]
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/xfs/xfs_ioctl.c |   17 +++++++++++++++++
 1 file changed, 17 insertions(+)


diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
index ab61d7d552fb..4763d20c05ff 100644
--- a/fs/xfs/xfs_ioctl.c
+++ b/fs/xfs/xfs_ioctl.c
@@ -43,6 +43,7 @@
 #include <linux/mount.h>
 #include <linux/namei.h>
 #include <linux/fileattr.h>
+#include <linux/fsverity.h>
 
 /*
  * xfs_find_handle maps from userspace xfs_fsop_handlereq structure to
@@ -2174,6 +2175,22 @@ xfs_file_ioctl(
 		return error;
 	}
 
+	case FS_IOC_ENABLE_VERITY:
+		if (!xfs_has_verity(mp))
+			return -EOPNOTSUPP;
+		return fsverity_ioctl_enable(filp, (const void __user *)arg);
+
+	case FS_IOC_MEASURE_VERITY:
+		if (!xfs_has_verity(mp))
+			return -EOPNOTSUPP;
+		return fsverity_ioctl_measure(filp, (void __user *)arg);
+
+	case FS_IOC_READ_VERITY_METADATA:
+		if (!xfs_has_verity(mp))
+			return -EOPNOTSUPP;
+		return fsverity_ioctl_read_metadata(filp,
+						    (const void __user *)arg);
+
 	default:
 		return -ENOTTY;
 	}


