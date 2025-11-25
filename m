Return-Path: <linux-fsdevel+bounces-69761-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E1BBFC8485F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Nov 2025 11:39:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BF7294E1326
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Nov 2025 10:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F17A30FF06;
	Tue, 25 Nov 2025 10:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UP9ll6OW";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="KWLTCLg8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100082DAFBB
	for <linux-fsdevel@vger.kernel.org>; Tue, 25 Nov 2025 10:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764067194; cv=none; b=byJBwHxVIzGqxvr5ZVRwylRDKiXAae0deAs3bS20zkBtFI1YC7T/XT5DyRhozK/LRRE16PGr/9+PkcNeIWmZs+Atl0+8A6o8RqwJaNj7si0e0lYstxHwSgQHs1iN2J9AUovWeq6k5EI8fqxPIEz/tRneIH++FnDmXkj/dXD52j4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764067194; c=relaxed/simple;
	bh=0XaJCLNQY4GylvIXCZ4CANBVcjoPnjp85qg8XXxlOa8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WsokjINMT6polW8FgGZS2tlUxDTscoIt+RgGVNv13DsWnAxk1lV0aSacc+weSVNcrAiMY9khas+fyeOmfpvqMjbP2eLrKTOOyHDRxS2zNzFQEvTApRQ2eHUH9CYIguBqpdD2HIPpYg2eyMQU2mD2X5BGPYYnqPGZIEQZ2ltHfcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UP9ll6OW; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=KWLTCLg8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764067192;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5iGMyrmhbLF1TEFnaXpMke+jhdfVLWB+vMdoSAJGCNc=;
	b=UP9ll6OWnGvU4WUm2JebNtWTcvg8req/pY5ijBd8sYQ/wEcoflViFDa2MxXps4twAzZfqx
	7v8yfAoZuyIGFeDeUzu2MMmIuw1KpdTeVTjdQVhsgyl1SY6H3NfcWfRrk8ucbT7D0xFkNx
	bW1zw0jq/aM+JvoruJSl8LiBmT1CibI=
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com
 [74.125.224.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-weB0-bxQPQa4PpATXybunw-1; Tue, 25 Nov 2025 05:39:46 -0500
X-MC-Unique: weB0-bxQPQa4PpATXybunw-1
X-Mimecast-MFC-AGG-ID: weB0-bxQPQa4PpATXybunw_1764067186
Received: by mail-yx1-f71.google.com with SMTP id 956f58d0204a3-63e08ae023cso11082503d50.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Nov 2025 02:39:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764067186; x=1764671986; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5iGMyrmhbLF1TEFnaXpMke+jhdfVLWB+vMdoSAJGCNc=;
        b=KWLTCLg8vaycmZHelB1ZI7gsupzmR81C/zBlNcV/M7n38qkYEGMo4SZrY8j1wWISSn
         TvUyCWvHRaW3OcRTumVRIKZOAroZVRmhOC+WHf+ppmvrt/mhdd/r9WAioFsMzU0+3Lk6
         xSrQBt/3BShFF3Ldhk5EqZfl+1jSVeuSJXEt09LvTpu3PCzTMkOOXTJ8fdTeDwUeM4tK
         UWJm/jwB6WedbKFWJmhv+fa6ECyv+ueDWAzhYGS0Zy9+9vvDbtkeALUiFtUf2W6zuIR/
         Y/mUzOjZkbCoL7fqZgYh6DhC+IAS5Z7EgNMbzBx1ILVjYnhGKqmmhtsijPJnPyr5Tosk
         AqHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764067186; x=1764671986;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5iGMyrmhbLF1TEFnaXpMke+jhdfVLWB+vMdoSAJGCNc=;
        b=grepuatXRkKcjWKK6pEnMso4Jbc2GvVDuEFDIkiOcVpLpCWXlvVBCWwv7Z40LQ5ZSY
         gNC9oOYwVYjtiy2T14VTiSLOPH0qzoeBepQKHZM8+151LycpPmCb0Gbboq6RBaqjJIfs
         ALICTeh2AkH6m6kvbY4fo1d8LSg7nLPD7yCa3wn+LZkhkd6i7JhW5eH7kKl5NoaRUC+U
         VjzZ4Wfd5mbx6qtejoJW7qfogvM5pha6w+GY89AXSvf0JjFupyiy0pawmAXBJOmp4rn6
         nRDcAIwlJilZaIIlD4Tv3VBWrknrWehxeXem0U0cnwT7uf/fFrTXUlOBZjjm3+5TNF+l
         WqqA==
X-Forwarded-Encrypted: i=1; AJvYcCX6NlmMfWe7MtOBkXNTfPJo3qZwweL33vKVLczfQA0iT7xjyimjF1IeKntUm4zKT0/mNIILidi+4Hq/fjHn@vger.kernel.org
X-Gm-Message-State: AOJu0YxnkdJSmIljq6qWblWtGHEWUoTLtUw8kv13brXRYuc4X4rnb5IG
	K9d1rkQ6hXEtIZMggMGAeyK0cV9HpSqsfYJ2RelHaftZ1wsCJBcBueHHW81OxL4FsWwGP6+6CQu
	zHlBdJFpyWgMJtydFTTqyflMCix72++cj0Aea/zvZg5hBHbLa3dP8ui21LgeP6sgYJmSBDSs1lL
	H4ZpZeckxiBqTeyq9HzuxMid/LIwwpOz0ViM9mGmvtiA==
X-Gm-Gg: ASbGnctgEz3uDX8OBrWxJVsTK5yZTFm8khWNRxMR03XT8c6+NCuvOpUgI+Aa/eZsyH+
	KBdEmfn/gDK+JR5k7TsY6oRpuykMKeV001jumb6chnTLx1JdXuNNh3jgeu5tYic0H8deczvYe8c
	tzyUU2i0qQKaHmUgpe9lV/flbZVjtgCdK9sYRYkQTaA0GACCMF893FtwJ7axyySLjl
X-Received: by 2002:a05:690e:429c:10b0:63f:96d7:a369 with SMTP id 956f58d0204a3-643026257f4mr10337770d50.28.1764067186078;
        Tue, 25 Nov 2025 02:39:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH86PxC7EfFxh6JezLUhyb35nRj9xb/GVBf1h/Caqow2tU682Eij12SKNc2bePwNa5qxTUuYIp1mKwjy2lqtEI=
X-Received: by 2002:a05:690e:429c:10b0:63f:96d7:a369 with SMTP id
 956f58d0204a3-643026257f4mr10337757d50.28.1764067185693; Tue, 25 Nov 2025
 02:39:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251010221737.1403539-1-mjguzik@gmail.com> <20251124174742.2939610-1-agruenba@redhat.com>
 <CAGudoHF4PNbJpc5uUDA02d=TD8gL2J4epn-+hhKhreou1dVX5g@mail.gmail.com>
 <CAHc6FU5aWPsv0ZfJAjLyziGjyem9SvWY2e+ZuKDhybOWS-roYQ@mail.gmail.com> <CAGudoHFSFy9KDAViEU8whypxsUN5+wXAi-Po6Tc1jw-yLE5PUg@mail.gmail.com>
In-Reply-To: <CAGudoHFSFy9KDAViEU8whypxsUN5+wXAi-Po6Tc1jw-yLE5PUg@mail.gmail.com>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Tue, 25 Nov 2025 11:39:34 +0100
X-Gm-Features: AWmQ_bngBxPRZPjz_HwnealLXlGB6Y1ARqiZ_Df3b4HzEgN4jgb1AQEJ5XZKpzM
Message-ID: <CAHc6FU4_anGQQWGkLtyOfjf0YvTrUuSYjiK87NSS3T4Xv9j5TQ@mail.gmail.com>
Subject: Re: [PATCH] fs: rework I_NEW handling to operate without fences
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 25, 2025 at 4:01=E2=80=AFAM Mateusz Guzik <mjguzik@gmail.com> w=
rote:
> On Tue, Nov 25, 2025 at 12:04=E2=80=AFAM Andreas Gruenbacher
> <agruenba@redhat.com> wrote:
> >
> > On Mon, Nov 24, 2025 at 8:25=E2=80=AFPM Mateusz Guzik <mjguzik@gmail.co=
m> wrote:
> > > On Mon, Nov 24, 2025 at 6:47=E2=80=AFPM Andreas Gruenbacher <agruenba=
@redhat.com> wrote:
> > > >
> > > > On Sat, Oct 11, 2025 at 12:17=E2=80=AFAM Mateusz Guzik <mjguzik@gma=
il.com> wrote:
> > > Was that always a thing? My grep for '!!' shows plenty of hits in the
> > > kernel tree and I'm pretty sure this was an established pratice.
> >
> > It depends on the data type. The non-not "operator" converts non-0
> > values into 1. For boolean values, that conversion is implicit. For
> > example,
> >
> >   !!0x100 =3D=3D 1
> >   (bool)0x100 =3D=3D 1
> >
> > but
> >
> >   (char)0x100 =3D=3D 0
> >
>
> I mean it was an established practice *specifically* for bools.
>
> Case in point from quick grep on the kernel:
> /* Internal helper functions to match cpu capability type */
> static bool
> cpucap_late_cpu_optional(const struct arm64_cpu_capabilities *cap)
> {
>         return !!(cap->type & ARM64_CPUCAP_OPTIONAL_FOR_LATE_CPU);
> }
>
> static bool
> cpucap_late_cpu_permitted(const struct arm64_cpu_capabilities *cap)
> {
>         return !!(cap->type & ARM64_CPUCAP_PERMITTED_FOR_LATE_CPU);
> }
>
> static bool
> cpucap_panic_on_conflict(const struct arm64_cpu_capabilities *cap)
> {
>         return !!(cap->type & ARM64_CPUCAP_PANIC_ON_CONFLICT);
> }
>
> I suspect the practice predates bool support in the C standard and
> people afterwards never found out.

Yes, often it's simply not needed anymore.

Andreas


