Return-Path: <linux-fsdevel+bounces-72075-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D087DCDD0BF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Dec 2025 20:32:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A756A303C294
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Dec 2025 19:31:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7279C248F64;
	Wed, 24 Dec 2025 19:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IJyEgqQs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D794A196C7C
	for <linux-fsdevel@vger.kernel.org>; Wed, 24 Dec 2025 19:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766604707; cv=none; b=l8Nddq0WREeqdn14Qpo9s0zsHe790nRzVaX0/FJQH8OMrQ3NNRjN1QQqC+oBvWi+9I4wvDlUx5ZOYow3Yr9LnQEqvHO5ZV8uwjtbkHXbD4+ffE79+/fEIGElf9F65V7smUHgTY/zRZJ9Vm2wvp6lL4Q6wwYDNfEy0cm3FN112o4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766604707; c=relaxed/simple;
	bh=Wa+o9QfTuABiKy5mYr5Zu0zQqJLVXPCI7YA0XZAm0Lw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UqEsWK/jymiWlCl2S8/xQk4mgbH89pExS5EX1FU5/0mNAJZHgFVjmJQsR8rEcjlisSljsmW5MKWC1NS3LmH9XE8zZKnUBTGDczUEDyjkVIlwhETX7AihPRTC8UwKSXvdOiqYSUpLIJhh3ftkrL+pDI5gGrwsiOAMuEan0VAXHJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IJyEgqQs; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b8018eba13cso867957566b.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Dec 2025 11:31:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766604704; x=1767209504; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4qtoZmKrTSJ4SaC0g5HiORq0DaDrNEnjZKlUxSF9t24=;
        b=IJyEgqQsMZG8mTgqJ3dmRh75G44iJOmPEG+apx74BR3FU2LTr67I8MgMK057gPpJMn
         UF5eQ7eeMHNBtXJengpCScaOK+GzFF9jQq6riyJzAxPHqSP92D1KTEETEeSVPjL82Wmn
         OyWKEbV+R54pR1UHUXky3OUjofbQxIz3ZyvHRTOmeQgto3D8PCBZgGlvKNyrGIX988ev
         7MrpHh2RcQXOaxUrp2XZaBTsQ8Xve471R+raNzsp8URqSupwg80D/OT62eH+12iMbJMh
         VpAyGx8duy0qq8bk0jZ7Wyec6XksKhQ0A8Rm0ET7igyjaax3CRFhgH9UtKDKHpNjTMWp
         MxrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766604704; x=1767209504;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4qtoZmKrTSJ4SaC0g5HiORq0DaDrNEnjZKlUxSF9t24=;
        b=hsE7QSDvK+PtSK+cCih8jHoLzipDUaTaAmBxA3b807zDv6lqJ+FaXZdN4LC5wkF0Mi
         rH3o9iauuReDY0aUmkwA+oThgcvIh5d4J6t5BouqrLFLgVS+dDpT4mJ07lBTXBfJnPp8
         pB6LwIu99tGIOQvOV3QAfdfKywFKVFftCdbWlqYsJRk4BhtgvJkmqPOIiyzZUwXeM/Nu
         Fxfe1l285SsVwvGw73blt4+gu83avdIS0BBDZF/LGmJ95xCK01mFaBMcQE8xyXB5QF3r
         1AJJMVntQWJn8EHxLy+zUMQqxRBgbqQh6D2zknk7pQUh4ZkG9qqWXQB1lIrn8HQjnmsN
         ZeGQ==
X-Forwarded-Encrypted: i=1; AJvYcCWh16eAqx23ndMgsWjTdSuEShlgW2bt+YQrZVEf///2bQWJtj6QcpbT6HRCb5mmQZw8tl7rKhoUb+IFdWSN@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/MFWhzSn5kyv0klBhPAkuZcoYuvqp9z3bWpWpeOQfW7+D3sXe
	sFv+rlhn4q1RLZ2U8QI7VjdO8DXHoHS9pncoB4WObhkNXuqTtoryeIWG/7qntqO9dbX4FUbHtJW
	Y3oCQ36vYyl+Ep6ztYySCaY1E7fsRoQo=
