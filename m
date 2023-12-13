Return-Path: <linux-fsdevel+bounces-6018-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 487C2812200
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 23:45:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F322328285B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 22:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A95B81856;
	Wed, 13 Dec 2023 22:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b="1exgBniK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5006810A
	for <linux-fsdevel@vger.kernel.org>; Wed, 13 Dec 2023 14:44:59 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-6d099d316a8so3644002b3a.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Dec 2023 14:44:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20230601.gappssmtp.com; s=20230601; t=1702507498; x=1703112298; darn=vger.kernel.org;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=kGZCiOP60aS3LFYHsa7o61H18ddX3mq+UCl5wwvEYdo=;
        b=1exgBniKuTC3GyNd7YlecCFTNxbqiGbfaURpDZhsJM0sHzPXfSitlGdzWOtAkNaQam
         rdpn0+LC5NOErW+2iMKEl8tHK4TFjQzBFcVL430URVUvx1M87yuC5tR1hxFQW3jopSbf
         JVHUTqwaqdmmUGrm8KffO3FjRcDciwstwBJSGavX1YFKU2Brd/0hPVlhMftReIeqs8hX
         e5d97B7u+/l6KEJab76197ZV7fT15C8Z6xasR4D2bRZr63TcskcLvlmiE2hQSXstP3U6
         qCLo59AZIXlxTikDDJkZ5nleDFg6oqUeVeu6inymNHmCdnyGCuo7L2anLCEJoT3vLGEV
         5wLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702507498; x=1703112298;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kGZCiOP60aS3LFYHsa7o61H18ddX3mq+UCl5wwvEYdo=;
        b=QjMfeJz3aXL98Jwj7imugmjKNhgNqQ/yoqv2qGFSSZrVWXUIZIV38uoYBrxERZWDdu
         RFMXnFLOjVQ3JNS/c49lk4ZCjsnZwwLlKzJiaDD/i+lM7vr4Bjt2T6J33ZtEsLyCYJ1B
         WBjST3LRt3Y0lZhPnKQnAQu+oua80Cmew4f3t3SEGBgC4aCgkf1R3y7MqjxDm2h16CIx
         PTDlSqVFIfxCNrmnVN/afiXGwQ6jNpeKMmqVh9vtlPJbjxSzTu50+usALWVWLgWUbYom
         nW8wiEirnhrQvJRm8nst8QiyEWA617MzYJ9kfrfnUNyL/anTzWkr6P7cMocKTS++sKCL
         Eibw==
X-Gm-Message-State: AOJu0Yyyzjgq4jrlLQIcEobU9wtVCQjLm07rixyh03x7TLphmNiQ/fPY
	beA4O8ZaKVWVkMFyvnQYWd1L8g==
X-Google-Smtp-Source: AGHT+IFf/Zh0NlXXtN9wAY10vXACB6rCtubJlDY4asxnoJeKpZffZstGrb15pMO4Vwio4pfsAX3O1A==
X-Received: by 2002:a05:6a21:3398:b0:18f:97c:614b with SMTP id yy24-20020a056a21339800b0018f097c614bmr11523777pzb.72.1702507498558;
        Wed, 13 Dec 2023 14:44:58 -0800 (PST)
Received: from cabot.adilger.int (S01068c763f81ca4b.cg.shawcable.net. [70.77.200.158])
        by smtp.gmail.com with ESMTPSA id y65-20020a636444000000b005b18c53d73csm10226393pgb.16.2023.12.13.14.44.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Dec 2023 14:44:58 -0800 (PST)
From: Andreas Dilger <adilger@dilger.ca>
Message-Id: <ECCDEA37-5F5F-4854-93FB-1C50213DCA6D@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_3B6D71F9-E993-4E4B-B2C8-31A613CAEFA0";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: file handle in statx (was: Re: How to cope with subvolumes and
 snapshots on muti-user systems?)
Date: Wed, 13 Dec 2023 15:45:41 -0700
In-Reply-To: <170242574922.12910.6678164161619832398@noble.neil.brown.name>
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
 David Howells <dhowells@redhat.com>,
 Donald Buczek <buczek@molgen.mpg.de>,
 linux-bcachefs@vger.kernel.org,
 Stefan Krueger <stefan.krueger@aei.mpg.de>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 Dave Chinner <david@fromorbit.com>
