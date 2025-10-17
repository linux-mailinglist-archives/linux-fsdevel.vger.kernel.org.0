Return-Path: <linux-fsdevel+bounces-64558-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7246DBEC0A5
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Oct 2025 01:44:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DACF623099
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Oct 2025 23:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F237530F940;
	Fri, 17 Oct 2025 23:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="PpCfbnCi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JID8YgBs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-a4-smtp.messagingengine.com (flow-a4-smtp.messagingengine.com [103.168.172.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 266682629F;
	Fri, 17 Oct 2025 23:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760744682; cv=none; b=iGza4fGallriRrHqko60yzsIsNB6VFmM8Kp8wnXaY4OOWm+/pDvOUtXIYJUn2ebCRto8QwGgGry2aRudE7YizfCf8qkDZNffUbSvon1wuwYTThdtCAekq/ipyO36Ka1/2U+Cz+N8N3u0GwBM/D1WvjsZH0QD0YtwdPJ7tn0wjfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760744682; c=relaxed/simple;
	bh=u0MZX99m7tsyAu2FbX/wO754TpewlSzO9tI9LAlI5Rg=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=AP9KAcbwU2ctK6Wy9HWLAHi+2SUARKLnJpmNeK3yov0z+NMRVzniD2RCfMOxYkN3r+0VMlpDC2AnE6JaS/6dwWO/QyClXdlodX3Mt/M8suBEWiuFdLVucP4NdqXhkFDWYQyNlvsiqAzK/TyzMpUVA//eonIxnOo9M3k+ZBn7kkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=PpCfbnCi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JID8YgBs; arc=none smtp.client-ip=103.168.172.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailflow.phl.internal (Postfix) with ESMTP id 3FD3F1380634;
	Fri, 17 Oct 2025 19:44:38 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Fri, 17 Oct 2025 19:44:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm2; t=
	1760744678; x=1760751878; bh=fsRJNHgf5wp6dMPZl2BHgqJB2Mn3uMg+ds8
	+N/kIR6M=; b=PpCfbnCi5m2pJlypffNagOwQ1jiOv1FqH42riPH7kB2SKsP0X2V
	JviiDDVWBhLadufIpgRZA4P+tAAmkEsTeo2iw5bey8/quk1S/nIzAKWSl//Jtsp4
	R3E1xHCnM5I7fPHqvY6xxYUEXnWFdcGsqnFOg0iZbW7nYad4O3m6AecmLEfa4wgm
	053figuFB9afPvzZisE9w9ZWy5lbX+Uk1XdACK4r2jD7lufSEfaQejMOYY7HCag4
	/kmwTf4NmJrnK3e2GrZQ4jz/u3/0aqPDdnu7qobIRo8P0z1Ge9t+sDHMSPF8/wrE
	2qptYIed9mahk/9p0SuwjIvpgwq2Shl/jVA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760744678; x=
	1760751878; bh=fsRJNHgf5wp6dMPZl2BHgqJB2Mn3uMg+ds8+N/kIR6M=; b=J
	ID8YgBsC0Zlq97uy28rnGxEniUfQ+yFOuU+ciiPl7K8wlO2e0nT3BEBmW2cl49h2
	NVHwoyX8FgY6wxmkjhwXjEbepDeRRrrd/2KynnCpsuVJkb6n05xksyt2Xf3l0rDJ
	zd5ryMoClAGFXxjnEvTtfNMFw6fJnOnGXBgXoIGUBsBczWbW0b5xo3c/PSoixbVd
	Vflnp8GoiiBmQ1lmJSzWS0ndraz6I0xBTcvVrs5JN+3Mp24jmfR4zysroUEK2JjJ
	/0j5o9flRWFIhIiCNmd2yAgkAA2DrIMqqLqIZfQi/VnGrg/hZ/EHEC5BgmjW66pn
	JnLifN/o/tGIonbXG5hCQ==
X-ME-Sender: <xms:5NTyaOorzpQDJMLlg9LI8TKz0YXzq0nDnVMeovAsKg6SBFO3UN3wUg>
    <xme:5NTyaLpPfn_QQB80N2_qjcaF0vOjVu5Y_NBqzmwm73Inj29zE7g-_wUZlXG-Kyviw
    _A2Y_hxNHVlcFb2oV9AQCjzAaIPG8LxGekke4oYziF4OhuaMIc>
X-ME-Received: <xmr:5NTyaLelh78ONagQhOl9SGV7AW4KVMmR6XnSnOyV0_u5_PpC99rpXmUMadzBckTIuya7bDQbfLWn8qJiAezszE_hu4hrpmd1QqEZX-8_2U1g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddufedtheefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurheptgfgggfhvfevufgjfhffkfhrsehtqhertddttdejnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epvdeuteelkeejkeevteetvedtkeegleduieeftdeftefgtddtleejgfelgfevffeinecu
    ffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehnvghilhgssehofihnmhgrihhlrdhnvghtpdhnsggp
    rhgtphhtthhopeegfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepvhhirhhose
    iivghnihhvrdhlihhnuhigrdhorhhgrdhukhdprhgtphhtthhopehnvghtuggvvhesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdigfhhssehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidquhhnihhonhhfshesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhnfhhssehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdgtihhfshesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegvtghrhihpthhfshesvhhgvghrrd
    hkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:5NTyaKQOygeT-WDC4EpGdB9UxeBX1x1b0QQARdMw78hJaUuGw16Bpg>
    <xmx:5NTyaHeqAIRulsREZCjlE_C8s0Is771XsTmonG6WXx4qb74PiaFT_w>
    <xmx:5NTyaKCO0YfW6-IqqtOcltxObTrHKpPry1oAkKr1FbLeSlCFfCsvXg>
    <xmx:5NTyaEv_hh5zLWLwI9GLd5aEfHsL025i_s7LtxBypvsPVX3tUGd22A>
    <xmx:5tTyaCiEjulIfLatm6Wk-Qg3CpixYcKoLl74c5ZXFD26oqjV2H5JH3BJ>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Oct 2025 19:44:25 -0400 (EDT)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Jeff Layton" <jlayton@kernel.org>
