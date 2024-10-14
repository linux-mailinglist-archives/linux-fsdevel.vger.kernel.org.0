Return-Path: <linux-fsdevel+bounces-31862-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F3AC99C433
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Oct 2024 10:55:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31E5A1C22B13
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Oct 2024 08:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4BCB1487F4;
	Mon, 14 Oct 2024 08:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hKZ6nNtC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8880D1514F8;
	Mon, 14 Oct 2024 08:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728896121; cv=none; b=PHsKPkRcE+CejRlHjcK1+0blfUL7Pdc0gkmu3H/WCvwlaQG4ynbdEsE6rWaRRhfWr5omKEkUdos8snYUr8UR0eEsT/X5ds6JK1vsgwR17D+jKReqn3g9are8Yr1CXRdK/ZMyAfPrT8KduX45WCerpvmte2bHOU0FW5qA4IjWLH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728896121; c=relaxed/simple;
	bh=om/tRqBgsXcGLf3tAtcW/TXrx5PGQXAZXl8KC/74rwE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W3c0x2/83eEcwVdt4FmmMBsfq/zaIGsMW6GvM04qlWwjNR7s8SoInzewajbVEZ/ZsKbGMR2zAzTOi5KezmS6V9NWE1RJEIb4WroEeV/3pWtbQ4hhOYNL3dWmZoOk8N/78C9sCaQ/iyIAx4Q39UBM0JiQeflAyMR1DbZnYzzoMBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hKZ6nNtC; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7b10ed5e7cdso475375485a.3;
        Mon, 14 Oct 2024 01:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728896118; x=1729500918; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fHxU8H8UsoeCoiILOhNNQeR6j+46WsSuvgSbOOVdp38=;
        b=hKZ6nNtCBDyjwuN1OckYT4FOiwteV9hFrita/Km6aWtaYyNhU739D+qRwDIA1aScix
         1MlECmLQJG475arKaAnFeB0XhbIfPmurjkrzerT7xKsk9+PwpFsx5YeEd440LIauIL9G
         0yZgNfYNTTpe4DIYoxz5Lm2ZaLWWWz8RZ17ZRerUwnk1YowFEQ+ffRN9U8Hn+FYVOxpw
         edPu9Vp/Us0OTYU+30yj/HGGyuS6CFiqjm56oEZHphRPRWXiKz72Cisfv2jV4yrtnVo+
         pWTc9TOetemAOp94RSaTyBlLM5mMwl2WJdu/PIvGn7pBClGoEc58ScaFWy4lyseZtGUW
         pUUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728896118; x=1729500918;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fHxU8H8UsoeCoiILOhNNQeR6j+46WsSuvgSbOOVdp38=;
        b=CHcggAm5Jn4TtARu0c5KCXsz8jcwxhFjJY6r7L2u2O0vnanl0f7RGlGZQlxvH5+pww
         h7fUlBJY05yXaVEW2ppTtXydfDk7XVEDq93UiPKPmTu6DhHMquyxx+kdMBYeP2VjpM6P
         74TOBYLSGbqLLASbR1+dMh6a7dWsT9VczWUILphHwZSPMAVq1Ljvj5Yfu+Q8ZJJSyXn+
         fJWhIX6leDvNPUEIzDtREz3CFwB2TAcacu/Jky+/X+i8xfw8h7KzPQmQcFwXzC+zmAgj
         CTf3rhSL4BtS8KRUescn+g/xdVeg/eVaA5JbAA5Vs1tNUcNKJpC0MiOV5olB+Ys9VxT+
         mknQ==
X-Forwarded-Encrypted: i=1; AJvYcCUajwYfA34DLw5uenlu3mwgkzy2bWz8SMwP+OXNjZeSdqqD0QDhGWqA0fkX8mkPCzlZsGAxfyL1+iBJ@vger.kernel.org, AJvYcCVxuR7d4I/Y8NeU4IkIEhNYoZOQ7QiJuKtNaOZ0Yy4XvG11U07VAleQkOIu4P4XEIBXsy5t9hPXrP/7lm53@vger.kernel.org
X-Gm-Message-State: AOJu0Yzt74SzT75kHCjCYQlUjtVWCEZ74Hk8PspchBFXdZRKyNm1pdGn
	cQOdhZQc8Qt92twvGsg5SFTVVI97F2cHHFsGY+w3f7vGg4kchuA9LH3NPuVRi/h6VSt6ryBUiEW
	3I3tfX/OLINk4ofcQmqBJstATF/m1WGjONoByzA==