X-Gm-Gg: AY/fxX7YfZ4Cwe3Dyi1yz8RqZS0sIhMHYHCRAPHmLnNX7yzXDVAbqhiQpZbgEMC+tI7
	BqOA4o/XpShtfI7mbRvI9D77JbfKf7QuUUloVVdrTUOfUS9KV46pU6wTpR9Zm7INq7oIzGexcxH
	JCUCC3bGXm0RPUH9Ez7x5l4qGUz9oKPwgswHkOeUBghanKyediK8AqYvgFfpwwGECLXQrqVyADn
	2n1PrXXXHyoOT+frG1ytJgWCPkxw3JNetAbR0LLI/dW1jdt6CuBdkKI50TmXzbdyU7XdBT2CHFT
	RvVTAB6d1EobrwMW7GL5ZNwehH25GQ==
X-Google-Smtp-Source: AGHT+IGclczWZWiIHmDkEJZ8h3iWTeWPwTWPm5Zia78TtLZOcZBF+SHnhduIOwK6oqqKXco4NusHyyR+EN27gDIdgyw=
X-Received: by 2002:a17:907:3fa2:b0:b72:5fac:d05a with SMTP id
 a640c23a62f3a-b80371790a3mr1945165966b.37.1766604703738; Wed, 24 Dec 2025
 11:31:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGzaKqnw+218VAa_L-XfzcrzivV31R-OdAO1xjAT1p_Boi94dg@mail.gmail.com>
 <CAOQ4uxi505WQB1E1dSYXcVGf9b5=HT-Cz55FMNw5RxnE=ww2yA@mail.gmail.com> <20251224070613.hfhhlnz4uq2nf47f@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
In-Reply-To: <20251224070613.hfhhlnz4uq2nf47f@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 24 Dec 2025 20:31:32 +0100
X-Gm-Features: AQt7F2rXEVDaDlLpoxnyy3ThljDgB7n1w178B6MFWgtvwBccJZaEj2k85YPFWHs
Message-ID: <CAOQ4uxgCVatK56o+q1JRY3K3dO69OEu6-WMA+LwuPFjcLtuP-w@mail.gmail.com>
Subject: Re: overlay unionmount failed when a long path is set
To: Zorro Lang <zlang@redhat.com>
Cc: Kun Wang <kunwan@redhat.com>, Christian Brauner <brauner@kernel.org>, linux-unionfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>, 
	Karel Zak <kzak@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 24, 2025 at 9:06=E2=80=AFAM Zorro Lang <zlang@redhat.com> wrote=
:
>
> On Tue, Dec 23, 2025 at 03:48:50PM +0100, Amir Goldstein wrote:
> > On Tue, Dec 23, 2025 at 3:25=E2=80=AFPM Kun Wang <kunwan@redhat.com> wr=
ote:
> > >
> > > Hi,
> > >
> > > This issue was found when I was doing overlayfs test on RHEL10 using =
unionmount-test-suite. Confirmed upstream kernel got the same problem after=
 doing the same test on the latest version with latest xfstests and unionmo=
unt-testsuite.
> > > [root@dell-per660-12-vm-01 xfstests]# uname -r
> > > 6.19.0-rc2+
> > >
> > > This issue only occurs when new mount API is on, some test cases in u=
nionmount test-suite start to fail like below after I set a long-name(longe=
r than 12 characters)  test dir:
> > >
> > > [root@dell-per660 xfstests]# ./check -overlay overlay/103
> > > FSTYP         -- overlay
> > > PLATFORM      -- Linux/x86_64 dell-per660-12-vm-01 6.19.0-rc2+ #1 SMP=
 PREEMPT_DYNAMIC Tue Dec 23 03:56:43 EST 2025
