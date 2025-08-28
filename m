Return-Path: <linux-fsdevel+bounces-59463-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E74BB39221
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Aug 2025 05:15:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4F5D7A9302
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Aug 2025 03:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FAC023F405;
	Thu, 28 Aug 2025 03:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=krisman.be header.i=@krisman.be header.b="Z9djkd3O"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 235A713957E;
	Thu, 28 Aug 2025 03:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756350929; cv=none; b=DL2y4zyn4qmriFXoprQZerHaY4EqqljVS9W4JHGNqa7gon+VXX/XbSf5Z5RjiZulgF4LVFpWPH2qH80FOhXgPnPwKNRRZpHu2LZm9yAGvY5KrDOpNNzM4HXK2MBQDKbXJAiH2cvdKkS+yZkNngc0wU1hLePGihWkMpihA1lfFT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756350929; c=relaxed/simple;
	bh=9O59D1dAi1hP0PrrgTKhy07sBFqjYfRdQoEdto4Yy4g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nVN7NnVgYY9bfHRxxildSvdfzjUoYF1PrsgoSc9xPmJh6GEKw+ZjYZU9esFmaP0+kOxMy60Tc2xAjmM87LUfI5RP0MFqJDzjAYpmO/mWzoKG8Xzx3BV4Ce3hJsBL8WbfNM41vxDgru1uketT4wMPnk6DCajoezcPDtBgCCBGFWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=krisman.be; spf=pass smtp.mailfrom=krisman.be; dkim=pass (2048-bit key) header.d=krisman.be header.i=@krisman.be header.b=Z9djkd3O; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=krisman.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=krisman.be
Received: by mail.gandi.net (Postfix) with ESMTPSA id B40DC1F47E;
	Thu, 28 Aug 2025 03:15:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=krisman.be; s=gm1;
	t=1756350918;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Je1c/W0HvzEfOCiCerF75aLF9hHDaYpsI3Yw0hvm6F0=;
	b=Z9djkd3O7cPBUCIBtvvIbVf9nRCa9sJLAupvFUbYAI1oCH0hBsr1d5sLBAZp5F3K59g6dW
	7nvxdGIu/5ETJ/HfhLAp/Nredfh0q15bp6+f9uI137iPawGu+5WJK3BDOsiyEAobVVNVhY
	6/pcH/46Ocs7ULRtYVIuzrNp+SdbkycUr8JQt7tL6XezUw5y8Hslab/q/8/mSRJz/TecTf
	XXBjoQjwSmfTlcoSFZtVYxX8rXr+XxYegXvUUXrgRtik0wnflSJOa6pqL1wflP/dM2TBEw
	e9HkcKuArIXpse8C5nKwgAulDEW+HnwUXb2dAQAtC5J97tYNF6qREhZguPiNbw==
From: Gabriel Krisman Bertazi <gabriel@krisman.be>
To: "NeilBrown" <neil@brown.name>
Cc: "Amir Goldstein" <amir73il@gmail.com>,  =?utf-8?Q?Andr=C3=A9?= Almeida
 <andrealmeid@igalia.com>,  "Miklos Szeredi" <miklos@szeredi.hu>,
  "Theodore Tso" <tytso@mit.edu>,  linux-unionfs@vger.kernel.org,
  linux-kernel@vger.kernel.org,  linux-fsdevel@vger.kernel.org,  "Alexander
 Viro" <viro@zeniv.linux.org.uk>,  "Christian Brauner"
 <brauner@kernel.org>,  "Jan Kara" <jack@suse.cz>,  kernel-dev@igalia.com
Subject: Re: [PATCH v6 9/9] ovl: Support mounting case-insensitive enabled
 layers