X-Google-Smtp-Source: AGHT+IHRL7c/m4WvThqTz0DcWBQ0zwMM/JAlU7jR361HxhdEn03+7ssDGFCw6W9itYCTS5nTHeP0WHIVBuyy2jWT2KM=
X-Received: by 2002:a05:620a:4481:b0:7a9:c0b8:9343 with SMTP id
 af79cd13be357-7b120fc3e06mr1297497885a.31.1728896118305; Mon, 14 Oct 2024
 01:55:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241011090023.655623-1-amir73il@gmail.com> <A1265158-06E7-40AA-8D61-985557CD9841@oracle.com>
 <CAOQ4uxgX+PqUeLuqD47S5PxeYqJ3OMs0bfmnUE+D7dcnpr-UNw@mail.gmail.com> <743E221E-6137-4525-9F89-20E06CD404E4@oracle.com>
In-Reply-To: <743E221E-6137-4525-9F89-20E06CD404E4@oracle.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 14 Oct 2024 10:55:06 +0200
Message-ID: <CAOQ4uxi+ztQGDNeoWJDL_jawKyDqEdQYbjDvWvJYat73zhuoXg@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] API for exporting connectable file handles to userspace
To: Chuck Lever III <chuck.lever@oracle.com>, Ilya Dryomov <idryomov@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.cz>, 
	Aleksa Sarai <cyphar@cyphar.com>, Linux FS Devel <linux-fsdevel@vger.kernel.org>, 
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>, Xiubo Li <xiubli@redhat.com>
Content-Type: multipart/mixed; boundary="000000000000fc6e5206246bfe85"

