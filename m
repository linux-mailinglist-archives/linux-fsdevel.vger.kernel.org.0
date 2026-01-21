Return-Path: <linux-fsdevel+bounces-74932-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eC+GDhRacWnLGAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74932-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 23:58:28 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D5B85F2AA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 23:58:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 102E5520D14
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 22:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B2114657D9;
	Wed, 21 Jan 2026 22:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="EeaQEH92";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Q3/YSv5C"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25FEC45BD5F;
	Wed, 21 Jan 2026 22:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769036124; cv=none; b=RaF7IxOKBzTHXpINsFx6Cap0+7amuG3HWEl873ZN7NeLIbh4++DvsfpiSskjB+rJ6GNib9REAMki+wcohG73lOI5hwkUZ9efQW/Uhk68oxNy+YF0RBHEKO8Ozf+20ZjQGlPdIKnBPopb/lVevM0SnAeP5xo47/rF4nMTXV4mzd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769036124; c=relaxed/simple;
	bh=9WQMlF9y3LYTmPX+PtpTQ9hy6hrX/EbrW7sKShnCTrk=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=qnO4PCL+LUAcRB3wBmivx+JLsviEdj0xQh9uHLw8wXCfWZxLl0096VDdwVc4G7CT+33Ea6MnubquYU82U+V38+fJV/faidZhBim/aj7HPCHPOC2BsEmPrEmpNDYzXKQEKKWIiazs3/GqJ7Q949RzykbIGpvxWj9HzrJUk3nMxTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=EeaQEH92; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Q3/YSv5C; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id CF7541D0006A;
	Wed, 21 Jan 2026 17:55:20 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Wed, 21 Jan 2026 17:55:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm2; t=
	1769036120; x=1769122520; bh=nR24qK0BOSEatIvWbtacTkHQc26YOJgPKoB
	IBDHjAgA=; b=EeaQEH92/W+83/D4vG11xnVozeMpzor9BwaxsGrZvW1f1GCTEyS
	nOVkPJIBNuao2fKxMi+SstMYzzh3/bD7bZlb3m/UxW3tl6IbFJSKYWLwmcyb5soA
	XQddR0Y37ZXqP3dcftdbVs/Lc7ad5pMYobX+6T+y6/SKUab4Kwh12hIjIwZRjIe4
	uESmOopXoEGTGYzTXTILghjhObpMBnKV3BqNyOkUFoUpKCgqlGB9P87wYMLEht0T
	9o9AesH137DdUYMoutWMQgIuE9aqsQcrNgQ9PQ+NtQFVw1ZmKy39rO2R1wEzvtwz
	txmC6I01GgNs4aKkV+Bfrva9QHfy4ufd9sQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1769036120; x=
	1769122520; bh=nR24qK0BOSEatIvWbtacTkHQc26YOJgPKoBIBDHjAgA=; b=Q
	3/YSv5Cfxy822xi4NLHJQ6VaMlfYG8ptFndHmt2p5OhOSVCrW+qakEcQ0d46qE+w
	vxS6JHBHjKqKcoqXApuyNOZXyre/uSPeTRi7e1xzNff/9oTK5b27xCKPM8ry4mMR
	0yjuf8ph75gNJacMqkFb64x/vSBUFHolEu7azSihaYXBii0Hch6F/YL/Y5vQobzH
	Ym0bjljkT4N5XEF/LvpsSKlhTnpAKaCWo/30SgaW6n0JOAoNLNmLsBpwDJl2ldWR
	5oRNjXnJH6Su2mEDkPab5FY/IjDFmNjQnM3YzwjN3Qf4lbQYCDUU8eF/gAmJIYAj
	LeoBehBPtB+fmXwPX8kNA==
