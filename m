Return-Path: <linux-fsdevel+bounces-43371-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39BD4A55072
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Mar 2025 17:22:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3313171CB2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Mar 2025 16:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4744A21325B;
	Thu,  6 Mar 2025 16:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XjRaxjEN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13C90212D82
	for <linux-fsdevel@vger.kernel.org>; Thu,  6 Mar 2025 16:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741278125; cv=none; b=VXA3fk0MzI7b3ndRy4t8FxjImivvl32PtQKu+5T0O2eLg1SVNTxVobqdaPla5/xotTyC5H0hGRhr2RZMpFDFRWgdmF9m8h1zEy7r8O1goOXHrKxXXboNvp7tKxK1uXFxvcqIegkUvs/O5skglZBlX2Z8F9Mc5ZaqUOv+3XKVbkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741278125; c=relaxed/simple;
	bh=6JEQjmrMba8qZUKzmUxEKp4TUW/usegCC4+9HVUbFao=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SPj28ArKyJRHDuFdObE++XBabNeW5mwHkH5ji8lw3C3el6ql5EN6BkLrEhKG4H7LFbzOz65u7mwT4Z43E4SuM0oM0k9/fLlP7yvHSbgYnyZdfYYHbnaXBy1Tj/r5WSH+DAtpumuDJjUCm1b5bQjSepDxc1u+nAjhVF6oE//WOdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XjRaxjEN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741278122;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tqC+Llm1WJYyckYsZ/+upOpOsuMKvlE5dwDUUY8Zj7g=;
	b=XjRaxjENachI0bTbFsGudAXN9b9DzOfDCTbjgabTvGqFruyC/dzKWZIQZ+i1G4Zwl8O2Cw
	cYfrKzPtLe+rhYGxSWBxi53UzGLiZst61yFNPU+hMHF4Eyk4aP/1Yjl/3YvgfuCuTBOUEV
	fD6rwqeKcTHT362S1xuV0AMSbcx2h1Y=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668-RMVd3pBAMF2LTi2Hh0wwYg-1; Thu, 06 Mar 2025 11:22:01 -0500
X-MC-Unique: RMVd3pBAMF2LTi2Hh0wwYg-1
X-Mimecast-MFC-AGG-ID: RMVd3pBAMF2LTi2Hh0wwYg_1741278121
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-223f63b450eso16179745ad.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 06 Mar 2025 08:22:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741278121; x=1741882921;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tqC+Llm1WJYyckYsZ/+upOpOsuMKvlE5dwDUUY8Zj7g=;
        b=hIx1RheaUsHC0/kSqkt0LyIcATCAXSIA2hBdwqiMwNAgxekbcGzN5mpLUrG6Y9QzhN
         90xKcBnpwRzSRCDAemnStbZHPXsRMK09E3iWGzrguDBolmUIvD/HJSeJ6DYpTeNq0K64
         w7B2i0a0XYjznNlldH/L00uZAK0tlDPPXDQdCwawAuPIMOm4jl7WmdssJdhwOKzgnEx/
         +cAZi6B3bcTLMFgJmAIr78awNkEQDTf3zSCysXPu3Skrtej0PB5EM1WDAb99TA+CYzTL
         0X5HpQZSIU2wPmWPqP9F4lHcTf3/9aEBlWGfiZzagsQ/9W0BjYeH5vS6eb2UhGM8Wb6R
         3WeQ==
X-Forwarded-Encrypted: i=1; AJvYcCWs3vYcls+fNo/99MLNl5ir2Bg0XpdACZ6NRHkh8vY+0MMSEwv8rnvy9GWQyAmkh87r0VfF4dOT1UcMgKPa@vger.kernel.org
X-Gm-Message-State: AOJu0YwQatAO1R19GzE7DcULpUzeMotHLq4GjV+y+/Rb6DfCYRWAJcQ8
	iKngT8xbJoZeoyJrSa6s5sBNXv0WoPqPUJUNKgoTyMo4LOMhO4DunJvHiaImBgSbwqDEkTVbtOO
	bQ+PlUVPywqXexANyzv6KVG2h2qvk3YRqqJBPxC9Cm7ZE7Zn7Esoxug9cHlpPy90ynpYv7UtrwR
	1L3gy0bVlYJ7q4CmB1wrowS7dlTDaI14sTMK0oyA==