--000000000000fc6e5206246bfe85
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 11, 2024 at 8:40=E2=80=AFPM Chuck Lever III <chuck.lever@oracle=
.com> wrote:
>
>
>
> > On Oct 11, 2024, at 2:22=E2=80=AFPM, Amir Goldstein <amir73il@gmail.com=
> wrote:
> >
> > On Fri, Oct 11, 2024 at 4:24=E2=80=AFPM Chuck Lever III <chuck.lever@or=
acle.com> wrote:
> >>
> >>
> >>
> >>> On Oct 11, 2024, at 5:00=E2=80=AFAM, Amir Goldstein <amir73il@gmail.c=
om> wrote:
> >>>
> >>> Christian,
> >>>
> >>> These patches bring the NFS connectable file handles feature to
> >>> userspace servers.
> >>>
> >>> They rely on your and Aleksa's changes recently merged to v6.12.
> >>>
> >>> This v4 incorporates the review comments on Jeff and Jan (thanks!)
> >>> and there does not seem to be any objection for this new API, so
> >>> I think it is ready for staging.
> >>>
> >>> The API I chose for encoding conenctable file handles is pretty
> >>> conventional (AT_HANDLE_CONNECTABLE).
> >>>
> >>> open_by_handle_at(2) does not have AT_ flags argument, but also, I fi=
nd
> >>> it more useful API that encoding a connectable file handle can mandat=
e
> >>> the resolving of a connected fd, without having to opt-in for a
> >>> connected fd independently.
> >>>
> >>> I chose to implemnent this by using upper bits in the handle type fie=
ld
> >>> It may be that out-of-tree filesystems return a handle type with uppe=
r
> >>> bits set, but AFAIK, no in-tree filesystem does that.
> >>> I added some warnings just in case we encouter that.
> >>>
> >>> I have written an fstest [4] and a man page draft [5] for the feature=
.
> >>>
> >>> Thanks,
> >>> Amir.
> >>>
> >>> Changes since v3 [3]:
> >>> - Relax WARN_ON in decode and replace with pr_warn in encode (Jeff)
> >>> - Loose the macro FILEID_USER_TYPE_IS_VALID() (Jan)
> >>> - Add explicit check for negative type values (Jan)
> >>> - Added fstest and man-page draft
> >>>
> >>> Changes since v2 [2]:
> >>> - Use bit arithmetics instead of bitfileds (Jeff)
> >>> - Add assertions about use of high type bits
> >>>
> >>> Changes since v1 [1]:
> >>> - Assert on encode for disconnected path (Jeff)
> >>> - Don't allow AT_HANDLE_CONNECTABLE with AT_EMPTY_PATH
> >>> - Drop the O_PATH mount_fd API hack (Jeff)
> >>> - Encode an explicit "connectable" flag in handle type
> >>>
> >>> [1] https://lore.kernel.org/linux-fsdevel/20240919140611.1771651-1-am=
ir73il@gmail.com/
> >>> [2] https://lore.kernel.org/linux-fsdevel/20240923082829.1910210-1-am=
ir73il@gmail.com/
> >>> [3] https://lore.kernel.org/linux-fsdevel/20241008152118.453724-1-ami=
r73il@gmail.com/
> >>> [4] https://github.com/amir73il/xfstests/commits/connectable-fh/
> >>> [5] https://github.com/amir73il/man-pages/commits/connectable-fh/
> >>>
> >>> Amir Goldstein (3):
> >>> fs: prepare for "explicit connectable" file handles
> >>> fs: name_to_handle_at() support for "explicit connectable" file
> >>>   handles
> >>> fs: open_by_handle_at() support for decoding "explicit connectable"
> >>>   file handles
> >>>
> >>> fs/exportfs/expfs.c        | 17 ++++++++-
> >>> fs/fhandle.c               | 75 +++++++++++++++++++++++++++++++++++--=
-
> >>> include/linux/exportfs.h   | 13 +++++++
> >>> include/uapi/linux/fcntl.h |  1 +
> >>> 4 files changed, 98 insertions(+), 8 deletions(-)
> >>>
> >>> --
> >>> 2.34.1
> >>>
> >>
> >> Acked-by: Chuck Lever <chuck.lever@oracle.com <mailto:chuck.lever@orac=
le.com>>
> >>
> >> Assuming this is going directly to Christian's tree.
> >>
> >> I'm a little concerned about how this new facility might be
> >> abused to get access to parts of the file system that a user
> >> is not authorized to access.
> >
> > That's exactly the sort of thing I would like to be reviewed,
> > but what makes you feel concerned?
> >
> > Are you concerned about handcrafted file handles?
>
> Yes; a user could construct a file handle that could bypass
> the usual authorization checks when it gets connected. It's
> a little hare-brained and hand-wavy because this is a new
> area for me.
>

A malformed file handle is indeed a concern - it has always been,
but in order to exploit one, an attacker would actually need to have
a filesystem exported to nfs (to the attacking client machine).

