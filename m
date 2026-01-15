Return-Path: <linux-fsdevel+bounces-73988-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 56A4BD27FCA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 20:16:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9B38E3087CA7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 18:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9DE73C009C;
	Thu, 15 Jan 2026 18:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mo5L59lI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334367E110;
	Thu, 15 Jan 2026 18:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768501947; cv=none; b=n76B+1zI8S1GkarXit9i3j3FeCe8sYE/u7fj5bW63kBHkFlZvPknJ+8VY7+Ty5gz01dfrXTyR0Qz6yl2UV2Woscn+vzWKJHFmajqtEIKIj5VbDlOYRStyYd+1Za/EQOTctdOtql3jP5tBLA960UJh/MujiAIGjVwdqBlCCBD00g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768501947; c=relaxed/simple;
	bh=mu/jwyuzs1woV3EsPbDGdDC5dwANFYIHrH4NaGlTLGQ=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=IUhpPsI1KeRLPaeAF0SBbhD17sgeJA1F7dDw0O+lBD0vk53CP7DGTwlaniiR1r6rAq5UrYpvceJxnDFWrV4cMCmN/EYFGjI+JFBmrXH/9f4OosLH0hv9mtA+RKq3FFnbgnSL47Ge7m/A/dn75FwQTc6MJP1scsn89Ut0CObiRjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mo5L59lI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 558DCC2BC86;
	Thu, 15 Jan 2026 18:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768501946;
	bh=mu/jwyuzs1woV3EsPbDGdDC5dwANFYIHrH4NaGlTLGQ=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=Mo5L59lIzVZwifik0yvo46pJ9Miyr3vUtBJxxLMRh/sqpycJZAzDKRU7FQPxP8x/K
	 OBAHcruQg3na7j0UYspvenCFjX/0iH3qjKcKhgiQC+F+tEeuqlsbZt9/siCMpN5N7D
	 DgDmgUbqFzoQLac+w80K7PJlYfifI5/de2KN3WLOcI2V7gax8Zo7sSFIWe/PGTlXP5
	 wVYnxGwdOcZHnhNLvoRunvNtMSJtWyB+lQ7LJl4gKipY1JgPY1HPQq9ulD83v3WXvZ
	 gAnmAXECJdk+vBnTKcrHAy6EdIeBV3Ba9woAeUUxG8GZAEzI0kvnpM6iScM5aFQ6Hg
	 4S8lbVx6y5Riw==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 3EF58F40068;
	Thu, 15 Jan 2026 13:32:25 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Thu, 15 Jan 2026 13:32:25 -0500
X-ME-Sender: <xms:uTJpabj27YqeJsPpWzmP6lJHqZHM3xS6NXnxyt-02KY4d58e4ljHdg>
    <xme:uTJpaS0wKtDO4nEoZbGKz2Irlr7mINYj63JF8UxM1vZDtrQVL_Ytd9AjmbXLoprna
    vZtOi2ALzu_3ePSs7_iOEZY8bK3zSCbuAnKdzUSWhW6Gfe9XoODe10>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvdeijeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfvehhuhgt
    khcunfgvvhgvrhdfuceotggvlheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrh
    hnpeegheduieeiveevheelheelueeghffhtddtheelhfdutddtheeileetkeelvedtjeen
    ucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomheptghhuhgtkhhlvghvvghrodhmvghsmhhtphgruhht
    hhhpvghrshhonhgrlhhithihqdduieefgeelleelheelqdefvdelkeeggedvfedqtggvlh
    eppehkvghrnhgvlhdrohhrghesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthho
    pedvgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheptghhuhgtkhdrlhgvvhgvrh
    esohhrrggtlhgvrdgtohhmpdhrtghpthhtoheprghlmhgriidrrghlvgigrghnughrohhv
    ihgthhesphgrrhgrghhonhdqshhofhhtfigrrhgvrdgtohhmpdhrtghpthhtoheprghgrh
    huvghnsggrsehrvgguhhgrthdrtghomhdprhgtphhtthhopegrmhgrrhhkuhiivgesrhgv
    ughhrghtrdgtohhmpdhrtghpthhtohepohhkohhrnhhivghvsehrvgguhhgrthdrtghomh
    dprhgtphhtthhopehsfhhrvghntghhsehsrghmsggrrdhorhhgpdhrtghpthhtohepphhh
    ihhllhhiphesshhquhgrshhhfhhsrdhorhhgrdhukhdprhgtphhtthhopegushhtvghrsg
    grsehsuhhsvgdrtghomhdprhgtphhtthhopehjrggtkhesshhushgvrdgtohhm
X-ME-Proxy: <xmx:uTJpaXjYEHydm0-mu6GJjOWkuY79d7YwA39dQa4yBpumpcrJjyZpBA>
    <xmx:uTJpadUspoWOoXgw6wz0Y-rauyDPCjUBX2Bv-lCfOP5KPVWq27YUvw>
    <xmx:uTJpafHdNYgz0ummJq2lkUsN0RmWNdLFj15LzfLEpujlJEEqeqsY4Q>
    <xmx:uTJpad9kkUBSM2-YMJbN3h4r5tNwg8XpVUFGLMjb4EHYpOn_qA6EYA>
    <xmx:uTJpaf32DSIZ0QbXG9Ym4mQcyBvW1vqcIAYpTFxwKSraJ47KfAgzWPHb>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 155C8780070; Thu, 15 Jan 2026 13:32:25 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A7-j_yKLHrMN
