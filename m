Return-Path: <linux-fsdevel+bounces-78866-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2LKeOnwNpWmT0gUAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78866-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Mar 2026 05:09:32 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 60FC51D2E3A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Mar 2026 05:09:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 96EDF3018740
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Mar 2026 04:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AB0A277035;
	Mon,  2 Mar 2026 04:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="jwgdHYRr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hrbCb7Me"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7DFA23C4F2;
	Mon,  2 Mar 2026 04:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772424555; cv=none; b=glXzVQB1+ll6nzOUWpbJnl6+CJqwlAIJIo7woVFRiKbcAl57m/+mY0EnE77J21wMfyG+NovoVtaToTOBumKHvNIUtfoGZga6cuPN9ZeR3QDOUaT6ZOfUUQZMJIdGEBMxeuSz8QorECBIdJaEFBvy/Szf8+vWIkuR5ylh9tVM1uY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772424555; c=relaxed/simple;
	bh=RL7YHfo9DlN6erX11ZBVFCufHA/U7iCLg3LKMdHX4LA=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=EkYFaHoA9CBVgp7Qp3VmfoSKxypWfwmGdZwCn/oUU1bBTLQf28WLJO9bOc1oYdO5YbsQdKlcY++anf4pR9+RSYa02QA+etiucmFHpaYrMTFe1SyEDYKkUwNLQ/sGomNDei8dYFhcTCuLlAunG0MIR18n2KNyZOCBRNCys9xCf1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=jwgdHYRr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hrbCb7Me; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id B2B2B1D00187;
	Sun,  1 Mar 2026 23:09:11 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Sun, 01 Mar 2026 23:09:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm1; t=
	1772424551; x=1772510951; bh=xdPM9Ho77dh5HWd18OeTmi5IVBzLIHu1iNH
	8LvaFcAg=; b=jwgdHYRrfQSaRj5Ikn7XXxeFhosDsAMqF/FmnKcRRKkg+mi4ptg
	ifPg0qK7rH2l2jVLJxVE4MYik22w/BruwcQ9QguHTWyMbL2+sSZRDQGAA62vag7P
	Nxx6R3oMlWzvfzBHKxnNbmlvy3ijWnc0V32wv2nMSK+zSWvNS6O7/yoa6T7XEgB3
	wXpUfObUIJDO0oxtU6w9a4LKuOe/WfgRutEZqhBIyW4vNDT5ujcaqSdDZszuwCXB
	yksjsoOKRPu7QXIJbkzu9NsO/j8osBflj8buJsRRiF5knUo/yuzbbrXViKiKbBSd
	o1AYFSGwbFlSexZzoXVBN4pE23Hu7rjK90w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1772424551; x=
	1772510951; bh=xdPM9Ho77dh5HWd18OeTmi5IVBzLIHu1iNH8LvaFcAg=; b=h
	rbCb7MeT51nKiLff/BxLJouP7U3ydtmgkFI2J0Y5UqnBlnMBfiUAlh/rotdaRopj
	X93+ZuVxQMR9k1r6mgT+DQXBJHhqun1OFl3OI+EA9nAcPANm97vUAcikqMDih+/X
	b4I4aAZexFRw+qqlF6axkpBQormXyeL2RDz/c7ikJ9G4MLvbq8h50ubbXVJhTBIS
	j8LnVkiGrYeu1k4uoeb8Ou9DlIbwsoQcQOkvj1IWJVIDc4n5fYHsTxKJ/ra/b1Si
	Me99qrAzKD+2QXbrzzAuQBGHp0vCC8hLq0DgXA2mk5UdL0V64IA28p1RR1neICBl
	1W2jnJXMi0PqWCQ1WW+UQ==
X-ME-Sender: <xms:Zw2laUXtx87Ec_EYOzof9RplFox5VvQGLATmW55jwJYoFBeg_D4MzQ>
    <xme:Zw2laaJBlm5YcyYwXENs8qAcyHMZLQySaZMpNh5buWs4VtF7em9eKYQK8vzK9oD-j
    y_MRU0WB2l-vtBhn3sYog0j_TTbfLc9E0bpdu43eTzV0Fc0gg>
X-ME-Received: <xmr:Zw2laXoU1FgOObyiNQb7dztklqAzbekWwmQZGypPlttrslnI7vDQ1fv9Z_FAYfkiAk_eCezD__jyaxiGBPU_BwPqkMo4JyMBQ7K3Hcd_WZam>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvheeiieejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurheptgfgggfhvfevufgjfhffkfhrsehtkeertddttdejnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epvdfhgfehkeekiedtleefhefhkeevvdegfffhgfduffeiveelffehlefhfeehveetnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsg
    esohifnhhmrghilhdrnhgvthdpnhgspghrtghpthhtohepuddvpdhmohguvgepshhmthhp
    ohhuthdprhgtphhtthhopehlihhnuhigqdhnfhhssehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehtohhmsehtrghlphgvhidrtghomhdprhgtphhtthhopehjrg
    gtkhesshhushgvrdgtiidprhgtphhtthhopehjrggtkhesshhushgvrdgtohhmpdhrtghp
    thhtohepohhkohhrnhhivghvsehrvgguhhgrthdrtghomhdprhgtphhtthhopegurghird
    hnghhosehorhgrtghlvgdrtghomhdprhgtphhtthhopegthhhutghkrdhlvghvvghrseho
    rhgrtghlvgdrtghomhdprhgtphhtthhopehjlhgrhihtohhnsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:Zw2laZwlKTSO1r6zJAWUt85cyqlmbZ78zAiSl_xFMTinilyP2jB5KA>
    <xmx:Zw2laTs5uOpt2mpaDvQ2hUxoPr_5XZYvhywERIASc3E8jyD2Vk6hnQ>
    <xmx:Zw2laa3eqbLISs5Ww8YezMWTKOTQCEEhDSrmx54FnhLCG-8R_npI9A>
    <xmx:Zw2laTBfz3rpgopvxw4iDNEA-WiPx-XA0Vjq5fDy1pXF8a19XS8k4g>
    <xmx:Zw2laadawXE9PF8Pj_DcFFEkKMaOG9ft98CQ7KuR-Xt5U7Fiwin66dMn>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 1 Mar 2026 23:09:07 -0500 (EST)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Chuck Lever" <cel@kernel.org>
