Return-Path: <linux-fsdevel+bounces-67502-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EC8BC41D43
	for <lists+linux-fsdevel@lfdr.de>; Fri, 07 Nov 2025 23:30:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 245124E56DD
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Nov 2025 22:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9C873148D3;
	Fri,  7 Nov 2025 22:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="RSl+2Ovm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UuwaUA5H"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-b3-smtp.messagingengine.com (flow-b3-smtp.messagingengine.com [202.12.124.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C4761F4CA9;
	Fri,  7 Nov 2025 22:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762554621; cv=none; b=B6Gk440rJkqTWqlee7+vvrypHgfpnj+sraRZojUhfzHjMaHt0wpoM9Mklp+QtaVS7Q3EWbrOmeT/Fn7vDqdR8mLx+5A+O1i3VMkTCKGWUmLJNTDDn+Aw2E0j239iakuPtkZroNT0RC8Uxa9adMRYLWQ3y4/pbybK2tQf7culAOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762554621; c=relaxed/simple;
	bh=W+ttskEK9RUptSjJ3i+3bIIqHWPThqYvd6x7/NI5P2o=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=cJ2bQbcpx/OQclvRLgy8SSh8A1UpGV0uBXYTmbRCncsZfvF4XdPaCTyQz94AqYZ6APUsuYK/9TzFf0hA3OE5TxVU/3Lq2I0NuOaWcf93LaURh5aNlavXx0Y50cu3nz5buLEscnxLKvTW4DAx7OkP6AITIWx1GDunho4W88vqUu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=RSl+2Ovm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UuwaUA5H; arc=none smtp.client-ip=202.12.124.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailflow.stl.internal (Postfix) with ESMTP id 793A513004D8;
	Fri,  7 Nov 2025 17:30:15 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Fri, 07 Nov 2025 17:30:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm3; t=
	1762554615; x=1762561815; bh=ZwkPbF9nsnt/dQhVAIT39vJvv4cO/9hCxNu
	UVfACV+4=; b=RSl+2OvmuLLOe4+H9eKpqC9RuowrdRH1jGe8qwVoOfdZ4I27ekS
	h347QoJGR7MbFLykEaO1W0OFpHRCXityFGk6z/rxp66MZo+KGt12LqqTInEw2CYx
	3UVsJ0CnGd7WLdxCGmc3/jPkOyINCLxKnxNZklsUc3J3YikUBo2z3iRjiXQtMcY8
	yq2lYeSEAVc2EWLQj1vGWye7x7mEIpjRksMMLReKQwYai89hN6GT0qLs9w2fXT/S
	aMCWnv9MVDkZT/W5daTSkcLSwc8NcaRJOdNaOs10bJXlSp1ckOlZsLuPaoex29HZ
	f8A5rEk01MsQM2q7vJ8gaDY5oWS9+X43upg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1762554615; x=
	1762561815; bh=ZwkPbF9nsnt/dQhVAIT39vJvv4cO/9hCxNuUVfACV+4=; b=U
	uwaUA5HM3Mo8/6XH0sr3iEvIm8qkyq18WHGz5dmT4o3VuNPYFK0sT5/XwMakgpxt
	Ddom64XoCKrACYy2h4ZcgV+Tb8PW+9ZOvOvsw3PhcaXohwqssibqLdWfGuvkRTof
	t0u6Tm24jIfdJQPXMml4ZsBV3LhgKvo8idsWtpOv2NMgA6+6q/kF7vulaDiw1Wu8
	QXM1pWPcrGZS5Ickwb89bPU2A6H7dDCOZcL68OGNiBqQPLXtlFiE4VEh4FSXHbCH
	jVfBahE281hNyxR2h1puiT9DkuKNVkHHM+JFBCiTT4EucRcOcOrhAYY2UT2c/Eoo
	JZasuDe2hIsiAlgrLmPZw==
X-ME-Sender: <xms:8HIOaWcJ3fvBIlxYhSXg2q9kliHbCJheSrwA-afUtv0OZvqwXLDyaQ>
    <xme:8HIOaUV0elXG3FvBZLynkKLK1KgrkL5csSh7j4QStWTKC78ohwNtKKCTXTTHgS-gp
    tx6yHyJkUTuEkTZ5fK6ZZAuUD2GiIcU7CC_2eZ5UrNZYjQDQA>
X-ME-Received: <xmr:8HIOaZisnAl3bLTOnvZKYyms_eoqV6GZneXYuZmTxpw76w3Ai29fkPeeLdpc1Or3ahBpEelhGgOyPonxIcN_mwWmfK2BHg0p1qv3ZiVRU6Jc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduledtkeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurheptgfgggfhvfevufgjfhffkfhrsehtjeertddttdejnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epudetfefhudevhedvfeeufedvffekveekgfdtfefggfekheejgefhteeihffggfelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsg
    esohifnhhmrghilhdrnhgvthdpnhgspghrtghpthhtohepleejpdhmohguvgepshhmthhp
    ohhuthdprhgtphhtthhopehvihhrohesiigvnhhivhdrlhhinhhugidrohhrghdruhhkpd
    hrtghpthhtohepfhhrrghnkhdrlhhisehvihhvohdrtghomhdprhgtphhtthhopehlihhn
    uhigqdigfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugi
    dquhhnihhonhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhn
    uhigqdhnihhlfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinh
    hugidqnhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhig
    qdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuh
    igqdhhrghruggvnhhinhhgsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    lhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:8HIOaQRYcr2XZwYm0IZqPOguq_RH9vLLuCtHHjKz_7fIxkwW75Seeg>
    <xmx:8HIOaYxjBK0ZJhgdNXL6-GZM5wqctaqKx4DPCA07b6HaSPRwb68vzg>
    <xmx:8HIOaa-QnxtUrxuCdvh7t737bdTRYVtIsmaz5JhvP3JtprsULcfyDA>
    <xmx:8HIOacn1Ltrl3NwobU3IDf3ppIfGvZcjgmhPN9__dNGKj77ZkqtQiQ>
    <xmx:93IOadG3kN8Y0sl9-bllfvn04bE55YSNPrlPh3KgJLC15UMHH_zqyJDP>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Nov 2025 17:29:44 -0500 (EST)
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
 "Jonathan Corbet" <corbet@lwn.net>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
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
 linux-hardening@vger.kernel.org, linux-doc@vger.kernel.org,
 "Jeff Layton" <jlayton@kernel.org>
Subject: Re: [PATCH v2] vfs: remove the excl argument from the ->create()
 inode_operation
In-reply-to: <20251107-create-excl-v2-1-f678165d7f3f@kernel.org>
References: <20251107-create-excl-v2-1-f678165d7f3f@kernel.org>
Date: Sat, 08 Nov 2025 09:29:43 +1100
Message-id: <176255458305.634289.5577159882824096330@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Sat, 08 Nov 2025, Jeff Layton wrote:
> With two exceptions, ->create() methods provided by filesystems ignore
> the "excl" flag.  Those exception are NFS and GFS2 which both also
> provide ->atomic_open.
> 
> Since ce8644fcadc5 ("lookup_open(): expand the call of vfs_create()"),
> the "excl" argument to the ->create() inode_operation is always set to
> true in vfs_create(). The ->create() call in lookup_open() sets it
> according to the O_EXCL open flag, but is never called if the filesystem
> provides ->atomic_open().
> 
> The excl flag is therefore always either ignored or true.  Remove it,
> and change NFS and GFS2 to act as if it were always true.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
> Note that this is based on top of the dir delegation series [1]. LMK
> if the Documentation/ updates are too wordy.

Patch is very nice.  I don't think the documentation is too wordy.
I think it is good that the two changes to the different files say
essentially the same thing but use different words.  That helps.

Reviewed-by: NeilBrown <neil@brown.name>

> 
> Full disclosure: I did use Claude code to generate the first
> approximation of this patch, but I had to fix a number of things that it
> missed.  I probably could have given it better prompts. In any case, I'm
> not sure how to properly attribute this (or if I even need to).

My understanding is that if you fully understand (and can defend) the
code change with all its motivations and implications as well as if you
had written it yourself, then you don't need to attribute whatever fancy
text editor or IDE (e.g.  Claude) that you used to help produce the
patch.

Thanks,
NeilBrown

