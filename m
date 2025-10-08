Return-Path: <linux-fsdevel+bounces-63616-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25A37BC6952
	for <lists+linux-fsdevel@lfdr.de>; Wed, 08 Oct 2025 22:27:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10F4D19E4EDD
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Oct 2025 20:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 273B429BDB8;
	Wed,  8 Oct 2025 20:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="R1TgEN3C"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E67E528C866
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 Oct 2025 20:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759955240; cv=none; b=ASaSpJUTF1WZdbdTQjtPDdbbE3NojhOb+X/Wo1b4RgBAOlL2T484ht8LUzNZcnl/QfFnc2hUMCasTChOE1G2vNDPoxk0A0xOqeV576TWERoQ6hnofOacLPmFgfCMrFcV9WD/bMert8ZjuJbAnfFlvGW1/vlSD5S3qk84qmmu0kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759955240; c=relaxed/simple;
	bh=1gtRIhdakY3OUEjKqsiJpOl5NeDvVJOe2kSkjt8sPNk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VUMapJ/EnIHqXp0fP1S2gZaXpCRVz78jH7R9v4RtAn6jlFMO2J/tYuyeHxSaZ8u09XcRgbOpQzwv5fJVQvDah68PIkqT2LLQfksdYikwkOJ9rnJxC9AvEs6c/MVCxMKviWLLkFEPyoIQGStpRzAdidfuYh91+bQTypuErcJAmz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=R1TgEN3C; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4d7b4b3c06dso1193261cf.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Oct 2025 13:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1759955238; x=1760560038; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ft9wlTfMhhvdI9XX1KOPoXEFZYD/S9J3oHik50ZJpxk=;
        b=R1TgEN3CbE90WuWghWglGAg8iNOFZdwdWcP/F0GngakMcbbNRxAVhgeWKr+RkMrS57
         JaSQ5ow2EoIj6Ua4XkWlGg4FU8fcH/X9mstI6T3p3Pw0udOWvqooZyDHmgmKMoJhnVnC
         WSb+Br8Gh38ugKIAPbVKHmUEgvvlE379xrG7NDfl9VHgdzZP41p/ibUGp5fCrk+Kc817
         MDUoFi8J8KcBafWorhZDuDD6mfdexp2jpGtl7moAqDqYnQaPZWnqeP9g61iSmxBKVksM
         uWB71RhkhTBPLf2tNB6rcFsXRToVXZGRa8GJ4ND308tix2MIuo8Era54RcyGoYEvw0UZ
         cVMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759955238; x=1760560038;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ft9wlTfMhhvdI9XX1KOPoXEFZYD/S9J3oHik50ZJpxk=;
        b=TOb2E6ZH1tjHxWhPXim02fwq5vlD4INOe1xJhirLDo7jKxhQNLxwu9whQKNzAE2kS2
         fztloFzsGktI7KMDx++lsCGQMqfGTutFAfRnJvo1a6KjLkrJaYLYN4B6GLabRdh1QzTI
         rTtSP3x26c9PUJU4fOeZpQpAUiwJZ0ZC2b8Tcyp4bGcc47jEzObUHZ+sqU1QdrJH/LFM
         7ZliZqlqb9auVsdfYi5DVzUfvkOOJ8gQYYkhthDFKzXIZXCooSaxMXhYQGJzWyr3ftNB
         MHqPecCIRZmex/EjewkdXJ9RYFceWP99rVnuQmkz1vpTRrf/SAvAjQlmZ09k2psBNGFy
         +BRA==
X-Forwarded-Encrypted: i=1; AJvYcCUVjR5QWpiPYcmZRaX+Rw08V+1JnaobLtnQSAFoPaFcr/EkJkIzlDgejLKxbeQ2eLZLVbJjsGfeOI7kHAxq@vger.kernel.org
X-Gm-Message-State: AOJu0YxUTppaxlPq0e0JFuThlgttHdRlh0JPri0b/6ZlNlQ75bGuqobD
	sudC4mbbRHjjCoPysNNSXVxJOFM8ub0Ye6V5BYFahrCdv0+1Cin1Kb1BiZ+H1kh+f541Tw5+aUK
	5XduNGtTvhNkNnqQ0URXASt6q6wV3+i36u3Ow3ZwQDQ==
X-Gm-Gg: ASbGncsNmmo44FaG8ntWkon/JzuOoiqOknv7NuTzMWx2HWuewFTAsHGLfoPM3mKSp5P
	XHMEnLIWF2LoewVuFcq8QFGM9aTH1sPGF8CSpmaU7KjN/af6+o/KUL1oyNLkFuq88wo0bqNl+IC
	3tHv6vwi95wYSfap5H/KHnGJ943ZXed/XzA3I5R7Ax2atRa0ZIZbANRTuVQ9cBc6Z7icbJKJdiD
	zdA0rTGb8ayCFUBLGlt2wvbDKYG
