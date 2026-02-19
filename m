Return-Path: <linux-fsdevel+bounces-77658-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IPH9NipglmkTegIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77658-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 01:58:18 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4598815B473
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 01:58:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3F0EE30297A8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 00:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A01522A7F9;
	Thu, 19 Feb 2026 00:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="QUPrI0wN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="W+NZ3jac"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC7D2AF00;
	Thu, 19 Feb 2026 00:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771462689; cv=none; b=IOEY+pFlrfZ/2MYJrw7YbYiladkMAN0v4pl1Uc+2Naq1xubrAKqprPcSMJn5SxuMs5edbOX4XoD6Y9Htaz5E8oNmex/xYQL1hxSYIbP9oPVwwdKSKeb9angMtTsKwNvTaggxbYakmca5wD3fuOoG/oR0R8jyucm6B/ZIbdz0/CU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771462689; c=relaxed/simple;
	bh=/mLPN+gqX7WgqsuKT7hVJ2tT7/p3OQX0qBElguK9lqE=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=SgZqkQZrYEg3wNbGl0DHakbB4/RFVa94B4r6boiApFJ6Tz/EtDStnV3FdebLPkVaJu1sB/WAPJ5TbzBFIpr7gnR4Jw/ho2ftflykId+RLT1F0mRnebjrgvSgfcY7ujiBzemIZv2r3LAsHLWrzPK53JRx4+vudAwmdcQv5u9v7BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=QUPrI0wN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=W+NZ3jac; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 30386EC05A5;
	Wed, 18 Feb 2026 19:58:07 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 18 Feb 2026 19:58:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm3; t=
	1771462687; x=1771549087; bh=d3gGUdBAtomJarI2vjZZMoWKgO1aI7iK5Mx
	uZziQs2Q=; b=QUPrI0wN6PvVratea+/Qb9rHKEPIbJ9gvS6cb98i8Lcn8FxQ7y5
	76tWTi2nCh01/MO9ad0xuKiRAAbUIieZFICjdRQ4LUdgFuXcA+5xZF1VXbqD4hS9
	b6lD/+N+pU0pEMl3lUOg0N/avS99jkvp8l4rO7iGo/xEkJNNCsxRmrrBs2pLXRes
	H0u7hcnBVNYNRYZHiNP9CAYwLsMm7cPRgplSkidS12G2qBJmsDOImrK7PNsvv2Xv
	8OlEIbZDMDi0QjA52yRb2EsMcbRTJBTHqK40dBFbRfZiFYPzZN4Vdz303tc1ceh6
	suSbHulV0C7CQ4SHc/bC/YHYEO4Lddm/hSw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771462687; x=
	1771549087; bh=d3gGUdBAtomJarI2vjZZMoWKgO1aI7iK5MxuZziQs2Q=; b=W
	+NZ3jac0mKFwX92kCEKNHamxzwvQ2r6oe24NHARXuCAYlrygIGfrDZROSQqReKlm
	nqrpcE4rNP44ZglPUJRX5g7msfc2l0VA9tDTyydJn/vl9mte0QwfVgR8WK/56RUq
	/+4y5y/XVr+0jSBlAbnQfb1mHehOhXUiO3r6fiNICadWygjx6nt2Sc6TBcRqFWqF
	rqL+zFt5wE96F8bR5+Zl/YCPipXKFj7K7vMS3rjU0+C+o8mb/C+lqiuTscpRJeYU
	M0fLGDrSuYPwIec3h0lr6MEwKrSr8Wi8Nm9CVgvfLDagipDQ7zriOViSrsrxMjDl
	y0g5DFt2v+KvYyV8SCjzQ==
X-ME-Sender: <xms:HWCWafSYS66TaYqZIILkZ3NFxai7vLuPFH9gfzn-WwcbzfHa40mZqA>
    <xme:HWCWaRvWw_YLrQyXnOQMQdGNYlDxkhGdHOGKPF9mo9L01c8iU8aTrHjEHk4CcNt2x
    LA7Ghx5n8LimvXeTUAglmCCfCtIggTlJSJHh_DJfYS1Hx69GA>
