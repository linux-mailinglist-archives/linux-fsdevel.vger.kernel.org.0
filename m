Return-Path: <linux-fsdevel+bounces-74016-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F0D1D28C4C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 22:39:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A01AE30F0A87
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 21:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85CB032863B;
	Thu, 15 Jan 2026 21:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VEJBaYjA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E62FD30B501;
	Thu, 15 Jan 2026 21:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768513080; cv=none; b=f+A/o8S0QsRCWFPuzKmI5qm+Dt4o4hvnyo9MOytr9aAhPOWieT5wNoEFN1x2rrcZz1txgehuOC73j4UIhJnaVCf7m/9zl+LvixfUOKFs0WTvdjEJWlPnCr3fLnypHqz5RwH2T/wntxpud31YGK/nQs6eTeWKeO/EH+CdZNWQg4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768513080; c=relaxed/simple;
	bh=0fqCmxD4yKmMSe6/QFTJtZ3ssoTn2Cuf5H+QMDU346c=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=reB8Tad0pIrkF2mkJUoJKz7B8TDoDPIUF7QpZMsscr4HsXyRsps0Ey/TOy3QfHMhKOPFeFvHB5KOsy7VHfSmyxRNJR9+HvU0l9bZhNqe4BKKZfAxhH4snv67VcgkUFCOFuoS9xEOy6Oc4AyNAvABzmQrmTACS2mj30mO2EnTv1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VEJBaYjA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 102ADC116D0;
	Thu, 15 Jan 2026 21:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768513079;
	bh=0fqCmxD4yKmMSe6/QFTJtZ3ssoTn2Cuf5H+QMDU346c=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=VEJBaYjA5BMCFCo1PVoVleNz0PVBIOLV4N43WWurvyqUOcBmx6SKFygGh5tcYf/In
	 vS4CJeV5N7/iDoVyh5ra65MW02t8ryHabCbmlqmnE7TJRQHrodE2c+q2PWa+FQvjsL
	 Y+Lc20Cm3gG/uGZjlRPntu3iykCPChBh2tlQMIeI0ua1mdQy6Ajsos9mC4Vd8bTEL7
	 x0GPKM+R+C3M7fQoQ4l8lvJ3iqGgBbjCvTdvDVtTGWTg6gpejkGj6pokJQARY88CHc
	 akH7P34QMvnel2BZo67QDnuXeMGDxIR2fbJlE9oVEmL29f/pGKN/r1GljGyDPF1cR4
	 v7nK+ed3eg0SQ==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id EBEB6F4006C;
	Thu, 15 Jan 2026 16:37:57 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Thu, 15 Jan 2026 16:37:57 -0500
X-ME-Sender: <xms:NV5padSqgmmI774iAps7E8rAK9eJu6Oo24dzsdB0LtMdH_MIhejwSQ>
    <xme:NV5paRkIHIFIrtsoDuaEYE4h5-cZe4bU4Mg1FxeyWoB0_FB5n__AZjKZXCJY2m552
    Rbqyyj1VWU8tKIwXs4POFF87J0uMM76-OrCuzTQuWzw3147R1PHdbE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvdejudehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfvehhuhgt
    khcunfgvvhgvrhdfuceotggvlheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrh
    hnpeegheduieeiveevheelheelueeghffhtddtheelhfdutddtheeileetkeelvedtjeen
    ucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomheptghhuhgtkhhlvghvvghrodhmvghsmhhtphgruhht
    hhhpvghrshhonhgrlhhithihqdduieefgeelleelheelqdefvdelkeeggedvfedqtggvlh
    eppehkvghrnhgvlhdrohhrghesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthho
    pedvhedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepuggrihdrnhhgohesohhrrg
    gtlhgvrdgtohhmpdhrtghpthhtoheptghhuhgtkhdrlhgvvhgvrhesohhrrggtlhgvrdgt
    ohhmpdhrtghpthhtoheprghlmhgriidrrghlvgigrghnughrohhvihgthhesphgrrhgrgh
    honhdqshhofhhtfigrrhgvrdgtohhmpdhrtghpthhtoheprghgrhhuvghnsggrsehrvggu
    hhgrthdrtghomhdprhgtphhtthhopegrmhgrrhhkuhiivgesrhgvughhrghtrdgtohhmpd
    hrtghpthhtohepohhkohhrnhhivghvsehrvgguhhgrthdrtghomhdprhgtphhtthhopehs
    fhhrvghntghhsehsrghmsggrrdhorhhgpdhrtghpthhtohepphhhihhllhhiphesshhquh
    grshhhfhhsrdhorhhgrdhukhdprhgtphhtthhopegushhtvghrsggrsehsuhhsvgdrtgho
    mh
X-ME-Proxy: <xmx:NV5pafq9leqvEaoLKct45DsgMBIbQtOsGMj0p7cgBQCvwSIFIgIfig>
    <xmx:NV5paa5gllaH6pnOyD_UGlCmqnEEMXGfNG9imdyD0Gp4TeUZbBtaRA>
    <xmx:NV5paVHRbjr7ztPeuldQS-_gihKV2rk_0rt2Jg160qFl7gtwF_E60w>
    <xmx:NV5paZ7PpIqZJEDAuMqIEmyPsuF3r8Zj9C01G-pNalaF0yUoUBBuMw>
    <xmx:NV5paQjepwCnXFoYX1v3UyP7qvlKgPyGr619exY1uoWx3_gE8RTCc3hi>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id B4F44780070; Thu, 15 Jan 2026 16:37:57 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A7-j_yKLHrMN
