Return-Path: <linux-fsdevel+bounces-71671-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A0649CCC78F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Dec 2025 16:31:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 13EF630CAC88
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Dec 2025 15:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A3EE345CD2;
	Thu, 18 Dec 2025 15:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IdQPFvDY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21BB534402C
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Dec 2025 15:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766071056; cv=none; b=TehXDc6WdzMyyMDt7kAiKrW1y49genquhaZYhyQuaCTcedBkq1BV9j+SRgWWHdATP+/K+B1mAQPhJdWRI8pvzn/rS3NrFFSL0CPSv9s6zxDE8syJZ1E6cKPsEqKgwxI1z77zAGI/DOAznA9GatQ5sH8+H990Xuc3gIbYHYKfXH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766071056; c=relaxed/simple;
	bh=wiQaayGqV6R38Tz/VLdb3rRA8ZnWrvRCRpcP9/jPE68=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LBUwbOppU9BWok+nl7Lsz1uWq1+maTqmIL4QXg0X2CCP2Sw0UaVsyuFM5t9et7gqRBu43HfIKxm8a1L/rK1aA3Bu8W+rpH9E+ld/l0MyAzFed8hsT2eY4krMR0Jk40h44RDebeXMYrr01/ffsrwy2Lk7Vi8caYdYc5zlKZGuX0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IdQPFvDY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E9F7C4CEFB
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Dec 2025 15:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766071055;
	bh=wiQaayGqV6R38Tz/VLdb3rRA8ZnWrvRCRpcP9/jPE68=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=IdQPFvDYI5CH7/mSuUv1lxEOOFlD7P9TC/gqDERynpBqhJBKPPzfQEJdb2tbvecKK
	 6WD6Fx4j1fKLuR9XdSknDb/r+62Tm7S0qOKo5hZVZsGvhnFeIFdHLdtlV8yP0p5UVu
	 KqNIh+EmM27nIIBBH/dkHzrHsJ0Ig8EgCEzR+XKi+VOMR1X97ETSAUKgRrmhm7Xll+
	 TPDVxEs/aj9uYyR+kQaFCxHZnj+eQg4GqNa6hLO3zsoRps4haBTeL3f/QfQKlSfszs
	 J0/eqtZ2tqHSDKcmx5sP/1+hoyTc/vjNTPaZu9Q9Bk7pBWGGycudq0p1+3OY9jWLgC
	 x2aDCqlRoutTA==
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b7ffa421f1bso322889266b.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Dec 2025 07:17:35 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXIWPY/M7MqU2llwFsg//wCV2tHwIU6mJb6xTw0XTyU/iyjd8D+/2TxWceNNWD6W2m7ZUI5RpaXPI1Ch84Y@vger.kernel.org
X-Gm-Message-State: AOJu0YxCKxym0AXdq0gexYgvY+7c8i0IupJ8zTEA1XU/y8jvxkev2PUn
	uDB6cu63+Asq48u1+Xnm/nvdQuXzHKkkUIzkWiIrnFqfOgInhqL6V3Dsux1oHskmpMMmKj5k0Z3
	ksZ8TSspbXbeXdo35Kxm0KFOyos3y12A=
X-Google-Smtp-Source: AGHT+IFtGcuOep+jKQD/k1z01d9sAmC6HG3VaUnfceAOvl0dHhDVM8Ca+5LZGkSHRIpF0xfLmjuSIV5QBHqNYKY37zo=
X-Received: by 2002:a17:907:3e12:b0:b7d:27dd:9a54 with SMTP id
 a640c23a62f3a-b8020634a93mr383586866b.31.1766071054068; Thu, 18 Dec 2025
 07:17:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251201225732.1520128-1-dhowells@redhat.com> <20251201225732.1520128-2-dhowells@redhat.com>
 <CAKYAXd9Ju4MFkkH5Jxfi1mO0AWEr=R35M3vQ_Xa7Yw34JoNZ0A@mail.gmail.com> <611045.1766064976@warthog.procyon.org.uk>
In-Reply-To: <611045.1766064976@warthog.procyon.org.uk>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Fri, 19 Dec 2025 00:17:22 +0900
X-Gmail-Original-Message-ID: <CAKYAXd8r1j9Z_yV2EHyUJ-yN+Z4U5s6jNqni97SY0U+D8YpMVw@mail.gmail.com>
X-Gm-Features: AQt7F2pS84S-3B8FBwyVSpBfwG6J7RVNHTbpgdtOqDmfedWyD4ctvYVJJCzjZo4
Message-ID: <CAKYAXd8r1j9Z_yV2EHyUJ-yN+Z4U5s6jNqni97SY0U+D8YpMVw@mail.gmail.com>
Subject: Re: [PATCH v6 1/9] cifs: Remove the RFC1002 header from smb_hdr
To: David Howells <dhowells@redhat.com>
Cc: Steve French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.org>, 
	Shyam Prasad N <sprasad@microsoft.com>, Stefan Metzmacher <metze@samba.org>, Tom Talpey <tom@talpey.com>, 
	linux-cifs@vger.kernel.org, netfs@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 18, 2025 at 10:36=E2=80=AFPM David Howells <dhowells@redhat.com=
> wrote:
>
> Namjae Jeon <linkinjeon@kernel.org> wrote:
>
> > Why did you only change smb client after changing smb_hdr structure in
> > smb/common?  smb server also uses smb_hdr structure to handle smb1 nego=
tiate
> > request.
>
> Apologies, but I was under the impression from Steve that ksmbd didn't su=
pport
> SMB1 and was never going to.  Further, I'm pretty certain I have been bui=
lding
> the server and it hasn't shown up any errors - and Steve hasn't mentioned=
 any
> either.
ksmbd needs to handle SMB1 requests to support auto-negotiation. This
process is triggered specifically during connections with Windows
clients, So it cannot be tested using cifs.ko. And this patch will
break the connection between ksmbd and Windows.
>
> > Also, Why didn't you cc me on the patch that updates smb/common?
>
> You're not mentioned in the MAINTAINERS record for CIFS.  I did, however,=
 send
> it to the linux-cifs mailing list six times, though.
I cannot afford to review all cifs patches. Since this patch changes
smb/common, I think that the patch prefix should not have been 'cifs'.
That is likely why I missed it. Furthermore, smb/common is explicitly
listed under the ksmbd entry in the MAINTAINERS file. Maybe I should
be added as a reviewer for the cifs entry...
>
> David
>
>

