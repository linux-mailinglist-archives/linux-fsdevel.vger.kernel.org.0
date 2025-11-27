Return-Path: <linux-fsdevel+bounces-70003-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F901C8DE91
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 12:12:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 12A0334E30C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 11:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EE9832C33E;
	Thu, 27 Nov 2025 11:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="c+VxFWOo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YK6ML7HD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-b3-smtp.messagingengine.com (flow-b3-smtp.messagingengine.com [202.12.124.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B87223BD06;
	Thu, 27 Nov 2025 11:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764241909; cv=none; b=SvzTXwdWFYZrtPnsGFT+IktpOo8uPRIlqyvnkNERx7kzf7aU2jg2NP+pLKwkxPUmKITlZcOyv66TZLrwIyv03gg0Ms2Vi9BILAdLnnWi71YUpDQ2CcUIV5MSrdZ6gKBZ10hdfyaS2AEP0YputqTQClLbiynWYjJMs8Y3vWzwtJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764241909; c=relaxed/simple;
	bh=GbIDAT9rtj7UlTcfXk6NmMiPhN0t9jJouRITwhbuniQ=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=fAjqoGyAp9J3imr3YX+bTtZO8yFfHgOICh6l6dkC7WNIc8ANqrBpYTkcW0T6ICDK2mX8x9RlQ92VvvZvu3nkKH7FtqpkvBR4gkDpD84Oosl33Y5r8cDgTFwjqhH0Xi9EG1Ou8FvdY9yQ8Cs/ZXvzadDdufcyqaHoM+LM2P/59wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=c+VxFWOo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YK6ML7HD; arc=none smtp.client-ip=202.12.124.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailflow.stl.internal (Postfix) with ESMTP id E54531300112;
	Thu, 27 Nov 2025 06:11:45 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Thu, 27 Nov 2025 06:11:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm1; t=
	1764241905; x=1764249105; bh=m1kV6hlzxb2O2XlqHGM1BPPCpFOnIPzOUy0
	n7fZKnGU=; b=c+VxFWOo9uq1DK4cCUXO6NBeE5V6mjiuePKe7uq7i7Uzw+e5z1r
	KSIFI9qcaqcHz/n4M2JGC1ShKl/MbAFLeZ5Gkz2dElDfo78nIMMAzxNeatPtEK9e
	Ru07vJE9mRlHzolsNc6YCOBgflzvX8LDXidjAqnXlE38xqoVzFriH4DNrf2ruGli
	heSyikJBEqbjPgZS6+el63Q1N05e2qxh4QAGs1ZfrzHXS7yCHKjO1lQEOkmReEhx
	qnzUYADGoVR0mdu9DH1ddnFcsMreV9GoBSAI6qINupHzYFkPg0j5YH5S3fkJCJTp
	FrDhzYk2BwjOPy5YmiyxBPmHIMvYQb6zYWA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1764241905; x=
	1764249105; bh=m1kV6hlzxb2O2XlqHGM1BPPCpFOnIPzOUy0n7fZKnGU=; b=Y
	K6ML7HDTpTVp9PjUPBfoTqh+u1zoLmFqmw+hkFRFq+N9YuLOKVRydNumSmfQAYgx
	OAttLjP+MFjq5RGkd91Hsq1Qcr44B8QVwobJrDtMl5UulnzgmDvIeua0pUppOct1
	22Hh23EtIDNgAw6sEMv/72llJaTe/P8BT5wbDKTpu7rR9nT1jj5Z/uUAWxmrcbAy
	V/h1oahiRy9rLpbiThxDQ+oIi8S+8z6uK9W6qpNro9kteF6xAi8wW7pXkY8pEIxL
	mzXa3JvSnawJshJHoyvNpEsRSBSqP/ndEheTdpqPjD3QX1ywhnT1v/sxGhBhdxEW
	zJ9oWyeEY/D8XM1NtqTaw==
X-ME-Sender: <xms:8TEoabu7JYFYMUfT7S8_I5--Lo9rbrFJdwoaNpvJDL9YrWnILVfvgQ>
    <xme:8TEoaRi_IAui-deAtJacilhZHHf4PFcDfB7m1UWRGkdliewWwXHx4qEADYj6VQBh7
    Qhd33fJ6UAMn6BXa5LXo7PE8unF5m36jwIvdlqBrbZforJtLg>
