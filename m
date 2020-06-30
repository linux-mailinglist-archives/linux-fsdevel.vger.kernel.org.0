Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4608210018
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Jul 2020 00:34:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbgF3Wej (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Jun 2020 18:34:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:49706 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725763AbgF3Wej (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Jun 2020 18:34:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3A0D9ADCC;
        Tue, 30 Jun 2020 22:34:37 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     yangerkun <yangerkun@huawei.com>, sfrench@samba.org,
        jlayton@kernel.org, neilb@suse.com
Date:   Wed, 01 Jul 2020 08:34:26 +1000
Cc:     linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] cifs: remove the retry in cifs_poxis_lock_set
In-Reply-To: <62b291ab-291c-339f-e8e8-ba7b0c4f6670@huawei.com>
References: <20200624071053.993784-1-yangerkun@huawei.com> <62b291ab-291c-339f-e8e8-ba7b0c4f6670@huawei.com>
Message-ID: <878sg42nf1.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 30 2020, yangerkun wrote:

> Ping...
>
> =E5=9C=A8 2020/6/24 15:10, yangerkun =E5=86=99=E9=81=93:
>> The caller of cifs_posix_lock_set will do retry(like
>> fcntl_setlk64->do_lock_file_wait) if we will wait for any file_lock.
>> So the retry in cifs_poxis_lock_set seems duplicated, remove it to
>> make a cleanup.

If cifs_posix_try_lock() returns FILE_LOCK_DEFERRED (which it might
after your patch), then cifs_setlk() will check the return value:

		if (!rc || rc < 0)
			return rc;

These tests will fail (as FILE_LOCK_DEFERRED is 1) and so it will
continue on as though the lock was granted.

So I think your patch is wrong.
However I think your goal is correct.  cifs shouldn't be waiting.
No other filesystem waits when it gets FILE_LOCK_DEFERRED.

So maybe try to fix up your patch.

Thanks,
NeilBrown


>>=20
>> Signed-off-by: yangerkun <yangerkun@huawei.com>
>> ---
>>   fs/cifs/file.c | 8 --------
>>   1 file changed, 8 deletions(-)
>>=20
>> diff --git a/fs/cifs/file.c b/fs/cifs/file.c
>> index 9b0f8f33f832..2c9c24b1805d 100644
>> --- a/fs/cifs/file.c
>> +++ b/fs/cifs/file.c
>> @@ -1162,7 +1162,6 @@ cifs_posix_lock_set(struct file *file, struct file=
_lock *flock)
>>   	if ((flock->fl_flags & FL_POSIX) =3D=3D 0)
>>   		return rc;
>>=20=20=20
>> -try_again:
>>   	cifs_down_write(&cinode->lock_sem);
>>   	if (!cinode->can_cache_brlcks) {
>>   		up_write(&cinode->lock_sem);
>> @@ -1171,13 +1170,6 @@ cifs_posix_lock_set(struct file *file, struct fil=
e_lock *flock)
>>=20=20=20
>>   	rc =3D posix_lock_file(file, flock, NULL);
>>   	up_write(&cinode->lock_sem);
>> -	if (rc =3D=3D FILE_LOCK_DEFERRED) {
>> -		rc =3D wait_event_interruptible(flock->fl_wait,
>> -					list_empty(&flock->fl_blocked_member));
>> -		if (!rc)
>> -			goto try_again;
>> -		locks_delete_block(flock);
>> -	}
>>   	return rc;
>>   }
>>=20=20=20
>>=20

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAl77vfQACgkQOeye3VZi
gbmW6BAAinormSTgvP6Zq9Oi/lClg/VGdOBbdsnmyqFgfkx35BKsa0lpdohWdpNB
e9u5TXSgohn1xEvZkYtCa5/bEx/LF4cJYoRnu1zQXS/CHAk22FsynyrbY1o3rAIm
i/9FtbtF02HCSI5j85rqFmDR+6iju9oOZUPMAcb+w3IsxpNXd+HSa8zCXSLUi9aJ
s1orhwmadyFulnDc/hkoD9YS9scZ00W6KKUDi2efXvbmRznH+z4mDVDjevQ9GRJG
7eUBX/GlThAUpFlp1yI8/Pya+5gVpLox3Ttp484FT9M+V/e5LhPB62T+5L5ZbH5y
NIpWWJAFmq9q/OWV9b6UiWyeMQ9S8/ZI5Ll4D6XtGjkYB3MdkOxXUOOg3qxheHQa
pQEmJNOEATiF7zLOC7eSxpKl2aajZAQf1XVkNyJLCePppk655T4enJhKjyR6BoYQ
xNnyUm7SKYx85Lkb19GqQBabJjzkzTdSUui+1VjwqlUYBYsaDOAm8IPu76J+r5qn
FZ0Y6INOhbInI+GH6nOWMAPIK6yZG8/nnJNaFKNR95EnTnmZzWY4zg9pZ4IifQ1J
qrn5SrRfd98TUIN8Xquua8FVCUqUSVUXyJRSA91IJbmrdOw5wnajlOJJ9q8Dl9dk
BgfmAl/EWz40uNaMFkO7Z/BZqVxWDC0rHYEAl8zAi7Oqm0Ci7Xk=
=wuds
-----END PGP SIGNATURE-----
--=-=-=--
