Return-Path: <linux-fsdevel+bounces-79454-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YBZqEHrbqGnGxwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79454-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Mar 2026 02:25:14 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A641D209CC2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Mar 2026 02:25:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5C803303C00F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Mar 2026 01:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1208823FC5A;
	Thu,  5 Mar 2026 01:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="fS1CK1OA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="zUZbV8qF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-a7-smtp.messagingengine.com (flow-a7-smtp.messagingengine.com [103.168.172.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF1516A395;
	Thu,  5 Mar 2026 01:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772673892; cv=none; b=HUNGic+pbZouFe+KSkUfL2tW5TQ8+Ml8khUJ+epidq2oiLEcDvFmZ7Vsl4NqmT6FHCEv09ZJah5DE0kWHQYmU+9o+VGdDbZkdGV7PT616behYBbc4Mr3OhNNuGwYTPC1mNFFLNjrlVw3osIIYYZQzX0b4vh6bPfgTI7C1AzR8Bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772673892; c=relaxed/simple;
	bh=PMX6JyRSnu2E5Zy7NOXER9HT8+AOuMaqShL4u2efzKc=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=QLmUCPH9PaXLPZ637KqL69LpR+Qt0Ad+xDWrQ+UlT7uYVuQezD+sPGUP2Tbo73hzo13uwZrfqK2LmqeDJnO+4omLu8Qwnrt7OwyCBnT/fPJLQYWpb4Zi820rPIJlrHWQBPPg0zMxXRktZ4aYtq51fV5iqmrCB3FCJO6rcBxlhRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=fS1CK1OA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=zUZbV8qF; arc=none smtp.client-ip=103.168.172.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailflow.phl.internal (Postfix) with ESMTP id 0F5ED1380E14;
	Wed,  4 Mar 2026 20:24:49 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Wed, 04 Mar 2026 20:24:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm1; t=
	1772673889; x=1772681089; bh=pHow27CTfPDvgGL29iyDc6nQ4fjpzyYL5lv
	mt+hLriQ=; b=fS1CK1OAQhIegJ19aVS0NBBw14oXk8mzezIRJvAKaXQt6wZk1QN
	QyLs07K4449ND+SR7dhuFNaz+DkpMCENe9edX65fMOZE8vNIETM4ctq15oQJ1xAj
	IASPRLB3GuikAUa+P85jb1NzwDHQVSJaLr3PiCo5pjUpXgZMT6tUnaKsZPUpMoTB
	q4MuZ1PkwcVP0wuHrDCy1sq1os7WCw2al7Ao5rBGZjtk4WImMh25cAcGYH7IzMYt
	qUGQwsG1Gl/qRF+/hfqX5Go7tCF6J2Eg4mWLzByuGIWjbhm60CkTkyu3nsAFg5gh
	QsB62PwimFCALvZrNF8SuGoR2RASKF+9N9A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1772673889; x=
	1772681089; bh=pHow27CTfPDvgGL29iyDc6nQ4fjpzyYL5lvmt+hLriQ=; b=z
	UZbV8qF1pUA4oX+oEhgbjXEd6Qz84vUCLWVNrmELGTAt7XsjDqlWTNaFfPpHE3bJ
	kMNZTY8rLo9r5EDXJxEyZ3A1QJS87loj+JnftGi9XEKIpAJQVpo11yA5L0nVKBbb
	1UyY7juYTNfIaFa7hWHhHDfDhoXGb4g6P1eBDBFXNOWDwoTu5tDWOsMK+UfDlsJ3
	8BXfwlGl8fvuqlXSD6JbeESKC/r2tbA+X5Ib8Ao6050Wenr8ysEYn6SF1uPhd7m3
	oM4l2EDbDeEQoQmu734V1MTKW1dg57hrCOO9MPgWK0xcwEz5ZsIsMSk0rPkOz1nl
	C08mNGz1OuRmU4Mnj/mOQ==
X-ME-Sender: <xms:X9uoaZyO8jjwzvZMObvAu_oGj1IqHp_V3PfAvAnBAuUZkRw8xP3l4Q>
    <xme:X9uoadMnYbkMLjUd7fzbzl4AMAvZQ8WNnha6k3Czu0U52hyQQonXEZLS12MaLKN2C
    MfhzvgweCg0JiTEgSIDO8Vk741TqUiGR_ieVtepTGiwddvfEQ>
X-ME-Received: <xmr:X9uoab3GZjHMqCmmD6HykudsWGTS1J0FNhd6kvBf8XStgOYIntA2X2d8AdRjB-PjdvYSry1kxymqO-MTcopwZgHWFz-z3NynmgT-IKGCm4BC>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvieehtdeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurheptgfgggfhvfevufgjfhffkfhrsehtqhertddttdejnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epleejtdefgeeukeeiteduveehudevfeffvedutefgteduhfegvdfgtdeigeeuudejnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsg
    esohifnhhmrghilhdrnhgvthdpnhgspghrtghpthhtohepvddvpdhmohguvgepshhmthhp
    ohhuthdprhgtphhtthhopehvihhrohesiigvnhhivhdrlhhinhhugidrohhrghdruhhkpd
    hrtghpthhtohepshgvlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehlihhnuhigqdhunhhiohhnfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtoheplhhinhhugidqshgvtghurhhithihqdhmohguuhhlvgesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhnfhhssehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehmihhklhhoshesshiivghrvgguihdrhhhupdhr
    tghpthhtohepjhgrtghksehsuhhsvgdrtgii
X-ME-Proxy: <xmx:X9uoaVF9aO2rFJfMo9ZYL-rjkjx-_hWBa1Y12rAj2w8CayyWtOGBWw>
    <xmx:X9uoaSh0iIkn877feRTUOzlbn3ySdhcr3gz3o8Kxm7eMSJUmXq0DRg>
    <xmx:X9uoaed2nuv1cxb9PBp9Rv7ou0Gkx-R2lM9ok6f10GCTojgs9qF02A>
    <xmx:X9uoaYxQMfDOzeYFQ4QFTCd42scQ48clntS8IR4tMTF1ZFP2AxKpCA>
    <xmx:YduoaeI_V-Uu4J5ku4xeQFzYsT6m2VzogBuSJbtMi1at18Dh4rQfWEYV>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Mar 2026 20:24:41 -0500 (EST)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Christian Brauner" <brauner@kernel.org>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "David Howells" <dhowells@redhat.com>, "Jan Kara" <jack@suse.cz>,
 "Chuck Lever" <chuck.lever@oracle.com>, "Jeff Layton" <jlayton@kernel.org>,
 "Miklos Szeredi" <miklos@szeredi.hu>, "Amir Goldstein" <amir73il@gmail.com>,
 "John Johansen" <john.johansen@canonical.com>,
 "Paul Moore" <paul@paul-moore.com>, "James Morris" <jmorris@namei.org>,
 "Serge E. Hallyn" <serge@hallyn.com>,
 "Stephen Smalley" <stephen.smalley.work@gmail.com>,
 "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-kernel@vger.kernel.org, netfs@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
 linux-unionfs@vger.kernel.org, apparmor@lists.ubuntu.com,
 linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Subject:
 Re: [PATCH v3 00/15] Further centralising of directory locking for name ops.
In-reply-to: <20260224222542.3458677-1-neilb@ownmail.net>
References: <20260224222542.3458677-1-neilb@ownmail.net>
Date: Thu, 05 Mar 2026 12:24:38 +1100
Message-id: <177267387855.7472.13497219877141601891@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>
X-Rspamd-Queue-Id: A641D209CC2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ownmail.net,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[ownmail.net:s=fm1,messagingengine.com:s=fm1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-79454-lists,linux-fsdevel=lfdr.de];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,zeniv.linux.org.uk,redhat.com,suse.cz,oracle.com,szeredi.hu,gmail.com,canonical.com,paul-moore.com,namei.org,hallyn.com];
	FREEMAIL_FROM(0.00)[ownmail.net];
	RCPT_COUNT_TWELVE(0.00)[22];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ownmail.net:+,messagingengine.com:+];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-0.988];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[neilb@ownmail.net,linux-fsdevel@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	HAS_REPLYTO(0.00)[neil@brown.name];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[noble.neil.brown.name:mid,ownmail.net:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,messagingengine.com:dkim]
X-Rspamd-Action: no action


Hi Christian,
 do you have thoughts about this series?  Any idea when you might have
 time to review and (hopefully) apply them?

Thanks,
NeilBrown


On Wed, 25 Feb 2026, NeilBrown wrote:
> Following Chris Mason's tool-based review, here is v3 with some fixes.
> Particularly 06/15 mistakenly tested the result of start_creating for NULL
> and 09/15 had some really messed up flow in error handling.
> Also human-language typos fixed.
>=20
> This code is in=20
>   github.com:neilbrown/linux.git
>   branch pdirops
>=20
> For anyone interested, my next batch is in branch pdirops-next
>=20
> Original patch description below.
>=20
> Thanks,
> NeilBrown
>=20
> I am working towards changing the locking rules for name-operations: locking
> the name rather than the whole directory.
>=20
> The current part of this process is centralising all the locking so that
> it can be changed in one place.
>=20
> Recently "start_creating", "start_removing", "start_renaming" and related
> interaces were added which combine the locking and the lookup.  At that time
> many callers were changed to use the new interfaces.  However there are sti=
ll
> an assortment of places out side of fs/namei.c where the directory is locked
> explictly, whether with inode_lock() or lock_rename() or similar.  These we=
re
> missed in the first pass for an assortment of uninteresting reasons.
>=20
> This series addresses the remaining places where explicit locking is
> used, and changes them to use the new interfaces, or otherwise removes
> the explicit locking.
>=20
> The biggest changes are in overlayfs.  The other changes are quite
> simple, though maybe the cachefiles changes is the least simple of those.
>=20
> I'm running the --overlay tests in xfstests and nothing has popped yet.
> I'll continue with this and run some NFS tests too.
>=20
> Thanks for your review of these patches!
>=20
> NeilBrown
>=20
>  [PATCH v3 01/15] VFS: note error returns in documentation for various
>  [PATCH v3 02/15] fs/proc: Don't lock root inode when creating "self"
>  [PATCH v3 03/15] VFS: move the start_dirop() kerndoc comment to
>  [PATCH v3 04/15] libfs: change simple_done_creating() to use
>  [PATCH v3 05/15] Apparmor: Use simple_start_creating() /
>  [PATCH v3 06/15] selinux: Use simple_start_creating() /
>  [PATCH v3 07/15] nfsd: switch purge_old() to use
>  [PATCH v3 08/15] VFS: make lookup_one_qstr_excl() static.
>  [PATCH v3 09/15] ovl: Simplify ovl_lookup_real_one()
>  [PATCH v3 10/15] cachefiles: change cachefiles_bury_object to use
>  [PATCH v3 11/15] ovl: pass name buffer to ovl_start_creating_temp()
>  [PATCH v3 12/15] ovl: change ovl_create_real() to get a new lock when
>  [PATCH v3 13/15] ovl: use is_subdir() for testing if one thing is a
>  [PATCH v3 14/15] ovl: remove ovl_lock_rename_workdir()
>  [PATCH v3 15/15] VFS: unexport lock_rename(), lock_rename_child(),
>=20
>=20


