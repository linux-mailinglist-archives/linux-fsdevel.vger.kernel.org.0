Return-Path: <linux-fsdevel+bounces-74931-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uF/3EyFYcWlVGAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74931-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 23:50:09 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 0023B5F112
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 23:50:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AB2D6600E77
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 22:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59E95449EBE;
	Wed, 21 Jan 2026 22:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="GuovOWXR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GQln8ftB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-b6-smtp.messagingengine.com (flow-b6-smtp.messagingengine.com [202.12.124.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9291A3A9D98;
	Wed, 21 Jan 2026 22:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769035693; cv=none; b=KqgwEG6JVJzgwc9uvSJTBljPfDe3iYYx3gwZ1TZwXMR7Y0VKp+nZVRPXDcOixwGVRcrcA3ud+3UP+Fo0l5nszSvcRJtw9i5VtQiDb6nKGjjPkEAw+0tHc5vC+OYwxc3+W3cSv6uVUUAMGlQcv3h10fmZqABVVk3xAPufMAy+3uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769035693; c=relaxed/simple;
	bh=qPvaj1CJudRWH8TWXb/DPXHF0yJiMz7RI8byLvamKBE=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=R4AHi9qgrXEZU56Br+ruKeD9+p0Xz8grKPbPfLi9yHZNys4amZJZCZRwrJMLoPYz1lG/qG1QeTjeV0e3oOP8pBryqa0DUcJ9eVaXDlxD4gqvrT78uGdirUa//3sGlupJvmSQGScKiQflIOovMZanTAYjw0FRjEvxRXKfotTghdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=GuovOWXR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GQln8ftB; arc=none smtp.client-ip=202.12.124.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailflow.stl.internal (Postfix) with ESMTP id 8D6A31300F24;
	Wed, 21 Jan 2026 17:48:08 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 21 Jan 2026 17:48:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm2; t=
	1769035688; x=1769042888; bh=5coOyJl4iosEMxvKLf9pz/D+NbUu48dkiDD
	9Y2kxJME=; b=GuovOWXRBLUE5OJcSyLnE/2eveX/36uTx36j9P93zjQcQRBZQL2
	hrnzBjQOgzs/f0q+zVSV1tWHCGJeldpGO5tNxzbNYGAmGERTI/74rC4AhDEcwnbN
	3EK+IxK9Da7qBxTZ0cL7/5RdElCmK5xx1WEmeVCQTAdbEDCJzhvLIyYH/VUBXRn2
	h49SQEqoXX9n4peKNOiWNTGeGPiK9qsGhIMzVRsfQ8nV0r0CSHnLs3nYhgIfpNL3
	aRQdXpKb6VS0ww0j3QddijYoBo1Kwrkcj+Ox1b+DG22Mrte7SY069e+GdbfIhnlj
	3VqqpOkLrd4aGQop2LrD926E4486pl+anPw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1769035688; x=
	1769042888; bh=5coOyJl4iosEMxvKLf9pz/D+NbUu48dkiDD9Y2kxJME=; b=G
	Qln8ftBpavKFAA+sJNEPaaNr8oKurXmo3q4BaVp9GwaWB1fm8C563yxGcgYW93DS
	2xtNzCjbtolaXD67qz6Qutqe5geB5bsD8Ugeg6j/LWjxuo9XwZj1mmfo4drLgUP2
	yKqhpGLcalZ4u5NUgfoc97greSYLp54DwzSB4S6wHw4u2msQsbGk5ZA8IJMGNIbQ
	ngZ+8m6ZYaIowc/dHLMNgP5a1uqvjsJX/qkbUxNoCKOD6a2oW1oaQNc62xAi1nw9
	1ilzAzJcDO41rfb5T7w8GgYR5Vyc6IoiPl6WjnE4pmvyLFxhbYKi59Pm07XkqffD
	MH3MYMODbYPIXIIlLoSWg==
X-ME-Sender: <xms:o1dxaZ-cMFc_o0d43ug7z0kzLEBmcLr7-qnETyPvdBZuqqtXE2bH3w>
    <xme:o1dxaWu_cgJpAPDvXRifHWGeBvpSKMc12f7rFBgOoG_tMemlpn3xQTXYgCwgfa7tz
    OXDCzuK93xla979oqbjqOFhStCl3Vabm505SJATmkmL4XzdyA>