Cc: "Amir Goldstein" <amir73il@gmail.com>, "Jan Kara" <jack@suse.cz>,
 "Christian Brauner" <brauner@kernel.org>, "Jan Kara" <jack@suse.com>,
 "Jeff Layton" <jlayton@kernel.org>, "Olga Kornievskaia" <okorniev@redhat.com>,
 "Dai Ngo" <dai.ngo@oracle.com>, "Tom Talpey" <tom@talpey.com>,
 linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 "Chuck Lever" <chuck.lever@oracle.com>
Subject: Re: [PATCH v3 1/3] fs: add umount notifier chain for filesystem
 unmount notification
In-reply-to: <07a2af61-6737-4e47-ad69-652af18eb47b@app.fastmail.com>
References: <20260224163908.44060-1-cel@kernel.org>,
 <20260224163908.44060-2-cel@kernel.org>,
 <20260226-alimente-kunst-fb9eae636deb@brauner>,
 <CAOQ4uxhEpf1p3agEF7_HBrhUeKz1Fb_yKAQ0Pjo0zztTJfMoXA@mail.gmail.com>,
 <1165a90b-acbf-4c0d-a7e3-3972eba0d35a@kernel.org>,
 <jxyalrg3a2yjtjfmdylncg7fz63jstbq6pwhhqlaaxju5sk72f@55lb7mfucc5i>,
 <3cff098e-74a8-4111-babb-9c13c7ba2344@kernel.org>,
 <CAOQ4uxiX5anNeZge9=uzw8Dkbad3bMBk5Ana5S94t9VfKNFO5g@mail.gmail.com>,
 <d7f2562a-7d32-41d5-a02e-904aa4203ed3@app.fastmail.com>,
 <CAOQ4uxiO+NCjhBme=YWCfnVyhJ=Zcg4zmnfoRspJab3n5waSCA@mail.gmail.com>,
 <07a2af61-6737-4e47-ad69-652af18eb47b@app.fastmail.com>
Date: Mon, 02 Mar 2026 15:09:03 +1100
Message-id: <177242454307.7472.11164903103911826962@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ownmail.net,none];
	R_DKIM_ALLOW(-0.20)[ownmail.net:s=fm1,messagingengine.com:s=fm1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-78866-lists,linux-fsdevel=lfdr.de];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,suse.cz,kernel.org,suse.com,redhat.com,oracle.com,talpey.com,vger.kernel.org];
	FREEMAIL_FROM(0.00)[ownmail.net];
	RCPT_COUNT_TWELVE(0.00)[12];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	HAS_REPLYTO(0.00)[neil@brown.name];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[neilb@ownmail.net,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[ownmail.net:+,messagingengine.com:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[noble.neil.brown.name:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,messagingengine.com:dkim,brown.name:replyto]
X-Rspamd-Queue-Id: 60FC51D2E3A
X-Rspamd-Action: no action

On Mon, 02 Mar 2026, Chuck Lever wrote:
> 
> On Sun, Mar 1, 2026, at 1:09 PM, Amir Goldstein wrote:
> > On Sun, Mar 1, 2026 at 6:21 PM Chuck Lever <cel@kernel.org> wrote:
> >> Perhaps that description nails down too much implementation detail,
> >> and it might be stale. A broader description is this user story:
> >>
> >> "As a system administrator, I'd like to be able to unexport an NFSD
> >
> > Doesn't "unexporting" involve communicating to nfsd?
> > Meaning calling to svc_export_put() to path_put() the
> > share root path?
> >
> >> share that is being accessed by NFSv4 clients, and then unmount it,
> >> reliably (for example, via automation). Currently the umount step
> >> hangs if there are still outstanding delegations granted to the NFSv4
> >> clients."
> >
> > Can't svc_export_put() be the trigger for nfsd to release all resources
> > associated with this share?
> 
> Currently unexport does not revoke NFSv4 state. So, that would
> be a user-visible behavior change. I suggested that approach a
> few months ago to linux-nfs@ and there was push-back.
> 

Could we add a "-F" or similar flag to "exportfs -u" which implements the
desired semantic?  i.e.  asking nfsd to release all locks and close all
state on the filesystem.

NeilBrown

