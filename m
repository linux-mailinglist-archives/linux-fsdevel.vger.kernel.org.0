Return-Path: <linux-fsdevel+bounces-29706-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03A7E97C8F0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Sep 2024 14:18:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 847B52859D4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Sep 2024 12:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 598C919D88D;
	Thu, 19 Sep 2024 12:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mnyKVVK0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56010199FCD;
	Thu, 19 Sep 2024 12:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726748312; cv=none; b=WBI7sGE8yOn+xHV7cFyefCP//1T8M5AsD4XbxUXxrJu2oHxYPgbTHtq0x2gscWkYEWGe2D69sxZ/XHC2nce5FU3XvZ8Cowy4hjTlMmcUmVkgiHj1rre6zsmU2VSMKb95hJS/4JDTm8lGUeRKvIvkfXK2v5R6sv8mCs4HhgQd39Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726748312; c=relaxed/simple;
	bh=absoCpViD2rd9oH2c7EtVkPVbL+HoTLCORezhf11GC4=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=p7IWevFXrhQArdF/IxEQjschCNib+kfxHVy2AIYb3p9iRa87aupuvaQ/hq3RfVzm9UyYjMndQBg4EUvt1tu5AB2wblXlCy3IUwnMIAXTtUvsLowh1c7QZQvTmouM/Dfj6Gv9mWimkcjFm+m08VFiQ/AiSKB+xuXYmx5Oj06hZuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mnyKVVK0; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2053f72319fso662915ad.2;
        Thu, 19 Sep 2024 05:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726748311; x=1727353111; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b0LMxaprsYAgSwJ1aL8Oxeuw2B+YaEuC1gX91HbsNHM=;
        b=mnyKVVK0bciTZoiguFgrkUzn1njpage+a/J4vReBDSQXuMr6iITFHtA9iUorxUgAkF
         PR6zDJBdI7hf19ytEfVAlQ9HWgFaGAkE2pwN2dqWaLlJujLYoK+lx+DXE5McAU46KEiT
         dR7N0B+jHKU8vsbp+oQ+dbNBE+aXWWKjW39D8hcpAFXGNr3mphLrkdE7cn5QEntpejvT
         /0fGn4lPGGN3Y1lFexAB8naoDZ1cgpvmt8CB90VSt0DDGSES1jxCkP4rZmcr9dh32W63
         ecIEv8clEOMz2+kYZc8WfflHJb8ptQlZmGhrgL6vJEXxsduO66ncFA+Vb/VBUCVprvUm
         cWHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726748311; x=1727353111;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b0LMxaprsYAgSwJ1aL8Oxeuw2B+YaEuC1gX91HbsNHM=;
        b=T+rRfHipCu0RBdBC9FuMkihAwPTmRcdlKLCJ9fbB/UETQWItH4+5pftlQJ1IgEqZWT
         hYRwK8guakyeB9pULAaeVa6wG5QMaJTXFK42KdaFUYx/bGsCrX16GlL3jw0VFG/Q1VPk
         iLcsAUaWnVRhcnJqICiBR9w3DO3hCD5vePjGQsKnNnQefGcFMJjfRUC4Grhqy4bwX5h5
         zZaQwSo+ttWpWRGVxReKp0zr8T+8uxDhuFMlTsCXLYAI3BX2tbXpZA/s7/K4Wnm6PDnP
         TIB6/0OEsE/OKxtSCTOwE/uvAkefYyddLzGSVZh80gDb0/wPxRUuRG+XaU5mVFIHfNEl
         iRVA==
X-Forwarded-Encrypted: i=1; AJvYcCWsP0kgWmZSM063aA4ArSM56AIyuD8hJuGlPN7urAMby1xGXAZphzDPWAZITielxOl5TWtFFtNR@vger.kernel.org, AJvYcCXrn7XfDnQQRzXiQUFZc1hqg+bYBxjTScjJrmQh186th4wkOHx2AYlJeMhhVARPSNSKaw4+vGmr5MNR2fCt@vger.kernel.org
X-Gm-Message-State: AOJu0Yw43zmSgqaITgmjxwg6tPZBHOGGNZsyg447v5sMV8mD4SG1eEwe
	Wz/yQSxc9WczqvfSCxOY262e+B2kY8vqJiPGf8QIALfAF2yDUny+
X-Google-Smtp-Source: AGHT+IG+c+ZQwOvpYAnnod5j5peCOVYy7tlRTX9YD4rCuK7dGJahEOJ+CSADrqtBazAQlxOERuqKBw==
X-Received: by 2002:a17:902:d4cb:b0:205:4415:c62f with SMTP id d9443c01a7336-2076e318b03mr163387575ad.1.1726748310414;
        Thu, 19 Sep 2024 05:18:30 -0700 (PDT)