X-ME-Received: <xmr:o1dxaTxZPCOrm1mlblqPiWzOX285XPSCGpXm-fKvOvS9y7eJCkfR7O9aWP_lCWxHfYgXgfjqf3Vws4y9gRuwORW00qGz0381O1TtjVlRJXe1>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugeeghedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurheptgfgggfhvfevufgjfhffkfhrsehtqhertddttdejnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epleejtdefgeeukeeiteduveehudevfeffvedutefgteduhfegvdfgtdeigeeuudejnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsg
    esohifnhhmrghilhdrnhgvthdpnhgspghrtghpthhtohepjeejpdhmohguvgepshhmthhp
    ohhuthdprhgtphhtthhopehvihhrohesiigvnhhivhdrlhhinhhugidrohhrghdruhhkpd
    hrtghpthhtohepghhuohgthhhunhhhrghisehvihhvohdrtghomhdprhgtphhtthhopehl
    ihhnuhigqdigfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinh
    hugidquhhnihhonhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehl
    ihhnuhigqdhnihhlfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplh
    hinhhugidqnhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhn
    uhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlih
    hnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    lhhinhhugidqvgigthegsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:o1dxabxtlAdkhpwCkINTEBpxmOYNyzwJPUiM41SluU32_hzzNA9XZQ>
    <xmx:o1dxafCKgd9STI3lGSZvVjQToHTy1h7liCKSrmU9waffzwMuC1NFUA>
    <xmx:o1dxaY793FR_a6LdPfr_ZHshxnAh_1jwBDA6jddarcyZMxIXycacjw>
    <xmx:o1dxaRMf9cXehnUejISjAclfFWLd7Zsy6-U0xLPbufXx8cPynQ1yZw>
    <xmx:qFdxaSd_vulaCSCn1gwPqzAJtzBUIYK-Pjhk-xVuA_6gzPYpL8lA2saQ>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Jan 2026 17:47:43 -0500 (EST)
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
Cc: "Christoph Hellwig" <hch@infradead.org>,
 "Christian Brauner" <brauner@kernel.org>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Chuck Lever" <chuck.lever@oracle.com>,
 "Olga Kornievskaia" <okorniev@redhat.com>,
 "Dai Ngo" <Dai.Ngo@oracle.com>, "Tom Talpey" <tom@talpey.com>,
 "Amir Goldstein" <amir73il@gmail.com>, "Hugh Dickins" <hughd@google.com>,
 "Baolin Wang" <baolin.wang@linux.alibaba.com>,
 "Andrew Morton" <akpm@linux-foundation.org>,
 "Theodore Ts'o" <tytso@mit.edu>,
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
 "Jaegeuk Kim" <jaegeuk@kernel.org>, "Jonathan Corbet" <corbet@lwn.net>,
 "David Laight" <david.laight.linux@gmail.com>,
 "Dave Chinner" <david@fromorbit.com>, linux-nfs@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-ext4@vger.kernel.org,
 linux-erofs@lists.ozlabs.org, linux-xfs@vger.kernel.org,
 ceph-devel@vger.kernel.org, linux-btrfs@vger.kernel.org,
 linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
 linux-unionfs@vger.kernel.org, devel@lists.orangefs.org,
 ocfs2-devel@lists.linux.dev, ntfs3@lists.linux.dev,
 linux-nilfs@vger.kernel.org, jfs-discussion@lists.sourceforge.net,
 linux-mtd@lists.infradead.org, gfs2@lists.linux.dev,
 linux-f2fs-devel@lists.sourceforge.net, linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 01/31] Documentation: document EXPORT_OP_NOLOCKS
