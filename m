Return-Path: <linux-fsdevel+bounces-74012-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 799D9D28AA2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 22:12:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8061930ECA56
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 21:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A888328273;
	Thu, 15 Jan 2026 21:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="fhYmLBp4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com [209.85.210.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4C42DF12F
	for <linux-fsdevel@vger.kernel.org>; Thu, 15 Jan 2026 21:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768511379; cv=none; b=XVhj4X4Q5SEY2+q0G4vSpYsWiOo2AhEF8anXD4dElsO9X3rBT2vPXDEntYhdKLQOZCbC0bC+O/tcWNFQbhoSJFKQEyKBeqkbMBfFDERMVMF2KsQAEU7nalbKa3ThsLsxHJvyMgGtGe9lb48T3tjjKNA4upFNiOUnJRjKxx0qIGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768511379; c=relaxed/simple;
	bh=2I13eLA86WUVjq+GNtA+9P+G4lanu5BXx/iTIVZI9ZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C+Blu3lIJO+wPtNdDYIwCqOzY/YcMoOMrlYTmnVaT3+cgAqSNkEqD72yPXLznBnGA0D+hsjWj/ZDvXi1CAKc75BlWuTsqkTmU3krawwLifyHjmCE16yzy9o+8zA+4foueiJVz+PLn7BUc1gZ8fjXm+pGJv2WP/koF2//pqk2DNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=fhYmLBp4; arc=none smtp.client-ip=209.85.210.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pf1-f194.google.com with SMTP id d2e1a72fcca58-81c72659e6bso1201083b3a.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Jan 2026 13:09:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1768511376; x=1769116176; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9qNaS/mHG0CWRhBXyo18LMgHGDC++HAHg2FdEUDjFsI=;
        b=fhYmLBp4Lhuuz02IOeinJZR0ga5TLKrwI3PKOxR7ePUZTl7L+SCF8W3dfdSwrhuiLI
         iyhgwuHL5daCJCNOefS4RfR1O5gQj6Uleno7czM8aTYqySE2nV5djWiYidFIqujC6rgm
         uOoZAoyBApGJIycPGYWKXg3LA0DTtaCQbXx/3xOzwJY3GX2i/YNsb4R2DpF0P9lnNldC
         cMq1/pw7FbyprENozmX4vuyVsr9t+YbQVbdJjVMvrQ7TVgT6rooXjgX7eo9cB90XaZas
         SKKnBRNrASQUJ7pJoTsqZtOsCX0YsK9JqAnkIvZiTqPnHa5luIgWtKPxHW26w09o//7w
         yZvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768511376; x=1769116176;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9qNaS/mHG0CWRhBXyo18LMgHGDC++HAHg2FdEUDjFsI=;
        b=Y7/QG3MDvnxVXVMfQUdOhQu2Y+Hd/MzHL0mnUZbI3om6EXyKXhHaAP+LjCkF1umvVY
         RXLwxZZflrjCzgxaSx3SEmrwqxIkQ+t2ygnIT++CV1dv8AmUhTo3P++4j6zuarot4Zge
         H95PiUxe9phBmVCoH5zes4IXZakSS+yTmIKr+oNpAPNkmu+J9np8TX9Dj+UWY7jp2wb6
         //ksLHjy8AcPAMLujjQs7oHkYBA2HLgBRtyf4roUjG43yzArwksRNhl52NfPnEjY7sEB
         +9rialo6CnCZ5n7B9f1KY8AOmFwYl4I7MH6osIuWs/UbvMQ5MHkYXX/hQndrpHQEPwY2
         LRIQ==
X-Forwarded-Encrypted: i=1; AJvYcCX7o8xBTvRS95s83HypTKgCEmzRvEUtHN6JuS67oAmmjppbRRbVhHRZG24Abf2e8nnTGhfeX9mBCfJsv57Q@vger.kernel.org
X-Gm-Message-State: AOJu0YxxSz812uOFozJiwz0MK/kRN5uU6IzOR8EIGHYQDn6nXWd7Pd2a
	M0GDGSpwTGErFzMNY4UrLVoV76Ig52CPMmGs544n1vZi7iKSNNSbyVaTHXi4e7ylbxM=
