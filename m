Return-Path: <linux-fsdevel+bounces-33472-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65DE99B92A7
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2024 14:55:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A2591F22347
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2024 13:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33E101A2C06;
	Fri,  1 Nov 2024 13:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=e43.eu header.i=@e43.eu header.b="AL0AoFK4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QXKolGFQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F5E158DD0;
	Fri,  1 Nov 2024 13:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730469317; cv=none; b=AmeLCPQ1tk36BxdAQxgeQm7voatq3M0vDz47W4JFZxAgR0yMDxtpUE02x8HDmoqub96aZsVrtJExYAlb3Qni7J86bpxpYpcHMiNb83hiB+z7X3RRBxZUL290HtmhzxlOhwy3lr8YmBEDw71Qh+rzgGsQ4107yhDXvo2zDbdm5zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730469317; c=relaxed/simple;
	bh=CSFmLXHJp06aDMvcn6Z4+VucVHRsGqWyh1BK043a+jg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HovtRYspjaQZEITPD5eHMP7GBr7W2uaDygcxz0B/eSMSHTwP8ZFRDVPsOSLW1BoQmYwcuuCSww6G9WmOnc2bAAIR+5xcKniaeEJId1inKe9qmRv5gp4W6HKQAjW2rcX9OKReQ9GSE39if16VRl3sZSs+iUjJ4U8HZZgSOewHU5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=e43.eu; spf=pass smtp.mailfrom=e43.eu; dkim=pass (2048-bit key) header.d=e43.eu header.i=@e43.eu header.b=AL0AoFK4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QXKolGFQ; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=e43.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=e43.eu
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.stl.internal (Postfix) with ESMTP id 35A5B1140113;
	Fri,  1 Nov 2024 09:55:13 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Fri, 01 Nov 2024 09:55:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=e43.eu; h=cc:cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm2; t=1730469313; x=1730555713; bh=qUiH84UVaL64E5EF3YfK1
	mi/Dpl5oXzsSHqcy24r22M=; b=AL0AoFK44+Pwh3YFM+UCLpJtLoQu5T6vGBIQc
	Z7tZVodmn8dUXbIU+dDCTJ6T0bhMCY54WLjfxso0gtsfguP8dxpPsk7VK+DI2PAH
	iOd6gnz2Jteq0HHwevboNF62RwXzzjfbB41fgMtI+esGbhARaQN66U7V6+1yTh6E
	Z4ZIYld4vlhHmBrunX0xgGosiQ0r6xc9fSJVqoPnZY27QaIXNRqBjxSlAHNBQPFb
	TmtEXwb/Z2XTN36Ui/DZl7VQ5OgmWQ3vpPyT0q8BglwddPvOn7Ojhu4yiXE5J/1H
	RVulHyGNORZ913LNOwo+sz/9tVqTRejAq84ogBc3xPo8nRlOw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1730469313; x=1730555713; bh=qUiH84UVaL64E5EF3YfK1mi/Dpl5oXzsSHq
	cy24r22M=; b=QXKolGFQm8WkHDjRSj674JKM5IO9ekx+crhDjR3z2ZzT63UjOWU
	EReJfchCFnHpttpwrOpdfqes9QPV6RwABEchuaRQJ1ZCeGDCwOqlFIfxnpxr8Y/O
	OrMzdsDsP9qCIh71KTHkFAoLNrAeSiIievQcvWc5YSB4Mk4P4IzCJ6Y+Hvyuv+se
	Phrp8NOdtHkZE+pciLS7zyWzP3UpvZnVlohX8u1/V1NIP/zzwmsBVCw77TJi4vGB
	e9dCw5DQxvO32CXgVK5AkV3/bTHnH2h8p5376sJ2DxyBRuWGSWQ6mOiaH6rUVkoM
	6elMTZxZeefeJhJqbg4fttR6TAfw39/Zw+A==
X-ME-Sender: <xms:wN0kZ0_AWPO-D-EUcySk2hUpn1_uBKxbS6jVWX7gRNi17quclSHHag>
    <xme:wN0kZ8v3WmzFyEgM9u2FyPpl_9uy0N8CfDCJQrhWqHN3eZ2d2wbzekYC5vW_725s4
    WPQHSGWytoXpCDYXgc>
