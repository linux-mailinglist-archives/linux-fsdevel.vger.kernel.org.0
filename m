Return-Path: <linux-fsdevel+bounces-58224-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F1FBB2B55A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 02:36:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D530624757
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 00:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2BB8154BE2;
	Tue, 19 Aug 2025 00:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="TbAf2y1n";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="D/1JpP9M"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 578114A06;
	Tue, 19 Aug 2025 00:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755563785; cv=none; b=BeyDs1GNnlggV733KL8GNus/vxfBGwMkuBVTG2FLmt/I/XabZxUu0+qLtJX3F5TOgstQveWbd9iGlOGdaVnAnlL3EGMpRSnH1NdDui6OQ7aVqdGPAoDp1rsDlKm1LsC0ZuFc98t/fVGAEtsP3oe7uqQcNaeXf/Pa30iLAJ4fL8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755563785; c=relaxed/simple;
	bh=o62v5QK+mRGZ8I8JDQ4jFc2o6kX+MJHRytStGnqumaw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I/zljUcAdvuaGKNkuOI2iiaOUE2wf7LCl8juAiWae+WR04VvSLTUPvCK97Ollx6IvZac8WuDnXcrURr+w1oSC7oqyi8VZVWn/TNTRhd/SRAIHnM1B3XxiZ5Qf0bel0wk+yzZPkpEJNwIsfp7Yz8avdZ2M7DXXUpzJtYuMeYQyAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=TbAf2y1n; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=D/1JpP9M; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 4A454EC0853;
	Mon, 18 Aug 2025 20:36:22 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 18 Aug 2025 20:36:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm1; t=1755563782; x=1755650182; bh=/Ev8ptTbSa6crLCiddX4D
	LFg5va4F4iq3QV7Ft+6OUA=; b=TbAf2y1nLSA68emvru9qoX7jsxaINk0SkVW14
	XXYRW4XwAMQouF15hi4u/qjR6vVKT1AhafGlaXQP3sfDy3snqu1nhPEA76jL9P47
	R8WftMuBu1zAucsRKtY7KnKei9GfzZeb5UsSun9VVy/5boaa5BaN+NhF3I+T6IJs
	UJz3Li+rynIrGeCvOKtSbOZE1g1D2lgd2bEevwCOJC1R+aDBxwI7MJpegldqXXfu
	aUMVTwf+u1OjEZCyhvYrm9Nvnxf9FVzIktweveFtS6L9G9xw3kIjfIe+YNts6jkX
	jTC/t9jeVMz78SFxCXOHWoUWUyjM8WJ7o0yny+F6yPfODaozQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755563782; x=1755650182; bh=/Ev8ptTbSa6crLCiddX4DLFg5va4F4iq3QV
	7Ft+6OUA=; b=D/1JpP9MzZG7xqnLX2v9ZbVJF5232P4YWr8EOImRMJcwC2A6kOr
	R/3gOEZ4mjWCOKsi3OjWQ1a1vlS6mN82LOgtd7vFMJPZPm8H5aqTUUg6rgXpTTBm
	fnFur8SKy++2L/9aV+G1kG/h5nctG3Ykzuufkonv3TuATAE0bOjJ9ptQQagY1P+t
	4h42PTLUXj/ElcJcE+Fz+0vgd3Oq6naM1jaDhumU9CL6MDPSW+AF2q8C0a6FbdUB
	vBCl0wyop0CFngxSAXUJ7dKATqUmjvh1eFo2GIcRD8RBKvx3igCrUCqNO5AV9+Ij
	ndliFfpWnp7T3FjAhDEa+YGqEnImmYGjn+A==
X-ME-Sender: <xms:BcejaBuT5PXL98drRyuxgBN8cyp7L9pZrhNvro7cOv_SevJ4kNyzXA>
    <xme:BcejaP9661sfFKC_CAMRYSePTxGvJQ85kNIzxHhXFm5Cr9JWQFugecQCVXfS-0cd-
    oICFsg_a_G8xdloqs4>
