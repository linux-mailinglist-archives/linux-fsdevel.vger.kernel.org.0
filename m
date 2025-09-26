Return-Path: <linux-fsdevel+bounces-62838-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DBECBA23E6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Sep 2025 04:50:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4554A385C78
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Sep 2025 02:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFA3F246BA4;
	Fri, 26 Sep 2025 02:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="I6qyT/Ne";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cqiIoHAe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E7B17996
	for <linux-fsdevel@vger.kernel.org>; Fri, 26 Sep 2025 02:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758855032; cv=none; b=c4xQkjCHHxBKowlJ/pvvPqbK7x5ZAJEH44Ii8HWb6EXD8dVKORIntJwW0U5OTyXOrmmHBA6DHnvwnmC9tFl8+4fGqul3GxkMU5pHaou+f5PidmIZwhvueElzkelUK7/vqeXT27EUi4mU8LU02xKw9CkfYffICarB0Hm7qzQMRz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758855032; c=relaxed/simple;
	bh=pMsOS46pP3H8EbGB5G7zt8nO6cxr7IMFmPwgjYllMYE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EyrXchYjNldfuxKNI+0JP7KSS7uqZx033z7Wa10UP/BMbj/qsCLR5YbMKLJsOiDRy34obsNrwbFDH2Q9lbf+mH5H8mHf2i6aiCspG5GtNZeQ7UMD6UTdwdoS8QFmA81UQdXsbkwDB24AnIsi6zI+xpRDqFRL7Ej2O/fSlKCQWyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=I6qyT/Ne; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cqiIoHAe; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id BF332EC01C9;
	Thu, 25 Sep 2025 22:50:28 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Thu, 25 Sep 2025 22:50:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:reply-to:subject
	:subject:to:to; s=fm1; t=1758855028; x=1758941428; bh=oc3B3OciCa
	x6/pGQStW4nJhpQLXcaiUUlsGiXwIpV10=; b=I6qyT/NeNicgnKgQMVJE6/1LQD
	cLLEfXu/OGE33nET4K2Mo4IOKhQShyaBnTZO/NRuN1l7Z3ZIOqEq/z8RkS341TOa
	fUa5fxLnwOBApcNiYWcQuXI2ptefdssDXHMGd3rPRdnGDEcHQImj6xRiY6kwZfHl
	3kFHl+prIpTSEKBuS7z1dfUY2x/zmmQp5PQU6Lyezng64/rvaE9u54FYWjna6XXw
	JMswm7n3pWxZGoeFXNIiGBCMPp/BCGpTOkeCYh5ut508idZEMePvdWq8iqCqOVlG
	HtP7gtFPigTD1EmCdWI8oXp0qKhU19YuIhgYoTBJg8yX2Gld9kompLRF00Kw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1758855028; x=1758941428; bh=oc3B3OciCax6/pGQStW4nJhpQLXc
	aiUUlsGiXwIpV10=; b=cqiIoHAefjacZrSkW2QjTnBEZgF4EwD6tk1RSsp38U7N
	0rB3fCl09dL5URwR6jIz0SRqdL9HINAzFCA9wqHB8huMtAx/+67slY8CZKdPdwCN
	xH7dF1kGUuxJHDOvGbcYjJLXIg9H6JEzeyHnj5XXEit6XkMdcuM1Imgh53b0L86V
	+S0j5NBn700kvLxPrRe6sUc7oFhgeVfzG4zAELfYwU1TDl+YmE7BnOQQtk7le5eF
	mffa6m2EP9VtqCm2arAJc+W9oQaImrzIUru6qI6Q5AIugehzgR94KkhLa/YgcN0Q
	UBGT7NKVg0qC7fqM+OQt42Pvq2Ih4dpfqqe/75cJBQ==
X-ME-Sender: <xms:dP_VaOviogB_xLGFCkKpfPgIYXfJRFA-JedEMBfRa8WHz32c8J-P1Q>
    <xme:dP_VaObeDScHb7AFHx7Pk3TPP1BMVcPDDlnkITIHQPVv0tla6Cl7VyN7zcrsO7sUs
    JsTnG9tXN8TWrk9qJFE6xjAuOSLZQhIleLO7H2F1mH3XeqsbQ>
X-ME-Received: <xmr:dP_VaIwCOxXRLID7CvVfJfidPjs4XxBpA2GhfX-2ckw4h4rOwbJlhBut3tzEP-4BHQYjO54qrysf4rmR9kG0tnxgAhzUOdo1KjQyB15Rz3KP>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeikedvudcutefuodetggdotefrod
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
X-ME-Proxy: <xmx:dP_VaOjhR871biz_YcQKmYWbXb-0oOSBy-SS5rT5DH0BeqtazjKL8w>
    <xmx:dP_VaMl7tcZiq2ogsPKrhgDcBbxK5lZYAnsW867KMoj1ZEFof5nziA>
    <xmx:dP_VaMi4d6KkqmPhLOH3x-xJO3tfoQ7xYdWR3oivVqsn9zsC8sXSfw>
    <xmx:dP_VaI0xEs0n0JfdWgjuZ3SwM8aLJxRDtqjYkNCWKg-Ytf5h_jLPmQ>
    <xmx:dP_VaKzkk6xIl-Ikzf6nOjA1T0MdWqwFrgYKhfMyVw9EBjg4ZpVOy83i>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 Sep 2025 22:50:26 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: "Alexander Viro" <viro@zeniv.linux.org.uk>,
	"Christian Brauner" <brauner@kernel.org>,
	"Amir Goldstein" <amir73il@gmail.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: "Jan Kara" <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 00/11] Create APIs to centralise locking for directory ops
Date: Fri, 26 Sep 2025 12:49:04 +1000
Message-ID: <20250926025015.1747294-1-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
Reply-To: NeilBrown <neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is the next batch in my ongoing work to change directory op locking.

The series creates a number of interfaces that combine locking and lookup, or
sometimes do the locking without lookup.
After this series there are still a few places where non-VFS code knows
about the locking rules.  Places that call simple_start_creating()
still have explicit unlock on the parent (I think).  Al is doing work
on those places so I'll wait until he is finished.
Also there explicit locking one place in nfsd which is changed by an
in-flight patch.  That lands it can be updated to use these interfaces.

The first patch here should have been part of the last patch of the
previous series - sorry for leaving it out.  It should probably be
squashed into that patch.

I've combined the new interface with changes is various places to use
the new interfaces.  I think it is easier to reveiew the design that way.
If necessary I can split these out to have separate patches for each place
that new APIs are used if the general design is accepted.

NeilBrown

 [PATCH 01/11] debugfs: rename end_creating() to
 [PATCH 02/11] VFS: introduce start_dirop() and end_dirop()
 [PATCH 03/11] VFS/nfsd/cachefiles/ovl: add start_creating() and
 [PATCH 04/11] VFS/nfsd/cachefiles/ovl: introduce start_removing() and
 [PATCH 05/11] VFS: introduce start_creating_noperm() and
 [PATCH 06/11] VFS: introduce start_removing_dentry()
 [PATCH 07/11] VFS: add start_creating_killable() and
 [PATCH 08/11] VFS/nfsd/ovl: introduce start_renaming() and
 [PATCH 09/11] VFS/ovl/smb: introduce start_renaming_dentry()
 [PATCH 10/11] Add start_renaming_two_dentrys()
 [PATCH 11/11] ecryptfs: use new start_creaing/start_removing APIs

