Return-Path: <linux-fsdevel+bounces-43714-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C9C9A5C355
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Mar 2025 15:11:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAA2C174BEA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Mar 2025 14:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62F8C25B68F;
	Tue, 11 Mar 2025 14:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RoGvcCZu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230CA1D63E2
	for <linux-fsdevel@vger.kernel.org>; Tue, 11 Mar 2025 14:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741702264; cv=none; b=Wkf4Fm4sKkPVqgvO5nkYT79oiyiodlIFsbyl6sGxGM5ZSIQTHjBnmabKTHMBu1LLeLqHcE1dVExECeeiPcX8S4yMlWf7JjYUJ4o0dnqwEjVzc6vWgowlsyzJ1+2MBdErkyOJHObJ6UC9wZqivDYhyykFDKmH9cij6kYkTaP/6bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741702264; c=relaxed/simple;
	bh=SAgeNbr9IRovlDJp8NvrudIcK+1LPRMAVQ2/y01X7K8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EGJbtHV4L4D+FvFmaH1IhILUlRn/vxg6J0JJN2r8x+8y5b7oJVKDmcjR41Pn0Xae799XmXOS36Mt2myNqqjMtJJjcmMArqvvWhFNXeeU6w9xytDT12KUMtfD/KNnBUe5vIMmq52/1xNCkOLDik+8gwnTfR9iL74L7dxlK08iz9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RoGvcCZu; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-abbd96bef64so893783866b.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Mar 2025 07:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741702261; x=1742307061; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SAgeNbr9IRovlDJp8NvrudIcK+1LPRMAVQ2/y01X7K8=;
        b=RoGvcCZuEXaORfDyEbFQdOozgWOjQF9CRenBPUrWegJNWmiO5+y6Kq1dWnuZTjY2xL
         OMf2ND+p3FfdLK7NBQY8aqiO5Y3CFlCgcvc6VZAHWZfwn0rG9ghQE19wBeu6SkviOC0s
         0G24PexweiRSD7aMsajXJBbaFBO/71qovVtyhu0Sg9lg1GxZMnHnBVyff76lnd10WsZZ
         J01/WMiyc+aWN+lJ4PKtJ1dKFefYXXClz9/y/qupLo86H/QEorpM35/NLlnfumbDk2uv
         w8EqKJ37wf8K1j2oLU7QKdaRqXg6CNJVXT5o2rP0Y/8PdueWBTrF3sdrtOObAHqBKHQw
         osjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741702261; x=1742307061;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SAgeNbr9IRovlDJp8NvrudIcK+1LPRMAVQ2/y01X7K8=;
        b=u3jm78NBkM+kaYJeXbw++gMUhS7NpPz1j35ENQ4bk71+sLxR07EI//946rBUhNbKZr
         wFlsFmO3vxeSb6DjR4ctL87dByLKV9zkrqOesO2NJQE+y60tS9svpPhsZvolqbsJje+H
         rEE+3UxKKX9YPMSWwcNJYrlWwTgvwLwfXtrM2cUPQMn2crLWxkZ3UHc2BHwnWytTitiy
         6K2+gDb9cTbY7O+ZbQ3U+cwS+eSRWRxW8tG4zlMboPZQ7kgce3bqLMHXEbXhVlqvlWYS
         CZ7H9LhE2U5cKmdkDeQQ7qSZ8GjVyrHeCBhwBSBXi9sdlzp2CdkA1MuedXy2Pog4TGDd
         aTlA==
X-Forwarded-Encrypted: i=1; AJvYcCWsjZS9jkus2VvKDi1IdXxChBvqbjEiYxOQQxZH4AaOYFYnzmkAXBegXqJBPv2lbfeIQqHyKbXwJJc8eWfy@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/aRoIx7DFA/kJqFQXRONLTeFHqOpzdVMKvV1rf9GNiA69dbfs
	JhJ8bjOxIDHcVNSyXUm68knGoLfgHGvKey2UZmGuyizrV+PQP77CQblY/RJjMaygu3mz7AguE5t
	mU+IKbO/dlvOXuY//QlCLVO8E6yY=
X-Gm-Gg: ASbGnct3X+OOWY1L3v/VLQyGkbQDAnIwJFabL+Zn3KrAgLtaUqbNtBZTg8XRekcrVKk
	z0RiPfnmJI5eIQM0SRqZAS0glOFoN6cSLkuOcpbWFgdDPFdjOZlC4kqD9K0gsKMZRtI8w/euy1b
	nqtmi3wy+v0Nj3ZYE79EoEiueWnsrSXaXLBcrM
X-Google-Smtp-Source: AGHT+IE13u28wsElV5uivrbQomaRVh1JCFLZw3+xJEgLr007Qb8OYoMfJ+ustOTigXaFZMk7/9Kl1d5qLGRDNUTTT70=
X-Received: by 2002:a17:907:9811:b0:ac1:fcda:78c1 with SMTP id
 a640c23a62f3a-ac2527193c1mr2193491166b.34.1741702260856; Tue, 11 Mar 2025
 07:11:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250311114153.1763176-1-amir73il@gmail.com> <20250311114153.1763176-3-amir73il@gmail.com>
 <f360f477-8671-4998-86bf-c134648b2c94@lucifer.local>
In-Reply-To: <f360f477-8671-4998-86bf-c134648b2c94@lucifer.local>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 11 Mar 2025 15:10:49 +0100
X-Gm-Features: AQ5f1JqBRCDvFBChCRi7Q1ABLW61dV6Zl4zg3IFcI_73_gPfhsdREIU4Gw30CAw
Message-ID: <CAOQ4uxhYVumjQMaxs8rAmmpCNu==F8YjL2wGU+iqcd1Zx0hDkw@mail.gmail.com>
Subject: Re: [PATCH 2/2] fsnotify: avoid pre-content events when faulting in
 user pages
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Jan Kara <jack@suse.cz>, Josef Bacik <josef@toxicpanda.com>, 
	Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 11, 2025 at 1:37=E2=80=AFPM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> On Tue, Mar 11, 2025 at 12:41:53PM +0100, Amir Goldstein wrote:
> > In the use case of buffered write whose input buffer is mmapped file on=
 a
> > filesystem with a pre-content mark, the prefaulting of the buffer can
> > happen under the filesystem freeze protection (obtained in vfs_write())
> > which breaks assumptions of pre-content hook and introduces potential
> > deadlock of HSM handler in userspace with filesystem freezing.
> >
> > Now that we have pre-content hooks at file mmap() time, disable the
> > pre-content event hooks on page fault to avoid the potential deadlock.
> >
> > Leave the code of pre-content hooks in page fault because we may want
> > to re-enable them on executables or user mapped files under certain
> > conditions after resolving the potential deadlocks.
> >
>
> Will leave the fs bits to fs people but not hugely comfortable with the
> concept of 'leaving code in place just in case'.
>
> Often things end up not being the case :)

Fair point.

It's not exactly a "just in case" situation - the existing user of
this code (Meta)
do use the page fault hooks, so I expect they will work on re-enabling
the hooks upstream after this release, but I am fine with reverting the pag=
e
fault hooks instead of the temporary disable if that is what everyone wants=
.

Thanks,
Amir.

