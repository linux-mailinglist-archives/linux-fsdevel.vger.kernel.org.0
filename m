Return-Path: <linux-fsdevel+bounces-73186-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AD242D10D3E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 08:15:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A8D543032CCF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 07:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DF2C32F749;
	Mon, 12 Jan 2026 07:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sony.com header.i=@sony.com header.b="lr/Fcslt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from jpms-ob01-os7.noc.sony.co.jp (jpms-ob01-os7.noc.sony.co.jp [211.125.139.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C80C329C49
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Jan 2026 07:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.125.139.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768202136; cv=none; b=PuTEJOCXsjAobMCjA0krRatqvA4GwSrvjkGqsUI3TnjsNynbPeg5AW6Ob6Unyuj1AwcAsgAZ47OPqgjgfS8OKw8zFQGaSLuv+MBZjtWvccqpm4/GquONF9imwYVAYptgKGyQq4KO8N4prizHASoxxHohYkkCf/NBVtDhGT101Eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768202136; c=relaxed/simple;
	bh=41DK+q6H9A29Mt8wwFHmZSl6vaWQ7DG1SWkdW1uKJTk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OCYOQ7K723gu+EQD7EBiNjEel+2LcfjzxvlRusR2AOLo5IT412ac68JYvibeoexG9BjyhAqbT41lNElCgBHlnBp6tI16MaB2LF2NkkiTx6bKBXYVGOG3eXtjWkVlUCBa/2j4WBZYRgPtwGroZrDOBGrmSuiwr7GD3CmLd69vW44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=fail smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=lr/Fcslt; arc=none smtp.client-ip=211.125.139.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=sony.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=sony.com; s=s1jp; t=1768202134; x=1799738134;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=41DK+q6H9A29Mt8wwFHmZSl6vaWQ7DG1SWkdW1uKJTk=;
  b=lr/Fcslted7TpIKcdbOodMT2inhA04/5qIRoP4UfRvTG9yxBAlLcIiu7
   cQufDz/d2sLQZ6nEXUWJ0L+PdBWrAdLuX6QmIOIC7zroH1dcuMOZ72yq/
   MpolVe3ONpVYfDGQSuP3tir3i6mEylAUfPux+ECnKIc4UdE9bGhayq9Py
   C10VTbiCkMjFYucDUTFvXQQjYYQPs0LgiBj36GZ5lh0O4/NurkMpQZidk
   eyborv+/I+zl68hj+Dwj2AaVLM8K3pei1Ca8nSq0kXznU/BfI8E92pfQx
   WUdlPdxBUgKR3jmWWbHKbfbp69+r5/SfuoE3GJLSuD4fcxr9THq5e956o
   w==;
Received: from unknown (HELO jpmta-ob01-os7.noc.sony.co.jp) ([IPv6:2001:cf8:acf:1104::6])
  by jpms-ob01-os7.noc.sony.co.jp with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2026 16:05:23 +0900
X-IronPort-AV: E=Sophos;i="6.21,227,1763391600"; 
   d="scan'208";a="60385049"
Received: from unknown (HELO cscsh-7000014390..) ([43.82.111.225])
  by jpmta-ob01-os7.noc.sony.co.jp with ESMTP; 12 Jan 2026 16:05:22 +0900
From: Yuezhang Mo <Yuezhang.Mo@sony.com>
To: willy@infradead.org
Cc: linkinjeon@kernel.org, linux-fsdevel@vger.kernel.org,
	sj1557.seo@samsung.com, yuezhang.mo@sony.com, yuling-dong@qq.com,
	On@web.codeaurora.org, Sun@web.codeaurora.org,
	Jan@web.codeaurora.org, 11@web.codeaurora.org,
	2026@web.codeaurora.org, at@web.codeaurora.org,
	"05:51:34AM"@web.codeaurora.org, +0000@web.codeaurora.org,
	Matthew@web.codeaurora.org, Wilcox@web.codeaurora.org,
	"wrote:"@web.codeaurora.org
Subject: > On Sun, Jan 11, 2026 at 05:19:55AM +0000, Matthew Wilcox wrote:
Date: Mon, 12 Jan 2026 15:02:19 +0800
Message-ID: <20260112070506.2675963-2-Yuezhang.Mo@sony.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <aWMy-4X75vkHmtDE@casper.infradead.org>
References: <tencent_E7EF2CBD4DBC5CC047C3EB74D3C52A55C905@qq.com> <aWMy-4X75vkHmtDE@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Matthew,

Thank you for your feedback!

There are two ways to extend valid_size: one is by writing 0 through
exfat_extend_valid_size(), and the other is by writing user data.
Before writing user data, we just need to extend valid_size to the
position of user data.

In your example above, valid_size is extended to 8192 by
exfat_extend_valid_size(), and when page 2(user data) is written,
valid_size will be expanded to 12288.

So, there is no missing "+1" and no need to consider large folios.

Best regards,
Yuling Dong

