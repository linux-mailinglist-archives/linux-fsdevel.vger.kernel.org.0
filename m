Return-Path: <linux-fsdevel+bounces-51027-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9B6CAD1EF1
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 15:33:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 758843AC933
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 13:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE7AF258CE9;
	Mon,  9 Jun 2025 13:33:31 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from tempest.elijah.cs.cmu.edu (tempest.elijah.cs.cmu.edu [128.2.210.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99FA742A9D;
	Mon,  9 Jun 2025 13:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=128.2.210.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749476011; cv=none; b=bK4Id2cSYUZs23fuXnsGdXYKDE1McXh/uwKLwwWGndHp2h6gvBLYpxBzx0ZeRq6zfNeoOMIr56Lb7z3MN62xuYhky/dX/9REfYnJgEMV2OsqUkEDjgXD9SExXpTu64fVA5XzH7ChvhGWuBZfvhk+e/owA4G/2mfQSsQjwF4GqFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749476011; c=relaxed/simple;
	bh=BbPzqmbbExmpBiIAsyBAIeuMs2KABkXDp/5r3WH4E6I=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=J1wo366l8c/nvm+NM8pkE6YvHE/4vf7/Rpx4TliqEM/8nvtTBRvyqZ6sVqMeTNIxjcymh+fOfSjyQwFEVz0Lg1TIi5MzihwS3/n8pccGoL+tfionkr3qlCSt9hLGu6deyY/GQpfm5yBiXB9+XDdIqN64k9bmDXQk06rWo+urQAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.cmu.edu; spf=pass smtp.mailfrom=cs.cmu.edu; arc=none smtp.client-ip=128.2.210.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.cmu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.cmu.edu
Received: from [127.0.0.1] (pool-74-98-214-249.pitbpa.fios.verizon.net [74.98.214.249])
	by tempest.elijah.cs.cmu.edu (Postfix) with ESMTPSA id 82A341800244;
	Mon,  9 Jun 2025 09:33:26 -0400 (EDT)
Date: Mon, 09 Jun 2025 09:33:26 -0400
From: Jan Harkes <jaharkes@cs.cmu.edu>
To: Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.cz>
CC: NeilBrown <neil@brown.name>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Chuck Lever <chuck.lever@oracle.com>,
 Amir Goldstein <amir73il@gmail.com>, David Howells <dhowells@redhat.com>,
 Tyler Hicks <code@tyhicks.com>, Miklos Szeredi <miklos@szeredi.hu>,
 Carlos Maiolino <cem@kernel.org>, linux-fsdevel@vger.kernel.org,
 coda@cs.cmu.edu, linux-nfs@vger.kernel.org, netfs@lists.linux.dev,
 ecryptfs@vger.kernel.org, linux-unionfs@vger.kernel.org,
 linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] coda: use iterate_dir() in coda_readdir()
In-Reply-To: <33c80551bb7e0ac26ef00fe14aa9550df68ed120.camel@kernel.org>
References: <20250608230952.20539-1-neil@brown.name> <20250608230952.20539-4-neil@brown.name> <8f2bf3aed5d7bd005adcdeaa51c02c7aa9ca14ba.camel@kernel.org> <6zirxkpkdrtpcoewopaaotmw4jpjvjmqq4tijudvrpeo4227pi@hyljuie6ngem> <A70CCC08-E8BE-4655-9158-81754F4F6B35@cs.cmu.edu> <33c80551bb7e0ac26ef00fe14aa9550df68ed120.camel@kernel.org>
Message-ID: <9E062191-C1D7-4E46-8BC8-B5DAE2270CAE@cs.cmu.edu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On June 9, 2025 9:21:20 AM EDT, Jeff Layton <jlayton@kernel=2Eorg> wrote:
>On Mon, 2025-06-09 at 09:12 -0400, Jan Harkes wrote:
>> There are definitely still users of Coda at CMU, I don't track who else=
 uses it, but it cannot be too many for sure=2E
>>=20
>> At this point it mostly keeps you honest about little locking details i=
n the vfs=2E There are some tricky details in how the inode mappings are ac=
cessed and such=2E I think that  is helpful for overlay and user filesystem=
s like fuse, overlayfs, etc=2E but Coda is quite small so it is easy to rea=
son about how it uses these features=2E
>>=20
>>=20
>
>The reason I ask is that it's one of the places that we often have to
>do odd fixups like this when making changes to core VFS APIs=2E It's also
>not seen any non-collateral changes since 2021=2E I'm just wondering
>whether it's worth it to keep coda in-tree for so few users=2E

I have no problem maintaining an external module=2E I already do that to b=
oth make development easier and to support building a custom module in case=
 some distro didn't ship with a prebuilt Coda kernel module=2E

>IIRC, it's also the only fs in the kernel that changes its
>inode->i_mapping pointer after inode instantiation=2E If not for coda, we
>could probably replace the i_mapping pointer with some macro wizardry
>and shrink struct inode by 8 bytes=2E

And that would be why an out-of-tree solution will not work in the long ru=
n=2E A small change like that to shave 8 bytes off the inode structure is a=
 fairly easy call to make when there are no in-tree filesystems that use it=
 anymore=2E

Ultimately it is up to you guys to decide if the extra burden on VFS maint=
enance is worth it=2E

Jan

>> On June 9, 2025 9:00:31 AM EDT, Jan Kara <jack@suse=2Ecz> wrote:
>> > On Mon 09-06-25 08:17:15, Jeff Layton wrote:
>> > > On Mon, 2025-06-09 at 09:09 +1000, NeilBrown wrote:
>> > > > The code in coda_readdir() is nearly identical to iterate_dir()=
=2E
>> > > > Differences are:
>> > > >  - iterate_dir() is killable
>> > > >  - iterate_dir() adds permission checking and accessing notificat=
ions
>> > > >=20
>> > > > I believe these are not harmful for coda so it is best to use
>> > > > iterate_dir() directly=2E  This will allow locking changes withou=
t
>> > > > touching the code in coda=2E
>> > > >=20
>> > > > Signed-off-by: NeilBrown <neil@brown=2Ename>
>> > > > ---
>> > > >  fs/coda/dir=2Ec | 12 ++----------
>> > > >  1 file changed, 2 insertions(+), 10 deletions(-)
>> > > >=20
>> > > > diff --git a/fs/coda/dir=2Ec b/fs/coda/dir=2Ec
>> > > > index ab69d8f0cec2=2E=2Eca9990017265 100644
>> > > > --- a/fs/coda/dir=2Ec
>> > > > +++ b/fs/coda/dir=2Ec
>> > > > @@ -429,17 +429,9 @@ static int coda_readdir(struct file *coda_fi=
le, struct dir_context *ctx)
>> > > >  	cfi =3D coda_ftoc(coda_file);
>> > > >  	host_file =3D cfi->cfi_container;
>> > > > =20
>> > > > -	if (host_file->f_op->iterate_shared) {
>> > > > -		struct inode *host_inode =3D file_inode(host_file);
>> > > > -		ret =3D -ENOENT;
>> > > > -		if (!IS_DEADDIR(host_inode)) {
>> > > > -			inode_lock_shared(host_inode);
>> > > > -			ret =3D host_file->f_op->iterate_shared(host_file, ctx);
>> > > > -			file_accessed(host_file);
>> > > > -			inode_unlock_shared(host_inode);
>> > > > -		}
>> > > > +	ret =3D iterate_dir(host_file, ctx);
>> > > > +	if (ret !=3D -ENOTDIR)
>> > > >  		return ret;
>> > > > -	}
>> > > >  	/* Venus: we must read Venus dirents from a file */
>> > > >  	return coda_venus_readdir(coda_file, ctx);
>> > > >  }
>> > >=20
>> > >=20
>> > > Is it already time for my annual ask of "Who the heck is using coda
>> > > these days?" Anyway, this patch looks fine to me=2E
>> > >=20
>> > > Reviewed-by: Jeff Layton <jlayton@kernel=2Eorg>
>> >=20
>> > Send a patch proposing deprecating it and we might learn that :) Sear=
ching
>> > the web seems to suggest it is indeed pretty close to dead=2E
>> >=20
>> > 								Honza
>

