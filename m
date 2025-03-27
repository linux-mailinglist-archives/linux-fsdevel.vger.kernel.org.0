Return-Path: <linux-fsdevel+bounces-45111-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1164A727B5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Mar 2025 01:18:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E3C43B4389
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Mar 2025 00:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F3544A1C;
	Thu, 27 Mar 2025 00:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vNf2FvR4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 007734C79;
	Thu, 27 Mar 2025 00:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743034668; cv=none; b=TPcyy0fnvL4otJbet7bkB5Lz89OhnDiJYD91p97XMmd3HBU8EFn5MuFkY4UIA8NlnM009GNQqrLIbotvhLZCgbR/ZnbNe2B2bR9myOld7egG1eBPSxOYTAzmkaekxHti6EC4tAaWy6w2IBcy24PgIihFsSfjYBOxvMfGTVW8y2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743034668; c=relaxed/simple;
	bh=zmEcurLR8RG57jqW4yrKKO7IDGUqhy+UXNtnWYipBiA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=T43XtPe6s7in6nddDWcUxoaPhNDGCMKpHjw8udSBM5f3+dhw+QSbL1VSs13BWb9CBb6xeE4jHfRACW/DlSYrc3MfMmNDTxGWiYOh/Kx/CqaWVD244qL2RMFp/OifU50LfvLRCEggYXM9GZ0DrUPUDq4aWeIUkHvEjyPMQSLlT6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vNf2FvR4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA321C4CEE2;
	Thu, 27 Mar 2025 00:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743034667;
	bh=zmEcurLR8RG57jqW4yrKKO7IDGUqhy+UXNtnWYipBiA=;
	h=Date:From:To:Cc:Subject:From;
	b=vNf2FvR4gBG7ehl5RqBNUsjFpBiE8bR/FLodS46xDhUtJUq7iyaz0OPFMQFgKN5Aj
	 FyxhAGGohixSg+FwhUGohr3ej3lVj/5DV7ilREtHFkUAQMhgzbxvalr5AAmKiw/1vY
	 rAfgeOt3PjQMGZwyjxqmLRbfVIz1TVeEfuBP6cCPM5aCwYRSBGuJPzsgyV9JLxkPMQ
	 kA3qlsgUYApesOIV6TLVCWEqHYcviae3xjbNgl2q1N+47jyHd3z+fIxFi2ITsAw7Be
	 a35/uVd9BHNms6FPWtU/jpGW/sPdXt4+9tZKxW5mlSVSO5ZAKdhnWRubV1judbOVxl
	 4B79mo27so19g==
Date: Wed, 26 Mar 2025 18:17:44 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH][next] fs: namespace: Avoid -Wflex-array-member-not-at-end
 warning
Message-ID: <Z-SZKNdCiAkVJvqm@kspp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

-Wflex-array-member-not-at-end was introduced in GCC-14, and we are
getting ready to enable it, globally.

Move the conflicting declaration to the end of the structure. Notice
that `struct statmount` is a flexible structure --a structure that
contains a flexible-array member.

Fix the following warning:

fs/namespace.c:5329:26: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 fs/namespace.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 6100e5b962a6..16292ff760c9 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -5326,8 +5326,10 @@ struct kstatmount {
 	struct mnt_idmap *idmap;
 	u64 mask;
 	struct path root;
-	struct statmount sm;
 	struct seq_file seq;
+
+	/* Must be last --ends in a flexible-array member. */
+	struct statmount sm;
 };
 
 static u64 mnt_to_attr_flags(struct vfsmount *mnt)
-- 
2.43.0