In-reply-to: <d8d68d1df6838c382799ce58345cfb5366585a8f.camel@kernel.org>
References: <>, <d8d68d1df6838c382799ce58345cfb5366585a8f.camel@kernel.org>
Date: Thu, 22 Jan 2026 09:47:41 +1100
Message-id: <176903566115.16766.12892778448343562390@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[ownmail.net:s=fm2,messagingengine.com:s=fm2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[ownmail.net,none];
	TAGGED_FROM(0.00)[bounces-74931-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[infradead.org,kernel.org,zeniv.linux.org.uk,oracle.com,redhat.com,talpey.com,gmail.com,google.com,linux.alibaba.com,linux-foundation.org,mit.edu,dilger.ca,suse.com,huawei.com,vivo.com,dubeyko.com,fb.com,squashfs.org.uk,samba.org,manguebit.org,microsoft.com,szeredi.hu,omnibond.com,fasheh.com,evilplan.org,paragon-software.com,nod.at,suse.cz,mail.parknet.co.jp,lwn.net,fromorbit.com,vger.kernel.org,kvack.org,lists.ozlabs.org,lists.samba.org,lists.orangefs.org,lists.linux.dev,lists.sourceforge.net,lists.infradead.org];
	FREEMAIL_FROM(0.00)[ownmail.net];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[ownmail.net:+,messagingengine.com:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[neilb@ownmail.net,linux-fsdevel@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCPT_COUNT_GT_50(0.00)[77];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	HAS_REPLYTO(0.00)[neil@brown.name];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[noble.neil.brown.name:mid,ownmail.net:dkim,ams.mirrors.kernel.org:helo,ams.mirrors.kernel.org:rdns,brown.name:replyto,messagingengine.com:dkim]
X-Rspamd-Queue-Id: 0023B5F112
X-Rspamd-Action: no action

On Wed, 21 Jan 2026, Jeff Layton wrote:
> On Wed, 2026-01-21 at 20:58 +1100, NeilBrown wrote:
> > On Wed, 21 Jan 2026, Jeff Layton wrote:
> > > On Tue, 2026-01-20 at 09:12 -0500, Jeff Layton wrote:
> > > > On Tue, 2026-01-20 at 08:20 -0500, Jeff Layton wrote:
> > > > > On Mon, 2026-01-19 at 23:44 -0800, Christoph Hellwig wrote:
> > > > > > On Mon, Jan 19, 2026 at 11:26:18AM -0500, Jeff Layton wrote:
> > > > > > > +  EXPORT_OP_NOLOCKS - Disable file locking on this filesystem.=
 Some
> > > > > > > +    filesystems cannot properly support file locking as implem=
ented by
> > > > > > > +    nfsd. A case in point is reexport of NFS itself, which can=
't be done
> > > > > > > +    safely without coordinating the grace period handling. Oth=
er clustered
> > > > > > > +    and networked filesystems can be problematic here as well.
> > > > > >=20
> > > > > > I'm not sure this is very useful.  It really needs to document wh=
at
> > > > > > locking semantics nfs expects, because otherwise no reader will k=
now
> > > > > > if they set this or not.
> > > > >=20
> > > > > Fair point. I'll see if I can draft something better. Suggestions
> > > > > welcome.
> > > >=20
> > > > How about this?
> > > >=20
> > > > +  EXPORT_OP_NOLOCKS - Disable file locking on this filesystem. Files=
ystems
> > > > +    that want to support locking over NFS must support POSIX file lo=
cking
> > > > +    semantics and must handle lock recovery requests from clients af=
ter a
> > > > +    reboot. Most local disk, RAM, or pseudo-filesystems use the gene=
ric POSIX
> > > > +    locking support in the kernel and naturally provide this capabil=
ity. Network
> > > > +    or clustered filesystems usually need special handling to do thi=
s properly.
> > >=20
> > > Even better, I think?
> > >=20
> > > +
> > > +  EXPORT_OP_NOLOCKS - Disable file locking on this filesystem. Filesys=
tems
> > > +    that want to support locking over NFS must support POSIX file lock=
ing
> > > +    semantics. When the server reboots, the clients will issue request=
s to
> > > +    recover their locks, which nfsd will issue to the filesystem as ne=
w lock
> > > +    requests. Those must succeed in order for lock recovery to work. M=
ost
> > > +    local disk, RAM, or pseudo-filesystems use the generic POSIX locki=
ng
> > > +    support in the kernel and naturally provide this capability. Netwo=
rk or
> > > +    clustered filesystems usually need special handling to do this pro=
perly.
> > > +    Set this flag on filesystems that can't guarantee the proper seman=
tics
> > > +    (e.g. reexported NFS).
> >=20
> > I think this is quite thorough, which it good ...  maybe too good :-) It
> > reminds me that for true NFS compatibility the fs shouldn't allow local
> > locks (or file opens!) until the grace period has passed.  I don't think
> > any local filesystems enforce that - it would have to be locks.c that
> > does I expect.  I doubt there would be much appetite for doing that
> > though.
> >=20
>=20
> Yeah, I don't see us ever doing that. It'd be a tricky chicken-and-egg
> problem, given the demand-driven way that the mountd upcalls work
> today. We don't even know that anything is exported until something
> asks for it.

statd keeps state in /var/lib/nfs/sm, and nfsd keeps v4 state elsewhere
in /var/lib/nfs.  This state effectively records if any NFS client might
try to recover a lock.
I think the v4 state is granular enough to identify the filesystem.
lockd could be enhanced to use the same state I suspect.

We would need to generalise that state and load it at mount time and
block new state creation accordingly.

i.e. this would have to be a vfs-level thing which nfsd makes use of.

Possibly, but there are other things better worth our time.

NeilBrown


