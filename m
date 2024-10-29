Return-Path: <linux-fsdevel+bounces-33119-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1ECB9B4A97
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Oct 2024 14:06:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AB35283706
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Oct 2024 13:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D165D1F9A99;
	Tue, 29 Oct 2024 13:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=verbum.org header.i=@verbum.org header.b="htx5LW66";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hdTnuEst"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC40C2ED;
	Tue, 29 Oct 2024 13:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730207179; cv=none; b=dtTYjUsjPhYYRf3ZPkqApelhpWXS9W7rjXDI8azhA7EUCpdEKKs9zY/H4Oh69ufmaIQpSAbuNm8tnZoYnA5cdGzI9jcRTe5TY1EaJbj6TZOQHOtpVX3nMrpznsLfvd7ADcWX1ilu4B7E8djOJStCgvA/H+5G0bVeZBjBUqPEaPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730207179; c=relaxed/simple;
	bh=QleypBxJn8If2RWVSbl8Pp5FeUrE3q9hmNgkiJKFEaM=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=UalroMsyKe0BxfTWzf3dZYbQqXtJSRXtK7e0VzX8LFk+SB8S+6PiwRlAmn3//oFoRaER7XIwcrSs8nH89YJTZgeUaHEce+EvNM9Haavmv9lUFw23SSE1Z12vpKQ2RUnskEn28pDielnCpRRYqUsDerOXJazHEVbSfo2jIh3NWrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=verbum.org; spf=pass smtp.mailfrom=verbum.org; dkim=pass (2048-bit key) header.d=verbum.org header.i=@verbum.org header.b=htx5LW66; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hdTnuEst; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=verbum.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=verbum.org
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 01FA013801DB;
	Tue, 29 Oct 2024 09:06:15 -0400 (EDT)
Received: from phl-imap-06 ([10.202.2.83])
  by phl-compute-02.internal (MEProxy); Tue, 29 Oct 2024 09:06:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=verbum.org; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1730207174;
	 x=1730293574; bh=XLLBVut8GOrp3tS5VCMMSWrOKO/rTUWowoPATf5dH/I=; b=
	htx5LW66m+M6qMB4rSlvAyqVLzb2eSpf5RZAWAIB5QTskB1yMdgGiEcGKE0qVyu3
	Xz3QGkpJaRdQ7jsNCcXHzgD1VhK82LkKNXZNMunzPw8t2elCf5okPeDF3QHoWbzN
	bXTTlszR1Q8LKpE8WUZmmE7jpa+k3wLAPCpl1keanNqFMWcciC0EzVCtuF/HxmDj
	NwH3ok4EzWWLkSyTaKtMt3cluzmSj9yaUBgrjhfSlNWnf61acJSNK0RIhXuhrIfM
	l2+JnLZZDoflkzonRuExE585jjIqZQL0anukYWy39duUiblLhVsuID0BnzgozzVA
	fmUu2Nxb0z+r5IhOsAyA3w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1730207174; x=
	1730293574; bh=XLLBVut8GOrp3tS5VCMMSWrOKO/rTUWowoPATf5dH/I=; b=h
	dTnuEstGSdFLLFzfZnzQjjNme+w21T4HtWKiR4TmJOrVdn+c/VS8vPCodzvF5i2h
	+TEwnOM6MS2ZO0IuLdp5Ve0ckfrWl0BcdWdEJpifgGpvRB10Uh7J/RFVQbbgFWhg
	WSbStNdIIQFNKKd5rn4VqdZ5ZXfiTS0ba6TFkqPfynTC1cSLgyCDMk9vy2EGlNDR
	eA38+9gg/ktTWu03ikWkXQo6eboUugmB++ZjKn1Te6vm8ipTGFePrI4yz9VLJraB
	GFagNHo+b2FWhs2L0de/ADOLr6Ug3bqehQZi5GPpM998/k1dKGFLg7pu1+1IgdTg
	8Ip/eNgs30+vym1qC8sZA==
