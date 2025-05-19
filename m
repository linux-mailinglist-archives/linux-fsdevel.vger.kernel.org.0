Return-Path: <linux-fsdevel+bounces-49328-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A5B7DABB516
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 08:28:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F3DF18943E5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 06:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 898FE245027;
	Mon, 19 May 2025 06:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f+VhVPnu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E666244E8C;
	Mon, 19 May 2025 06:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747636080; cv=none; b=qWKpL/5/lQmMGV4s4i1cxxE8CrnpnmKk/78ANouTsROT4VOcYkYWqAas7SARTGMyb3FMn3dYHnW2sA61qotrblFGWFJsaYtTHUWCZqwHD7JATzaaT1PcwU3T/QJPHlITNT58MrVTt6n+fBEAF7Om8OdLviw2ZTU99Wd30tTlbcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747636080; c=relaxed/simple;
	bh=hwm8WBOYDHtDa9VLp9WuAR1DlNYMdyOk8vi1d//7JHA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rHGj10L7/Gu5ll4Ol9HMkd/XJ5ORiCS3HVnMj4b3mmEIkWKK0+Xv1v+rrLCPX8mvRmlvgGyzD1PAQGsitkayczzy1mSSB0rrGPPkc3mP4HJ1638xAfWQ7K/6++dRFUNvensxgFy2S+Sn+vMG9c6rX0PExY9gc28jRs+mo2la4MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f+VhVPnu; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-601f278369bso578670a12.1;
        Sun, 18 May 2025 23:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747636076; x=1748240876; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pXsyUMIQ0XIOxEd0HgUN3xKydqhCFVjspZ5Sh+H499A=;
        b=f+VhVPnummHbpNX+xL4dpxie8Z5TmgD9P8uxm4NaNfbYtx3uU/zAbNFACGXar7jf75
         9lFJGQbQZe1CR8vPg+0jS4RoBRC7mXE4lxRTS+Y5lPCtM5SDAI8YvtIWlore588a2IHC
         oloKIyALwfZKr4J2dRfTLGTaA4RRqiHam85c4r6uR/ZILgt0mP83EC0WTolOiWP1Ijbs
         +PEMKw0L/ivOuY/2B3G3dMMS2skkYYT6mhlHGvlycMz2jFRBB45JMRPk6nez8DE9rreJ
         RURMLVAZFlZZ1r92HQbinpnqSRQVZa0qap46n3BXejvKFv1e4pLWpmPJdnCcAXkZKsr9
         n7Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747636076; x=1748240876;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pXsyUMIQ0XIOxEd0HgUN3xKydqhCFVjspZ5Sh+H499A=;
        b=TlYezZTb4eIk1sFJDdBufso8Zy5y0gGsOD7UfqgWh76MXSYUOuubIsnFbuKnQS2LCx
         UvJix+Bf6lKrGhg0nuHzqSNvz+ZyzlF/nk+yWpJ6rETGQ5GvJTcJQVmavGTur2ZTxXI/
         MwFLZA5DXCdsvAjtv6eaqp9ALjugUefMAzCpqkHd1cofVG9aDqVi/dsJHgYoSZV0LDaa
         FcchSKbgwqoil/WdaWWFrcr6d4WFkDCf+uViazmXRItmXPgWOLezvWYqmhQWn0TYgPbJ
         P5rME5QdYR9s03nNMWh3rmB/fsnf8GkXAwRGEV+vrY0HRXBHSgsL2SjePY0d8jtu8WL/
         ranQ==
X-Forwarded-Encrypted: i=1; AJvYcCW3ddJi6wzjvJXKogdXrdTWiEnveXnGmC0v0SoHKh1G0mYwMfxsrtWFW5fxv4N1rqRpIGoSKNEfv8F8ldaXUBMY@vger.kernel.org, AJvYcCWd1oR05C2oI+HdKY2LBVG7P3LXYLnK0NoeuFjiQCiMQSUS2/c9Xm3R9IdgSCO80cNEo5djShXc2V43967t@vger.kernel.org, AJvYcCWkdQi0C4INOJJWnI9gOknYgW3oUcDQXMCVB6JzMRovgU9L0QQH/Ygi32YO95Kx4MfQZ4D5aI2aoXOE7Xwj@vger.kernel.org
X-Gm-Message-State: AOJu0YxuhKJiu/JqmKp2t6UOndTRzEWAKQoac5arRtId0n0ua/NPUQMx
	WNyZ/7pOqYCdVyW3BsLBEaEcRRCWkJ3NevOPxaEJOx6+3ou8h90Y4xP0ZYCmLEpN/QllUrBNbIO
	Odn20o7GV2XSDX7x3kPPu91GHeAhBHflrQNdUQSpHKW+s