X-ME-Sender: <xms:WFlxafv1VK9yiCa9QZxYaxbPzhzrxrDXNwrgXwu2-bHEJuOJMy9yqg>
    <xme:WFlxaWe1kkIhZHdPdNt2bwEE3TBV9eWaHLBd5CZtuWiVOlskIHShpeB38QDZLA6e7
    zoPsyVtM05L5A17_iRspFAA4Bpu_h0bXGJ_IEopPPR0G-uMBg>
X-ME-Received: <xmr:WFlxadkvJkizcEytJdlUDUudwLkV7C5FRB8W3Qe9DmrMELW1I3BA4M77h8WetZIfpKZ6ZW2OQyDd-MmoEjRI3B-lrmcCa_9gp4D7qm41OiAH>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugeegheefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurheptgfgggfhvfevufgjfhffkfhrsehtqhertddttdejnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epleejtdefgeeukeeiteduveehudevfeffvedutefgteduhfegvdfgtdeigeeuudejnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsg
    esohifnhhmrghilhdrnhgvthdpnhgspghrtghpthhtohepuddtpdhmohguvgepshhmthhp
    ohhuthdprhgtphhtthhopehlihhnuhigqdhnfhhssehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehlihhnuhigqdgtrhihphhtohesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopegthhhutghkrdhlvghvvghrsehorhgrtghlvgdrtghomhdp
    rhgtphhtthhopehtrhhonhgumhihsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehjlh
    grhihtohhnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegvsghighhgvghrsheskhgv
    rhhnvghlrdhorhhgpdhrtghpthhtoheprghnnhgrsehkvghrnhgvlhdrohhrghdprhgtph
    htthhopegstghougguihhngheshhgrmhhmvghrshhprggtvgdrtghomh
X-ME-Proxy: <xmx:WFlxaRBmvROrZDFk3dBHdWxIbO8smBT4gF4UHgACugM0L-MsW0IUlw>
    <xmx:WFlxafOWkRF3GXHb_alDOUFQF8OzIP6I9ZMoZOvh1XE3j0vOD7Rvlw>
    <xmx:WFlxaYMdGI1gBk150Dhg3mS5Pz25yEKYXuflQnTufejaY4gE9i_vwg>
    <xmx:WFlxaXmG2oO0UGe2YtTI9AffkrvFstfaLdehYmeyTBHUhSiLK5501A>
    <xmx:WFlxaUIMGb1sLbfBDe_KjBFp_OxyH5eRPWQWkwyuc--AfZHhCgI9jDIV>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Jan 2026 17:55:17 -0500 (EST)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Benjamin Coddington" <bcodding@hammerspace.com>
Cc: "Chuck Lever" <chuck.lever@oracle.com>, "Jeff Layton" <jlayton@kernel.org>,
 "Trond Myklebust" <trondmy@kernel.org>, "Anna Schumaker" <anna@kernel.org>,
 "Benjamin Coddington" <bcodding@hammerspace.com>,
 "Eric Biggers" <ebiggers@kernel.org>, "Rick Macklem" <rick.macklem@gmail.com>,
 linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-crypto@vger.kernel.org
