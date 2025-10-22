Return-Path: <linux-fsdevel+bounces-65032-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E235BF9FC2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 06:47:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 260F219C82C5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 04:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10B001DF252;
	Wed, 22 Oct 2025 04:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="OV02CDmd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="p1CKaTPk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F3D1F099C
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Oct 2025 04:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761108435; cv=none; b=Xt/AWi7NlpX6Dffhks7f5B4eLfyqTW6NTMJTbhSaKo4JJJDHkqe2Mhi+Ombe4Cd2sRdvfPHUXaEdZOvxRJKLyixqNynUbq6x4GaV7/juSfLlbAuIqlQQQHipLBMvxwMquMwb8WT7PlvhuBrq5ehntgBgCHj1/NOUhJ3ECWOhbuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761108435; c=relaxed/simple;
	bh=SzNt1wY9Ks5NBZLi1qClit0LkcjipIIFQXzctSAicpQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p0pSqJHU13wD2EECusf30kzEzTop4roiS7KRDnV//GdpqOo9Q3T6VegMco4ZUJTy24Pu+p+4oo6mf6nxeG5jLkzhhmDIKAz4W0QafRjjzaKguZQz/8aCdJY2XVFSjphK7q/98ZGISzEu+FG7+Llar2/B718CEaPC5jOLwwV95so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=OV02CDmd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=p1CKaTPk; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 371CDEC00C2;
	Wed, 22 Oct 2025 00:47:12 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Wed, 22 Oct 2025 00:47:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:reply-to:subject
	:subject:to:to; s=fm2; t=1761108432; x=1761194832; bh=lE+rour0qG
	TckuQLrcQHQK1EM31eYaV0WmPTL7K8Ovw=; b=OV02CDmdddPMCnuu62gfKhnFdq
	uiA0FYcXIuDIte3b5R3XFF10V7Qpufuw589L5XZKqh8H0ur8nYhSglr7P/j6ImaP
	ze5BO+olpkga6up7eYlZsJWtAu1jI9JNpo16tH2xLR/CGCMqOGqlfjn72hdbWbgr
	p5VQeD1YIMpKJMYFucf1xSBHz4E2hFfFf8MYehV+ttZ97Wyo+3EUfPnLW8a1ldrd
	mluahngYrCoE/0XqwBuPaMFnlQMvAwtHy3p+Q66+ER/kklIIgZZ+szpVXIoAMmyW
	mIFtQ7XYJKIuVOXTfkyfQlRchB2noUlhlIVqpdidXcDqrV74uCAUrPR+LPMA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1761108432; x=1761194832; bh=lE+rour0qGTckuQLrcQHQK1EM31e
	YaV0WmPTL7K8Ovw=; b=p1CKaTPkGJKZQIWZUyH4DoMaej3JiG377lrXikyo36gB
	+Gr7Grczk/MZP5GbjtxrZtOhg2Iewpdd/MFXBYEQEVEGe6ZQlMwfgfn1VVzbPgBX
	w5N8rNiRZ5XmRLzaP8JrsaS8tsEm8C8R9RQGkFr+YN769iIdrBJRXM1rMykgukuH
	iuhXNJfzzEbb0X0q4M2KFIoee0Y3Mt0vjihXKN0ad1rfD0yOEkxRGaMcZCITCy8P
	Qen3QbiZ4Hen2yxim6inPn2c0bguCJLCOze+PDHwCdj0RoTx99o93NUHMFPMEai2
	5SD+c8ql9pu7Xrm1G+WjCHangjqOlugIdZfvmDMRXQ==
X-ME-Sender: <xms:z2H4aIJJHiI2r5BD2JK1AgZNJjJpLRnu4EbtZ2lSLpmYGsyFZ34q2A>
    <xme:z2H4aDE3-Mue9POhxZ8jD6-lgP2glzERgR5CdX7nJMQ3XKq4L3KxLdUtTZ3kvLPct
    7bA8DzW615pafaRnl9aV-nNQmZ5I5psNkIoi-6-j3oLvlnidN8>
