Return-Path: <linux-fsdevel+bounces-71573-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C157ECC84D5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Dec 2025 15:55:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3EFB7302D5BD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Dec 2025 14:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E061234D3A1;
	Wed, 17 Dec 2025 14:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="SW2r7NCu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C7D9347FEA;
	Wed, 17 Dec 2025 14:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765982763; cv=none; b=rFG1q+CqM9MrplNaVZr8QEoo0NwGz/ZceX16tRxIE5lwyJa3I/fn4nhhNLJBOg+PI/aEBBsXncvMT8FgfzzSp7z8flSN4XTTorlBEGqI9ix7LQJXV3XMrDb1nodyFE16uwLfzm/fcTXEjh2EZBK+Zn5rZlJr73eLS5Lg/4FvHhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765982763; c=relaxed/simple;
	bh=wt/hsWFcBJ0OA99dDhA1jIe7b8YKuDpPXEwCE1z1wVQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uVs4s90ERJ+nUqPxYTmvShKEsRbHOMe1hvbrZGRsgH6pnwGg/jd9MJLB1b94VEY5g/KYxGBY4IeGUXO/nZfM/6lWwJ1X+GmGfQ7keFyJ/l3RA+Fvnn8jE0Bl2lMswp8gizNobHXHk2MSFOdE87jSlNS1/9m05nEE8Pl5kiozAWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=SW2r7NCu; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:References:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=cKB02N6wo25pFDZZr89nSYrDDnP322Ww/uWYscB4N8U=; b=SW2r7NCu4myrO5sPvJ7AYI4FOz
	3SMeDYXeYUcqybhq3q7gJcftwK+zkoiFKtdWUslQ0kT2+qCTmokXdRkPCZhiyHi5x+LtIBvMXbH+6
	vcNNuGIustcLs5/Ar4RJs9mBGKUfCWBjEa4mlPGXIQdD6fUQ9rV2UHcMakiQhhBMsZL15/hSEhk6J
	PZdQ/kFmM2jWMSKZ8kD7CMEKiHfPp3gkheRyTVo3SxqBSrvrgR9iNcuEPwQXKdGpqzu8sspNxSrZz
	tAdWihCrOms0Et6Z+QJu/uXFLxbLgdxl2K00NG3qG1Cx+zChKIz0mvfC8HDSFDcm+C6S2SAcb2LvE
	pwFDcl2A==;
