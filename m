Return-Path: <linux-fsdevel+bounces-14621-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5875187DEC0
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Mar 2024 17:35:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E34D2810A7
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Mar 2024 16:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E208C63B3;
	Sun, 17 Mar 2024 16:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oCZYGBzb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B981B949;
	Sun, 17 Mar 2024 16:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710693293; cv=none; b=e24JAnaEHZAz5MLqcQycGI6bYkK/GBemxLQYwCt0uYj1rOHxOfwh7Zyy23ZjkPbPAXz9MZgFRqFBA8Apw9ZzfAtObPchVFO4Pm42kqE2IsBp5zOmW1sd6bvR6+ks/Zrnae3RxMyVDOdBQJVge30MO9ALdnVi5oKvmFC+cmGUH8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710693293; c=relaxed/simple;
	bh=RggHKhdZKkJxpYlXhjfqhzcYpZJ5RnDewFcTjCfCK0o=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uJik4L5o0HSooUK5+42S+LrvD6/f2fQ+hW+GiCaUpFl3XBnYiEJS/83JoHN9bu1OGV9T3QFuavlCnbC2+o57IYddHcS2odb1muSOdtoAOvOJQRJZOe8B43OTIeMUaz1y/V+LFQ0Q+AEHDddN3na4q4b0OfFwCiFh/bNmJ6gNcIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oCZYGBzb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8613C433C7;
	Sun, 17 Mar 2024 16:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710693292;
	bh=RggHKhdZKkJxpYlXhjfqhzcYpZJ5RnDewFcTjCfCK0o=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=oCZYGBzbQzMGYhL2L0sovmjdRh3C7QplObrgVcGYEgyv7wdUABSYrPr0aWq+i9vbL
	 rtHgJu+ArPVnNCgyYL1MARoVKAU/AQhXSUbNwDubBtnM+T89v6M1Prw95IFC4wAUVD
	 K/IMfB2MTZmm7pIJx72DX6sMS4Tr7MVfKHOQiB+SnFf+B7yEtZyYATZ4lt1Da0uw92
	 QxxosSFzbrY5nwZqSC+/NtAAl4Viu98aaVMwHq44dIfmjfI8bQ9n+Jx8b4upHHEo8F
	 zR/i6971GtgpN85sT9ztBTApgdvoB4FpHQVxHbvTpKysxqgKNPFHLorqT1nwAyRUY0
	 Kt1RLTOcwq2SA==
Date: Sun, 17 Mar 2024 09:34:52 -0700
Subject: [PATCH 04/20] fs: add FS_XFLAG_VERITY for verity files
From: "Darrick J. Wong" <djwong@kernel.org>
To: aalbersh@redhat.com, djwong@kernel.org, cem@kernel.org,
 ebiggers@kernel.org
Cc: fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org,
 linux-xfs@vger.kernel.org
Message-ID: <171069247730.2685643.9652848886084002483.stgit@frogsfrogsfrogs>
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

From: Andrey Albershteyn <aalbersh@redhat.com>

Add extended attribute FS_XFLAG_VERITY for inodes with fs-verity
enabled.

Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
[djwong: fix broken verity flag checks]
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 include/linux.h |    4 ++++
 1 file changed, 4 insertions(+)


diff --git a/include/linux.h b/include/linux.h
index 95a0deee..d98d387e 100644
--- a/include/linux.h
+++ b/include/linux.h
@@ -249,6 +249,10 @@ struct fsxattr {
 #define FS_XFLAG_COWEXTSIZE	0x00010000	/* CoW extent size allocator hint */
 #endif
 
+#ifndef FS_XFLAG_VERITY
+#define FS_XFLAG_VERITY		0x00020000	/* fs-verity enabled */
+#endif
+
 /*
  * Reminder: anything added to this file will be compiled into downstream
  * userspace projects!


