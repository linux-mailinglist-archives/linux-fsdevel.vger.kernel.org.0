Return-Path: <linux-fsdevel+bounces-49103-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56DDDAB80AE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 10:31:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB4CE4E1951
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 08:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A50A28ECCE;
	Thu, 15 May 2025 08:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="GraEnDqp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04AD528DF00
	for <linux-fsdevel@vger.kernel.org>; Thu, 15 May 2025 08:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747297647; cv=none; b=tYW4W7VPDSJIUeix5emqrFovUqEX3R8jU+wSoaEz7N7/m2ShoA3V2PqN5qqtHWu3P+tLRPJPTeheaYvOqEbLF7zCVKAqrX7ulQy8wNSRlVl486ctIvRRJWibWUxUr/oi/61HamM1rbkO9TnXto8SFXGMSuxu8SpHMF7EUCaXVwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747297647; c=relaxed/simple;
	bh=ju3GYTAc6g9gB56j4cOaA5NMlcLlKL1y4kqQjU1EJek=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dpEY3bGSiwW9YWCZwznZ7EJhvm/vAYASdmEjManyAbxgAJFSFBw8E3v52oF2Oe6H+/dKxvZhPHTQ/UOGRBatMsHCJKZDPlZl0m2wDsrPzHDvzQpw0IVYvL/nRdx1/CwTqyRqXtLMAaRzkUQNjJTMt2LyAZdJfewRsND5DagC2iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=GraEnDqp; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-476a1acf61eso6235151cf.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 May 2025 01:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1747297645; x=1747902445; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pWxCUTBI6tcE82Qu84WtIEGkLKncwUangQq7J5ogvJc=;
        b=GraEnDqpfdKlR6GsB4tc4iLjlMvgNctLSxSV00bIN3fkjlUlBAiP7XjDf6X/+rCmTI
         yKMD0m4x7QPjUxoE2pHKoctMBZi+VSImQ6VsGLuAYv012RXOAfGyucE9m7EG26jCAJh5
         qQHFFaGW2TojiCXcjuw9xfQeLqQfg7kVb/GIc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747297645; x=1747902445;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pWxCUTBI6tcE82Qu84WtIEGkLKncwUangQq7J5ogvJc=;
        b=G2Lg67JRv9JKkR8INAqN3WVqtfr1WGyjRgGj5vzITysUGnPAFM/S20Z0G9apnR4EEU
         Kb+LMVhvfMOfds0AMsganqrbgQ5CrHCzfY4+bO+0qfCGaNigjy9A1CYWZsNfYWkX4Z8I
         P6qUQbydUn4xVHDNMaBbkUN48Z0lu+d/FgAsZDcNsDJUS+DVJKEQp6I8Jo7O4Y+X/Mtr
         4vAC+i5SQbU6NKm0VRkuLQ/wGRUydzKx1PwuogTY5X5XZ0i0o9XQHeqUHCJgUYaQ5N3x
         o5vaQ3C3gengMZTObfB1UpHT5bLygUdgjWmFFkg2up1F5sAbqPXcWMhAPhhoLra6haw6
         LbzA==
X-Gm-Message-State: AOJu0Yx0xxj73C+zVEPyG7KOwwi7LLoT4I38vdhkbVwNwBvm0Cx3RJvS
	E6cxxJlOHOVMNX0sRmlZhauItHl32nBNG5T6rZQXDhrEqKF7w9ZfYgnv5JJ5Nz7iXFw7aSCF5IX
	xrDKuFN1bYb8O8NyUOoKoCRjv0PJMgNUN7z/vnA==
X-Gm-Gg: ASbGncu72n8vioSa8hhM1tgMSNzwauSZw7S9dx2PpGz+DVZvEU2ll6jTX/PMD0wA0gs
	B54EFvqh/fcfWvOfgwDta2uMuzF6T0CZ2bgRBHrHx7x9Tjdpq0t/eOKyI86bu07GIHp3AYbOMNC
	1LZgok4JX8zh3e/11FKadXB+YdrEm38UM=
X-Google-Smtp-Source: AGHT+IHPXGHKYk/SgDbl3GgEYBWZPWdZRKYIDYtgS32VDN3lW3xyfFF+TZD5Tujmh8RiYERqqqsfznena5GbgNbO/lA=
X-Received: by 2002:a05:622a:5585:b0:472:1d98:c6df with SMTP id
 d75a77b69052e-49495d2eeb6mr122369471cf.52.1747297644753; Thu, 15 May 2025
 01:27:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250512225840.826249-1-joannelkoong@gmail.com>
 <20250512225840.826249-11-joannelkoong@gmail.com> <CAJfpegs=3mhpQeXhu37HN=p846UFzxEg3NM9awwLwU+cKr1NZw@mail.gmail.com>
 <CAJnrk1Z8OEjrvFtqgR22E-8MWE5MAbA3LDgv54XEHudr4ELsDg@mail.gmail.com>
In-Reply-To: <CAJnrk1Z8OEjrvFtqgR22E-8MWE5MAbA3LDgv54XEHudr4ELsDg@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 15 May 2025 10:27:14 +0200
X-Gm-Features: AX0GCFvwRwwje3b0u_kvJzE7tdwcmKiiEIhJHAEFR7Xgs0rERnWX_GQLkNRH_c4
Message-ID: <CAJfpegt2yWFynKpgjCxCbhXmMOU-umbvRkjc4eWBy4xVBcToYw@mail.gmail.com>
Subject: Re: [PATCH v6 10/11] fuse: optimize direct io large folios processing
To: Joanne Koong <joannelkoong@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, bernd.schubert@fastmail.fm, 
	jlayton@kernel.org, jefflexu@linux.alibaba.com, josef@toxicpanda.com, 
	willy@infradead.org, kernel-team@meta.com, Bernd Schubert <bschubert@ddn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 13 May 2025 at 22:39, Joanne Koong <joannelkoong@gmail.com> wrote:
>
> On Tue, May 13, 2025 at 12:19=E2=80=AFAM Miklos Szeredi <miklos@szeredi.h=
u> wrote:
> >
> > On Tue, 13 May 2025 at 00:59, Joanne Koong <joannelkoong@gmail.com> wro=
te:
> > >
> > > Optimize processing folios larger than one page size for the direct i=
o
> > > case. If contiguous pages are part of the same folio, collate the
> > > processing instead of processing each page in the folio separately.
> >
> > This patch is sort of special in the series, since the others are
> > basically no-op until large folios are enabled.
> >
> > Did you validate this in particular?  Is there a good way to test
> > direct I/O on a buffer with mixed folio sizes?
>
> Hi Miklos,
>
> No, I did not validate this case in particular. I'm happy to drop this
> patch for now and resend it when large folios get turned on, if you
> prefer that. It seems like it'd be good to add this case to xfstests.

Dropped for now.

Thanks,
Miklos