X-ME-Received: <xmr:HWCWaVJxT62jjHIxUhNZMV4g1JHYgX476HmtA_mABIVC9nNVeiwPVfhRWo0Fp3JKrOhUZVa6sVqs2jHNeL3tgBjljR1bDAEYxQl86JReb0U3>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvdegudegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurheptgfgggfhvfevufgjfhffkfhrsehtqhertddttdejnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epueefiedvjeekfeeludeuueduieejvdelledtudehgeetkeduvdelhfeuvdevudejnecu
    ffhomhgrihhnpehkvghrnhgvlhdrohhrghdpghhithhhuhgsrdgtohhmpdhlihhnuhigtg
    honhhtrghinhgvrhhsrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepnhgvihhlsgesohifnhhmrghilhdrnhgvthdpnhgspghrtghpth
    htohepudejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehlihhnuhigqdhnfhhs
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqfhhsuggvvh
    gvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehmihhklhhoshesshii
    vghrvgguihdrhhhupdhrtghpthhtohepjhgrtghksehsuhhsvgdrtgiipdhrtghpthhtoh
    epshhtghhrrggsvghrsehsthhgrhgrsggvrhdrohhrghdprhgtphhtthhopehtrhgrphgv
    gihithesshhprgifnhdrlhhinhhkpdhrtghpthhtohepuhhtrghmtdhksehprhgvfhgvrh
    hrvggurdhjphdprhgtphhtthhopehkshhughhihhgrrhgrsehprhgvfhgvrhhrvggurdhj
    phdprhgtphhtthhopegthhhutghkrdhlvghvvghrsehorhgrtghlvgdrtghomh
X-ME-Proxy: <xmx:HWCWade1vGvv6gy4czlGRXTXcawvXfI_jHkeeFsV5eWZZLFl4UGmAg>
    <xmx:HWCWafU44jgAhExyi0X66CrfIDO_qA-nycSMuwQCdTphozwK9P2Azg>
    <xmx:HWCWaTgdn7gwZ43jTs1JOuLCVC9r0WQ1E_M26b6DaSQKFZ5p5TvDqA>
    <xmx:HWCWaRhdgdJB-fQ8X9yuNfX_9rlCf_nsjB8BLEBBtkSp6UF4-c4HGw>
    <xmx:H2CWaV8h45gnVZG_1M3bCrOIyfBxvGj4pQdehycA5rAEs2sxa1HQLPK0>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Feb 2026 19:58:00 -0500 (EST)
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
Cc: "Alexander Mikhalitsyn" <alexander@mihalicyn.com>,
 lsf-pc@lists.linux-foundation.org, aleksandr.mikhalitsyn@futurfusion.io,
 linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
 stgraber@stgraber.org, brauner@kernel.org, ksugihara@preferred.jp,
 utam0k@preferred.jp, trondmy@kernel.org, anna@kernel.org,
 chuck.lever@oracle.com, miklos@szeredi.hu, jack@suse.cz, amir73il@gmail.com,
 trapexit@spawn.link
Subject: Re: [LSF/MM/BPF TOPIC] VFS idmappings support in NFS
In-reply-to: <e0be58df89ffaf41763312dfffe8402fdcb9d023.camel@kernel.org>
References: <65a53a2d6fcc053edeed688a8c8d580c03bd6f3b.camel@mihalicyn.com>,
 <d11b39cb43ffe437868eef4bc1c01d3bce8509e9.camel@kernel.org>,
 <CAJqdLrqNzXRwMF2grTGCkaMKCEXAwemQLEi3wsL5Lp2W9D-ZVg@mail.gmail.com>,
 <e0be58df89ffaf41763312dfffe8402fdcb9d023.camel@kernel.org>
