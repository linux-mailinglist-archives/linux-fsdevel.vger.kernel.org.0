Return-Path: <linux-fsdevel+bounces-73728-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A19F7D1F588
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 15:16:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1F764301EF98
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 14:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CBBE2D7DD3;
	Wed, 14 Jan 2026 14:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ATDvkPvs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 354272D661C
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Jan 2026 14:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768400073; cv=none; b=LHdA/AW073Sv2WwTz1hQcc+2wJHd/7cb858Undl+5mmC66cXOA8WtOgyXPvGDveTL3IA7pNAw++CgXBaO99o+TMJecFy4K3b/KXA1FzhJ1fBgO2RivTeJ2n0mtajXeCJZr10YTgi90Hc3eZannKUxW66qGH6qfea3Gpj2ncRT9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768400073; c=relaxed/simple;
	bh=EVxOIndNclLVBz66EPG+/56lwGCRWQUQFbefqx9zJEA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p/IZ8TfJN94OGLCruBOAR2wW0dvl7f+kNLJIKC2EexWioOAzszDED6AKNCvuVlZwLFcEU7BacD4NcIo2LMkUPFPpLtMhqWDEfN+9GEnk5TIvRNWhuotM4ifw6GOqPFAQTWa4MRRajnmAlpCvhxpTybajMCC3PA8p6mSyYlThj+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ATDvkPvs; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6505d3adc3aso13498761a12.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Jan 2026 06:14:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768400067; x=1769004867; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LXI/JsxBbKF9LcEy7WQN83dkdhDN53l6d1BjVlfpBx8=;
        b=ATDvkPvsgMJyP3EIhSx+waeN9em7laMQLBeBB3nIO+P3DLVzV5+OaA+5w7ya7SWhN8
         wxwHQhvJgPAWmt6bUYWUHbmYg+0uA+NXPZ27hecPI96gQRzBbIIMHPS88+NAz+S2onWh
         IITOWoxVIC/1im6BVMkfcl6YB9fPp9i7tIlNEeE+z1DHFBYIlBTQXnVMON5eCvNh29i2
         gui/dtbkxpTqMyfBpOA8f7X1MzRlvBCgmW/njxfFa4ST5kIbk7NQ8bL7m07qTToF/Mmq
         kPMZz0eQcj4/Yi8GH6Zjk8I6SVs2qWA0kbfAyllVjXHX6l8TuerIvVK9OcJa+huOZOJx
         fxlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768400067; x=1769004867;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LXI/JsxBbKF9LcEy7WQN83dkdhDN53l6d1BjVlfpBx8=;
        b=k65D37/DNORntMqnEW/JOStdP6tvTJItj+DY+EVRHWhm76VBakOMg97LaIPBLK+95K
         2FTK4xbzgfCMxhendpfqFIMDG0A2fAu16Dcn3g5v7rHU9qWiS3Yc+X+MLT+P4aoVY+I1
         gVgrZE+fGsJI509hlS/20FzOnYlXMkSWntz7SYd02bJ0wsH9IRxi+dB6+1vMboHfLk2w
         Y+tynpWJ1OKGoWzA3M+VynimGJgozBEYfQILI+MaWx3ofPG5+cw7tVpoU1wMZY3rZUTB
         1J37WbJ5qoV7cerGLOdgVVvX5kJ1TB+v6yN2R6QSlVCfI/Pgt3iaA/4JgV2CHA3nfoDm
         FPUQ==
X-Forwarded-Encrypted: i=1; AJvYcCUwnLdJQ30GgvQBQtqaXWQbx2PnQnLyndFloSw3WRfqt+3StISMd37rMHsA4+qFz7mRu8IcYaYRKRPWXCc1@vger.kernel.org
X-Gm-Message-State: AOJu0YxXLTfh0aO00PElD9KWQjbWSKiHe74LX9zcAZfrsA55yFJRP9IE
	wWGRihEVdwB3AlIRlbSmODzAwMP7pswg3KnQ/IlO868RolGnQ436kIRizN3V8NatcdgliMDYHyq
	FmXabfdodpCQ6IA2H+RHfIRvE+/Ock+c=
X-Gm-Gg: AY/fxX5YMyB2vMtMm30Qzc/2ACoVYFBt4SzWm82EWJfxz9BEB901xBxgr0aR9iEByvL
	WhAMtfeqzNG1pG66EBSPOZf1J9/C48Shjkf0nZH1e1pHUhG/3PyqxUJbQYuZduOtc+QugKT6d7n
	YH31Yd/+X6aE9QxL3CbIb2YqKQkYUOCZzqsZjxSPks7bZOL0nAyri0Q6uEj9Y6EVpexQB5bwnP1
	fzflFQ4OzqBtRmSlON6Ey/UtKNK1TPqN7VbghEE6AclUtXwcna+cc4x1Tt6vU09DBnQlcPjWWUZ
	HYY4IDFCr+DSrj9nbhz2LVSrOaZdhA==
