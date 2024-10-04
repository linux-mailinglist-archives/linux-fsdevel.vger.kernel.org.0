Return-Path: <linux-fsdevel+bounces-31020-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C152990FCE
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 22:09:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF754283D63
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 20:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 681D71DED4F;
	Fri,  4 Oct 2024 19:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=krisman.be header.i=@krisman.be header.b="YIou8kT7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF4101DE3D5;
	Fri,  4 Oct 2024 19:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728070443; cv=none; b=NXgj7SpEsCb+lghlBBQKWAGTJ26izTIuRePDMvsmx7t2eCrWloiN03hKFtgUshWXUtZXSL0obThmx7qvoWYqKqoGWjeDV68gzu2N7+yDWZrirsiLgtB5YSNxkEynwkKRIB52mwTgZjg2KlWPeQr3LhRzs4DpN3YdjecmV4hrf7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728070443; c=relaxed/simple;
	bh=rvdP38n8wk9U7GqawxaK9Ga5gTiRGV9WWXUsTJy1+fA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CNuDO6XjknsKfGcRAAM4pOezjBM552mYElQUPPxYMTZCDUxB9h/AlzRfSkQb9IyvV/llsozc2PoCUzKOWsRNbarnN6WL6CbQkhl9se4wNTPrbStik1VQH92lE/aYgtXYZnh/Q+fS/PbiC8KrNn3XIUiq3gBsjsAIKRZYQeRmF/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=krisman.be; spf=pass smtp.mailfrom=krisman.be; dkim=pass (2048-bit key) header.d=krisman.be header.i=@krisman.be header.b=YIou8kT7; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=krisman.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=krisman.be
Received: by mail.gandi.net (Postfix) with ESMTPSA id 12420FF803;
	Fri,  4 Oct 2024 19:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=krisman.be; s=gm1;
	t=1728070439;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eqgMY+d2SYC/fKjAR/lG04fq4NcjyLPJ10Z85yTqpdg=;
	b=YIou8kT7/wKpmE/IQKf05D0ueTkE7Frr4aKXOe30la5lQnHWFZFTmmyIktxIus76Hq7asC
	RHBxWfBLlJN6l7FW7fzCuakGyoJlRY1gGJJdWF3VK8xs9zENeK4dgnKQRJ0/yItle/1TXv
	M1UPhsprxJYdxOUTxe3BjMg0ELXhs2jVfahRmyme/QtPkeQ6BOsyOICOcl5RVfL1SRI2tD
	XPt8Fz80eAFUk+tnu6AkBpRx+700BURY4zw3zPacrldmfRw1hRP3UTaAMZl+++uCXfIrjB
	mPxjwhUBou9sDX/Ek9+BmDHMaxNnD/uIk+oAG4F9mnN92z9eUog5Mr5bIrg9NA==
From: Gabriel Krisman Bertazi <gabriel@krisman.be>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>,  Jan Stancek <jstancek@redhat.com>,  Christian
 Brauner <brauner@kernel.org>,  Ted Tso <tytso@mit.edu>,
  linux-fsdevel@vger.kernel.org,  linux-ext4@vger.kernel.org,
  ltp@lists.linux.it,  Gabriel Krisman Bertazi <gabriel@krisman.be>