X-Gm-Gg: ASbGncuNtD7SqiXSP7gvdviZ6/NtXzP1H9xsEdOdvejBXiVLi8YGPZG0r8QgpaCwSp8
	C/bcZBdKzO0bhg31YKzPqobCAN0mgQoHaywEjPTTgz9o9wICw4p7cncb09S4HDxQDdAl2Z6eoeF
	H9MFjN95gV8US/2T6idxhAwDFHi9UTrCM=
X-Received: by 2002:a05:6a20:6a26:b0:1f0:e3cd:ffc0 with SMTP id adf61e73a8af0-1f544cad6dbmr117475637.38.1741278120571;
        Thu, 06 Mar 2025 08:22:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEBnNiZHiJ9P1cHLuxoqkZ0Gke5p5+vnyphXWaW76LGKMfyxbwfovLX3oXnrDS2K4RsAwjCEgRVZZSj048G2+4=
X-Received: by 2002:a05:6a20:6a26:b0:1f0:e3cd:ffc0 with SMTP id
 adf61e73a8af0-1f544cad6dbmr117431637.38.1741278120028; Thu, 06 Mar 2025
 08:22:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3989572.1734546794@warthog.procyon.org.uk> <4170997.1741192445@warthog.procyon.org.uk>
 <CAO8a2Sg2b2nW6S3ctS+H0F1Owt=rAkKCyjnFW3WoRSKYD-sSDQ@mail.gmail.com>
 <CACPzV1mpUUnxpKQFtDzd25NzwooQLyyzdRhxEsHKtt3qfh35mA@mail.gmail.com> <128444.1741270391@warthog.procyon.org.uk>
In-Reply-To: <128444.1741270391@warthog.procyon.org.uk>
From: Gregory Farnum <gfarnum@redhat.com>
Date: Thu, 6 Mar 2025 08:21:49 -0800
X-Gm-Features: AQ5f1JrunyMYAkh4fezKqE6Zg5EpuX-iNcyahs73zEQzWdI8lPNSFb7vn1fVr8Q
Message-ID: <CAJ4mKGZP2a8acd3Z7OT4UxJo-eygz30_V4Ouh05daMQ=pQv4aw@mail.gmail.com>
Subject: Re: Is EOLDSNAPC actually generated? -- Re: Ceph and Netfslib
To: David Howells <dhowells@redhat.com>
Cc: Venky Shankar <vshankar@redhat.com>, Alex Markuze <amarkuze@redhat.com>, 
	Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>, Ilya Dryomov <idryomov@gmail.com>, Xiubo Li <xiubli@redhat.com>, 
	Jeff Layton <jlayton@kernel.org>, ceph-devel@vger.kernel.org, netfs@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, Patrick Donnelly <pdonnell@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 6, 2025 at 6:13=E2=80=AFAM David Howells <dhowells@redhat.com> =
wrote:
>
> Venky Shankar <vshankar@redhat.com> wrote:
>
> > > That's a good point, though there is no code on the client that can
> > > generate this error, I'm not convinced that this error can't be
> > > received from the OSD or the MDS. I would rather some MDS experts
> > > chime in, before taking any drastic measures.
> >
> > The OSDs could possibly return this to the client, so I don't think it
> > can be done away with.
>
> Okay... but then I think ceph has a bug in that you're assuming that the =
error
> codes on the wire are consistent between arches as mentioned with Alex.  =
I
> think you need to interject a mapping table.

Without looking at the kernel code, Ceph in general wraps all error
codes to a defined arch-neutral endianness for the wire protocol and
unwraps them into the architecture-native format when decoding. Is
that not happening here? It should happen transparently as part of the
network decoding, so when I look in fs/ceph/file.c the usage seems
fine to me, and I see include/linux/ceph/decode.h is full of functions
that specify "le" and translating that to the cpu, so it seems fine.
And yes, the OSD can return EOLDSNAPC if the client is out of date
(and certain other conditions are true).
-Greg


