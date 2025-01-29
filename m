Return-Path: <linux-fsdevel+bounces-40292-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2ACCA21E35
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2025 14:54:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3626718856AA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2025 13:54:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CFDD148FF9;
	Wed, 29 Jan 2025 13:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BeXEnz07"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5092822EE5
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jan 2025 13:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738158868; cv=none; b=OmQ0UIinXWgjtRLP9ow98hhu8TiJYQrz71Ip8ndRUBY8Mb4VX8W+3ZBzM3i/kmU+6CtvGU3LfqXnskJd0EoteqpiID2KEiDw4uiHvhIMxT0Tt5AJS/Ao4lU0jAY2ouUOvqldENiS1s0d4POeTIhSw9TFZKqAPgaSFWSXQEbJsjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738158868; c=relaxed/simple;
	bh=eRwhaLv5TWLvY+t+PzV+r0OKnG5yDvaTT1koG0K3dho=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NFVeaTfmgcB3iWu2T4J/smZZz39ybEV411gcOlcKRO0933spjBYTRIiY591ak3gJDGQsMx3G2rygBW4vJQVTXLgcd025P0mqsPMAIXpJkxPC/1+IBRTlikcv563Kw6c4+ITakKn8fsIUKaUMZkQwzaWKIFF8zKFONESYabAPm2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BeXEnz07; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738158866;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oOlu6dB3//zUYOhcqFla8h2uJ/qtjTb83w7ohytxlZ4=;
	b=BeXEnz07UmikxS+rNG5348J+dZnvVMZeO4wGeZj8Ob+k6LVOW9nKX1eu1laKxQXt2jDKiS
	YXNR9PTbjzqf3dAvZHgdlaq1L7EKovw7/L7IhiZ91Z4yCsxG71Hrg+Y/zz2o1nN85b1dbf
	bPI8Cv71NW1lowqvFiNBv9OFRaO7GIc=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-2-2ykU09Oq2Rxm6T5bjVNg-1; Wed, 29 Jan 2025 08:54:24 -0500
X-MC-Unique: 2-2ykU09Oq2Rxm6T5bjVNg-1
X-Mimecast-MFC-AGG-ID: 2-2ykU09Oq2Rxm6T5bjVNg
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-aaf8396f65fso695737466b.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jan 2025 05:54:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738158863; x=1738763663;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oOlu6dB3//zUYOhcqFla8h2uJ/qtjTb83w7ohytxlZ4=;
        b=ZWgNjW5vuZym2S1JhasugpbhZyOHPlKks9VaZfI88HoX1JD2DeMuSANwGY2F81GK3n
         u+KbdT4bKX4D8EPGzl6nNl7UcarkWi8AYsP4OnVYkgaV8uHNEyH4LE2ENyUBx5mpCdfn
         FW2IMZPhI0JPe7k/jOVC6VqA5Odx1H/q7xxOFSXpO9wDvVboXJ0fIRIRb4vbt060Ci9p
         G12bXinBmL36nbM9c89qgYS8Jr5uTihxx22a/jPcboC9gaXhh+/1y1OM4ZpQLcCMmH2q
         ijgr5KttT7Kjc2YjHS5IZ/Jp5Vghlc4rM+KI717oCL5xLvkhdbzxGp985/AI9mFeEJgX
         cVtA==
X-Forwarded-Encrypted: i=1; AJvYcCVuCbIrTLnMHi4cVPZHCDPD6xlaS1hD5VSZirviCwcQuslAJR7v0R4pLOTtgFon1dIXQoYT6tpDjL/12huc@vger.kernel.org
X-Gm-Message-State: AOJu0YxqJmlfsnhhb0mDYu2Vvom6oAItB6uOO54un5pbaF931VHK6QdD
	uV+D+v4QqA0bndwAkuvsbWJT5dTnPnPawEW6FST1iR5gFv6G/mtpajuYmfFUa35oU5P/woCtsLo
	4SJZofgMkQfqMXbcSxOcnFr+aIN6G8OLV9I2WJlsAVC41gf0RMwk0mNGfNMYDLi24teW1DydkZT
	jZ3TCVv+ug02D1Gy3dsfxk42TYoETBhpslC0q5sA==