X-Gm-Gg: ASbGnctN4BRDoCJ55P5ieoHBwgEW4RVGyKWlsMJQzAOlZXTG9G0xOEpTPw7V+bPpn+7
	BAb1GqQ2ehIPe40v95UHEtgP5N16ttPmT5nQNc9IWRlcu1zex6uBrojuP4JnW2DTJi9IGrlLZeb
	OyDDIn+jFnr7CYLRWPFCyTCQTXGqmxRDcS
X-Google-Smtp-Source: AGHT+IEDUGdgd57hqnJhmZWzmyJSlXQ/w0VUAPyqIuTv14bUuodHWsKKgLnu9TTSlwd8jxOtmZrz2M5cZBf+28PzXn0=
X-Received: by 2002:a17:907:72c3:b0:ad1:e4e9:6b4f with SMTP id
 a640c23a62f3a-ad52d53c8f3mr1061862966b.36.1747636076129; Sun, 18 May 2025
 23:27:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250515073449.346774-2-chenlinxuan@uniontech.com>
 <CAOQ4uxja322ZuOaHm2rLU1mPsqHsuSbAe=0g5Rc_oh=DmBcn0Q@mail.gmail.com> <CAC1kPDOyYyvvkJr3yX=j4JE3q-jQwUN7tdkOG55HFjy6wE+DeA@mail.gmail.com>
In-Reply-To: <CAC1kPDOyYyvvkJr3yX=j4JE3q-jQwUN7tdkOG55HFjy6wE+DeA@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 19 May 2025 08:27:45 +0200
X-Gm-Features: AX0GCFsI_4JCzy0ZlWJFvPfBfY100MDbfqho3Xa_8QBQqEKLjBdq0aUYVA8ZMK0
Message-ID: <CAOQ4uxh9Zyorcox8UHH-nhZig_gmV=YDqX=mizSe6tftXwt_Dw@mail.gmail.com>
Subject: Re: [PATCH] selftests: Add functional test for the abort file in fusectl
To: Chen Linxuan <chenlinxuan@uniontech.com>
Cc: Shuah Khan <shuah@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>, zhanjun@uniontech.com, 
	niecheng1@uniontech.com, wentao@uniontech.com, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 19, 2025 at 7:58=E2=80=AFAM Chen Linxuan <chenlinxuan@uniontech=
.com> wrote:
>
> On Thu, May 15, 2025 at 6:27=E2=80=AFPM Amir Goldstein <amir73il@gmail.co=
m> wrote:
> >
> > On Thu, May 15, 2025 at 9:35=E2=80=AFAM Chen Linxuan <chenlinxuan@union=
tech.com> wrote:
> > >
> > > +       ret =3D read(test_fd, path_buf, sizeof(path_buf));
> > > +       ASSERT_LT(ret, 0);
> >
> > Nice!
> > I guess you could also verify errno =3D=3D ENOTCONN or whatever it is
> > in this case.
>
> I am currently facing two issues:
>
> 1. I am not sure about the exact functions of max_background and
> congestion_threshold. I have prepared a patch that adds documentation
> for these two fields, which can be found here:
> https://lore.kernel.org/all/20250514061703.483505-2-chenlinxuan@uniontech=
.com/

It may be a bit challenging to design a test that does deterministic
readahead, because there is usually no contract for readahead,
so not sure.

>
> 2. How should I test the "waiting" file? My current idea is to have my
> FUSE daemon stay in a state where it does not respond to requests, and
> then use some form of inter-process communication (maybe a Unix
> socket?) to make it resume working. I am not sure if there is a better
> approach.

This is a good approach that several selftests use.

Looking at the bigger picture, your work to improve documentation and
selftest coverage for fuse is very welcome! so I will add some wider
context comments.

One small nit: please rename the test subdir to filesystems/fuse rather
than filesystems/fusectl, so that more fuse selftests could be added later.

For the long run, I would consider a very minimal single threaded
fuse server implementation that does not rely on libfuse for fuse selftests=
,
because the selftest should not rely on the libfuse version installed on
the development system and also testing low level protocol issues
would require this anyway.
But this is not a requirement for this first test.

Thanks,
Amir.

