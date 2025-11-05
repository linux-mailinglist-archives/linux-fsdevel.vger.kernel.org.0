Return-Path: <linux-fsdevel+bounces-67207-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4033C38090
	for <lists+linux-fsdevel@lfdr.de>; Wed, 05 Nov 2025 22:31:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D420E463C0A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Nov 2025 21:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41E7B2E174B;
	Wed,  5 Nov 2025 21:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="HmU5hGoP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qSmEJgx4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-b6-smtp.messagingengine.com (flow-b6-smtp.messagingengine.com [202.12.124.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A34F23F424;
	Wed,  5 Nov 2025 21:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762377849; cv=none; b=i4JciZp882lhO+EIRmak5VUTyfPbdPgWOHnqVKwi4FWsn4BmrrY3n5csFOyxN3y4F/PTyi40oXxqfCoJu1opa0WoeU5FTq5NF1Jzg62sbd+YQH6NK7C51ezim9QzetLr4fux9Ft5Dweed7WDI9ZyPZ2YxwU2O0ock1eFhXdDLLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762377849; c=relaxed/simple;
	bh=u7d9evMnHLg8hJK0Bj/mYGhbV3SaK5dJyb8wyfl1+zg=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=HShAdk2x0EZ/hCfR6hiYIh+DOtgJ/yMqTxtEDwpRYr+c4sQHQZ0WxHnwh1YVCmt2oX/xazquhtSrOnEbpf9jc/MyJf/pPUbsnVrQGSxvgduq9+doZq6Gg8KjwfsgaxOjl5JoqsEmmU7VW1+/5SfQ20tMBzrydN3y2BPbTgye7U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=HmU5hGoP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qSmEJgx4; arc=none smtp.client-ip=202.12.124.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailflow.stl.internal (Postfix) with ESMTP id 1739B1300C2C;
	Wed,  5 Nov 2025 16:24:03 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 05 Nov 2025 16:24:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm3; t=
	1762377842; x=1762385042; bh=EVCZm+k0TFnzyISAYv/ad61W8yGyS+Ggtni
	ecPh35bI=; b=HmU5hGoPqokqzJCeAqGf4BLGNy0MGNPv7gplJ67n7ajHRRuR5XU
	QACgC7SBMngKWRr4nVPjJJgBKA3Q8lvkyUIGSJ1J47cOcYiClbPU1pS4MppGb5wh
	2U2/xgadcENW/jgHJsJTyYYdk+1XjojR7/TQqmLQq3cUPGl27XnIya4CBHC1wN5U
	B+nehvMy/L9Mb2tEVTuU62Q/a0ARwc5MO2szCGIyxpVtm6vXzecjyFmyuGF+NoPC
	aDoFRHfQnTUA0wUc9ga83EokX5Vq/Y4zVF59Z0IqpO5AZkbSr//2iHDO/uH6Mdle
	v+KzAJeRAhAF2PY5f//xFYICp+6h/EtUY0Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1762377842; x=
	1762385042; bh=EVCZm+k0TFnzyISAYv/ad61W8yGyS+GgtniecPh35bI=; b=q
	SmEJgx4M8dlmgTjoUZkSr8FLucgLUEVlbd9odWDFkQcMJ+PFRsH9Y//0VRWWOa2P
	Ww7Nr0XlQSokRvZEPNvVMlDa6wHjsBAaK17Tal0oudel/kBoVldVw56udPXn9uh7
	Mczp91CekHgkQQrSfj7GW2ikHW7rCR3uH+ZZqm5byT0S1cyww1zJkHKJ+SuERDBe
	UBNUFH0g9LBeW66OTxBJSBU1+z1R+WJlAHRefWLPYecfVMfJsDxhw/7LXOajVkRK
	EY0gezm21MwMMJYPZofen2+s3eL3i0IyTk0/RNQdye2aRU/x2B6K2Dlf35uwcujj
	UVMV0x49c00E0JFs7mDIA==
X-ME-Sender: <xms:asALaQBQoSVaUuTXtcG_GYkEHX7ZGK1IdW3-DpTTeAob7NvcdQnESw>
    <xme:asALaZvvSYTRURk71wOmt1sLYQpre30qKc9hcTtEoays4h59X1vNTOzcXv4ewIAT7
    PBP05Cv2IT0eKS3Y5hzt-pSpQXWpNcWFPc3z3tPuShZJnbiAw>