X-ME-Sender: <xms:xt0gZ3lKpJXtmV8QxTAgYFj6sK2HtyzAYNxjy7IWWvgWzG_yxv9g_w>
    <xme:xt0gZ62HXi-NxAsvZrSfIbD0Vsc-tsQHcnba0sDOzt-lV50ZLdnkr8ApD25EkXhXP
    ojUIaN62OBnydaR>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdekuddggeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddt
    necuhfhrohhmpedfveholhhinhcuhggrlhhtvghrshdfuceofigrlhhtvghrshesvhgvrh
    gsuhhmrdhorhhgqeenucggtffrrghtthgvrhhnpedviefhjeeiieejtdeutdeuuddvffeu
    udfgvdettdeuffejhedtleejieeuffefhfenucffohhmrghinhepghhithhhuhgsrdgtoh
    hmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepfigr
    lhhtvghrshesvhgvrhgsuhhmrdhorhhgpdhnsggprhgtphhtthhopeehpdhmohguvgepsh
    hmthhpohhuthdprhgtphhtthhopegrmhhirhejfehilhesghhmrghilhdrtghomhdprhgt
    phhtthhopegsrhgruhhnvghrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopeiilhgrnh
    hgsehrvgguhhgrthdrtghomhdprhgtphhtthhopehlihhnuhigqdhfshguvghvvghlsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidquhhnihhonhhfsh
    esvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:xt0gZ9qKASoGp6JpX8Op8uVuprQ9dj2q0BWfPRLMYvlMT8RDDf6U6Q>
    <xmx:xt0gZ_lmQ5esfXZjXaHC5zP7s29A3Mcy_pjAunrUmH1VRDkCpdRpzQ>
    <xmx:xt0gZ11SBg5RT7UQReBotUG3AUjcrPE4mZFLA5_Mvg3fhscDfcYR-A>
    <xmx:xt0gZ-s7U7uQGmqWowlc9N0cezP_clIeD0bR_HZBlAq7PFj2Uw9RBg>
    <xmx:xt0gZwQjzzLDo7DT8F6brwjkw4Qoyr8QWDxHdbPsdMapCzbKmUVo2PIO>
Feedback-ID: ibe7c40e9:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id B1AD829C006F; Tue, 29 Oct 2024 09:06:14 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 29 Oct 2024 09:05:54 -0400
From: "Colin Walters" <walters@verbum.org>
To: "Christian Brauner" <brauner@kernel.org>, "Zorro Lang" <zlang@redhat.com>
Cc: "Amir Goldstein" <amir73il@gmail.com>, linux-unionfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
Message-Id: <474e70f3-38d1-4c6d-9847-62d692bcb2f8@app.fastmail.com>
In-Reply-To: <20241028-eigelb-quintessenz-2adca4670ee8@brauner>
References: 
 <20241026180741.cfqm6oqp3frvasfm@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <20241028-eigelb-quintessenz-2adca4670ee8@brauner>
Subject: Re: lots of fstests cases fail on overlay with util-linux 2.40.2 (new mount
 APIs)
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Mon, Oct 28, 2024, at 8:22 AM, Christian Brauner wrote:
> On Sun, Oct 27, 2024 at 02:07:41AM +0800, Zorro Lang wrote:
>> Hi,
>> 
>> Recently, I hit lots of fstests cases fail on overlayfs (xfs underlying, no
>> specific mount options), e.g.
>> 
>> FSTYP         -- overlay
>> PLATFORM      -- Linux/s390x s390x-xxxx 6.12.0-rc4+ #1 SMP Fri Oct 25 14:29:18 EDT 2024
>> MKFS_OPTIONS  -- -m crc=1,finobt=1,rmapbt=0,reflink=1,inobtcount=1,bigtime=1 /mnt/fstests/SCRATCH_DIR
>> MOUNT_OPTIONS -- -o context=system_u:object_r:root_t:s0 /mnt/fstests/SCRATCH_DIR /mnt/fstests/SCRATCH_DIR/ovl-mnt
>> 
>> generic/294       [failed, exit status 1]- output mismatch (see /var/lib/xfstests/results//generic/294.out.bad)
>>     --- tests/generic/294.out	2024-10-25 14:38:32.098692473 -0400
>>     +++ /var/lib/xfstests/results//generic/294.out.bad	2024-10-25 15:02:34.698605062 -0400
>>     @@ -1,5 +1,5 @@
>>      QA output created by 294
>>     -mknod: SCRATCH_MNT/294.test/testnode: File exists
>>     -mkdir: cannot create directory 'SCRATCH_MNT/294.test/testdir': File exists
>>     -touch: cannot touch 'SCRATCH_MNT/294.test/testtarget': Read-only file system
>>     -ln: creating symbolic link 'SCRATCH_MNT/294.test/testlink': File exists
>>     +mount: /mnt/fstests/SCRATCH_DIR/ovl-mnt: fsconfig system call failed: overlay: No changes allowed in reconfigure.
>>     +       dmesg(1) may have more information after failed mount system call.
>
> In the new mount api overlayfs has been changed to reject invalid mount
> option on remount whereas in the old mount api we just igorned them.
> If this a big problem then we need to change overlayfs to continue
> ignoring garbage mount options passed to it during remount.

https://github.com/ostreedev/ostree/commit/bc62fd519631be6591c5c62302f83b45b9d56328 is related...I probably should have reported it at the time.