X-ME-Received: <xmr:8TEoabwy5w0jZKY1rlGFdR9h2JuLLKcSlLcY3KhHiDFqYSQUh_uGJMNO0XTo5J1Em-XAiAWPRrsI0FwLL4oUHwxhQtwrO4uben-LiXPBsZkx>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvgeejtdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurheptgfgggfhvfevufgjfhffkfhrsehtqhertddttdejnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epvdeuteelkeejkeevteetvedtkeegleduieeftdeftefgtddtleejgfelgfevffeinecu
    ffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehnvghilhgssehofihnmhgrihhlrdhnvghtpdhnsggp
    rhgtphhtthhopeegtddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepvhhirhhose
    iivghnihhvrdhlihhnuhigrdhorhhgrdhukhdprhgtphhtthhopehsvghlihhnuhigsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqgihfshesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhunhhiohhnfhhssehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqshgvtghurhhith
    ihqdhmohguuhhlvgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhn
    uhigqdhnfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugi
    dqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhu
    gidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlih
    hnuhigqdgtihhfshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:8TEoaX4jhOU-RJfrf3t1xEcR-lNfjS28e99wANWzbIhtgXOc8tvlQQ>
    <xmx:8TEoadfn3ihxo_f2JsQabXyhrsPX7Ty6n2NXo-mzGemtFZUciGdvkw>
    <xmx:8TEoafruRCtJU5PoM56axqXYQfY267HfKJE3cT5se9N7bV25X2ebug>
    <xmx:8TEoaR1xv1E0dscVlFpB4htOxcDXJkE0QaT7-sPWv8fjNCO-_Nn03g>
    <xmx:8TEoacuIUsW2XK9lNoDW8FFI-jSTzwnKCqQ_3XoqxqRE8twj9TVgjbxl>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 27 Nov 2025 06:11:35 -0500 (EST)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Christian Brauner" <brauner@kernel.org>
Cc: "Jeff Layton" <jlayton@kernel.org>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Amir Goldstein" <amir73il@gmail.com>, "Jan Kara" <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org, "Chris Mason" <clm@fb.com>,
 "David Sterba" <dsterba@suse.com>, "David Howells" <dhowells@redhat.com>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 "Danilo Krummrich" <dakr@kernel.org>, "Tyler Hicks" <code@tyhicks.com>,
 "Miklos Szeredi" <miklos@szeredi.hu>,
 "Chuck Lever" <chuck.lever@oracle.com>,
 "Olga Kornievskaia" <okorniev@redhat.com>,
 "Dai Ngo" <Dai.Ngo@oracle.com>, "Namjae Jeon" <linkinjeon@kernel.org>,
 "Steve French" <smfrench@gmail.com>,
 "Sergey Senozhatsky" <senozhatsky@chromium.org>,
 "Carlos Maiolino" <cem@kernel.org>,
 "John Johansen" <john.johansen@canonical.com>,
 "Paul Moore" <paul@paul-moore.com>, "James Morris" <jmorris@namei.org>,
 "Serge E. Hallyn" <serge@hallyn.com>,
 "Stephen Smalley" <stephen.smalley.work@gmail.com>,
 "Ondrej Mosnacek" <omosnace@redhat.com>,
 "Mateusz Guzik" <mjguzik@gmail.com>,
 "Lorenzo Stoakes" <lorenzo.stoakes@oracle.com>,
 "Stefan Berger" <stefanb@linux.ibm.com>,
 "Darrick J. Wong" <djwong@kernel.org>, linux-kernel@vger.kernel.org,
 netfs@lists.linux.dev, ecryptfs@vger.kernel.org,
 linux-nfs@vger.kernel.org, linux-unionfs@vger.kernel.org,
 linux-cifs@vger.kernel.org, linux-xfs@vger.kernel.org,
 linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Subject: Re: [PATCH v6 00/15] Create and use APIs to centralise locking for
 directory ops
In-reply-to: <20251114-liedgut-eidesstattlich-8c116178202f@brauner>
References: <20251113002050.676694-1-neilb@ownmail.net>,
 <20251114-baden-banknoten-96fb107f79d7@brauner>,
 <20251114-liedgut-eidesstattlich-8c116178202f@brauner>
Date: Thu, 27 Nov 2025 22:11:33 +1100
Message-id: <176424189349.634289.4480398011245842622@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Sat, 15 Nov 2025, Christian Brauner wrote:
> On Fri, Nov 14, 2025 at 01:24:41PM +0100, Christian Brauner wrote:
> > On Thu, Nov 13, 2025 at 11:18:23AM +1100, NeilBrown wrote:
> > > Following is a new version of this series:
> > >  - fixed a bug found by syzbot
> > >  - cleanup suggested by Stephen Smalley
> > >  - added patch for missing updates in smb/server - thanks Jeff Layton
> >=20
> > The codeflow right now is very very gnarly in a lot of places which
> > obviously isn't your fault. But start_creating() and end_creating()
> > would very naturally lend themselves to be CLASS() guards.
> >=20
> > Unrelated: I'm very inclined to slap a patch on top that renames
> > start_creating()/end_creating() and start_dirop()/end_dirop() to
> > vfs_start_creating()/vfs_end_creating() and
> > vfs_start_dirop()/vfs_end_dirop(). After all they are VFS level
> > maintained helpers and I try to be consistent with the naming in the
> > codebase making it very easy to grep.
>=20
> @Neil, @Jeff, could you please look at:
> https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git/log/?h=3Dvfs.all
>=20
> and specifically at the merge conflict resolution I did for:
>=20
> https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git/commit/?h=3Dvfs=
.all&id=3Df28c9935f78bffe6fee62f7fb9f6c5af7e30d9b2
>=20
> and tell me whether it all looks sane?
>=20

That merge is a7b062be95fed490d1dcd350d3b5657f243d7d4f today, and I
agree with Jeff that it looks good.

Thanks,
NeilBrown