Date: Thu, 15 Jan 2026 13:31:54 -0500
From: "Chuck Lever" <cel@kernel.org>
To: "Amir Goldstein" <amir73il@gmail.com>, "Jeff Layton" <jlayton@kernel.org>
Cc: "Christian Brauner" <brauner@kernel.org>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Chuck Lever" <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>,
 "Olga Kornievskaia" <okorniev@redhat.com>,
 "Dai Ngo" <Dai.Ngo@oracle.com>, "Tom Talpey" <tom@talpey.com>,
 "Hugh Dickins" <hughd@google.com>,
 "Baolin Wang" <baolin.wang@linux.alibaba.com>,
 "Andrew Morton" <akpm@linux-foundation.org>,
 "Theodore Tso" <tytso@mit.edu>,
 "Andreas Dilger" <adilger.kernel@dilger.ca>, "Jan Kara" <jack@suse.com>,
 "Gao Xiang" <xiang@kernel.org>, "Chao Yu" <chao@kernel.org>,
 "Yue Hu" <zbestahu@gmail.com>, "Jeffle Xu" <jefflexu@linux.alibaba.com>,
 "Sandeep Dhavale" <dhavale@google.com>,
 "Hongbo Li" <lihongbo22@huawei.com>, "Chunhai Guo" <guochunhai@vivo.com>,
 "Carlos Maiolino" <cem@kernel.org>, "Ilya Dryomov" <idryomov@gmail.com>,
 "Alex Markuze" <amarkuze@redhat.com>,
 "Viacheslav Dubeyko" <slava@dubeyko.com>, "Chris Mason" <clm@fb.com>,
 "David Sterba" <dsterba@suse.com>,
 "Luis de Bethencourt" <luisbg@kernel.org>,
 "Salah Triki" <salah.triki@gmail.com>,
 "Phillip Lougher" <phillip@squashfs.org.uk>,
 "Steve French" <sfrench@samba.org>, "Paulo Alcantara" <pc@manguebit.org>,
 "Ronnie Sahlberg" <ronniesahlberg@gmail.com>,
 "Shyam Prasad N" <sprasad@microsoft.com>,
 "Bharath SM" <bharathsm@microsoft.com>,
 "Miklos Szeredi" <miklos@szeredi.hu>,
 "Mike Marshall" <hubcap@omnibond.com>,
 "Martin Brandenburg" <martin@omnibond.com>,
 "Mark Fasheh" <mark@fasheh.com>, "Joel Becker" <jlbec@evilplan.org>,
 "Joseph Qi" <joseph.qi@linux.alibaba.com>,
 "Konstantin Komarov" <almaz.alexandrovich@paragon-software.com>,
 "Ryusuke Konishi" <konishi.ryusuke@gmail.com>,
 "Trond Myklebust" <trondmy@kernel.org>,
 "Anna Schumaker" <anna@kernel.org>, "Dave Kleikamp" <shaggy@kernel.org>,
 "David Woodhouse" <dwmw2@infradead.org>,
 "Richard Weinberger" <richard@nod.at>, "Jan Kara" <jack@suse.cz>,
 "Andreas Gruenbacher" <agruenba@redhat.com>,
 "OGAWA Hirofumi" <hirofumi@mail.parknet.co.jp>,
 "Jaegeuk Kim" <jaegeuk@kernel.org>,
 "Christoph Hellwig" <hch@infradead.org>, linux-nfs@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-ext4@vger.kernel.org,
 linux-erofs@lists.ozlabs.org, linux-xfs@vger.kernel.org,
 ceph-devel@vger.kernel.org, linux-btrfs@vger.kernel.org,
 linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
 linux-unionfs@vger.kernel.org, devel@lists.orangefs.org,
 ocfs2-devel@lists.linux.dev, ntfs3@lists.linux.dev,
 linux-nilfs@vger.kernel.org, jfs-discussion@lists.sourceforge.net,
 linux-mtd@lists.infradead.org, gfs2@lists.linux.dev,
 linux-f2fs-devel@lists.sourceforge.net
Message-Id: <d486fdb8-686c-4426-9fac-49b7dbc28765@app.fastmail.com>
In-Reply-To: 
 <CAOQ4uxjOJMwv_hRVTn3tJHDLMQHbeaCGsdLupiZYcwm7M2rm3g@mail.gmail.com>
References: <20260115-exportfs-nfsd-v1-0-8e80160e3c0c@kernel.org>
 <CAOQ4uxjOJMwv_hRVTn3tJHDLMQHbeaCGsdLupiZYcwm7M2rm3g@mail.gmail.com>
Subject: Re: [PATCH 00/29] fs: require filesystems to explicitly opt-in to nfsd export
 support
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On Thu, Jan 15, 2026, at 1:17 PM, Amir Goldstein wrote:
> On Thu, Jan 15, 2026 at 6:48=E2=80=AFPM Jeff Layton <jlayton@kernel.or=
g> wrote:
>>
>> In recent years, a number of filesystems that can't present stable
>> filehandles have grown struct export_operations. They've mostly done
>> this for local use-cases (enabling open_by_handle_at() and the like).
>> Unfortunately, having export_operations is generally sufficient to ma=
ke
>> a filesystem be considered exportable via nfsd, but that requires that
>> the server present stable filehandles.
>
> Where does the term "stable file handles" come from? and what does it =
mean?
> Why not "persistent handles", which is described in NFS and SMB specs?
>
> Not to mention that EXPORT_OP_PERSISTENT_HANDLES was Acked
> by both Christoph and Christian:
>
> https://lore.kernel.org/linux-fsdevel/20260115-rundgang-leihgabe-12018=
e93c00c@brauner/
>
> Am I missing anything?

PERSISTENT generally implies that the file handle is saved on
persistent storage. This is not true of tmpfs.

The use of "stable" means that the file handle is stable for
the life of the file. This /is/ true of tmpfs.

--=20
Chuck Lever