> > > MKFS_OPTIONS  -- /123456789abc
> > > MOUNT_OPTIONS -- -o context=3Dsystem_u:object_r:root_t:s0 /123456789a=
bc /123456789abc/ovl-mnt
> > >
> > > overlay/103        - output mismatch (see /root/xfstests/results//ove=
rlay/103.out.bad)
> > >     --- tests/overlay/103.out   2025-12-23 05:30:37.467387962 -0500
> > >     +++ /root/xfstests/results//overlay/103.out.bad     2025-12-23 05=
:44:53.414195538 -0500
> > >     @@ -1,2 +1,17 @@
> > >      QA output created by 103
> > >     +mount: /123456789abc/union/m: wrong fs type, bad option, bad sup=
erblock on overlay, missing codepage or helper program, or other error.
> > >     +       dmesg(1) may have more information after failed mount sys=
tem call.
> > >     +Traceback (most recent call last):
> > >     +  File "/root/unionmount-testsuite/./run", line 362, in <module>
> > >     +    func(ctx)
> > >     +  File "/root/unionmount-testsuite/tests/rename-file.py", line 9=
6, in subtest_7
> > >     ...
> > >     (Run 'diff -u /root/xfstests/tests/overlay/103.out /root/xfstests=
/results//overlay/103.out.bad'  to see the entire diff)
> > > Ran: overlay/103
> > > Failures: overlay/103
> > > Failed 1 of 1 tests
> > >
> > > So I looked into unionmount-testsuite, and picked out the cmdline rep=
roducer for this issue:
> > >
> > > //make a long name test dir and multiple lower later dir init//
> > > [root@dell-per660 xfstests]# mkdir -p /123456789abcdefgh/l{0..11}
> > > [root@dell-per660 xfstests]# mkdir /123456789abcdefgh/u /123456789abc=
defgh/m /123456789abcdefgh/w
> > > [root@dell-per660 xfstests]# ls /123456789abcdefgh/
> > > l0  l1  l10  l11   l2  l3  l4  l5  l6  l7  l8  l9  m  u  w
> > >
> > > //do overlay unionmount with below cmd will tigger the issue://
> > > [root@dell-per660 xfstests]# mount -t overlay overlay /123456789abcde=
fgh/m -orw,index=3Don,redirect_dir=3Don -olowerdir=3D/123456789abcdefgh/l1:=
/123456789abcdefgh/l2:/123456789abcdefgh/l3:/123456789abcdefgh/l4:/12345678=
9abcdefgh/l5:/123456789abcdefgh/l6:/123456789abcdefgh/l7:/123456789abcdefgh=
/l8:/123456789abcdefgh/l9:/123456789abcdefgh/l10:/123456789abcdefgh/l11:/12=
3456789abcdefgh/l0,upperdir=3D/123456789abcdefgh/u,workdir=3D/123456789abcd=
efgh/w
> > >
> > > mount: /123456789abcdefgh/m: wrong fs type, bad option, bad superbloc=
k on overlay, missing codepage or helper program, or other error.
> > >        dmesg(1) may have more information after failed mount system c=
all.

fsconfig(3, FSCONFIG_SET_STRING, "lowerdir",
"/123456789abcdefgh/l1:/123456789"..., 0) =3D -1 EINVAL (Invalid
argument)

the value of lowerdir mount opt is larger than the 256 limit for
FSCONFIG_SET_STRING

> > >
> > > //If I reduce the length of test dir name by 1 character, the mount w=
ill success://
> > > [root@dell-per660 xfstests]# cp /123456789abcdefgh /123456789abcdefg =
-r
> > > [root@dell-per660 xfstests]# mount -t overlay overlay /123456789abcde=
fg/m -orw,index=3Don,redirect_dir=3Don -olowerdir=3D/123456789abcdefg/l1:/1=
23456789abcdefg/l2:/123456789abcdefg/l3:/123456789abcdefg/l4:/123456789abcd=
efg/l5:/123456789abcdefg/l6:/123456789abcdefg/l7:/123456789abcdefg/l8:/1234=
56789abcdefg/l9:/123456789abcdefg/l10:/123456789abcdefg/l11:/123456789abcde=
fg/l0,upperdir=3D/123456789abcdefg/u,workdir=3D/123456789abcdefg/w
> > > [root@dell-per660 xfstests]# df -h | grep overlay
> > > overlay          57G   29G   28G  52% /123456789abcdefg/m
> > >
> > >  //If force using mount2 api, the mount will be good too://
> > > [root@dell-per660 xfstests]# export LIBMOUNT_FORCE_MOUNT2=3Dalways
> > > [root@dell-per660 xfstests]# mount -t overlay overlay /123456789abcde=
fgh/m -orw,index=3Don,redirect_dir=3Don -olowerdir=3D/123456789abcdefgh/l1:=
/123456789abcdefgh/l2:/123456789abcdefgh/l3:/123456789abcdefgh/l4:/12345678=
9abcdefgh/l5:/123456789abcdefgh/l6:/123456789abcdefgh/l7:/123456789abcdefgh=
/l8:/123456789abcdefgh/l9:/123456789abcdefgh/l10:/123456789abcdefgh/l11:/12=
3456789abcdefgh/l0,upperdir=3D/123456789abcdefgh/u,workdir=3D/123456789abcd=
efgh/w

mount("overlay", "/123456789abcdefgh/m", "overlay", 0,
"index=3Don,redirect_dir=3Don,lowerdi"...) =3D 0

> > > [root@dell-per660 xfstests]# df -h | grep overlay
> > > overlay          57G   29G   28G  52% /123456789abcdefg/m
> > > overlay          57G   29G   28G  52% /123456789abcdefgh/m
> > >
> > > So I don't think this unionmount cmd had reached the limit of param l=
ength, since it's working with the old mount API.
> > > Then maybe a kernel bug needs to be fixed..
> >
> > Hi Kun,
> >
> > Thanks for reporting this issue.
> >
> > We've had several issues with systems that are upgraded to linmount
> > that uses new mount API by default.

Indeed, when libmount is upgraded and the default is changed to new mount A=
PI
users with the long lowerdir string get a regression, because the limits on
the monolith mount options with old mount API are different than the limits
on the individual mount options with the new mount API.

> >
> > FYI, the lowerdir+ mount option was added exactly to avoid these sorts
> > of limits, but that will require changing applications (like unionmount
> > testsuite) to use this more scalable mount options or require libmount
> > to automatically parse and convert a long lowerdir=3D mount option to
> > smaller lowerdir+=3D mount options.

I am not sure it is reasonable to allow very long strings in the new mount =
API?
I am not sure if it makes sense for libmount to break the long
lowerdir=3Dxx:yy::zz
to multiple lowerdir+=3D,datadir+ fsconfig calls?

>
> Hi Amir,
>
> Thanks for your quick reply :) Maybe you remember we talked in an email
> "fstests overlay/103~109, 114~119 always fail". You said these tests alwa=
ys
> passed for you after your commit:
>
>   commit e6fc42f16c77ea40090b7168a7195ea12967b012
>   Author: Amir Goldstein <amir73il@gmail.com>
>   Date:   Tue Jun 3 12:07:40 2025 +0200
>
>     overlay: workaround libmount failure to remount,ro
>
> But they're still failed on my side. Our discussion was interrupted due t=
o I got
> other busy things. Recently I asked Kun to go to track this issue again, =
so this
> is a follow-up of that. We've excluded some conditions, now the only one =
difference
> between your test(passed) and mine (failed) might be the name (or name le=
ngth) of
> SCRATCH_MNT.

Now I remember :)

I don't know how to deal with this issue of automatic upgrade to new mount =
API.

The easiest thing for me to say is that unionmount can be fixed to use
lowerdir+ instead of lowerdir mount args and until we hear of another produ=
ction
workload which is affected we leave it at that.

I have to wonder why we haven't heard about this problem from
container runtimes?
Maybe because they already had a problem with reaching the limits of
old mount API
so they already made use of the new scalable lowerdir+ mount args?

Thanks,
Amir.

