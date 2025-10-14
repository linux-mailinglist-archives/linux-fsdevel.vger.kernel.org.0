Return-Path: <linux-fsdevel+bounces-64083-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C4C4BD7701
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Oct 2025 07:35:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BCEA54E50A0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Oct 2025 05:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 589C229B205;
	Tue, 14 Oct 2025 05:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="EMHXmtH6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ih+RDekg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-b8-smtp.messagingengine.com (flow-b8-smtp.messagingengine.com [202.12.124.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861CE13DBA0;
	Tue, 14 Oct 2025 05:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.143
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760420101; cv=none; b=uql13z7X+xXzIiYlu646JIWcKnkDlDOPyAwu7tkm/ZejwmE9ud1esGWpdc4WQn2no8qD+KVV0l8uzWcEz54CwjplhpNwv48qO6Qz+rcJc3MIQzNp24InsM0RNhoXdXruwDuTPPnDhRCmnpDGSmtbMqIl0zKvlzRcnqymn8dMqG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760420101; c=relaxed/simple;
	bh=X5WPVB8Em/gBcebUeg/HDVgnFFFK8ttMHgLzywHakA4=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=qFzThTzxYIDivtZcTbW1KntBvvXOrmNP++4/WVC5ujNMN+If8IJX2toWZGghvVHLKDCUdLe8eomN8kVm5wIgftB+BRKN8vhpTVLYxKatvcqdXmOwBQq1dsBEngmYIFAj65iwarrhHA6gm44yyy1p5lhtkBVvTOQpL/cA6RcFnAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=EMHXmtH6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ih+RDekg; arc=none smtp.client-ip=202.12.124.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailflow.stl.internal (Postfix) with ESMTP id 9C94F1300216;
	Tue, 14 Oct 2025 01:34:57 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 14 Oct 2025 01:34:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm2; t=
	1760420097; x=1760427297; bh=sKvX0cwi5L2mQqOKfWbZAQQCGUflq024x5h
	ZczDrYtI=; b=EMHXmtH6b1fssNuWNAbg39nPBc2L6iLo9Ov6TFV9qllyxag3kQl
	VvtR8X+4Za9g2Vw/Na+uS9UetgsfpRkZL1jz1/auc6Oy9Fq/N3API8bZzlIeqS+8
	OjId+x1I54l5gE4nOruTpTX/eIn+DMjXL5K+xkpQQMMBYqKYZbAoJbxHVEnJCxyO
	GuwVNtYCGxxVYsar+VUXpQgttiAqGWRjkt15aK64LQqfqxqxFr0g6wXKB/Ibf2XG
	/cxaxnXKKVd6RVbRRMfLB3f2m4fsB0FeJxFOUSfB6WZiuqXvwmbis9V2yhheF05K
	VmxNfUjA1k1l+mLURd+ZuZFqVsb6BMYN94A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760420097; x=
	1760427297; bh=sKvX0cwi5L2mQqOKfWbZAQQCGUflq024x5hZczDrYtI=; b=i
	h+RDekgtuViqOuIRe5nRpsoy76Bx+bzGVh5cBTj8/X62C0XR7TEIA2xbt2Ubxpid
	ZHq1+y+7InziK5qe1r9LHucLnuKtgHqiO+FJDRNHoj+tR9Q3PyID4LVM/3M3ybRX
	tIH70Tx5Za71PjvLbkA/yeToEismdKYiPPzND/ygwI7geT796CZq/6emzH7eNm4V
	Kce1Eyi/Y3RiDRX6XMGOfP6tmK6MicTRdw6J7gWuQcQoU6VJmgQ73wKrjDyZY++8
	u8xiIYup5XPh8TtZB2Jq/GVp2aBKUBf6LKfVQd6UoWatyJpdJXN19DN+foHp9Ekz
	zoZtogTA7a4Db2it5V2NQ==
X-ME-Sender: <xms:_-DtaGDSStk9-hdw2H6ZL83waWfdVJ9YX5PyZE66IpkrirSbEhiR2w>
    <xme:_-DtaPgz524KR1bIMerhs2C7YXAmbZW4Lsj3EsWSvpJwVeGY-BzhhonTtr5xmV6Ss
    GpABGkyA-RB0RJhi2Lq8cCoQS1KXsJC00AQOjfMWlRhV5yMIA>