X-Gm-Gg: ASbGncu5BfE0m6HgYl7U0EhOOXQ0IEFtYzxo7+98X99oh2dMhCrcKLGpK4nWNvmYqbT
	YaLtkpFcuW8mQDGnpajpTrOcqo3Ejz/IrUJr1VnG1LzjR38adYyxAWIYRf9WWKQ==
X-Received: by 2002:a17:906:608f:b0:ab6:d575:3c4c with SMTP id a640c23a62f3a-ab6d5753e0cmr160660866b.17.1738158862909;
        Wed, 29 Jan 2025 05:54:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGEoSRFizNZ7LApK6I1ExjTAM8b67HHexrPzWrlsDcchWhdruOGgR01UriVscVcl71uuggIobEF8/2Lt28xRMU=
X-Received: by 2002:a17:906:608f:b0:ab6:d575:3c4c with SMTP id
 a640c23a62f3a-ab6d5753e0cmr160659466b.17.1738158862523; Wed, 29 Jan 2025
 05:54:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <d81a04646f76e0b65cd1e075ab3d410c4b9c3876.camel@ibm.com>
 <3469649.1738083455@warthog.procyon.org.uk> <3406497.1738080815@warthog.procyon.org.uk>
 <c79589542404f2b73bcdbdc03d65aed0df17d799.camel@ibm.com> <20250117035044.23309-1-slava@dubeyko.com>
 <988267.1737365634@warthog.procyon.org.uk> <CAO8a2SgkzNQN_S=nKO5QXLG=yQ=x-AaKpFvDoCKz3B_jwBuALQ@mail.gmail.com>
 <3532744.1738094469@warthog.procyon.org.uk> <3541166.1738103654@warthog.procyon.org.uk>
 <dbf086dc3113448cb4efaeee144ad01d39d83ea3.camel@ibm.com> <CAO8a2SjrDL5TqW70P3yyqv8X-B5jfQRg-eMTs9Nbntr8=Mwbog@mail.gmail.com>
 <3669175.1738158126@warthog.procyon.org.uk>
In-Reply-To: <3669175.1738158126@warthog.procyon.org.uk>
From: Alex Markuze <amarkuze@redhat.com>
Date: Wed, 29 Jan 2025 15:54:11 +0200
X-Gm-Features: AWEUYZmRlTOFqntcqaf2lh13EYbDsYagSNYklA86w8T9p1Y0tYv9fQUzl6VDPoo
Message-ID: <CAO8a2Sg-uQdpAq+4K0y6=bzx7ACszm1Z2dZuhDhyMJ254mKL=g@mail.gmail.com>
Subject: Re: [PATCH v2] ceph: Fix kernel crash in generic/397 test
To: David Howells <dhowells@redhat.com>
Cc: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>, "idryomov@gmail.com" <idryomov@gmail.com>, 
	"slava@dubeyko.com" <slava@dubeyko.com>, 
	"ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Yeah, all tests are fully independent.
Just make sure you see them being executed or you can just run them stand a=
lone.
e.g., sudo ./check generic/429

On Wed, Jan 29, 2025 at 3:42=E2=80=AFPM David Howells <dhowells@redhat.com>=
 wrote:
>
> Alex Markuze <amarkuze@redhat.com> wrote:
>
> > FYI, This the set of fscrypt of tests that keep failing, w/o this patch=
.
> > Many of these revoke keys mid I/O.
> > generic/397
> > generic/421  #Test revoking an encryption key during concurrent I/O.
> > generic/429. #Test revoking an encryption key during concurrent I/O.
> > And additional fscrypt races
> > generic/440. #Test revoking an encryption key during concurrent I/O.
> > generic/580  #Testing the different keyring policies - also revokes
> > keys on open files
> > generic/593  #Test adding a key to a filesystem's fscrypt keyring via
> > an "fscrypt-provisioning" keyring key.
> > generic/595  #Test revoking an encryption key during concurrent I/O.
>
> I presume I don't need to add a key and that these do it for themselves?
>
> David
>


