Return-Path: <linux-fsdevel+bounces-74000-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2986FD2824F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 20:37:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D0BF430783C5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 19:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 892F231AABA;
	Thu, 15 Jan 2026 19:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HFbrkaxb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A79930CDBB;
	Thu, 15 Jan 2026 19:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768505845; cv=none; b=V5Z1B/cOR/ngH8bd/qRNKnEABA8o4m8DCZeA7xXl+ZrE4EN+TipNabIht3SrxzGiniKey/XSjnxAtIorROpF8VWWQqOGd34RqApLZ3Qc+UCz97ptyLoD/KvhV32NUUvri39rw6DyBb8Ttp4OHp5JRCi5Lf07DgbrGxg4sdMVd3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768505845; c=relaxed/simple;
	bh=WJfdSxntdjCGN+SFF94mp89xagtZVsc8ko5YpfyHmzo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GFGVMnLnY98jGeyIjjTBd4I/PT4VcgO/lRiWtBSttK9LUv5IRIlUPgRMGEU21Pr7KfNNV6X6MpsAC6FZPy87pq0xhjudZzoO2aVIPJY4NB7kTQEl9aY1L4p9SZ7JinnVhsTGGqs3806LrpWqCmmTC0AsXsypaLsCG1FUhj+A6UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HFbrkaxb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DB8DC116D0;
	Thu, 15 Jan 2026 19:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768505845;
	bh=WJfdSxntdjCGN+SFF94mp89xagtZVsc8ko5YpfyHmzo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=HFbrkaxb1G2AMG3MzNBQW/L4EalwCCXCDDxxDQ0j51u/B6PgVvK4NDRP+gGsVfnpe
	 VyaIgHktK2ed+mNcElWfMOvW8ETWuYtZ5BFV7xemUUxHpfR8cVtiKroue7/9G/qCGd
	 rt85fYelVNLihiQeGcg1jxPrf/3yQwBY4s+8zZk5LgZv0Ho8j42Klxvmo6vU2q3pOQ
	 ev3GcW+Npw86laMA3/1Ho9Pk9tnCRdwq68XKqMY+ib2uyFDvs9SuOLSNploZHBt1DR
	 d0vpBTEHYbunJ8ienXua5qZh3TfRauncM885fsO/Gz1dFmAlUhHctfiqlwv2dV0p89
	 QAbmFxgjt0yHA==
Message-ID: <4d9967cc-a454-46cf-909b-b8ab2d18358d@kernel.org>
Date: Thu, 15 Jan 2026 14:37:09 -0500
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/29] fs: require filesystems to explicitly opt-in to
 nfsd export support
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jeff Layton <jlayton@kernel.org>, Christian Brauner <brauner@kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>,
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
 Tom Talpey <tom@talpey.com>, Hugh Dickins <hughd@google.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Andrew Morton <akpm@linux-foundation.org>, Theodore Tso <tytso@mit.edu>,
 Andreas Dilger <adilger.kernel@dilger.ca>, Jan Kara <jack@suse.com>,
 Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>,
 Yue Hu <zbestahu@gmail.com>, Jeffle Xu <jefflexu@linux.alibaba.com>,
 Sandeep Dhavale <dhavale@google.com>, Hongbo Li <lihongbo22@huawei.com>,
 Chunhai Guo <guochunhai@vivo.com>, Carlos Maiolino <cem@kernel.org>,
 Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>,
 Viacheslav Dubeyko <slava@dubeyko.com>, Chris Mason <clm@fb.com>,
 David Sterba <dsterba@suse.com>, Luis de Bethencourt <luisbg@kernel.org>,
 Salah Triki <salah.triki@gmail.com>,
 Phillip Lougher <phillip@squashfs.org.uk>, Steve French <sfrench@samba.org>,
 Paulo Alcantara <pc@manguebit.org>,
 Ronnie Sahlberg <ronniesahlberg@gmail.com>,
 Shyam Prasad N <sprasad@microsoft.com>, Bharath SM
 <bharathsm@microsoft.com>, Miklos Szeredi <miklos@szeredi.hu>,
 Mike Marshall <hubcap@omnibond.com>, Martin Brandenburg
 <martin@omnibond.com>, Mark Fasheh <mark@fasheh.com>,
 Joel Becker <jlbec@evilplan.org>, Joseph Qi <joseph.qi@linux.alibaba.com>,
 Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
 Ryusuke Konishi <konishi.ryusuke@gmail.com>,
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
 Dave Kleikamp <shaggy@kernel.org>, David Woodhouse <dwmw2@infradead.org>,
 Richard Weinberger <richard@nod.at>, Jan Kara <jack@suse.cz>,
 Andreas Gruenbacher <agruenba@redhat.com>,
 OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
 Jaegeuk Kim <jaegeuk@kernel.org>, Christoph Hellwig <hch@infradead.org>,
 linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-ext4@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 linux-xfs@vger.kernel.org, ceph-devel@vger.kernel.org,
 linux-btrfs@vger.kernel.org, linux-cifs@vger.kernel.org,
 samba-technical@lists.samba.org, linux-unionfs@vger.kernel.org,
 devel@lists.orangefs.org, ocfs2-devel@lists.linux.dev,
 ntfs3@lists.linux.dev, linux-nilfs@vger.kernel.org,
 jfs-discussion@lists.sourceforge.net, linux-mtd@lists.infradead.org,
 gfs2@lists.linux.dev, linux-f2fs-devel@lists.sourceforge.net
