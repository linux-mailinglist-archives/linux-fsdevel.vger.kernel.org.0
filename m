Return-Path: <linux-fsdevel+bounces-51514-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A714AAD799C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 20:07:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7082418899AA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 18:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1B472C3256;
	Thu, 12 Jun 2025 18:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="go6H3AgI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 514511F03EF;
	Thu, 12 Jun 2025 18:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749751646; cv=none; b=UdcqXo9fujxvwLTlQjHKexrpdVVzLsgVi2SGOj3cjOQJO6hH+nVKdwkjo1eaLLLO60h1nVrNQHjc0UAPWKShV90t1K9yMsseCVXcXA3Vimxn5Q3KmI58RB3/UmKhNHsdMjNwLAvl4duS6cFNZeuQeXs+o9S9FjIL/wtVU/LDxNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749751646; c=relaxed/simple;
	bh=eM6QfeQzql7UqLEFhuaq/EAtkl9E7c4VSfI0W7L0U9g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mnL8k8NmLX/FJ8PLIo1Bsn1nwYMxqtQfI20CvhEUCnlEkKIkdmarKUdLwsF5hX1XHMmR6h0J2YQooOPpl6ngjPkYwczfU9NJpljT9kGSWa7nl0zU3kz4w06dBiVuyliIBPBMjGp899t8fs3qxCLSQtOuCMDbU7SlmAxW92/PUTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=go6H3AgI; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:References:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=NLI18LvjQ4CANycpGsFkt9dk8MUgMfENzEtgG+JvMSs=; b=go6H3AgIQSZpVtLYfNp5kAezy4
	OZugAub43DyyFbjmDyBMzxDhFQa7Fcn/sHHUBMfhg0AAQqtOUoiGFpDQPJ7NPi0RCrUxlsQvgTC68
	0oamLAFQc3U4In8kNMQ1jXgtNcgZrCB9xg1uOK9qtNP+bnG083QkgJcNwI9+iNc2AtnL/ZUKMaxzS
	M+nKg0BpYvbBNnK1LNpJ82PXXwDjyEQjobQwocOfm/QmsxG2oAlVOH8Xz81hN5cdy/KeeF7Lqw1kH
	ecszQjPH5B3dd+ev2mXlOKjbY6v8TrJ7jN1Z985Z2UvUC0g6blJceF1Dc+vGtZ69lCKxjjpDR2td2
	sqzZqScQ==;