X-Gm-Gg: AY/fxX6Ve+77AAEB6WwTl68Fsw86cDkR0HDxA+C8e4FJbCZV0II5+Wyyr63ONjEumSq
	/1sIZc4AMoczKFJ53OB1xEtNf1cp5xGSCWeDGb7UyP2dy7FNVOTdx/1vsF+k2d2lbIMyUDa8hmk
	qnCmO/wvaJ9feW16QUoEYqOklKKw2hoauIYoGjUFS4T2fRI+W34EGvzjg8dPi00sx5jNJxLg1ar
	3yCVXQIogKz0b8q7Kr1fFD0Ez9lPiDQgIOd5J+3lmNSETUcH/iBKd/VnK8/NZVCnRjHRaNAOzMT
	HU4J1du7SuLocnuZhGvEBaUoz+Eb+oGhCDHArZJe1uZ/WLnC8GNMBgH+enhEExdb5zp2ucDMJez
	tiwIF7F5h7n66R5mj09PgZPy5cu3dtmor9CKiWpUVnYV+7UXGKOusHt9RMgU1/myMoUA+JvbC2+
	mHuWAuRv0yGpMV41xNus+0C27aWyhj0luoisi5SmbUwGk41zGPimylNJDDarE0mPs=
X-Received: by 2002:a05:6a00:1c99:b0:81e:5d52:53b9 with SMTP id d2e1a72fcca58-81f9f7f61bamr693898b3a.8.1768511376156;
        Thu, 15 Jan 2026 13:09:36 -0800 (PST)
Received: from dread.disaster.area (pa49-180-164-75.pa.nsw.optusnet.com.au. [49.180.164.75])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-81fa10bda5csm259171b3a.19.2026.01.15.13.09.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 13:09:35 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.99.1)
	(envelope-from <david@fromorbit.com>)
	id 1vgUai-00000003vHn-2AU2;
	Fri, 16 Jan 2026 08:09:16 +1100
Date: Fri, 16 Jan 2026 08:09:16 +1100
From: Dave Chinner <david@fromorbit.com>
To: Chuck Lever <cel@kernel.org>
Cc: Amir Goldstein <amir73il@gmail.com>, Jeff Layton <jlayton@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	Hugh Dickins <hughd@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Theodore Tso <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>, Jan Kara <jack@suse.com>,
	Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>,
	Yue Hu <zbestahu@gmail.com>, Jeffle Xu <jefflexu@linux.alibaba.com>,
	Sandeep Dhavale <dhavale@google.com>,
	Hongbo Li <lihongbo22@huawei.com>,
	Chunhai Guo <guochunhai@vivo.com>, Carlos Maiolino <cem@kernel.org>,
	Ilya Dryomov <idryomov@gmail.com>,
	Alex Markuze <amarkuze@redhat.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>, Chris Mason <clm@fb.com>,
	David Sterba <dsterba@suse.com>,
	Luis de Bethencourt <luisbg@kernel.org>,
	Salah Triki <salah.triki@gmail.com>,
	Phillip Lougher <phillip@squashfs.org.uk>,
	Steve French <sfrench@samba.org>,
	Paulo Alcantara <pc@manguebit.org>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Bharath SM <bharathsm@microsoft.com>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Mike Marshall <hubcap@omnibond.com>,
	Martin Brandenburg <martin@omnibond.com>,
	Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>,
	Joseph Qi <joseph.qi@linux.alibaba.com>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Ryusuke Konishi <konishi.ryusuke@gmail.com>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>, Dave Kleikamp <shaggy@kernel.org>,
	David Woodhouse <dwmw2@infradead.org>,
	Richard Weinberger <richard@nod.at>, Jan Kara <jack@suse.cz>,
	Andreas Gruenbacher <agruenba@redhat.com>,
	OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Christoph Hellwig <hch@infradead.org>, linux-nfs@vger.kernel.org,
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
Subject: Re: [PATCH 00/29] fs: require filesystems to explicitly opt-in to
 nfsd export support