X-ME-Received: <xmr:wN0kZ6A74E2dVW1FZhpeoVbaQmaJhtxBnqQoLwYxqJvGq1naqjb26X7INYCe41sxfrnrxmmT_-p1lmL7_MYlEw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdekledgheejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevuf
    ffkffoggfgsedtkeertdertddtnecuhfhrohhmpefgrhhinhcuufhhvghphhgvrhguuceo
    vghrihhnrdhshhgvphhhvghrugesvgegfedrvghuqeenucggtffrrghtthgvrhhnpeffvd
    ffffehvdevtdeiueefgeelheffieegudefuedtieevtdejhefguefffedugfenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegvrhhinhdrshhhvg
    hphhgvrhgusegvgeefrdgvuhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphho
    uhhtpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrd
    horhhgpdhrtghpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopegthhhrihhsthhirghnsegsrhgruhhnvghrrdhiohdprh
    gtphhtthhopehprghulhesphgruhhlqdhmohhorhgvrdgtohhmpdhrtghpthhtohepsghl
    uhgtrgesuggvsghirghnrdhorhhgpdhrtghpthhtohepvghrihhnrdhshhgvphhhvghrug
    esvgegfedrvghu
X-ME-Proxy: <xmx:wN0kZ0ePbpptRHUJ0m6CsdEoBufc4dOh32pgYOSAOG7mACDhMdL5zg>
    <xmx:wN0kZ5OPhPklyNDT0IaspYe7tXRPwREYP9VzzNlLJgU9W0rJpA0xwg>
    <xmx:wN0kZ-nP2aywfOMyn2QmUbRvZeD3xkWnVbcL9CjCPQPiMm3l8uJBNg>
    <xmx:wN0kZ7tt8nSe3aXcQbelFHlexsReCgYU0Z5J2BnW6206Q4ljF9TJ5w>
    <xmx:wd0kZ1DXQuoUtYA1kGPGU3I9NL7JEgbYK1EpQuyF7GGYNv5LV_AAVtTv>
Feedback-ID: i313944f9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 1 Nov 2024 09:55:12 -0400 (EDT)
From: Erin Shepherd <erin.shepherd@e43.eu>
To: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: christian@brauner.io,
	paul@paul-moore.com,
	bluca@debian.org,
	erin.shepherd@e43.eu
Subject: [PATCH 0/4] pidfs: implement file handle support
Date: Fri,  1 Nov 2024 13:54:48 +0000
Message-ID: <20241101135452.19359-1-erin.shepherd@e43.eu>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since the introduction of pidfs, we have had 64-bit process identifiers 
that will not be reused for the entire uptime of the system. This greatly 
facilitates process tracking in userspace.

There are two limitations at present:

 * These identifiers are currently only exposed to processes on 64-bit 
   systems. On 32-bit systems, inode space is also limited to 32 bits and 
   therefore is subject to the same reuse issues.
 * There is no way to go from one of these unique identifiers to a pid or 
   pidfd.

Patch 1 & 2 in this stack implements fh_export for pidfs. This means 
userspace  can retrieve a unique process identifier even on 32-bit systems 
via name_to_handle_at.

Patch 3 & 4 in this stack implement fh_to_dentry for pidfs. This means 
userspace can convert back from a file handle to the corresponding pidfd. 
To support us going from a file handle to a pidfd, we have to store a pid 
inside the file handle. To ensure file handles are invariant and can move 
between pid namespaces, we stash a pid from the initial namespace inside 
the file handle.

I'm not quite sure if stashing an initial-namespace pid inside the file 
handle is the right approach here; if not, I think that patch 1 & 2 are 
useful on their own.

Erin Shepherd (4):
  pseudofs: add support for export_ops
  pidfs: implement file handle export support
  pid: introduce find_get_pid_ns
  pidfs: implement fh_to_dentry

 fs/libfs.c                |  1 +
 fs/pidfs.c                | 57 +++++++++++++++++++++++++++++++++++++++
 include/linux/pid.h       |  1 +
 include/linux/pseudo_fs.h |  1 +
 kernel/pid.c              | 10 +++++--
 5 files changed, 68 insertions(+), 2 deletions(-)

-- 
2.46.1