Received: from smtpclient.apple (v133-130-115-230.a046.g.tyo1.static.cnode.io. [133.130.115.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-207946d27ffsm78717035ad.121.2024.09.19.05.18.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Sep 2024 05:18:29 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51\))
Subject: Re: [PATCH 0/3] Backport statx(..., NULL, AT_EMPTY_PATH, ...)
From: Miao Wang <shankerwangmiao@gmail.com>
In-Reply-To: <2024091900-sloppy-swept-0a2e@gregkh>
Date: Thu, 19 Sep 2024 20:18:10 +0800
Cc: Xi Ruoyao <xry111@xry111.site>,
 stable@vger.kernel.org,
 Mateusz Guzik <mjguzik@gmail.com>,
 Christian Brauner <brauner@kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Jan Kara <jack@suse.cz>,
 Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>,
 Wedson Almeida Filho <wedsonaf@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@samsung.com>,
 Alice Ryhl <aliceryhl@google.com>,
 linux-fsdevel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <D5904FCB-5681-4744-93AE-BF030307CF86@gmail.com>
References: <20240918-statx-stable-linux-6-10-y-v1-0-8364a071074f@gmail.com>
 <2024091801-segment-lurk-e67b@gregkh>
 <f6ecd24e0fdb1327dad41f41c3ac31477ca00c9f.camel@xry111.site>
 <2024091900-sloppy-swept-0a2e@gregkh>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
X-Mailer: Apple Mail (2.3776.700.51)


> 2024=E5=B9=B49=E6=9C=8819=E6=97=A5 19:18=EF=BC=8CGreg Kroah-Hartman =
<gregkh@linuxfoundation.org> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On Thu, Sep 19, 2024 at 01:37:17AM +0800, Xi Ruoyao wrote:
>> On Wed, 2024-09-18 at 19:33 +0200, Greg Kroah-Hartman wrote:
>>> On Wed, Sep 18, 2024 at 10:01:18PM +0800, Miao Wang via B4 Relay =
wrote:
>>>> Commit 0ef625bba6fb ("vfs: support statx(..., NULL, AT_EMPTY_PATH,
>>>> ...)") added support for passing in NULL when AT_EMPTY_PATH is =
given,
>>>> improving performance when statx is used for fetching stat =
informantion
>>>> from a given fd, which is especially important for 32-bit =
platforms.
>>>> This commit also improved the performance when an empty string is =
given
>>>> by short-circuiting the handling of such paths.
>>>>=20
>>>> This series is based on the commits in the Linus=E2=80=99 tree. =
Sligth
>>>> modifications are applied to the context of the patches for cleanly
>>>> applying.
>>>>=20
>>>> Tested-by: Xi Ruoyao <xry111@xry111.site>
>>>> Signed-off-by: Miao Wang <shankerwangmiao@gmail.com>
>>>=20
>>> This really looks like a brand new feature wanting to be backported, =
so
>>> why does it qualify under the stable kernel rules as fixing =
something?
>>>=20
>>> I am willing to take some kinds of "fixes performance issues" new
>>> features when the subsystem maintainers agree and ask for it, but =
that
>>> doesn't seem to be the case here, and so without their approval and
>>> agreement that this is relevant, we can't accept them.
>>=20
>> Unfortunately the performance issue fix and the new feature are in =
the
>> same commit.  Is it acceptable to separate out the performance fix =
part
>> for stable?  (Basically remove "if (!path) return true;" from the 1st
>> patch.)
>=20
> What prevents you, if you wish to have the increased performance, from
> just moving to a newer kernel version?  We add new features and
> improvements like this all the time, why is this one so special to
> warrant doing backports.  Especially with no maintainer or subsystem
> developer asking for this to be done?

We all know the long process from a new improvement getting into the =
mainline
kernel to landing in users' devices. Considering 32-bit archectures =
which lacks
64-bit time support in fstat(), statx(fd, AT_EMPTY_PATH) is heavily =
relied on.
My intention on putting up this backport is that to quicken this =
process,
benefiting these users.

Another reason is about loongarch. fstat() was not included in loongarch
initially, until 6.11. Although the re-inclusion of fstat() is =
backported to
stable releases, we still have implementation problems on the glibc =
side, that
loongarch is the only architecture that may lack the support of fstat. =
If
dynamic probing of the existence of fstat() is implemented, this code =
path
would be only effective on loongarch, adding another layer of mess to =
the
current fstat implementation and adding maintenance burden to glibc =
maintainers.
Instead, if we choose to utilize statx(fd, NULL, AT_EMPTY_PATH), even if =
using
dynamic probing, loongarch and all other 32-bit architectures using =
statx() for
fstat() can benefit from this.

Based on the same reason why you have accepted the re-inclusion of fstat =
on
loongarch into the stable trees, I believe it would be potentially =
possible to
let the statx(..., NULL, AT_EMPTY_PATH, ...) get into the stable trees =
as well.

Thanks again for your considering this. Since VFS maintainers are being =
looped
in the thread, if their approval is necessary, I'm happy to listen to =
their
opinions.

Cheers,

Miao Wang