References: <20260115-exportfs-nfsd-v1-0-8e80160e3c0c@kernel.org>
 <CAOQ4uxjOJMwv_hRVTn3tJHDLMQHbeaCGsdLupiZYcwm7M2rm3g@mail.gmail.com>
 <d486fdb8-686c-4426-9fac-49b7dbc28765@app.fastmail.com>
 <CAOQ4uxhnoTC6KBmRVx2xhvTXYg1hRkCJWrq2eoBQGHKC3sv3Hw@mail.gmail.com>
From: Chuck Lever <cel@kernel.org>
Content-Language: en-US
Organization: kernel.org
In-Reply-To: <CAOQ4uxhnoTC6KBmRVx2xhvTXYg1hRkCJWrq2eoBQGHKC3sv3Hw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 1/15/26 2:14 PM, Amir Goldstein wrote:
> On Thu, Jan 15, 2026 at 7:32 PM Chuck Lever <cel@kernel.org> wrote:
>>
>>
>>
>> On Thu, Jan 15, 2026, at 1:17 PM, Amir Goldstein wrote:
>>> On Thu, Jan 15, 2026 at 6:48 PM Jeff Layton <jlayton@kernel.org> wrote:
>>>>
>>>> In recent years, a number of filesystems that can't present stable
>>>> filehandles have grown struct export_operations. They've mostly done
>>>> this for local use-cases (enabling open_by_handle_at() and the like).
>>>> Unfortunately, having export_operations is generally sufficient to make
>>>> a filesystem be considered exportable via nfsd, but that requires that
>>>> the server present stable filehandles.
>>>
>>> Where does the term "stable file handles" come from? and what does it mean?
>>> Why not "persistent handles", which is described in NFS and SMB specs?
>>>
>>> Not to mention that EXPORT_OP_PERSISTENT_HANDLES was Acked
>>> by both Christoph and Christian:
>>>
>>> https://lore.kernel.org/linux-fsdevel/20260115-rundgang-leihgabe-12018e93c00c@brauner/
>>>
>>> Am I missing anything?
>>
>> PERSISTENT generally implies that the file handle is saved on
>> persistent storage. This is not true of tmpfs.
> 
> That's one way of interpreting "persistent".
> Another way is "continuing to exist or occur over a prolonged period."
> which works well for tmpfs that is mounted for a long time.

I think we can be a lot more precise about the guarantee: The file
handle does not change for the life of the inode it represents. It
has nothing to do with whether the file system is mounted.


> But I am confused, because I went looking for where Jeff said that
> you suggested stable file handles and this is what I found that you wrote:
> 
> "tmpfs filehandles align quite well with the traditional definition
>  of persistent filehandles. tmpfs filehandles live as long as tmpfs files do,
>  and that is all that is required to be considered "persistent".

I changed my mind about the name, and I let Jeff know that privately
when he asked me to look at these patches this morning.


>> The use of "stable" means that the file handle is stable for
>> the life of the file. This /is/ true of tmpfs.
> 
> I can live with STABLE_HANDLES I don't mind as much,
> I understand what it means, but the definition above is invented,
> whereas the term persistent handles is well known and well defined.

Another reason not to adopt the same terminology as NFS is that
someone might come along and implement NFSv4's VOLATILE file
handles in Linux, and then say "OK, /now/ can we export cgroupfs?"
And then Linux will be stuck with overloaded terminology and we'll
still want to say "NO, NFS doesn't support cgroupfs".

Just a random thought.


-- 
Chuck Lever