X-ME-Received: <xmr:_-DtaB2IaBnzbz1hHV5senq7g_aSWzgh3eK-gJYcQFcoiXy_Aqk709eaLtyG4VXyvm7TKsTwnzEKdhghfx2bsou0ue1yREccsDhltZNVqC4X>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduudeljeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurheptgfgggfhvfevufgjfhffkfhrsehtqhertddttdejnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epleejtdefgeeukeeiteduveehudevfeffvedutefgteduhfegvdfgtdeigeeuudejnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsg
    esohifnhhmrghilhdrnhgvthdpnhgspghrtghpthhtohepgeefpdhmohguvgepshhmthhp
    ohhuthdprhgtphhtthhopehvihhrohesiigvnhhivhdrlhhinhhugidrohhrghdruhhkpd
    hrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    oheplhhinhhugidqgihfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hlihhnuhigqdhunhhiohhnfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    oheplhhinhhugidqnhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpth
    htoheplhhinhhugidqtghifhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepvggtrhihphhtfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:_-DtaBIY-oFTdHKRTw3D8L3q4PTHVD4zpV8goGnqHXyVH0nbHG8b-g>
    <xmx:_-DtaE2CVchSpis3kE9Qdx37fJ6LzhXT6BNt0IM3jeZVpKMoYnyecg>
    <xmx:_-DtaL64I2eH2ZO8gGbqN6_6BowsHFpdQspB-a4TT9QeVF7PfU6YCw>
    <xmx:_-DtaBHiAd6eRDoVhivjdRfsp-KtS_QT_guqr2aFH_bbkXfblrXRRA>
    <xmx:AeHtaDciWRkXrzOWRd6sH4KgBlnrwJkD0ZAWHMp6JhGiQZ8mFgAE876O>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Oct 2025 01:34:44 -0400 (EDT)
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
Subject:
 Re: [PATCH 02/13] filelock: add a lm_may_setlease lease_manager callback
In-reply-to: <20251013-dir-deleg-ro-v1-2-406780a70e5e@kernel.org>
References: <20251013-dir-deleg-ro-v1-0-406780a70e5e@kernel.org>,
 <20251013-dir-deleg-ro-v1-2-406780a70e5e@kernel.org>
Date: Tue, 14 Oct 2025 16:34:43 +1100
Message-id: <176042008301.1793333.506325387242251221@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Tue, 14 Oct 2025, Jeff Layton wrote:
> The NFSv4.1 protocol adds support for directory delegations, but it
> specifies that if you already have a delegation and try to request a new
> one on the same filehandle, the server must reply that the delegation is
> unavailable.
>=20
> Add a new lease manager callback to allow the lease manager (nfsd in
> this case) to impose this extra check when performing a setlease.
>=20
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/locks.c               |  5 +++++
>  include/linux/filelock.h | 14 ++++++++++++++
>  2 files changed, 19 insertions(+)
>=20
> diff --git a/fs/locks.c b/fs/locks.c
> index 0b16921fb52e602ea2e0c3de39d9d772af98ba7d..9e366b13674538dbf482ffdeee9=
2fc717733ee20 100644
> --- a/fs/locks.c
> +++ b/fs/locks.c
> @@ -1826,6 +1826,11 @@ generic_add_lease(struct file *filp, int arg, struct=
 file_lease **flp, void **pr
>  			continue;
>  		}
> =20
> +		/* Allow the lease manager to veto the setlease */
> +		if (lease->fl_lmops->lm_may_setlease &&
> +		    !lease->fl_lmops->lm_may_setlease(lease, fl))
> +			goto out;
> +

I don't see any locking around this.  What if the condition which
triggers a veto happens after this check, and before the lm_change
below?
Should lm_change implement the veto?  Return -EAGAIN?

NeilBrown


>  		/*
>  		 * No exclusive leases if someone else has a lease on
>  		 * this file:
> diff --git a/include/linux/filelock.h b/include/linux/filelock.h
> index c2ce8ba05d068b451ecf8f513b7e532819a29944..70079beddf61aa32ef01f1114cf=
0cb3ffaf2131a 100644
> --- a/include/linux/filelock.h
> +++ b/include/linux/filelock.h
> @@ -49,6 +49,20 @@ struct lease_manager_operations {
>  	int (*lm_change)(struct file_lease *, int, struct list_head *);
>  	void (*lm_setup)(struct file_lease *, void **);
>  	bool (*lm_breaker_owns_lease)(struct file_lease *);
> +
> +	/**
> +	 * lm_may_setlease - extra conditions for setlease
> +	 * @new: new file_lease being set
> +	 * @old: old (extant) file_lease
> +	 *
> +	 * This allows the lease manager to add extra conditions when
> +	 * setting a lease, based on the presence of an existing lease.
> +	 *
> +	 * Return values:
> +	 *   %false: @new and @old conflict
> +	 *   %true: No conflict detected
> +	 */
> +	bool (*lm_may_setlease)(struct file_lease *new, struct file_lease *old);
>  };
> =20
>  struct lock_manager {
>=20
> --=20
> 2.51.0
>=20
>=20