Subject: Re: [LTP] [PATCH] ext4: don't set SB_RDONLY after filesystem errors
In-Reply-To: <CAOQ4uxjXE7Tyz39wLUcuSTijy37vgUjYxvGL21E32cxStAgQpQ@mail.gmail.com>
	(Amir Goldstein's message of "Fri, 4 Oct 2024 14:32:07 +0200")
References: <20240805201241.27286-1-jack@suse.cz> <Zvp6L+oFnfASaoHl@t14s>
	<20240930113434.hhkro4bofhvapwm7@quack3>
	<CAOQ4uxjXE7Tyz39wLUcuSTijy37vgUjYxvGL21E32cxStAgQpQ@mail.gmail.com>
Date: Fri, 04 Oct 2024 15:33:56 -0400
Message-ID: <877canu0gr.fsf@mailhost.krisman.be>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: gabriel@krisman.be

Amir Goldstein <amir73il@gmail.com> writes:

> On Mon, Sep 30, 2024 at 1:34=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>>
>> On Mon 30-09-24 12:15:11, Jan Stancek wrote:
>> > On Mon, Aug 05, 2024 at 10:12:41PM +0200, Jan Kara wrote:
>> > > When the filesystem is mounted with errors=3Dremount-ro, we were set=
ting
>> > > SB_RDONLY flag to stop all filesystem modifications. We knew this mi=
sses
>> > > proper locking (sb->s_umount) and does not go through proper filesys=
tem
>> > > remount procedure but it has been the way this worked since early ex=
t2
>> > > days and it was good enough for catastrophic situation damage
>> > > mitigation. Recently, syzbot has found a way (see link) to trigger
>> > > warnings in filesystem freezing because the code got confused by
>> > > SB_RDONLY changing under its hands. Since these days we set
>> > > EXT4_FLAGS_SHUTDOWN on the superblock which is enough to stop all
>> > > filesystem modifications, modifying SB_RDONLY shouldn't be needed. So
>> > > stop doing that.
>> > >
>> > > Link: https://lore.kernel.org/all/000000000000b90a8e061e21d12f@googl=
e.com
>> > > Reported-by: Christian Brauner <brauner@kernel.org>
>> > > Signed-off-by: Jan Kara <jack@suse.cz>
>> > > ---
>> > > fs/ext4/super.c | 9 +++++----
>> > > 1 file changed, 5 insertions(+), 4 deletions(-)
>> > >
>> > > Note that this patch introduces fstests failure with generic/459 tes=
t because
>> > > it assumes that either freezing succeeds or 'ro' is among mount opti=
ons. But
>> > > we fail the freeze with EFSCORRUPTED. This needs fixing in the test =
but at this
>> > > point I'm not sure how exactly.
>> > >
>> > > diff --git a/fs/ext4/super.c b/fs/ext4/super.c
>> > > index e72145c4ae5a..93c016b186c0 100644
>> > > --- a/fs/ext4/super.c
>> > > +++ b/fs/ext4/super.c
>> > > @@ -735,11 +735,12 @@ static void ext4_handle_error(struct super_blo=
ck *sb, bool force_ro, int error,
>> > >
>> > >     ext4_msg(sb, KERN_CRIT, "Remounting filesystem read-only");
>> > >     /*
>> > > -    * Make sure updated value of ->s_mount_flags will be visible be=
fore
>> > > -    * ->s_flags update
>> > > +    * EXT4_FLAGS_SHUTDOWN was set which stops all filesystem
>> > > +    * modifications. We don't set SB_RDONLY because that requires
>> > > +    * sb->s_umount semaphore and setting it without proper remount
>> > > +    * procedure is confusing code such as freeze_super() leading to
>> > > +    * deadlocks and other problems.
>> > >      */
>> > > -   smp_wmb();
>> > > -   sb->s_flags |=3D SB_RDONLY;
>> >
>> > Hi,
>> >
>> > shouldn't the SB_RDONLY still be set (in __ext4_remount()) for the case
>> > when user triggers the abort with mount(.., "abort")? Because now we s=
eem
>> > to always hit the condition that returns EROFS to user-space.
>>
>> Thanks for report! I agree returning EROFS from the mount although
>> 'aborting' succeeded is confusing and is mostly an unintended side effect
>> that after aborting the fs further changes to mount state are forbidden =
but
>> the testcase additionally wants to remount the fs read-only.
>
> Regardless of what is right or wrong to do in ext4, I don't think that th=
e test
> really cares about remount read-only.
> I don't see anything in the test that requires it. Gabriel?
> If I remove MS_RDONLY from the test it works just fine.

If I recall correctly, no, there is no need for the MS_RDONLY.  We only
care about getting the event to test FS_ERROR.

Thanks,

>
> Any objection for LTP maintainers to apply this simple test fix?
>
> Thanks,
> Amir.
>
> --- a/testcases/kernel/syscalls/fanotify/fanotify22.c
> +++ b/testcases/kernel/syscalls/fanotify/fanotify22.c
> @@ -57,7 +57,7 @@ static struct fanotify_fid_t bad_link_fid;
>  static void trigger_fs_abort(void)
>  {
>         SAFE_MOUNT(tst_device->dev, MOUNT_PATH, tst_device->fs_type,
> -                  MS_REMOUNT|MS_RDONLY, "abort");
> +                  MS_REMOUNT, "abort");
>  }

--=20
Gabriel Krisman Bertazi