X-ME-Received: <xmr:BcejaD1K12Mn2jjFfiBFJsMsKxxifyU1kNrF1YenT945aRLfsJkgA6GXE0kqcAOQbbCAieLli47xDracgaf6k6SlDwU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduheegtdeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffoggfgsedtkeertdertd
    dtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheq
    necuggftrfgrthhtvghrnhepieegleehjeelfeeifeeiuefhfefgvefgkedtjefhiedvve
    etgfduleejheeifffgnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuhhrrd
    hiohdpnhgspghrtghpthhtohepuddvpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pegrkhhpmheslhhinhhugidqfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtoheplh
    hinhhugidqsghtrhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehl
    ihhnuhigqdhmmheskhhvrggtkhdrohhrghdprhgtphhtthhopehlihhnuhigqdhfshguvg
    hvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgvrhhnvghlqdht
    vggrmhesfhgsrdgtohhmpdhrtghpthhtohepshhhrghkvggvlhdrsghuthhtsehlihhnuh
    igrdguvghvpdhrtghpthhtohepfihquhesshhushgvrdgtohhmpdhrtghpthhtohepfihi
    lhhlhiesihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehmhhhotghkoheskhgvrh
    hnvghlrdhorhhg
X-ME-Proxy: <xmx:BcejaMh3Mg_wY7sWh3tf1hEPkxEXcMOpFrjgN2Dso3v6Y5vphBa1dA>
    <xmx:BcejaLYu5f75W6lkvFuu0wUl4WCYmZzVMrm2r2jwinIfGvsLAEB3gA>
    <xmx:BcejaAWJRNDmat8g6qKhGvBAE4D0TgU71bWzZk9oxvrg77mWO3boYg>
    <xmx:BcejaLF0Ukwqvbo5Dr9Zqk6JqGy3dzyouHACe1PAs0NXYD1nKIQ10g>
    <xmx:BsejaIqyJCeHtecmHl9fjstQOZ9-dVguM5qPDdJ8f7h7kxFVDwRdKk2t>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 Aug 2025 20:36:21 -0400 (EDT)
From: Boris Burkov <boris@bur.io>
To: akpm@linux-foundation.org
Cc: linux-btrfs@vger.kernel.org,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	kernel-team@fb.com,
	shakeel.butt@linux.dev,
	wqu@suse.com,
	willy@infradead.org,
	mhocko@kernel.org,
	muchun.song@linux.dev,
	roman.gushchin@linux.dev,
	hannes@cmpxchg.org
Subject: [PATCH v3 0/4] introduce uncharged file mapped folios
Date: Mon, 18 Aug 2025 17:36:52 -0700
Message-ID: <cover.1755562487.git.boris@bur.io>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I would like to revisit Qu's proposal to not charge btrfs extent_buffer
allocations to the user's cgroup.

https://lore.kernel.org/linux-mm/b5fef5372ae454a7b6da4f2f75c427aeab6a07d6.1727498749.git.wqu@suse.com/

I believe it is detrimental to randomly account these global pages to
the cgroup using them, basically at random. A bit more justification
and explanation in the patches themselves.

---
Changelog:
v3:
- use mod_node_page_state since we will never count cgroup stats
- include Shakeel's patch that removes a WARNING triggered by this series
v2:
- switch from filemap_add_folio_nocharge() to AS_UNCHARGED on the
  address_space.
- fix an interrupt safety bug in the vmstat patch.
- fix some foolish build errors for CONFIG_MEMCG=n


Boris Burkov (3):
  mm/filemap: add AS_UNCHARGED
  mm: add vmstat for cgroup uncharged pages
  btrfs: set AS_UNCHARGED on the btree_inode

Shakeel Butt (1):
  memcg: remove warning from folio_lruvec

 fs/btrfs/disk-io.c         |  1 +
 include/linux/memcontrol.h |  5 +----
 include/linux/mmzone.h     |  3 +++
 include/linux/pagemap.h    |  1 +
 mm/filemap.c               | 29 +++++++++++++++++++++++++----
 mm/vmstat.c                |  3 +++
 6 files changed, 34 insertions(+), 8 deletions(-)

-- 
2.50.1