Cc: "Miklos Szeredi" <miklos@szeredi.hu>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Christian Brauner" <brauner@kernel.org>, "Jan Kara" <jack@suse.cz>,
 "Chuck Lever" <chuck.lever@oracle.com>,
 "Alexander Aring" <alex.aring@gmail.com>,
 "Trond Myklebust" <trondmy@kernel.org>,
 "Anna Schumaker" <anna@kernel.org>, "Steve French" <sfrench@samba.org>,
 "Paulo Alcantara" <pc@manguebit.org>,
 "Ronnie Sahlberg" <ronniesahlberg@gmail.com>,
 "Shyam Prasad N" <sprasad@microsoft.com>, "Tom Talpey" <tom@talpey.com>,
 "Bharath SM" <bharathsm@microsoft.com>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 "Danilo Krummrich" <dakr@kernel.org>,
 "David Howells" <dhowells@redhat.com>, "Tyler Hicks" <code@tyhicks.com>,
 "Olga Kornievskaia" <okorniev@redhat.com>,
 "Dai Ngo" <Dai.Ngo@oracle.com>, "Amir Goldstein" <amir73il@gmail.com>,
 "Namjae Jeon" <linkinjeon@kernel.org>,
 "Steve French" <smfrench@gmail.com>,
 "Sergey Senozhatsky" <senozhatsky@chromium.org>,
 "Carlos Maiolino" <cem@kernel.org>,
 "Kuniyuki Iwashima" <kuniyu@google.com>,
 "David S. Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>,
 "Paolo Abeni" <pabeni@redhat.com>, "Simon Horman" <horms@kernel.org>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
 samba-technical@lists.samba.org, netfs@lists.linux.dev,
 ecryptfs@vger.kernel.org, linux-unionfs@vger.kernel.org,
 linux-xfs@vger.kernel.org, netdev@vger.kernel.org,
 "Jeff Layton" <jlayton@kernel.org>
Subject: Re: [PATCH v2 00/11] vfs: recall-only directory delegations for knfsd
In-reply-to: <20251017-dir-deleg-ro-v2-0-8c8f6dd23c8b@kernel.org>
References: <20251017-dir-deleg-ro-v2-0-8c8f6dd23c8b@kernel.org>
Date: Sat, 18 Oct 2025 10:44:23 +1100
Message-id: <176074466364.1793333.7771684363912648120@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Fri, 17 Oct 2025, Jeff Layton wrote:
> A smaller variation of the v1 patchset that I posted earlier this week.
> Neil's review inspired me to get rid of the lm_may_setlease operation
> and to do the conflict resolution internally inside of nfsd. That means
> a smaller VFS-layer change, and an overall reduction in code.
>=20
> This patchset adds support for directory delegations to nfsd. This
> version only supports recallable delegations. There is no CB_NOTIFY
> support yet. I have patches for those, but we've decided to add that
> support in a later kernel once we get some experience with this part.
> Anna is working on the client-side pieces.
>=20
> It would be great if we could get into linux-next soon so that it can be
> merged for v6.19. Christian, could you pick up the vfs/filelock patches,
> and Chuck pick up the nfsd patches?
>=20
> Thanks!
> Jeff
>=20
> [1]: https://lore.kernel.org/all/20240315-dir-deleg-v1-0-a1d6209a3654@kerne=
l.org/
>=20
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
> Changes in v2:
> - handle lease conflict resolution inside of nfsd
> - drop the lm_may_setlease lock_manager operation
> - just add extra argument to vfs_create() instead of creating wrapper
> - don't allocate fsnotify_mark for open directories
> - Link to v1: https://lore.kernel.org/r/20251013-dir-deleg-ro-v1-0-406780a7=
0e5e@kernel.org
>=20
> ---
> Jeff Layton (11):
>       filelock: push the S_ISREG check down to ->setlease handlers
>       vfs: add try_break_deleg calls for parents to vfs_{link,rename,unlink}
>       vfs: allow mkdir to wait for delegation break on parent
>       vfs: allow rmdir to wait for delegation break on parent
>       vfs: break parent dir delegations in open(..., O_CREAT) codepath
>       vfs: make vfs_create break delegations on parent directory
>       vfs: make vfs_mknod break delegations on parent directory
>       filelock: lift the ban on directory leases in generic_setlease
>       nfsd: allow filecache to hold S_IFDIR files
>       nfsd: allow DELEGRETURN on directories
>       nfsd: wire up GET_DIR_DELEGATION handling

vfs_symlink() is missing from the updated APIs.  Surely that needs to be
able to wait for a delegation to break.

vfs_mkobj() maybe does too, but I could easily turn a blind eye to that.

I haven't looked properly at the last patch but all the other could have
 Reviewed-by: NeilBrown <neil@brown.name>

once the vfs_symlink() omission is fixed.

NeilBrown

