Return-Path: <linux-fsdevel+bounces-22462-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1175917583
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2024 03:22:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADFFA284CE9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2024 01:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96739E54D;
	Wed, 26 Jun 2024 01:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Cq4UFOYR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F44ABE58
	for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jun 2024 01:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719364920; cv=none; b=lrAeLJZyVme/xhGQPeVnFSVcjhYCbuU/avtz/p6frvjlo7UU30pnhUeMJ90JHyx6/ibrCuL5YtKVlIoMEShFUs8KNzcZgGpdOXThQHRLv7pm/k7unAIHUzkekXrlPyzHGXlvPx/tASs/MBHslNUMEmpqWaZfD4pL3YDKBpLsC68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719364920; c=relaxed/simple;
	bh=UFZ9PY+GDSA9BNrYdHIS8Xjr5b2tAoCZFEY+1AZ/7t0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FOlvI7jbTzToKLN3Qp8QPm6qxK/f6KzPnvnQW3Xc4b0XAd0sotYmJtpbDUvP0N/6iykdJP/i6p0fdzvf/fzCylE2fMkuEeAsR2t6/OH039/AvudOibzCSejJzkgfs8kYNBW2gFpx+SSN5Zx3KyfUUY8640mQ0kiuNcoKZa2fgc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Cq4UFOYR; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-57a16f4b8bfso4222a12.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Jun 2024 18:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719364917; x=1719969717; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MDXzXy/x3VAMGE4telAkJ0AkS3Dvfn3YkfUIsKfqDwQ=;
        b=Cq4UFOYRRbjF3YhMkezEuCi9aTT66KFSHhSkVCqq6mewoWNJ5XvvO1y7UVLheN/0oK
         LYTA46DU69qfprsn+2qPRo9oGrO8Km42cI5FSOK9ITQIuLWkh/9kSnAWjUCdQ9CXNyA/
         N5tjn7eFQ5nSn+6y13X7nC3yJyQVGKf3si52ZiInsEd4cWxTn6Q+70U1p7X8DoP1SW3v
         g6mx5DnMIYDoh49no2PatO1vn+FvQ67MkOW2jbMTbSvZ8P8DBkinzGnNaa8LrghUuD/B
         g1eHFpKxD8oS9wNUdZtWO3s9w1vaZ7ZfbQZIobv9+ca+OoCcpUpxBRK8Guf+ADEbIMcY
         er6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719364917; x=1719969717;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MDXzXy/x3VAMGE4telAkJ0AkS3Dvfn3YkfUIsKfqDwQ=;
        b=QJd7Csb8v5zPMD6j12BhKtoG9AQaxfQjGMiFwrWvx9bVtpXOMLHlCgc7oCdbIxUQUF
         Sg3guWw5taszWqeAxrNEjvYFqQ4c075wq7I8ouWoRDu5nWC1vKLY2B2L1jyOppKyAxw4
         DZJNKtE+xFDNPTzUk/GEZx3iZ5XY6OwRQGP/2Xc8KJiomT28PHw6cvJxF1t0ltcqlnz4
         tUlZr1KE114TOjrMxSHd56+eKq7w71dCmWVZsaPwADMpm3V7/ss4nnbNXxvecgZY2vtS
         4yhgLJOx5wIloMLWtNtQklh63nFeuF0X0rZqCGxsYB1PSLliRmpYuWsKr5WWfLMpjYlL
         hNGw==
X-Forwarded-Encrypted: i=1; AJvYcCX4oB0XUYhesnxgD6acdTu2QFbcr00RJA8FamTzGtWZdoMB1X9bx3YZreTnz8aLh6qo59vKDq5vmFLcJN0IoA5GRXnhvcvIqeOauvd5CQ==
X-Gm-Message-State: AOJu0YxF0BrijZo6ib/cxBedhuTQ0mslXZO1Oua7EjM1TEiLW4txWfjv
	cHL8t1/osN8Am6tTbpRS6QL6Z0rCZHI1zZcgoNT9hyt6pu8mOtnlWb5SGGcwn8qkwb9mkHdCzTT
	YQM+9BGN1E5SKzIg1TqN1umufX7M+nRGtM/Rn
X-Google-Smtp-Source: AGHT+IHX6Dw13lvp9tA5r1Nr3EDVBrqZjzt46+AZrMqkD9VDrFcqyfsc9zQwLVqS3nH7c8fc7LBij/O5GqbVZ/GRwBU=
X-Received: by 2002:a05:6402:350c:b0:582:f117:548e with SMTP id
 4fb4d7f45d1cf-5832c353bf0mr116598a12.0.1719364915083; Tue, 25 Jun 2024
 18:21:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240624232718.1154427-1-edliaw@google.com> <20240625135234.d52ef77c0d84cb19d37dc44f@linux-foundation.org>
 <f975fe76-92f4-4af0-a91d-0f3d8938f6b2@linuxfoundation.org> <CAG4es9V0XAqe-eqPgjU+sdRS00VOEr0Xda1Dv-gtfEvqsODjiw@mail.gmail.com>
In-Reply-To: <CAG4es9V0XAqe-eqPgjU+sdRS00VOEr0Xda1Dv-gtfEvqsODjiw@mail.gmail.com>
From: Edward Liaw <edliaw@google.com>
Date: Tue, 25 Jun 2024 18:21:27 -0700
Message-ID: <CAG4es9WHUSC7qm_6fJjQm5nM_iYEjXO75DWC8e5tzqc7fLEtfw@mail.gmail.com>
Subject: Re: [PATCH v6 00/13] Centralize _GNU_SOURCE definition into lib.mk
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kselftest@vger.kernel.org, 
	Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Darren Hart <dvhart@infradead.org>, 
	Davidlohr Bueso <dave@stgolabs.net>, =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Fenghua Yu <fenghua.yu@intel.com>, 
	Reinette Chatre <reinette.chatre@intel.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Jarkko Sakkinen <jarkko@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, 
	linux-kernel@vger.kernel.org, usama.anjum@collabora.com, seanjc@google.com, 
	kernel-team@android.com, linux-mm@kvack.org, iommu@lists.linux.dev, 
	kvm@vger.kernel.org, netdev@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-sgx@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 25, 2024 at 5:41=E2=80=AFPM Edward Liaw <edliaw@google.com> wro=
te:
>
> On Tue, Jun 25, 2024 at 4:34=E2=80=AFPM Shuah Khan <skhan@linuxfoundation=
.org> wrote:
> >
> > On 6/25/24 14:52, Andrew Morton wrote:
> > > On Mon, 24 Jun 2024 23:26:09 +0000 Edward Liaw <edliaw@google.com> wr=
ote:
> > >
> > >> Centralizes the definition of _GNU_SOURCE into lib.mk and addresses =
all
> > >> resulting macro redefinition warnings.
> > >>
> > >> These patches will need to be merged in one shot to avoid redefiniti=
on
> > >> warnings.
> > >
> > > Yes, please do this as a single patch and resend?
> >
> > Since the change is limited to makefiles and one source file
> > we can manage it with one patch.
> >
> > Please send single patch and I will apply to next and we can resolve
> > conflicts if any before the merge window rolls around.
>
> Sounds good, I sent:
> https://lore.kernel.org/linux-kselftest/20240625223454.1586259-1-edliaw@g=
oogle.com

I realized that in this v6 patch, I had accidentally sent it in the
middle of a rebase, so it's missing the last change to
selftests/tmpfs.  I've fixed it in v7.

>
> >
> > thanks,
> > -- Shuah