In-Reply-To: <175633908557.2234665.14959580663322237611@noble.neil.brown.name>
	(NeilBrown's message of "Thu, 28 Aug 2025 09:58:05 +1000")
References: <CAOQ4uxj551a7cvjpcYEyTLtsEXw9OxHtTc-VSm170J5pWtwoUQ@mail.gmail.com>
	<175633908557.2234665.14959580663322237611@noble.neil.brown.name>
Date: Wed, 27 Aug 2025 23:15:14 -0400
Message-ID: <87ldn416il.fsf@mailhost.krisman.be>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddujeelledvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtgfesthhqredttderjeenucfhrhhomhepifgrsghrihgvlhcumfhrihhsmhgrnhcuuegvrhhtrgiiihcuoehgrggsrhhivghlsehkrhhishhmrghnrdgsvgeqnecuggftrfgrthhtvghrnhepleetjeefvdeftdegudekgeffhedtffevudehvdfgtdehffeivddvhfelgfelhfdunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpghhithhhuhgsrdgtohhmnecukfhppeejtddrkedvrddukedvrdeikeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeejtddrkedvrddukedvrdeikedphhgvlhhopehlohgtrghlhhhoshhtpdhmrghilhhfrhhomhepghgrsghrihgvlheskhhrihhsmhgrnhdrsggvpdhnsggprhgtphhtthhopeduvddprhgtphhtthhopehnvghilhessghrohifnhdrnhgrmhgvpdhrtghpthhtoheprghmihhrjeefihhlsehgmhgrihhlrdgtohhmpdhrtghpthhtoheprghnughrvggrlhhmvghiugesihhgrghlihgrrdgtohhmpdhrtghpthhtohepmhhikhhlohhssehsiigvrhgvughirdhhuhdprhgtphhtthhopehthihtshhosehmihhtrdgvughup
 dhrtghpthhtoheplhhinhhugidquhhnihhonhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-GND-Sasl: gabriel@krisman.be

"NeilBrown" <neil@brown.name> writes:

> On Thu, 28 Aug 2025, Amir Goldstein wrote:
>> On Tue, Aug 26, 2025 at 9:01=E2=80=AFPM Andr=C3=A9 Almeida <andrealmeid@=
igalia.com> wrote:
>> >
>> >
>> >
>> > Em 26/08/2025 04:31, Amir Goldstein escreveu:
>> > > On Mon, Aug 25, 2025 at 3:31=E2=80=AFPM Andr=C3=A9 Almeida <andrealm=
eid@igalia.com> wrote:
>> > >>
>> > >> Hi Amir,
>> > >>
>> > >> Em 22/08/2025 16:17, Amir Goldstein escreveu:
>> > >>
>> > >> [...]
>> > >>
>> > >>     /*
>> > >>>>>> -        * Allow filesystems that are case-folding capable but =
deny composing
>> > >>>>>> -        * ovl stack from case-folded directories.
>> > >>>>>> +        * Exceptionally for layers with casefold, we accept th=
at they have
>> > >>>>>> +        * their own hash and compare operations
>> > >>>>>>             */
>> > >>>>>> -       if (sb_has_encoding(dentry->d_sb))
>> > >>>>>> -               return IS_CASEFOLDED(d_inode(dentry));
>> > >>>>>> +       if (ofs->casefold)
>> > >>>>>> +               return false;
>> > >>>>>
>> > >>>>> I think this is better as:
>> > >>>>>            if (sb_has_encoding(dentry->d_sb))
>> > >>>>>                    return false;
>> > >>>>>
>> > >>>
>> > >>> And this still fails the test "Casefold enabled" for me.
>> > >>>
>> > >>> Maybe you are confused because this does not look like
>> > >>> a test failure. It looks like this:
>> > >>>
>> > >>> generic/999 5s ...  [19:10:21][  150.667994] overlayfs: failed loo=
kup
>> > >>> in lower (ovl-lower/casefold, name=3D'subdir', err=3D-116): parent=
 wrong
>> > >>> casefold
>> > >>> [  150.669741] overlayfs: failed lookup in lower (ovl-lower/casefo=
ld,
>> > >>> name=3D'subdir', err=3D-116): parent wrong casefold
>> > >>> [  150.760644] overlayfs: failed lookup in lower (/ovl-lower,
>> > >>> name=3D'casefold', err=3D-66): child wrong casefold
>> > >>>    [19:10:24] [not run]
>> > >>> generic/999 -- overlayfs does not support casefold enabled layers
>> > >>> Ran: generic/999
>> > >>> Not run: generic/999
>> > >>> Passed all 1 tests
>> > >>>
>> > >>
>> > >> This is how the test output looks before my changes[1] to the test:
>> > >>
>> > >> $ ./run.sh
>> > >> FSTYP         -- ext4
>> > >> PLATFORM      -- Linux/x86_64 archlinux 6.17.0-rc1+ #1174 SMP
>> > >> PREEMPT_DYNAMIC Mon Aug 25 10:18:09 -03 2025
>> > >> MKFS_OPTIONS  -- -F /dev/vdc
>> > >> MOUNT_OPTIONS -- -o acl,user_xattr /dev/vdc /tmp/dir2
>> > >>
>> > >> generic/999 1s ... [not run] overlayfs does not support casefold en=
abled
>> > >> layers
>> > >> Ran: generic/999
>> > >> Not run: generic/999
>> > >> Passed all 1 tests
>> > >>
>> > >>
>> > >> And this is how it looks after my changes[1] to the test:
>> > >>
>> > >> $ ./run.sh
>> > >> FSTYP         -- ext4
>> > >> PLATFORM      -- Linux/x86_64 archlinux 6.17.0-rc1+ #1174 SMP
>> > >> PREEMPT_DYNAMIC Mon Aug 25 10:18:09 -03 2025
>> > >> MKFS_OPTIONS  -- -F /dev/vdc
>> > >> MOUNT_OPTIONS -- -o acl,user_xattr /dev/vdc /tmp/dir2
>> > >>
>> > >> generic/999        1s
>> > >> Ran: generic/999
>> > >> Passed all 1 tests
>> > >>
>> > >> So, as far as I can tell, the casefold enabled is not being skipped
>> > >> after the fix to the test.
>> > >
>> > > Is this how it looks with your v6 or after fixing the bug:
>> > > https://lore.kernel.org/linux-unionfs/68a8c4d7.050a0220.37038e.005c.=
GAE@google.com/
>> > >
>> > > Because for me this skipping started after fixing this bug
>> > > Maybe we fixed the bug incorrectly, but I did not see what the probl=
em
>> > > was from a quick look.
>> > >
>> > > Can you test with my branch:
>> > > https://github.com/amir73il/linux/commits/ovl_casefold/
>> > >
>> >
>> > Right, our branches have a different base, mine is older and based on
>> > the tag vfs/vfs-6.18.mount.
>> >
>> > I have now tested with your branch, and indeed the test fails with
>> > "overlayfs does not support casefold enabled". I did some debugging and
>> > the missing commit from my branch that is making this difference here =
is
>> > e8bd877fb76bb9f3 ("ovl: fix possible double unlink"). After reverting =
it
>> > on top of your branch, the test works. I'm not sure yet why this
>> > prevents the mount, but this is the call trace when the error happens:
>>=20
>> Wow, that is an interesting development race...
>>=20
>> >
>> > TID/PID 860/860 (mount/mount):
>> >
>> >                      entry_SYSCALL_64_after_hwframe+0x77
>> >                      do_syscall_64+0xa2
>> >                      x64_sys_call+0x1bc3
>> >                      __x64_sys_fsconfig+0x46c
>> >                      vfs_cmd_create+0x60
>> >                      vfs_get_tree+0x2e
>> >                      ovl_get_tree+0x19
>> >                      get_tree_nodev+0x70
>> >                      ovl_fill_super+0x53b
>> > !    0us [-EINVAL]  ovl_parent_lock
>> >
>> > And for the ovl_parent_lock() arguments, *parent=3D"work", *child=3D"#=
7". So
>> > right now I'm trying to figure out why the dentry for #7 is not hashed.
>> >
>>=20
>> The reason is this:
>>=20
>> static struct dentry *ext4_lookup(...
>> {
>> ...
>>         if (IS_ENABLED(CONFIG_UNICODE) && !inode && IS_CASEFOLDED(dir)) {
>>                 /* Eventually we want to call d_add_ci(dentry, NULL)
>>                  * for negative dentries in the encoding case as
>>                  * well.  For now, prevent the negative dentry
>>                  * from being cached.
>>                  */
>>                 return NULL;
>>         }
>>=20
>>         return d_splice_alias(inode, dentry);
>> }
>>=20
>> Neil,
>>=20
>> Apparently, the assumption that
>> ovl_lookup_temp() =3D> ovl_lookup_upper() =3D> lookup_one()
>> returns a hashed dentry is not always true.
>>=20
>> It may be always true for all the filesystems that are currently
>> supported as an overlayfs
>> upper layer fs (?), but it does not look like you can count on this
>> for the wider vfs effort
>> and we should try to come up with a solution for ovl_parent_lock()
>> that will allow enabling
>> casefolding on overlayfs layers.
>>=20
>> This patch seems to work. WDYT?
>>=20
>> Thanks,
>> Amir.
>>=20
>> commit 5dfcd10378038637648f3f422e3d5097eb6faa5f
>> Author: Amir Goldstein <amir73il@gmail.com>
>> Date:   Wed Aug 27 19:55:26 2025 +0200
>>=20
>>     ovl: adapt ovl_parent_lock() to casefolded directories
>>=20
>>     e8bd877fb76bb9f3 ("ovl: fix possible double unlink") added a sanity
>>     check of !d_unhashed(child) to try to verify that child dentry was n=
ot
>>     unlinked while parent dir was unlocked.
>>=20
>>     This "was not unlink" check has a false positive result in the case =
of
>>     casefolded parent dir, because in that case, ovl_create_temp() retur=
ns
>>     an unhashed dentry.
>>=20
>>     Change the "was not unlinked" check to use cant_mount(child).
>>     cant_mount(child) means that child was unlinked while we have been
>>     holding a reference to child, so it could not have become negative.
>>=20
>>     This fixes the error in ovl_parent_lock() in ovl_check_rename_whiteo=
ut()
>>     after ovl_create_temp() and allows mount of overlayfs with casefoldi=
ng
>>     enabled layers.
>>=20
>>     Reported-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>
>>     Link: https://lore.kernel.org/r/18704e8c-c734-43f3-bc7c-b8be345e1bf5=
@igalia.com/
>>     Signed-off-by: Amir Goldstein <amir73il@gmail.com>
>>=20
>> diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
>> index bec4a39d1b97c..bffbb59776720 100644
>> --- a/fs/overlayfs/util.c
>> +++ b/fs/overlayfs/util.c
>> @@ -1551,9 +1551,23 @@ void ovl_copyattr(struct inode *inode)
>>=20
>>  int ovl_parent_lock(struct dentry *parent, struct dentry *child)
>>  {
>> +       bool is_unlinked;
>> +
>>         inode_lock_nested(parent->d_inode, I_MUTEX_PARENT);
>> -       if (!child ||
>> -           (!d_unhashed(child) && child->d_parent =3D=3D parent))
>> +       if (!child)
>> +               return 0;
>> +
>> +       /*
>> +        * After re-acquiring parent dir lock, verify that child was not=
 moved
>> +        * to another parent and that it was not unlinked. cant_mount() =
means
>> +        * that child was unlinked while parent was unlocked. Since we a=
re
>> +        * holding a reference to child, it could not have become negati=
ve.
>> +        * d_unhashed(child) is not a strong enough indication for unlin=
ked,
>> +        * because with casefolded parent dir, ovl_create_temp() returns=
 an
>> +        * unhashed dentry.
>> +        */
>> +       is_unlinked =3D cant_mount(child) || WARN_ON_ONCE(d_is_negative(=
child));
>> +       if (!is_unlinked && child->d_parent =3D=3D parent)
>>                 return 0;
>>=20
>>         inode_unlock(parent->d_inode);
>>=20
>
> I don't feel comfortable with that.  Letting ovl_parent_lock() succeed
> on an unhashed dentry doesn't work for my longer term plans for locking.
> I would really rather we got that dentry hashed.
>
> What is happening is :
>   - lookup on non-existent name -> unhashed dentry
>   - vfs_create on that dentry - still unhashed
>   - rename of that unhashed dentry -> confusion in ovl_parent_lock()
>
> If this were being done from user-space there would be another lookup
> after the create and before the rename, and that would result in a
> hashed dentry.
>
> Could ovl_create_real() do a lookup for the name if the dentry isn't
> hashed?  That should result in a dentry that can safely be passed to
> ovl_parent_lock().

Might be a good time to mention I have a branch enabling negative
dentries in casefolded directories.  It didn't have any major issues last
time I posted, but it didn't get much interest.  It should be enough to
resolve the unhashed dentries after a lookup due to casefolding.

I'd need to revisit and retest, but it is a way out of it.

--=20
Gabriel Krisman Bertazi