Subject: Re: [PATCH v2 0/3] kNFSD Signed Filehandles
In-reply-to: <cover.1769026777.git.bcodding@hammerspace.com>
References: <cover.1769026777.git.bcodding@hammerspace.com>
Date: Thu, 22 Jan 2026 09:55:15 +1100
Message-id: <176903611574.16766.10534751557103722262@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[ownmail.net:s=fm2,messagingengine.com:s=fm2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[ownmail.net,none];
	TAGGED_FROM(0.00)[bounces-74932-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[oracle.com,kernel.org,hammerspace.com,gmail.com,vger.kernel.org];
	FREEMAIL_FROM(0.00)[ownmail.net];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[neilb@ownmail.net,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[ownmail.net:+,messagingengine.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	HAS_REPLYTO(0.00)[neil@brown.name];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[brown.name:replyto,noble.neil.brown.name:mid,ams.mirrors.kernel.org:helo,ams.mirrors.kernel.org:rdns,ownmail.net:dkim,messagingengine.com:dkim]
X-Rspamd-Queue-Id: 1D5B85F2AA
X-Rspamd-Action: no action

On Thu, 22 Jan 2026, Benjamin Coddington wrote:
> The following series enables the linux NFS server to add a Message
> Authentication Code (MAC) to the filehandles it gives to clients.  This
> provides additional protection to the exported filesystem against filehandle
> guessing attacks.
>=20
> Filesystems generate their own filehandles through the export_operation
> "encode_fh" and a filehandle provides sufficient access to open a file
> without needing to perform a lookup.  A trusted NFS client holding a valid
> filehandle can remotely access the corresponding file without reference to
> access-path restrictions that might be imposed by the ancestor directories
> or the server exports.
>=20
> In order to acquire a filehandle, you must perform lookup operations on the
> parent directory(ies), and the permissions on those directories may prohibit
> you from walking into them to find the files within.  This would normally be
> considered sufficient protection on a local filesystem to prohibit users
> from accessing those files, however when the filesystem is exported via NFS
> an exported file can be accessed whenever the NFS server is presented with
> the correct filehandle, which can be guessed or acquired by means other than
> LOOKUP.
>=20
> Filehandles are easy to guess because they are well-formed.  The
> open_by_handle_at(2) man page contains an example C program
> (t_name_to_handle_at.c) that can display a filehandle given a path.  Here's
> an example filehandle from a fairly modern XFS:
>=20
> # ./t_name_to_handle_at /exports/foo=20
> 57
> 12 129    99 00 00 00 00 00 00 00 b4 10 0b 8c
>=20
>           ^---------  filehandle  ----------^
>           ^------- inode -------^ ^-- gen --^
>=20
> This filehandle consists of a 64-bit inode number and 32-bit generation
> number.  Because the handle is well-formed, its easy to fabricate
> filehandles that match other files within the same filesystem.  You can
> simply insert inode numbers and iterate on the generation number.
> Eventually you'll be able to access the file using open_by_handle_at(2).
> For a local system, open_by_handle_at(2) requires CAP_DAC_READ_SEARCH, which
> protects against guessing attacks by unprivileged users.

"Simple testing confirms that the correct generation number can be found
withing XXX minutes using open_by_handle_at() and it is estimated that
adding network delay with genuine NFS calls would only increase this to
YYY minutes (ZZZ hours)".

>=20
> In contrast to a local user using open_by_handle(2), the NFS server must
> permissively allow remote clients to open by filehandle without being able
> to check or trust the remote caller's access. Therefore additional
> protection against this attack is needed for NFS case.  We propose to sign
> filehandles by appending an 8-byte MAC which is the siphash of the
> filehandle from a key set from the nfs-utilities.  NFS server can then
> ensure that guessing a valid filehandle+MAC is practically impossible
> without knowledge of the MAC's key.  The NFS server performs optional
> signing by possessing a key set from userspace and having the "sign_fh"
> export option.
>=20
> Because filehandles are long-lived, and there's no method for expiring them,
> the server's key should be set once and not changed.  It also should be
> persisted across restarts.  The methods to set the key allow only setting it
> once, afterward it cannot be changed.  A separate patchset for nfs-utils
> contains the userspace changes required to set the server's key.
>=20
> I had planned on adding additional work to enable the server to check wheth=
er the
> 8-byte MAC will overflow maximum filehandle length for the protocol at
> export time.  There could be some filesystems with 40-byte fileid and
> 24-byte fsid which would break NFSv3's 64-byte filehandle maximum with an
> 8-byte MAC appended.  The server should refuse to export those filesystems
> when "sign_fh" is requested.  However, the way the export caches work (the
> server may not even be running when a user sets up the export) its
> impossible to do this check at export time.  Instead, the server will refuse
> to give out filehandles at mount time and emit a pr_warn().
>=20
> Thanks for any comments and critique.

Thanks,
NeilBrown