Date: Thu, 19 Feb 2026 11:57:59 +1100
Message-id: <177146267901.8396.9601896246772305364@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ownmail.net,none];
	R_DKIM_ALLOW(-0.20)[ownmail.net:s=fm3,messagingengine.com:s=fm3];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-77658-lists,linux-fsdevel=lfdr.de];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[mihalicyn.com,lists.linux-foundation.org,futurfusion.io,vger.kernel.org,stgraber.org,kernel.org,preferred.jp,oracle.com,szeredi.hu,suse.cz,gmail.com,spawn.link];
	FREEMAIL_FROM(0.00)[ownmail.net];
	RCPT_COUNT_TWELVE(0.00)[17];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	HAS_REPLYTO(0.00)[neil@brown.name];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[neilb@ownmail.net,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[ownmail.net:+,messagingengine.com:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[brown.name:replyto,noble.neil.brown.name:mid,futurfusion.io:url,preferred.jp:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4598815B473
X-Rspamd-Action: no action

On Thu, 19 Feb 2026, Jeff Layton wrote:
> On Wed, 2026-02-18 at 15:36 +0100, Alexander Mikhalitsyn wrote:
> > Am Mi., 18. Feb. 2026 um 14:49 Uhr schrieb Jeff Layton <jlayton@kernel.or=
g>:
> > >=20
> > > On Wed, 2026-02-18 at 13:44 +0100, Alexander Mikhalitsyn wrote:
> > > > Dear friends,
> > > >=20
> > > > I would like to propose "VFS idmappings support in NFS" as a topic fo=
r discussion at the LSF/MM/BPF Summit.
> > > >=20
> > > > Previously, I worked on VFS idmap support for FUSE/virtiofs [2] and c=
ephfs [1] with support/guidance
> > > > from Christian.
> > > >=20
> > > > This experience with Cephfs & FUSE has shown that VFS idmap semantics=
, while being very elegant and
> > > > intuitive for local filesystems, can be quite challenging to combine =
with network/network-like (e.g. FUSE)
> > > > FSes. In case of Cephfs we had to modify its protocol (!) (see [2]) a=
s a part of our agreement with
> > > > ceph folks about the right way to support idmaps.
> > > >=20
> > > > One obstacle here was that cephfs has some features that are not very=
 Linux-wayish, I would say.
> > > > In particular, system administrator can configure path-based UID/GID =
restrictions on a *server*-side (Ceph MDS).
> > > > Basically, you can say "I expect UID 1000 and GID 2000 for all files =
under /stuff directory".
> > > > The problem here is that these UID/GIDs are taken from a syscall-call=
er's creds (not from (struct file *)->f_cred)
> > > > which makes cephfs FDs not very transferable through unix sockets. [3]
> > > >=20
> > > > These path-based UID/GID restrictions mean that server expects client=
 to send UID/GID with every single request,
> > > > not only for those OPs where UID/GID needs to be written to the disk =
(mknod, mkdir, symlink, etc).
> > > > VFS idmaps API is designed to prevent filesystems developers from mak=
ing a mistakes when supporting FS_ALLOW_IDMAP.
> > > > For example, (struct mnt_idmap *) is not passed to every single i_op,=
 but instead to only those where it can be
> > > > used legitimately. Particularly, readlink/listxattr or rmdir are not =
expected to use idmapping information anyhow.
> > > >=20
> > > > We've seen very similar challenges with FUSE. Not a long time ago on =
Linux Containers project forum, there
> > > > was a discussion about mergerfs (a popular FUSE-based filesystem) & V=
FS idmaps [5]. And I see that this problem
> > > > of "caller UID/GID are needed everywhere" still blocks VFS idmaps ado=
ption in some usecases.
> > > > Antonio Musumeci (mergerfs maintainer) claimed that in many cases fil=
esystems behind mergerfs may not be fully
> > > > POSIX and basically, when mergerfs does IO on the underlying FSes it =
needs to do UID/GID switch to caller's UID/GID
> > > > (taken from FUSE request header).
> > > >=20
> > > > We don't expect NFS to be any simpler :-) I would say that supporting=
 NFS is a final boss. It would be great
> > > > to have a deep technical discussion with VFS/FSes maintainers and dev=
elopers about all these challenges and
> > > > make some conclusions and identify a right direction/approach to thes=
e problems. From my side, I'm going
> > > > to get more familiar with high-level part of NFS (or even make PoC if=
 time permits), identify challenges,
> > > > summarize everything and prepare some slides to navigate/plan discuss=
ion.
> > > >=20
> > > > [1] cephfs https://lore.kernel.org/linux-fsdevel/20230807132626.18210=
1-1-aleksandr.mikhalitsyn@canonical.com
> > > > [2] cephfs protocol changes https://github.com/ceph/ceph/pull/52575
> > > > [3] cephfs & f_cred https://lore.kernel.org/lkml/CAEivzxeZ6fDgYMnjk21=
qXYz13tHqZa8rP-cZ2jdxkY0eX+dOjw@mail.gmail.com/
> > > > [4] fuse/virtiofs https://lore.kernel.org/linux-fsdevel/2024090315162=
6.264609-1-aleksandr.mikhalitsyn@canonical.com/
> > > > [5]
> > > > mergerfshttps://discuss.linuxcontainers.org/t/is-it-the-case-that-you=
-cannot-use-shift-true-for-disk-devices-where-the-source-is-a-mergerfs-mount-=
is-there-a-workaround/25336/11?u=3Damikhalitsyn
> > > >=20
> > > > Kind regards,
> > > > Alexander Mikhalitsyn @ futurfusion.io
> > >=20
> >=20
> > Hi Jeff,
> >=20
> > thanks for such a fast reply! ;)
> >=20
> > >=20
> > > IIUC, people mostly use vfs-layer idmappings because they want to remap
> > > the uid/gid values of files that get stored on the backing store (disk,
> > > ceph MDS, or whatever).
> >=20
> > yes, precisely.
> >=20
> > >=20
> > > I've never used idmappings myself much in practice. Could you lay out
> > > an example of how you would use them with NFS in a real environment so
> > > I understand the problem better? I'd start by assuming a simple setup
> > > with AUTH_SYS and no NFSv4 idmapping involved, since that case should
> > > be fairly straightforward.
> >=20
> > For me, from the point of LXC/Incus project, idmapped mounts are used as
> > a way to "delegate" filesystems (or subtrees) to the containers:
> > 1. We, of course, assume that container enables user namespaces and
> > user can't mount a filesystem
> > inside because it has no FS_USERNS_MOUNT flag set (like in case of Cephfs=
, NFS,
> > CIFS and many others).
> > 2. At the same time host's system administrator wants to avoid
> > remapping between container's user ns and
> > sb->s_user_ns (which is init_user_ns for those filesystems). [
> > motivation here is that in many
> > cases you may want to have the same subtree to be shared with other
> > containers and even host users too and
> > you want UIDs to be "compatible", i.e UID 1000 in one container and
> > UID 1000 in another container should
> > land as UID 1000 on the filesystem's inode ]
> >=20
> > For this usecase, when we bind-mount filesystem to container, we apply
> > VFS idmap equal to container's
> > user namespace. This makes a behavior I described.
> >=20
>=20
> Ok: so you have a process running in a userns as UID 2000 and you want
> to use vfs layer idmapping so that when you create a file as that user
> that it ends up being owned by UID 1000. Is that basically correct?
>=20
> Typically, the RPC credentials used in an OPEN or CREATE call is what
> determines its ownership (at least until a SETATTR comes in). With
> AUTH_SYS, the credential is just a uid and set of gids.
>=20
> So in this case, it sounds like you would need just do that conversion
> (maybe at the RPC client layer?) when issuing an RPC. You don't really
> need a protocol extension for that case.

You also need to consider the conversion when receiving an RPC.

If you use krb5 and NFSv3 then you really want the mapping between krb5
identity and uid to be the same on client and server, so then when an
application creates a file and the stats it, it sees that it owns it.

If I use a krb5 identity in an idmapped NFS filesystem I'll want the
server to map the identity to the "underlying" uid (was would be stored
in a local filesystem) and then when the client gets a GETATTR reply,
the VFS maps back to the uid seen by the application.

With NFSv4 and the idmapper you wouldn't need (or want) the kernel
idmapping to be used at all.  You would want the idmapper deamon to run
in the user-namespace and map from on-the-wire names to the appropriate
app-level uids.
This would mean that a given NFS mount would need to be an a given user
namespace.  Maybe that isn't desired.

If it is important for a given NFS mount to be available in multiple
user namespaces, then the idmapper daemon would need to map to the
underlying uid, and the VFS mapping would map that up to the app-level
uid.

NeilBrown


>=20
> As Trond points out though, AUTH_GSS and NFSv4 idmapping will make this
> more complex. Once you're using kerberos credentials for
> authentication, you don't have much control over what the UIDs and GIDs
> will be on newly-created files, but is that really a problem? As long
> as all of the clients have a consistent view, I wouldn't think so.
>=20
> > But this is just one use case. I'm pretty sure there are some more
> > around here :)
> > I know that folks from Preferred Networks (preferred.jp) are also
> > interested in VFS idmap support in NFS,
> > probably they can share some ideas/use cases too.
> >=20
> >=20
>=20
> Yes, we don't want to focus too much on a single use-case, but I find
> it helpful to focus on a single simple problem first.
> --=20
> Jeff Layton <jlayton@kernel.org>
>=20
>=20