With commit 620c266f3949 ("fhandle: relax open_by_handle_at()
permission checks"), attackers that have non-root access to a machine
could also try to exploit filesystem bugs with malformed file handles.

By adding support for connectable file handles, attackers could try
to exploit bugs in ->fh_to_parent() implementations - bugs that would
not have been exploitable so far unless filesystem is exported to nfs with
subtree_check, which is quite rare IIUC.

So I did an audit of the in-tree ->fh_to_{dentry,parent}() implementations.
AFAICT all implementations properly check buffer length before trying
to decode the handle... except for ceph.

It looks to me like __snapfh_to_dentry() does not check buffer length
before assuming that ceph_nfs_snapfh can be accessed.

Ilya,

Do you agree with my analysis?
Please see the attached fix patch.
Let me know if you want me to post it on ceph list or if that is sufficient=
.

Thanks,
Amir.

--000000000000fc6e5206246bfe85
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-ceph-fix-bounds-check-for-decoding-fh-of-snapshot-fi.patch"
Content-Disposition: attachment; 
	filename="0001-ceph-fix-bounds-check-for-decoding-fh-of-snapshot-fi.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_m28rz3th0>
X-Attachment-Id: f_m28rz3th0

RnJvbSAyMjljMGI2NjYzZWVmNjU0MzYwMzFiNzgyZjg1OGQwMmQ1ZGVjOTM4IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbWlyIEdvbGRzdGVpbiA8YW1pcjczaWxAZ21haWwuY29tPgpE
YXRlOiBNb24sIDE0IE9jdCAyMDI0IDEwOjQ2OjIwICswMjAwClN1YmplY3Q6IFtQQVRDSF0gY2Vw
aDogZml4IGJvdW5kcyBjaGVjayBmb3IgZGVjb2RpbmcgZmggb2Ygc25hcHNob3QgZmlsZQoKUHJl
dmVudCBhdHRhY2tlcnMgZnJvbSB1c2luZyBtYWxmb3JtZWQgY2VwaCBmaWxlIGhhbmRsZSB3aXRo
IHR5cGUKRklMRUlEX0JUUkZTX1dJVEhfUEFSRU5UIHRvIGNhdXNlIG91dCBvZiBib3VuZHMgYWNj
ZXNzLgoKRml4ZXM6IDU3MGRmNGU5YzIzZiAoImNlcGg6IHNuYXBzaG90IG5mcyByZS1leHBvcnQi
KQpTaWduZWQtb2ZmLWJ5OiBBbWlyIEdvbGRzdGVpbiA8YW1pcjczaWxAZ21haWwuY29tPgotLS0K
IGZzL2NlcGgvZXhwb3J0LmMgfCA0ICsrKysKIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMo
KykKCmRpZmYgLS1naXQgYS9mcy9jZXBoL2V4cG9ydC5jIGIvZnMvY2VwaC9leHBvcnQuYwppbmRl
eCA0NDQ1MTc0OWM1NDQuLjRhOGQwMGU5OTEwYSAxMDA2NDQKLS0tIGEvZnMvY2VwaC9leHBvcnQu
YworKysgYi9mcy9jZXBoL2V4cG9ydC5jCkBAIC0zMDIsNiArMzAyLDggQEAgc3RhdGljIHN0cnVj
dCBkZW50cnkgKmNlcGhfZmhfdG9fZGVudHJ5KHN0cnVjdCBzdXBlcl9ibG9jayAqc2IsCiAKIAlp
ZiAoZmhfdHlwZSA9PSBGSUxFSURfQlRSRlNfV0lUSF9QQVJFTlQpIHsKIAkJc3RydWN0IGNlcGhf
bmZzX3NuYXBmaCAqc2ZoID0gKHZvaWQgKilmaWQtPnJhdzsKKwkJaWYgKGZoX2xlbiA8IHNpemVv
Zigqc2ZoKSAvIDQpCisJCQlyZXR1cm4gTlVMTDsKIAkJcmV0dXJuIF9fc25hcGZoX3RvX2RlbnRy
eShzYiwgc2ZoLCBmYWxzZSk7CiAJfQogCkBAIC00MjIsNiArNDI0LDggQEAgc3RhdGljIHN0cnVj
dCBkZW50cnkgKmNlcGhfZmhfdG9fcGFyZW50KHN0cnVjdCBzdXBlcl9ibG9jayAqc2IsCiAKIAlp
ZiAoZmhfdHlwZSA9PSBGSUxFSURfQlRSRlNfV0lUSF9QQVJFTlQpIHsKIAkJc3RydWN0IGNlcGhf
bmZzX3NuYXBmaCAqc2ZoID0gKHZvaWQgKilmaWQtPnJhdzsKKwkJaWYgKGZoX2xlbiA8IHNpemVv
Zigqc2ZoKSAvIDQpCisJCQlyZXR1cm4gTlVMTDsKIAkJcmV0dXJuIF9fc25hcGZoX3RvX2RlbnRy
eShzYiwgc2ZoLCB0cnVlKTsKIAl9CiAKLS0gCjIuMzQuMQoK
--000000000000fc6e5206246bfe85--