X-Received: by 2002:a05:6402:210c:b0:64b:42a6:3946 with SMTP id
 4fb4d7f45d1cf-653ec10b2c1mr2391600a12.7.1768400066360; Wed, 14 Jan 2026
 06:14:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <8af369636c32b868f83669c49aea708ca3b894ac.camel@kernel.org>
 <CAOQ4uxgD+Sgbbg9K2U0SF9TyUOBb==Z6auShUWc4FfPaDCQ=rg@mail.gmail.com>
 <ec78bf021fa1f6243798945943541ba171e337e7.camel@kernel.org>
 <cb5d2da6-2090-4639-ad96-138342bba56d@oracle.com> <ce700ee20834631eceededc8cd15fc5d00fee28e.camel@kernel.org>
 <20260113-mondlicht-raven-82fc4eb70e9d@brauner> <aWZcoyQLvbJKUxDU@infradead.org>
 <ce418800f06aa61a7f47f0d19394988f87a3da07.camel@kernel.org>
 <aWc3mwBNs8LNFN4W@infradead.org> <CAOQ4uxhMjitW_DC9WK9eku51gE1Ft+ENhD=qq3uehwrHO=RByA@mail.gmail.com>
 <aWeUv2UUJ_NdgozS@infradead.org> <c40862cd65a059ad45fa88f5473722ea5c5f70a5.camel@kernel.org>
In-Reply-To: <c40862cd65a059ad45fa88f5473722ea5c5f70a5.camel@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 14 Jan 2026 15:14:13 +0100
X-Gm-Features: AZwV_QgcgdaBnds1gv_V4-TD2P8OEmx8uWYCKQoKmrAoITMmwNZxXsYhEeLI48A
Message-ID: <CAOQ4uxhDwR7dteLaqURX+9CooGM1hA7PL6KnVmSwX11ZdKxZTA@mail.gmail.com>
Subject: Re: [PATCH 00/24] vfs: require filesystems to explicitly opt-in to
 lease support
To: Jeff Layton <jlayton@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, Christian Brauner <brauner@kernel.org>, 
	Chuck Lever <chuck.lever@oracle.com>, Jan Kara <jack@suse.cz>, 
	Luis de Bethencourt <luisbg@kernel.org>, Salah Triki <salah.triki@gmail.com>, 
	Nicolas Pitre <nico@fluxnic.net>, Anders Larsen <al@alarsen.net>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>, 
	Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>, Yue Hu <zbestahu@gmail.com>, 
	Jeffle Xu <jefflexu@linux.alibaba.com>, Sandeep Dhavale <dhavale@google.com>, 
	Hongbo Li <lihongbo22@huawei.com>, Chunhai Guo <guochunhai@vivo.com>, Jan Kara <jack@suse.com>, 
	"Theodore Ts'o" <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>, 
	Jaegeuk Kim <jaegeuk@kernel.org>, OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, 
	David Woodhouse <dwmw2@infradead.org>, Richard Weinberger <richard@nod.at>, Dave Kleikamp <shaggy@kernel.org>, 
	Ryusuke Konishi <konishi.ryusuke@gmail.com>, Viacheslav Dubeyko <slava@dubeyko.com>, 
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, Mark Fasheh <mark@fasheh.com>, 
	Joel Becker <jlbec@evilplan.org>, Joseph Qi <joseph.qi@linux.alibaba.com>, 
	Mike Marshall <hubcap@omnibond.com>, Martin Brandenburg <martin@omnibond.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, Phillip Lougher <phillip@squashfs.org.uk>, 
	Carlos Maiolino <cem@kernel.org>, Hugh Dickins <hughd@google.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Namjae Jeon <linkinjeon@kernel.org>, Sungjong Seo <sj1557.seo@samsung.com>, 
	Yuezhang Mo <yuezhang.mo@sony.com>, Alexander Aring <alex.aring@gmail.com>, 
	Andreas Gruenbacher <agruenba@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Eric Van Hensbergen <ericvh@kernel.org>, 
	Latchesar Ionkov <lucho@ionkov.net>, Dominique Martinet <asmadeus@codewreck.org>, 
	Christian Schoenebeck <linux_oss@crudebyte.com>, Xiubo Li <xiubli@redhat.com>, 
	Ilya Dryomov <idryomov@gmail.com>, Trond Myklebust <trondmy@kernel.org>, 
	Anna Schumaker <anna@kernel.org>, Steve French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.org>, 
	Ronnie Sahlberg <ronniesahlberg@gmail.com>, Shyam Prasad N <sprasad@microsoft.com>, 
	Tom Talpey <tom@talpey.com>, Bharath SM <bharathsm@microsoft.com>, 
	Hans de Goede <hansg@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-mtd@lists.infradead.org, 
	jfs-discussion@lists.sourceforge.net, linux-nilfs@vger.kernel.org, 
	ntfs3@lists.linux.dev, ocfs2-devel@lists.linux.dev, devel@lists.orangefs.org, 
	linux-unionfs@vger.kernel.org, linux-xfs@vger.kernel.org, linux-mm@kvack.org, 
	gfs2@lists.linux.dev, linux-doc@vger.kernel.org, v9fs@lists.linux.dev, 
	ceph-devel@vger.kernel.org, linux-nfs@vger.kernel.org, 
	linux-cifs@vger.kernel.org, samba-technical@lists.samba.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 14, 2026 at 2:41=E2=80=AFPM Jeff Layton <jlayton@kernel.org> wr=