To: NeilBrown <neilb@suse.de>
References: <170199821328.12910.289120389882559143@noble.neil.brown.name>
 <20231208013739.frhvlisxut6hexnd@moria.home.lan>
 <170200162890.12910.9667703050904306180@noble.neil.brown.name>
 <20231208024919.yjmyasgc76gxjnda@moria.home.lan>
 <630fcb48-1e1e-43df-8b27-a396a06c9f37@molgen.mpg.de>
 <20231208200247.we3zrwmnkwy5ibbz@moria.home.lan>
 <170233460764.12910.276163802059260666@noble.neil.brown.name>
 <2799307.1702338016@warthog.procyon.org.uk>
 <20231212205929.op6tq3pqobwmix5a@moria.home.lan>
 <170242184299.12910.16703366490924138473@noble.neil.brown.name>
 <20231212234348.ojllavmflwipxo2j@moria.home.lan>
 <170242574922.12910.6678164161619832398@noble.neil.brown.name>
X-Mailer: Apple Mail (2.3273)


--Apple-Mail=_3B6D71F9-E993-4E4B-B2C8-31A613CAEFA0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Dec 12, 2023, at 5:02 PM, NeilBrown <neilb@suse.de> wrote:
>=20
> On Wed, 13 Dec 2023, Kent Overstreet wrote:
>> On Wed, Dec 13, 2023 at 09:57:22AM +1100, NeilBrown wrote:
>>> On Wed, 13 Dec 2023, Kent Overstreet wrote:
>>>> On Mon, Dec 11, 2023 at 11:40:16PM +0000, David Howells wrote:
>>>>> Kent Overstreet <kent.overstreet@linux.dev> wrote:
>>>>>=20
>>>>>> I was chatting a bit with David Howells on IRC about this, and =
floated
>>>>>> adding the file handle to statx. It looks like there's enough =
space
>>>>>> reserved to make this feasible - probably going with a fixed =
maximum
>>>>>> size of 128-256 bits.
>>>>>=20
>>>>> We can always save the last bit to indicate extension =
space/extension record,
>>>>> so we're not that strapped for space.
>>>>=20
>>>> So we'll need that if we want to round trip NFSv4 filehandles, they
>>>> won't fit in existing struct statx (nfsv4 specs 128 bytes, statx =
has 96
>>>> bytes reserved).
>>>>=20
>>>> Obvious question (Neal): do/will real world implementations ever =
come
>>>> close to making use of this, or was this a "future proofing gone =
wild"
>>>> thing?
>>>=20
>>> I have no useful data.  I have seen lots of filehandles but I don't =
pay
>>> much attention to their length.  Certainly some are longer than 32 =
bytes.
>>>=20
>>>>=20
>>>> Say we do decide we want to spec it that large: _can_ we extend =
struct
>>>> statx? I'm wondering if the userspace side was thought through, I'm
>>>> sure glibc people will have something to say.
>>>=20
>>> The man page says:
>>>=20
>>>     Therefore, do not simply set mask to UINT_MAX (all bits set), as
>>>     one or more bits may, in the future, be used to specify an
>>>     extension to the buffer.
>>>=20
>>> I suspect the glibc people read that.
>>=20
>> The trouble is that C has no notion of which types are safe to pass
>> across a dynamic library boundary, so if we increase the size of =
struct
>> statx and someone's doing that things will break in nasty ways.
>>=20
>=20
> Maybe we don't increase the size of struct statx.
> Maybe we declare
>=20
>   struct statx2 {
>     struct statx base;
>     __u8 stx_handle[128];
>   }
>=20
> and pass then when we request STX_HANDLE.

This would be extremely fragile, in the sense that "struct statx2" =
breaks
if "struct statx" adds any fields.


Not getting into the question of whether the FH _should_ be added to =
statx
or not, but I wanted to chime in on the discussion about statx being =
able
to add new fields.