X-Google-Smtp-Source: AGHT+IGAPqmJcgL16UIg0d4+RNt3XKw0htJPMbSHIFhskDVjDGNvAxn7Z6jrk84cREgUa1kvsB4Hz5CuCuJTQ1VRagg=
X-Received: by 2002:ac8:5e4d:0:b0:4e5:6c5e:430a with SMTP id
 d75a77b69052e-4e6ead671a1mr74767911cf.64.1759955237650; Wed, 08 Oct 2025
 13:27:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250929010321.3462457-1-pasha.tatashin@soleen.com>
 <CA+CK2bB+RdapsozPHe84MP4NVSPLo6vje5hji5MKSg8L6ViAbw@mail.gmail.com>
 <CAAywjhSP=ugnSJOHPGmTUPGh82wt+qnaqZAqo99EfhF-XHD5Sg@mail.gmail.com>
 <CA+CK2bAG+YAS7oSpdrZYDK0LU2mhfRuj2qTJtT-Hn8FLUbt=Dw@mail.gmail.com> <20251008193551.GA3839422@nvidia.com>
In-Reply-To: <20251008193551.GA3839422@nvidia.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Wed, 8 Oct 2025 16:26:39 -0400
X-Gm-Features: AS18NWDStUB3aziIoEu9unN2oxgQKkUZyxSI_-rUVqTnIsSkLapICWThr2gCAYY
Message-ID: <CA+CK2bDs1JsRCNFXkdUhdu5V-KMJXVTgETSHPvCtXKjkpD79Sw@mail.gmail.com>
Subject: Re: [PATCH v4 00/30] Live Update Orchestrator
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Samiullah Khawaja <skhawaja@google.com>, pratyush@kernel.org, jasonmiu@google.com, 
	graf@amazon.com, changyuanl@google.com, rppt@kernel.org, dmatlack@google.com, 
	rientjes@google.com, corbet@lwn.net, rdunlap@infradead.org, 
	ilpo.jarvinen@linux.intel.com, kanie@linux.alibaba.com, ojeda@kernel.org, 
	aliceryhl@google.com, masahiroy@kernel.org, akpm@linux-foundation.org, 
	tj@kernel.org, yoann.congal@smile.fr, mmaurer@google.com, 
	roman.gushchin@linux.dev, chenridong@huawei.com, axboe@kernel.dk, 
	mark.rutland@arm.com, jannh@google.com, vincent.guittot@linaro.org, 
	hannes@cmpxchg.org, dan.j.williams@intel.com, david@redhat.com, 
	joel.granados@kernel.org, rostedt@goodmis.org, anna.schumaker@oracle.com, 
	song@kernel.org, zhangguopeng@kylinos.cn, linux@weissschuh.net, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, 
	gregkh@linuxfoundation.org, tglx@linutronix.de, mingo@redhat.com, 
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	rafael@kernel.org, dakr@kernel.org, bartosz.golaszewski@linaro.org, 
	cw00.choi@samsung.com, myungjoo.ham@samsung.com, yesanishhere@gmail.com, 
	Jonathan.Cameron@huawei.com, quic_zijuhu@quicinc.com, 
	aleksander.lobakin@intel.com, ira.weiny@intel.com, 
	andriy.shevchenko@linux.intel.com, leon@kernel.org, lukas@wunner.de, 
	bhelgaas@google.com, wagi@kernel.org, djeffery@redhat.com, 
	stuart.w.hayes@gmail.com, ptyadav@amazon.de, lennart@poettering.net, 
	brauner@kernel.org, linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	saeedm@nvidia.com, ajayachandra@nvidia.com, parav@nvidia.com, 
	leonro@nvidia.com, witu@nvidia.com, hughd@google.com, chrisl@kernel.org, 
	steven.sistare@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 8, 2025 at 3:36=E2=80=AFPM Jason Gunthorpe <jgg@nvidia.com> wro=
te:
>
> On Wed, Oct 08, 2025 at 12:40:34PM -0400, Pasha Tatashin wrote:
> > 1. Ordered Un-preservation
> > The un-preservation of file descriptors must also be ordered and must
> > occur in the reverse order of preservation. For example, if a user
> > preserves a memfd first and then an iommufd that depends on it, the
> > iommufd must be un-preserved before the memfd when the session is
> > closed or the FDs are explicitly un-preserved.
>
> Why?
>
> I imagined the first to unpreserve would restore the struct file * -
> that would satisfy the order.

In my description, "un-preserve" refers to the action of canceling a
preservation request in the outgoing kernel, before kexec ever
happens. It's the pre-reboot counterpart to the PRESERVE_FD ioctl,
used when a user decides not to go through with the live update for a
specific FD.

The terminology I am using:
preserve: Put FD into LUO in the outgoing kernel
unpreserve: Remove FD from LUO from the outgoing kernel
retrieve: Restore FD and return it to user in the next kernel

For the retrieval part, we are going to be using FIFO order, the same
as preserve.

> The ioctl version that is to get back a FD would recover the struct
> file and fd_install it.
>
> Meaning preserve side is retaining a database of labels to restored
> struct file *'s.
>
> As discussed unpreserve a FD does not imply unfreeze, which is the
> opposite of how preserver works.
>
> > 2. New API to Check Preservation Status
> > A new LUO API will be needed to check if a struct file is already
> > preserved within a session. This is needed for dependency validation.
> > The proposed function would look like this:
>
> This doesn't seem right, the API should be more like 'luo get
> serialization handle for this file *'

How about:

int liveupdate_find_token(struct liveupdate_session *session,
                          struct file *file, u64 *token);

And if needed:
int liveupdate_find_file(struct liveupdate_session *session,
                         u64 token, struct file **file);

Return: 0 on success, or -ENOENT if the file is not preserved.

Pasha