Received: from bl23-10-177.dsl.telepac.pt ([144.64.10.177] helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1uPmKX-002jLz-BM; Thu, 12 Jun 2025 20:07:13 +0200
From: Luis Henriques <luis@igalia.com>
To: Jan Kara <jack@suse.cz>
Cc: Mateusz Guzik <mjguzik@gmail.com>,  Alexander Viro
 <viro@zeniv.linux.org.uk>,  Christian Brauner <brauner@kernel.org>,
  linux-fsdevel@vger.kernel.org,  linux-kernel@vger.kernel.org,
  kernel-dev@igalia.com
Subject: Re: [PATCH] fs: drop assert in file_seek_cur_needs_f_lock
In-Reply-To: <3gvuqzzyhiz5is42h4rbvqx43q4axmo7ehubomijvbr5k25xgb@pwjvfuttjegk>
	(Jan Kara's message of "Thu, 12 Jun 2025 18:23:01 +0200")
References: <87tt4u4p4h.fsf@igalia.com>
	<20250612094101.6003-1-luis@igalia.com>
	<ybfhcrgmiwlsa4elkag6fuibfnniep76n43xzopxpe645vy4zr@fth26jirachp>
	<3gvuqzzyhiz5is42h4rbvqx43q4axmo7ehubomijvbr5k25xgb@pwjvfuttjegk>
Date: Thu, 12 Jun 2025 19:07:12 +0100
Message-ID: <87v7p06dgv.fsf@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 12 2025, Jan Kara wrote:

> On Thu 12-06-25 15:55:40, Mateusz Guzik wrote:
>> On Thu, Jun 12, 2025 at 10:41:01AM +0100, Luis Henriques wrote:
>> > The assert in function file_seek_cur_needs_f_lock() can be triggered v=
ery
>> > easily because, as Jan Kara suggested, the file reference may get
>> > incremented after checking it with fdget_pos().
>> >=20
>> > Fixes: da06e3c51794 ("fs: don't needlessly acquire f_lock")
>> > Signed-off-by: Luis Henriques <luis@igalia.com>
>> > ---
>> > Hi Christian,
>> >=20
>> > It wasn't clear whether you'd be queueing this fix yourself.  Since I =
don't
>> > see it on vfs.git, I decided to explicitly send the patch so that it d=
oesn't
>> > slip through the cracks.
>> >=20
>> > Cheers,
>> > --=20
>> > Luis
>> >=20
>> >  fs/file.c | 2 --
>> >  1 file changed, 2 deletions(-)
>> >=20
>> > diff --git a/fs/file.c b/fs/file.c
>> > index 3a3146664cf3..075f07bdc977 100644
>> > --- a/fs/file.c
>> > +++ b/fs/file.c
>> > @@ -1198,8 +1198,6 @@ bool file_seek_cur_needs_f_lock(struct file *fil=
e)
>> >  	if (!(file->f_mode & FMODE_ATOMIC_POS) && !file->f_op->iterate_share=
d)
>> >  		return false;
>> >=20=20
>> > -	VFS_WARN_ON_ONCE((file_count(file) > 1) &&
>> > -			 !mutex_is_locked(&file->f_pos_lock));
>> >  	return true;
>> >  }
>>=20
>> fdget_pos() can only legally skip locking if it determines to be in
>> position where nobody else can operate on the same file obj, meaning
>> file_count(file) =3D=3D 1 and it can't go up. Otherwise the lock is take=
n.
>>=20
>> Or to put it differently, fdget_pos() NOT taking the lock and new refs
>> showing up later is a bug.
>
> I mostly agree and as I've checked again, this indeed seems to be the case
> as fdget() will increment f_ref if file table is shared with another thre=
ad
> and thus file_needs_f_pos_lock() returns true whenever there are more
> threads sharing the file table or if the struct file is dupped to another
> fd. That being said I find the assertion in file_seek_cur_needs_f_lock()
> misplaced - it just doesn't make sense in that place to me.
>=20=20
>> I don't believe anything of the sort is happening here.
>>=20
>> Instead, overlayfs is playing games and *NOT* going through fdget_pos():
>>=20
>> 	ovl_inode_lock(inode);
>>         realfile =3D ovl_real_file(file);
>> 	[..]
>>         ret =3D vfs_llseek(realfile, offset, whence);
>>=20
>> Given the custom inode locking around the call, it may be any other
>> locking is unnecessary and the code happens to be correct despite the
>> splat.
>
> Right and good spotting. That's indeed more likely explanation than mine.
> Actually custom locking around llseek isn't all that uncommon (mostly for
> historical reasons AFAIK but that's another story).
>
>> I think the safest way out with some future-proofing is to in fact *add*
>> the locking in ovl_llseek() to shut up the assert -- personally I find
>> it uneasy there is some underlying file obj flying around.
>
> Well, if you grep for vfs_llseek(), you'll see there are much more calls =
to
> it in the kernel than overlayfs. These callers outside of fs/read_write.c
> are responsible for their locking. So I don't think keeping the assert in
> file_seek_cur_needs_f_lock() makes any sense. If anything I'd be open to
> putting it in fdput_pos() or something like that.

Thank you Mateusz and Honza for looking into this.  Overlayfs was indeed
my initial suspect, but I had two reasons for thinking that the assert was
the problem: 1) that code was there for quite some time and 2) nobody else
was reporting this issue.

>> Even if ultimately the assert has to go, the proposed commit message
>> does not justify it.
>
> I guess the commit message could be improved. Something like:
>
> The assert in function file_seek_cur_needs_f_lock() can be triggered very
> easily because there are many users of vfs_llseek() (such as overlayfs)
> that do their custom locking around llseek instead of relying on
> fdget_pos(). Just drop the overzealous assertion.

Thanks, makes more sense.

Christian, do you prefer me to resend the patch or is it easier for you to
just amend the commit?  (Though, to be fair, the authorship could also be
changed as I mostly reported the issue and tested!)

Cheers,
--=20
Lu=C3=ADs

