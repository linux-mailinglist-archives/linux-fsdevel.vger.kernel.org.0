Return-Path: <linux-fsdevel+bounces-66869-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72104C2EA54
	for <lists+linux-fsdevel@lfdr.de>; Tue, 04 Nov 2025 01:38:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 623BC3A5EE3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Nov 2025 00:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63121207A09;
	Tue,  4 Nov 2025 00:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="ZXaqscoA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uIbao+gH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-b2-smtp.messagingengine.com (flow-b2-smtp.messagingengine.com [202.12.124.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 051131A2C11;
	Tue,  4 Nov 2025 00:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762216473; cv=none; b=lzlOV+EXsjNYiPsaLH82jB2wgfDB69HCrBzNK2JJd5irOhA0ernPHKF7molmUp6ATqrwMBg6o6Ol6YMWqMEbUEPkPrcMM25M5D3SP7HsnhDDMp/boTNZ/ygUAVW8329u0lKV3+ku1RPy+IzqzAk1rSsNsRhXKTzRNChhYloJj84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762216473; c=relaxed/simple;
	bh=BGZwrpus3lHtfsbvhH4iXIFhobnmKnvjJoGJprtyb3k=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=N7ANdc6HMAfsJ5Uh4UpKDKYp+h68C5a+KtKVozcXAv+cJXm0Jb3ya38MrQbuO36Rn4g3nDwhSUpUZkuzrKooN8PUwTThbJS58DKpvoSoHNYbn8IVXXcrF4jkgAmfiDAV1VgSXm3TFQ8wjDDHloqOGb267iLLgbFHVFEhAS3RbyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=ZXaqscoA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uIbao+gH; arc=none smtp.client-ip=202.12.124.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailflow.stl.internal (Postfix) with ESMTP id 30BE41300AAF;
	Mon,  3 Nov 2025 19:34:30 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 03 Nov 2025 19:34:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm3; t=
	1762216470; x=1762223670; bh=qeQ9pSvQPAFnDOoHPFbKVWO6Cl7+FMERadY
	NQKykv7k=; b=ZXaqscoAoWcyH5B6xlrBBs/1+Rbd43ofN8C2+S833h0k/oNrSwV
	tAPafKpitQJp18rWNitPDWUEXYlHxhySCAmJPDB2F4lWtimOf5M6zxQw1LHwyQbi
	boU+V3+XsmK+8yJT3a4tW/nDkdJNf2N5GLldQAQcw4fFN8KV4VxCBeS9bI4x2SJr
	NER8eXk22/5ALkGXkrRQBGuSbFvp12ruMqe5r+Z83PiW1LUny24nlxWxc13HsQId
	niT5mXQfHrwnzboeDYCBTQ+RnHf08JnJdKNGS24XVRxiDoxSXF6YCIBA9yfSv6lJ
	E1zyPCY4CGtHO76G9ZIQUTgooqrpI5FilIg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1762216470; x=
	1762223670; bh=qeQ9pSvQPAFnDOoHPFbKVWO6Cl7+FMERadYNQKykv7k=; b=u
	Ibao+gH9sPTr2bMMb8QFEzQCRAhf/D0CjSv3wC9IXrnO5K1G3KSxmRI8jQQUEgcJ
	oWSCbYF8ejh/x6nBRUIpNP5szu0CKcUe3P7Shoua8EPrptU3c2MYR3X5j14a5dyq
	jIz5Lls2CEVdxPMnITfhZCW6o139DpG+KcWN3W6ZzRNFEW7zDhHx1LRLk81jxYYx
	wBKUSaLgYJgRavsvONgEcLjy88Ipj2YwVQzhcQZbcslWl0FKlIHamDwvN0YlFf3s
	FMGx6mYrl5QDpBiwfz7Fnvf7hSc3NCkLc38qqWu0I5NHlsHKfXX/u0J9d/3dJTn4
	8tcV9XfAWtpmeFQKrHCJA==
X-ME-Sender: <xms:FUoJaXYKrufVPSQJF8yOL7P3S15hULdNbQHFw3Q-P9WggcvC-K8u_w>
    <xme:FUoJaVbZ0XsaJ3UHNUfy6u6Go54wGf1pPefW6xlXguX5iaX6NOMNk5-pVE2yMVQsl
    RB1_SsanqQtUXC7G2e_M0JJ130va4vB0Gvc-eLqZchJlxQq-Q>
X-ME-Received: <xmr:FUoJaSNli2Bk6QH8ww3lpsxfug9luibV5gSJW-ye3CQdnk_LIKWJXHAwq9t9KkZwisurttg_OyfvPLrvL-96yEdKU-Pk3J7mWxVpX0VP8_B3>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddujeelheekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurheptgfgggfhvfevufgjfhffkfhrsehtjeertddttdejnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epudetfefhudevhedvfeeufedvffekveekgfdtfefggfekheejgefhteeihffggfelnecu
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
X-ME-Proxy: <xmx:FUoJaaCX7ROhHlMxfULTjMpZCXgJx070-5t210jOrh2vKf1Dbsc70Q>
    <xmx:FUoJacNlhGxAsNNP0sTE0PwH-m67-XImxsL7odxy-Iy5MH7tEpM_Wg>
    <xmx:FUoJafyVPnRwFltBkXYn0n3f5Z_EqJ8RodWi2JrDgGA2BRx_fYEGWg>
    <xmx:FUoJaXfJX06EVls3FZbb6OdR9ehl65ofH1qSAGck_eYJQGsDo2rIOg>
    <xmx:FkoJad1IPwXLYRPa8uXI6XqJquLGVJAuaWDq2BDfal-cowKmcB1EugxP>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Nov 2025 19:34:18 -0500 (EST)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
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
Subject: Re: [PATCH v4 09/17] vfs: add struct createdata for passing arguments
 to vfs_create()
In-reply-to: <176221480589.1793333.7801494824880510264@noble.neil.brown.name>
References: <20251103-dir-deleg-ro-v4-0-961b67adee89@kernel.org>, <>,
 <20251103-dir-deleg-ro-v4-9-961b67adee89@kernel.org>,
 <176221480589.1793333.7801494824880510264@noble.neil.brown.name>
Date: Tue, 04 Nov 2025 11:34:14 +1100
Message-id: <176221645432.1793333.17238801449784435061@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Tue, 04 Nov 2025, NeilBrown wrote:
> On Mon, 03 Nov 2025, Jeff Layton wrote:
> > vfs_create() has grown an uncomfortably long argument list, and a
> > following patch will add another. Convert it to take a new struct
> > createdata pointer and fix up the callers to pass one in.
> > 
> 
> I know Christian asked for this and he is a Maintainer so.....
> 
> but I would like say that I don't think this is a win.  The argument
> list isn't *that* long, and all the args are quite different so there is
> little room for confusion.
> 
> I would be in favour of dropping the "dir" arg because it is always
>    d_inode(dentry->d_parent)
> which is stable.
> 
> I would rather pass the vfsmnt rather than the idmap, then we could pass
> "struct path", for both that and dentry, but I know Christian disagrees.
> 
> So if anyone really thinks the arg list is too long, I think there are
> better solutions.  But I don't even think the length is a problem.

Also *every* caller of vfs_create() passes ".excl = true".  So maybe we
don't need that arg at all.

I think that the last time false might have been passed to vfs_create()
was before

Commit ce8644fcadc5 ("lookup_open(): expand the call of vfs_create()")

NeilBrown