X-ME-Received: <xmr:z2H4aHv8eUeygqoG-b5JCVDrpzynX7-rxZ91nZK2e_o1LW9ZRsBQc06AsRONg-lhjtH99-miEPMBHMjTqOuYFFjxoTGIys39thy-SwEE1zDS>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugedvieehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofhrggfgsedtkeertdertddtnecuhfhrohhmpefpvghilheurhho
    fihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnheple
    eiueeuhedtieehvdeukeffleelgedtudehheetgefhjeelvddvkeffteeghfevnecuffho
    mhgrihhnpehgihhthhhusgdrtghomhdpkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsgesohifnhhmrghi
    lhdrnhgvthdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpth
    htohepvhhirhhoseiivghnihhvrdhlihhnuhigrdhorhhgrdhukhdprhgtphhtthhopehl
    ihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epjhgrtghksehsuhhsvgdrtgiipdhrtghpthhtohepjhhlrgihthhonheskhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepsghrrghunhgvrheskhgvrhhnvghlrdhorhhgpdhrtghpth
    htoheprghmihhrjeefihhlsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:z2H4aKsG-XHUY08j5XEouHokh4jhKvwY0_ym-Bauj0h6wVuMEVRTuQ>
    <xmx:z2H4aNBU7Z3GuLIgmTD0GrJKS1fzK-btCU2ej_rdcnV5QVTK-a3WnQ>
    <xmx:z2H4aMNqr5YqHM6J-BGVA1IQ1yEfiWtBpRTLRd17CIVlq1tIZ6F3rw>
    <xmx:z2H4aGx7FJAWgxdEgRaTI7lzxo7nL_Dkk1ts4eLqrkNW-8EsLY_yVw>
    <xmx:0GH4aHhUkTdhHOe1_mzASANfvbUJX6m-ZIXR9cX0VrFgox9mNuLvZPR7>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Oct 2025 00:47:09 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: "Alexander Viro" <viro@zeniv.linux.org.uk>,
	"Christian Brauner" <brauner@kernel.org>,
	"Amir Goldstein" <amir73il@gmail.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: "Jan Kara" <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 00/14] Create and use APIs to centralise locking for directory ops.
Date: Wed, 22 Oct 2025 15:41:34 +1100
Message-ID: <20251022044545.893630-1-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
Reply-To: NeilBrown <neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

following is v3 of this patch set with a few changes as suggested by Amir. 
See particularly patches 06 09 13

Whole series can be found in "pdirops" branch of
   https://github.com/neilbrown/linux.git

v2: https://lore.kernel.org/all/20251015014756.2073439-1-neilb@ownmail.net/

Thanks,
NeilBrown

 [PATCH v3 01/14] debugfs: rename end_creating() to
 [PATCH v3 02/14] VFS: introduce start_dirop() and end_dirop()
 [PATCH v3 03/14] VFS: tidy up do_unlinkat()
 [PATCH v3 04/14] VFS/nfsd/cachefiles/ovl: add start_creating() and
 [PATCH v3 05/14] VFS/nfsd/cachefiles/ovl: introduce start_removing()
 [PATCH v3 06/14] VFS: introduce start_creating_noperm() and
 [PATCH v3 07/14] VFS: introduce start_removing_dentry()
 [PATCH v3 08/14] VFS: add start_creating_killable() and
 [PATCH v3 09/14] VFS/nfsd/ovl: introduce start_renaming() and
 [PATCH v3 10/14] VFS/ovl/smb: introduce start_renaming_dentry()
 [PATCH v3 11/14] Add start_renaming_two_dentries()
 [PATCH v3 12/14] ecryptfs: use new start_creating/start_removing APIs
 [PATCH v3 13/14] VFS: change vfs_mkdir() to unlock on failure.
 [PATCH v3 14/14] VFS: introduce end_creating_keep()

