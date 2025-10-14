Return-Path: <linux-fsdevel+bounces-64085-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DB762BD779D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Oct 2025 07:45:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BE4564F0E45
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Oct 2025 05:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCB1129B78F;
	Tue, 14 Oct 2025 05:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="YYPxstny";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="o1lyp4Hf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-b8-smtp.messagingengine.com (flow-b8-smtp.messagingengine.com [202.12.124.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E7F1D6DB5;
	Tue, 14 Oct 2025 05:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.143
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760420719; cv=none; b=toO5O8+7b2drkc3MeLPXLOcSciedYuabT58yPsrUJYPdzNjxAVG1Dn2iR5OfJVfFUCrNSgcNvAfutiZwUTx2lPlinr0pB2Q7VGe4lhWbNAjebB4Z2sgPRIGcrZe8Z+cZDTgaDxWdJ2xOMEJE/3pW9TLcd7QgkQC0Kuon21vyad4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760420719; c=relaxed/simple;
	bh=RIKVc3Wc7E5lYDkBcG6hZen0A7odn0U2DnONdKG10sM=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=iNSKNQ+mShAcYp+p9Hhc1pSpo35c+vlOkPUfU3RqpeWZuLyZEGLfUbeRwRo2JvGZcuFTYdMX6jn2CRaPZ0X7hyBnvqrELg91zSKqzbQWBafd+28WcuDrQHIzUm4LsZR5Bm6XFw8BHsEAtbE7/luyjkX5dIsiMRcZ2U4LKXRRzmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=YYPxstny; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=o1lyp4Hf; arc=none smtp.client-ip=202.12.124.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailflow.stl.internal (Postfix) with ESMTP id 3032313001B1;
	Tue, 14 Oct 2025 01:45:14 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 14 Oct 2025 01:45:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm2; t=
	1760420714; x=1760427914; bh=j6qLjDOtIcdtk5AgTCPFCn752KfsnP8vVAb
	epo18a/8=; b=YYPxstnyAhH94kPt4i4gt21NigyEitKVqBr1HOmWb8GgrQVF2IK
	Wprqozf1xn+JpYetjPJtdnantTfK4imyJo4cduv1YnW7UMeqrvlKXYB/XUymQN/Y
	+sPn30qdoGSFxZTxrL3G7x+MbJZUTHwhOy1KisIeSCEkAG1KcBcG0rKKf1JcoeFM
	feMRUTR7rs22bAS6cupwC142uI0eM1Nmhvq3vtp3DhZ2mNMqZiIUWWy+6grmjSYh
	RgHlevpL7KuTbEGQWygMPDtcSWm294AaRrvurTlQVvVt9gW5C8eZ5SAMRV+Y62gJ
	rw/Pl8CYzeT3lLvLaGE6XiLFQ7TxiU2FewQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760420714; x=
	1760427914; bh=j6qLjDOtIcdtk5AgTCPFCn752KfsnP8vVAbepo18a/8=; b=o
	1lyp4HfCz1sREqiMHUooDHZpuIs1oSmy4Ubn3BqVD1BfskcsxTBjExZkcYHgSgGG
	DX8yB2RCS1UcBLZQqjp1yHRJsNjHfxGlV4Ty7fn7h3WJjmS6zSh2mPwuYzHssaMx
	Iom3exG+zqtncr7pnjvBr8mD8Ru6aHUlGhg1a1OFtePsdSsUHMa7q5ftBJxU6C0P
	vLJF4jOVy/a5ZP2LoEctfHRERq8QXFR2z9oj54KuJ2rqF4pnTulnt8uA+38c3dz6
	2LR54H9NMvS6BsFAwzHbiFBdr4hE87lmyZ/1BaMf04pYjk4iHGlYZCFzcFwIuW3C
	codPUVkhvwziRiNBNS25A==
X-ME-Sender: <xms:aePtaJocOYYwcIEzEofmcxua6qHqgo4rr543Y-fbpkSiMfm9kFRtCQ>
    <xme:aePtaKrqhOCVyImXh2Ahl76JRoUDmOVhDcC7oIeimuiAQL7jIdOcE3-GMTnyen82b
    0QUuRjqV-jzqU0UlqbeSYqEsixKgKRyqJNMlR0d4X-GLYGkDA>
X-ME-Received: <xmr:aePtaOc9y_N-cKikfqlY-xwff9Q0_8BeWzQI9ua55peuXfl49IJfvqWAtntI4Bfe-0A9fHZy9utJoCPdDA7zmikc8ML8oRL-YCJWxxlIRhfh>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduudeljedvucetufdoteggodetrf
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
X-ME-Proxy: <xmx:aePtaBT7jO-yJ29_xlesceJUtXlanxbVKtg8IRcjOeMpWnvEEM8vyA>
    <xmx:aePtaCf2q2nEau_f0phRQhSaBLSnVgmf4cTihukiHMKyqG4Vxvn9Ug>
    <xmx:aePtaJDoAJ5MKeE66u5aWsyflyrKuDZ8qGniKvKiXWhRHvslsE5fnw>
    <xmx:aePtaHvqvSSRQMx1wjfLOMuklXE1TCvT9vetmvBfDyehBS73I1ybmQ>
    <xmx:auPtaGGRK-w7dQ7sOZfWa_yW2IEjkThX-ARa1b5CiCYNo0ZK89nGgsL7>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Oct 2025 01:45:02 -0400 (EDT)
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
Subject: Re: [PATCH 10/13] nfsd: allow filecache to hold S_IFDIR files
In-reply-to: <20251013-dir-deleg-ro-v1-10-406780a70e5e@kernel.org>
References: <20251013-dir-deleg-ro-v1-0-406780a70e5e@kernel.org>,
 <20251013-dir-deleg-ro-v1-10-406780a70e5e@kernel.org>
Date: Tue, 14 Oct 2025 16:45:00 +1100
Message-id: <176042070049.1793333.3305827349841340282@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Tue, 14 Oct 2025, Jeff Layton wrote:
> The filecache infrastructure will only handle S_ISREG files at the
> moment. Plumb a "type" variable into nfsd_file_do_acquire and have all
> of the existing callers set it to S_ISREG. Add a new

S_IFREG  (s/IS/IF/)  :-)

Otherwise looks good.


> nfsd_file_acquire_dir() wrapper that we can then call to request a
> nfsd_file that holds a directory open.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

NeilBrown

