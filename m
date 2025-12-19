Return-Path: <linux-fsdevel+bounces-71733-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CD508CCFC2B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Dec 2025 13:21:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A968930E421F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Dec 2025 12:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3D6733A9C2;
	Fri, 19 Dec 2025 12:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PgEmvRPD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04DFF337B8C;
	Fri, 19 Dec 2025 12:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766146572; cv=none; b=WBrB0eJwotqyFpdLo/yGM7r/OKAVtqeg/NR++z/Wc2Rcy570CrOJ2v+HxfDI9LMY2mVScK0MvGmpw2VZSwpUPwCxfZhO48EMqirkpyc3DjUx+fFe0mhcSncNV1iME3Edo95L2DjUN7on1ShJT4EH0q0WzswnBHmBLH0PbnPQpXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766146572; c=relaxed/simple;
	bh=BttYzFF+xjDCiXPSwOn5xmsY105yRYbvY3nWA/ZGsJo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TgTkWvw0ZFgSFaHtLhn8/vNQRi8kWPKUWYEyuWxNW7Xd22rpx9gc90XaPyiouhZ6Pwl2Djw4R10z51qv7vN0dPR6oVmC23t3FWtPQhDDboM6efGDF4Fr3GfMunh7DXDTzh9eXOg7z0mebs/KF3YZgw2lUfAHkH97OGsVTBuYISA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PgEmvRPD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 91091C113D0;
	Fri, 19 Dec 2025 12:16:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766146571;
	bh=BttYzFF+xjDCiXPSwOn5xmsY105yRYbvY3nWA/ZGsJo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=PgEmvRPD5xYIi01ZU9qWAcsQ8JFmenkUcWBIIXu0366nXrIj5Kzl/Z3/ThWQLgDVG
	 AVyR62AxCMhaMHttPodzkV7YtO1Bwvk5PKb8QPsjF80A51mq4bjEPftPHYeRmuo1Cj
	 PvGWb9cVJqIGBB0TT3Hmvkvb72DOUUp+4TAv6cW0SyFTazmwtcyXqWkjitsTkqV4Oo
	 TMlWfc0elAykHxD+VYNtDq7dJSI5swVxXWiMdmbfwRF6iA3i1SfA+6bpTpKZvpIYuF
	 OhX4fJFnELHYgb6i4GX/0UlvQZOWVUFkifEhoxzD3eswHcrQlHmUk7qJbKrpUnz767
	 hBQT62dRjPWmw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CB8CD767EE;
	Fri, 19 Dec 2025 12:16:11 +0000 (UTC)
From: Joel Granados <joel.granados@kernel.org>
Date: Fri, 19 Dec 2025 13:15:52 +0100
Subject: [PATCH 1/9] sysctl: Move default converter assignment out of
 do_proc_dointvec
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251219-jag-dovec_consolidate-v1-1-1413b92c6040@kernel.org>
References: <20251219-jag-dovec_consolidate-v1-0-1413b92c6040@kernel.org>
In-Reply-To: <20251219-jag-dovec_consolidate-v1-0-1413b92c6040@kernel.org>
To: Kees Cook <kees@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Joel Granados <joel.granados@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1599;
 i=joel.granados@kernel.org; h=from:subject:message-id;
 bh=BttYzFF+xjDCiXPSwOn5xmsY105yRYbvY3nWA/ZGsJo=;
 b=owJ4nAHtARL+kA0DAAoBupfNUreWQU8ByyZiAGlFQgRMtizYR9OYfeMjw7pycCr20q/WRljNv
 Gv7AtsSvdGWWIkBswQAAQoAHRYhBK5HCVcl5jElzssnkLqXzVK3lkFPBQJpRUIEAAoJELqXzVK3
 lkFPwrIL/0iqyDLEk1RhmqSMkosxAUAybbbCK4smGes4JaXl8BHioW4tZycsI6h2HCNiTXaXOru
 IvIXurtl6sXky1KuZ+xH50ynenFebFbsbCjPSbGrF0dU5QiKc8iPkritOe8xPeU3GqwNLMpb72k
 tm330e3TYbYuJWCJj64ruZbsYZID4sBhRD1FW835FOT8XzeUCkYAML7YqpKVBTVVN6k5F7l+ZlW
 Lkaq6r25AmPFhkq9F+CZQJirk0Wip5O53b4hnlpKR3QMkVAoKOuno+PaN7s4oxJ2Vo8teWNh3jX
 KO8f+TBapGhhY70TJye2Y8ff4eacLQuP36M/LH3zzzZJZF2H28B8hgT7Z319yME/VkzDfI/CJd1
 qMrpTI5rj5JNfbTUU8EnjdLdxoCZZp+BB9W+WQtrYjQjB+pkSX214bWeETdooaGVC67fkZnvejR
 9FCJaz71ZYpPPNp61hy4mdH305OI7B3vfaohWSfkzi5bLjqmqaikxTbfou9Fbq7ZgBr1u9L/Q17
 dY=
X-Developer-Key: i=joel.granados@kernel.org; a=openpgp;
 fpr=F1F8E46D30F0F6C4A45FF4465895FAAC338C6E77
X-Endpoint-Received: by B4 Relay for joel.granados@kernel.org/default with
 auth_id=239

Move the converter assignment out of do_proc_dointvec into the caller.
Both the test for NULL and the assignment are meant to stay within the
sysctl.c context. This is in preparation of using a typed macro to for
the integer proc vector function.

Signed-off-by: Joel Granados <joel.granados@kernel.org>
---
 kernel/sysctl.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index caee1bd8b2afc0927e0dcdd33c0db41c87518bfb..284ad6c277e8b52177cca3153acf02ff39de17f0 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -591,9 +591,6 @@ static int do_proc_dointvec(const struct ctl_table *table, int dir,
 	vleft = table->maxlen / sizeof(*i);
 	left = *lenp;
 
-	if (!conv)
-		conv = do_proc_int_conv;
-
 	if (SYSCTL_USER_TO_KERN(dir)) {
 		if (proc_first_pos_non_zero_ignore(ppos, table))
 			goto out;
@@ -840,7 +837,7 @@ int proc_dobool(const struct ctl_table *table, int dir, void *buffer,
 int proc_dointvec(const struct ctl_table *table, int dir, void *buffer,
 		  size_t *lenp, loff_t *ppos)
 {
-	return do_proc_dointvec(table, dir, buffer, lenp, ppos, NULL);
+	return do_proc_dointvec(table, dir, buffer, lenp, ppos, do_proc_int_conv);
 }
 
 /**
@@ -1074,6 +1071,8 @@ int proc_dointvec_conv(const struct ctl_table *table, int dir, void *buffer,
 		       int (*conv)(bool *negp, unsigned long *u_ptr, int *k_ptr,
 				   int dir, const struct ctl_table *table))
 {
+	if (!conv)
+		conv = do_proc_int_conv;
 	return do_proc_dointvec(table, dir, buffer, lenp, ppos, conv);
 }
 

-- 
2.50.1