X-ME-Received: <xmr:asALaV1K1vj_trpV4WX4Ug9tckywabHWFw4izsBwBHNEfUZdhT2LhWV0hKbStCEFmuTyATTpSjnEcu5m6FzT9u-CFv5Y_mYw-vIlsrnNGGDt>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddukeegleejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurheptgfgggfhvfevufgjfhffkfhrsehtqhertddttdejnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epleejtdefgeeukeeiteduveehudevfeffvedutefgteduhfegvdfgtdeigeeuudejnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsg
    esohifnhhmrghilhdrnhgvthdpnhgspghrtghpthhtohepleegpdhmohguvgepshhmthhp
    ohhuthdprhgtphhtthhopehvihhrohesiigvnhhivhdrlhhinhhugidrohhrghdruhhkpd
    hrtghpthhtohepfhhrrghnkhdrlhhisehvihhvohdrtghomhdprhgtphhtthhopehlihhn
    uhigqdigfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugi
    dquhhnihhonhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhn
    uhigqdhnihhlfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinh
    hugidqnhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhig
    qdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuh
    igqdhhrghruggvnhhinhhgsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    lhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:asALafmPr_ZX1OBseZ_yN5P8ha0kcdOo70DqfQ-d7eox1J3FRhMuTg>
    <xmx:asALaYv6caGo7YOyqxlwHt-aa7xcS6ubR74B6joQPFkP4nVa857B-Q>
    <xmx:asALaQazXCEbXKvEWtOde9MGMuFd4iSpENdxHY6Br8A6SQLP9UCqOg>
    <xmx:asALaUc6XxQI42baNH5r4oVKLbArJeUxiTNL9duhGxUFeugLz9diCA>
    <xmx:csALaZ2nr3Xo9lu7ZwRVoMnu5vfNzgtS4RKi9tfb5i1b6hqQye68vliH>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Nov 2025 16:23:32 -0500 (EST)
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
Cc: "Eric Van Hensbergen" <ericvh@kernel.org>,
 "Latchesar Ionkov" <lucho@ionkov.net>,
 "Dominique Martinet" <asmadeus@codewreck.org>,
 "Christian Schoenebeck" <linux_oss@crudebyte.com>,
 "David Sterba" <dsterba@suse.com>, "David Howells" <dhowells@redhat.com>,
 "Marc Dionne" <marc.dionne@auristor.com>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Christian Brauner" <brauner@kernel.org>, "Jan Kara" <jack@suse.cz>,
 "Tigran A. Aivazian" <aivazian.tigran@gmail.com>,
 "Chris Mason" <clm@fb.com>, "Xiubo Li" <xiubli@redhat.com>,
 "Ilya Dryomov" <idryomov@gmail.com>, "Jan Harkes" <jaharkes@cs.cmu.edu>,
 coda@cs.cmu.edu, "Tyler Hicks" <code@tyhicks.com>,
 "Jeremy Kerr" <jk@ozlabs.org>, "Ard Biesheuvel" <ardb@kernel.org>,
 "Namjae Jeon" <linkinjeon@kernel.org>,
 "Sungjong Seo" <sj1557.seo@samsung.com>,
 "Yuezhang Mo" <yuezhang.mo@sony.com>, "Theodore Ts'o" <tytso@mit.edu>,
 "Andreas Dilger" <adilger.kernel@dilger.ca>,
 "Jaegeuk Kim" <jaegeuk@kernel.org>, "Chao Yu" <chao@kernel.org>,
 "OGAWA Hirofumi" <hirofumi@mail.parknet.co.jp>,
 "Miklos Szeredi" <miklos@szeredi.hu>,
 "Andreas Gruenbacher" <agruenba@redhat.com>,
 "Viacheslav Dubeyko" <slava@dubeyko.com>,
 "John Paul Adrian Glaubitz" <glaubitz@physik.fu-berlin.de>,
 "Yangtao Li" <frank.li@vivo.com>, "Richard Weinberger" <richard@nod.at>,
 "Anton Ivanov" <anton.ivanov@cambridgegreys.com>,
 "Johannes Berg" <johannes@sipsolutions.net>,
 "Mikulas Patocka" <mikulas@artax.karlin.mff.cuni.cz>,
 "Muchun Song" <muchun.song@linux.dev>,
 "Oscar Salvador" <osalvador@suse.de>,
 "David Hildenbrand" <david@redhat.com>,
 "David Woodhouse" <dwmw2@infradead.org>,
 "Dave Kleikamp" <shaggy@kernel.org>,
 "Trond Myklebust" <trondmy@kernel.org>,
 "Anna Schumaker" <anna@kernel.org>,
 "Ryusuke Konishi" <konishi.ryusuke@gmail.com>,
 "Konstantin Komarov" <almaz.alexandrovich@paragon-software.com>,
 "Mark Fasheh" <mark@fasheh.com>, "Joel Becker" <jlbec@evilplan.org>,
 "Joseph Qi" <joseph.qi@linux.alibaba.com>,
 "Bob Copeland" <me@bobcopeland.com>,
 "Mike Marshall" <hubcap@omnibond.com>,
 "Martin Brandenburg" <martin@omnibond.com>,
 "Amir Goldstein" <amir73il@gmail.com>,
 "Steve French" <sfrench@samba.org>, "Paulo Alcantara" <pc@manguebit.org>,
 "Ronnie Sahlberg" <ronniesahlberg@gmail.com>,
 "Shyam Prasad N" <sprasad@microsoft.com>, "Tom Talpey" <tom@talpey.com>,
 "Bharath SM" <bharathsm@microsoft.com>,
 "Zhihao Cheng" <chengzhihao1@huawei.com>,
 "Hans de Goede" <hansg@kernel.org>, "Carlos Maiolino" <cem@kernel.org>,
 "Hugh Dickins" <hughd@google.com>,
 "Baolin Wang" <baolin.wang@linux.alibaba.com>,
 "Andrew Morton" <akpm@linux-foundation.org>,
 "Kees Cook" <kees@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 linux-kernel@vger.kernel.org, v9fs@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, linux-afs@lists.infradead.org,
 linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org,
 codalist@coda.cs.cmu.edu, ecryptfs@vger.kernel.org,
 linux-efi@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, gfs2@lists.linux.dev,
 linux-um@lists.infradead.org, linux-mm@kvack.org,
 linux-mtd@lists.infradead.org, jfs-discussion@lists.sourceforge.net,
 linux-nfs@vger.kernel.org, linux-nilfs@vger.kernel.org,
 ntfs3@lists.linux.dev, ocfs2-devel@lists.linux.dev,
 linux-karma-devel@lists.sourceforge.net, devel@lists.orangefs.org,
 linux-unionfs@vger.kernel.org, linux-cifs@vger.kernel.org,
 samba-technical@lists.samba.org, linux-xfs@vger.kernel.org,
 linux-hardening@vger.kernel.org, "Jeff Layton" <jlayton@kernel.org>
Subject:
 Re: [PATCH] vfs: remove the excl argument from the ->create() inode_operation
In-reply-to: <20251105-create-excl-v1-1-a4cce035cc55@kernel.org>
References: <20251105-create-excl-v1-1-a4cce035cc55@kernel.org>
Date: Thu, 06 Nov 2025 08:23:24 +1100
Message-id: <176237780417.634289.15818324160940255011@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Thu, 06 Nov 2025, Jeff Layton wrote:
> Since ce8644fcadc5 ("lookup_open(): expand the call of vfs_create()"),
> the "excl" argument to the ->create() inode_operation is always set to
> true. Remove it, and fix up all of the create implementations.

nonono


> @@ -3802,7 +3802,7 @@ static struct dentry *lookup_open(struct nameidata *n=
d, struct file *file,
>  		}
> =20
>  		error =3D dir_inode->i_op->create(idmap, dir_inode, dentry,
> -						mode, open_flag & O_EXCL);
> +						mode);

"open_flag & O_EXCL" is not the same as "true".

It is true that "all calls to vfs_create() pass true for 'excl'"
The same is NOT true for inode_operations.create.

NeilBrown


