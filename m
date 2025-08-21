Return-Path: <linux-fsdevel+bounces-58692-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 688EEB308A9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 23:55:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 402BE5A7611
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 21:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B74C2E9EC2;
	Thu, 21 Aug 2025 21:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="TtRxgGJT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZvMZ4not"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2B920766E;
	Thu, 21 Aug 2025 21:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755813312; cv=none; b=h0bHhdzV+LkCxm9L2sUEuiAq2GUgTUifFBPRz4YTzHa+cwAtZ5/yaDDrCJ3P/wy4RRH+4jJsF9v2Z3+SjdDyfROZnyZbEttSZoA+uuAFUjasaqCOLS7frIQ1FifGDbnudD84MJ71YqjKgnRHf7FW72ndK5lJ4zE6+XmQKAke0jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755813312; c=relaxed/simple;
	bh=P0mFJkiz2HMJ55XEoGvIpPbp5gcB0tYOBBeSXaOTU50=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YCGvGjEblLTu3pjFRvs9ucwqi1xee17FqESQzB1+uPN0DaC3OXcyOGO6U0qg14S5Co5vkAo3UGT0my9OLxCXh11vcc11XldWBO3o5I46VsiRIBvUQd1KLn6gr5gB/8OTpiaXojN7ZrSjISOPpgZZMCmV41PC6GZOtmn3Z+8HDWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=TtRxgGJT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZvMZ4not; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A92E57A0140;
	Thu, 21 Aug 2025 17:55:08 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 21 Aug 2025 17:55:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm1; t=1755813308; x=1755899708; bh=XtWHWCopUVQb2SD2YU/s0
	ucRlC4xraBcZGfo9PxpLrY=; b=TtRxgGJT7BCqDJxnitfo46+BAatMP7H8Gt4OX
	GD3i+jutYLtWRcT1Vom0jeZxHEXnKqBVJz+S4xw6HbHfcDLI2bd2ei1V+7Ebbeoa
	lbi2x3dPHGOgRGHhTmixNtytihU1xerplil4H+6aZKNki8iA+gCcO/QVuq3zBxKy
	BAj6CTGcCcgsh0P0lgiYzD6r8t1FI9EvJOALii8jid5F1E8Z2PUiwT2s20Fk2YrM
	d+Ut6sAh/C6nZLsN8YWN1ayH+2Gzf2S9bU3M5IQ2U9VDnHBB/Tc4AwKgOtvu5K+A
	x4+dWLSc1PG0fwPiko+Chka3SdUEtT0VcLM9UVtf2YRMK4/Xw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755813308; x=1755899708; bh=XtWHWCopUVQb2SD2YU/s0ucRlC4xraBcZGf
	o9PxpLrY=; b=ZvMZ4not7qHw0rSobjS2kIjctumomqiFxTuXs6nYBVi7W+lKQME
	OFHgfNDHTUgY7T+QbS/L6RUsRYw+4zdHeyoedy/sEqKuPdDzFziWiJMxevWRmiYC
	xmFdMcD8fpCcNRfyWGVHQNnBCECMU7YAPJmTS4XCJlZOHjnDxNDLZ0iyeEw3Uy2+
	dGh+FIPapwb1qaKXwArCJtv4oQ8s3OQ6/4s0tSq1By4sVLjDO1Pn0eRgGKONQ4mu
	V170j+4KZGAsgWYziIvV4FQ60IcoyJmeOp6JM9zQjTBqIkpksibXEOtWkzuDVc0h
	xMU9Y4G5zgCfpieeXltY0ILa69VguT5/H9A==
X-ME-Sender: <xms:u5WnaLL6ECbe-06Mfkdes9QihAsRdJYcWYpVbubwAQLsyyYLvA9wLw>
    <xme:u5WnaEpAGTVlLTvah7aKe2YrCy5vOZA4inIX56-fZBUHBP1NhRnX5Nr1JCByJ7qw6
    q-TuRfrhOlWNyrZg2E>
X-ME-Received: <xmr:u5WnaCytuebL1fvAOSvZBiC29vEEEh1VzLGb1uc-B3km_HlHVn7_blDPcX_WSHikpppLI3mCZxsloaCTnkpIde86aCk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduiedvvdejucetufdoteggodetrf
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
X-ME-Proxy: <xmx:u5WnaItRzaTziVeon9XijMTWjhlMSNOYJXTznHn0Fl7xQ4bixrR_BA>
    <xmx:u5WnaL0YPasEVfVe_1HejUAnol-cdN0FdwhJX7CC8d8k4GBryk1bYw>
    <xmx:u5WnaAB4af7ttrkD4obF4RvD2ETO_vniZXY5YCkXWAjUvk8BS_mazg>
    <xmx:u5WnaJC3JRo1dywVeUMLc_jLk4vBEEqwFHCdTjDm2ogkV2hS5CwKUA>
    <xmx:vJWnaKGP0zu5PKMd-Rf2prRyEzmOo2kvCqY-wTfm2tVSnxR0GVVky3Xy>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 Aug 2025 17:55:07 -0400 (EDT)
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
Subject: [PATCH v4 0/3] introduce kernel file mapped folios
Date: Thu, 21 Aug 2025 14:55:34 -0700
Message-ID: <cover.1755812945.git.boris@bur.io>
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

I believe it is detrimental to account these global pages to the cgroup
using them, basically at random. A bit more justification and explanation
in the patches themselves.

---
Changelog:
v4:
- change the concept from "uncharged" to "kernel_file"
- no longer violates the invariant that each mapped folio has a memcg
  when CONFIG_MEMCG=y
- no longer really tied to memcg conceptually, so simplify build/helpers
v3:
- use mod_node_page_state since we will never count cgroup stats
- include Shakeel's patch that removes a WARNING triggered by this series
v2:
- switch from filemap_add_folio_nocharge() to AS_UNCHARGED on the
  address_space.
- fix an interrupt safety bug in the vmstat patch.
- fix some foolish build errors for CONFIG_MEMCG=n



Boris Burkov (3):
  mm/filemap: add AS_KERNEL_FILE
  mm: add vmstat for kernel_file pages
  btrfs: set AS_KERNEL_FILE on the btree_inode

 fs/btrfs/disk-io.c      |  1 +
 include/linux/mmzone.h  |  1 +
 include/linux/pagemap.h |  2 ++
 mm/filemap.c            | 13 +++++++++++++
 mm/vmstat.c             |  1 +
 5 files changed, 18 insertions(+)

-- 
2.50.1