Date: Thu, 15 Jan 2026 16:37:27 -0500
From: "Chuck Lever" <cel@kernel.org>
To: "Dave Chinner" <david@fromorbit.com>
Cc: "Amir Goldstein" <amir73il@gmail.com>,
 "Jeff Layton" <jlayton@kernel.org>,
 "Christian Brauner" <brauner@kernel.org>,
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
Message-Id: <06dcc4b6-7457-4094-a1c6-586ce518020f@app.fastmail.com>
In-Reply-To: <aWlXfBImnC_jhTw4@dread.disaster.area>
References: <20260115-exportfs-nfsd-v1-0-8e80160e3c0c@kernel.org>
 <CAOQ4uxjOJMwv_hRVTn3tJHDLMQHbeaCGsdLupiZYcwm7M2rm3g@mail.gmail.com>
 <d486fdb8-686c-4426-9fac-49b7dbc28765@app.fastmail.com>
 <CAOQ4uxhnoTC6KBmRVx2xhvTXYg1hRkCJWrq2eoBQGHKC3sv3Hw@mail.gmail.com>
 <4d9967cc-a454-46cf-909b-b8ab2d18358d@kernel.org>
 <aWlXfBImnC_jhTw4@dread.disaster.area>
Subject: Re: [PATCH 00/29] fs: require filesystems to explicitly opt-in to nfsd export
 support
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On Thu, Jan 15, 2026, at 4:09 PM, Dave Chinner wrote:
> On Thu, Jan 15, 2026 at 02:37:09PM -0500, Chuck Lever wrote:
>> On 1/15/26 2:14 PM, Amir Goldstein wrote:
>> > On Thu, Jan 15, 2026 at 7:32=E2=80=AFPM Chuck Lever <cel@kernel.org=
> wrote:
>> >>
>> >>
>> >>
>> >> On Thu, Jan 15, 2026, at 1:17 PM, Amir Goldstein wrote:
>> >>> On Thu, Jan 15, 2026 at 6:48=E2=80=AFPM Jeff Layton <jlayton@kern=
el.org> wrote:
>> >>>>
>> >>>> In recent years, a number of filesystems that can't present stab=
le
>> >>>> filehandles have grown struct export_operations. They've mostly =
done
>> >>>> this for local use-cases (enabling open_by_handle_at() and the l=
ike).
>> >>>> Unfortunately, having export_operations is generally sufficient =
to make
>> >>>> a filesystem be considered exportable via nfsd, but that require=
s that
>> >>>> the server present stable filehandles.
>> >>>
>> >>> Where does the term "stable file handles" come from? and what doe=
s it mean?
>> >>> Why not "persistent handles", which is described in NFS and SMB s=
pecs?
>> >>>
>> >>> Not to mention that EXPORT_OP_PERSISTENT_HANDLES was Acked
>> >>> by both Christoph and Christian:
>> >>>
>> >>> https://lore.kernel.org/linux-fsdevel/20260115-rundgang-leihgabe-=
12018e93c00c@brauner/
>> >>>
>> >>> Am I missing anything?
>> >>
>> >> PERSISTENT generally implies that the file handle is saved on
>> >> persistent storage. This is not true of tmpfs.
>> >=20
>> > That's one way of interpreting "persistent".
>> > Another way is "continuing to exist or occur over a prolonged perio=
d."
>> > which works well for tmpfs that is mounted for a long time.
>>=20
>> I think we can be a lot more precise about the guarantee: The file
>> handle does not change for the life of the inode it represents. It
>
> <pedantic mode engaged>
>
> File handles most definitely change over the life of a /physical/
> inode. Unlinking a file does not require ending the life of the
> physical object that provides the persistent data store for the
> file.
>
> e.g. XFS dynamically allocates physical inodes might in a life cycle
> that looks somewhat life this:
>
> 	allocate physical inode
> 	insert record into allocated inode index
> 	mark inode as free
>
> 	while (don't need to free physical inode) {
> 		...
> 		allocate inode for a new file
> 		update persistent inode metadata to generate new filehandle
> 		mark inode in use
> 		...
> 		unlink file
> 		mark inode free
> 	}
>
> 	remove inode from allocated inode index
> 	free physical inode
>
> i.e. a free inode is still an -allocated, indexed inode- in the
> filesystem, and until we physically remove it from the filesystem
> the inode life cycle has not ended.
>
> IOWs, the physical (persistent) inode lifetime can span the lifetime
> of -many- files. However, the filesystem guarantees that the handle
> generated for that inode is different for each file it represents
> over the whole inode life time.
>
> Hence I think that file handle stability/persistence needs to be
> defined in terms of -file lifetimes-, not the lifetimes of the
> filesystem objects implement the file's persistent data store.

Fair enough, "inode" is the wrong term to use here.


--=20
Chuck Lever