ote:
>
> On Wed, 2026-01-14 at 05:06 -0800, Christoph Hellwig wrote:
> > On Wed, Jan 14, 2026 at 10:34:04AM +0100, Amir Goldstein wrote:
> > > On Wed, Jan 14, 2026 at 7:28=E2=80=AFAM Christoph Hellwig <hch@infrad=
ead.org> wrote:
> > > >
> > > > On Tue, Jan 13, 2026 at 12:06:42PM -0500, Jeff Layton wrote:
> > > > > Fair point, but it's not that hard to conceive of a situation whe=
re
> > > > > someone inadvertantly exports cgroupfs or some similar filesystem=
:
> > > >
> > > > Sure.  But how is this worse than accidentally exporting private da=
ta
> > > > or any other misconfiguration?
> > > >
> > >
> > > My POV is that it is less about security (as your question implies), =
and
> > > more about correctness.
> >
> > I was just replying to Jeff.
> >
> > > The special thing about NFS export, as opposed to, say, ksmbd, is
> > > open by file handle, IOW, the export_operations.
> > >
> > > I perceive this as a very strange and undesired situation when NFS
> > > file handles do not behave as persistent file handles.
> >
> > That is not just very strange, but actually broken (discounting the
> > obscure volatile file handles features not implemented in Linux NFS
> > and NFSD).  And the export ops always worked under the assumption
> > that these file handles are indeed persistent.  If they're not we
> > do have a problem.
> >
> > >
> > > cgroupfs, pidfs, nsfs, all gained open_by_handle_at() capability for
> > > a known reason, which was NOT NFS export.
> > >
> > > If the author of open_by_handle_at() support (i.e. brauner) does not
> > > wish to imply that those fs should be exported to NFS, why object?
> >
> > Because "want to export" is a stupid category.
> >
> > OTOH "NFS exporting doesn't actually properly work because someone
> > overloaded export_ops with different semantics" is a valid category.
> >
>
> cgroupfs definitely doesn't behave as expected when exported via NFS.
> The files aren't readable, at least. I'd also be surprised if the
> filehandles were stable across a reboot, which is sort of necessary for
> proper operation. I didn't test writing, but who knows whether that
> might also just not work, crash the box, or do something else entirely.
>
> I imagine this is the case for all sorts of filesystems like /proc,
> /sys, etc. Those aren't exportable today (to my knowledge), but we're
> growing export_operations across a wide range of fs's these days.
>
> I'd prefer that we require someone to take the deliberate step to say
> "yes, allow nfsd to access this type of filesystem".
>
> > > We could have the opt-in/out of NFS export fixes per EXPORT_OP_
> > > flags and we could even think of allowing admin to make this decision
> > > per vfsmount (e.g. for cgroupfs).
> > >
> > > In any case, I fail to see how objecting to the possibility of NFS ex=
port
> > > opt-out serves anyone.
> >
> > You're still think of it the wrong way.  If we do have file systems
> > that break the original exportfs semantics we need to fix that, and
> > something like a "stable handles" flag will work well for that.  But
> > a totally arbitrary "is exportable" flag is total nonsense.
>

Very well then.
How about EXPORT_OP_PERSISTENT_HANDLES?

This terminology is from the NFS protocol spec and it is also used
to describe the same trait in SMB protocol.

> The problem there is that we very much do want to keep tmpfs
> exportable, but it doesn't have stable handles (per-se).

Thinking out loud -
It would be misguided to declare tmpfs as
EXPORT_OP_PERSISTENT_HANDLES
and regressing exports of tmpfs will surely not go unnoticed.

How about adding an exportfs option "persistent_handles",
use it as default IFF neither options fsid=3D, uuid=3D are used,
so that at least when exporting tmpfs, exportfs -v will show
"no_persistent_handles" explicitly?

Thanks,
Amir.