Received: from bl17-145-117.dsl.telepac.pt ([188.82.145.117] helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1vVsmh-00Dt3w-9T; Wed, 17 Dec 2025 15:45:47 +0100
From: Luis Henriques <luis@igalia.com>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Bernd Schubert <bschubert@ddn.com>,  Miklos Szeredi <miklos@szeredi.hu>,
  "Darrick J. Wong" <djwong@kernel.org>,  Kevin Chen <kchen@ddn.com>,
  Horst Birthelmer <hbirthelmer@ddn.com>,  "linux-fsdevel@vger.kernel.org"
 <linux-fsdevel@vger.kernel.org>,  "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>,  Matt Harvey <mharvey@jumptrading.com>,
  "kernel-dev@igalia.com" <kernel-dev@igalia.com>
Subject: Re: [RFC PATCH v2 4/6] fuse: implementation of the
 FUSE_LOOKUP_HANDLE operation
In-Reply-To: <CAOQ4uxj8QO1pJC1nOh9g3UV34b1x-_EQrT382aS-_gUvhJfLig@mail.gmail.com>
	(Amir Goldstein's message of "Wed, 17 Dec 2025 11:18:03 +0100")
References: <20251212181254.59365-1-luis@igalia.com>
	<20251212181254.59365-5-luis@igalia.com>
	<76f21528-9b14-4277-8f4c-f30036884e75@ddn.com>
	<87ike6d4vx.fsf@wotan.olymp>
	<CAOQ4uxj8QO1pJC1nOh9g3UV34b1x-_EQrT382aS-_gUvhJfLig@mail.gmail.com>
Date: Wed, 17 Dec 2025 14:45:41 +0000
Message-ID: <87wm2lp3oq.fsf@wotan.olymp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 17 2025, Amir Goldstein wrote:

> On Tue, Dec 16, 2025 at 12:48=E2=80=AFPM Luis Henriques <luis@igalia.com>=
 wrote:
>>
>> On Mon, Dec 15 2025, Bernd Schubert wrote:
>>
>> > On 12/12/25 19:12, Luis Henriques wrote:
>> >> The implementation of LOOKUP_HANDLE modifies the LOOKUP operation to =
include
>> >> an extra inarg: the file handle for the parent directory (if it is
>> >> available).  Also, because fuse_entry_out now has a extra variable si=
ze
>> >> struct (the actual handle), it also sets the out_argvar flag to true.
>> >>
>> >> Most of the other modifications in this patch are a fallout from these
>> >> changes: because fuse_entry_out has been modified to include a variab=
le size
>> >> struct, every operation that receives such a parameter have to take t=
his
>> >> into account:
>> >>
>> >>    CREATE, LINK, LOOKUP, MKDIR, MKNOD, READDIRPLUS, SYMLINK, TMPFILE
>> >>
>> >> Signed-off-by: Luis Henriques <luis@igalia.com>
>> >> ---
>> >>   fs/fuse/dev.c             | 16 +++++++
>> >>   fs/fuse/dir.c             | 87 ++++++++++++++++++++++++++++++------=
---
>> >>   fs/fuse/fuse_i.h          | 34 +++++++++++++--
>> >>   fs/fuse/inode.c           | 69 +++++++++++++++++++++++++++----
>> >>   fs/fuse/readdir.c         | 10 ++---
>> >>   include/uapi/linux/fuse.h |  8 ++++
>> >>   6 files changed, 189 insertions(+), 35 deletions(-)
>> >>
>> >> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
>> >> index 629e8a043079..fc6acf45ae27 100644
>> >> --- a/fs/fuse/dev.c
>> >> +++ b/fs/fuse/dev.c
>> >> @@ -606,6 +606,22 @@ static void fuse_adjust_compat(struct fuse_conn =
*fc, struct fuse_args *args)
>> >>      if (fc->minor < 4 && args->opcode =3D=3D FUSE_STATFS)
>> >>              args->out_args[0].size =3D FUSE_COMPAT_STATFS_SIZE;
>> >>
>> >> +    if (fc->minor < 45) {
>> >
>> > Could we use fc->lookup_handle here? Numbers are hard with backports
>>
>> To be honest, I'm not sure this code is correct.  I just followed the
>> pattern.  I'll need to dedicate some more time looking into this,
>> specially because the READDIRPLUS op handling is still TBD.
>>
>> <snip>
>>
>> >> @@ -505,6 +535,30 @@ struct inode *fuse_iget(struct super_block *sb, =
u64 nodeid,
>> >>      if (!inode)
>> >>              return NULL;
>> >>
>> >> +    fi =3D get_fuse_inode(inode);
>> >> +    if (fc->lookup_handle) {
>> >> +            if ((fh =3D=3D NULL) && (nodeid !=3D FUSE_ROOT_ID)) {
>> >> +                    pr_err("NULL file handle for nodeid %llu\n", nod=
eid);
>> >> +                    iput(inode);
>> >> +                    return NULL;
>> >
>> > Hmm, so there are conditions like "if (fi && fi->fh) {" in lookup and I
>> > was thinking "nice, fuse-server can decide to skip the fh for some
>> > inodes like FUSE_ROOT_ID. But now it gets forbidden here. In combinati=
on
>> > with the other comment in fuse_inode_handle_alloc(), could be allocate
>> > here to the needed size and allow fuse-server to not send the handle
>> > for some files?
>>
>> I'm not sure the code is consistent with this regard, but here I'm doing
>> exactly that: allowing the fh to be NULL only for FUSE_ROOT_ID.  Or did I
>> misunderstood your comment?
>>
>
> root inode is a special case.
> The NFS server also does not encode the file handle for export root as
> far as a I know
> it just sends the special file handle type FILEID_ROOT to describe the
> root inode
> without any blob unique, so FUSE can do the same.

OK, that makes sense.

> There is not much point in "looking up" the root inode neither by nodeid
> nor by handle. unless is for making the code more generic.
>
> I am not sure if FUSE server restart is supposed to revalidate the
> root inode by file handle. That's kind of an administrative question about
> the feature. My feeling is that it is not needed.

Thanks, Amir.  Looks like there's a lot in these v2 review comments that
I'll need to go through.  I'll try to put everything together and see what
I can cook for v3.

Cheers,
--=20
Lu=C3=ADs