The answer is definitely yes.  Callers are expected to set STATX_* flags
for any fields that they are interested in, so if the caller were to set
STATX_FILE_HANDLE in the request, then it is expected they understand =
this
flag and have allocated a large enough struct statx to hold =
stx_file_handle
in the reply.

Apps that don't need/want stx_file_handle should not set =
STATX_FILE_HANDLE
and then the kernel won't spend time to fill this in, the same as other
fields that may have overhead, like stx_size.  That should avoid =
concerns
from Dave that this adds overhead to the hot path.  Most apps won't need =
or
want this field, but apps that *do* want it would be better served =
getting
it in a single syscall instead of two (and avoid potential TOCTOU =
races).


It should be possible for userspace and the kernel to increase the size =
of
struct statx independently, and not have any issues.  If userspace =
requests
a field via STATX_* flags that the kernel doesn't understand, then it =
will
be masked out by the kernel, and any extended fields in the struct will =
not
be referenced.  Likewise, if the kernel understands more fields than =
what
userspace requests, it shouldn't spend time to fill in those fields, =
since
userspace will ignores them anyway, so it is just wasted cycles.



Not going into whether statx _should_ handle variable-sized fields, but
it _could_ do so, though it would make struct handling a bit more =
complex.

Adding "__u32 stx_file_handle_size" and "__u32 stx_file_handle_offset"
(relative to the start of the struct) to encode where the variable sized
handle data would be packed at the end after fixed-size fields (aligned
on a __u64 boundary to avoid issues if there are multiple such fields).
Userspace would indicate the maximum size of file handle it expects via
(stx_file_handle_offset + stx_file_handle_size).  The kernel would be at
liberty to pack "struct file_handle" at that offset, or after the end of
whatever fields are actually used, and userspace would use this to =
access
the handle.

Not pretty, but probably better than reserving a huge fixed size field
that is not needed for most case (is NFS intending a server on every
sub-atomic particle in the universe?).  This would allow apps to access
fields after stx_file_handle_size/offset normally, and only compute a
simple offset to access the variable sized blob as needed.  The presence
of STATX_FILE_HANDLE would indicate if the size/offset fields were valid
upon return (since an old kernel would not zero the fields).

Cheers, Andreas






--Apple-Mail=_3B6D71F9-E993-4E4B-B2C8-31A613CAEFA0
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmV6NBYACgkQcqXauRfM
H+C8Dw//XGfgCZJzoJX5Hi+UNFfjpLMJ5T3KfKH8xakhKMNDhM11Kgp9ShOAXy2b
MktsoWX8b9c+aNOH+bVAx16Clj/DKMxEjPeGGTztVse5GrhZ8r+g1aGCnTf+kgtq
eIu+prD9uOflIa4BpLImI9/aD3jIn6OJVLuxVhIcNSlT6kXXB3sk6hNYn7LUorgc
IIdPYGzQnNvljasDVcv/Mveo6VCgluMr+o/mMeHr/OKJCODFfZv15S21pqnPv7EW
68zLt5yqWLZzhLWiPgtYLsLS6ZtsvUoV9w8JVLwQWSz1bP17g7TdqWo5B9DTSLgI
v9y/ovmWbttOi6m+21hVW+tVYcAaHLE86DmPdGjXTFHNWQurqsoGGU0txItk5UHH
bSMyEE/HLBiQ+d/OOZCDfiFt6o20d8M799x8XXlg53cob5uSIgyGdkZ6A8DFbcSn
QWvpTMQuFMJBA4jjrTSel0xaZVscKKm6XX/4nq+sR3lbG1koT3CyQ6xht7LGv1EC
CIlysQ8BPGd2l3irv1chIUJT9DZWC7f/iifQyof5cBHkEfYVt7b1pKMWdUjt/xwT
MoJsJlGY8tT2OE+PtH68aT6+I99seX7P2+0EBncb4V26K+CEbiGqXzN/ufhoxIgt
fqE/9gIupMiuVjNwocIvJQw0rWNWGHfkHoeHt+vWK0aBdLqD35E=
=Y0hw
-----END PGP SIGNATURE-----

--Apple-Mail=_3B6D71F9-E993-4E4B-B2C8-31A613CAEFA0--

