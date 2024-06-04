Return-Path: <linux-fsdevel+bounces-20922-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 637E68FAD0B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 10:03:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA5A0B21480
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 08:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE9C11419A9;
	Tue,  4 Jun 2024 08:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="jjIJwl4R"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5BEB142E61
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Jun 2024 08:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717488162; cv=none; b=AWSPBICxODFAABlHRe6SY4BFsHaTJG6p4//gaYHP/V8kEl39ZKjm6d2pLzpshTc2j1GFRkwYmszujYONja9VB8Ill/S4oAUxigOn2+Gj8T7kZRSXFBdtgcuZ02olIYgD1bx26AZXA57Divh4QG6ZqD9+asQQL5D6+Ef/4ntgtp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717488162; c=relaxed/simple;
	bh=ydW56PzluKWgcPSKukxF7UDGObejUYK6H6Hy1neKvYY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fTYbfGe0mEUarFhF8C6SIzH5DfU52S988OlI0Avdg7r0fW6+Ji1se32BcfLW6Dtz8KjpNstJ2sSumRhXHhHIlcjTqphcPOd76ZMn1kOy9yalTWWrsRenrriMK+JAvhI6sX5JchC95U702/+UH+ydCYLSeqP33MRIAqve8nsv90Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=jjIJwl4R; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-52b98fb5c32so2768345e87.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Jun 2024 01:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1717488158; x=1718092958; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pl2Hglw606KlgDBUaavgQPdiC9MzZDauPWAbRuFDlKw=;
        b=jjIJwl4RcX9sghXl7x54v596ZoCSYP8EF9WjSATuQbjQ5CKNGNikoBK9hs63wVr3/p
         uIIMo1sVtcDGCFBLOH72Nubh7Klv6F6SPt+Dl8kTLANOEFuKGWUSgw4pViDpV1ZJlbDx
         R0AR/RwvlsK9jKBLlMbloU0fO+AwpJseAG5Bw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717488158; x=1718092958;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pl2Hglw606KlgDBUaavgQPdiC9MzZDauPWAbRuFDlKw=;
        b=jF75jliXTLFaRYFepnSeGsS5JVjMnx9s5INStciPiG6Ep7WKqwsg6sfDgqQ85jZM2t
         XXl37wER0vbu6BQXlne2qxE5+b+l0+BRVAL5Anlo6epE86KJbCkPIHWddc/7nsMvjggh
         f/DaTVZA09rFak/jJTynH3/WXBPRVD8ObZytuTGUC8BhmeWkxamRJj2mml7Gdrrs7Mm8
         5eIAFuFblzTeb0sJ4ziIP+Vud75Jb5ze9UaqOyS25eTYYK59YcRyzf8Bc7bVy+54T11a
         IastdLcEBIDaakfqPo04DO2ii1eF9oI+K5aBz2Wgcj6NifwwM5KaOn9WAxr+XpO8+zwV
         QdTg==
X-Forwarded-Encrypted: i=1; AJvYcCWIuxZ8aoksvduI56vFWsyBUY76r3T8Zz8j9Qo1Ws8dsatyfZaJdkFJN48TYBalE0u7L9RgnCgVYxBRspBbk5sR93MJ+tIBaoFExaHCEA==
X-Gm-Message-State: AOJu0YxItNKzYy2PfL7on7hM+hR3CWKKoZJr186MgzU5Q09eE6642GzX
	eq/2idf5y064cgxnpeiZT/jaB9Qw+ofWICsrYGZh5j6TeSyMxlYoaOVBUIYxfx6gIX898YSHykl
	LoCLCXm0Y50ib4j73zyGHnCoVI01tvh9R1s/nnA==
X-Google-Smtp-Source: AGHT+IEPelug+UmeuJqbrHG9tmKC1riKOZH4vA8O545Sh3JVlejgXDR2o6c3TGLIXiXayqZdAErYV1fLwDpcwdWqEu4=
X-Received: by 2002:a05:6512:2e7:b0:52b:90f5:494c with SMTP id
 2adb3069b0e04-52b90f54aa8mr6341929e87.43.1717488157694; Tue, 04 Jun 2024
 01:02:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <SI2PR06MB53852C83901A0DDE55624063FFF32@SI2PR06MB5385.apcprd06.prod.outlook.com>
 <b55cb50b3ecf8d6132f8633ce346b6adc159b38c.camel@nvidia.com>
 <CAJfpegsppbYbbLaECO+K2xpg8v0XZaQKFRZRTj=gJc9p7swdvQ@mail.gmail.com>
 <bbf427150d16122da9dd2a8ebec0ab1c9a758b56.camel@nvidia.com>
 <CAJfpegshNFmJ-LVfRQW0YxNyWGyMMOmzLAoH65DLg4JxwBYyAA@mail.gmail.com>
 <20240603134427.GA1680150@fedora.redhat.com> <CAOssrKfw4MKbGu=dXAdT=R3_2RX6uGUUVS+NEZp0fcfiNwyDWw@mail.gmail.com>
 <20240603152801.GA1688749@fedora.redhat.com>
In-Reply-To: <20240603152801.GA1688749@fedora.redhat.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 4 Jun 2024 10:02:26 +0200
Message-ID: <CAJfpegsr7hW1ryaZXFbA+njQQyoXgQ_H-wX-13n=YF86Bs7LxA@mail.gmail.com>
Subject: Re: Addressing architectural differences between FUSE driver and fs -
 Re: virtio-fs tests between host(x86) and dpu(arm64)
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Miklos Szeredi <mszeredi@redhat.com>, Peter-Jan Gootzen <pgootzen@nvidia.com>, 
	Idan Zach <izach@nvidia.com>, Yoray Zack <yorayz@nvidia.com>, 
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>, Parav Pandit <parav@nvidia.com>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"bin.yang@jaguarmicro.com" <bin.yang@jaguarmicro.com>, Max Gurtovoy <mgurtovoy@nvidia.com>, 
	Eliav Bar-Ilan <eliavb@nvidia.com>, "mst@redhat.com" <mst@redhat.com>, 
	"lege.wang@jaguarmicro.com" <lege.wang@jaguarmicro.com>, Oren Duer <oren@nvidia.com>, 
	"angus.chen@jaguarmicro.com" <angus.chen@jaguarmicro.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 3 Jun 2024 at 17:28, Stefan Hajnoczi <stefanha@redhat.com> wrote:
>
> On Mon, Jun 03, 2024 at 04:56:14PM +0200, Miklos Szeredi wrote:
> > On Mon, Jun 3, 2024 at 3:44=E2=80=AFPM Stefan Hajnoczi <stefanha@redhat=
.com> wrote:
> > >
> > > On Mon, Jun 03, 2024 at 11:06:19AM +0200, Miklos Szeredi wrote:
> > > > On Mon, 3 Jun 2024 at 10:53, Peter-Jan Gootzen <pgootzen@nvidia.com=
> wrote:
> > > >
> > > > > We also considered this idea, it would kind of be like locking FU=
SE into
> > > > > being x86. However I think this is not backwards compatible. Curr=
ently
> > > > > an ARM64 client and ARM64 server work just fine. But making such =
a
> > > > > change would break if the client has the new driver version and t=
he
> > > > > server is not updated to know that it should interpret x86 specif=
ically.
> > > >
> > > > This would need to be negotiated, of course.
> > > >
> > > > But it's certainly simpler to just indicate the client arch in the
> > > > INIT request.   Let's go with that for now.
> > >
> > > In the long term it would be cleanest to choose a single canonical
> > > format instead of requiring drivers and devices to implement many
> > > arch-specific formats. I liked the single canonical format idea you
> > > suggested.
> > >
> > > My only concern is whether there are more commands/fields in FUSE tha=
t
> > > operate in an arch-specific way (e.g. ioctl)? If there really are par=
ts
> > > that need to be arch-specific, then it might be necessary to negotiat=
e
> > > an architecture after all.
> >
> > How about something like this:
> >
> >  - by default fall back to no translation for backward compatibility
> >  - server may request matching by sending its own arch identifier in
> > fuse_init_in
> >  - client sends back its arch identifier in fuse_init_out
> >  - client also sends back a flag indicating whether it will transform
> > to canonical or not
> >
> > This means the client does not have to implement translation for every
> > architecture, only ones which are frequently used as guest.  The
> > server may opt to implement its own translation if it's lacking in the
> > client, or it can just fail.
>
> From the client perspective:
>
> 1. Do not negotiate arch in fuse_init_out - hopefully client and server
>    know what they are doing :). This is the current behavior.
> 2. Reply to fuse_init_in with server's arch in fuse_init_out - client
>    translates according to server's arch.
> 3. Reply to fuse_init_in with canonical flag set in fuse_init_out -
>    client and server use canonical format.
>
> From the server perspective:
>
> 1. Client does not negotiate arch - the current behavior (good luck!).
> 2. Arch received in fuse_init_out from client - must be equal to
>    server's arch since there is no way for the server to reject the
>    arch.
> 3. Canonical flag received in fuse_init_out from client - client and
>    server use canonical format.

Yeah, something like that (I got the direction of the negotiation wrong).

See below patch.

I'm thinking that fuse_init_out need not even have the server arch,
since the client will only be translating to the canonical arch.  The
client sends its own arch in fuse_init_in.arch_id and advertises with
FUSE_CANON_ARCH set in fuse_init_in.flags whether it supports
transforming to canonical.  If the server wants canonicalization, then
it responds with FUSE_CANON_ARCH set in fuse_init_out.flags.

This works for legacy server that doesn't interpret the new flag and
field, and also for legacy client that doesn't set either (zero
arch_id means: unknown architecture).

arch_id could be a hash of the arch name, so that the fuse header file
doesn't need to be updated whenever a new architecture is added.

Thanks,
Miklos

diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index d08b99d60f6f..c63d8bab2d37 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -421,6 +421,7 @@ struct fuse_file_lock {
  * FUSE_NO_EXPORT_SUPPORT: explicitly disable export support
  * FUSE_HAS_RESEND: kernel supports resending pending requests, and
the high bit
  * FUSE_NO_EXPORT_SUPPORT: explicitly disable export support
  * FUSE_HAS_RESEND: kernel supports resending pending requests, and
the high bit
  *                 of the request ID indicates resend requests
+ * FUSE_CANON_ARCH: translate arch specific constants to canonical
  */
 #define FUSE_ASYNC_READ                (1 << 0)
 #define FUSE_POSIX_LOCKS       (1 << 1)
@@ -463,6 +464,7 @@ struct fuse_file_lock {
 #define FUSE_PASSTHROUGH       (1ULL << 37)
 #define FUSE_NO_EXPORT_SUPPORT (1ULL << 38)
 #define FUSE_HAS_RESEND                (1ULL << 39)
+#define FUSE_CANON_ARCH                (1ULL << 40)

 /* Obsolete alias for FUSE_DIRECT_IO_ALLOW_MMAP */
 #define FUSE_DIRECT_IO_RELAX   FUSE_DIRECT_IO_ALLOW_MMAP
@@ -874,7 +876,8 @@ struct fuse_init_in {
        uint32_t        max_readahead;
        uint32_t        flags;
        uint32_t        flags2;
-       uint32_t        unused[11];
+       uint32_t        arch_id;
+       uint32_t        unused[10];
 };

 #define FUSE_COMPAT_INIT_OUT_SIZE 8

