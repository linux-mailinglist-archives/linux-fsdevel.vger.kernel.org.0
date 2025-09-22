Return-Path: <linux-fsdevel+bounces-62357-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C960B8EF04
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Sep 2025 06:33:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F40F8173E5D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Sep 2025 04:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51FEC1F3B98;
	Mon, 22 Sep 2025 04:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="j1yaAfC3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JBSFWVa5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C86A1C69D
	for <linux-fsdevel@vger.kernel.org>; Mon, 22 Sep 2025 04:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758515603; cv=none; b=PGxOtRv6dUFANNz7zfQe/kN1LIOvQWhP5Y9TzqRyFyfl1q7Gx9+bHof2j2AoZYKY65JQobcnO3DfFV85YaG08iltd2jCaHk3JyyqblxBdHwUTdVENaed2Lq7fAKNd1yA0IdYkUUEB79I0MorMM1Rp9wKNrRsHSHyleYrvdrQl/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758515603; c=relaxed/simple;
	bh=rz3CC4OwQAov0zlqNwwOc90Fgo0/syR/2tgT6eF6IH0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FDwIHWIyoe+iPUdlOPp0QMu6XpWs3taaznZUIWgIbyXGzOQJcwBtdjTacJnwIsW+nl9WO4QKH9Zf4EcnG/SqIqTDSTpuQAa1TKWeeiTq6kOrFUlkXL1iceeVDV1iqyFbXoreDhSJSpvmglSQYXJfZBliRNyBrObtZSpPrGTMd3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=j1yaAfC3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JBSFWVa5; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id B7F78EC0109;
	Mon, 22 Sep 2025 00:33:19 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Mon, 22 Sep 2025 00:33:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:reply-to:subject
	:subject:to:to; s=fm1; t=1758515599; x=1758601999; bh=rz3CC4OwQA
	ov0zlqNwwOc90Fgo0/syR/2tgT6eF6IH0=; b=j1yaAfC3OMbtS8j4V+OlzuowQc
	moNNZPMgNVaqCHMPj1LxlyYYno8m1qBzRW2hwfx8Ss8Ie5eIWfx2rhiq4PhXQTZ+
	TPtey/IcV627U16MHdHAm3lZ0kNEwwpg8jHth+wA4oSl2RJk0P+1KV1dudvnQ9q2
	LoamYm5vxdLK5JBS6IRJNBk2aktB4WSRZqMzs/YzwO2+GGkgE9Q68C0w+EtND/7O
	wLY195hQGnaq5F8JyKt+YKN/1bt4nziY2rvoIRtOAr9vACEZd8M0WT+5OTDygW/S
	6y4CMR2aw4/GVzpGDqvTHv03wAfWISMAgCL0dadwNnRfNbBkytPBilUpUpBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1758515599; x=1758601999; bh=rz3CC4OwQAov0zlqNwwOc90Fgo0/
	syR/2tgT6eF6IH0=; b=JBSFWVa5v3UwOUiPkrYwYFD4SGWOPSxkAIB/khiFF25u
	vZhSOSVV067pCwljKUI2trM4eoGclC9gbmEYGIEVmz8wg2TRjr1iK5osjP+iMYnH
	IAUtfq79QG0cq4l8+y2zTwmS3KlOdkk1s7GhppW8wRqocP7JS/3UsZ6cpc08Tx5I
	V+Fb7VK2nWNBUtjEOBU6I40euKueV1FvNBumw5Oi0stLgEDXUay20zvDs/MwOH6V
	12HHUfvD75+XxoaAEr080/Ql8gs9ZZiVuwGTpHd9Vg+p8lwlrHN2FzYuybHYsiN0
	JHXUk5HJVOq5uyexIs8CBtNelqy41qgNPQHRXumkeQ==
X-ME-Sender: <xms:j9HQaCHHZix6Fsx14VuS5TpRXZYP5kge7mpBRwMLz9KQddBsEe03qQ>
    <xme:j9HQaKvlHn14p9qZWh0S6M0lilyjgtk_WzoenRYulw3psZKLwvY3aIEnblskSPVfq
    a3GDXL5jx7BtA>
X-ME-Received: <xmr:j9HQaBtw8QpQ_yB2CLQ6S_SAcY-FgG2yA3h3QPXje0xrcH2qxuITgCnYjjJ1Bia2_IKdnxdpzpWDBrmKdsR4i6qmSZrxbiekhuJHyC0Ul1tl>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdehieeltdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdengfhmph
    hthicushhusghjvggtthculddutddmnecujfgurhephffvvefufffkofhrggfgsedtkeer
    tdertddtnecuhfhrohhmpefpvghilheurhhofihnuceonhgvihhlsgesohifnhhmrghilh
    drnhgvtheqnecuggftrfgrthhtvghrnhepgeetfeegtddtvdeigfegueevfeelleelgfej
    ueefueektdelieeikeevtdelveelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepnhgvihhlsgesohifnhhmrghilhdrnhgvthdpnhgspghrtghp
    thhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepvhhirhhoseiivghnih
    hvrdhlihhnuhigrdhorhhgrdhukhdprhgtphhtthhopehlihhnuhigqdhfshguvghvvghl
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhgrtghksehsuhhsvgdrtg
    iipdhrtghpthhtohepjhhlrgihthhonheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    sghrrghunhgvrheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghmihhrjeefihhlse
    hgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:j9HQaIDZrEEokXKpwc2ph9B5d0M9lVXVAsgg1HoCMExFSjDCKbH0gw>
    <xmx:j9HQaLMJsVKFNvf019VHAWxiKrZ6Op1dfR57HdRbXWEr8cg-9iBnrw>
    <xmx:j9HQaJzH0LaBRL8AIk3HXoZeGQIW1sJzeZ_cnAw4NYJuv4IwVzMEYg>
    <xmx:j9HQaDWFWAimdkqyDG_BwNNQDaU2USfKPpqQqUOPddhyC6OFguFPJA>
    <xmx:j9HQaO8kEqDSyOhisl2RwSfoltzbEle_rDFutihkOjuPnK7P6lAmjmbv>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Sep 2025 00:33:17 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: "Alexander Viro" <viro@zeniv.linux.org.uk>,
	"Christian Brauner" <brauner@kernel.org>,
	"Amir Goldstein" <amir73il@gmail.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: "Jan Kara" <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Subject: 
Date: Mon, 22 Sep 2025 14:29:47 +1000
Message-ID: <20250922043121.193821-1-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
Reply-To: NeilBrown <neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a re-re-revised selection of cleanups and API renaming which continues
my work to centralise locking of create/remove/rename operations.

Since v3 I've fixed a bug in 5/6 were I was using path-> where
I should have been using parent_path.

Thanks,
NeilBrown

 [PATCH v4 1/6] VFS/ovl: add lookup_one_positive_killable()
 [PATCH v4 2/6] VFS: discard err2 in filename_create()
 [PATCH v4 3/6] VFS: unify old_mnt_idmap and new_mnt_idmap in
 [PATCH v4 4/6] VFS/audit: introduce kern_path_parent() for audit
 [PATCH v4 5/6] VFS: rename kern_path_locked() and related functions.
 [PATCH v4 6/6] debugfs: rename start_creating() to

