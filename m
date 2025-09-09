Return-Path: <linux-fsdevel+bounces-60609-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 87A56B4A0E1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Sep 2025 06:48:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 600D81BC2A38
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Sep 2025 04:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B90445945;
	Tue,  9 Sep 2025 04:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="DWY4lzRe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="noEaJDOA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F7762D94B8
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Sep 2025 04:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757393308; cv=none; b=LVyuBLyb7RRE9HRoeSWjJQulG6eUosdf6F4RYJb4OX/8/PjUlhkHWOOuHZySp2pfhFNFAd2ytfqKa0s0Gyj3R2wtdS/8Sr7Nx8k7DlmpegFx9Nwx88u2PJJ/lsKCPwtN6pqsnS3hfMN0BLRCeXQ17ta6m/FReKWhZ52jROcnS1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757393308; c=relaxed/simple;
	bh=SElxd4oqBB5d91elXmVbh8FaJpLqhPc9/nOHDZWurqs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oPXgxiyW8QjLZbr1ruu6kUUEp4fzSmhsCnkPVA2w28IjKhWX68IzhaWLIZUXxEoe2EY02NYcdkXKHtnFx9U+TyJQCWI/bzPxwKu9h53bntUCYd8yfWvZEizXBXdtkWEkID9hai67+4SSdcjs/fvoCrTmkEg9mr2cdfnUhlMcRIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=DWY4lzRe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=noEaJDOA; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7762F7A00BC;
	Tue,  9 Sep 2025 00:48:24 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 09 Sep 2025 00:48:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:reply-to:subject
	:subject:to:to; s=fm1; t=1757393304; x=1757479704; bh=SElxd4oqBB
	5d91elXmVbh8FaJpLqhPc9/nOHDZWurqs=; b=DWY4lzReo00wzDsklc5CnNEHR5
	IQ4VSmdJwlvx4Yf3O+mJ+3XePMvI+3BgmlboNSs4/1auyi0I7djoQw5Uvct+LTDg
	cdNmjJ9DK5ikgXIug9whgIrBfyawylVMB9cBYaHT4TZEo2De8de+JZ/e+3szoIF7
	s0DsmNn3RBqVjXHVUySFhdzaGIrNf6Ey8L84kl+ov73EqrUtW4OAPf/60fWzBPBt
	fKKZcmnaU1QrTa4kjhUq8FBwJFcLPfsAjyOH53qPBY9nepNcwzd14LOil8AhJYHC
	qoYa+fVWIQtbzjUF5sjPPSNhJRDfal1vkdGPu/agm6M8DP5sGly0UuaST2FQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1757393304; x=1757479704; bh=SElxd4oqBB5d91elXmVbh8FaJpLq
	hPc9/nOHDZWurqs=; b=noEaJDOAh4TEIyzfKzpwvt4MmWaEEU4cQwHY133zAW5j
	CQvUQXVlA4AlIIfPoxjK8ZmuoF58GQ+Tiys302UrnFzBQTILkuQozqBxB9+/kBxw
	9ycAw5yx2b6DHBYzzL/G19omPfXV15gnV1e2GYCqRhdv71atQ++n/HhXHAccNJ04
	Lz4D2YGzPCLUjkrDJMgBRARJsegYlzeCqPGE5zkk4qXEQQUOIkXwkFjbCF5ld6+b
	//WTzMl2goBMk9NV99co+BjTLxpFXGsR092/bFc5MMg6fiUJ0rkQuBOCNaonbCEb
	pTLWIrKDrsECEk3Y/WMVD36cnubdtzAaA2RQ+ux1Jg==
X-ME-Sender: <xms:l7G_aIoXAvmpOwByrBndNoc8aXp5wso87UnNcqkwnpettVOeZD7cfQ>
    <xme:l7G_aGB4SlQ3ieUskVHpl7jejscYjVxpgY_oRAXW2X8DtCTZDYx9le49zNBkH0UGE
    wTmOmamx4dTbw>
X-ME-Received: <xmr:l7G_aCyFKQMI2E57MVBy0UwEUzXw0KHT7-wbBDlh46KSLlUjWtsz2ij2Py705zspiR_7t_RtEr0N3V_82YW3atn3d9uIrx78WVzQQOt-I4KL>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduleeglecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkfforhgggfestdekredtredttdenucfhrhhomheppfgvihhluehrohif
    nhcuoehnvghilhgssehofihnmhgrihhlrdhnvghtqeenucggtffrrghtthgvrhhnpeegte
    efgedttddviefggeeuveefleellefgjeeufeeukedtleeiieekvedtleevleenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehnvghilhgssehofi
    hnmhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdp
    rhgtphhtthhopehvihhrohesiigvnhhivhdrlhhinhhugidrohhrghdruhhkpdhrtghpth
    htoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehjrggtkhesshhushgvrdgtiidprhgtphhtthhopehjlhgrhihtohhnsehkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopegsrhgruhhnvghrsehkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopegrmhhirhejfehilhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:l7G_aL0XJ35HNRjql2t-tmDrX7I5zHWJmIAJ9q08NBJk9RMRWXBO8g>
    <xmx:l7G_aKxX5CyOy7mUpDMRD0XtWwAsaWhAUtu3DEF5SRfbbtRQGU66MA>
    <xmx:l7G_aKGwQoYTcFy8SSu6Uku5OganFAiebS8DrpyrGgudF8CGFXh_Mw>
    <xmx:l7G_aFY6z9lxVgyoWsvzpQEdWFN1Py3UnPgiBEdlE2o02mUtqd6g9w>
    <xmx:mLG_aLBa25vIyVrdY3pgEzIysTNWR3-DydHllhed3R4f6WXGaqA6tNEe>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Sep 2025 00:48:21 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: "Alexander Viro" <viro@zeniv.linux.org.uk>,
	"Christian Brauner" <brauner@kernel.org>,
	"Amir Goldstein" <amir73il@gmail.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: "Jan Kara" <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 0/8] VFS: more prep for change to directory locking
Date: Tue,  9 Sep 2025 14:43:14 +1000
Message-ID: <20250909044637.705116-1-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
Reply-To: neil@brown.name
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a revised selection of cleanups and API renaming which continues
my work to centralise locking of create/remove/rename operations.

I've removed a procfs cleanup which conflicts slightly with some of Al's
work, and added more renaming, and have added some more places that use
simple_start_creating().

Thanks,
NeilBrown

 [PATCH v2 1/7] VFS/ovl: add lookup_one_positive_killable()
 [PATCH v2 2/7] VFS: discard err2 in filename_create()
 [PATCH v2 3/7] VFS: unify old_mnt_idmap and new_mnt_idmap in
 [PATCH v2 4/7] VFS/audit: introduce kern_path_parent() for audit
 [PATCH v2 5/7] VFS: rename kern_path_locked() and related functions.
 [PATCH v2 6/7] VFS: introduce simple_end_creating() and
 [PATCH v2 7/7] Use simple_start_creating() in various places.