Message-ID: <aWlXfBImnC_jhTw4@dread.disaster.area>
References: <20260115-exportfs-nfsd-v1-0-8e80160e3c0c@kernel.org>
 <CAOQ4uxjOJMwv_hRVTn3tJHDLMQHbeaCGsdLupiZYcwm7M2rm3g@mail.gmail.com>
 <d486fdb8-686c-4426-9fac-49b7dbc28765@app.fastmail.com>
 <CAOQ4uxhnoTC6KBmRVx2xhvTXYg1hRkCJWrq2eoBQGHKC3sv3Hw@mail.gmail.com>
 <4d9967cc-a454-46cf-909b-b8ab2d18358d@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4d9967cc-a454-46cf-909b-b8ab2d18358d@kernel.org>

On Thu, Jan 15, 2026 at 02:37:09PM -0500, Chuck Lever wrote:
> On 1/15/26 2:14 PM, Amir Goldstein wrote:
> > On Thu, Jan 15, 2026 at 7:32 PM Chuck Lever <cel@kernel.org> wrote:
> >>
> >>
> >>
> >> On Thu, Jan 15, 2026, at 1:17 PM, Amir Goldstein wrote:
> >>> On Thu, Jan 15, 2026 at 6:48 PM Jeff Layton <jlayton@kernel.org> wrote:
> >>>>
> >>>> In recent years, a number of filesystems that can't present stable
> >>>> filehandles have grown struct export_operations. They've mostly done
> >>>> this for local use-cases (enabling open_by_handle_at() and the like).
> >>>> Unfortunately, having export_operations is generally sufficient to make
> >>>> a filesystem be considered exportable via nfsd, but that requires that
> >>>> the server present stable filehandles.
> >>>
> >>> Where does the term "stable file handles" come from? and what does it mean?
> >>> Why not "persistent handles", which is described in NFS and SMB specs?
> >>>
> >>> Not to mention that EXPORT_OP_PERSISTENT_HANDLES was Acked
> >>> by both Christoph and Christian:
> >>>
> >>> https://lore.kernel.org/linux-fsdevel/20260115-rundgang-leihgabe-12018e93c00c@brauner/
> >>>
> >>> Am I missing anything?
> >>
> >> PERSISTENT generally implies that the file handle is saved on
> >> persistent storage. This is not true of tmpfs.
> > 
> > That's one way of interpreting "persistent".
> > Another way is "continuing to exist or occur over a prolonged period."
> > which works well for tmpfs that is mounted for a long time.
> 
> I think we can be a lot more precise about the guarantee: The file
> handle does not change for the life of the inode it represents. It

<pedantic mode engaged>

File handles most definitely change over the life of a /physical/
inode. Unlinking a file does not require ending the life of the
physical object that provides the persistent data store for the
file.

e.g. XFS dynamically allocates physical inodes might in a life cycle
that looks somewhat life this:

	allocate physical inode
	insert record into allocated inode index
	mark inode as free

	while (don't need to free physical inode) {
		...
		allocate inode for a new file
		update persistent inode metadata to generate new filehandle
		mark inode in use
		...
		unlink file
		mark inode free
	}

	remove inode from allocated inode index
	free physical inode

i.e. a free inode is still an -allocated, indexed inode- in the
filesystem, and until we physically remove it from the filesystem
the inode life cycle has not ended.

IOWs, the physical (persistent) inode lifetime can span the lifetime
of -many- files. However, the filesystem guarantees that the handle
generated for that inode is different for each file it represents
over the whole inode life time.

Hence I think that file handle stability/persistence needs to be
defined in terms of -file lifetimes-, not the lifetimes of the
filesystem objects implement the file's persistent data store.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

